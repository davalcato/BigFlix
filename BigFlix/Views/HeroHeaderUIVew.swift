//
//  HeroHeaderUIVew.swift
//  BigFlix
//
//  Created by Daval Cato on 8/13/22.
//

import UIKit

class HeroHeaderUIVew: UIView {
    
    // implement image view
    private let heroImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()

   // add frame
    override init(frame: CGRect) {
        super.init(frame: frame)
        // no constraints here
        addSubview(heroImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
