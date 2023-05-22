//
//  CartViewController.swift
//  ArbuzTest
//
//  Created by Saruar on 21.05.2023.
//

import UIKit



class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ViewControllerDelegate{
    

    private var selectedProducts = [PhotoCollectionViewCellModel]()
  
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = true
        tableView.frame = view.bounds
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        
        
        title = "Cart"
        self.navigationItem.title = "cart 🛒"
        
        
        
 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ViewController {
            destinationVC.delegate = self
            print("HUI")
        }
    }
  
    
    func moveToCart(with viewModels: [PhotoCollectionViewCellModel]) {
        print("LOL")
        
        selectedProducts = viewModels
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "LOl"
        
        return cell
    }
    

    
    
    
}


