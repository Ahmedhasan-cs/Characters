//
//  APIHandlerTest.swift
//  YassirTests
//
//  Created by Ahmed Aly on 13/02/2025.
//

import XCTest

final class APIHandlerTests: XCTestCase {
    
    var networkSession: NetworkSessionMock!
    var endPointsManager: EndPointsManager!
    var apiHandler: APIHandling!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        networkSession = NetworkSessionMock()
        endPointsManager = EndPointsManager(session: networkSession)
        apiHandler = APIHandler(manager: endPointsManager)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        apiHandler = nil
        endPointsManager = nil
        networkSession = nil
        try super.tearDownWithError()
    }
    
    // Test successful API response decoding
    func testExecuteQuerySuccess() {
        let fixtureData = DataFixtures.charactersDataSuccessful
        networkSession.data = fixtureData
        networkSession.error = nil
        let expectation = self.expectation(description: "Successful API Response")

        apiHandler.executeQuery(service: .characterList, data: nil, method: .GET) { (result: Result<CharacterPage, Error>) in
            switch result {
            case .success(let character):
                XCTAssertEqual(character.info.count, 826)
                XCTAssertEqual(character.results.count, 20)
            case .failure:
                XCTFail("Expected success, got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testExecuteQueryDecodingFailure() {
        let fixtureData = DataFixtures.charactersDataFailure
        networkSession.data = fixtureData
        networkSession.error = nil
        
        let expectation = self.expectation(description: "Decoding Failure")
        
        apiHandler.executeQuery(service: .characterList, data: nil, method: .GET) { (result: Result<CharacterPage, Error>) in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure:
                XCTAssertTrue(true) // Expected path
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
        // Test failure case due to network error
    func testExecuteQueryNetworkFailure() {
        networkSession.error = NSError(domain: "NetworkError", code: 404, userInfo: nil)
        
        let expectation = self.expectation(description: "Network Failure")
        
        apiHandler.executeQuery(service: .characterList, data: nil, method: .GET) { (result: Result<CharacterPage, Error>) in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertNotNil(error) // Expected path
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}


//}
