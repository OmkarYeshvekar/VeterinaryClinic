//
//  ImageLoaderTest.swift
//  Veterinary ClinicTests
//
//  Created by Yeshvekar.Suresh on 19/01/23.
//

import XCTest
@testable import Veterinary_Clinic

class ImageLoaderTest: XCTestCase {

    func test_imageFromUrl_success() {

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)

        if let imageData = UIImage(named: "Ferret.png")?.pngData() {
            MockURLProtocol.stubResponseData = imageData
            MockURLProtocol.responseStatusCode = 200
        }

        let expectation = self.expectation(description: "downlaod image from url")

        let imageLoader = ImageLoader.sharedInstance
        imageLoader.urlSession = urlSession

        imageLoader.imageForUrl(urlString: "https://upload.wikimedia.org/wikipedia/commons/3/32/Ferret_2008.png",
                                               completionHandler: { (image, url) in
            XCTAssertNotNil(image)
            expectation.fulfill()
        })
        self.wait(for: [expectation], timeout: 5)
    }

    func test_imageFromUrl_failure_emptyUrl() {

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)

        MockURLProtocol.responseStatusCode = 404

        let imageLoader = ImageLoader.sharedInstance
        imageLoader.urlSession = urlSession

        let expectation = self.expectation(description: "downlaod image from empty url")
        imageLoader.imageForUrl(urlString: "",
                                               completionHandler: { (image, url) in
            XCTAssertNil(image)
            expectation.fulfill()
        })
        self.wait(for: [expectation], timeout: 5)
    }
}
