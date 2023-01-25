//
//  HomeViewModelTest.swift
//  Veterinary ClinicTests
//
//  Created by Yeshvekar.Suresh on 18/01/23.
//

import XCTest
@testable import Veterinary_Clinic

class HomeViewModelTest: XCTestCase {
    
    var homeViewModel: HomeViewModel?
    var mockApiFetcher: MockAPIFetcher?
    var mockOfficeHourHelper: MockOfficeHourHelper?
    var mockHomeViewController: MockHomeViewController?
    
    override func setUp() {
        mockApiFetcher = MockAPIFetcher()
        mockOfficeHourHelper = MockOfficeHourHelper()
        homeViewModel = HomeViewModel(apiFetcher: mockApiFetcher,
                                      officeHourHelper: mockOfficeHourHelper)
        mockHomeViewController = MockHomeViewController()
        
        homeViewModel?.completionToReloadTableView = { tableData in
            self.mockHomeViewController?.relaodTableView(tableViewData: tableData)
        }
        
        homeViewModel?.showProgress = {
            self.mockHomeViewController?.showProgress()
        }
        
        homeViewModel?.hideProgress = {
            self.mockHomeViewController?.hideProgress()
        }
    }
    
    override func tearDown() {
        homeViewModel = nil
        mockApiFetcher = nil
        mockHomeViewController = nil
    }
    
    func test_handleApiCalls() {
        
        homeViewModel?.handleApiCalls()
        XCTAssertTrue(mockApiFetcher?.getClinicConfigurationCalled ?? false)
        XCTAssertNotNil(homeViewModel?.configInfo)
        XCTAssertNotNil(homeViewModel?.tableViewData)
        
        let model = homeViewModel?.tableViewData[0]
        
        if let data = model?[TableDataCellConstants.configScreenModel] as? ConfigScreenModel {

            XCTAssertTrue(data.isCallEnabled)
            XCTAssertTrue(data.isChatEnabled)
            XCTAssertEqual(data.officeHours, "M-F 9:00 - 18:00")
        }
        
        XCTAssertTrue(mockApiFetcher?.getClinicPetsInformationCalled ?? false)
        XCTAssertNotNil(homeViewModel?.petInfo)
        XCTAssertNotNil(homeViewModel?.tableViewData)
        
        let model1 = homeViewModel?.tableViewData[1]
        
        if let data1 = model1?[TableDataCellConstants.petScreenModel] as? [PetsInformationScreenModel] {
            XCTAssertEqual(data1.count, 10)
        }
        XCTAssertTrue(mockHomeViewController?.showProgressCalled ?? false)
        XCTAssertTrue(mockHomeViewController?.hideProgressCalled ?? false)
        XCTAssertTrue(mockHomeViewController?.reloadTableViewCalled ?? false)
    }
    
    func test_handleApiCalls_ConfigSettings_Failure() {

        let mockAPIFetcher = MockAPIFetcher(executionCases: .failure)
//        let mockOfficeHourhelper = MockOfficeHourHelper()
        let homeViewModel = HomeViewModel(apiFetcher: mockAPIFetcher, officeHourHelper: mockOfficeHourHelper)

        homeViewModel.completionForAPIFailureMessage = { message in
            self.mockHomeViewController?.showAPIFailureErrorMessage(message: message)
        }

        homeViewModel.apiCallForClinicConfiguration {
        }

        XCTAssertTrue(mockAPIFetcher.getClinicConfigurationCalled)
        XCTAssertNil(homeViewModel.configInfo)

        XCTAssertTrue(mockHomeViewController?.showAPIFailureErrorMessageCalled ?? false)
    }
    
    func test_handleApiCalls_PetsInformation_Failure() {

        let mockAPIFetcher = MockAPIFetcher(executionCases: .failure)
        let homeViewModel = HomeViewModel(apiFetcher: mockAPIFetcher, officeHourHelper: mockOfficeHourHelper)

        homeViewModel.completionForAPIFailureMessage = { message in
            self.mockHomeViewController?.showAPIFailureErrorMessage(message: message)
        }

        homeViewModel.apiCallForClinicPetsInformation {
        }

        XCTAssertTrue(mockAPIFetcher.getClinicPetsInformationCalled)
        XCTAssertNil(homeViewModel.petInfo)
        XCTAssertTrue(mockHomeViewController?.showAPIFailureErrorMessageCalled ?? false)
    }
    
    func test_checkClinicTimings() {
        homeViewModel?.officeHours = "M-F 9:00 - 18:00"
        _ = homeViewModel?.checkClinicTimings(currentDate: Date())
        XCTAssertTrue(mockOfficeHourHelper?.determineOfficeHoursCalled ?? false)
    }
}
