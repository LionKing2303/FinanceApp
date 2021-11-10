//
//  FinancialOperationsCoordinator.swift
//  FinanceApp
//
//  Created by Arie Peretz on 10/11/2021.
//

import UIKit

final class FinancialOperationsCoordinator: Coordinator {
    private var childCoordinators = [Coordinator]()

    private weak var financialOperationsViewController: FinancialOperationsViewController?
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let navigationController = navigationController else { return }
        let financialOperationsVC = FinancialOperationsViewController()
        navigationController.pushViewController(financialOperationsVC, animated: true)
        financialOperationsViewController = financialOperationsVC
    }
}
