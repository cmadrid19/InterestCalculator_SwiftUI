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
    
    @AppStorage("selectedPupose") var selectedPurpose: Purpose = Purpose.accrued
    @AppStorage("timeType") var selectedTimeType: TimeTypes = TimeTypes.years
    
    @Published var compoundPeriods: Compounds = Compounds.annually
    @Published var compound: Compound? = nil
    @Published var alertType: AlertType? = nil
    
    func clearInputs(){
        self.accrued = ""
        self.answer = ""
        self.principal = ""
        self.periods = ""
        self.rate = ""
    }
    
    func calculate() {
        ///The most important thing before calculating:
        /// 1.  The percentage always rules
        /// 2.  Rate and time must be in the same unit
        
        self.compound = Compound(periods: Double(self.periods.replacingOccurrences(of: ",", with: ".")) ?? Double.zero,
                                 principal: Double(self.principal) ?? Double.zero,
                                 rate: Double(self.rate.replacingOccurrences(of: ",", with: ".")) ?? Double.zero,
                                 accrued: Double(self.accrued) ?? Double.zero)
        
        switch selectedPurpose {
        case Purpose.accrued:
            guard !(self.principal.isEmpty && self.rate.isEmpty && self.periods.isEmpty) else {
                alertType = AlertType.singleButton(title: "Error", message: "Insuficient data inputs.", dismissButton: Alert.Button.destructive(Text("Ok")))
                return
            }
            if let accrued = self.compound?.calculateAccrued(){
                self.answer = "Cn = \(accrued.intoLocaleCurrency)"
            }
            
        case Purpose.time:
            guard !(self.principal.isEmpty && self.rate.isEmpty && self.periods.isEmpty) else {
                alertType = AlertType.singleButton(title: "Error", message: "Insuficient data inputs.", dismissButton: Alert.Button.destructive(Text("Ok")))
                return
            }
            
            guard (self.compound?.principal ?? Double.zero < self.compound?.accrued ?? Double.zero) else {
                alertType = AlertType.singleButton(title: "Error", message: "Accrued must be grater than principal", dismissButton: Alert.Button.destructive(Text("Ok")))
                return
            }
            if let periods = self.compound?.calculatePeriods() {
                self.answer = "Periods = \(String(format: "%.3f", periods))"
            }
        case Purpose.rate:
            guard !(self.principal.isEmpty && self.accrued.isEmpty && self.periods.isEmpty) else {
                alertType = AlertType.singleButton(title: "Error", message: "Insuficient data inputs.", dismissButton: Alert.Button.destructive(Text("Ok")))
                return
            }
            
            guard (self.principal < self.accrued) else {
                alertType = AlertType.singleButton(title: "Error", message: "Accrued must be grater than principal", dismissButton: Alert.Button.destructive(Text("Ok")))
                return
            }
            if let rate = self.compound?.calculateRate() {
                self.answer = "R = \(String(format: "%.3f", rate))% per period"
            }
        case Purpose.principal:
            guard !(self.rate.isEmpty && self.accrued.isEmpty && self.periods.isEmpty) else {
                alertType = AlertType.singleButton(title: "Error", message: "Insuficient data inputs.", dismissButton: Alert.Button.destructive(Text("Ok")))
                return
            }
            if let principal = self.compound?.calculatePrincipal() {
                self.answer = "Co = \(principal.intoLocaleCurrency)"
            }
        }
    }
    
    private func operations(){
        
    }
}

