//
//  TvShowData.swift
//  Challenge2
//
//  Created by Tatyana Sidoryuk on 29.08.2022.
//

import Foundation

struct TvShowData: Codable {
    var id: Int
    var name: String
    var poster_path: String?
    var poster: String
    var release_date: String
}
