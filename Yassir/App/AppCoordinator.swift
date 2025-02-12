//
//  MainCoordinator.swift
//  Yassir
//
//  Created by Ahmed Aly on 11/02/2025.
//

import SwiftUI

protocol Coordinator: AnyObject {
    func start()
}

import SwiftUI

class AppCoordinator: ObservableObject {
    @Published var navigationPath = NavigationPath()

    func start() {
        navigationPath = NavigationPath() // Ensures fresh start
    }

    func goToScreen(_ screen: AppScreen) {
        navigationPath.append(screen)
    }

    func goBack() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }

    func resetToRoot() {
        navigationPath = NavigationPath() // Clears navigation history
    }
}

enum AppScreen: Hashable {
    case home
    case details(item: String)
}

