//
//  PhotoCollectionViewCell.swift
//  ArbuzTest
//
//  Created by Saruar on 18.05.2023.
//

import UIKit
import GMStepper


class PhotoCollectionViewCellModel{
    
    let label: String
    let imageURL: URL?
    let button: UIButton = UIButton(type: .system)
    let price: Int

    
    var imageData: Data? = nil

    
    init(
        label: String,
        imageURL: URL?,
        price: Int

    ){
        self.label = label
        self.imageURL = imageURL
        self.price = price
    }
    
}


class PhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "PhotoCollectionViewCell"
    
    var imageData: Data? = nil
    private var quantity: Int = 0
    
    private let MyGMStepper: GMStepper = {
        let GMstepper = GMStepper()
        

        GMstepper.isHidden = true
        GMstepper.buttonsBackgroundColor = UIColor(red: 0.10, green: 0.67, blue: 0.29, alpha: 1.00)
        GMstepper.labelBackgroundColor = UIColor(red: 0.10, green: 0.67, blue: 0.29, alpha: 1.00)
        GMstepper.addTarget(self, action: #selector(stepperPressed), for: .valueChanged)
        GMstepper.minimumValue = 0
        GMstepper.value = 1
        GMstepper.borderWidth = 1
        GMstepper.cornerRadius = 8
        GMstepper.labelFont = UIFont.systemFont(ofSize: 20)
    
        
        return GMstepper
    }()
    
    
    
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.text = "Custom"
        label.textAlignment = .center
        label.clipsToBounds = true
        return label
    }()
    
    
    private let myButton: UIButton = {
        let button = UIButton()
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 0.10, green: 0.67, blue: 0.29, alpha: 1.00)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        
        
        return button
    }()
    
    
    @objc func buttonPressed(){
        myButton.isHidden = true
        MyGMStepper.isHidden = false
    
    }
    
    @objc func stepperPressed(){
        let num = Int(MyGMStepper.value)
        

        if num == 0{
            MyGMStepper.isHidden = true
            myButton.isHidden = false
            MyGMStepper.value = 1
        }
        
        quantity = num
        
        print(quantity)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(myLabel)
        contentView.addSubview(myImageView)
        contentView.addSubview(myButton)
        contentView.addSubview(MyGMStepper)
        contentView.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00)
        
        contentView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        MyGMStepper.frame = CGRect(x: 25, y: contentView.frame.size.height - 30, width: contentView.frame.size.height - 45, height: 20)
        myButton.frame = CGRect(x: 25, y: contentView.frame.size.height - 30, width: contentView.frame.size.height - 45, height: 20)
        myLabel.frame = CGRect(x: 5, y: contentView.frame.size.height-65, width: contentView.frame.size.height - 10, height: 50)
        myImageView.frame = CGRect(x: 5, y: 0, width: contentView.frame.size.height - 10, height: contentView.frame.size.height - 50)
    }
    

    
    override func prepareForReuse() {
        super.prepareForReuse()
        myLabel.text = nil
        myImageView.image = nil
    
    }
    
    

    
    public func configure(with viewModel: PhotoCollectionViewCellModel){
        myLabel.text = viewModel.label
        
        myButton.setTitle("\(viewModel.price)₸ +", for: .normal)
          
        if let data = viewModel.imageData{
            myImageView.image = UIImage(data: data)
        }else if let url = viewModel.imageURL{
            URLSession.shared.dataTask(with: url){data, _, error in
                guard let data = data, error == nil else{
                    return
                }
                
                viewModel.imageData = data
                
                DispatchQueue.main.async {
                    self.myImageView.image = UIImage(data: data)
                }
            }.resume()
        }
        
    }
    
    
    
}
