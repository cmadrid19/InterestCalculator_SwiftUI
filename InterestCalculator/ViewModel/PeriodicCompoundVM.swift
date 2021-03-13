//
//  CompoundVM.swift
//  InterestCalculator
//
//  Created by Maxim Macari on 10/3/21.
//

import SwiftUI

class PeriodicCompoundVM: ObservableObject {
    
    @Published var periods: String = ""
    @Published var principal: String = ""
    @Published var accrued: String = ""
    @Published var rate: String = ""
    @Published var answer: String = ""
    @Published var compound: Compounds = Compounds.annually
    
    @AppStorage("timeType") var selectedTimeType: TimeTypes = TimeTypes.years
    @AppStorage("selectedPupose") var selectedPurpose: Purpose = Purpose.accrued
    
    public var principalDoble: Double {
        return Double(self.principal) ?? Double.zero
    }
    
    public var accruedDouble: Double{
        return Double(self.accrued) ?? Double.zero
    }
    
    public var periodsDouble: Double{
        return Double(self.periods.replacingOccurrences(of: ",", with: ".")) ?? Double.zero
    }
    
    public var ratePercentDouble: Double{
        return Double(self.rate.replacingOccurrences(of: ",", with: ".")) ?? Double.zero
    }
    
    public var rateDecimalDouble: Double{
        return self.ratePercentDouble / 100
    }
    
    func clearInputs(){
        self.accrued = ""
        self.answer = ""
        self.principal = ""
        self.periods = ""
        self.rate = ""
    }
    
    func calculate() {
        ///The most important this before calculating:
        /// 1.  The percentage always rules
        ///. 2  Rate and time must be in the same unit
        switch selectedPurpose {
        case Purpose.accrued:
            self.calculateAccrued()
        case Purpose.time:
            self.calculatePeriods()
        case Purpose.rate:
            self.calculateRate()
        case Purpose.principal:
            self.calculatePrincipal()
        }
    }
    
    //    //show interes
    //    func showInterest() -> String{
    //        //todo accrued: I = Cn - Co
    //        if let Cn = Double(accrued), let Co = Double(principal){
    //            return String((Cn - Co).intoLocaleCurrency)
    //        } else {
    //            print("insufficient data")
    //            return ""
    //        }
    //    }
    
    private func calculateAccrued(){
        guard !(self.principal.isEmpty && self.rate.isEmpty && self.periods.isEmpty) else {
            print("insufficient data inputs")
            return
        }
        self.accrued = String(self.principalDoble * pow(( 1 + self.rateDecimalDouble), self.periodsDouble))
        self.answer = "Cn = \(self.accruedDouble.intoLocaleCurrency)"
    }
    
    private func calculatePeriods(){
        guard !(self.principal.isEmpty && self.rate.isEmpty && self.periods.isEmpty) else {
            print("insufficient data inputs")
            return
        }
        
        guard (self.principalDoble < self.accruedDouble) else {
            print("Accrued must be grater than principal")
            return
        }
        let result = abs(log((self.principalDoble / self.accruedDouble)) / log(1 + self.rateDecimalDouble))
        self.periods = String(format: "%.3f", result)
        self.answer = "Periods = \(periods)"
        
    }
    
    private func calculateRate(){
        guard !(self.principal.isEmpty && self.accrued.isEmpty && self.periods.isEmpty) else {
            print("insufficient data inputs")
            return
        }
        
        guard (self.principal < self.accrued) else {
            print("Accrued must be grater than principal")
            return
        }
        let result = (pow((self.accruedDouble/self.principalDoble), (1/self.periodsDouble)) - 1) * 100
        self.rate = String(format: "%.3f", result)
        self.answer = "R = \(self.ratePercentDouble)% per period"
    }
    
    private func calculatePrincipal(){
        guard !(self.rate.isEmpty && self.accrued.isEmpty && self.periods.isEmpty) else {
            print("insufficient data inputs")
            return
        }
        self.principal = String(self.accruedDouble / pow((1 + rateDecimalDouble), self.periodsDouble))
        self.answer = "Co = \(self.principalDoble.intoLocaleCurrency)"
    }
}

