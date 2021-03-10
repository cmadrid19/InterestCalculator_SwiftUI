//
//  Home.swift
//  InterestCalculator
//
//  Created by Maxim Macari on 8/3/21.
//

import SwiftUI



struct Home: View {
    
//    var kinds = ["Simple interest", "Compound interest", "Loans"]
    @State var selection = Tab.simple
    
    enum Tab: Int {
        case simple = 0
        case compound = 1
        case loan = 2
    }
    
    var body: some View {
        VStack{
            TabView(selection: $selection) {
                SimpleInterestView()
                    .tabItem() {
                        Label(
                            title: { Text("Simple interest")},
                            icon: { Image(systemName: "percent")})
                    }
                    .tag(Tab.simple)
                    
                CompoundInterestView()
                    .tabItem {
                        Label(
                            title: { Text("Compound interest") },
                            icon: { Image(systemName: "florinsign.circle")})
                    }
                    .tag(Tab.compound)
                LoanView()
                    .tabItem {
                        Label(
                            title: { Text("Loans") },
                            icon: { Image(systemName: "newspaper")})
                    }
                    .tag(Tab.loan)
            }
//            #warning("Declare main ObservableObject, on change tab clear inputs")
            .onChange(of: selection, perform: { value in
                print("tab: \(value)")
            })
        }
        
    }
}



struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
