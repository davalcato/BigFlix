//
//  Movie.swift
//  BigFlix
//
//  Created by Daval Cato on 8/18/22.
//

import Foundation

// conform to the codable -
struct TrendingMoviesResponse: Codable {
    // create array of movie
    let results: [Movie]
    
}

struct Movie: Codable {
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

/*
 
 {
adult = 0;
"backdrop_path" = "/odJ4hx6g6vBt4lBWKFD1tI8WS4x.jpg";
"genre_ids" =             (
 28,
 18
);
id = 361743;
"media_type" = movie;
"original_language" = en;
"original_title" = "Top Gun: Maverick";
overview = "After more than thirty years of service as one of the Navy\U2019s top aviators, and dodging the advancement in rank that would ground him, Pete \U201cMaverick\U201d Mitchell finds himself training a detachment of TOP GUN graduates for a specialized mission the likes of which no living pilot has ever seen.";
popularity = "4227.805";
"poster_path" = "/62HCnUTziyWcpDaBO2i1DX17ljH.jpg";
"release_date" = "2022-05-24";
title = "Top Gun: Maverick";
video = 0;
"vote_average" = "8.331";
"vote_count" = 2144;
 
 
 */







