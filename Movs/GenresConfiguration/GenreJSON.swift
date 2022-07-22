//
//  GenreApi.swift
//  Movs
//
//  Created by Lorhany Moraes on 14/07/22.
//

import Foundation
import SwiftyJSON

struct GenreJSON: Codable, Equatable {
    let id: Int?
    let name: String?
}


    
    
    
    
    /*
    var idString: String? {
        if let id = id {
            return String(id)
        }
        return " "
    }
}

func ==(lhs:GenreJSON, rhs:GenreJSON) -> Bool {
    return lhs.idString == rhs.name
}
     /**/*/
