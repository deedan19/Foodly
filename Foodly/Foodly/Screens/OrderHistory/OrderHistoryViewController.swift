//
//  OrderHistoryViewController.swift
//  Foodly
//
//  Created by Decagon on 23.6.21.
//

import UIKit

class OrderHistoryViewController: UIViewController {
    
    @IBOutlet weak var oderHistoryTableView: UITableView!
    let orderHistoryModel = OrderHistoryModel()
    lazy var refreshOrderHistory = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        self.navigationItem.title = "My Order History"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadOrderHistory()
    }
    
    fileprivate func setUpTableView() {
        let nib = UINib(nibName: OrderHistoryTableViewCell.identifier, bundle: nil)
        oderHistoryTableView.register(nib, forCellReuseIdentifier: OrderHistoryTableViewCell.identifier)
        oderHistoryTableView.delegate = self
        oderHistoryTableView.dataSource = self
        oderHistoryTableView.addSubview(refreshOrderHistory)
        refreshOrderHistory.addTarget(self, action: #selector(reloadOrderHistory), for: .valueChanged)
    }
    
    @objc func reloadOrderHistory() {
        DispatchQueue.main.async { [self] in
            self.oderHistoryTableView.reloadData()
        }
        refreshOrderHistory.endRefreshing()
    }
}

extension OrderHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderHistoryModel.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = oderHistoryTableView.dequeueReusableCell(withIdentifier: OrderHistoryTableViewCell.identifier,
                                                                  for: indexPath)
                as? OrderHistoryTableViewCell else {fatalError()}
        cell.configure(with: orderHistoryModel.orders[indexPath.row])
        return cell
    }
}

extension OrderHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}
