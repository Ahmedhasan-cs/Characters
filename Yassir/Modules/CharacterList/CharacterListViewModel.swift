//
//  CharacterListViewModel.swift
//  Yassir
//
//  Created by Ahmed Aly on 11/02/2025.
//

import Foundation

class CharacterListViewModel: ObservableObject {
    private weak var coordinator: AppCoordinator?

    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }

    func showDetails() {
        coordinator?.goToScreen(.details(item: "SwiftUI & Coordinator"))
    }
}
