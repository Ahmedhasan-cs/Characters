//
//  YassirApp.swift
//  Yassir
//
//  Created by Ahmed Aly on 11/02/2025.
//

import SwiftUI

@main
struct YassirApp: App {
    @StateObject var coordinator = AppCoordinator()
    var body: some Scene {
        WindowGroup {
            CoordinatorView(coordinator: coordinator)
                .onAppear {
                    coordinator.start()
                }
        }
    }
}
