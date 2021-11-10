//
//  CashWithdrawalTableViewCell.swift
//  FinanceApp
//
//  Created by Arie Peretz on 10/11/2021.
//

import UIKit

class CashWithdrawalTableViewCell: UITableViewCell {
    static let identifier: String = "CashWithdrawalTableViewCell"
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var address: UILabel!
    
    func configure(with model: OperationsModel.Operation) {
        amount.text = "$ \(model.amount ?? 0)"
        source.text = model.source
        address.text = model.address
    }
}
