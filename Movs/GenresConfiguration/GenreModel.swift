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
    
//    fileprivate static var cachedGenres: [Genre] = []
//    static func getGenres(movieApi: MovieAPI, completion: @escaping ([Genre]) -> Void) {
//        if cachedGenres.isEmpty {
//            MovieAPI.getGenres { (genres) in
//            cachedGenres = genres
//                completion(genres)
//            } onError: { (error) in
//                switch error {
//                case .noData:
//                    print("\(ModelError.noData)")
//                default:
//                    print(error)
//                }
//            }
//
//        } else {
//            completion(cachedGenres)
//            
//        }
//    
//}
//}
//
//extension Genre {
//    static func ==(lhs: Genre, rhs: Genre) -> Bool {
//        return lhs.id == rhs.id
//    }
//}




