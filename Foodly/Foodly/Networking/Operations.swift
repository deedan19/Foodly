//
//  Operations.swift
//  Foodly
//
//  Created by Decagon on 5.6.21.
//

import Foundation
enum Operations {
    case create(data: Parameter)
    case read
    case update(data: Parameter)
    case delete
    case query
}
