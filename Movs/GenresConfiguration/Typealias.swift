//
//  Typealias.swift
//  Movs
//
//  Created by Lorhany Moraes on 13/08/22.
//

import Foundation

typealias Response<T: Decodable> = (Result<T>) -> ()
