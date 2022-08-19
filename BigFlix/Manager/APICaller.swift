//
//  APICaller.swift
//  BigFlix
//
//  Created by Daval Cato on 8/17/22.
//

import Foundation

struct Constants {
    static let API_KEY = "e3b0726e5bf9b6cb3662f028a20dfbf0"
    // new column
    static let baseURL = "https://api.themoviedb.org"
}

// return string
enum APIError: Error {
    case failedTogetData
    
}

class APICaller {
    static let shared = APICaller()
    
    // fetching api caller
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/all/day?api_key=\(Constants.API_KEY)") else {return }
        
        // networking code
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                // converting json
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                // Call the completion
                completion(.success(results.results))
                
            } catch {
                completion(.failure(error))
            }
        }
        // created the task
        task.resume()
    }
}












