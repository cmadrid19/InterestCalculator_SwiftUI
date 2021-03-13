//
//  CompoundInterestView.swift
//  InterestCalculator
//
//  Created by Maxim Macari on 8/3/21.
//

import SwiftUI

struct PeriodicCompoundInterestView: View {
    
    @EnvironmentObject var compoundVM: PeriodicCompoundVM
    @AppStorage("selectedPupose") var selectedPurpose: Purpose = Purpose.accrued
    
    var body: some View {
        VStack(spacing: 10){
            
//            HStack{
//                Text("Periodic Compound Interest".capitalized)
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .minimumScaleFactor(0.9)
//                    .lineLimit(1)
//                    .foregroundColor(.black)
//                    .autocapitalization(.sentences)
//                
//                Spacer()
//            }
//            .padding()
            
            ManifestCalculationView()
            
            VStack(spacing: 10){
                switch selectedPurpose {
                case Purpose.time:
                    CalculatePeriodView()
                case Purpose.rate:
                    CalculateRateView()
                case Purpose.principal:
                    CalculatePrincipalView()
                default:
                    CalculateAccruedView()
                }
            }
            .padding([.horizontal, .top])
            .onChange(of: compoundVM.selectedPurpose, perform: { _ in
                compoundVM.clearInputs()
            })
            
            HStack(spacing: 5){
                Button(action: {
                    compoundVM.clearInputs()
                }, label: {
                    Text("Clear")
                        .foregroundColor(Color.red.opacity(0.8))
                        .frame(width: UIScreen.main.bounds.width * 0.3)
                        .padding()
                        .background(Color.gray.opacity(0.15))
                        .cornerRadius(15)
                })
                
                
                Button(action: {
                    compoundVM.calculate()
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
                
            }
            .padding()
            
            Spacer()
        }
        
        
    }
    
    private struct AnswerView: View {
        
        @EnvironmentObject var compoundVM: PeriodicCompoundVM
        
        var body: some View{
            if !compoundVM.answer.isEmpty{
                VStack(alignment: HorizontalAlignment.center, spacing: 0){
                    
                    HStack{
                        Text("Answer: ")
                            .fontWeight(.semibold)
                        
                        Spacer()
                    }
                    
                    VStack(spacing: 0){
                        switch compoundVM.selectedPurpose {
                        case Purpose.time:
                            Text("\(compoundVM.answer)")
                                .fontWeight(.semibold)
                        case Purpose.rate:
                            Text("\(compoundVM.answer)")
                                .fontWeight(.semibold)
                        case Purpose.principal:
                            Text("\(compoundVM.answer)")
                                .fontWeight(.semibold)
                        default:
                            Text("\(compoundVM.answer)")
                                .fontWeight(.semibold)
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
        
        @State var showCompoundPickerSheet: Bool = false
        @EnvironmentObject var compoundVM: PeriodicCompoundVM
        
        var body: some View {
            VStack(spacing: 5){
                Text("Where \(Text("Cn = Co(1 + r)ᵀ").fontWeight(.semibold))")
                
                CustomTextField(name: "Principal", result: $compoundVM.principal, keyBoardType: .decimalPad)
                    
                VStack(spacing: 5){
                    CustomTextField(name: "Rate per period", result: $compoundVM.rate, keyBoardType: .decimalPad)
                    
                    CustomTextField(name: "Number of periods", result: $compoundVM.periods, keyBoardType: .decimalPad)
                    
                   
                }
            }
        }
    }
    
    private struct CalculatePeriodView: View {
        
        @EnvironmentObject var compoundVM: PeriodicCompoundVM
        
        var body: some View {
            VStack(spacing: 5){
                Text("Where \(Text("t = ln(Cn/Co) / ln(1 + r)").fontWeight(.semibold))")
                
                CustomTextField(name: "Principal", result: $compoundVM.principal, keyBoardType: .decimalPad)
                
                CustomTextField(name: "Accrued", result: $compoundVM.accrued, keyBoardType: .decimalPad)
                
                CustomTextField(name: "Rate per year", result: $compoundVM.rate, keyBoardType: .decimalPad)
            }
        }
    }
    
    private struct CalculateRateView: View {
        
        @State var showTimeTypeSheet: Bool = false
        @EnvironmentObject var compoundVM: PeriodicCompoundVM
        
        var body: some View {
            VStack(spacing: 5){
                
                Text("Where \(Text("r = (Cn/Co)^(1/t) - 1").fontWeight(.semibold))")
                
                CustomTextField(name: "Principal", result: $compoundVM.principal, keyBoardType: .decimalPad)
                
                CustomTextField(name: "Accrued", result: $compoundVM.accrued, keyBoardType: .decimalPad)
                
                CustomTextField(name: "Number of periods", result: $compoundVM.periods, keyBoardType: .decimalPad)
                
            }
        }
    }
    
    private struct CalculatePrincipalView: View {
        
        @State var showTimeTypeSheet: Bool = false
        @EnvironmentObject var compoundVM: PeriodicCompoundVM
        
        var body: some View {
            VStack(spacing: 5){
                Text("Where \(Text("Co = Cn / (1 + r)ᵀ").fontWeight(.semibold))")
                
                CustomTextField(name: "Accrued", result: $compoundVM.accrued, keyBoardType: .decimalPad)
                
                VStack(spacing: 5){
                    CustomTextField(name: "Rate per period", result: $compoundVM.rate, keyBoardType: .decimalPad)
                    
                    CustomTextField(name: "Number of periods", result: $compoundVM.periods, keyBoardType: .decimalPad)
                    
                    HStack(spacing: 0){
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(Color("notice-color"))
                        
                        Text("Rate and periods must be in the same unit.")
                            .font(.callout)
                            .foregroundColor(Color("notice-color").opacity(0.8))
                    }
                }
            }
        }
    }
}

struct CompoundInterestView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//private struct CustomCompoundPickerView: View {
//
//    @State var showCompoundSheet: Bool = false
//    @Binding var rate: String
//
//    //    @EnvironmentObject var simpleInteresVM: CommonVM
//    @AppStorage("compound") var selectedCompound: Compounds = Compounds.annually
//
//    var body: some View{
//        HStack(spacing: 5){
//            CustomTextField(name: "Rate", result: $rate, keyBoardType: .decimalPad)
//
//            Button(action: {
//                showCompoundSheet.toggle()
//            }, label: {
//                Text("<\(self.selectedCompound.rawValue)>")
//                    .foregroundColor(Color.gray)
//                    .frame(minWidth: UIScreen.main.bounds.width * 0.32)
//                    .lineLimit(1)
//                    .minimumScaleFactor(0.7)
//                    .padding()
//                    .background(Color.gray.opacity(0.15))
//                    .cornerRadius(15)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 15)
//                            .stroke(Color.blue.opacity(0.8), lineWidth: 1)
//                    )
//            })
//            .actionSheet(isPresented: $showCompoundSheet, content: {
//                ActionSheet(title: Text("Times"), message: Text("pick one"), buttons:
//                                getActionSheetTimeOptions()
//                )
//            })
//        }
//    }
//    private func getActionSheetTimeOptions() -> [ActionSheet.Button] {
//        var buttons: [ActionSheet.Button] = []
//        Compounds.allCases.forEach { (value) in
//            buttons.append(.default(Text("\(value.rawValue)")){
//                self.selectedCompound = value
//            })
//        }
//        return buttons
//    }
//}

//func showCompoundSummary() -> String {
//    var steps: String = ""
//    switch self.selectedPurpose {
//    case .time:
//        steps = "The time required to get a total amount of $ 1,123.00 from compound interest on a principal of $ 1,112.00 at an interest rate of 2% per year and compounded 24 times per year is 0.492 years. (about 0 years 6 months)"
//    case .rate:
//        steps = "The interest rate required to get a total amount of $ 10,000.00 from compound interest on a principal of $ 21.00 compounded 24 times per year over 2 years is 328.968% per year."
//    case .principal:
//        steps = "The principal investment required to geta total amount of $ 10,000.00 from compound interest at a rate of 2% per year compounded 12 times per year over 2 years is $ 9,608.21."
//    default: //accrued
//        steps = "The total amount accrued, principal plus interest, from compound interest on an original principal of $ 10,000.00 at a rate of 3.875% per year compounded 12 times per year over 7.5 years is $ 13,366.37."
//    }
//    return steps
//}
