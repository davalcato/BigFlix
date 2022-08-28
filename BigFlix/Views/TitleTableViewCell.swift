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
        // change the size of image
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))
        // pass the image
        button.setImage(image, for: .normal)
        // activate the autolayout
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
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
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // prevent each poster from over flowing in container
        imageView.clipsToBounds = true
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
            titlesPostUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titlesPostUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titlesPostUIImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        // complete adding the constraints
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: titlesPostUIImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ]
        // button constraint
        let playTitleButtonConstraints = [
            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            // fix the middle cell as well
            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        
        ]
        
        // activate the NSLayoutConstraint
        NSLayoutConstraint.activate(titlesPostUIImageViewConstraints)
        // activate the NSLayoutConstraint
        NSLayoutConstraint.activate(titleLabelConstraints)
        // activate the NSLayoutConstraint
        NSLayoutConstraint.activate(playTitleButtonConstraints)
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
