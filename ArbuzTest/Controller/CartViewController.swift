import UIKit

class CartViewController: UIViewController {
    
    // MARK: - Properties
    
    private var tableView = UITableView()
    

    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureNavigationItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        selectedProducts.removeAll(where: { $0.quantity == 0 })
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - Private Methods
    
    private func configureTableView() {
        tableView.allowsSelection = false
        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: CartTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
        view.addSubview(tableView)
    }
    
    private func configureNavigationItem() {
        title = "Cart"
        navigationItem.title = "Cart 🛒"
    }
    
}

// MARK: - UITableViewDelegate

extension CartViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension CartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as! CartTableViewCell
        cell.delegate = self
        cell.configure(with: selectedProducts[indexPath.row])
        return cell
    }
    
}

// MARK: - CartTableViewCellDelegate

extension CartViewController: CartTableViewCellDelegate {
    
    func updateCell() {
        tableView.reloadData()
    }
    
}
