//
//  PhotoCollectionViewCell.swift
//  ArbuzTest
//
//  Created by Saruar on 18.05.2023.
//

import UIKit





class PhotoCollectionViewCellModel{
    
    let label: String
    let imageURL: URL?
    
    var imageData: Data? = nil
    
    init(
        label: String,
        imageURL: URL?
    ){
        self.label = label
        self.imageURL = imageURL
    }
    
}


class PhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "PhotoCollectionViewCell"
    
    var imageData: Data? = nil
    
    
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
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(myLabel)
        contentView.addSubview(myImageView)
        contentView.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00)
        
        contentView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myLabel.frame = CGRect(x: 5, y: contentView.frame.size.height-50, width: contentView.frame.size.height - 10, height: 50)
        myImageView.frame = CGRect(x: 5, y: 0, width: contentView.frame.size.height - 10, height: contentView.frame.size.height - 50)
    }
    

    
    override func prepareForReuse() {
        super.prepareForReuse()
        myLabel.text = nil
        myImageView.image = nil
    }
    
    
    public func configure(with viewModel: PhotoCollectionViewCellModel){
        myLabel.text = viewModel.label
        
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
