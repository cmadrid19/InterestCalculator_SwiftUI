//
//  Home.swift
//  InterestCalculator
//
//  Created by Maxim Macari on 8/3/21.
//

import SwiftUI



struct Home: View {
    
    enum Tab: Int, CaseIterable {
        case simple = 0
        case periodicCompound = 1
        case loan = 2
    }
    
    @ObservedObject var simpleVM = SimpleVM()
    @ObservedObject var compoundM = PeriodicCompoundVM()
    
    @AppStorage("homeTab") var homeTab: Tab = Tab.simple
    @State var minDragTranslation: CGFloat = 100
    
    @State var showMoreInfo: Bool = false
    
    var body: some View {
        VStack{
            TabView(selection: $homeTab) {
                NavigationView{
                    SimpleInterestView()
                        .navigationBarTitle(Text("Simple Interest"), displayMode: .automatic)
                        .navigationBarItems(trailing:
                                                navigationBarButton(showingSheet: $showMoreInfo)
                        )
                        .environmentObject(simpleVM)
                        .sheet(isPresented: $showMoreInfo){
                            InfoSheetView(infoSheet: simlpeInfoSheet)
                        }
                    
                }
                .tabItem() {
                    Label(
                        title: { Text("Simple interest")},
                        icon: { Image(systemName: "percent")})
                }
                .tag(Tab.simple)
                .highPriorityGesture(DragGesture().onEnded({self.handleSwipe(translation: $0.translation.width)}))
                
                NavigationView{
                    PeriodicCompoundInterestView()
                        .navigationBarTitle(Text("Periodic Compound"), displayMode: .automatic)
                        .navigationBarItems(trailing:
                                                navigationBarButton(showingSheet: $showMoreInfo)
                        )
                        .environmentObject(compoundM)
                        .sheet(isPresented: $showMoreInfo){
                            InfoSheetView(infoSheet: periodicCompoundInfoSheet)
                        }
                }
                .tabItem {
                    Label(
                        title: { Text("Compound interest") },
                        icon: { Image(systemName: "florinsign.circle")})
                }
                .tag(Tab.periodicCompound)
                .highPriorityGesture(DragGesture().onEnded({self.handleSwipe(translation: $0.translation.width)}))
                
                NavigationView{
                    RentView()
                        .navigationBarTitle(Text("Rents"), displayMode: .automatic)
                        .navigationBarItems(trailing:
                                                navigationBarButton(showingSheet: $showMoreInfo)
                        )
                        .sheet(isPresented: $showMoreInfo){
                            InfoSheetView(infoSheet: rentInfoSheet)
                        }
                }
                .tabItem {
                    Label(
                        title: { Text("Loans") },
                        icon: { Image(systemName: "newspaper")})
                }
                .tag(Tab.loan)
                .highPriorityGesture(DragGesture().onEnded({self.handleSwipe(translation: $0.translation.width)}))
            }
        }
        .onChange(of: homeTab, perform: { value in
            print("HomeTab: \(value)")
        })
        
    }
    
    private struct InfoSheetView: View {
        
        var infoSheet: SheetData
        
        var body: some View{
            
            ScrollView{
                Text("Additional information")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding([.horizontal, .top])
                
                VStack{
                    
                    if (!self.infoSheet.definition.isEmpty){
                        Text("\(self.infoSheet.definition)")
                    }
                    

                    if (!self.infoSheet.legends.isEmpty){
                        Divider()

                        
                        VStack(alignment: .leading, spacing: 5){
                            ForEach(self.infoSheet.legends, id: \.self){ value in
                                Text("\(value)")
                                    .font(.footnote)
                            }
                        }
                    }
                    
                    if(!self.infoSheet.notes.isEmpty){
                        Divider()

                        VStack(alignment: .leading, spacing: 5){

                            HStack{
                                Image(systemName: "exclamationmark.triangle.fill")

                                Text("Notes")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(Color("notice-color").opacity(0.8))


                            ForEach(self.infoSheet.notes, id: \.self){ value in
                                Text("\(value)")
                                    .font(.footnote)
                            }

                        }
                        .font(.callout)
                    }
                }
                .padding()
            }
        }
    }
    
    private struct navigationBarButton: View{
        @Binding var showingSheet: Bool
        var body: some View{
            Button(action: {
                withAnimation(.easeOut){
                    self.showingSheet.toggle()
                }
            }, label: {
                HStack{
                    Image(systemName: "info.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.white)
                        .scaledToFill()
                }
                .padding(6)
                .background(Color.blue)
                .clipShape(Circle())
            })
        }
    }
    
    private func handleSwipe(translation: CGFloat) {
        if translation > minDragTranslation && homeTab.rawValue > 0 {
            //one tab back
            self.homeTab = self.moveIntoTab(value: self.homeTab.rawValue - 1)
        } else if translation < -minDragTranslation && homeTab.rawValue < Tab.allCases.count - 1{
            //one tab forward
            self.homeTab = self.moveIntoTab(value: self.homeTab.rawValue + 1)
        }
    }
    
    private func moveIntoTab(value: Int) -> Tab{
        switch value {
        case 1:
            return Tab.periodicCompound
        case 2:
            return Tab.loan
        default:
            return Tab.simple
        }
    }
    
    
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
