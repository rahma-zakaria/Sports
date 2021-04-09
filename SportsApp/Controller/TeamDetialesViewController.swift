//
//  TeamDetialesViewController.swift
//  SportsApp
//
//  Created by rahma zakaria on 3/27/21.
//

import UIKit

class TeamDetialesViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var teamLogoImage: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    
    var team : [String: String?]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        teamLogoImage.layer.cornerRadius = teamLogoImage.frame.size.height/2
        teamLogoImage.layer.borderWidth = 2
        teamLogoImage.layer.borderColor = UIColor(named: "light")?.cgColor
        if let team = self.team {
            if let teamImgUrl = team["strTeamLogo"]{
                let img = NSURL(string: teamImgUrl ?? "")! as URL
                self.teamLogoImage.sd_setImage(with: img, completed: nil)
            }
            self.teamNameLabel.text = team["strTeam"] ?? ""
            self.descriptionText.text = team["strDescriptionEN"] ?? ""
        }
    }
    
    @IBAction func faceBookButton(_ sender: Any) {
        let socialLink = (self.team!["strFacebook"] ?? "")!
        pushToSocialView(link: socialLink)
    }
    @IBAction func instgramButton(_ sender: Any) {
        let socialLink = (self.team!["strInstagram"] ?? "")!
        pushToSocialView(link: socialLink)
    }
    @IBAction func twitterButton(_ sender: Any) {
        let socialLink = (self.team!["strTwitter"] ?? "")!
        pushToSocialView(link: socialLink)
    }
    func pushToSocialView(link: String){
        let SocialView = storyboard?.instantiateViewController(withIdentifier: "SocialViewController") as! SocialViewController
        SocialView.socialLink = link
        self.navigationController?.pushViewController(SocialView, animated: true)
    }
    
}
