//
//  OperationsModel.swift
//  FinanceApp
//
//  Created by Arie Peretz on 10/11/2021.
//

import Foundation

enum OperationType: String, Codable {
    case cashWithdrawal = "CASH_WITHDRAWAL"
    case charge = "CHARGE"
    case savingWithdrawal = "SAVING_WITHDRAWAL"
    case refund = "REFUND"
    case salary = "SALARY"
}

struct OperationsModel: Codable {
    let operations: [Operation]    
    struct Operation: Codable, Hashable {
        let operationType: OperationType?
        let operationDesc: String?
        let amount: Double?
        let source: String?
        let address: String?
        let operationId: Int
        
        func contains(text: String) -> Bool {
            (operationDesc?.contains(text) ?? false) || ("\(amount ?? 0)".contains(text)) || (source?.contains(text) ?? false) || (address?.contains(text) ?? false)
        }
    }
}
