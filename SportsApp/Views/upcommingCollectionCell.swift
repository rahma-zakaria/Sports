//
//  upcommingCollectionCell.swift
//  SportsApp
//
//  Created by rahma zakaria on 3/30/21.
//

import UIKit

class upcommingCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imageTeamA: UIImageView!
    @IBOutlet weak var imageTeamB: UIImageView!
    
    @IBOutlet weak var nameTeamA: UILabel!
    @IBOutlet weak var nameTeamB: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
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
    
}
