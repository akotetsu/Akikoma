//
//  OnboardingViewModel.swift
//  Akikoma
//
//  Created by 原里駆 on 2025/08/11.
//
import Foundation
import SwiftUI

@Observable
class OnboardingViewModel {
    private let userDefaults = UserDefaults.standard
    private let hasSeenOnboardingKey = "hasSeenOnboarding"
    
    var hasSeenOnboarding: Bool {
        get {
            userDefaults.bool(forKey: hasSeenOnboardingKey)
        }
        set {
            userDefaults.set(newValue, forKey: hasSeenOnboardingKey)
        }
    }
    
    func markOnboardingAsComplete() {
        hasSeenOnboarding = true
    }
    
    func resetOnboarding() {
        hasSeenOnboarding = false
    }
}
