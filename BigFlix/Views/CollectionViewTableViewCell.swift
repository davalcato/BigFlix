//
//  CollectionViewTableViewCell.swift
//  BigFlix
//
//  Created by Daval Cato on 8/7/22.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {

    static let identifier = "CollectionViewTableViewCell"
    
    // intialize private to hold an array
    private var titles: [Title] = [Title]()
    
    private let collectionView: UICollectionView = {
        // define layout
        let layout = UICollectionViewFlowLayout()
        // item size
        layout.itemSize = CGSize(width: 144, height: 200)
        
        
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // register tableview
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        
        
        return collectionView
    }()
    
    // intialize
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // color
        contentView.backgroundColor = .systemPink
        // add to content view
        contentView.addSubview(collectionView)
        
        // conform to protocol
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // frame
    override func layoutSubviews() {
        super.layoutSubviews()
        // collectioView the entire body of cell
        collectionView.frame = contentView.bounds
    }
    // feed the titles for each section
    public func configure(with titles: [Title]) {
        // reference the titles array for each section 
        self.titles = titles
        // reload the data from the collection on the main thread
        DispatchQueue.main.sync { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // instead of dequeueReusableCell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        // optional string
        guard let model = titles[indexPath.row].poster_path else {
            return UICollectionViewCell()
        }
        // have access to the configure or each title
        cell.configure(with: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
}
