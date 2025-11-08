//
//  Segment.swift
//  MobileTest
//
//  Created by 刘志康 on 2025/11/7.
//

import Foundation

struct Segment: Identifiable, Codable {
    let id: Int
    let originAndDestinationPair: OriginDestinationPair
}

