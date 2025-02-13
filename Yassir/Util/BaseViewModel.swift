//
//  BaseViewModel.swift
//  Yassir
//
//  Created by Ahmed Aly on 12/02/2025.
//

public protocol BaseViewModel {
    associatedtype Repo
    var repo : Repo {get set}
}
