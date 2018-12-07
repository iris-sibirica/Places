//
//  OverviewViewModel.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 04.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import Foundation

protocol OverviewViewModelDelegate: class {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
}

class OverviewViewModel {
    private weak var delegate: OverviewViewModelDelegate?
    
    private var pois: [PointOfInterest] = []
    private var fetchingInProgress: Bool = false
    private var currentPage = 1
    private var total = 0
    
    private var poisDataSource: PoisDataSource
    
    init(poisDataSource: PoisDataSource, delegate: OverviewViewModelDelegate?) {
        self.poisDataSource = poisDataSource
        self.delegate = delegate
    }
    
    var totalCount: Int {
        return total
    }
    
    var currentCount: Int {
        return pois.count
    }
    
    var allPois: [PointOfInterest] {
        return pois
    }
    
    func poi(at index: Int) -> PointOfInterest {
        return pois[index]
    }
    
    func getPois() {
            
        guard !fetchingInProgress else { return }
        fetchingInProgress = true
        
        poisDataSource.pois(from: currentPage) { result in
            guard result.isSuccessful else {
                self.fetchingInProgress = false
                self.delegate?.onFetchFailed(with: result.error?.errorDescription ?? "")
                return
            }

            do {
                let poisResponse: PoisResponse?
                if result.cashed {
                    let rootResponse = try result.map(PoisResponse.self)
                    poisResponse = PoisResponse(pois: rootResponse?.pois ?? [], hasMore: rootResponse?.hasMore ?? false, page: rootResponse?.page ?? 0)
                } else {
                    let rootResponse = try result.map(Root.self)
                    poisResponse = self.parseResponse(rootResponse)
                    
                    let encodedData = try? PropertyListEncoder().encode(poisResponse)
                    UserDefaults.standard.set(encodedData, forKey: String(describing: PoisResponse.self))
                    UserDefaults.standard.synchronize()
                }
                
                Context.main.queue.async {
                    self.pois.append(contentsOf: poisResponse!.pois)
                    self.fetchingInProgress = false
                    self.currentPage += 1
                    self.total = poisResponse!.pois.count
                    if poisResponse!.page > 1 {
                        let indexPathsToReload = self.calculateIndexPathsToReload(from: poisResponse!.pois)
                        self.delegate?.onFetchCompleted(with: indexPathsToReload)
                    } else {
                        self.delegate?.onFetchCompleted(with: .none)
                    }
                }
            } catch let error {
                self.fetchingInProgress = false
                self.delegate?.onFetchFailed(with: error.localizedDescription)
            }
        }
    }
}

// MARK: - Private Methods

extension OverviewViewModel {
    private func calculateIndexPathsToReload(from newPois: [PointOfInterest]) -> [IndexPath] {
        let startIndex = pois.count - newPois.count
        let endIndex = startIndex + newPois.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    private func parseResponse(_ rootResponse: Root?) -> PoisResponse? {
        guard let groups = rootResponse?.response.groups else { return  nil }
        var pois: [PointOfInterest] = []
        for group in groups {
            for item in group.items {
                pois.append(PointOfInterest(id: item.venue.id, name: item.venue.name,
                                            location: item.venue.location,
                                            categoryName: item.venue.categories[0].name))
            }
        }
        return PoisResponse(pois: pois, hasMore: true, page: 1)
    }
}
