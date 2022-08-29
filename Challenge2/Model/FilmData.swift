//
//  FilmData.swift
//  Challenge2
//
//  Created by Tatyana Sidoryuk on 28.08.2022.
//

import Foundation

struct FilmData: Codable {
    var id: Int
    var overview: String
    var title: String
    var poster_path: String?
}
