//
//  TitleCollectionViewCell.swift
//  BigFlix
//
//  Created by Daval Cato on 8/21/22.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    //
    static let identifier = "TitleCollectionViewCell"
    
    private let posterImageView: UIImageView = {
        
        let imageView = UIImageView()
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
    // add third party library to update the poster
    public func configure(with model: String) {
        // set image with url then pass model
        guard let url = URL(string: model) else {return}
        // hold the url for the poster
        posterImageView.sd_setImage(with: url, completed: nil)
        
    }
    
}
