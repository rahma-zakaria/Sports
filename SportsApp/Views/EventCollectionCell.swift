//
//  EventCollectionCell.swift
//  SportsApp
//
//  Created by rahma zakaria on 3/28/21.
//

import UIKit

class EventCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imageTeamA: UIImageView!
    @IBOutlet weak var imageTeamB: UIImageView!
    
    @IBOutlet weak var nameTeamA: UILabel!
    @IBOutlet weak var nameTeamB: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    @IBOutlet weak var teamAResView: UIView!
    @IBOutlet weak var teamBResView: UIView!
    @IBOutlet weak var labelARes: UILabel!
    @IBOutlet weak var labelBRes: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
    }
    
    func displayImgs(teamAURL: String?, teamBURL: String?) {
        if(teamAURL != nil){
            self.imageTeamA.sd_setImage(with: URL(string: teamAURL!), placeholderImage: UIImage(named: "no"))
        }else{
            self.imageTeamA.image = UIImage(named: "no")
        }
        
        if(teamBURL != nil){
            
            self.imageTeamB.sd_setImage(with: URL(string: teamBURL!), placeholderImage: UIImage(named: "no"))
        }else{
            self.imageTeamB.image = UIImage(named: "no")
        }
        self.imageTeamB.layer.cornerRadius = self.imageTeamB.frame.size.width/3
        self.imageTeamB.layer.borderWidth = 2
        self.imageTeamB.layer.borderColor = UIColor(named: "background")?.cgColor
        self.imageTeamA.layer.cornerRadius = self.imageTeamA.frame.size.width/3
        self.imageTeamA.layer.borderWidth = 2
        self.imageTeamA.layer.borderColor = UIColor(named: "background")?.cgColor
    }
    
    func displayNames(teamA: String, teamB: String) {
        self.nameTeamA.text = teamA
        self.nameTeamB.text = teamB
    }
    
    func displayDateTime(date: String?, time: String?) {
        if(date != nil && date!.count > 1){
            self.labelDate.text = date!
        }else{
            self.labelDate.text = "no Date"
        }
        
        if(time != nil && time!.count > 1){
            self.labelTime.text = time!
        }else{
            self.labelTime.text = "No time"
        }
    }
    
    func displayResults(teamARes: String?, teamBRes: String?) {
        self.teamAResView.layer.cornerRadius = self.teamAResView.frame.size.width/2
        self.teamBResView.layer.cornerRadius = self.teamBResView.frame.size.width/2
        self.teamAResView.layer.borderWidth = 1
        self.teamAResView.layer.borderColor = UIColor(named: "dark")?.cgColor
        self.teamBResView.layer.borderWidth = 1
        self.teamBResView.layer.borderColor = UIColor(named: "dark")?.cgColor
        
        self.teamAResView.isHidden = false
        self.teamBResView.isHidden = false
        
        if(teamARes != nil){
            self.labelARes.text = teamARes
        }else{
            self.labelARes.text = "N"
        }
        
        if(teamBRes != nil){
            self.labelBRes.text = teamBRes
        }else{
            self.labelBRes.text = "N"
        }
    }
    
}
