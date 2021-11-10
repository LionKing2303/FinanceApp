//
//  FinancialOperationsViewModel.swift
//  FinanceApp
//
//  Created by Arie Peretz on 10/11/2021.
//

import Foundation
import Combine

extension FinancialOperationsViewController {
    final class ViewModel {
        @Published var operationId: Int?
    }
}
