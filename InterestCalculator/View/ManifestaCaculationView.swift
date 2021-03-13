//
//  Manifest.swift
//  InterestCalculator
//
//  Created by Maxim Macari on 10/3/21.
//

import SwiftUI

struct ManifestCalculationView: View {
   
    @AppStorage("selectedPupose") var selectedPurpose: Purpose = Purpose.accrued
    
    var body: some View {
        VStack(spacing: 0){
            Picker(selection: $selectedPurpose, label: Text(""), content: {
                Text("Accrued").tag(Purpose.accrued) // (principal + interest)
                Text("Time").tag(Purpose.time)
                Text("Rate").tag(Purpose.rate)
                Text("Principal").tag(Purpose.principal)
            })
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
        }
    }
}
struct ManifestCalculationView_Previews: PreviewProvider {
    static var previews: some View {
        ManifestCalculationView(selectedPurpose: Purpose.accrued)
    }
}
