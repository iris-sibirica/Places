//
//  Context.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 05.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import Foundation

enum Context {
    case main
    case userInteractive
    case userInitiated
    case utility
    case background
    case custom(queue: DispatchQueue)
    
    public var queue: DispatchQueue {
        switch self {
        case .main: return .main
        case .userInteractive: return .global(qos: .userInteractive)
        case .userInitiated: return .global(qos: .userInitiated)
        case .utility: return .global(qos: .utility)
        case .background: return .global(qos: .background)
        case .custom(let queue): return queue
        }
    }
}
