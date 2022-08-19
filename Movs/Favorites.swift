//
//  Favorites.swift
//  Movs
//
//  Created by Lorhany Moraes on 22/07/22.
//

import Foundation

struct FavoritedMovie: Codable, Hashable {
    let id: Int?
    let title: String?
    let posterPath: String?
    
    var posterUrlString: String? {
        if let posterPath = posterPath {
            return "https://image.tmdb.org/t/p/w500\(posterPath)"
        }
        return nil
    }
}

