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
        session = NetworkSessionMock()
        session.data = data
        service = Service(environment: Environment(host: API.BaseUrl.Host), session: session)
    }

    override func tearDown() {
        session = nil
        service = nil
        data = Data(bytes: [])
    }

    func testSuccessfulResponse() {
        var result: NetworkResponse?
        service.execute(request: NetworkRequest(path: "", parameters: [:]), completion: { result = $0 })
        XCTAssertEqual(result?.data, data)
    }
}
