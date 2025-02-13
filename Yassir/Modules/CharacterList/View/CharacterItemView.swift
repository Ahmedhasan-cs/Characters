//
//  Item.swift
//  DemoApp
//
//  Created by Ahmed Aly on 03/06/2023.
//

import SwiftUI

struct CharacterItemView: View {
    var character: Character
    var backgroundColor: Color {
            switch character.status {
            case .alive: return Color.white
            case .unknown: return Color.blue.opacity(0.1)
            case .dead: return Color.red.opacity(0.1)
            }
        }

    var body: some View {
        HStack(spacing: 10) {
            AsyncImage(url: URL(string: character.image)) { image in
                image.resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 70, height: 70)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.2), lineWidth: 1))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(character.name)
                    .font(.title3).bold()
                    .foregroundColor(.black)
                
                Text(character.species)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
            }
            
            Spacer()
        }
        .padding()
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .imageModifier(showBorder: character.status == .alive)
        .frame(height: 90, alignment: Alignment.trailing)
    }
}


extension View {
    @ViewBuilder
    func imageModifier(showBorder: Bool) -> some View {
        if showBorder {
            self.overlay(RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1))
        } else {
            self
        }
    }
}


   
