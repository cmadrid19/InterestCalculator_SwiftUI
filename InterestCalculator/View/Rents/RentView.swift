//
//  RentView.swift
//  InterestCalculator
//
//  Created by Maxim Macari on 9/3/21.
//

import SwiftUI

struct RentView: View {
    var body: some View {
        VStack{
            RentTypePickerView()
            
            Spacer()
        }
    }
}


let durations: [String] = ["temporary", "perpetual"]
let payMoments: [String] = ["inmediate", "deferred", "anticipated"]
let modifiers: [String] = ["prepayable", "postpayable"]

struct RentView_Previews: PreviewProvider {
    static var previews: some View {
        RentView()
    }
}

private struct RentTypePickerView: View{
    
    @State var selectedDuration: RentType.Duration = RentType.Duration.temporary
    @State var selectedPayCondition: RentType.PayCondition = RentType.PayCondition.deferred
    @State var selectedPayMoment: RentType.PayMoment  = RentType.PayMoment.prepayable
    
    @State var showingEdit: Bool = false
    @State var offset: CGFloat = 0
    
    var body: some View {
        
        VStack{
            VStack(spacing: 0){
                
                HStack{
                    Text("Types: ")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.easeIn){
                            self.showingEdit.toggle()
                        }
                    }, label: {
                        Image(systemName: self.showingEdit ? "xmark.circle" : "square.and.pencil")
                            .resizable()
                            .foregroundColor(self.showingEdit ? Color.red : Color.blue)
                            .frame(width: 20, height: 20)
                            .padding(.horizontal)
                    })
                    .padding(.vertical, 10)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(15)
                    .padding(10)
                    
                }
                
                HStack(alignment: .center, spacing: 5){
                    
                    Text("\(selectedDuration.rawValue)")
                        .frame(minWidth: getWidth() * 0.25)
                        .padding(5)
                        .background(getIndex() < 1 ? Color.blue.opacity(0.5) : Color.clear)
                        .cornerRadius(15)
                    
                    Image(systemName: "chevron.right")
                    
                    Text("\(selectedPayCondition.rawValue)")
                        .frame(minWidth: getWidth() * 0.25)
                        .padding(5)
                        .background(getIndex() == 1 ? Color.blue.opacity(0.5) : Color.clear)
                        .cornerRadius(15)
                    
                    Image(systemName: "chevron.right")
                    
                    Text("\(selectedPayMoment.rawValue)")
                        .frame(minWidth: getWidth() * 0.25)
                        .padding(5)
                        .background(getIndex() > 1 ? Color.blue.opacity(0.5) : Color.clear)
                        .cornerRadius(15)
                    
                }
                .font(.callout)
                .padding(.bottom, 10)
                .padding(.horizontal, 20)
                .foregroundColor(Color.black.opacity(0.8))
                
                ScrollView {
                    TabView{
                        Picker(selection: self.$selectedDuration, label: Text("Durations")) {
                            
                            ForEach(RentType.Duration.allCases, id: \.self) { duration in
                                Text("\(duration.rawValue)")
                                    .font(.callout)
                            }
                        }
                        
                        .overlay(
                            //geometry reader for getting offset
                            GeometryReader{ reader -> Color in
                                let minX = reader.frame(in: .global).minX
                                
                                DispatchQueue.main.async {
                                    withAnimation(.default){
                                        self.offset = -minX
                                    }
                                }
                                
                                return Color.clear
                            }
                            .frame(width: 0, height: 0)
                            ,alignment: .leading
                        )
                        
                        Picker(selection: self.$selectedPayMoment, label: Text("Pay moments")) {
                            ForEach(RentType.PayCondition.allCases, id:\.self) { modifier in
                                Text("\(modifier.rawValue)")
                                    .font(.callout)
                            }
                        }
                        
                        Picker(selection: self.$selectedPayCondition, label: Text("Pay conditions")) {
                            ForEach(RentType.PayMoment.allCases, id: \.self) { moment in
                                Text("\(moment.rawValue)")
                                    .font(.callout)
                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 4)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .overlay(
                        HStack(spacing: 15){
                            ForEach(Range(0...2)){ index in
                                Capsule()
                                    .fill(getIndex() == index ? Color.blue : Color.white)
                                    .frame(width: getIndex() == index ? 20 : 7, height: 7)
                            }
                        }
                        //Smooth sliding effect
                        .overlay(
                            Capsule()
                                .fill(Color.blue)
                                .frame(width: 20, height: 7)
                                .offset(x: getOffset())
                            ,alignment: .leading
                        )
                        .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                        //                            .padding(.bottom, 10)
                        ,alignment: .bottom
                    )
                }
                .frame(height: self.showingEdit ? getHeight() * 0.3 : 0)
            }
            .background(Color.gray.opacity(0.15))
            .cornerRadius(15)
        }
    }
    
    
    func getIndex() -> Int {
        print("index: \(Int(ceil(offset / getWidth())))")
        return  Int(ceil(offset / getWidth()))
    }
    
    //        getting offset for capsule shape
    func getOffset() -> CGFloat {
        //Spacing = 15
        //Circle width = 7
        //total = 22
        
        return CGFloat(22 * getIndex())
    }
}


