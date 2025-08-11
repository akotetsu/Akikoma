//
//  SignUpView.swift
//  Akikoma
//
//  Created by 原里駆 on 2025/08/11.
//

import SwiftUI

struct SignUpView: View {
    @Bindable var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    // ヘッダー
                    VStack(spacing: 16) {
                        Image(systemName: "person.badge.plus")
                            .font(.system(size: 50))
                            .foregroundColor(.blue)
                        
                        Text("新規登録")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("アカウントを作成して\n空きコマを共有しましょう")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 40)
                    
                    // フォーム
                    VStack(spacing: 20) {
                        // 表示名
                        VStack(alignment: .leading, spacing: 8) {
                            Text("表示名")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            TextField("表示名を入力", text: $viewModel.displayName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .textContentType(.name)
                        }
                        
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
                            
                            SecureField("8文字以上で入力", text: $viewModel.password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .textContentType(.newPassword)
                        }
                        
                        // パスワード確認
                        VStack(alignment: .leading, spacing: 8) {
                            Text("パスワード確認")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            SecureField("パスワードを再入力", text: $viewModel.confirmPassword)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .textContentType(.newPassword)
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
                    
                    // 登録ボタン
                    Button(action: {
                        Task {
                            await viewModel.signUp()
                        }
                    }) {
                        HStack {
                            if viewModel.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(0.8)
                            }
                            Text(viewModel.isLoading ? "登録中..." : "アカウント作成")
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
                    
                    Spacer(minLength: 50)
                }
            }
        }
        .navigationTitle("新規登録")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("キャンセル") {
                    dismiss()
                }
            }
        }
        .onChange(of: viewModel.isAuthenticated) { _, isAuthenticated in
            if isAuthenticated {
                dismiss()
            }
        }
    }
}

#Preview {
    SignUpView(viewModel: AuthViewModel())
}
