//
//  BookingListView.swift
//  MobileTest
//
//  Created by 刘志康 on 2025/11/7.
//

import SwiftUI

struct BookingListView: View {
    @StateObject private var dataManager = BookingDataManager()
    
    enum Constant {
        static let borderWidth: CGFloat = 0.5
    }
    
    var body: some View {
        NavigationView {
            buildViewContent()
            .navigationTitle("Bookings")
            .onAppear {
                DispatchQueue.main.async {
                    dataManager.dataProvider()
                }
            }
            .refreshable {
                dataManager.refreshData()
            }
            .alert("Error", isPresented: Binding(
                get: { dataManager.error != nil },
                set: { if !$0 { dataManager.error = nil } }
            )) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(dataManager.error?.localizedDescription ?? "Unknown error")
            }
        }
    }
    
    @ViewBuilder
    func buildViewContent() -> some View {
        switch dataManager.requestStatus {
        case .loading:
            LoadingView()
        case .success:
            VStack {
                List {
                    ForEach(dataManager.bookings ?? []) {booking in
                        ForEach(booking.segments) {segment in
                            BookingListItemView(segment: segment)
                        }
                    }
                }
                Spacer()
                Text("load More")
                .onTapGesture {
                    dataManager.requestStatus = .loading
                    dataManager.loadMore()
                }
            }
        case .failure:
            EmptyView()
        }
    }
}

struct BookingListView_Previews: PreviewProvider {
    static var previews: some View {
        BookingListView()
    }
}
