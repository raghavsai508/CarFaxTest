//
//  ServiceProvider.swift
//  CarFaxTest
//
//  Created by Raghav Sai Cheedalla on 6/13/21.
//

import Foundation

// This class is reponsible for handling the Service type and fetches the data.
class ServiceProvider<T: Service> {
    
    let session = URLSession.shared
    
    init() {}
    
    func load(service: T, completion: @escaping (Result<Data, Error>)->Void) {
        makeCall(service.urlRequest, completion: completion)
    }
    
    // This method is responsible for downloading the data and converting the data to Decodable type
    func load<U>(service: T, decodeType: U.Type, completion: @escaping (Result<U, Error>)->Void) where U: Decodable {
        makeCall(service.urlRequest) { (result) in
            switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    decoder.dateDecodingStrategy = .iso8601
                    do {
                        let resp = try decoder.decode(decodeType, from: data)
                        completion(.success(resp))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    /**
     This method is reponsible for making service call.
     */
    private func makeCall(_ urlRequest: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        
        session.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } else if let data = data {
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            }
        }.resume()
    }
    
}
