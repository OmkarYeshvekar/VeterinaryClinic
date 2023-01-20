//
//  PetsInformationViewModel.swift
//  Veterinary Clinic
//
//  Created by Yeshvekar.Suresh on 16/01/23.
//

import Foundation

protocol PetsInformationViewModelProtocol {
    func configUrlForWebView()
}

class PetsInformationViewModel: PetsInformationViewModelProtocol {
    
    var contentUrl: String
    var view: PetsInformationViewControllerProtocol?
    
    init(contentUrl: String) {
        self.contentUrl = contentUrl
    }
    
    func configUrlForWebView() {
        guard let myURL = URL(string: self.contentUrl) else { return }
        let request = URLRequest(url: myURL)
        view?.loadWebView(request: request)
    }
}
