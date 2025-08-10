//
//  AkikomaApp.swift
//  Akikoma
//
//  Created by 原里駆 on 2025/08/10.
//

import SwiftUI

@main
struct AkikomaApp: App {
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
