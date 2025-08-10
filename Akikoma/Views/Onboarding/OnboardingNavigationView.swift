//
//  OnboardingNavigationView.swift
//  Akikoma
//
//  Created by 原里駆 on 2025/08/11.
//

import SwiftUI

struct OnboardingNavigationView: View {
    let currentPage: Int
    let totalPages: Int
    let onNext: () -> Void
    let onComplete: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            // ページドット
            HStack(spacing: 8) {
                ForEach(0..<totalPages, id: \.self) { index in
                    Circle()
                        .fill(currentPage == index ? Color.blue : Color.gray.opacity(0.3))
                        .frame(width: 8, height: 8)
                        .animation(.easeInOut, value: currentPage)
                }
            }
            
            // 次へ/完了ボタン
            Button(action: {
                if currentPage < totalPages - 1 {
                    onNext()
                } else {
                    onComplete()
                }
            }) {
                Text(currentPage < totalPages - 1 ? "次へ" : "始める")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.blue)
                    .cornerRadius(25)
            }
            .padding(.horizontal, 40)
        }
        .padding(.bottom, 50)
    }
}

