//
//  FinancialOperationsViewController.swift
//  FinanceApp
//
//  Created by Arie Peretz on 10/11/2021.
//

import UIKit
import Combine

class FinancialOperationsViewController: UIViewController {
    // MARK: -- Table view sections
    enum Section {
        case main
    }
    
    // MARK: -- Private variables
    private let headerTitle: String = "Financial Operations"
    private var viewModel: ViewModel
    private var dataSource: UITableViewDiffableDataSource<Section,OperationsModel.Operation>!
    private var cancellables = Set<AnyCancellable>()

    // MARK: -- Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
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
        
        searchBar.delegate = self
        configureTableView()
        
        viewModel.$filteredOperations
            .receive(on: DispatchQueue.main)
            .sink { [weak self] operations in
                self?.applySnapshot(items: operations)
            }
            .store(in: &cancellables)
        
        viewModel.fetchData()
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: CashWithdrawalTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CashWithdrawalTableViewCell.identifier)
        tableView.register(UINib(nibName: ChargeTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ChargeTableViewCell.identifier)
        tableView.register(UINib(nibName: OtherTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: OtherTableViewCell.identifier)
        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        dataSource = .init(tableView: tableView, cellProvider: {
            (tableView, indexPath, model) -> UITableViewCell? in
            switch model.operationType {
            case .cashWithdrawal:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CashWithdrawalTableViewCell.identifier) as? CashWithdrawalTableViewCell else { return UITableViewCell() }
                cell.configure(with: model)
                return cell
            case .charge:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ChargeTableViewCell.identifier) as? ChargeTableViewCell else { return UITableViewCell() }
                cell.configure(with: model) { [weak self] in
                    self?.selectOperation(model: model)
                }
                return cell
            case .savingWithdrawal, .refund, .salary:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherTableViewCell.identifier) as? OtherTableViewCell else { return UITableViewCell() }
                cell.configure(with: model) { [weak self] in
                    self?.selectOperation(model: model)
                }
                return cell
            case .none:
                return UITableViewCell()
            }
        })
    }
    
    private func applySnapshot(items: [OperationsModel.Operation]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section,OperationsModel.Operation>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        dataSource.apply(snapshot)
    }
    
    private func selectOperation(model: OperationsModel.Operation?) {
        guard let id = model?.operationId else { return }
        viewModel.selectOperation(operationId: id)
    }
}

extension FinancialOperationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Selecting a row should work only on cashWithdrawal type of cell
        let model = dataSource.itemIdentifier(for: indexPath)
        switch model?.operationType {
        case .cashWithdrawal:
            selectOperation(model: model)
        default: break
        }
    }
}

extension FinancialOperationsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Ask the view model to filter the operations based on the search text
        viewModel.filter(with: searchText)
    }
}
