//
//  YoutubeSearchResponse.swift
//  BigFlix
//
//  Created by Daval Cato on 9/3/22.
// 


import Foundation

// conforming to the Protocal
struct YoutubeSearchResponse: Codable {
    // an array of items
    let items: [VideoElement]
    
}
// name the items
struct VideoElement: Codable {
    // name id object
    let id: IdVideoElement
    
}
// create id
struct IdVideoElement: Codable {
    // two fields
    let kind: String
    let videoId: String
    
}






