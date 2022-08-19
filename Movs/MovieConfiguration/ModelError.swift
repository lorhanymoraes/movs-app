//
//  PError.swift
//  Movs
//
//  Created by Lorhany Moraes on 20/07/22.
//

import Foundation

enum ModelError: Error {
    case url
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
    
    case unableToFavorite  
    case alreadyInFavorites
    
}


