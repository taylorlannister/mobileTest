//
//  OriginDestinationPair.swift
//  MobileTest
//
//  Created by 刘志康 on 2025/11/6.
//

import Foundation

struct OriginDestinationPair: Codable {
    let destination: Location
    let destinationCity: String
    let origin: Location
    let originCity: String
}

