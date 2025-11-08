//
//  ShipInfo.swift
//  MobileTest
//
//  Created by 刘志康 on 2025/11/6.
//

import Foundation

struct Booking: Identifiable, Codable {
    let id: UUID = UUID()
    let shipReference: String
    let shipToken: String
    let canIssueTicketChecking: Bool
    let expiryTime: String
    let duration: Int
    let segments: [Segment]
}
