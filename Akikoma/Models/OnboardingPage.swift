//
//  OnboardingPage.swift
//  Akikoma
//
//  Created by 原里駆 on 2025/08/11.
//

import SwiftUI

struct OnboardingPage: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let imageName: String
    let backgroundColor: Color
}

// オンボーディングページのデータ
extension OnboardingPage {
    static let pages: [OnboardingPage] = [
        OnboardingPage(
            title: "空きコマを共有",
            description: "あなたの空き時間を友達と共有して、一緒に過ごす時間を作りましょう。",
            imageName: "calendar.badge.plus",
            backgroundColor: Color.blue.opacity(0.1)
        ),
        OnboardingPage(
            title: "簡単に予定調整",
            description: "友達の空き時間を確認して、簡単に予定を申請・承認できます。",
            imageName: "person.2.circle.fill",
            backgroundColor: Color.green.opacity(0.1)
        ),
        OnboardingPage(
            title: "予約を確定",
            description: "承認された予定は自動的に予約として確定され、スケジュールに反映されます。",
            imageName: "checkmark.circle.fill",
            backgroundColor: Color.orange.opacity(0.1)
        )
    ]
}
