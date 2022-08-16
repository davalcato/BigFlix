//
//  HeroHeaderUIVew.swift
//  BigFlix
//
//  Created by Daval Cato on 8/13/22.
//

import UIKit

class HeroHeaderUIVew: UIView {
    
    // add download button
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        // constraints for button
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        
        return button
    }()
    // add playButton
    private let playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        // constraints for button
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    // implement image view
    private let heroImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        // frame for gradient layer
        gradientLayer.frame = bounds
        // add sublayer
        layer.addSublayer(gradientLayer)
    }

   // add frame
    override init(frame: CGRect) {
        super.init(frame: frame)
        // no constraints here
        addSubview(heroImageView)
        // add gradient
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
        // add another function
        applyConstraints()
    }
    
    private func applyConstraints() {
        
        let playButtonConstraints = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 79),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let downloadButtonConstraints = [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -79),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        // activate constraints
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
