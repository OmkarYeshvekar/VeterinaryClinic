//
//  MockHomeViewController.swift
//  Veterinary ClinicTests
//
//  Created by Yeshvekar.Suresh on 18/01/23.
//

import Foundation
@testable import Veterinary_Clinic

class MockHomeViewController {
    
    var reloadTableViewCalled = false
    var showAPIFailureErrorMessageCalled = false
    var showProgressCalled = false
    var hideProgressCalled = false
    
    func relaodTableView(tableViewData: [[String : Any]]) {
        reloadTableViewCalled = true
    }
    
    func showAPIFailureErrorMessage(message: String) {
        showAPIFailureErrorMessageCalled = true
    }
    
    func showProgress() {
        showProgressCalled = true
    }
    
    func hideProgress() {
        hideProgressCalled = true
    }
}
