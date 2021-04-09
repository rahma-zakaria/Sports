import UIKit

class LeaguesDetialesViewController: UIViewController {
    
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    @IBOutlet weak var teamsCV: UICollectionView!
    @IBOutlet weak var resultsCollection: UICollectionView!
    @IBOutlet weak var upCommingCollection: UICollectionView!
    
    var myLeague: FavoriteLeague?
    
    var teams : [[String: String?]]?
    var events = [Events]()
    let teamsUrl = "https://www.thesportsdb.com/api/v1/json/1/search_all_teams.php?l="
    let eventsUrl = "https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id="
    
    let coreData = CoreDataModel()
    let indicator = Indicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: "background")
        if coreData.isLeagueInFavorate(ID: (myLeague?.id)!) {
            favoriteButton.image = UIImage(systemName: "heart.fill")
        }else{
            favoriteButton.image = UIImage(systemName: "heart")
        }
        favoriteButton!.tintColor = .red
        self.navigationItem.rightBarButtonItem = favoriteButton
        self.indicator.startAnimating(view: view)
        setupCollectionView()
        requestEvents()
        requestTeams()
    }
    override func viewWillAppear(_ animated: Bool) {
        /*
         self.indicator.startAnimating(view: view)
         setupCollectionView()
         requestEvents()
         requestTeams()
 */
    }
    
    @IBAction func favoriteAction(_ sender: UIBarButtonItem) {
        if coreData.isLeagueInFavorate(ID: (myLeague?.id)!) {
            favoriteButton.image = UIImage(systemName: "heart")
            coreData.deleteLeague(leagueID: (myLeague?.id)!)
        }else{
            favoriteButton.image = UIImage(systemName: "heart.fill")
            coreData.addLeague(league: myLeague!)
        }
    }
    
    func requestTeams(){
        DispatchQueue.global(qos: .background).async {
            if let leagueName = self.myLeague?.name{
                let url = self.teamsUrl + leagueName.replacingOccurrences(of: " ", with: "_")
                ApiModal.instance.getData(url: url) { (myLeagueTeams: TeamsData?, error) in
                    if let myError = error{
                        print(myError)
                    }else{
                        self.teams = myLeagueTeams?.teams
                    }
                    DispatchQueue.main.async {
                        self.teamsCV.reloadData()
                        self.indicator.stopAnimating()
                        if (self.teams == nil) {
                            let image = UIImage(named: "notFound")
                            let imageView = UIImageView(image: image!)
                            imageView.frame = self.view.frame
                            self.view.addSubview(imageView)
                        }
                    }
                }
            }
        }
    }
    func requestEvents(){
        DispatchQueue.global(qos: .background).async {
            if let leagueId = self.myLeague?.id{
                let url = self.eventsUrl + leagueId
                ApiModal.instance.getData(url: url, completion:{(myEvents: EventsModel?,error) in
                    if let myError = error{
                        print(myError)
                    }else{
                        guard let events = myEvents else {return}
                        guard let myEvent = events.events  else { return }
                        self.events = myEvent
                        
                    }
                    DispatchQueue.main.async {
                        self.resultsCollection.reloadData()
                        self.upCommingCollection.reloadData()
                        self.indicator.stopAnimating()
                        if (self.events.count == 0) {
                            let image = UIImage(named: "notFound")
                            let imageView = UIImageView(image: image!)
                            imageView.frame = self.view.frame
                            self.view.addSubview(imageView)
                        }
                    }
                })
            }
            
        }
        
    }
}

extension LeaguesDetialesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func setupCollectionView(){
        teamsCV.delegate = self
        teamsCV.dataSource = self
        resultsCollection.delegate = self
        resultsCollection.dataSource = self
        resultsCollection.register(UINib(nibName: "EventCollectionCell", bundle: nil), forCellWithReuseIdentifier: "EventCollectionCell")
        upCommingCollection.delegate = self
        upCommingCollection.dataSource = self
        upCommingCollection.register(UINib(nibName: "upcommingCollectionCell", bundle: nil), forCellWithReuseIdentifier: "upcommingCollectionCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return events.count
        case 1:
            return events.count
        default:
            if let teams = self.teams{
                return teams.count
            }else{
                return 0
            }
        }
        
    }
    
    func getTeamLogo(id: String) ->String{
        let num = self.teams?.count ?? 0
        for index in 0..<num{
            let team = self.teams![index]
            if(team["idTeam"] == id){
                return team["strTeamLogo"]! ?? ""
            }
        }
        return ""
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0 :
            let eventCell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcommingCollectionCell", for: indexPath) as! upcommingCollectionCell
            let event = events[indexPath.row]
            eventCell.displayImgs(teamAURL: self.getTeamLogo(id: event.idHomeTeam ?? ""), teamBURL: self.getTeamLogo(id: event.idAwayTeam ?? ""))
            eventCell.displayNames(teamA: event.strHomeTeam ?? "", teamB: event.strAwayTeam ?? "")
            eventCell.displayDateTime(date: event.dateEvent, time: event.strTime)
            eventCell.layer.borderWidth = 2
            eventCell.layer.borderColor = UIColor(named: "light")?.cgColor
            eventCell.layer.cornerRadius = 12
            return eventCell
        case 1:
            let eventCell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionCell", for: indexPath) as! EventCollectionCell
            let event = events[indexPath.row]
            eventCell.displayImgs(teamAURL: self.getTeamLogo(id: event.idHomeTeam ?? ""), teamBURL: self.getTeamLogo(id: event.idAwayTeam ?? ""))
            eventCell.displayNames(teamA: event.strHomeTeam ?? "", teamB: event.strAwayTeam ?? "")
            eventCell.displayResults(teamARes: event.intHomeScore, teamBRes: event.intAwayScore)
            eventCell.displayDateTime(date: event.dateEvent, time: event.strTime)
            
            return eventCell
        default:
            let teamCell: teamCell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! teamCell
            let team = self.teams![indexPath.row]
            teamCell.updateCell(teamName: team["strTeam"]! ?? "", teamImage: team["strTeamLogo"]! ?? "")
            teamCell.layer.borderWidth = 4
            teamCell.layer.borderColor = UIColor(named: "light")?.cgColor
            teamCell.layer.cornerRadius = 10
            return teamCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 0:
            print("first")
        case 1:
            print("scond")
        default:
            let team = self.teams![indexPath.row]
            pushToTeamDetailsView(team: team)
        }
    }
    
    func pushToTeamDetailsView(team: [String: String?]){
        let teamDetailes = storyboard?.instantiateViewController(withIdentifier: "TeamDetialesViewController") as! TeamDetialesViewController
        teamDetailes.team = team
        self.navigationController?.pushViewController(teamDetailes, animated: true)
    }
    
}
extension LeaguesDetialesViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 0:
            return CGSize(width: collectionView.frame.size.height * 1.2, height: collectionView.frame.size.height - 24)
        case 1:
            return CGSize(width: ((self.view.frame.size.width/2) - 16), height: (self.view.frame.size.width/3))
            
        default:
            return CGSize(width: collectionView.frame.size.width * 0.3, height: collectionView.frame.size.height - 24)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView.tag {
        case 3:
            return 24
        default:
            return 8
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
    
}

