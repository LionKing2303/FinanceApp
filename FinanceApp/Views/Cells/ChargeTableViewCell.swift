//
//  ChargeTableViewCell.swift
//  FinanceApp
//
//  Created by Arie Peretz on 10/11/2021.
//

import UIKit

class ChargeTableViewCell: UITableViewCell {
    static let identifier: String = "ChargeTableViewCell"
    
    // MARK: -- Private variables
    private var infoButtonTapped: (()->Void)?
    
    // MARK: -- Outlets
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var operationDescription: UILabel!
    
    func configure(with model: OperationsModel.Operation, infoButtonTapped: (()->Void)? = nil) {
        amount.text = "$\(model.amount ?? 0)"
        operationDescription.text = model.operationDesc
        self.infoButtonTapped = infoButtonTapped
    }
    
    @IBAction func infoButtonAction(_ sender: Any) {
        infoButtonTapped?()
    }
}
