//
//  ImdbListModel.swift
//  ImdbListSample
//
//  Created by Muhammet Gokhan Yavuz on 14.12.2021.
//

import Foundation

struct Film : Codable {
    
    let title : String
    let year : String
    let imdbId : String
    let type : String
    let poster : String
    
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbId = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }
    
}

struct FilmList : Codable {
    let search : [Film]
    
    private enum CodingKeys : String, CodingKey {
        case search = "Search"
    }
}
