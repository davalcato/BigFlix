//
//  SearchResultsViewController.swift
//  BigFlix
//
//  Created by Daval Cato on 8/31/22.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    // an array
    private var titles: [Title] = [Title]()
    
    // intialize
    private let searchResultsControllerView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        // for multiply screens with UIScreen divide / by 3 and subtrack 10
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // register new cell and use title
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // pass the collectionview
        view.backgroundColor = .systemBackground
        // add subview
        view.addSubview(searchResultsControllerView)
        
        searchResultsControllerView.delegate = self
        searchResultsControllerView.dataSource = self

    }
    // lay out the functions
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        searchResultsControllerView.frame = view.bounds
    }
    
}
extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // implement datasource function
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        // specify the color of background
        cell.backgroundColor = .blue
        return cell
    }
}
