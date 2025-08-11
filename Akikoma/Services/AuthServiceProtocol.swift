//
//  AuthServiceProtocol.swift
//  Akikoma
//
//  Created by 原里駆 on 2025/08/11.
//

import Foundation
import FirebaseAuth

protocol AuthServiceProtocol {
    @MainActor var currentUser: User? { get }
    @MainActor var isAuthenticated: Bool { get }
    
    @MainActor func signIn(email: String, password: String) async throws -> User
    @MainActor func signUp(email: String, password: String, displayName: String) async throws -> User
    @MainActor func signOut() async throws
    @MainActor func deleteAccount() async throws
    @MainActor func resetPassword(email: String) async throws
    @MainActor func updateDisplayName(_ displayName: String) async throws
}
