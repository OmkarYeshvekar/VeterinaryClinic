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
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.configUrlForWebView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
}

extension PetsInformationViewController: PetsInformationViewControllerProtocol {

    func loadWebView(request: URLRequest) {
        webView.load(request)
    }
}

extension PetsInformationViewController: WKUIDelegate {
    
}
