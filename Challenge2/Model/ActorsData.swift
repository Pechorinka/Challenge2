//
//  FilmActorsData.swift
//  Challenge2
//
//  Created by Tatyana Sidoryuk on 29.08.2022.
//

//https://developers.themoviedb.org/3/movies/get-movie-credits
//https://developers.themoviedb.org/3/tv/get-tv-credits


import Foundation

struct ActorsData: Codable {
    var id: Int
    var cast: [Cast]
}

struct Cast: Codable {
    var id: Int
    var name: String
    var original_name: String
    var character: String
}
