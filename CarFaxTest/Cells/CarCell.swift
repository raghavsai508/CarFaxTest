//
//  CarCell.swift
//  CarFaxTest
//
//  Created by Raghav Sai Cheedalla on 6/13/21.
//

import UIKit
import SDWebImage

class CarCell: UITableViewCell {
    
    
    @IBOutlet weak var mainBackgroundView: UIView!
    @IBOutlet weak var shadowView: ShadowView!
    
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var lblCar: UILabel!
    @IBOutlet weak var lblCarInfo: UILabel!
    @IBOutlet weak var btnCallDealer: UIButton!
    
    weak var delegate: CarDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(car: Car, tag: Int) {
        
        mainBackgroundView.layer.cornerRadius = 8
        mainBackgroundView.layer.masksToBounds = true
        shadowView.layer.cornerRadius = 8
        shadowView.layer.masksToBounds = false
        
        lblCar.text = "\(car.year!) \(car.make!) \(car.model!) \(car.trim!)"
        
        if let listPrice = car.listPrice,
           let convertedPrice = Utility.convertDoubleToCurrency(amount: listPrice) {
            lblCarInfo.text = "\(convertedPrice) | \(car.mileage!.formatUsingAbbrevation()) Mi | \(car.dealer.city!), \(car.dealer.state!)"
        }
        
        
        btnCallDealer.tag = tag
        
        if let phone = car.dealer.phone {
            let phoneConverted = Utility.formatPhone(phone: phone)
            btnCallDealer.setTitle(phoneConverted, for: .normal)

        }
        
        if let imageUrl = car.imageUrl,
           let url = URL(string: imageUrl) {
            carImageView.sd_setImage(with: url, placeholderImage: nil)
        }
        
    }
    
    
    @IBAction func btnCallDealerAction(_ sender: UIButton) {
        delegate?.callDealerAt(index: sender.tag)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        carImageView.image = nil
    }
    
}
