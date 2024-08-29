//
//  SimpleTodoApp.swift
//  SimpleTodo
//
//  Created by Pei-Tzu Huang on 2024/8/27.
//

import SwiftUI
import FirebaseCore

@main
struct SimpleTodoApp: App {
    
    init() {
        FirebaseApp.configure()
        
    }
    var body: some Scene {
        WindowGroup {
            NavigationView {
                AuthView()
            }
        }
    }
}
