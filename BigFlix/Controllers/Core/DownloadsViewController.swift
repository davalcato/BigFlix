//
//  DownloadsViewController.swift
//  BigFlix
//
//  Created by Daval Cato on 8/3/22.
//

import UIKit

class DownloadsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        // titles
        title = "Downloads"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    

}
