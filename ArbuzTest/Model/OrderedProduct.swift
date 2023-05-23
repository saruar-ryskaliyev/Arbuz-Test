//
//  OrderedProduct.swift
//  ArbuzTest
//
//  Created by Saruar on 23.05.2023.
//

import UIKit


class OrderedProduct{
    
    let label: String
    let totalPrice: Int
    var quantity: Int
    
    
    init(
        label: String,
        totalPrice: Int,
        quantity: Int
        
    ){
        self.label = label
        self.totalPrice = totalPrice
        self.quantity = quantity
    }
    
}

