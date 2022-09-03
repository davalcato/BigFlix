//
//  HomeViewController.swift
//  BigFlix
//
//  Created by Daval Cato on 8/3/22.
//

import UIKit

// define new enum
enum Sections: Int {
    // four sections
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    // an array to hold text
    let sectionTitles: [String] = ["Trending Movies", "Trending Tv", "Popular", "Up Coming Movies", "Top Rated"]
    
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
        
        // Call APICaller for func getMovie
        APICaller.shared.getMovie(with: "Harry Potter") 
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
    
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
   
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
        // switch titles section cases
        switch indexPath.section {
            
            // handle the cases for each section
        case Sections.TrendingMovies.rawValue:
            // make the API call
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case .success(let titles):
                    // receive an array of titles
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.TrendingTv.rawValue:
            // make the API call
            APICaller.shared.getTrendingTvs { result in
                switch result {
                case .success(let titles):
                    // pass results
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Popular.rawValue:
            // make the API call
            APICaller.shared.getPopular { result in
                switch result {
                case .success(let titles):
                    // pass results
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Upcoming.rawValue:
            // make the API call
            APICaller.shared.getUpcomingMovies { result in
                switch result {
                case .success(let titles):
                    // pass results
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.TopRated.rawValue:
            // make the API call
            APICaller.shared.getTopRated { result in
                switch result {
                case .success(let titles):
                    // pass results
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error)
                }
            }
            // switch to be an exhaustive 
        default:
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
        
    // get the header for each section
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
    // modify changes
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(
            x: header.bounds.origin.x + 20,
            y: header.bounds.origin.y,
            width: 100,
            height: header.bounds.height)
        // change color of font
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
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
    





    
    

