//
//  CartTableViewCell.swift
//  ArbuzTest
//
//  Created by Saruar on 23.05.2023.
//

import UIKit
import GMStepper
import SnapKit


protocol CartTableViewCellDelegate: AnyObject{
    func updateCell()
}

class CartTableViewCell: UITableViewCell {
    
    
    static let identifier = "CartTableViewCell"
    static let greenColor: UIColor = UIColor(red: 0.10, green: 0.67, blue: 0.29, alpha: 1.00)
    var viewModel: PhotoCollectionViewCellModel?
    var delegate: CartTableViewCellDelegate?
    

    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    
    private let MyGMStepper: GMStepper = {
        let GMstepper = GMStepper()
        

        GMstepper.buttonsBackgroundColor = greenColor
        GMstepper.labelBackgroundColor = greenColor
        GMstepper.addTarget(self, action: #selector(stepperPressed), for: .valueChanged)
        GMstepper.minimumValue = 0
        GMstepper.cornerRadius = 8
        GMstepper.labelFont = UIFont.systemFont(ofSize: 20)

        
        return GMstepper
    }()
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    private let mySmallerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(myLabel)
        contentView.addSubview(myImageView)
        contentView.addSubview(MyGMStepper)
        contentView.addSubview(mySmallerLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    @objc func stepperPressed(){
        let num = Int(MyGMStepper.value)
        
        if num == 0{
            viewModel?.quantity = 0
            selectedProducts.removeAll(where: {$0.quantity == 0})
            delegate?.updateCell()
        }
        
        viewModel?.quantity = num
        
    }
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myImageView.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(20)
            make.centerY.equalToSuperview()
            make.width.equalTo(65)
            make.height.equalTo(65)
        }
        
        myLabel.snp.makeConstraints { make in
            make.left.equalTo(myImageView.snp.right).offset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(self.contentView.frame.size.width - 300)
            make.height.equalTo(70)
            
        }
        
        mySmallerLabel.snp.makeConstraints { make in
            make.left.equalTo(myLabel.snp.right).offset(20)
            make.centerY.equalToSuperview()
            make.width.equalTo(self.contentView.frame.size.width - 300)
            make.height.equalTo(70)
        }
    
        
        MyGMStepper.snp.makeConstraints { make in
            make.left.equalTo(mySmallerLabel.snp.right).offset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(self.contentView.frame.size.height)
            make.height.equalTo(50)
            
        }
        

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        myImageView.image = nil
        myLabel.text = nil
        
    }
    
    
    func configure(with viewModel: PhotoCollectionViewCellModel){
        
        self.viewModel = viewModel
        
        myImageView.image = UIImage(data: viewModel.imageData!)
        myLabel.text = viewModel.label
      
        mySmallerLabel.text = "kg \(viewModel.price) ₸"
        MyGMStepper.value = Double(viewModel.quantity)
    }
    
    
    
    
    

}
