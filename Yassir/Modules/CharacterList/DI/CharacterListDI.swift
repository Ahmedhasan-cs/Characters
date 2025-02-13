//
//  ListOfMoviesLauncher.swift
//  Movies_V2
//
//  Created by Ahmed Aly on 05/03/2024.
//

import Foundation


protocol CharacterListDIProtocol {
    func launch() -> CharacterListView<CharacterListViewModel>
    var coordinator: AppCoordinator { get }
}

struct CharacterListDI: CharacterListDIProtocol {
    var coordinator: AppCoordinator

    func launch() -> CharacterListView<CharacterListViewModel> {
        let repo: CharacterListReposing = CharacterListRepo()
        let viewModel = CharacterListViewModel(repo: repo, coordinator: coordinator)
        return CharacterListView(viewModel: viewModel)
    }
}
