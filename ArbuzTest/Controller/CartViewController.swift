import UIKit
import SnapKit

class CartViewController: UIViewController {
    
    // MARK: - Properties
    
    private var tableView = UITableView()
    

    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var checkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Checkout", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.backgroundColor = .systemGreen
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(checkoutButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureNavigationItem()
        configureBottomView()
        
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
    

    private func configureBottomView() {
        view.addSubview(bottomView)
        bottomView.addSubview(checkoutButton)
        
       
        bottomView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(300)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
        checkoutButton.snp.makeConstraints { make in
            make.centerX.equalTo(bottomView.snp.centerX)
            make.centerY.equalTo(view).offset(300)
            make.height.equalTo(50)
            make.width.equalTo(150)
        }
        
        
    }
    
    @objc private func checkoutButtonTapped() {
        let checkoutVC = CheckoutViewController()
        
        self.present(checkoutVC, animated: true)
    }

    
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete all", style: .done, target: self, action: #selector(deletePressed))
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


extension CartViewController{
    @objc func deletePressed(){
        selectedProducts.removeAll()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
