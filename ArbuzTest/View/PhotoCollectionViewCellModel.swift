//
//  PhotoCollectionViewCellModel.swift
//  ArbuzTest
//
//  Created by Saruar on 22.05.2023.
//

import UIKit

class PhotoCollectionViewCellModel{
    
    let label: String
    let imageURL: URL?
    let button: UIButton = UIButton(type: .system)
    let price: Int
    var quantity: Int
    
    var imageData: Data? = nil
    

    
    init(
        label: String,
        imageURL: URL?,
        price: Int

    ){
        self.label = label
        self.imageURL = imageURL
        self.price = price
        self.quantity = 0
    }
    
    
    
    public func updateQuantity(with number: Int){
        self.quantity = number
    }
    
    
}
