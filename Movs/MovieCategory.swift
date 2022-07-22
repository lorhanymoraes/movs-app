//
//  MovieCategory.swift
//  Movs
//
//  Created by Lorhany Moraes on 20/07/22.
//

import Foundation

enum MovieCategory: String {
    case popular    = "popular"
    case nowPlaying = "now_playing"
    case topRated   = "top_rated"
}


extension MovieCategory {
    var title: String {
        switch self {
        case .popular:
            return "Popular"
        case .nowPlaying:
            return "Now Playing"
        case .topRated:
            return "Top Rated"
        }
    }
}
