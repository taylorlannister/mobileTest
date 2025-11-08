//
//  BookingListItemView.swift
//  MobileTest
//
//  Created by 刘志康 on 2025/11/7.
//

import SwiftUI
import UIKit

struct BookingListItemView: View {
    let segment: Segment
    
    enum Constant {
        static let itemSpaceing: CGFloat = 8
        static let borderWidth: CGFloat = 0.5
        static let conrnerRadius: CGFloat = 10
    }
    
    private var randomColor: Color {
        Color(
            red: Double.random(in: 0.5...1),
            green: Double.random(in: 0.5...1),
            blue: Double.random(in: 0.5...1)
        )
    }
    
    var body: some View {
        VStack {
            Text("originCity:\(segment.originAndDestinationPair.originCity)").font(.largeTitle)
            VStack(alignment: .leading, spacing: Constant.itemSpaceing) {
                Text(segment.originAndDestinationPair.origin.displayName).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Spacer()
                Text(segment.originAndDestinationPair.origin.url).font(.subheadline)
                Spacer()
                Text(segment.originAndDestinationPair.origin.code).font(.caption)
                Spacer()
            }.onTapGesture {
                guard let url = URL(string: "http://\(segment.originAndDestinationPair.origin.url)") else {
                    return
                }
                openExternalURL(url)
            }
            
            Text("destinationCity:\(segment.originAndDestinationPair.destinationCity)").font(.largeTitle)
            VStack(alignment: .leading, spacing: Constant.itemSpaceing) {
                Text(segment.originAndDestinationPair.destination.displayName).font(.title)
                Spacer()
                Text(segment.originAndDestinationPair.destination.url).font(.subheadline)
                Spacer()
                Text(segment.originAndDestinationPair.destination.code).font(.caption)
                Spacer()
            }.onTapGesture {
                guard let url = URL(string: "http://\(segment.originAndDestinationPair.destination.url)") else {
                    return
                }
                openExternalURL(url)
            }
        }
        .background(randomColor)
        .cornerRadius(Constant.conrnerRadius)
    }
    
    private func openExternalURL(_ url: URL) {
        guard UIApplication.shared.canOpenURL(url) else {
            print("Cannot open URL: \(url)")
            return
        }
        UIApplication.shared.open(url)
    }
}
