//
//  Compound.swift
//  InterestCalculator
//
//  Created by Maxim Macari on 12/3/21.
//

import SwiftUI

struct Compound {
    var time: Double?
    var principal: Double?
    var accrued: Double?
    var rate: Double?
    
    
    init(time: Double, principal: Double, rate: Double) {
        self.time = time
        self.accrued = Double.zero
        self.rate = rate
        self.principal = principal
    }
    
    init(time: Double, principal: Double, accrued: Double) {
        self.time = time
        self.accrued = accrued
        self.rate = Double.zero
        self.principal = principal
    }
    
    init(principal: Double, accrued: Double, rate: Double) {
        self.time = Double.zero
        self.accrued = accrued
        self.rate = rate
        self.principal = principal
    }
    
    init(time: Double, accrued: Double, rate: Double) {
        self.time = time
        self.accrued = accrued
        self.rate = rate
        self.principal = Double.zero
    }
    
    private func calculateAccrued(){
        
    }
    
    private func calculateTime(){
        
    }
    
    private func calculateRate() {
        
    }
    
    private func calculatePrincipal() {
        
    }
    
}

