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
    var mockHomeViewController: MockHomeViewController?
    
    override func setUp() {
        mockApiFetcher = MockAPIFetcher()
        homeViewModel = HomeViewModel(apiFetcher: mockApiFetcher)
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
            
            guard let isCallEnabled = data.isCallEnabled,
                  let isChatEnabled = data.isChatEnabled else { return }
            
            XCTAssertTrue(isCallEnabled)
            XCTAssertTrue(isChatEnabled)
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
        let homeViewModel = HomeViewModel(apiFetcher: mockAPIFetcher)

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
        let homeViewModel = HomeViewModel(apiFetcher: mockAPIFetcher)

        homeViewModel.completionForAPIFailureMessage = { message in
            self.mockHomeViewController?.showAPIFailureErrorMessage(message: message)
        }

        homeViewModel.apiCallForClinicPetsInformation {
        }

        XCTAssertTrue(mockAPIFetcher.getClinicPetsInformationCalled)
        XCTAssertNil(homeViewModel.petInfo)
        XCTAssertTrue(mockHomeViewController?.showAPIFailureErrorMessageCalled ?? false)
    }
    
    func test_OFH() throws {
        let currentDate = getCurrentDate(date: "2023-01-25T13:14:00+0000")
        homeViewModel?.officeHours = "M-F 9:00 - 17:00"
        let message = homeViewModel?.checkClinicTimings(currentDate: currentDate)
        XCTAssertEqual(message, StringConstants.workHourEndMessage)
    }
    
    func test_contactWithInOfficeHours() throws {
        let currentDate = getCurrentDate(date: "2023-01-25T10:44:00+0000")
        homeViewModel?.officeHours = "M-F 9:00 - 18:00"
        let message = homeViewModel?.checkClinicTimings(currentDate: currentDate)
        XCTAssertEqual(message, StringConstants.thankYouMessage)
    }
    
    func test_checkWeekEnd_OFH() throws {
        let currentDate = getCurrentDate(date: "2023-01-28T19:44:00+0000")
        homeViewModel?.officeHours = "M-F 9:00 - 18:00"
        let message = homeViewModel?.checkClinicTimings(currentDate: currentDate)
        XCTAssertEqual(message, StringConstants.workHourEndMessage)
    }
    
    private func getCurrentDate(date: String) -> Date {
        let isoDate = date
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:isoDate)!
        return date
    }
}
