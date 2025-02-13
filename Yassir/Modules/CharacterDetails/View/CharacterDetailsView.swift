//
//  CharacterDetails.swift
//  Yassir
//
//  Created by Ahmed Aly on 11/02/2025.
//

import SwiftUI

struct CharacterDetailsView<T: CharacterDetailsViewModeling>: View {
    @StateObject var viewModel: T
    
    var body: some View {
        VStack(spacing: 0) {
            headerView
            contentView
        }
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.top)
    }
    
    var headerView: some View {
        ZStack(alignment: .topLeading) {
            AsyncImage(url: URL(string: viewModel.character.image)) { image in
                image.resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(height: 350)
            .clipShape(RoundedCornerShape(corners: [.bottomRight, .bottomLeft], radius: 30))


            Button(action: { viewModel.goBack() }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.black)
                    .padding()
                    .background(Circle().fill(Color.white))
            }
            .padding(.leading, 16)
            .padding(.top, 50)
        }
    }
    
    var contentView: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Text(viewModel.character.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Text(viewModel.character.status.rawValue)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.cyan)
                            .clipShape(Capsule())
                    }
                    .padding(.trailing, 16)
                }
            }
            HStack {
                Text("\(viewModel.character.species) • ")
                    .foregroundColor(.black)
                    .font(.subheadline)
                
                Text("\(viewModel.character.gender.rawValue)")
                    .foregroundColor(.gray)
                    .font(.subheadline)
            }
            HStack {
                Text("Location:")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Text(viewModel.character.location.name)
                    .foregroundColor(.black)
            }.padding(.top, 20)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct RoundedCornerShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

//#Preview {
//    CharacterDetailsView()
//}
