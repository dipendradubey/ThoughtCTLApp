//
//  GalleryApiResourceUnitTests.swift
//  ThoughtCTLAppTests
//
//  Created by Dipendra Dubey on 16/12/23.
//

import XCTest
import Combine
@testable import ThoughtCTLApp

final class GalleryApiResourceUnitTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Do Clenup
    override func tearDown() {
        super.tearDown()
        cancellables.forEach { $0.cancel() }
    }
    
    // MARK: - Test Cases
    func test_FetchGalleryData(){
        let searchText = "Cat"
        let request = Api.gallery(queryParam: "gallery/search/top/week/1?q=\(searchText)")
            .getURLRequest()
        XCTAssertNotNil(request, "Request should not be nil")
        
        let expectation = self.expectation(description: "API Call Expectation")
        HTTPClient.shared.getData(request: request!, responseType: GalleryRootModel.self)
            .sink { value in
                switch value{
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("API call failed with error: \(error)")
                    
                }
                expectation.fulfill()
            } receiveValue: { galleryArr in
                // Add assertions based on the expected API response
                XCTAssertNotNil(galleryArr, "Received data should not be nil")
                XCTAssertFalse(galleryArr.data.isEmpty, "Result is empty")
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 5.0)
        
    }
    

}
