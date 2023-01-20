//
//  ImageLoaderTest.swift
//  Veterinary ClinicTests
//
//  Created by Yeshvekar.Suresh on 19/01/23.
//

import XCTest
@testable import Veterinary_Clinic

class ImageLoaderTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_imageFromUrl_success() {
        let expectation = self.expectation(description: "downlaod image from url")
        ImageLoader.sharedInstance.imageForUrl(urlString: "https://upload.wikimedia.org/wikipedia/commons/3/30/RabbitMilwaukee.jpg",
                                               completionHandler: { (image, url) in
            XCTAssertNotNil(image)
            expectation.fulfill()
        })
        self.wait(for: [expectation], timeout: 10)
    }
    
    func test_imageFromUrl_failure_emptyUrl() {
        let expectation = self.expectation(description: "downlaod image from empty url")
        ImageLoader.sharedInstance.imageForUrl(urlString: "",
                                               completionHandler: { (image, url) in
            XCTAssertNil(image)
            expectation.fulfill()
        })
        self.wait(for: [expectation], timeout: 10)
    }
    
    func test_imageFromUrl_cacheImage() {
        let expectation = self.expectation(description: "getting image which is already cached")
        ImageLoader.sharedInstance.imageForUrl(urlString: "https://upload.wikimedia.org/wikipedia/commons/3/30/RabbitMilwaukee.jpg",
                                               completionHandler: { (image, url) in
            XCTAssertNotNil(image)
            expectation.fulfill()
        })
        self.wait(for: [expectation], timeout: 10)
    }
    
    func test_imageFromUrl_failure_incorrectUrl() {
        let expectation = self.expectation(description: "download image from an incorrect URL")
        ImageLoader.sharedInstance.imageForUrl(urlString: "https://upload.wikimedia",
                                               completionHandler: { (image, url) in
            XCTAssertNil(image)
            expectation.fulfill()
        })
        self.wait(for: [expectation], timeout: 10)
    }
}
