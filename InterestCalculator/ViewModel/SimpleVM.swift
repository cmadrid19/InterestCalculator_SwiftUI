//
//  Simple.swift
//  InterestCalculator
//
//  Created by Maxim Macari on 10/3/21.
//

import SwiftUI

class SimpleVM: ObservableObject {
    
    @Published var time: String = ""
    @Published var principal: String = ""
    @Published var accrued: String = ""
    @Published var rate: String = ""
    
    @Published var simpleInterest: Simple? = nil
    
    @Published var answer: String = ""
    
    @Published var alertType: AlertType? = nil
    
    @AppStorage("timeType") var selectedTimeType: TimeTypes = TimeTypes.years
    @AppStorage("selectedPupose") var selectedPurpose: Purpose = Purpose.accrued
    
    private var rateString: String {
        return String(self.simpleInterest?.rate ?? Double.zero)
    }
    
    private var rateDecimalString: String {
        return String(self.simpleInterest?.rateDecimal ?? Double.zero)
    }
    
    private var principalString: String {
        return self.simpleInterest?.principal?.intoLocaleCurrency ?? String(Double.zero)
    }
    private var accruedString: String {
        return self.simpleInterest?.accrued?.intoLocaleCurrency ?? String(Double.zero)
    }
    private var timeYearsString: String{
        return String(self.simpleInterest?.timeIntoYears ?? Double.zero)
    }
    private var timeString: String{
        return String(self.simpleInterest?.time ?? Double.zero)
    }
    
    func clearInputs(){
        self.accrued = ""
        self.answer = ""
        self.principal = ""
        self.time = ""
        self.rate = ""
    }
    
    //show interes
    func showInterest() -> String{
        //todo accrued: I = Cn - Co
        if let Cn = Double(accrued), let Co = Double(principal){
            return String((Cn - Co).intoLocaleCurrency)
        } else {
            alertType = AlertType.singleButton(title: "Error", message: "Insuficient data inputs.", dismissButton: Alert.Button.destructive(Text("Ok")))
            return ""
        }
    }
    
    private func transformToYearsPartitionString() -> String {
        var secondStep = ""
        switch self.selectedTimeType {
        case .months:
            secondStep = "12 months/year"
        case .quarters:
            secondStep = "4 quarters/year"
        case .weaks:
            secondStep = "52 weaks/year"
        case .threeHundrednSixty:
            secondStep = "360 days/year"
        case .threeHundrednSixtyFive:
            secondStep = "365 days/year"
        case .years:
            secondStep = ""
        }
        return secondStep
    }
    
    
    func calculate() {
        
        self.simpleInterest = Simple(time: Double(self.time.replacingOccurrences(of: ",", with: ".")) ?? Double.zero,
                                     principal: Double(self.principal) ?? Double.zero,
                                     rate: Double(self.rate.replacingOccurrences(of: ",", with: ".")) ?? Double.zero,
                                     accrued: Double(self.accrued) ?? Double.zero)
        
        switch selectedPurpose {
        case Purpose.accrued:
            guard !(self.principal.isEmpty && self.rate.isEmpty && self.time.isEmpty) else {
                alertType = AlertType.singleButton(title: "Error", message: "Insuficient data inputs. inputs", dismissButton: Alert.Button.destructive(Text("Ok")))
                return
            }
            self.answer = self.simpleInterest?.calculateAccrued().intoLocaleCurrency ?? ""
        case Purpose.time:
            guard !(self.principal.isEmpty || self.rate.isEmpty || self.time.isEmpty) else {
                alertType = AlertType.singleButton(title: "Error", message: "Insuficient data inputs.", dismissButton: Alert.Button.destructive(Text("Ok")))
                return
            }
            guard (self.simpleInterest?.principal ?? Double.zero < self.simpleInterest?.accrued ?? Double.zero) else {
                alertType = AlertType.singleButton(title: "Error", message: "Accrued must be grater than principal", dismissButton: Alert.Button.destructive(Text("Ok")))
                return
            }
            if let time = self.simpleInterest?.calculateTime(){
                self.answer = "\(MyTime(years: time).showTimeString())"
            }
        case Purpose.rate:
            guard !(self.principal.isEmpty || self.accrued.isEmpty || self.time.isEmpty) else {
                alertType = AlertType.singleButton(title: "Error", message: "Insuficient data inputs.", dismissButton: Alert.Button.destructive(Text("Ok")))
                return
            }
            guard (self.simpleInterest?.principal ?? Double.zero < self.simpleInterest?.accrued ?? Double.zero) else {
                alertType = AlertType.singleButton(title: "Error", message: "Accrued must be grater than principal", dismissButton: Alert.Button.destructive(Text("Ok")))
                return
            }
            self.answer = String("\(self.simpleInterest?.calculateRate())%")
        case Purpose.principal:
            guard !(self.rate.isEmpty && self.accrued.isEmpty && self.time.isEmpty) else {
                alertType = AlertType.singleButton(title: "Error", message: "Insuficient data inputs.", dismissButton: Alert.Button.destructive(Text("Ok")))
                return
            }
            self.answer = self.simpleInterest?.calculatePrincipal().intoLocaleCurrency ?? ""
        }
    }
    
    func showSimpleOperations() -> String {
        var steps: String = ""
        switch self.selectedPurpose {
        case .time:
            steps = "First, converting percent to decimal, r = \(self.rate)%/100 = \(self.rateDecimalString) per year, then, solving our equation. t = (1/(\(self.rateDecimalString))((\(self.accrued)/\(self.principal) - 1) = \(self.time). The time required to get a total amount, principal plus interest, of \(self.principalString) from simple interest on a principal of \(self.principalString) at an interest rate of \(self.rate)% per year is (\(self.answer)). "
        case .rate:
            steps = "Solving our equation: r = (1/\(self.time)((\(self.accrued)/\(self.principal) - 1) = \(self.rate). Converting r decimal to percentage, R = \(self.rate) * 100 = \(self.rateString)%/year. The interest rate required to get a total amount, principal plus interest, of \(self.principalString) from simple interest on a principal of \(self.principalString) over \(self.time) \(self.selectedTimeType.rawValue) is \(self.answer) per year. "
        case .principal:
            steps = "First, converting R percent to r a decimal, r = \(self.rateString)/100 = \( self.rateDecimalString) per year. Solving our equation:, P = \(self.accruedString) / ( 1 + (\( self.rateDecimalString) × \(self.timeYearsString) = \(self.answer). The principal investment required to get a total amount, principal plus interest, of \(self.principalString) from simple interest at a rate of \(self.rateString)% per year for \(self.timeString) \(self.selectedTimeType.rawValue) is \(self.principalString)."
        default: //accrued
            steps = "First, converting R percent to decimal r = \(self.rate)%/100 = \(self.rateDecimalString) per year. "
            if self.selectedTimeType != TimeTypes.years {
                steps += "Putting time into years for simplicity, \(self.time) \(self.selectedTimeType.rawValue) / (\(self.transformToYearsPartitionString())) = \(self.timeYearsString) years. "
            }
            steps += "Solving our equation: Co=\(self.principal)(1 + (\(self.rateDecimalString) × \(self.timeYearsString))) = \(self.answer)"
        }
        return steps
    }
    
}


