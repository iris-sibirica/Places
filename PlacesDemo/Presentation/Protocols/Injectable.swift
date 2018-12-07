//
//  Injectable.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 07.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import Foundation

protocol Injectable {
    associatedtype T
    func inject(_: T?)
    func assertDependencies()
}
