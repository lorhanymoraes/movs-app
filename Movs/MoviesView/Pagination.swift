//
//  Pagination.swift
//  Movs
//
//  Created by Lorhany Moraes on 23/07/22.
////
//
//import Foundation
//
//class Pagination {
//    var moviesPag: APIMovies?
//    
//    func fetchData(pagination: Bool = false, completion: @escaping (Result<APIMovies, Error>) -> Void) {
//        DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: {
//            let firstPage = self.moviesPag?.page
//            completion(.success(pagination ? firstPage : (firstPage ?? 1) + 1))
//        }
//    
//}
//}
