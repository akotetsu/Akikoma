//
//  Error.swift
//  Akikoma
//
//  Created by 原里駆 on 2025/08/11.
//

import Foundation
import FirebaseAuth

enum AuthError: LocalizedError {
    case signInFailed
    case signUpFailed
    case signOutFailed
    case deleteAccountFailed
    case passwordResetFailed
    case userNotFound
    case weakPassword
    case emailAlreadyInUse
    case invalidEmail
    case networkError
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .signInFailed:
            return "ログインに失敗しました"
        case .signUpFailed:
            return "アカウント作成に失敗しました"
        case .signOutFailed:
            return "ログアウトに失敗しました"
        case .deleteAccountFailed:
            return "アカウント削除に失敗しました"
        case .passwordResetFailed:
            return "パスワードリセットに失敗しました"
        case .userNotFound:
            return "ユーザーが見つかりません"
        case .weakPassword:
            return "パスワードが弱すぎます（8文字以上で入力してください）"
        case .emailAlreadyInUse:
            return "このメールアドレスは既に使用されています"
        case .invalidEmail:
            return "メールアドレスの形式が正しくありません"
        case .networkError:
            return "ネットワークエラーが発生しました"
        case .unknown(let error):
            return "エラーが発生しました: \(error.localizedDescription)"
        }
    }
    
    static func fromFirebaseError(_ error: Error) -> AuthError {
        let nsError = error as NSError
        switch nsError.code {
        case AuthErrorCode.userNotFound.rawValue:
            return .userNotFound
        case AuthErrorCode.weakPassword.rawValue:
            return .weakPassword
        case AuthErrorCode.emailAlreadyInUse.rawValue:
            return .emailAlreadyInUse
        case AuthErrorCode.invalidEmail.rawValue:
            return .invalidEmail
        case AuthErrorCode.networkError.rawValue:
            return .networkError
        default:
            return .unknown(error)
        }
    }
}
