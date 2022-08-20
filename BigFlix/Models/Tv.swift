//
//  Tv.swift
//  BigFlix
//
//  Created by Daval Cato on 8/19/22.
//

import Foundation

// conform to the codable -
struct TrendingTvResponse: Codable {
    // create array of movie
    let results: [Tv]
    
}
struct Tv: Codable {
    // add the attributes
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}










