//
//  AkikomaApp.swift
//  Akikoma
//
//  Created by 原里駆 on 2025/08/10.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct AkikomaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var onboardingViewModel = OnboardingViewModel()
    @State private var hasSeenOnboarding = false
    
    var body: some Scene {
        WindowGroup {
            Group {
                if hasSeenOnboarding {
                    // オンボーディング完了後は認証画面を表示
                    if let authViewModel = onboardingViewModel.authViewModel {
                        if authViewModel.isAuthenticated {
                            ContentView()
                                .environment(onboardingViewModel)
                        } else {
                            LoginView(viewModel: authViewModel)
                                .environment(onboardingViewModel)
                        }
                    } else {
                        // 初回認証画面表示時にAuthViewModelを初期化
                        LoginView(viewModel: AuthViewModel())
                            .environment(onboardingViewModel)
                            .onAppear {
                                Task { @MainActor in
                                    onboardingViewModel.initializeAuthState()
                                }
                            }
                    }
                } else {
                    OnboardingView()
                        .environment(onboardingViewModel)
                }
            }
            .onAppear {
                // 初期状態を設定
                hasSeenOnboarding = onboardingViewModel.hasSeenOnboarding
                print("DEBUG: hasSeenOnboarding = \(hasSeenOnboarding)")
                print("DEBUG: authViewModel = \(onboardingViewModel.authViewModel != nil ? "exists" : "nil")")
                
                // コールバックを設定
                onboardingViewModel.onOnboardingComplete = {
                    hasSeenOnboarding = true
                    print("DEBUG: onOnboardingComplete callback called")
                }
            }
        }
    }
}
