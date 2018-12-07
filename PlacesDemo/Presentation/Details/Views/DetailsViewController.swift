//
//  DetailsViewController.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 07.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private lazy var viewModel: DetailsViewModel = {
        return DetailsViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: - Private Methods

extension DetailsViewController {
    private func setupUI() {
        setupDescriptionLabel()
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.text = viewModel.locationDescription
    }
}

// MARK: - Selector Methods

extension DetailsViewController {
    
}

// MARK: - Injectable Protocol

extension DetailsViewController: Injectable {
    typealias T = PointOfInterest
    
    func inject(_ selectedPoint: T?) {
        viewModel.setDetails(poi: selectedPoint)
    }
    
    func assertDependencies() {
        assert(viewModel.getPointOfInterest() != nil, "`inject` method on DetailsViewController should be called")
    }
}
