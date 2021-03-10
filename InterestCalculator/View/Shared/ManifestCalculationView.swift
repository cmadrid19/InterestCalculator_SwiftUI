//
//  ManifestCalculationView.swift
//  InterestCalculator
//
//  Created by Maxim Macari on 10/3/21.
//

import SwiftUI

struct ManifestCalculationView: View {
    
    @EnvironmentObject var simpleInteresVM: SimpleCapitalizationVM
    
    var body: some View {
        VStack(spacing: 0){
            Picker(selection: $simpleInteresVM.selectedPurpose, label: Text(""), content: {
                Text("Accrued").tag(Purpose.accrued) // (principal + interest)
                Text("Time").tag(Purpose.time)
                Text("Rate").tag(Purpose.rate)
                Text("Principal").tag(Purpose.principal)
            })
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            .onChange(of: simpleInteresVM.selectedPurpose, perform: { value in
                //                TODO cleear only on one input for each select, recover the input if goese back
                simpleInteresVM.clearInputs()
                print(value)
            })
        }
    }
}
struct ManifestCalculationView_Previews: PreviewProvider {
    static var previews: some View {
        ManifestCalculationView()
    }
}
