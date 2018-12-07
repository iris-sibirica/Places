//
//  OverviewViewController.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 03.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import UIKit
import MapKit

class OverviewViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var toggleButton: UIBarButtonItem!
    
    private lazy var viewModel: OverviewViewModel = {
        let poisDataSource = DataModule.shared.poisRepository()
        return OverviewViewModel(poisDataSource: poisDataSource, delegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        viewModel.getPois()
    }
    
    @IBAction func didTapToggleButton(_ sender: Any) {
        mapView.isHidden = !mapView.isHidden
        toggleButton.title = mapView.isHidden ? "Map" : "Table"
    }
    
}

// MARK: - Private Methods

extension OverviewViewController {
    private func setupTableView() {
        let cellNib = UINib(nibName: TableViewCell.nibName, bundle: Bundle.main)
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
    }
    
    private func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion =
            MKCoordinateRegion(center: location.coordinate,
                               latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func addAnnotations() {
        let annotations = viewModel.allPois.map { MapPoint(title: $0.name, locationName: $0.name, category: $0.categoryName, coordinate: CLLocationCoordinate2D(latitude: $0.location.lat, longitude: $0.location.lng)) }
        mapView.addAnnotations(annotations)
    }
}

// MARK: - TableView Data Source Methods

extension OverviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier) as? TableViewCell
        cell?.setTitleLabel(text: viewModel.poi(at: indexPath.row).name)
        
        return cell!
    }
}

// MARK: - TableView Delegate Methods

extension OverviewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPoi = viewModel.poi(at: indexPath.row)
        performSegue(withIdentifier: StoryboardSegue.overviewToDetails.rawValue, sender: selectedPoi)
    }
}

// MARK: - TableView Data Source Prefetching Methods

extension OverviewViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {}
}

// MARK: - Segues

extension OverviewViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch storyboardSegue(for: segue) {
        case .overviewToDetails:
            let detailsViewController = segue.destination as? DetailsViewController
            guard let selectedPoi = sender as? PointOfInterest else { return }
            detailsViewController?.inject(selectedPoi)
        default:
            fatalError("ERROR: Trying to perform an undefined segue with identifier \(segue.identifier ?? "")")
        }
    }
}

// MARK: - ViewModel Delegate Methods

extension OverviewViewController: OverviewViewModelDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        //table view
        tableView.reloadData()
        // map view
        let evenlyLocation = CLLocation(latitude: API.CurrentLocation.Latitude, longitude: API.CurrentLocation.Longitude)
        centerMapOnLocation(location: evenlyLocation)
        addAnnotations()
    }
    
    func onFetchFailed(with reason: String) {
        print("Fetch failed: \(reason)")
    }  
}
