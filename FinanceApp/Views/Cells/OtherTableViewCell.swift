//
//  OtherTableViewCell.swift
//  FinanceApp
//
//  Created by Arie Peretz on 10/11/2021.
//

import UIKit

class OtherTableViewCell: UITableViewCell {
    static let identifier: String = "OtherTableViewCell"
    
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var receivedPayment: UILabel!
    
    func configure(with model: OperationsModel.Operation) {
        amount.text = "$ \(model.amount ?? 0)"
        receivedPayment.text = "Received Payment"
    }
}
