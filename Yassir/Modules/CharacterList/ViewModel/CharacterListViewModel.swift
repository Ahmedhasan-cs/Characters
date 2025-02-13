//
//  CharacterListViewModel.swift
//  Yassir
//
//  Created by Ahmed Aly on 11/02/2025.
//

import Foundation

public protocol CharacterListViewModeling: ObservableObject, BaseViewModel {
    associatedtype Repo
    var repo : Repo {get set}
    var characters: [Character] { get }
    var selectedStatus: CharacterStatus? { get }
    func navigateToCharacterDetails(character: Character)
    func fetchCharacterPage()
    func fetchMoreCharacters(character: Character)
    func setSelectedFilterationStatus(status: CharacterStatus?)
}

class CharacterListViewModel: CharacterListViewModeling {
    internal var repo: CharacterListReposing
    private var coordinator: AppCoordinator
    private var pageInfo: PageInfo?
    @Published var characters: [Character] = []
    @Published var selectedStatus: CharacterStatus?
    
    init(repo: CharacterListReposing, coordinator: AppCoordinator, pageInfo: PageInfo? = nil){
        self.repo = repo
        self.coordinator = coordinator
        self.pageInfo = pageInfo
    }
    
    func navigateToCharacterDetails(character: Character) {
        coordinator.goToScreen(.details(character: character))
    }
    
    func fetchMoreCharacters(character: Character) {
        if self.characters.last?.id != character.id {
            return
        }
        
        if let nextURL = self.pageInfo?.next {
            self.repo.fetchCharacterList(service: .characterNextPage(nextURL), data: nil) {[weak self] (result: Result<CharacterPage,Error>) in
                switch result{
                case .success(let page):
                    self?.pageInfo = page.info
                    DispatchQueue.main.async {
                        self?.characters.append(contentsOf: page.results)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func fetchCharacterPage() {
        var params: [String: Any] = [:]
        if let status = selectedStatus {
            params = ["status": status.rawValue]
        }
        self.repo.fetchCharacterList(service: .characterList, data: params) {[weak self] (result: Result<CharacterPage,Error>) in
            switch result{
            case .success(let page):
                self?.pageInfo = page.info
                DispatchQueue.main.async {
                    self?.characters = page.results
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setSelectedFilterationStatus(status: CharacterStatus?) {
        self.selectedStatus = status
        self.characters = []
        self.pageInfo = nil
        fetchCharacterPage()
    }
}
