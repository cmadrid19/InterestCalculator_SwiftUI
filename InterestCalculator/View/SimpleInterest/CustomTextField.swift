//
//  CustomTextField.swift
//  InterestCalculator
//
//  Created by Maxim Macari on 9/3/21.
//

import SwiftUI

struct CustomTextField: View {
    
    var name: String
    @Binding var result: String
    var keyBoardType: UIKeyboardType
    
    var body: some View {
        HStack{
            Text("\(name):")
            TextField("Insert the \(name.lowercased())...", text: $result)
                .frame(height: 40)
                .keyboardType(keyBoardType)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 5)
        .background(Color.gray.opacity(0.15))
        .mask(RoundedRectangle(cornerRadius: 15))
        .hideKeyboardOnTapAround()
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(name: "Principal", result: .constant(""), keyBoardType: .decimalPad)
    }
}
