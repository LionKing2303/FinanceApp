//
//  OperationDetailsViewModel.swift
//  FinanceApp
//
//  Created by Arie Peretz on 10/11/2021.
//

import Combine

extension OperationDetailsViewController {
    final class ViewModel {
        let operationId: Int
        
        init(operationId: Int) {
            self.operationId = operationId
        }
    }
}
