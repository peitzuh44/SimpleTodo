//
//  AuthView.swift
//  SimpleTodo
//
//  Created by Pei-Tzu Huang on 2024/8/28.
//

import SwiftUI

struct AuthView: View {
    @StateObject private var authManager = AuthManager()

    var body: some View {
        switch authManager.authState {
        case .signedIn:
            TodoView(authManager: authManager)
        case .signedOut:
            SignInView(authManager: authManager)
        }
    }
}
