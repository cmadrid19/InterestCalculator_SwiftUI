//
//  SimpleCapitalizationVM.swift
//  InterestCalculator
//
//  Created by Maxim Macari on 8/3/21.
//

import SwiftUI

class SimpleCapitalizationVM: ObservableObject {
    
    @Published var time: String = ""
    @Published var principal: String = ""
    @Published var accrued: String = ""
    @Published var rate: String = ""
    
    @Published var answer: String = ""
    
    @AppStorage("timeType") var selectedTimeType: TimeTypes = TimeTypes.years
    @Published var selectedPurpose: Purpose = Purpose.accrued
    
    func calculate() {
        switch self.selectedPurpose {
        case .accrued:
            self.calculateAccrued()
        case .time:
            self.calculateTime()
        case .rate:
            self.calculateRate()
        case .principal:
            self.calculatePrincipal()
        }
    }
    
    private var principalDoble: Double {
        return Double(self.principal) ?? Double.zero
    }
    
    private var accruedDouble: Double{
        return Double(self.accrued) ?? Double.zero
    }
    
    private var timeDouble: Double{
        return Double(self.time.replacingOccurrences(of: ",", with: ".")) ?? Double.zero
    }
    
    private var ratePercentDouble: Double{
        return Double(self.rate.replacingOccurrences(of: ",", with: ".")) ?? Double.zero
    }
    
    private var rateDecimalDouble: Double{
        return self.ratePercentDouble / 100
    }
    
    
    private func calculateAccrued(){
        var accrued = Double.zero
        
        guard !(self.principal.isEmpty && self.rate.isEmpty && self.time.isEmpty) else {
            print("in")
            return
        }
        
        if let rate = Double(rate.replacingOccurrences(of: ",", with: ".")), let principal = Double(principal){
            //1 convert R percent to r a decimal -> Percent
            let ratePercentage = rate / 100
            
            let rateTime = ratePercentage * convertTimeToYears(time: self.timeDouble)
            
            accrued = principal * (1 + Double(rateTime))
            
            self.accrued = String(accrued)
            self.answer = "\(accrued.intoLocaleCurrency)"
        }
    }
    
    private func calculateTime(){
        guard !(self.principal.isEmpty && self.rate.isEmpty && self.time.isEmpty) else {
            print("insufficient data inputs")
            return
        }
        
        guard (self.principal < self.accrued) else {
            print("Accrued must be grater than principal")
            return
        }
        
        let auxTimeYears = Double(1 / self.rateDecimalDouble) * Double((self.accruedDouble / self.principalDoble) - 1)
        self.time = String(auxTimeYears)
        self.answer = "\(MyTime(years: auxTimeYears).showTimeString())"
        
    }
    
    private func calculateRate(){
        
        guard !(self.principal.isEmpty && self.accrued.isEmpty && self.time.isEmpty) else {
            print("insufficient data inputs")
            return
        }
        
        guard (self.principal < self.accrued) else {
            print("Accrued must be grater than principal")
            return
        }
        var auxRate = (1/self.timeDouble) * ((self.accruedDouble / self.principalDoble) - 1) // this is decimal rate, not anual rate
        auxRate = auxRate * 100
        self.rate = String(convertToAnnualRate(distinctRate: auxRate))
        self.answer = "\(self.rate)%"
    }
    
    private func calculatePrincipal(){
        guard !(self.rate.isEmpty && self.accrued.isEmpty && self.time.isEmpty) else {
            print("insufficient data inputs")
            return
        }
        let auxTime = convertTimeToYears(time: Double(self.timeDouble))
        self.principal = String(self.accruedDouble / (1 + (self.rateDecimalDouble * auxTime)))
        self.answer = "\(self.principalDoble.intoLocaleCurrency)"
        
    }
    
    //putting time into years for simplicity...
    //if its day weeeks or monthss.. we need to convert it to years
    private func convertTimeToYears(time: Double) -> Double{
        var years: Double = Double.zero
        switch self.selectedTimeType {
        case .months:
            years = time / 12
        case .quarters:
            years = time / 4
        case .threeHundrednSixty:
            years = time / 360
        case .threeHundrednSixtyFive:
            years = time / 365
        case .weaks:
            years = time / 52
        default: //Years
            years = time
        }
        return years
    }
    
    private func convertToAnnualRate(distinctRate: Double) -> Double{
        var annualRate: Double = Double.zero
        switch self.selectedTimeType {
        case .months:
            annualRate = distinctRate * 12
        case .quarters:
            annualRate = distinctRate * 4
        case .threeHundrednSixty:
            annualRate = distinctRate * 360
        case .threeHundrednSixtyFive:
            annualRate = distinctRate * 365
        case .weaks:
            annualRate = distinctRate * 52
        default: //Years
            annualRate = distinctRate
        }
        return annualRate
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
            print("insufficient data")
            return ""
        }
    }
    
    func showOperations() -> String {
        var steps: String = ""
        switch self.selectedPurpose {
        case .time:
            steps = "First, converting percent to decimal, r = \(self.rate)%/100 = \(self.rateDecimalDouble) per year, then, solving our equation. t = (1/(\(self.rateDecimalDouble))((\(self.accrued)/\(self.principal) - 1) = \(self.time). The time required to get a total amount, principal plus interest, of \(self.accruedDouble.intoLocaleCurrency) from simple interest on a principal of \( Double(self.principalDoble).intoLocaleCurrency) at an interest rate of \(self.rate)% per year is (\(self.answer)). "
        case .rate:
            steps = "Solving our equation: r = (1/\(self.time)((\(self.accrued)/\(self.principal) - 1) = \(self.rate). Converting r decimal to percentage, R = \(self.rate) * 100 = \(self.ratePercentDouble * 100)%/year. The interest rate required to get a total amount, principal plus interest, of \(self.accruedDouble.intoLocaleCurrency) from simple interest on a principal of \(self.principalDoble.intoLocaleCurrency) over \(self.time) \(self.selectedTimeType.rawValue) is \(self.answer) per year. "
        case .principal:
            steps = "First, converting R percent to r a decimal, r = \(self.ratePercentDouble)/100 = \(self.rateDecimalDouble) per year. Solving our equation:, P = \(self.accruedDouble) / ( 1 + (\(self.rateDecimalDouble) × \(convertTimeToYears(time: Double(self.timeDouble))) = \(self.answer). The principal investment required to get a total amount, principal plus interest, of \(self.accruedDouble.intoLocaleCurrency) from simple interest at a rate of \(self.ratePercentDouble)% per year for \(self.timeDouble) \(self.selectedTimeType.rawValue) is \(self.principalDoble.intoLocaleCurrency)."
        default: //accrued
            if let rate = Double(rate.replacingOccurrences(of: ",", with: ".")){
                steps = "First, converting R percent to decimal r = \(self.rate)%/100 = \(rate / 100) per year. "
                if selectedTimeType != TimeTypes.years {
                    steps += "Putting time into years for simplicity, \(self.time) \(self.selectedTimeType.rawValue) / (\(self.transformToYearsPartitionString())) = \(self.convertTimeToYears(time: self.timeDouble)) years. "
                }
                steps += "Solving our equation: Co=\(self.principal)(1 + (\(rate / 100) × \(self.convertTimeToYears(time: self.timeDouble)))) = \(self.answer)"
            }
        }
        return steps
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
}



