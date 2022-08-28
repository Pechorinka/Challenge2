//
//  FilmData.swift
//  Challenge2
//
//  Created by Tatyana Sidoryuk on 28.08.2022.
//

import Foundation

struct FilmData: Codable {
    var id: Int
    var description: String
    var title: String
    var image_path: String?
}
