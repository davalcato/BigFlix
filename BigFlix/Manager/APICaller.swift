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
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return }
        
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
    func getTrendingTvs(completion: @escaping (Result<[String], Error>) -> Void) {
        // intialize the URL
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return }
        // new task with a request
        let task = URLSession.shared.dataTask(
            with: url) { data, _, error in
            // check that the error is equal to nil
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONSerialization.jsonObject(
                    with: data,
                    options: .fragmentsAllowed)
                print(results)
            }
            // catch if there are any errors
            catch {
                print(error.localizedDescription)
            }
        }
        
        // resume task
        task.resume()
        
    }
    
}












