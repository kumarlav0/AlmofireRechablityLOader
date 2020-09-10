//
//  Enums.swift
//  Loader_Reacheablity
//
//  Created by Kumar Lav on 8/17/20.
//  Copyright © 2020 Kumar Lav. All rights reserved.
//

import Foundation

typealias success = (_ response: NSDictionary)-> Void
typealias failure = (_ error: NSError)-> Void
typealias dictPost = [String:Any]


enum APIErrorType {
    case invalidURL
    case invalidHeaderValue
    case noData
    case conversionFailed
    case invalidJSON
    case invalidResponse
    case noNetwork
    case customAPIError
    
    func getMessage() -> String {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidHeaderValue: return "Header value is not string"
        case .noData: return "No Data available"
        case .conversionFailed: return "Conversion Failed"
        case .invalidJSON: return "Invalid JSON"
        case .invalidResponse: return "Invalid Response"
        case .noNetwork: return "Please check your internet connection."
        case .customAPIError: return ""
        }
    }
}



enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
