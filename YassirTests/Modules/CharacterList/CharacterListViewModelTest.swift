//
//  CharacterListViewModelTest.swift
//  YassirTests
//
//  Created by Ahmed Aly on 13/02/2025.
//

import XCTest
@testable import Yassir

class CharacterListViewModelTests: XCTestCase {
    
    var viewModel: CharacterListViewModel!
    var repo: CharacterListRepo!
    var networkSession: NetworkSessionMock!
    var endPointsManager: EndPointsManager!
    var apiHandler: APIHandling!
    var mockCoordinator: MockAppCoordinator!
    
    override func setUpWithError() throws {
        networkSession = NetworkSessionMock()
        endPointsManager = EndPointsManager(session: networkSession)
        apiHandler = APIHandler(manager: endPointsManager)
        repo = CharacterListRepo(networkManager: apiHandler)
        mockCoordinator = MockAppCoordinator()
        viewModel = CharacterListViewModel(repo: repo, coordinator: mockCoordinator)
    }

    override func tearDownWithError() throws {
        apiHandler = nil
        endPointsManager = nil
        networkSession = nil
        repo = nil
        mockCoordinator = nil
        apiHandler = nil
    }
    
    func testFetchCharacterPage_Success() {
        // Given: Mock repository returns character data
        let fixtureData = DataFixtures.charactersDataSuccessful
        networkSession.data = fixtureData
        networkSession.error = nil
       
        let expectation = XCTestExpectation(description: "Fetch character page completes")
        viewModel.fetchCharacterPage()
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(self.viewModel.characters.count, 20)
            XCTAssertEqual(self.viewModel.characters[0].name, "Rick Sanchez")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchCharacterPage_Failure() {
        let fixtureData = DataFixtures.charactersDataFailure
        networkSession.data = fixtureData
        networkSession.error = nil
        
        let expectation = self.expectation(description: "Fetch character page Failure")
        viewModel.fetchCharacterPage()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(self.viewModel.characters.count, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchMoreCharacters_AppendsNewData() {
        // Given
        let initialCharacter = Character(id: 0, name: "Mark", image: "", status:.alive , species: "", gender: .female, location: LocationInfo(name: "", url: ""))
        let pageInfo = PageInfo(count: 826, pages: 42, next: "https://rickandmortyapi.com/api/character?page=3", prev: "https://rickandmortyapi.com/api/character?page=1")
        viewModel = CharacterListViewModel(repo: repo, coordinator: mockCoordinator, pageInfo: pageInfo)
        viewModel.characters = [initialCharacter]
      
        
        let fixtureData = DataFixtures.charactersDataNextPageSuccessful
        networkSession.data = fixtureData
        networkSession.error = nil
        
        let expectation = XCTestExpectation(description: "Fetch more character page completes")
        viewModel.fetchMoreCharacters(character: initialCharacter)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(self.viewModel.characters.count, 21)
            XCTAssertEqual(self.viewModel.characters.last?.name, "Beth")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        
    }
    
    func testFetchMoreCharacters_NoNextPage() {
        viewModel = CharacterListViewModel(repo: repo, coordinator: mockCoordinator, pageInfo: nil)
        
        let initialCharacter = Character(id: 0, name: "Mark", image: "", status:.alive , species: "", gender: .female, location: LocationInfo(name: "", url: ""))
        viewModel.characters = [initialCharacter]
        viewModel.fetchMoreCharacters(character: initialCharacter)
        XCTAssertEqual(viewModel.characters.count, 1)
    }
    
    func testNavigateToCharacterDetails() {
        let character = Character(id: 0, name: "Rick", image: "", status:.alive , species: "", gender: .female, location: LocationInfo(name: "", url: ""))
        viewModel.navigateToCharacterDetails(character: character)
        XCTAssertEqual(mockCoordinator.lastNavigatedCharacter?.name, "Rick")
    }
    
    func testSetSelectedFilterationStatus() {
        // Given
        let status: CharacterStatus = .alive
        let fixtureData = DataFixtures.CharactersListAliveSuccessful
        networkSession.data = fixtureData
        networkSession.error = nil
        let expectation = XCTestExpectation(description: "Fetch alive characters completes")
        viewModel.setSelectedFilterationStatus(status: status)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(self.viewModel.selectedStatus, status)
            XCTAssertEqual(self.viewModel.characters.first?.status, .alive)
            XCTAssertEqual(self.viewModel.characters.last?.status, .alive)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}


// MARK: - Mock Coordinator
class MockAppCoordinator: AppCoordinator {
    var lastNavigatedCharacter: Character?

    override func goToScreen(_ screen: AppScreen) {
        if case let .details(character) = screen {
            lastNavigatedCharacter = character
        }
    }
}

