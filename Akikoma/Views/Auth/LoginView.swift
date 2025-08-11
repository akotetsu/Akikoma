//
//  LoginView.swift
//  Akikoma
//
//  Created by 原里駆 on 2025/08/11.
//

import SwiftUI

struct LoginView: View {
    @Bindable var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // ヘッダー
                VStack(spacing: 16) {
                    Image(systemName: "calendar.badge.plus")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                    
                    Text("AkiComa")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    
                    Text("空きコマ共有アプリ")
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 60)
                
                // フォーム
                VStack(spacing: 20) {
                    // メールアドレス
                    VStack(alignment: .leading, spacing: 8) {
                        Text("メールアドレス")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        TextField("example@email.com", text: $viewModel.email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                    }
                    
                    // パスワード
                    VStack(alignment: .leading, spacing: 8) {
                        Text("パスワード")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        SecureField("パスワードを入力", text: $viewModel.password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .textContentType(.password)
                    }
                }
                .padding(.horizontal, 30)
                
                // エラーメッセージ
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                }
                
                // ログインボタン
                Button(action: {
                    Task {
                        await viewModel.signIn()
                    }
                }) {
                    HStack {
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(0.8)
                        }
                        Text(viewModel.isLoading ? "ログイン中..." : "ログイン")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.blue)
                    .cornerRadius(25)
                }
                .disabled(viewModel.isLoading)
                .padding(.horizontal, 30)
                
                // パスワードリセット
                Button("パスワードを忘れた場合") {
                    viewModel.showPasswordReset = true
                }
                .foregroundColor(.blue)
                .font(.subheadline)
                
                Spacer()
                
                // サインアップリンク
                HStack {
                    Text("アカウントをお持ちでない場合")
                        .foregroundColor(.secondary)
                    Button("新規登録") {
                        viewModel.showSignUp = true
                    }
                    .foregroundColor(.blue)
                }
                .font(.subheadline)
                .padding(.bottom, 30)
            }
        }
        .sheet(isPresented: $viewModel.showSignUp) {
            SignUpView(viewModel: viewModel)
        }
        .onChange(of: viewModel.isAuthenticated) { _, isAuthenticated in
            if isAuthenticated {
                // 認証成功時の処理は親ビューで管理
            }
        }

        .alert("パスワードリセット", isPresented: $viewModel.showPasswordReset) {
            TextField("メールアドレス", text: $viewModel.email)
            Button("送信") {
                Task {
                    await viewModel.resetPassword()
                }
            }
            Button("キャンセル", role: .cancel) { }
        } message: {
            Text("パスワードリセットメールを送信します")
        }
    }
}

#Preview {
    LoginView(viewModel: AuthViewModel())
}
