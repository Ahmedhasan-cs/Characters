//
//  CharacterDetails.swift
//  Yassir
//
//  Created by Ahmed Aly on 11/02/2025.
//

import SwiftUI

struct CharacterDetailsView: View {
    var coordinator: AppCoordinator
    
    var body: some View {
        VStack {
            Text("Detail Screen:")
            Button("Back") {
                coordinator.goBack()
            }
        }
    }
    
}

//#Preview {
//    CharacterDetailsView()
//}
