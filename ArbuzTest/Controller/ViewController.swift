import UIKit




var selectedProducts = [PhotoCollectionViewCellModel]()



class ViewController: UIViewController {
    
    
    
    private var searching = false
    private var searchedFood = [PhotoCollectionViewCellModel]()
    private var products = [Product]()
    private var viewModels = [PhotoCollectionViewCellModel]()
    private var collectionView: UICollectionView?
    

    
    // View Controller Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = "Home"
        
        self.navigationItem.title = "arbuz kz 🍉"
    

        
        setupCollectionView()
        setupNavigationBar()
        setupSearchController()
        fetchProducts()
        
        
    }
}




// MARK: - Search Controller

extension ViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func setupSearchController() {
        let searchController = UISearchController()
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Искать на Арбузе"
    }
    
    func updateSearchResults(for searchController: UISearchController) {
       // Update search results based on the search text entered by the user.
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
        // Reset the search results and display all items.
        searching = false
        searchedFood.removeAll()
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
}

// MARK: - Navigation Bar

extension ViewController {
    
    func setupNavigationBar() {
        // Customize the appearance of the navigation bar.
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor(red: 0.10, green: 0.67, blue: 0.29, alpha: 1.00)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(red: 0.10, green: 0.67, blue: 0.29, alpha: 1.00)]
        
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
}

// MARK: -Collection View

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the number of items to be displayed in the collection view.
        if searching == false{
            return viewModels.count
        }else{
            return searchedFood.count
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Configure and return the cell to be displayed for the given item.
        
        
        if searching == false{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
            cell.configure(with: viewModels[indexPath.row])
            cell.delegate = self
      
            return cell
        } else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
            cell.configure(with: searchedFood[indexPath.row])
            cell.delegate = self
            
            return cell
        }
        
    }
    
    func setupCollectionView() {
        // Configure the collection view.
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
}

// MARK: - API Fetching

extension ViewController {
    
    
    private func fetchProducts() {
        // Fetch products from the API and update the view models.
        APICaller.shared.parse { [weak self] result in
            switch result{
            case .success(let products):
                self?.products = products
                self?.viewModels = products.compactMap({
                    PhotoCollectionViewCellModel(label: $0.name, imageURL: URL(string: $0.photo_url ), price: $0.price)
                   
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


extension ViewController: PhotoCollectionViewCellDelegate{
    func saveToCart(viewModel: PhotoCollectionViewCellModel) {
        
        
        
        if selectedProducts.contains(where: {$0.label == viewModel.label}){
            if let index = selectedProducts.firstIndex(where: { $0.label == viewModel.label }) {
                
                selectedProducts[index] = viewModel
            }
        }else{
            selectedProducts.append(viewModel)
        }
        
        
         
        
    }
    
    
}






