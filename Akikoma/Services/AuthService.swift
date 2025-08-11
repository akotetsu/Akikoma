//
//  AuthService.swift
//  Akikoma
//
//  Created by 原里駆 on 2025/08/11.
//

import Foundation
import FirebaseAuth
import FirebaseCore

final class AuthService: AuthServiceProtocol {
    private let auth = Auth.auth()
    
    @MainActor
    var currentUser: User? {
        guard let firebaseUser = auth.currentUser else { return nil }
        return User(firebaseUser: firebaseUser)
    }
    
    @MainActor
    var isAuthenticated: Bool {
        auth.currentUser != nil
    }
    
    @MainActor
    func signIn(email: String, password: String) async throws -> User {
        do {
            let result = try await auth.signIn(withEmail: email, password: password)
            return User(firebaseUser: result.user)
        } catch {
            throw AuthError.fromFirebaseError(error)
        }
    }
    
    @MainActor
    func signUp(email: String, password: String, displayName: String) async throws -> User {
        do {
            let result = try await auth.createUser(withEmail: email, password: password)
            
            // プロフィール更新
            let changeRequest = result.user.createProfileChangeRequest()
            changeRequest.displayName = displayName
            try await changeRequest.commitChanges()
            
            return User(firebaseUser: result.user)
        } catch {
            throw AuthError.fromFirebaseError(error)
        }
    }
    
    @MainActor
    func signOut() async throws {
        do {
            try auth.signOut()
        } catch {
            throw AuthError.signOutFailed
        }
    }
    
    @MainActor
    func deleteAccount() async throws {
        guard let user = auth.currentUser else {
            throw AuthError.userNotFound
        }
        
        do {
            try await user.delete()
        } catch {
            throw AuthError.fromFirebaseError(error)
        }
    }
    
    @MainActor
    func resetPassword(email: String) async throws {
        do {
            try await auth.sendPasswordReset(withEmail: email)
        } catch {
            throw AuthError.fromFirebaseError(error)
        }
    }
    
    @MainActor
    func updateDisplayName(_ displayName: String) async throws {
        guard let user = auth.currentUser else {
            throw AuthError.userNotFound
        }
        
        do {
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = displayName
            try await changeRequest.commitChanges()
        } catch {
            throw AuthError.fromFirebaseError(error)
        }
    }
}
