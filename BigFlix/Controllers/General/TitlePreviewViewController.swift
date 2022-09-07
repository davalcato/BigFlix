//
//  TitlePreviewViewController.swift
//  BigFlix
//
//  Created by Daval Cato on 9/3/22.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {
    
    // define new label title
    private let titleLabel: UILabel = {
        
        let label = UILabel()
        // enable layout
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        // dummy text
        label.text = "Harry Potter"
        return label
    }()
    
    // another view
    private let overviewLabel: UILabel = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        // multiple lines
        label.numberOfLines = 0
        label.text = "This is the best movie"
        return label
    }()
    
    // button
    private let downloadButton: UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        // set background
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        
        return button
        
    }()
    
    // intialize new view from the trailer
    private let webView: WKWebView = {
        let webview = WKWebView()
        webview.translatesAutoresizingMaskIntoConstraints = false
        return webview
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // background color of view
        view.backgroundColor = .systemBackground

        // add views to controllers
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)
        
        // configure restraints
        configureConstraints()
    }
    
    func configureConstraints() {
        // set the webviews array
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ]
        // constraint title
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ]
        
        // title constraints for overview
        let overviewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            // add some margin to the left
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            // this corrects the text on the video back screen
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
            
        ]
        // button
        let downloadButtonConstraints = [
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // add top margin between button
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25),
            downloadButton.widthAnchor.constraint(equalToConstant: 140),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    // configure
    func configure(with model: TitlePreviewViewModel) {
        // set the label
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        
        // create new URL
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {
            return
        }
        // load inside the webview
        webView.load(URLRequest(url: url))
    }
}
