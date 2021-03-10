//
//  SimpleInterestView.swift
//  InterestCalculator
//
//  Created by Maxim Macari on 8/3/21.
//

import SwiftUI

struct SimpleInterestView: View {
    
    @ObservedObject var simpleInterestVM: SimpleCapitalizationVM = SimpleCapitalizationVM()
    
    var body: some View {
        VStack(spacing: 10){
            
            HStack{
                Text("Calculate simple interest".capitalized)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .autocapitalization(.sentences)
                
                Spacer()
            }
            .padding()
            
            
            ManifestCalculationView()
            
            VStack{
                switch simpleInterestVM.selectedPurpose {
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
            .padding(.horizontal)
            
            HStack(spacing: 5){
                Button(action: {
                    simpleInterestVM.clearInputs()
                }, label: {
                    Text("Clear")
                        .foregroundColor(Color.red.opacity(0.8))
                        .frame(width: UIScreen.main.bounds.width * 0.3)
                        .padding()
                        .background(Color.gray.opacity(0.15))
                        .cornerRadius(15)
                })
                
                
                Button(action: {
                    simpleInterestVM.calculate()
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
        .environmentObject(simpleInterestVM)
    }
    
    private struct OperationsView: View {
        @EnvironmentObject var simpleInteresVM: SimpleCapitalizationVM
        var body: some View {
            if !simpleInteresVM.answer.isEmpty{
                VStack{
                    HStack{
                        Text("Operations: ")
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    //Depends on each case, of what we want to calculate
                    ScrollView(.vertical, showsIndicators: false){
                        Text("\(simpleInteresVM.showOperations())")
                    }
                }
            } else{
                Spacer()
            }
        }
    }
    
    private struct AnswerView: View {
        
        @EnvironmentObject var simpleInteresVM: SimpleCapitalizationVM
        
        var body: some View{
            if !simpleInteresVM.answer.isEmpty{
                VStack(alignment: HorizontalAlignment.center, spacing: 0){
                    
                    HStack{
                        Text("Answer: ")
                            .fontWeight(.semibold)
                        
                        Spacer()
                    }
                    switch simpleInteresVM.selectedPurpose {
                    case Purpose.time:
                        Text("T = \(simpleInteresVM.answer)")
                            .foregroundColor(Color.black)
                            .fontWeight(.semibold)
                    case Purpose.rate:
                        Text("R = \(simpleInteresVM.answer)/year")
                    case Purpose.principal:
                        Text("Co = \(simpleInteresVM.answer)")
                    default:
                        Text("Cn = \(simpleInteresVM.answer)")
                            .foregroundColor(Color.black)
                            .fontWeight(.semibold)
                        
                        if let interest = simpleInteresVM.showInterest(){
                            if !interest.isEmpty{
                                Text("I = Cn - Co = \(interest)")
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                }
            }
            else {
                Spacer()
            }
        }
    }
    
    private struct CalculateAccruedView: View {
        
        @State var showTimeTypeSheet: Bool = false
        @EnvironmentObject var simpleInteresVM: SimpleCapitalizationVM
        
        var body: some View {
            VStack(spacing: 5){
                Text("Where \(Text("Cn = Co(1 + rt)").fontWeight(.semibold))")
                
                CustomTextField(name: "Principal", result: $simpleInteresVM.principal, keyBoardType: .decimalPad)
                
                CustomTextField(name: "Rate per year", result: $simpleInteresVM.rate, keyBoardType: .decimalPad)
                
                CustomTimePickerView(showTimeTypeSheet: showTimeTypeSheet, time: $simpleInteresVM.time)
            }
        }
    }
    
    private struct CalculateTimeView: View {
        
        @EnvironmentObject var simpleInteresVM: SimpleCapitalizationVM
        
        var body: some View {
            VStack(spacing: 5){
                Text("Where \(Text("Cn = (1/r)(Cn/Co - 1)").fontWeight(.semibold))")
                
                CustomTextField(name: "Principal", result: $simpleInteresVM.principal, keyBoardType: .decimalPad)
                
                CustomTextField(name: "Rate per year", result: $simpleInteresVM.rate, keyBoardType: .decimalPad)
                
                CustomTextField(name: "Accrued", result: $simpleInteresVM.accrued, keyBoardType: .decimalPad)
                
            }
        }
    }
    
    private struct CalculateRateView: View {
        
        @State var showTimeTypeSheet: Bool = false
        @EnvironmentObject var simpleInteresVM: SimpleCapitalizationVM
        
        var body: some View {
            VStack(spacing: 5){
                Text("Where \(Text("Cn = (1/t)(Cn/Co - 1)").fontWeight(.semibold))")
                
                CustomTextField(name: "Principal", result: $simpleInteresVM.principal, keyBoardType: .decimalPad)
                
                CustomTextField(name: "Accrued", result: $simpleInteresVM.accrued, keyBoardType: .decimalPad)
                
                CustomTimePickerView(showTimeTypeSheet: showTimeTypeSheet, time: $simpleInteresVM.time)
                
            }
        }
    }
    
    private struct CalculatePrincipalView: View {
        
        @State var showTimeTypeSheet: Bool = false
        @EnvironmentObject var simpleInteresVM: SimpleCapitalizationVM
        
        var body: some View {
            VStack(spacing: 5){
                Text("Where \(Text("Co = Cn / (1 + rt)").fontWeight(.semibold))")
                
                CustomTextField(name: "Accrued", result: $simpleInteresVM.accrued, keyBoardType: .decimalPad)
                
                CustomTextField(name: "rate", result: $simpleInteresVM.rate, keyBoardType: .decimalPad)
                
                CustomTimePickerView(showTimeTypeSheet: showTimeTypeSheet, time: $simpleInteresVM.time)
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



