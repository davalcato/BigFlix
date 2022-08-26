//
//  TitleTableViewCell.swift
//  BigFlix
//
//  Created by Daval Cato on 8/26/22.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    static let identifier = "TitleTableViewCell"
    
    private let playTitleButton: UIButton = {
        // intialize
        let button = UIButton()
        // activate the autolayout
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // label to the hold title name
    private let titleLabel: UILabel = {
        let label = UILabel()
        // activate
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    
    // hold the poster for the image we retrieve
    private let titlesPostUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // add for the cell
        contentView.addSubview(titlesPostUIImageView)
        // add the label to the contentView
        contentView.addSubview(titleLabel)
        // add
        contentView.addSubview(playTitleButton)
        
        // make new function
        applyConstraints()
    }
    
    // create function
    private func applyConstraints() {
        // first constraint is poster
        let titlesPostUIImageViewConstraints = [
            // an array constraining the leading
            titlesPostUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlesPostUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            titlesPostUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            titlesPostUIImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        // complete adding the constraints
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: titlesPostUIImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ]
        // activate the NSLayoutConstraint
        NSLayoutConstraint.activate(titlesPostUIImageViewConstraints)
        // activate the NSLayoutConstraint
        NSLayoutConstraint.activate(titleLabelConstraints)
        
    }
    // create a public function and pass the viewmodel
    public func configure(with model: TitleViewModel) {
        
        // set the url
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
            return
        }
        // image view
        titlesPostUIImageView.sd_setImage(with: url, completed: nil)
        // set the title
        titleLabel.text = model.titleName
        
        
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
