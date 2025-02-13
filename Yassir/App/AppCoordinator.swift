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

public class AppCoordinator: ObservableObject {
    @Published var navigationPath = NavigationPath()

    func start() {
        navigationPath = NavigationPath()
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
        navigationPath = NavigationPath()
    }
}

enum AppScreen: Hashable {
    case home
    case details(character: Character)
}

