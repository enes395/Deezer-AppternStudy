//
//  HomeTableViewCell.swift
//  Deezer-ApternStudy
//
//  Created by Muhammed Enes Kılıçlı on 11.05.2023.
//

import UIKit
import Kingfisher
class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var photoView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoView.kf.indicatorType = .activity
        configurePhotoView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func configurePhotoView(){
        photoView.layer.cornerRadius = 20
        photoView.layer.shadowRadius = 20
    }
    
}
