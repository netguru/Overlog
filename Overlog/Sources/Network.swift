//
//  Network.swift
//  Overlog
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import Foundation

internal enum Network: NetworkProtocol {
    typealias NetworkParameters = Dictionary<String, Any>
    
    case get(url: URL)
    case post(url: URL)
    
    fileprivate var httpMethod: String {
        switch self {
        case .get(_):
            return "GET"
        case .post(_):
            return "POST"
        }
    }
    
    func performRequest(with parameters: NetworkParameters?, headers: Dictionary<String, String>?, completionHandler: @escaping (NetworkResponse) -> ()) {
        let session = URLSession(configuration: .default)
        var request: URLRequest! = nil
        switch self {
        case .get(let url):
            if let parameters = requestParameters(from: parameters) {
                request = URLRequest(url: URL(string: String(describing: url.absoluteString) + "?" + parameters)!)
            } else {
                request = URLRequest(url: url)
            }
        case .post(let url):
            request = URLRequest(url: url)
            request?.httpBody = requestParameters(from: parameters)?.data(using: .utf8)
        }
        request?.httpMethod = self.httpMethod
        let dataTask = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    if let error = error {
                        completionHandler(NetworkResponse.error(error: error))
                        return
                    }
                    completionHandler(NetworkResponse.error(error: NetworkError.noData))
                    return
                }
                completionHandler(NetworkResponse.success(response: data))
            }
        }
        dataTask.resume()
    }
    
    fileprivate func requestParameters(from dictonary: Dictionary<String, Any>?) -> String? {
        guard let dictonary = dictonary else {
            return nil
        }
        var result = String.empty
        for key in Array(dictonary.keys) {
            if result != String.empty {
                result.append("&")
            }
            let value = dictonary[key]
            result.append("\(key)=\(String(describing: value))")
        }
        return result == String.empty ? nil : result
    }
}
