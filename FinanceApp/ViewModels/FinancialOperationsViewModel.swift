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
        // MARK: -- Private variables
        private var service: Repository
        private var cancellables = Set<AnyCancellable>()
        
        // MARK: -- Public variables
        var operations: [OperationsModel.Operation] = []
        @Published var filteredOperations: [OperationsModel.Operation] = []
        @Published var operationId: Int?
        
        init(service: Repository) {
            self.service = service
        }
        
        func fetchData() {
            service.fetchData()
                .replaceError(with: OperationsModel(operations: []))
                .sink { [weak self] model in
                    guard let self = self else { return }
                    self.operations = model.operations
                    self.filteredOperations = self.operations
                }
                .store(in: &cancellables)
        }
        
        func filter(with text: String) {
            // Filter operations that contains a text  (case-insensitive)
            // in one or more of the following: address, source, amount, operationDesc
            filteredOperations = operations
                .filter { model in
                    model.contains(text: text) || text.isEmpty
                }
        }
    }
}
