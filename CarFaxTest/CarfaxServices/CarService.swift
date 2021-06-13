//
//  CarService.swift
//  CarFaxTest
//
//  Created by Raghav Sai Cheedalla on 6/13/21.
//

import Foundation

struct CarService: Service {
    
    var baseURL: String {
        return Constants.baseURL
    }
    
    var path: String {
        return "/assignment.json"
    }
    
    var parameters: [String : Any]?
    var httpMethod: HTTPMethod
    var headers: [String : Any]?
    
}
