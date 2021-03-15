//
//  Compound.swift
//  InterestCalculator
//
//  Created by Maxim Macari on 12/3/21.
//

import SwiftUI

class Compound {
    var periods: Double?
    var principal: Double?
    var accrued: Double?
    var rate: Double?
    
    @AppStorage("timeType") var selectedTimeType: TimeTypes = TimeTypes.years
    
    init(periods: Double, principal: Double, rate: Double, accrued: Double) {
        self.periods = periods
        self.accrued = accrued
        self.rate = rate
        self.principal = principal
    }
    
    var rateDecimal: Double {
        if let rate = self.rate {
            return rate / 100
        } else {
            return Double.zero
        }
    }
    
    func calculateAccrued() -> Double{
        if let periods = self.periods, let principal = self.principal {
            self.accrued = principal * pow(( 1 + self.rateDecimal), periods)
        }
        return accrued ?? Double.zero
    }
    
    func calculatePeriods() -> Double{
        if let principal = self.principal, let accrued = self.accrued{
            self.periods = abs(log((principal / accrued)) / log(1 + self.rateDecimal))
        }
        return periods ?? Double.zero
    }
    
    func calculateRate() -> Double{
        if let periods = self.periods, let principal = self.principal, let accrued = self.accrued{
            self.rate = (pow((accrued/principal), (1/periods)) - 1) * 100
        }
        return rate ?? Double.zero
    }
    
    func calculatePrincipal() -> Double{
        if let periods = self.periods, let accrued = self.accrued{
            self.principal = accrued / pow((1 + rateDecimal), periods)
        }
        return principal ?? Double.zero
    }
}

