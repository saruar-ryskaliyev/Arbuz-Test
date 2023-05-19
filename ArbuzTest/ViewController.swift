//
//  ViewController.swift
//  ArbuzTest
//
//  Created by Saruar on 18.05.2023.
//

import UIKit




class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UISearchResultsUpdating {
 
   
    
    private var searching = false
    private var searchedFood = [PhotoCollectionViewCellModel]()
    private var products = [Product]()
    private var viewModels = [PhotoCollectionViewCellModel]()
    private var collectionView: UICollectionView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "arbuz.kz 🍉"
        

        setupCollectionView()
        setupNavigationBar()
        setupSearchController()

        
        fetchProducts()
        
    }
    
    
    
    //MARK: - Search Controller
    
    func setupSearchController(){
        let searchController = UISearchController()
        navigationItem.searchController = searchController
        
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Искать на Арбузе"
        
    }
    
    
    
    //MARK: - NavigationBar
    
    func setupNavigationBar(){
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor(red: 0.10, green: 0.67, blue: 0.29, alpha: 1.00)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(red: 0.10, green: 0.67, blue: 0.29, alpha: 1.00)]

        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty{
            searching = true
            searchedFood.removeAll()
            for viewModel in viewModels{
                if viewModel.label.lowercased().contains(searchText.lowercased()){
                    searchedFood.append(viewModel)
                }
            }
            
        }else{
            searching = false
            searchedFood.removeAll()
            searchedFood = viewModels
        }
        
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchedFood.removeAll()
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }

    
    //MARK: - Collection View

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        if searching == false{
            return viewModels.count
        }else{
            return searchedFood.count
        }
 
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if searching == false{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
            
            cell.configure(with: viewModels[indexPath.row])

            return cell
        } else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
            
            cell.configure(with: searchedFood[indexPath.row])

            return cell
        }
        

    }
    
    func setupCollectionView(){
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        layout.itemSize = CGSize(width: (view.frame.size.width/3) - 4, height: (view.frame.size.width/3) - 4)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else{
            return
        }
        
    
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        view.addSubview(collectionView)
        
        collectionView.frame = view.bounds
    }
    
    
    
    //MARK: - API Fetching
    
    private func fetchProducts(){
        APICaller.shared.parse { [weak self] result in
            switch result{
            case .success(let products):
                self?.products = products
                self?.viewModels = products.compactMap({
                    PhotoCollectionViewCellModel(label: $0.name, imageURL: URL(string: $0.photo_url ))
                   
                })
                
                DispatchQueue.main.async {
                    self?.collectionView?.reloadData()
                }
                
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    
}

