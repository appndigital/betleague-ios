//
//  TeamCell.swift
//  betleagues-ios
//
//  Created by Didier Nizard on 24/07/2023.
//

import UIKit
import SDWebImage

class TeamCell: UICollectionViewCell {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    var data: TeamModel! {
        didSet{
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainImage.clipsToBounds = true
    }
    
    func updateUI() {
        self.mainImage.sd_setImage(with: URL(string: self.data.strTeamBadge ?? ""), completed: nil)
        self.lblName.text = self.data.strTeam
    }
}
