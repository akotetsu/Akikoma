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
    
    var body: some Scene {
        WindowGroup {
            if onboardingViewModel.hasSeenOnboarding {
                ContentView()
            } else {
                OnboardingView()
                    .environment(onboardingViewModel)
            }
        }
    }
}
