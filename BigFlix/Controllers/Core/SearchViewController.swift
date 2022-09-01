//
//  SearchViewController.swift
//  BigFlix
//
//  Created by Daval Cato on 8/3/22.
//

import UIKit

class SearchViewController: UIViewController {
    
    // define variable
    private var titles: [Title] = [Title]()
    
    // added a tableView for query search
    private let discoverTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    // search controller
    private let searchController: UISearchController = {
        // new controller that specifies results
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        // message to prompt the user
        controller.searchBar.placeholder = "Search for a Movie or a Tv Show"
        // translucent background with minimal
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = .systemBackground
        // add subview
        view.addSubview(discoverTable)
        // set delegate and datasource
        discoverTable.delegate = self
        discoverTable.dataSource = self
        
        // pass searchcontroller 
        navigationItem.searchController = searchController
        
        // fetch
        fetchDiscoverMovies()
    }
    
    // define function
    private func fetchDiscoverMovies() {
        // call the APICaller
        APICaller.shared.getDiscoverMovies { [weak self] result in
            switch result {
            case .success(let titles):
                // assign the titles
                self?.titles = titles
                // set on the main thread
                DispatchQueue.main.async {
                    // reference the table
                    self?.discoverTable.reloadData()
                }
                // handle the other case
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // set the layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // frame
        discoverTable.frame = view.bounds
    }
}
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return TitleTableViewCell()
        }
        let title = titles[indexPath.row]
        // if not ?? available pass unknown
        let model = TitleViewModel(titleName: title.original_name ?? title.original_title ?? "unknown name", posterURL: title.poster_path ?? "")
        cell.configure(with: model)
        // retrieve the data
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

