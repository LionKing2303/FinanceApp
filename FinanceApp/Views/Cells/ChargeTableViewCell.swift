//
//  ChargeTableViewCell.swift
//  FinanceApp
//
//  Created by Arie Peretz on 10/11/2021.
//

import UIKit

class ChargeTableViewCell: UITableViewCell {
    static let identifier: String = "ChargeTableViewCell"

    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var operationDescription: UILabel!
    
    func configure(with model: OperationsModel.Operation) {
        amount.text = "$ \(model.amount ?? 0)"
        operationDescription.text = model.operationDesc
    }
}
