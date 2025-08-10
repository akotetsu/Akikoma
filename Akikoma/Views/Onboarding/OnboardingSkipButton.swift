//
//  OnboardingSkipButton.swift
//  Akikoma
//
//  Created by 原里駆 on 2025/08/11.
//

import SwiftUI

struct OnboardingSkipButton: View {
    let onSkip: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Button("スキップ") {
                onSkip()
            }
            .foregroundColor(.gray)
            .padding(.horizontal, 20)
            .padding(.top, 10)
        }
    }
}


