//
//  UpComingViewController.swift
//  BigFlix
//
//  Created by Daval Cato on 8/3/22.
//

import UIKit

class UpComingViewController: UIViewController {
    
    // assign to a local variable switch result
    private var titles: [Title] = [Title]()
    // added new table
    private let upcomingTable: UITableView = {
        
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        // add table to view
        view.addSubview(upcomingTable)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
        
        // call the function
        fetchUpcoming()
    }
    // add the tableview
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }
    // fetch upcoming data
    private func fetchUpcoming() {
        // called api and avoid memory leaks with weak
        APICaller.shared.getUpcomingMovies { [weak self] result in
            switch result {
                // retrieve titles
            case .success(let titles):
                // reference
                self?.titles = titles
                // put inside an async func for main thread
                DispatchQueue.main.async {
                    // reload the data
                    self?.upcomingTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension UpComingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeue cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            
            return UITableViewCell()
        }
        // define the title
        let title = titles[indexPath.row]
        // access the cell thru the titles array - and if ?? not their - then add the value ""
        cell.configure(with: TitleViewModel(titleName: (title.original_title ?? title.original_name) ?? "unknown title name", posterURL: title.poster_path ?? ""))
        // return cell
        return cell
    }
    // fixed the height of the row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    // implementing function to select
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
