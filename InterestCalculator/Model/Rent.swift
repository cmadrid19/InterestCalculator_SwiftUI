//
//  Loan.swift
//  InterestCalculator
//
//  Created by Maxim Macari on 12/3/21.
//

import SwiftUI

struct Rent {
    var time: Double?
    var principal: Double?
    var accrued: Double?
    var rate: Double?
    var type: RentType
    
    var finalValue: Double?
    var currentValue: Double?
    
    
    
    func calculateFinalValue(){
        
    }
    
    func calculateCurrentValue(){
        
    }
    
    private func useThis(){
        
    }
}

struct RentType {
    var duration: Duration
    var payCondition: PayCondition
    var payMoment: PayMoment
    var flow: Flow?
    var incidence: Incidence?
    
    enum Duration: String, CaseIterable, Equatable{
        case temporary
        case perpetual
        
        var allCases: [Self] {
            return [.temporary, .perpetual]
        }
    }
    
    enum PayCondition: String, CaseIterable, Equatable{
        case immediate
        case deferred
        case anticipated
        
        var allCases: [Self] {
            return [.immediate, .anticipated, .deferred]
        }
    }
    
    enum PayMoment: String, CaseIterable, Equatable{
        case prepayable
        case postpayable
        
        var allCases: [Self] {
            return [.prepayable, .postpayable]
        }
    }
    
    //COMMING SOON...
    enum Flow: String, CaseIterable, Equatable{
        case constant
        case variable
        
        var allCases: [Self] {
            return [.constant, .variable]
        }
    }
    
    enum Incidence: String, CaseIterable, Equatable{
        case periodical
        case nonperiodical
        
        var allCases: [Self] {
            return [.periodical, .nonperiodical]
        }
    }
    
    //More types
    //discrete or continuous rent
    //certain or random rent
    
}

var rentTest = Rent(time: Double.zero, principal: Double.zero, accrued: Double.zero, rate: Double.zero, type: RentType(duration: RentType.Duration.perpetual, payCondition: RentType.PayCondition.immediate, payMoment: RentType.PayMoment.postpayable))

