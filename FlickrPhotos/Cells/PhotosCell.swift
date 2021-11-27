//
//  PhotosCell.swift
//  FlickrPhotos
//
//  Created by Rukhsar Ali on 26/11/2021.
//

import UIKit

class PhotosCell: UITableViewCell {

    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
        
        // Initialization code
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 0, width:imageCell.bounds.width, height: 250)
        let blackColor = UIColor.black.withAlphaComponent(0.5)
        layer.colors = [UIColor.clear.cgColor  , blackColor.cgColor ]
        imageCell.layer.addSublayer(layer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
