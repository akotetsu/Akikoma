//
//  OnboardingView.swift
//  Akikoma
//
//  Created by 原里駆 on 2025/08/11.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(OnboardingViewModel.self) private var onboardingViewModel
    @State private var currentPage = 0
    
    private let onboardingPages = OnboardingPage.pages
    
    var body: some View {
        ZStack {
            // 背景グラデーション
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                // スキップボタン
                OnboardingSkipButton {
                    onboardingViewModel.markOnboardingAsComplete()
                }
                
                // ページビュー
                TabView(selection: $currentPage) {
                    ForEach(0..<onboardingPages.count, id: \.self) { index in
                        OnboardingPageView(page: onboardingPages[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.easeInOut, value: currentPage)
                
                // ページインジケーターとボタン
                OnboardingNavigationView(
                    currentPage: currentPage,
                    totalPages: onboardingPages.count,
                    onNext: {
                        withAnimation {
                            currentPage += 1
                        }
                    },
                    onComplete: {
                        onboardingViewModel.markOnboardingAsComplete()
                    }
                )
            }
        }
    }
}

