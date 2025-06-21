//
//  GenreCell.swift
//  Jahez_Task
//
//  Created by Omnia Samy on 18/06/2025.
//

import SwiftUI

struct GenreCell: View {
    
    let genreModel: GenreModel?
    let isSelected: Bool?
    
    var body: some View {
        Text(genreModel?.name ?? "")
            .font(.system(size: 14, weight: .medium))
            .foregroundColor( (isSelected ?? false) ? .white : .red)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background( (isSelected ?? false) ? Color.red : Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.red, lineWidth: 2)
            )
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    GenreCell(genreModel: GenreModel(id: 1, name: "Action"), isSelected: false)
}
