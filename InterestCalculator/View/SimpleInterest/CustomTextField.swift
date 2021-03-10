//
//  CustomTextField.swift
//  InterestCalculator
//
//  Created by Maxim Macari on 9/3/21.
//

import SwiftUI

#warning("TODO: validate textfields, do not allow negative inputs")
struct CustomTextField: View {
    
    var name: String
    @Binding var result: String
    var keyBoardType: UIKeyboardType
    
    var body: some View {
        HStack{
            Text("\(name):")
            TextField("Insert the \(name.lowercased())...", text: $result)
                .keyboardType(keyBoardType)
        }
        .padding(15)
        .background(Color.gray.opacity(0.15))
        .cornerRadius(15)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(name: "Principal", result: .constant(""), keyBoardType: .decimalPad)
    }
}
