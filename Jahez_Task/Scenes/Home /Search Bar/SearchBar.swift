//
//  SearchBar.swift
//  Jahez_Task
//
//  Created by Omnia Samy on 19/06/2025.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    var placeholder: String = "Search..."
    
    var onClear: (() -> Void)? = nil
    
    var body: some View {
        
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField(placeholder, text: $text)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            if !text.isEmpty {
                Button(action: {
                    text = ""
                    onClear?()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}
