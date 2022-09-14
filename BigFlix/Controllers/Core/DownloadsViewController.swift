//
//  DownloadsViewController.swift
//  BigFlix
//
//  Created by Daval Cato on 8/3/22.
//

import UIKit

class DownloadsViewController: UIViewController {
    
    // assign to a local variable switch result
    private var titles: [TitleItem] = [TitleItem]()
    
    // added new table
    private let downloadedTable: UITableView = {
        
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        // titles
        title = "Downloads"
        // added tableview for the download
        view.addSubview(downloadedTable)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        // add table to view
        view.addSubview(downloadedTable)
        downloadedTable.delegate = self
        downloadedTable.dataSource = self
        // call
        fetchLocalStorageForDownload()
    }
    
    // new function
    private func fetchLocalStorageForDownload() {
        
        DataPersistenceManager.shared.fetchingTitlesFromDatabase { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                // dispatch download
                DispatchQueue.main.async {
                    // reload tableview
                    self?.downloadedTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    // lay down downloads
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadedTable.frame = view.bounds
    }
}

extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource {
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
    // delete something from a table
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
          // attempting to delete an item
        case .delete:
            // delete from database itself
            DataPersistenceManager.shared.deleteTitleWith(
                model: titles[indexPath.row]) { [weak self] result in
                // switch on the result
                switch result {
                case .success():
                    print("Delete from the database")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            // remove from titles array
            self?.titles.remove(at: indexPath.row)
                tableView.deleteRows(
                    at: [indexPath], with: .fade)
            }
            // another case
        default:
            break;
        }
    }
}
