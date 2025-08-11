//
//  AuthViewModel.swift
//  Akikoma
//
//  Created by 原里駆 on 2025/08/11.
//

import Foundation
import SwiftUI

@Observable
final class AuthViewModel {
    let authService: AuthServiceProtocol
    
    // MARK: - Published Properties
    var currentUser: User?
    var isAuthenticated = false
    var isLoading = false
    var errorMessage: String?
    
    // MARK: - Form Properties
    var email = ""
    var password = ""
    var displayName = ""
    var confirmPassword = ""
    
    // MARK: - UI State
    var showSignUp = false
    var showPasswordReset = false
    
    init(authService: AuthServiceProtocol = AuthService()) {
        self.authService = authService
        // 初期化時は非同期で状態を取得するため、デフォルト値を設定
        self.currentUser = nil
        self.isAuthenticated = false
    }
    
    @MainActor
    func initializeAuthState() {
        self.currentUser = authService.currentUser
        self.isAuthenticated = authService.isAuthenticated
    }
    
    // MARK: - Authentication Methods
    func signIn() async {
        guard !email.isEmpty && !password.isEmpty else {
            errorMessage = "メールアドレスとパスワードを入力してください"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let user = try await authService.signIn(email: email, password: password)
            currentUser = user
            isAuthenticated = true
            clearForm()
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func signUp() async {
        guard validateSignUpForm() else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let user = try await authService.signUp(email: email, password: password, displayName: displayName)
            currentUser = user
            isAuthenticated = true
            clearForm()
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func signOut() async {
        isLoading = true
        
        do {
            try await authService.signOut()
            currentUser = nil
            isAuthenticated = false
            clearForm()
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func deleteAccount() async {
        isLoading = true
        
        do {
            try await authService.deleteAccount()
            currentUser = nil
            isAuthenticated = false
            clearForm()
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func resetPassword() async {
        guard !email.isEmpty else {
            errorMessage = "メールアドレスを入力してください"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            try await authService.resetPassword(email: email)
            showPasswordReset = false
            errorMessage = "パスワードリセットメールを送信しました"
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    // MARK: - Helper Methods
    private func validateSignUpForm() -> Bool {
        guard !email.isEmpty else {
            errorMessage = "メールアドレスを入力してください"
            return false
        }
        
        guard !displayName.isEmpty else {
            errorMessage = "表示名を入力してください"
            return false
        }
        
        guard !password.isEmpty else {
            errorMessage = "パスワードを入力してください"
            return false
        }
        
        guard password.count >= 8 else {
            errorMessage = "パスワードは8文字以上で入力してください"
            return false
        }
        
        guard password == confirmPassword else {
            errorMessage = "パスワードが一致しません"
            return false
        }
        
        return true
    }
    
    private func clearForm() {
        email = ""
        password = ""
        displayName = ""
        confirmPassword = ""
        errorMessage = nil
    }
    
    func clearError() {
        errorMessage = nil
    }
}
