//
//  ContentView.swift
//  Akikoma
//
//  Created by 原里駆 on 2025/08/10.
//

import SwiftUI

struct ContentView: View {
    @Environment(OnboardingViewModel.self) private var onboardingViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "calendar.badge.plus")
                .imageScale(.large)
                .foregroundStyle(.blue)
                .font(.system(size: 60))
            
            Text("AkiComa")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            Text("空きコマ共有アプリ")
                .font(.title2)
                .foregroundColor(.secondary)
            
            Text("オンボーディング完了！")
                .font(.headline)
                .foregroundColor(.green)
                .padding(.top, 20)
            
            // デバッグ用：オンボーディングをリセットするボタン
            Button("オンボーディングをリセット") {
                onboardingViewModel.resetOnboarding()
            }
            .foregroundColor(.red)
            .padding(.top, 40)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
