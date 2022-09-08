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
        // change cancel button color
        navigationController?.navigationBar.tintColor = .white
        // fetch
        fetchDiscoverMovies()
        // update the search controller
        searchController.searchResultsUpdater = self
        
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
    // add new function to select poster item
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // reference table
        tableView.deselectRow(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else {
            return
        }
        //  call api
        APICaller.shared.getMovie(with: titleName) { [weak self] result in
            // switch result
            switch result {
                
            case .success(let videoElement):
                // main thread
                DispatchQueue.main.async {
                    // new instance to push the controller
                    let vc = TitlePreviewViewController()
                    // configure with the title
                    vc.configure(with: TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: title.overview ?? ""))
                    // push view here
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
// conform to the SearchResultsViewControllerDelegate
extension SearchViewController: UISearchResultsUpdating, SearchResultsViewControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        // get query from searchBar
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              // make sure its ok to search query and not empty
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              // count is greater then
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              // set the result controller
              let resultsController = searchController.searchResultsController as? SearchResultsViewController else {
                  
                  return
              }
        // delegate
        resultsController.delegate = self
        
        
        // call function
        APICaller.shared.search(with: query) { result in
            // main thread
            DispatchQueue.main.async {
                // switch results
                switch result {
                    // get results
                case.success(let titles):
                    resultsController.titles = titles
                    resultsController.searchResultsControllerView.reloadData()
                case.failure(let error):
                    print(error.localizedDescription)
                    
                }
            }
        }
    }
    // search results tap item
    func SearchResultsViewControllerDidTapItem(_ viewModel: TitlePreviewViewModel) {
        
        // main thread and mention that it's going to be a weak self in
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            // then configure
            vc.configure(with: viewModel)
            // pass in the vc
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

