//
//  CollectionViewTableViewCell.swift
//  BigFlix
//
//  Created by Daval Cato on 8/7/22.
//

import UIKit

// new protocal
protocol CollectionViewTableViewCellDelegate: AnyObject {
    // takes an object type and viewModel
    func CollectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel)
    
}

class CollectionViewTableViewCell: UITableViewCell {

    static let identifier = "CollectionViewTableViewCell"
    
    // optional
    weak var delegate: CollectionViewTableViewCellDelegate?
    
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
    // core data to download titles
    private func downloadTitleAt(indexPath: IndexPath) {
       // download title
        DataPersistenceManager.shared.downloadTitleWith(model: titles[indexPath.row]) { result in
            // switching on result
            switch result {
            case.success():
                print("downloaded to database")
            case.failure(let error):
                print(error.localizedDescription)
            }
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
    // select item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        // grab the title name
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else {
            // return if its empty
            return
        }
        
        APICaller.shared.getMovie(with: titleName + "trailer") { [weak self] result in
            switch result {
            case .success(let videoElement):
                
                let title = self?.titles[indexPath.row]
                // pass in the overView
                guard let titleOverview = title?.overview else {
                    return
                }
                // pass self
                guard let strongSelf = self else {
                    return
                }
                
                let viewModel = TitlePreviewViewModel(
                    title: titleName,
                    youtubeView: videoElement,
                    titleOverview: titleOverview)
                self?.delegate?.CollectionViewTableViewCellDidTapCell(strongSelf, viewModel: viewModel)
                // if it goes wrong
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    // implement new function for downloading the title
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        // define
        let config = UIContextMenuConfiguration(
            identifier: nil,
            // download action
            previewProvider: nil) { _ in
            let downloadAction = UIAction(
                title: "Download",
                image: nil,
                identifier: nil,
                discoverabilityTitle: nil,
                state: .off) { [weak self] _ in
                self?.downloadTitleAt(indexPath: indexPath)
            }
            return UIMenu(
                title: "",
                image: nil,
                identifier: nil,
                options: .displayInline,
                children: [downloadAction])
        }
        return config
    }
}
