//
//  ListOfMoviesLauncher.swift
//  Movies_V2
//
//  Created by Ahmed Aly on 05/03/2024.
//

import Foundation


protocol CharacterDetailsProtocol {
    func launch(character: Character) -> CharacterDetailsView<CharacterDetailsViewModel>
    var coordinator: AppCoordinator { get }
}

struct CharacterDetails: CharacterDetailsProtocol {
    var coordinator: AppCoordinator

    func launch(character: Character) -> CharacterDetailsView<CharacterDetailsViewModel> {
        let viewModel = CharacterDetailsViewModel(character: character, coordinator: coordinator)
        return CharacterDetailsView(viewModel: viewModel)
    }
}
