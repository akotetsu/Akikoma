//
//  User.swift
//  Akikoma
//
//  Created by 原里駆 on 2025/08/11.
//

import Foundation
import FirebaseAuth

struct User: Identifiable, Codable {
    let id: String
    let email: String
    let displayName: String
    let faculty: String?
    let createdAt: Date
    
    init(firebaseUser: FirebaseAuth.User) {
        self.id = firebaseUser.uid
        self.email = firebaseUser.email ?? ""
        self.displayName = firebaseUser.displayName ?? ""
        self.faculty = nil
        self.createdAt = firebaseUser.metadata.creationDate ?? Date()
    }
    
    init(id: String, email: String, displayName: String, faculty: String? = nil, createdAt: Date = Date()) {
        self.id = id
        self.email = email
        self.displayName = displayName
        self.faculty = faculty
        self.createdAt = createdAt
    }
}
