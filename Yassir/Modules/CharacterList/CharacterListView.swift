//
//  CharacterListView.swift
//  Yassir
//
//  Created by Ahmed Aly on 11/02/2025.
//

import SwiftUI

struct CharacterListView: View {
    @ObservedObject var viewModel: CharacterListViewModel
    var body: some View {
        VStack {
           Text("Home Screen")
           Button("Go to Details") {
               viewModel.showDetails()
           }
        }
    }
}
//
//#Preview {
//    CharacterListView()
//}
