//
//  SwiftUIView.swift
//  Yassir
//
//  Created by Ahmed Aly on 12/02/2025.
//

import SwiftUI

struct FilterOptionsView<T: CharacterListViewModeling>: View {
    @ObservedObject var viewModel: T

    var body: some View {
        HStack(spacing: 12) {
            ForEach(CharacterStatus.allCases, id: \.self) { status in
                Button(action: { toggleSelection(status) }) {
                    Text(status.rawValue)
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(.black)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(viewModel.selectedStatus == status ? Color.purple.opacity(0.2) : Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                        .clipShape(Capsule())
                }
            }
            Spacer()
        }
        .padding()
    }

    private func toggleSelection(_ status: CharacterStatus) {
        let status: CharacterStatus? = (viewModel.selectedStatus == status) ? nil : status
        self.viewModel.setSelectedFilterationStatus(status: status)
    }
}
//#Preview {
//    filterOptionsView()
//}
