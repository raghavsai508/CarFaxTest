//
//  Car.swift
//  CarFaxTest
//
//  Created by Raghav Sai Cheedalla on 6/13/21.
//

import Foundation

struct CarContainer: Decodable {
    var listings: [Car]
}

struct Car: Decodable {
    var imageUrl: String?
    var year: Int?
    var make: String?
    var model: String?
    var trim: String?
    var listPrice: Double?
    var mileage: Int?
    var dealer: Dealer
    
    struct Dealer: Decodable {
        var phone: String?
        var city: String?
        var state: String?
    }
    
    enum OuterKeys: String, CodingKey {
        case year, make, model, trim, listPrice, mileage, dealer, images
    }
    
    enum ImageKeys: String, CodingKey {
        case firstPhoto
    }
    
    enum FirstPhotoKeys: String, CodingKey {
        case medium
    }
    
    init(from decoder: Decoder) throws {
        let outerContainer = try decoder.container(keyedBy: OuterKeys.self)
        
        year = try outerContainer.decodeIfPresent(Int.self, forKey: .year)
        make = try outerContainer.decodeIfPresent(String.self, forKey: .make)
        model = try outerContainer.decodeIfPresent(String.self, forKey: .model)
        trim = try outerContainer.decodeIfPresent(String.self, forKey: .trim)
        listPrice = try outerContainer.decodeIfPresent(Double.self, forKey: .listPrice)
        mileage = try outerContainer.decodeIfPresent(Int.self, forKey: .mileage)
        dealer = try outerContainer.decode(Dealer.self, forKey: .dealer)
        
        let imagesContainer = try outerContainer.nestedContainer(keyedBy: ImageKeys.self, forKey: .images)
        let firstPhotoContainer = try imagesContainer.nestedContainer(keyedBy: FirstPhotoKeys.self, forKey: .firstPhoto)
        imageUrl = try firstPhotoContainer.decodeIfPresent(String.self, forKey: .medium)
    }
}
