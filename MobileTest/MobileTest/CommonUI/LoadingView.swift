//
//  LoadingView.swift
//  MobileTest
//
//  Created by 刘志康 on 2025/11/7.
//

import SwiftUI

struct LoadingView: View {
    
    enum Constant {
        static let opacity: CGFloat = 0.1
        static let scaleEffect: CGFloat = 2
        static let padding: CGFloat = 20
        static let cornerRadius: CGFloat = 10
        
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(Constant.opacity)
                .edgesIgnoringSafeArea(.all)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                .scaleEffect(Constant.scaleEffect)
                .padding(Constant.padding)
                .background(Color(.systemBackground))
                .cornerRadius(Constant.cornerRadius)
        }
    }
}

