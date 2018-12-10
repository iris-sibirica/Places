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
    private var poisDataSource: PoisDataSource
    private weak var delegate: OverviewViewModelDelegate?
    
    private var pois: [PointOfInterest] = []
    private var fetchingInProgress: Bool = false
    private var currentOffset = 0
    private var total = 0
    
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
        
        if let savedPois = self.savedPois() {
            Context.main.queue.async {
                self.pois = savedPois
                self.fetchingInProgress = false
                self.total = savedPois.count
                self.delegate?.onFetchCompleted(with: .none)
            }
            return
        }
        
        
        poisDataSource.pois(offset: currentOffset) { result in
            guard result.isSuccessful else {
                self.fetchingInProgress = false
                self.delegate?.onFetchFailed(with: result.error?.errorDescription ?? "")
                return
            }
            
            do {
                let rootResponse = try result.map(Root.self)
                let poisResponse = try self.parseResponse(rootResponse)
                
                Context.main.queue.async {
                    self.pois.append(contentsOf: poisResponse.pois)
                    self.fetchingInProgress = false
                    self.currentOffset += 50
                    self.total = poisResponse.total
                    
                    if poisResponse.offset > 50 {
                        let indexPathsToReload = self.calculateIndexPathsToReload(from: poisResponse.pois)
                        self.delegate?.onFetchCompleted(with: indexPathsToReload)
                    } else {
                        self.delegate?.onFetchCompleted(with: .none)
                    }
                    
                    // TODO: Think of better way to handle this.
                    print("total = \(self.totalCount)")
                    print("pois = \(self.allPois.count)")
                    if self.currentOffset > 0 && (self.allPois.count == self.totalCount) {
                        self.encodeResponse(self.pois)
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
    
    private func parseResponse(_ rootResponse: Root?) throws -> PoisResponse {
        guard let response = rootResponse?.response, let groups = response.groups else { throw NetworkError.parsingError }
        let items = groups.flatMap { $0.items }
        let pois = items.map { PointOfInterest(name: $0.venue.name, location: $0.venue.location) }
        let hasMore = currentOffset < response.totalResults
        return PoisResponse(pois: pois, hasMore: hasMore, offset: currentOffset, total: response.totalResults)
    }
    
    func encodeResponse(_ pois: [PointOfInterest]) {
        let encodedData = try? PropertyListEncoder().encode(pois)
        UserDefaults.standard.set(encodedData, forKey: "Pois")
        UserDefaults.standard.synchronize()
    }
    
    private func savedPois() -> [PointOfInterest]? {
        guard let data =  UserDefaults.standard.object(forKey: "Pois") as? Data else { return nil }
        return try! PropertyListDecoder().decode([PointOfInterest].self, from: data)
    }
}
