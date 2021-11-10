//
//  OtherTableViewCell.swift
//  FinanceApp
//
//  Created by Arie Peretz on 10/11/2021.
//

import UIKit

class OtherTableViewCell: UITableViewCell {
    static let identifier: String = "OtherTableViewCell"
    
    // MARK: -- Private variables
    private var infoButtonTapped: (()->Void)?
    
    // MARK: -- Outlets
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var receivedPayment: UILabel!
    
    func configure(with model: OperationsModel.Operation, infoButtonTapped: (()->Void)? = nil) {
        amount.text = "$\(model.amount ?? 0)"
        receivedPayment.text = "Received Payment"
        self.infoButtonTapped = infoButtonTapped
    }
    
    @IBAction func infoButtonAction(_ sender: Any) {
        infoButtonTapped?()
    }
}
