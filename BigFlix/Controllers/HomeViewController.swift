//
//  HomeViewController.swift
//  BigFlix
//
//  Created by Daval Cato on 8/3/22.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // an array to hold text
    let sectionTitles: [String] = ["Trending Movies", "Trending Tv", "Top Rated", "Up Coming Movies", "Popular"]
    
    
    private let homeFeedTable: UITableView = {
        // Instantize the table here
        let table = UITableView(frame: .zero, style: .grouped)
        // registered customize cell
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // added tableview to view
        view.addSubview(homeFeedTable)
        
        // add data
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavBar()
        
        
        // inialize headerView
        let headerView = HeroHeaderUIVew(frame: CGRect(
            x: 0,
            y: 0,
            width: view.bounds.width,
            height: 370))
        
        // tableview header
        homeFeedTable.tableHeaderView = headerView
        
    }
    
    private func configureNavBar() {
        // grab the image
        var image = UIImage(named: "netflixLogo")
        // modify the image alwaysOriginal force image as is
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: image,
            style: .done,
            target: self,
            action: nil)
        
        // an array of items
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                image: UIImage(systemName: "person"),
                style: .done,
                target: self,
                action: nil),
            
            UIBarButtonItem(
                image: UIImage(systemName: "play.rectangle"),
                style: .done,
                target: self,
                action: nil)
        ]
        // image icon color here
        navigationController?.navigationBar.tintColor = .white
        
        
    }
    
    
    // added a frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    // algorithm that cause the NavBar to disaapear
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 1, y: min(0, -offset))
    }
    // titles in sections
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    
}





    
    

