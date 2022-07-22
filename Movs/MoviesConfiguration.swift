//
//  MoviesConfiguration.swift
//  Movs
//
//  Created by Lorhany Moraes on 20/07/22.
//

import Foundation

 class MoviesConfiguration {
     
     public static let shared = MoviesConfiguration()
     
     private init() {}
     
     private let urlSession = URLSession.shared
     private let baseURL = URL(string: "https://api.themoviedb.org/3")!
     private let apiKey = "b621e030f5e5548ff84999cf7b668c13"
     
     private let jsonDecoder: JSONDecoder = {
         let jsonDecoder = JSONDecoder()
         jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
         
         let dateFormatter        = DateFormatter()
         dateFormatter.dateFormat = "yyyy-mm-dd"
         jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
         return jsonDecoder
     }()
     
     
      //MARK:- General methods
     
     private func fetchMovieInfo <MoviesResponse: Decodable>(url: URL, page: Int, completion: @escaping (Result<MoviesResponse, PError>) -> Void) {
         
         guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
             completion(.failure(.invalidEndpoint))
             return
         }
         
         let queryItems = [URLQueryItem(name: "api_key", value: apiKey),
                           URLQueryItem(name: "page", value: "\(page)")]
         urlComponents.queryItems = queryItems
         
         guard let url = urlComponents.url else {
             completion(.failure(.invalidEndpoint))
             return
         }
         
         urlSession.dataTask(with: url) { (result) in
             switch result {
                 
             case .success(let (response, data)):
                 guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                     completion(.failure(.invalidResponse))
                     return
                 }
                 do {
                     let values = try self.jsonDecoder.decode(MoviesResponse.self, from: data)
                     completion(.success(values))
                 } catch {
                     completion(.failure(.decodeError))
                 }
                 
             case .failure(let error):
                 completion(.failure(.apiError))
                 print ("\(error.localizedDescription)")
             }
         }.resume()
     }
     
     
     private func fetchMovieInfoByID <T: Decodable>(url: URL, completion: @escaping (Result<T, PError>) -> Void) {
         
         guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
             completion(.failure(.invalidEndpoint))
             return
         }
         
         let queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
         urlComponents.queryItems = queryItems
         
         guard let url = urlComponents.url else {
             completion(.failure(.invalidEndpoint))
             return
         }
         
         urlSession.dataTask(with: url) { (result) in
             switch result {
                 
             case .success(let (response, data)):
                 guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                     completion(.failure(.invalidResponse))
                     return
                 }
                 do {
                     let values = try self.jsonDecoder.decode(T.self, from: data)
                     completion(.success(values))
                 } catch {
                     completion(.failure(.decodeError))
                 }
                 
             case .failure(let error):
                 completion(.failure(.apiError))
                 print ("\(error.localizedDescription)")
             }
         }.resume()
     }
 
     

     //MARK:- Method for Categories
     
     public func fetchMovies(from endpoint: String, page: Int, result: @escaping (Result<MoviesResponse, PError>) -> Void) {
         let movieURL = baseURL
             .appendingPathComponent("movie")
             .appendingPathComponent(endpoint)
         
         fetchMovieInfo(url: movieURL, page: page, completion: result)
     }
     
     
     //MARK:- Method for MovieID
     public func fetchMovie(movieID: Int, result: @escaping (Result <Movie, PError>) -> Void) {
         
         let movieURL = baseURL
         .appendingPathComponent("movie")
         .appendingPathComponent(String(movieID))
         
         fetchMovieInfoByID(url: movieURL, completion: result)
     }
     
     
     
     
     //MARK:- Method for a Movie keyword
     public func searchMovie(query: String, page: Int, params: [String : String]?, completion: @escaping (Result<MoviesResponse,PError>) -> Void) {
         
         guard var urlComponents = URLComponents(string: "\(baseURL)/search/movie") else {
             completion(.failure(.invalidEndpoint))
             return
         }
         
         var queryItems = [URLQueryItem(name: "api_key", value: apiKey),
                           URLQueryItem(name: "language", value: "en-US"),
                           URLQueryItem(name: "include_adult", value: "false"),
                           URLQueryItem(name: "region", value: "US"),
                           URLQueryItem(name: "query", value: query),
                           URLQueryItem(name: "page", value: "\(page)")
                         ]
         
         if let params = params {
             queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
         }
         
         urlComponents.queryItems = queryItems
         
         guard let url = urlComponents.url else {
             completion(.failure(.invalidEndpoint))
             return
         }
         
         urlSession.dataTask(with: url) { (result) in
             switch result {
                 
             case .success(let (response, data)):
                 guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                     completion(.failure(.invalidResponse))
                     return
                 }
                 do {
                     let values = try self.jsonDecoder.decode(MoviesResponse.self, from: data)
                     completion(.success(values))
                 } catch {
                     completion(.failure(.decodeError))
                 }
                 
             case .failure(let error):
                 completion(.failure(.apiError))
                 print ("\(error.localizedDescription)")
             }
         }.resume()
     }
 }
         
    
