//
//  BookingService.swift
//  MobileTest
//
//  Created by 刘志康 on 2025/11/7.
//
import Foundation
class BookingService {
    func fetchBookings(completion: @escaping (Result<Booking, Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: "Booking", withExtension: "json") else {
            completion(.failure(NSError(domain: "BookingService", code: 0, userInfo: [NSLocalizedDescriptionKey: "JSON 文件不存在"])))
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let response = try decoder.decode(Booking.self, from: data)
            completion(.success(response))
        } catch {
            completion(.failure(error))
        }
    }
}
