//
//  LeaguesTableCell.swift
//  SportsApp
//
//  Created by rahma zakaria on 3/26/21.
//

import UIKit

class LeaguesTableCell: UITableViewCell {
    
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var youtubeButton: UIButton!
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var leagueIView: UIView!
    
    var youtubeLink: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func youtubeButton(_ sender: UIButton) {
        let currentView: UIViewController = self.window!.rootViewController!
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let youtubeView = storyboard.instantiateViewController(withIdentifier: "YoutubeViewController") as! YoutubeViewController
        youtubeView.youtubeLink = self.youtubeLink
        let navController = UINavigationController(rootViewController: youtubeView)
        currentView.present(navController, animated:true, completion: nil)
    }
    
    func setUpLeaguesTableCell(leagueName: String, imageName: String, youtubeLink: String) {
        leagueIView!.layer.borderWidth = 1
        leagueIView!.layer.borderColor = UIColor(named: "border")?.cgColor
        leagueIView!.layer.masksToBounds = false
        leagueIView!.layer.cornerRadius = leagueIView.frame.size.height/2
        leagueIView!.clipsToBounds = true
        
        leagueNameLabel.text = leagueName
       // leagueNameLabel.textColor = UIColor(named: "light")
        leagueImage.sd_setImage(with: URL(string: imageName), placeholderImage: UIImage(named: "no"))
        self.youtubeLink = youtubeLink
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
