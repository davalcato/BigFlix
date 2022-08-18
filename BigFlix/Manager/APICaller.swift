//
//  APICaller.swift
//  BigFlix
//
//  Created by Daval Cato on 8/17/22.
//

import Foundation

struct Constants {
    static let API_KEY = "697d439ac993538da4e3e60b54e762cd"
    // new column
    static let baseURL = "https://api.themoviedb.org"
}

class APICaller {
    static let shared = APICaller()
    
    // fetching api caller
    func getTrendingMovies(completion: @escaping (String) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/all/day?api_keys\(Constants.API_KEY)") else {return }
        
        // networking code
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                // converting json
                let results = try JSONSerialization.jsonObject(
                    with: data,
                    options: .fragmentsAllowed)
                print(results)
                
            } catch {
                print(error.localizedDescription)
            }
        }
        // created the task
        task.resume()
    }
}












