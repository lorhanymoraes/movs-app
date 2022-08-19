//
//  MovieAPI.swift
//  Pods
//
//  Created by Lorhany Moraes on 07/07/22.
//


import Foundation
import UIKit

struct APIMovies: Codable {
    var page: Int?
    var results: [MoviesResult]?
    var totalResults: Int
    var totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}


struct MoviesResult: Codable {
    //    static func == (lhs: MoviesResult, rhs: MoviesResult) -> Bool {
    //        lhs.id == rhs.id
    //    }
    //    func hash(into hasher: inout Hasher) {
    //        hasher.combine(id)
    //    }
    
    let posterPath: String?
    let adult: Bool?
    let overview: String?
    let releaseDate: String?
    var genreIds: [Int]?
    let genres: [MovieGenre]?
    var id: Int?
    let originalTitle: String?
    let originalLanguage: String?
    let title: String?
    let backdropPath: String?
    let popularity: Float?
    let voteCount: Int?
    let video: Bool?
    let voteAvarage: Double?
    
    
    //    var genreText: String {
    //        genres?.first?.name ?? "n/a"
    //    }
    
    
    var posterUrlString: String? {
        if let posterPath = posterPath {
            return "https://image.tmdb.org/t/p/w300\(posterPath)"
        }
        return nil
    }
    
    var backUrlString: String? {
        if let backdropPath = backdropPath {
            return "https://image.tmdb.org/t/p/w500\(backdropPath)"
        }
        return nil
    }
    
    var moviesId: String? {
        if let id = id {
            return "https://api.themoviedb.org/3/movie/\(id)?api_key=b621e030f5e5548ff84999cf7b668c13&language=en-US"
        }
        return nil
    }
    
    var popularityString: String? {
        if let popularity = Int?(Int(popularity ?? 0)) {
            return String(popularity)
        }
        return nil
    }
    
    var formattedReleaseDate: Date? {
        if let releaseDate = releaseDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-DD"
            return dateFormatter.date(from: releaseDate)
        }
        return nil
    }
    
    var releaseYear: String? {
        if let date = formattedReleaseDate {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_us")
            dateFormatter.dateFormat = "MMMM yyyy"
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    enum CodingKeys: String, CodingKey {
        
        case posterPath = "poster_path"
        case adult
        case overview
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case genres
        case id
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case voteAvarage = "vote_avarage"
        
        
    }
}

struct MovieGenre: Codable {
    let id: Int
    let name: String
    
    //    enum CodinKeys: String, CodingKey {
    //        case Id = "id"
    //        case name
    //    }
    //    init(from decoder: Decoder) throws {
    //        let values = try decoder.container(keyedBy: CodingKeys.self)
    //        Id = try values.decodeIfPresent(Int.self, forKey: .Id)
    //        name = try values.decodeIfPresent(String.self, forKey: .name)
    //    }
    
}


//extension MovieGenre: Equatable {
//    public static func == (lhs: MovieGenre, rhs: MovieGenre) -> Bool {
//        return lhs.id == rhs.id &&
//            lhs.name == rhs.name
//    }
//}



