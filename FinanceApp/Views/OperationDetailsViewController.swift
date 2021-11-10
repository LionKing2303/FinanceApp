//
//  OperationDetailsViewController.swift
//  FinanceApp
//
//  Created by Arie Peretz on 10/11/2021.
//

import UIKit

class OperationDetailsViewController: UIViewController {
    
    // MARK: -- Private variables
    private let headerTitle: String = "Operation"
    private var viewModel: ViewModel
    
    // MARK: -- Outlets
    @IBOutlet weak var operationIdTitle: UILabel!
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = headerTitle
        operationIdTitle.text = "Operation Id: \(viewModel.operationId)"
    }
}
