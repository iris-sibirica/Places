//
//  NetworkError.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 03.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import Foundation

/// A type representing possible errors that can be thrown.
enum NetworkError: Error {
    
    /// Indicates a response failed to map to a JSON structure.
    case jsonMapping//(NetworkResponse)
    /// Indicates a response failed to map to a String.
    case stringMapping//(NetworkResponse)
    /// Indicates a response failed to map to a Decodable object.
    case objectMapping//(Error, NetworkResponse)
    /// Indicates a response failed with an invalid HTTP status code.
    case statusCode//(NetworkResponse)
    /// Indicates a response failed due to an underlying `Error`.
    case underlying(Error?)
    /// Indicates that an `Endpoint` failed to encode the parameters for the `URLRequest`.
    case parameterEncoding(Error)
    /// Indicates that data in response is nil
    case dataIsNil
    
    case responseIsNil
    
    case parsingError
}

// MARK: - Error Descriptions

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .jsonMapping:
            return "Failed to map data to JSON."
        case .stringMapping:
            return "Failed to map data to a String."
        case .objectMapping:
            return "Failed to map data to a Decodable object."
        case .statusCode:
            return "Status code didn't fall within the given range."
        case .parameterEncoding(let error):
            return "Failed to encode parameters for URLRequest. \(error.localizedDescription)"
        case .underlying(let error):
            return error?.localizedDescription
        case .dataIsNil:
            return "Data in response is nil."
        case .responseIsNil:
            return "Response is nil."
        case .parsingError:
            return "Unable to parse data."
        }
    }
}

