//
//  URLSession.swift
//  ArbuzTest
//
//  Created by Saruar on 18.05.2023.
//


import UIKit



final class APICaller{
    static let shared = APICaller()


    
    struct Constants{
        static let fruitsURL = URL(string:"https://gist.githubusercontent.com/ChrisNjubi/f07089be7d3b9e58af616e65ab006cac/raw/11115300319e507204c92f2d621cb59b9e18061c/blinky_fruitiez.json")
    }
    
    
    private init(){}
    
    
    public func parse(completion: @escaping(Result<[Product], Error>) -> Void){
        guard let url = Constants.fruitsURL else{
            return
        }
        

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error{
                completion(.failure(error))
            }
            else if let data = data{
                
                do{
                    let result = try JSONDecoder().decode([Product].self, from: data)
                    
                    print(result.count)
                    
                    completion(.success(result))
                }catch{
                    completion(.failure(error))
                    }
                }
            }
            


        task.resume()
        
        
    }
    
    
    
    
    
    
}
