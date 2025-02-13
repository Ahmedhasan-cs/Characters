//
//  CharacterDetailsViewModel.swift
//  Yassir
//
//  Created by Ahmed Aly on 11/02/2025.
//

import Foundation

public protocol CharacterDetailsViewModeling: ObservableObject {
    var character: Character { get }
    func goBack()
}

class CharacterDetailsViewModel: CharacterDetailsViewModeling {
    var character: Character
    private var coordinator: AppCoordinator
    
    init(character: Character, coordinator: AppCoordinator) {
        self.character = character
        self.coordinator = coordinator
    }
    
    func goBack() {
        coordinator.goBack()
    }
}
