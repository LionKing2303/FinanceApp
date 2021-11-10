//
//  Repository.swift
//  FinanceApp
//
//  Created by Arie Peretz on 10/11/2021.
//

import Foundation
import Combine

enum RepositoryError: Error {
    case general
}

protocol Repository {
    func fetchData() -> AnyPublisher<OperationsModel,RepositoryError>
}

struct MockRepository: Repository {
    func fetchData() -> AnyPublisher<OperationsModel, RepositoryError> {
        let json = """
        { "operations": [ { "operationType": "CASH_WITHDRAWAL", "amount": 100.0, "source":  "ATM", "address": "127 Hudson St, NY", "operationId": 11 }, { "operationType":  "CHARGE", "operationDesc": "Restaurant", "amount": 70.0, "operationId": 10 },  { "operationType": "CHARGE", "operationDesc": "Shopping", "amount": 320.7,  "operationId": 9 }, { "operationType": "CHARGE", "operationDesc": "Car rent", "amount":  170.0, "operationId": 8 }, { "operationType": "REFUND", "operationDesc": "Refund",  "amount": 99.9, "operationId": 7 }, { "operationType": "CHARGE", "operationDesc":  "Vacation Booking", "amount": 540.50, "operationId": 6 }, { "operationType": "CHARGE",  "operationDesc": "Tickets", "amount": 220.0, "operationId": 5 }, { "operationType":  "SAVING_WITHDRAWAL", "operationDesc": "Saving", "amount": 250.0, "operationId":  4 }, { "operationType": "SALARY", "operationDesc": "Salary", "amount": 1000.0,  "operationId": 3 }, { "operationType": "CHARGE", "operationDesc": "Hummus",  "amount": 3.2, "operationId": 2 }, { "operationType": "CHARGE", "operationDesc": "Pita",  "amount": 1.0, "operationId": 1 } ] }
        """
        
        guard
            let jsonData = json.data(using: .utf8),
            let model = try? JSONDecoder().decode(OperationsModel.self, from: jsonData) else {
            return Fail(error: RepositoryError.general)
                    .eraseToAnyPublisher()
        }
                    
        return Just(model)
                .setFailureType(to: RepositoryError.self)
                .eraseToAnyPublisher()
    }
}
