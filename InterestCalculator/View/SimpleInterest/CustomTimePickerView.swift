//
//  TimePickerView.swift
//  InterestCalculator
//
//  Created by Maxim Macari on 9/3/21.
//

import SwiftUI

struct CustomTimePickerView: View {
    
    @State var showTimeTypeSheet: Bool = false
    @Binding var time: String

    @EnvironmentObject var simpleInteresVM: SimpleCapitalizationVM
    
    var body: some View{
        HStack(spacing: 5){
            CustomTextField(name: "Time", result: $time, keyBoardType: .decimalPad)
            
            Button(action: {
                showTimeTypeSheet.toggle()
            }, label: {
                Text("<\(simpleInteresVM.selectedTimeType.rawValue)>")
                    .foregroundColor(Color.gray)
                    .frame(minWidth: UIScreen.main.bounds.width * 0.28)
                    .padding()
                    .background(Color.gray.opacity(0.15))
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.blue.opacity(0.8), lineWidth: 1)
                        //                                    .shadow(color: .blue, radius: 20, x: 2, y: 2)
                        //                                    .shadow(color: .blue, radius: 20, x: -2, y: -2)
                    )
            })
            .actionSheet(isPresented: $showTimeTypeSheet, content: {
                ActionSheet(title: Text("Times"), message: Text("pick one"), buttons:
                                getActionSheetTimeOptions()
                )
            })
        }
    }
    
    private func getActionSheetTimeOptions() -> [ActionSheet.Button] {
        var buttons: [ActionSheet.Button] = []
        TimeTypes.allCases.forEach { (value) in
            buttons.append(.default(Text("\(value.rawValue)")){
                simpleInteresVM.selectedTimeType = value
            })
        }
        return buttons
    }
}

struct CustomTimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTimePickerView(showTimeTypeSheet: false, time: .constant(""))
    }
}
