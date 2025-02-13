//
//  CharacterListView.swift
//  Yassir
//
//  Created by Ahmed Aly on 11/02/2025.
//

import SwiftUI

struct CharacterListView<T: CharacterListViewModeling>: View {
    @StateObject var viewModel: T
    var body: some View {
        VStack {
            FilterOptionsView(viewModel: viewModel)
            List(viewModel.characters, id: \.id) { character in
                CharacterItemView(character: character)
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        self.viewModel.navigateToCharacterDetails(character: character)
                    }
                    .onAppear {
                        viewModel.fetchMoreCharacters(character: character)
                    }
            }

            .refreshable {
                self.viewModel.fetchCharacterPage()
            }
            .listStyle(.plain)
        }
        .onAppear {
            self.viewModel.fetchCharacterPage()
        }
        .navigationTitle("Characters")
    }
}
//
//#Preview {
//    CharacterListView()
//}
