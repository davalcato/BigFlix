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
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = titles[indexPath.row].original_name ?? titles[indexPath.row].original_title ?? "unknown"
        return cell
    }
    
}
