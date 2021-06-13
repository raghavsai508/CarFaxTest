//
//  Service.swift
//  CarFaxTest
//
//  Created by Raghav Sai Cheedalla on 6/13/21.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol Service {
    var baseURL: String { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: Any]? { get }
}

extension Service {
    
    private var url: URL? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        if httpMethod == .get {
            
            if let parameters = parameters as? [String : String] {
                urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
            }
        }
        
        return urlComponents?.url
    }
    
    public var urlRequest: URLRequest {
        guard let url = url else {
            fatalError("No url is set")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        if let headers = headers as? [String: String] {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
    
}
