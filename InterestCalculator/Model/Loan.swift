//
//  Loan.swift
//  InterestCalculator
//
//  Created by Maxim Macari on 12/3/21.
//

import SwiftUI

struct Loan {
    var time: Double?
    var principal: Double?
    var accrued: Double?
    var rate: Double?
    var type: Sort
    
    var finalValue: Double?
    var currentValue: Double?
    
    enum Sort{
        case temporary(Temporary)
        case perpetual(Perpetual)
        
        enum Temporary {
            case immediate(Rent)
            case defferred(Rent)
            case anticipated(Rent)
        }
        
        enum Perpetual {
            case immediate(Rent)
            case defferred(Rent)
            case anticipated(Rent)
        }
        
        enum Rent{
            case prepayable
            case postpayable
        }
    }
    
    
    
    func calculateFinalValue(){
        switch self.type {
        case .temporary(.anticipated(.postpayable)):
            self.useThis()
        case .temporary(.anticipated(.prepayable)):
            self.useThis()
        case .temporary(.defferred(.postpayable)):
            self.useThis()
        case .temporary(.defferred(.prepayable)):
            self.useThis()
        case .temporary(.immediate(.postpayable)):
            self.useThis()
        case .temporary(.immediate(.prepayable)):
            self.useThis()
        
        case .perpetual(.anticipated(.postpayable)):
            self.useThis()
        case .perpetual(.anticipated(.prepayable)):
            self.useThis()
        case .perpetual(.defferred(.postpayable)):
            self.useThis()
        case .perpetual(.defferred(.prepayable)):
            self.useThis()
        case .perpetual(.immediate(.postpayable)):
            self.useThis()
        case .perpetual(.immediate(.prepayable)):
            self.useThis()
        }
    }
    
    func calculateCurrentValue(){
        switch self.type {
        case .temporary(.anticipated(.postpayable)):
            self.useThis()
        case .temporary(.anticipated(.prepayable)):
            self.useThis()
        case .temporary(.defferred(.postpayable)):
            self.useThis()
        case .temporary(.defferred(.prepayable)):
            self.useThis()
        case .temporary(.immediate(.postpayable)):
            self.useThis()
        case .temporary(.immediate(.prepayable)):
            self.useThis()
        
        case .perpetual(.anticipated(.postpayable)):
            self.useThis()
        case .perpetual(.anticipated(.prepayable)):
            self.useThis()
        case .perpetual(.defferred(.postpayable)):
            self.useThis()
        case .perpetual(.defferred(.prepayable)):
            self.useThis()
        case .perpetual(.immediate(.postpayable)):
            self.useThis()
        case .perpetual(.immediate(.prepayable)):
            self.useThis()
        }
    }
    
    private func useThis(){
        
    }
}

var loanTest = Loan(time: Double.zero, principal: Double.zero, accrued: Double.zero, rate: Double.zero, type: Loan.Sort.perpetual(.anticipated(.postpayable)))

