//
//  OptionalStringCoalescingOperator.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 09.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import Foundation

infix operator ???: NilCoalescingPrecedence

func ???<T>(optional: T?, defaultValue: @autoclosure () -> String) -> String {
    switch optional {
    case let value?: return String(describing: value)
    case nil: return defaultValue()
    }
}
