//
//  PetsInformationViewController.swift
//  Veterinary Clinic
//
//  Created by Yeshvekar.Suresh on 16/01/23.
//

import UIKit
import WebKit


protocol PetsInformationViewControllerProtocol {
    func loadWebView(request: URLRequest)
}

class PetsInformationViewController: UIViewController {
    
    var viewModel: PetsInformationViewModelProtocol?
    
    private lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setWebView()
        viewModel?.configUrlForWebView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setWebView() {
        self.view.backgroundColor = .white
        self.view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: self.view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension PetsInformationViewController: PetsInformationViewControllerProtocol {

    func loadWebView(request: URLRequest) {
        webView.load(request)
    }
}

extension PetsInformationViewController: WKUIDelegate {
    
}
