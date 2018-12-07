//
//  UIViewController+SegueIdentifier.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 07.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import UIKit

extension UIViewController {
    func storyboardSegue(for segue: UIStoryboardSegue) -> StoryboardSegue {
        return StoryboardSegue(rawValue: segue.identifier ?? "") ?? StoryboardSegue.undefined
    }
}
