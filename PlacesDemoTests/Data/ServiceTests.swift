//
//  ServiceTests.swift
//  PlacesDemoTests
//
//  Created by Jelena Cvokic on 07.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import XCTest
@testable import PlacesDemo

class ServiceTests: XCTestCase {
    var session: NetworkSessionMock!
    var service: ServiceProtocol!
    var data = Data(bytes: [0, 1, 0, 1])

    override func setUp() {
        session = NetworkSessionMock(data: data, urlResponse: nil, error: nil)
        service = Service(environment: Environment(host: API.BaseUrl.Host), session: session)
    }

    override func tearDown() {
        session = nil
        service = nil
        data = Data(bytes: [])
    }

    func testSuccessfulResponse() {
        var result: NetworkResponse?
        service.execute(request: NetworkRequest(path: API.BaseUrl.ExplorePath, parameters: ["offset": "50"]), completion: { result = $0 })
        XCTAssertEqual(result!.data, data)
        XCTAssertEqual(result!.error!, NetworkError.underlying(nil))
    }
    
    func testRequestURL() {
        let url = URL(string: "HTTPS://api.foursquare.com/v2/venues/explore?radius=4000&client_secret=YOUR_CLIENT_SECRET&intent=checkin&v=20170607&client_id=YOUR_CLIENT_ID&ll=52.500342,13.42517&offset=50")!
        let request = NetworkRequest(method: .get, path: API.BaseUrl.ExplorePath, parameters: ["offset": "50"])
        service.execute(request: request, completion: { _ -> Void in })
        XCTAssertEqual(session!.lastURL?.host, url.host)
        XCTAssertEqual(session!.lastURL?.scheme, url.scheme)
        XCTAssertEqual(session!.lastURL!.path, url.path)
        XCTAssertEqual(session!.lastURL!["radius"], url["radius"])
        XCTAssertEqual(session!.lastURL!["ll"], url["ll"])
        XCTAssertEqual(session!.lastURL!["v"], url["v"])
        XCTAssertEqual(session!.lastURL!["client_id"], url["client_id"])
        XCTAssertEqual(session!.lastURL!["client_secret"], url["client_secret"])
        XCTAssertEqual(session!.lastURL!["offset"], url["offset"])
    }
}
