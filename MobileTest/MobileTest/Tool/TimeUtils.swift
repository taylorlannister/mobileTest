//
//  TimeUtils.swift
//  MobileTest
//
//  Created by 刘志康 on 2025/11/8.
//

import Foundation


final class TimeUtils {

    static let shared = TimeUtils()
    private init() {}
    
    static var currentTimestamp: TimeInterval {
        Date().timeIntervalSince1970
    }
    
    static func isPastTime(timestamp: TimeInterval) -> Bool {
        return timestamp < currentTimestamp
    }
    
    static func format(timestamp: TimeInterval,
                      format: String = "yyyy-MM-dd HH:mm:ss",
                      timeZone: TimeZone = TimeZone(identifier: "Asia/Shanghai")!) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = timeZone
        return formatter.string(from: date)
    }
}
