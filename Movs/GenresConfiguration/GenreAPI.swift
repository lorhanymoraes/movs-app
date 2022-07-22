//
//  GenreAPI.swift
//  Movs
//
//  Created by Lorhany Moraes on 14/07/22.
//

import Foundation
import Alamofire

enum GenreError {
    case url
    case invalidJSON
}


class GenreAPI {
    
    static private let basePath = "https://api.themoviedb.org/3/genre/movie/list?api_key=b621e030f5e5548ff84999cf7b668c13&language=en-US"
    
    class func loadGenre(onComplete: @escaping ([GenreJSON]?) -> Void, onError: @escaping (PError) -> Void) {
        
        let url = basePath
        
        AF.request(url).responseJSON { (response) in
            guard let data = response.data else {
                onError(.invalidUrl)
                return }
            do {
                let genreInfo = try JSONDecoder().decode([GenreJSON].self, from: data)
                onComplete(genreInfo)
                print(genreInfo)
            } catch {
                print(error.localizedDescription)
                onError(.decodeError)
            }
        
        }
    }
}


