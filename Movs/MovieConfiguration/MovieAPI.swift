//
//  MovieUrls.swift
//  Movs
//
//  Created by Lorhany Moraes on 11/07/22.
//

import Foundation
import Alamofire

class MovieAPI {
    
    public static let shared = MovieAPI()
    static private let baseURL = "https://api.themoviedb.org/3/movie/"
    static private let baseGenre = "https://api.themoviedb.org/3/"
    static private let baseURLPopular = "https://api.themoviedb.org/3/movie/popular?"
    static private let apiKey = "b621e030f5e5548ff84999cf7b668c13"
    static private let language = "en-US"
    static private let page = 1
    private class Dummy {}
    
    class func loadAllMovie(page: Int = 1, onComplete: @escaping (APIMovies?) -> Void, onError: @escaping (ModelError) -> Void) {
        let url = baseURLPopular + "api_key=\(apiKey)&language=\(language)&page=\(page)"
        print(url)
        guard let url = URL(string: url) else {
            onError(.url)
            return
        }
        AF.request(url).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                guard let data = response.data else {
                    onError(.noData)
                    return }
                
                do {
                    let allMovies = try JSONDecoder().decode(APIMovies.self, from: data)
                    onComplete(allMovies)
                }
                catch {
                    print(error.localizedDescription)
                    onError(.invalidJSON)
                }
                
            } else {
                onError(.responseStatusCode(code: response.response?.statusCode ?? 0))
            }
        }
    }
    
    class func loadInfoMovie(movieID: Int,onComplete: @escaping (MoviesResult?) -> Void, onError: @escaping (ModelError) -> Void) {
        
        let movieURL = baseURL + "\(movieID)?api_key=\(apiKey)&language=\(language)"
        print(movieURL)
        guard let movieURL = URL(string: movieURL) else {
            onError(.url)
            return
        }
        
        AF.request(movieURL).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                guard let data = response.data else {
                    onError(.noData)
                    return }
                
                do {
                    let infoMovies = try JSONDecoder().decode(MoviesResult.self, from: data)
                    onComplete(infoMovies)
                } catch {
                    print(error.localizedDescription)
                    onError(.invalidJSON)
                }
                
            } else {
                onError(.responseStatusCode(code: response.response?.statusCode ?? 0))
                
            }
        }
    }
    
    class func getGenres(onComplete: @escaping (GenresResponse) -> Void, onError: @escaping (ModelError) -> Void) {
        let genreURL = baseGenre + "\("genre/movie/list")?api_key=\(apiKey)&language=\(language)"
        print(genreURL)
        
        guard let genreURL = URL(string: genreURL) else {
            onError(.url)
            return
        }
        
        AF.request(genreURL).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                guard let data = response.data else {
                    onError(.noData)
                    return }
                
                do{
                    let genres = try JSONDecoder().decode(GenresResponse.self, from: data)
                    onComplete(genres)
                } catch {
                    print(error.localizedDescription)
                    onError(.invalidJSON)
                }
            } else {
                onError(.responseStatusCode(code: response.response?.statusCode ?? 0))
                
            }
            
        }
    }
    
}


