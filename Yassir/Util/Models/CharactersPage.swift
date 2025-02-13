//
//  CharactersPage.swift
//  Yassir
//
//  Created by Ahmed Aly on 12/02/2025.
//

import Foundation

public struct CharacterPage: Codable {
    let info: PageInfo
    var results: [Character]
}

struct PageInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

public struct Character: Codable, Identifiable, Hashable {
    public let id: Int
    let name: String
    let image: String
    let status: CharacterStatus
    let species: String
    let gender: CharacterGender
    let location: LocationInfo
}

public enum CharacterStatus: String, Codable, CaseIterable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

enum CharacterGender: String, Codable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"
}

struct LocationInfo: Codable, Hashable {
    let name: String
    let url: String
}
