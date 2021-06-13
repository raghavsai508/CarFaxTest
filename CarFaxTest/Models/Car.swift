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
    var year: Int?
    var make: String?
    var model: String?
    var trim: String?
    var listPrice: Double?
    var mileage: Int?
    var city: String?
    var state: String?
    var dealer: Dealer
    
    struct Dealer: Decodable {
        var phone: String?
    }
}
