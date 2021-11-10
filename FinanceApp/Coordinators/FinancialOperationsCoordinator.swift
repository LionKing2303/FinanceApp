//
//  FinancialOperationsCoordinator.swift
//  FinanceApp
//
//  Created by Arie Peretz on 10/11/2021.
//

import UIKit
import Combine

final class FinancialOperationsCoordinator: Coordinator {
    // MARK: -- Private variables
    private var childCoordinators = [Coordinator]()
    private weak var financialOperationsViewController: FinancialOperationsViewController?
    private weak var navigationController: UINavigationController?
    private var cancellables = Set<AnyCancellable>()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let navigationController = navigationController else { return }
        
        // Create view, view model and service,
        // then push the view in the navigation controller
        let service = MockRepository()
        let viewModel = FinancialOperationsViewController.ViewModel(service: service)
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
