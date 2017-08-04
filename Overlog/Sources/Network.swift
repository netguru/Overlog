//
//  Network.swift
//  Overlog
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import Foundation

internal enum Network: NetworkProtocol {
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
    
    func performRequest(with parameters: Dictionary<String, Any>?, completionHandler: @escaping (NetworkResponse) -> ()) {
        let session = URLSession(configuration: .default)
        var request: URLRequest! = nil
        switch self {
        case .get(let url):
            let requestURL = URL(string: String(describing: url.absoluteString) + requestParameters(from: parameters))
            request?.httpMethod = "GET"
            request = URLRequest(url: requestURL!)
        case .post(let url):
            request = URLRequest(url: url)
            request?.httpMethod = "POST"
            request?.httpBody = requestParameters(from: parameters).data(using: .utf8)
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
    
    fileprivate func requestParameters(from dictonary: Dictionary<String, Any>?) -> String {
        guard let dictonary = dictonary else {
            return String.empty
        }
        let glue = "?"
        var result = glue
        for key in Array(dictonary.keys) {
            if result != glue {
                result.append("&")
            }
            let value = dictonary[key]
            result.append("\(key)=\(String(describing: value))")
        }
        return result
    }
}
