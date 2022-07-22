//
//  GetGenres.swift
//  Movs
//
//  Created by Lorhany Moraes on 20/07/22.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(ErrorModel)
}

typealias Response<T: Decodable> = (Result<T>) -> ()

protocol MovieService: Service {
    func getGenres(completion: @escaping Response<[Genre]>)
}

protocol Service: AnyObject {}

extension Service {
    func prettyPrint<T: Encodable>(model: T) {
        debugPrint("-------")
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try jsonEncoder.encode(model)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                debugPrint(jsonString)
            }
        } catch let err {
            debugPrint(err)
        }
        debugPrint("-------")
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
    
    fileprivate static var cachedGenres: [Genre] = []
    static func getGenres(movieApi: MovieService, completion: @escaping Response<[Genre]>) {
        if cachedGenres.isEmpty {
            movieApi.getGenres { (response) in
                switch response {
                case .success(let genres):
                    cachedGenres = genres
                    completion(Result.success(genres))
                case .error(let err):
                    completion(Result.error(err))
                }
            }
        } else {
            completion(Result.success(cachedGenres))
        }
    }
}

extension Genre {
    static func ==(lhs: Genre, rhs: Genre) -> Bool {
        return lhs.id == rhs.id
    }
}

class GenresResponse: NSObject, Codable {
    var genres: [Genre]?
}
