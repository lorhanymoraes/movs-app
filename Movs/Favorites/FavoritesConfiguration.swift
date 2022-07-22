//
//  FavoritesConfiguration.swift
//  Movs
//
//  Created by Lorhany Moraes on 17/07/22.
//

import Foundation

//enum FavoritesError: String, Error {
//    case invalidMovieKeyword = "This movie keyword created an invalid request. Please try again."
//    case unableToFavorite  = "There was an error favoriting this movie. Please try it again."
//    case alreadyInFavorites  = "You've already favorited this movie."
//}
//
//enum PersistenceActionType {
//    case add, remove
//}
//
//enum PersistenceManager {
//    
//    static private let defaults = UserDefaults.standard
//    enum Keys {
//        static let favouritesKey = "favorites2"
//    }
//    
//    static func updateWith(favoritedMovie: FavoritedMovie, actionType: PersistenceActionType, completed: @escaping (FavoritesError?) -> Void) {
//        
//        retrieveFavorites { result in
//            switch result {
//            case .success(var favorites):
//                switch actionType {
//                case .add:
//                    guard !favorites.contains(favoritedMovie) else {
//                        completed(.alreadyInFavorites)
//                        return
//                    }
//                    favorites.append(favoritedMovie)
//                    
//                case .remove:
//                    favorites.removeAll {$0.title == favoritedMovie.title}
//                }
//                
//                completed(save(favoritedMovies: favorites))
//                
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//    
//    
//    //Get data of already favorited movies.. First Decoding then Encoding
//    static func retrieveFavorites(completed: @escaping (Result<[FavoritedMovie], FavoritesError>) -> Void) {
//
//        guard let favoritesData = defaults.object(forKey: Keys.favouritesKey) as? Data else {
//            completed(.success([]))
//            return
//        }
//
//        do {
//            let decoder = JSONDecoder()
//            let favorites = try decoder.decode([FavoritedMovie].self, from: favoritesData)
//            completed(.success(favorites))
//        } catch {
//            completed(.failure(.unableToFavorite))
//            print("unableToFavorite. error - inside do+catch retrieveFavorites")
//        }
//    }
//
//
//    //Save new movie to the array of favorited movies. Encoding.
//    static func save(favoritedMovies: [FavoritedMovie]) -> FavoritesError? { /// if saving is successful, we gonna return 'nil'
//        
//        do{
//            let encoder = JSONEncoder()
//            let encodedFavorites = try encoder.encode(favoritedMovies)
//            defaults.set(encodedFavorites, forKey: Keys.favouritesKey)
//            return nil /// we are returning 'nil' because no error happens
//        } catch {
//            return .unableToFavorite
//        }
//    }
//    
//}

