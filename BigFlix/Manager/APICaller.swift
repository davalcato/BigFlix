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
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return }
        
        // networking code
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                // converting json
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                // Call the completion
                completion(.success(results.results))
                
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        // created the task
        task.resume()
    }
    func getTrendingTvs(completion: @escaping (Result<[Title], Error>) -> Void) {
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
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }
            // catch if there are any errors
            catch {
                // handle from homeviewController
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        // resume task
        task.resume()
    }
    // new func
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        // create url then added the api try out the TMDB website
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)") else {return }
        // new task with a request
        let task = URLSession.shared.dataTask(
            with: url) { data, _, error in
            // check that the error is equal to nil
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }
            // catch if there are any errors
            catch {
                // handle from homeviewController
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        // resume task
        task.resume()
    }
    // new func for getPopular
    func getPopular(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string:
                                "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        // data task
        let task = URLSession.shared.dataTask(
            with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        // resume task
        task.resume()
    }
    func getTopRated(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string:
                                "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        // data task
        let task = URLSession.shared.dataTask(
            with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        // resume task
        task.resume()
     }
    // add new func for discover
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string:
                                "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        // data task
        let task = URLSession.shared.dataTask(
            with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        // resume task
        task.resume()
    }
    // search function that takes a query of string
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        
        // format the query
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        
        // fetch a new url
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else { return
        }
        // data task
        let task = URLSession.shared.dataTask(
            with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                // serialize the request using JSONDecoder
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                // pass on completion the array of title
                completion(.success(results.results))
                
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        // resume task
        task.resume()
    }
    
}













