//
//  SimpleInterestView.swift
//  InterestCalculator
//
//  Created by Maxim Macari on 8/3/21.
//

import SwiftUI

struct SimpleInterestView: View {
    
    @EnvironmentObject var simpleVM: SimpleVM
    @AppStorage("selectedPupose") var selectedPurpose: Purpose = Purpose.accrued
    
    var body: some View {
        VStack(spacing: 10){
            
//            HStack{
//                Text("Simple Interest".capitalized)
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .foregroundColor(.black)
//                    .autocapitalization(.sentences)
//                
//                Spacer()
//            }
//            .padding()
            
            ManifestCalculationView()
            
            VStack(spacing: 0){
                switch selectedPurpose {
                case Purpose.time:
                    CalculateTimeView()
                case Purpose.rate:
                    CalculateRateView()
                case Purpose.principal:
                    CalculatePrincipalView()
                default:
                    CalculateAccruedView()
                }
            }
            .padding([.horizontal, .top])
            .onChange(of: simpleVM.selectedPurpose, perform: { _ in
                simpleVM.clearInputs()
            })
            
            HStack(spacing: 5){
                Button(action: {
                    simpleVM.clearInputs()
                }, label: {
                    Text("Clear")
                        .foregroundColor(Color.red.opacity(0.8))
                        .frame(width: UIScreen.main.bounds.width * 0.3)
                        .padding()
                        .background(Color.gray.opacity(0.15))
                        .cornerRadius(15)
                })
                
                
                Button(action: {
                    simpleVM.calculate()
                    UIApplication.shared.hideKeyboard()
                }, label: {
                    HStack{
                        Text("Calculate")
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.3)
                    .padding()
                    .background(Color.gray.opacity(0.15))
                    .cornerRadius(15)
                    
                })
                .buttonStyle(DefaultButtonStyle())
            }
            
            VStack(spacing: 5){
                //Answer
                AnswerView()
                
                //Operations
                OperationsView()
                
            }
            .padding()
        }
        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
    }
    
    private struct OperationsView: View {
        @EnvironmentObject var simpleVM: SimpleVM
        var body: some View {
            if !simpleVM.answer.isEmpty{
                VStack{
                    HStack{
                        Text("Operations: ")
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    //Depends on each case, of what we want to calculate
                    ScrollView(.vertical, showsIndicators: false){
                        Text("\(simpleVM.showSimpleOperations())")
                    }
                }
            } else{
                Spacer()
            }
        }
    }
    
    private struct AnswerView: View {
        
        @EnvironmentObject var simpleVM: SimpleVM
        
        var body: some View{
            if !simpleVM.answer.isEmpty{
                VStack(alignment: HorizontalAlignment.center, spacing: 0){
                    
                    HStack{
                        Text("Answer: ")
                            .fontWeight(.semibold)
                        
                        Spacer()
                    }
                    
                    VStack(spacing: 0){
                        switch simpleVM.selectedPurpose {
                        case Purpose.time:
                            Text("T = \(simpleVM.answer)")
                                .fontWeight(.semibold)
                        case Purpose.rate:
                            Text("R = \(simpleVM.answer)/year")
                                .fontWeight(.semibold)
                        case Purpose.principal:
                            Text("Co = \(simpleVM.answer)")
                                .fontWeight(.semibold)
                        default:
                            Text("Cn = \(simpleVM.answer)")
                                .fontWeight(.semibold)
                            if let interest = simpleVM.showInterest(){
                                if !interest.isEmpty{
                                    Text("I = Cn - Co = \(interest)")
                                        .fontWeight(.semibold)
                                }
                            }
                        }
                    }
                    .foregroundColor(Color.black)
                }
            }
            else {
                Spacer()
            }
        }
    }
    
    private struct CalculateAccruedView: View {
        
        @State var showTimeTypeSheet: Bool = false
        @EnvironmentObject var simpleVM: SimpleVM
        
        var body: some View {
            VStack(spacing: 5){
                Text("Where \(Text("Cn = Co(1 + rt)").fontWeight(.semibold))")
                
                CustomTextField(name: "Principal", result: $simpleVM.principal, keyBoardType: .decimalPad)
                
                CustomTextField(name: "Rate per year", result: $simpleVM.rate, keyBoardType: .decimalPad)
                
                CustomTimePickerView(showTimeTypeSheet: showTimeTypeSheet, time: $simpleVM.time)
            }
        }
    }
    
    private struct CalculateTimeView: View {
        
        @EnvironmentObject var simpleVM: SimpleVM
        
        var body: some View {
            VStack(spacing: 5){
                Text("Where \(Text("Cn = (1/r)(Cn/Co - 1)").fontWeight(.semibold))")
                
                CustomTextField(name: "Principal", result: $simpleVM.principal, keyBoardType: .decimalPad)
                
                CustomTextField(name: "Rate per year", result: $simpleVM.rate, keyBoardType: .decimalPad)
                
                CustomTextField(name: "Accrued", result: $simpleVM.accrued, keyBoardType: .decimalPad)
                
            }
        }
    }
    
    private struct CalculateRateView: View {
        
        @State var showTimeTypeSheet: Bool = false
        @EnvironmentObject var simpleVM: SimpleVM
        
        var body: some View {
            VStack(spacing: 5){
                Text("Where \(Text("r = (1/t)(Cn/Co - 1)").fontWeight(.semibold))")
                
                CustomTextField(name: "Principal", result: $simpleVM.principal, keyBoardType: .decimalPad)
                
                CustomTextField(name: "Accrued", result: $simpleVM.accrued, keyBoardType: .decimalPad)
                
                CustomTimePickerView(showTimeTypeSheet: showTimeTypeSheet, time: $simpleVM.time)
                
            }
        }
    }
    
    private struct CalculatePrincipalView: View {
        
        @State var showTimeTypeSheet: Bool = false
        @EnvironmentObject var simpleVM: SimpleVM
        
        var body: some View {
            VStack(spacing: 5){
                Text("Where \(Text("Co = Cn / (1 + rt)").fontWeight(.semibold))")
                
                CustomTextField(name: "Accrued", result: $simpleVM.accrued, keyBoardType: .decimalPad)
                
                CustomTextField(name: "rate", result: $simpleVM.rate, keyBoardType: .decimalPad)
                
                CustomTimePickerView(showTimeTypeSheet: showTimeTypeSheet, time: $simpleVM.time)
            }
        }
    }
}


struct SimpleInterestView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum Purpose: Int{
    case accrued = 0
    case time = 1
    case rate = 2
    case principal = 3
}



