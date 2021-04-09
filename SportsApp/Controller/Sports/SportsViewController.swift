//
//  SportsViewController.swift
//  SportsApp
//
//  Created by rahma zakaria on 3/24/21.
//

import UIKit
import Reachability

class SportsViewController: UIViewController {
    let reachability = try! Reachability()
    
    @IBOutlet weak var sportsCollection: UICollectionView!{
        didSet{
            sportsCollection.delegate = self
            sportsCollection.dataSource = self
        }
    }
    
    let sportsUrl = "https://www.thesportsdb.com/api/v1/json/1/all_sports.php"
    var sports = [Sports]()
    let indicator = Indicator()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sports"
        self.sportsCollection.backgroundColor = UIColor(named: "background")
        self.indicator.startAnimating(view: self.view)
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.global(qos: .background).async {
            ApiModal.instance.getData(url: self.sportsUrl, completion:{(mySports: SportsModel?,error) in
                if let myError = error{
                    print(myError)
                }else{
                    guard let sports = mySports else {return}
                    guard let mySport = sports.sports  else { return }
                    self.sports = mySport
                    DispatchQueue.main.async {
                        self.sportsCollection.reloadData()
                        self.indicator.stopAnimating()
                    }
                }
            })
        }
        reachability.whenReachable = { reachability in
            self.tabBarController?.selectedIndex = 0
        }
        reachability.whenUnreachable = { _ in
            self.tabBarController?.selectedIndex = 1
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        reachability.stopNotifier()
    }
}

extension SportsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportsCollectionCell", for: indexPath) as! SportsCollectionCell
        let name = sports[indexPath.row].strSport!
        let image = sports[indexPath.row].strSportThumb!
        cell.setUpSportsCollectionCell(sportName: name, imageName: image)
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = cell.frame
        rectShape.position = cell.center
        rectShape.path = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.bottomRight, .topLeft], cornerRadii: CGSize(width: 20, height: 20)).cgPath
        cell.layer.mask = rectShape
        cell.layer.borderWidth = 4
        cell.layer.borderColor = UIColor(named: "light")?.cgColor
        cell.layer.cornerRadius = cell.frame.width/4
        cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let leaguesView = storyboard?.instantiateViewController(withIdentifier: "LeaguesViewController") as! LeaguesViewController
        leaguesView.sportName = sports[indexPath.row].strSport!
        
        self.navigationController?.pushViewController(leaguesView, animated: true)
    }
}
extension SportsViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width * 0.47, height: collectionView.frame.size.width * 0.34)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 8)
    }
}


