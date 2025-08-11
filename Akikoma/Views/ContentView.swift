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
            
            if let authViewModel = onboardingViewModel.authViewModel,
               let user = authViewModel.currentUser {
                Text("ようこそ、\(user.displayName)さん！")
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding(.top, 20)
            }
            
            Text("認証完了！")
                .font(.headline)
                .foregroundColor(.green)
                .padding(.top, 10)
            
            // ログアウトボタン
            if let authViewModel = onboardingViewModel.authViewModel {
                Button("ログアウト") {
                    Task {
                        await authViewModel.signOut()
                    }
                }
                .foregroundColor(.red)
                .padding(.top, 20)
                
                // アカウント削除ボタン
                Button("アカウント削除") {
                    Task {
                        await authViewModel.deleteAccount()
                        onboardingViewModel.onAccountDeleted()
                    }
                }
                .foregroundColor(.red)
                .padding(.top, 10)
            }
            
            // デバッグ用：オンボーディングをリセットするボタン
            Button("オンボーディングをリセット") {
                onboardingViewModel.resetOnboarding()
            }
            .foregroundColor(.orange)
            .padding(.top, 40)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
