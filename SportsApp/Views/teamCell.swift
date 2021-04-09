import UIKit

class teamCell: UICollectionViewCell {
    
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(teamName: String, teamImage: String){
        let img = NSURL(string: teamImage)! as URL
        self.teamImage.sd_setImage(with: img, completed: nil)
        self.teamName.text = teamName
    }
    
}
