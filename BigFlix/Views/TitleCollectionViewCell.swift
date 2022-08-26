//
//  TitleCollectionViewCell.swift
//  BigFlix
//
//  Created by Daval Cato on 8/21/22.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TitleCollectionViewCell"
    // image view to pass the poster thru
    private let posterImageView: UIImageView = {
        
        let imageView = UIImageView()
        // fill the whole cell
        imageView.contentMode = .scaleAspectFill
        return imageView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // add contentView
        contentView.addSubview(posterImageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // laying the frame of the view
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    // add third party library to retrieve poster image
    public func configure(with model: String) {
        // hold the url for the poster were looking for 
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else {
            return
        }
        // use API to search poster image
        posterImageView.sd_setImage(with: url, completed: nil)
    }
    
}
