//
//  CompoundInterestView.swift
//  InterestCalculator
//
//  Created by Maxim Macari on 8/3/21.
//

import SwiftUI

struct CompoundInterestView: View {
    
    @ObservedObject var simpleInterestVM: SimpleCapitalizationVM = SimpleCapitalizationVM()
    
    var body: some View {
        VStack(spacing: 10){
            
            HStack{
                Text("Calculate Compound interest".capitalized)
                    .font(.title)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                    .foregroundColor(.black)
                    .autocapitalization(.sentences)
                
                Spacer()
            }
            .padding()
            
            ManifestCalculationView()
            
            Spacer()
        }
        .environmentObject(simpleInterestVM)
    }
}

struct CompoundInterestView_Previews: PreviewProvider {
    static var previews: some View {
        CompoundInterestView()
    }
}
