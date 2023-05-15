//
//  PostCell.swift
//  Deezer-ApternStudy
//
//  Created by Muhammed Enes Kılıçlı on 15.05.2023.
//

import UIKit

class PostCell: UICollectionViewCell {
    @IBOutlet weak var background: UIView!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var pReleaseDate: UILabel!
    
    @IBOutlet weak var pTitle: UILabel!
    
    
    override func awakeFromNib() {
        background.layer.cornerRadius = 12
        image.layer.cornerRadius = 12
        pTitle.adjustsFontSizeToFitWidth = true
        pTitle.sizeToFit()
        pReleaseDate.textColor = .systemPurple
    }

        
}


