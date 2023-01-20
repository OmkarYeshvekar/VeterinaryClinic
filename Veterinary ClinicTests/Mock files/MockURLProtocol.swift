//
//  MockURLProtocol.swift
//  Veterinary ClinicTests
//
//  Created by Yeshvekar.Suresh on 19/01/23.
//

import Foundation

class MockURLProtocol: URLProtocol {
    
    static var stubResponseData: Data?
    static var url: URL = URL(fileURLWithPath: "")
    static var responseStatusCode: Int = 200
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
//        self.client?.urlProtocol(self, didLoad: MockURLProtocol.stubResponseData ?? Data())
        
        let response: HTTPURLResponse = HTTPURLResponse(url: MockURLProtocol.url,
                                                        statusCode: MockURLProtocol.responseStatusCode,
                                                        httpVersion: nil,
                                                        headerFields: nil)!
        
        self.client?.urlProtocol(self, cachedResponseIsValid: CachedURLResponse(response: response,
                                                                                data: MockURLProtocol.stubResponseData ?? Data()))
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
    }
}
