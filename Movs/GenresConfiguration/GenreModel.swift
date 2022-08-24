//
//  GenreApi.swift
//  Movs
//
//  Created by Lorhany Moraes on 14/07/22.
//

import Foundation

struct GenresResponse: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}





