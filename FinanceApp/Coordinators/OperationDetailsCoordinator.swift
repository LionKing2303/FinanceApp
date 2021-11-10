//
//  OperationDetailsCoordinator.swift
//  FinanceApp
//
//  Created by Arie Peretz on 10/11/2021.
//

import UIKit

final class OperationDetailsCoordinator: Coordinator {
    private weak var operationDetailsViewController: OperationDetailsViewController?
    private weak var navigationController: UINavigationController?
    private var operationId: Int
    
    init(navigationController: UINavigationController, operationId: Int) {
        self.navigationController = navigationController
        self.operationId = operationId
    }
    
    func start() {
        guard let navigationController = navigationController else { return }
        
        // Create view and view model and push in the navigation controller
        let viewModel = OperationDetailsViewController.ViewModel(operationId: operationId)
        let operationDetailsVC = OperationDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(operationDetailsVC, animated: true)
        
        // Store reference to the view
        operationDetailsViewController = operationDetailsVC
    }
}
