//
//  FinancialOperationsCoordinator.swift
//  FinanceApp
//
//  Created by Arie Peretz on 10/11/2021.
//

import UIKit
import Combine

final class FinancialOperationsCoordinator: Coordinator {
    private var childCoordinators = [Coordinator]()

    private weak var financialOperationsViewController: FinancialOperationsViewController?
    private weak var navigationController: UINavigationController?
    private var cancellables = Set<AnyCancellable>()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let navigationController = navigationController else { return }
        
        // Create view and view model and push in the navigation controller
        let viewModel = FinancialOperationsViewController.ViewModel()
        let financialOperationsVC = FinancialOperationsViewController(viewModel: viewModel)
        navigationController.pushViewController(financialOperationsVC, animated: true)
        
        // Store reference to the view and bind the data flow
        financialOperationsViewController = financialOperationsVC
        dataBind(viewModel)
    }
    
    private func dataBind(_ viewModel: FinancialOperationsViewController.ViewModel) {
        // When a value comes down from the view model
        // we open the details view controller with that value
        viewModel.$operationId
            .print()
            .sink { [weak self] id in
                self?.openOperationDetails(operationId: id)
            }
            .store(in: &cancellables)
    }
    
    func openOperationDetails(operationId: Int?) {
        guard let navigationController = navigationController,
              let operationId = operationId
        else { return }
        
        // Create the operation details coordinator and start it
        let coordinator = OperationDetailsCoordinator(
            navigationController: navigationController,
            operationId: operationId
        )
        coordinator.start()
        childCoordinators.append(coordinator)
    }
}
