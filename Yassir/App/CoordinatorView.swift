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
            CharacterListDI(coordinator: coordinator).launch()
                .navigationDestination(for: AppScreen.self) { screen in
                    switch screen {
                        case .home:
                            CharacterListDI(coordinator: coordinator).launch()
                        case .details(let character):
                            CharacterDetails(coordinator: coordinator)
                            .launch(character: character)
                    }
                   
                }
        }
    }
}
