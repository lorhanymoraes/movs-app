//
//  MovieUrls.swift
//  Movs
//
//  Created by Lorhany Moraes on 11/07/22.
//

import Foundation
import Alamofire

class Configuration {
    
    static private let baseURLPopular = "https://api.themoviedb.org/3/movie/popular?"
    static private let apiKey = "b621e030f5e5548ff84999cf7b668c13"
    static private let language = "en-US"
    static private let page = 1
    
    
    class func loadMovie(page: Int = 1, onComplete: @escaping (APIMovies?) -> Void, onError: @escaping (PError) -> Void) {
        let page = page
        

        let url = baseURLPopular + "api_key=\(apiKey)&language=\(language)&page=\(page)"
        print(url)
        
        guard let url = URL(string: url) else {
            onError(.decodeError)
            return
        }
        AF.request(url).responseJSON { (response) in
            guard let data = response.data else {
                    onError(.invalidUrl)
                    return }
                    do{
                        let allMovies = try JSONDecoder().decode(APIMovies.self, from: data)
                        onComplete(allMovies)
                    } catch {
                        print(error.localizedDescription)
                        onError(.decodeError)
                    }
                    
                }
            }
       }
     
