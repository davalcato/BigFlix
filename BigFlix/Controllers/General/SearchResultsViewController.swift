//
//  SearchResultsViewController.swift
//  BigFlix
//
//  Created by Daval Cato on 8/31/22.
//


import UIKit

// new procotol with type AnyObject
protocol SearchResultsViewControllerDelegate: AnyObject {
    // new function with viewModel
    func SearchResultsViewControllerDidTapItem(_ viewModel: TitlePreviewViewModel)
    
}

class SearchResultsViewController: UIViewController {
    
    // an array made public to access from SearchViewController
    public var titles: [Title] = [Title]()
    
    // create the public for the TitlePreviewViewModel with same type of protocol
    public weak var delegate: SearchResultsViewControllerDelegate?
    
    // intialize
    public let searchResultsControllerView: UICollectionView = {
        
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
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // implement datasource function
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        // configure with the array
        let title = titles[indexPath.row]
        // access to poster path
        cell.configure(with: title.poster_path ?? "")
        return cell
    }
    
    // tap item in collectionView
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // the instance
        collectionView.deselectItem(at: indexPath, animated: true)
        // title here
        let title = titles[indexPath.row]
        let titleName = title.original_title ?? ""
        
        // grab video element
        APICaller.shared.getMovie(with: titleName) { [weak self] result in
            // switch result
            switch result {
                
            case .success(let videoElement):
                // inside of this
                self?.delegate?.SearchResultsViewControllerDidTapItem(TitlePreviewViewModel(title: title.original_title ?? "", youtubeView: videoElement, titleOverview: title.overview ?? ""))
               
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
