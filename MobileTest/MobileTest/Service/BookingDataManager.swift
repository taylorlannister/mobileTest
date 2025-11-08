//
//  DataManager.swift
//  MobileTest
//
//  Created by 刘志康 on 2025/11/7.
//

import Foundation

class BookingDataManager: ObservableObject {
    @Published var bookings: [Booking]? = []
    @Published var requestStatus: RequestStatus = .loading
    @Published var error: Error?
    
    private let service = BookingService()
    enum Constant {
        static let cacheKey = "cachedBookings"
    }
   
    private let expiryDuration: TimeInterval = 3600
    
    init() {
        loadCacheAndCombineData()
    }
    
    private func loadCacheAndCombineData() {
        if let cachedData = UserDefaults.standard.data(forKey: Constant.cacheKey) {
            do {
                let decoder = JSONDecoder()
                self.bookings = try decoder.decode([Booking].self, from: cachedData)
            } catch {
                self.error = error
            }
        }
    }
    
    private func saveToCache(_ response: Booking) {
        var allBookings: [Booking] = []
        if let cachedData = UserDefaults.standard.data(forKey: Constant.cacheKey) {
            let cachedBookings = try? JSONDecoder().decode([Booking].self, from: cachedData)
            allBookings = cachedBookings ?? []
        }
        if TimeUtils.isPastTime(timestamp: Double(response.expiryTime) ?? 0) {
            allBookings.append(response)
        }
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(allBookings)
            UserDefaults.standard.set(data, forKey: Constant.cacheKey)
        } catch {
            self.error = error
        }
    }
    
    func dataProvider() {
        service.fetchBookings { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                switch result {
                case .success(let response):
                    print(response)
                    self.requestStatus = .success
                    self.saveToCache(response)
                    self.loadCacheAndCombineData()
                case .failure(let err):
                    self.requestStatus = .failure
                    self.error = err
                }
            }
        }
    }
    
    func loadMore() {
        service.fetchBookings { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                switch result {
                case .success(let response):
                    self.requestStatus = .success
                    self.saveToCache(response)
                    self.loadCacheAndCombineData()
                case .failure(let err):
                    self.requestStatus = .failure
                    self.error = err
                }
            }
        }
    }
    
    func refreshData() {
        self.bookings?.removeAll()
        dataProvider()
    }
}
