//
//  FavoriteViewController.swift
//  SportsApp
//
//  Created by rahma zakaria on 3/29/21.
//

import UIKit
import Reachability

class FavoriteViewController: UIViewController {
    @IBOutlet weak var leaguesTabelView: UITableView!{
        didSet{
            leaguesTabelView.delegate = self
            leaguesTabelView.dataSource = self
        }
    }
    var leagues = [FavoriteLeague]()
    let reachability = try! Reachability()
    var isConected: Bool?
    
    override func viewDidLoad() {
        self.title = "Favorite"
        self.leaguesTabelView.backgroundColor = UIColor(named: "background")
        leaguesTabelView.separatorColor = .none
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        reachability.whenReachable = { reachability in
            self.isConected = true
        }
        reachability.whenUnreachable = { _ in
            self.isConected = false
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        let coreData = CoreDataModel()
        leagues = []
        leagues = coreData.gitAllData()
        leaguesTabelView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        reachability.stopNotifier()
    }
}

extension FavoriteViewController :UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = leaguesTabelView.dequeueReusableCell(withIdentifier: "LeaguesTableCellF", for: indexPath) as! LeaguesTableCell
        let youtubeLink = leagues[indexPath.section].youtubeUrl!
        if (youtubeLink.isEmpty){
            cell.youtubeButton.isHidden = true
        } else {
            cell.youtubeButton.isHidden = false
            cell.youtubeButton.tag = indexPath.section
        }
        
        let name = leagues[indexPath.section].name ?? "no name"
        let image = leagues[indexPath.section].image ?? " no"
        cell.setUpLeaguesTableCell(leagueName: name, imageName: image, youtubeLink: youtubeLink)
        
        cell.layer.borderWidth = 4
        cell.layer.borderColor = UIColor(named: "light")?.cgColor
        cell.backgroundColor = UIColor(named: "light")
        cell.layer.cornerRadius = 32
        cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner,.layerMaxXMinYCorner]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("in selected")
        if isConected! {
            let name = self.leagues[indexPath.section].name ?? ""
            let id = self.leagues[indexPath.section].id ?? ""
            let image = self.leagues[indexPath.section].image ?? ""
            let youtube = self.leagues[indexPath.section].youtubeUrl ?? ""
            let myLeague = FavoriteLeague(id: id, name: name, image: image, youtubeUrl:youtube)
            
            tableView.deselectRow(at: indexPath, animated: true)
            performSegue(withIdentifier: "ShowDetailes", sender: myLeague)
            //pushToTeamsView(myLeague: myLeague)
        }else{
            let alert = UIAlertController(title: "No Connection", message: "Pleas Connect Internet And Connect Agian", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailes" {
            if let detailesVC = segue.destination as? LeaguesDetialesViewController{
                let league = sender as? FavoriteLeague
                detailesVC.myLeague = league
            }
        }
    }
    
}

extension FavoriteViewController{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(tableView.frame.size.width * 0.3)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
}
