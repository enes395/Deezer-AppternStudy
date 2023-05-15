//
//  ArtistTableViewCell.swift
//  Deezer-ApternStudy
//
//  Created by Muhammed Enes Kılıçlı on 13.05.2023.
//

import UIKit

class ArtistTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configurePhotoView()
        photoView.kf.indicatorType = .activity
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func configurePhotoView() {
        photoView.layer.cornerRadius = photoView.frame.height/2
        photoView.clipsToBounds = true
        
        
    }

    
}
