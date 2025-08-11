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
    
    // 認証状態管理
    var authViewModel: AuthViewModel?
    
    // コールバック
    var onOnboardingComplete: (() -> Void)?
    
    var hasSeenOnboarding: Bool {
        get {
            userDefaults.bool(forKey: hasSeenOnboardingKey)
        }
        set {
            userDefaults.set(newValue, forKey: hasSeenOnboardingKey)
        }
    }
    
    func markOnboardingAsComplete() {
        print("DEBUG: markOnboardingAsComplete called")
        hasSeenOnboarding = true
        print("DEBUG: hasSeenOnboarding set to \(hasSeenOnboarding)")
        onOnboardingComplete?()
    }
    
    func resetOnboarding() {
        hasSeenOnboarding = false
    }
    
    // 認証状態の初期化
    @MainActor
    func initializeAuthState() {
        if authViewModel == nil {
            authViewModel = AuthViewModel()
        }
        authViewModel?.initializeAuthState()
    }
    
    // アカウント削除時の処理
    @MainActor
    func onAccountDeleted() {
        resetOnboarding()
        authViewModel = nil
    }
}
