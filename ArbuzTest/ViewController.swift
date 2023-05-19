//
//  ViewController.swift
//  ArbuzTest
//
//  Created by Saruar on 18.05.2023.
//

import UIKit




class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {


    
    private var products = [Product]()
    private var viewModels = [PhotoCollectionViewCellModel]()
    private var collectionView: UICollectionView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

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
        
        fetchProducts()
        
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        
        cell.configure(with: viewModels[indexPath.row])

        return cell
    }
    
    
    
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

