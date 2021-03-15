//
//  Simple.swift
//  InterestCalculator
//
//  Created by Maxim Macari on 12/3/21.
//

import SwiftUI

class Simple {
    var time: Double?
    var principal: Double?
    var accrued: Double?
    var rate: Double?
    
    @AppStorage("timeType") var selectedTimeType: TimeTypes = TimeTypes.years
    
    init(time: Double, principal: Double, rate: Double, accrued: Double) {
        self.time = time
        self.accrued = accrued
        self.rate = rate
        self.principal = principal
    }
    
    var rateDecimal: Double{
        if let rate = self.rate {
            return (rate / 100)
        }else{
            return Double.zero
        }
    }
    
    
    func calculateAccrued() -> Double{
        if let rate = self.rate, let principal = self.principal {
            let rateTime = rate * timeIntoYears
            self.accrued = principal * (1 + Double(rateTime))
        }
        return self.accrued ?? Double.zero
    }
    
   
    func calculateTime() -> Double{
        if let principal = self.principal, let accrued = self.accrued {
            self.time = Double(1 / self.rateDecimal) * Double((accrued / principal) - 1)
        }
        return self.time ?? Double.zero
    }
    
    func calculateRate() -> Double{
        if let time = self.time, let principal = self.principal, let accrued = self.accrued {
            let auxRate = (1/time) * ((accrued / principal) - 1) * 100// this is decimal rate, not anual rate
            self.rate = self.convertToAnnualRate(distinctRate: auxRate)
        }
        return self.rate ?? Double.zero
    }
    
    func calculatePrincipal() -> Double{
        if let accrued = self.accrued {
            self.principal = accrued / (1 + (self.rateDecimal * timeIntoYears))
        }
        return self.principal ?? Double.zero
    }
    
    //putting time into years for simplicity...
    //if its day weeeks or monthss.. we need to convert it to years
    public var timeIntoYears: Double{
        var years: Double = Double.zero
        if let time = self.time {
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
        }
        
        return years
    }
    
    public func convertToAnnualRate(distinctRate: Double) -> Double{
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
}

var simpleTest: Simple = Simple(time: Double.zero, principal: Double.zero, rate: Double.zero, accrued: Double.zero)
