//
//  UIView+Identifier.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 03.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import UIKit

extension UIView {
    class var identifier: String {
        return String(describing: self)
    }
}
