//
//  Untitled.swift
//  Yassir
//
//  Created by Ahmed Aly on 11/02/2025.
//

import SwiftUI

struct CoordinatorView: View {
    @ObservedObject var coordinator: AppCoordinator

    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            CharacterListView(viewModel: CharacterListViewModel(coordinator: coordinator))
                .navigationDestination(for: AppScreen.self) { screen in
                    switch screen {
                        case .home:
                            CharacterListView(viewModel: CharacterListViewModel(coordinator: coordinator))
                        case .details(_):
                            CharacterDetailsView(coordinator: coordinator)
                    }
                   
                }
        }
    }
}
