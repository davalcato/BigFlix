//
//  HomeViewController.swift
//  BigFlix
//
//  Created by Daval Cato on 8/3/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let homeFeedTable: UITableView = {
        
        // Instantize the table here
        let table = UITableView()
        // registered cell to customize cell
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // added tableview to view
        view.addSubview(homeFeedTable)
        
        
    }
    

}
