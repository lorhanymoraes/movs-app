//
//  FavoritesManager.swift
//  Movs
//
//  Created by Lorhany Moraes on 22/07/22.
//

import Foundation


enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    enum Keys {
        static let favouritesKey = "favorites2"
    }
    
    static func updateWith(favoritedMovie: FavoritedMovie, actionType: PersistenceActionType, completed: @escaping (ModelError?) -> Void) {
        
        retrieveFavorites { result in
            switch result {
            case .success(var favorites):
                switch actionType {
                case .add:
                    guard !favorites.contains(favoritedMovie) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    favorites.append(favoritedMovie)
                    
                case .remove:
                    favorites.removeAll {$0.title == favoritedMovie.title}
                }
                
                completed(save(favoritedMovies: favorites))
                
            case .failure(let error):
                completed(error)
                print ("error inside retrieveFavorites method")
            }
        }
    }
    
    
    static func retrieveFavorites(completed: @escaping (Result<[FavoritedMovie], ModelError>) -> Void) {
        
        guard let favoritesData = defaults.object(forKey: Keys.favouritesKey) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([FavoritedMovie].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
            print("unableToFavorite. error - inside retrieveFavorites")
        }
    }
    
    
    static func save(favoritedMovies: [FavoritedMovie]) -> ModelError? {
        
        do{
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favoritedMovies)
            defaults.set(encodedFavorites, forKey: Keys.favouritesKey)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
    
}
