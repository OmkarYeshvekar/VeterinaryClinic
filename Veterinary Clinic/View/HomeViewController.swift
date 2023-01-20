//
//  HomeViewController.swift
//  Veterinary Clinic
//
//  Created by Yeshvekar.Suresh on 14/01/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
        
    lazy var viewModel: HomeViewModelProtocol = {
        let apiFetcher = APIFetcher(networkManager: NetworkManager())
        let viewModel = HomeViewModel(apiFetcher: apiFetcher)
        return viewModel
    }()
    
    var tableViewData = [[String: Any]]()
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        setupLoader()
        
        viewModel.completionForAPIFailureMessage = { [weak self] message in
            guard let self = self else { return }
            self.showAPIFailureErrorMessage(message: message)
        }
        
        viewModel.completionToReloadTableView = { [weak self] tableData in
            guard let self = self else { return }
            self.relaodTableView(tableViewData: tableData)
        }
        
        viewModel.showProgress = { [weak self] in
            guard let self = self else { return }
            self.showProgress()
        }
        
        viewModel.hideProgress = { [weak self] in
            guard let self = self else { return }
            self.hideProgress()
        }
        
        viewModel.handleApiCalls()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}


//MARK: HomeViewController: tableView datasource
extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = tableViewData[section]
        
        if let _ = model[TableDataCellConstants.configScreenModel] as? ConfigScreenModel {
            return 1
        }
        else if let data = model[TableDataCellConstants.petScreenModel] as? [PetsInformationScreenModel] {
            return data.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = tableViewData[indexPath.section]

        if let data = model[TableDataCellConstants.configScreenModel] as? ConfigScreenModel {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: StringConstants.contactDetailsTableViewCell,
                                                     for: indexPath) as! ContactDetailsTableViewCell
            cell.selectionStyle = .none
            cell.setArrangeContactButtons(data: data)
            
            cell.chatButtonClicked = { [weak self] message in
                guard let self = self else { return }
                debugPrint(message)
                self.showAlert(message: message)
            }
            
            cell.callButtonClicked = { [weak self] message in
                guard let self = self else { return }
                debugPrint(message)
                self.showAlert(message: message)
            }
            
            cell.contactMethodButtonClicked = { [weak self] message in
                guard let self = self else { return }
                debugPrint(message)
                self.showAlert(message: message)
            }
            
            return cell
        }
        else if let data = model[TableDataCellConstants.petScreenModel] as? [PetsInformationScreenModel] {
            
            let cell: PetInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: StringConstants.petInfoTableViewCell,
                                                                           for: indexPath) as! PetInfoTableViewCell
            cell.selectionStyle = .none
            let cellData = data[indexPath.row]
            
            ImageLoader.sharedInstance.imageForUrl(urlString: cellData.imageUrl,
                                                   completionHandler: { (image, url) in
                
                DispatchQueue.main.async {
                    if image != nil {
                        cell.petImageView.image = image
                    }
                }
            })
            
            cell.petName.text = cellData.petName
            
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
}


//MARK: HomeViewController: tableView delegates
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = tableViewData[indexPath.section]
        if let data = model[TableDataCellConstants.petScreenModel] as? [PetsInformationScreenModel] {
            let cellData = data[indexPath.row]
            let contentUrl = cellData.contentUrl
            navigateToPetsInfoScreen(contentUrl: contentUrl)
        }
    }
}


//MARK: HomeViewController: private func
extension HomeViewController {
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(UINib(nibName: StringConstants.contactDetailsTableViewCell, bundle: nil),
                                forCellReuseIdentifier: StringConstants.contactDetailsTableViewCell)
        tableView.register(UINib(nibName: StringConstants.petInfoTableViewCell, bundle: nil),
                           forCellReuseIdentifier: StringConstants.petInfoTableViewCell)
    }
    
    private func setupLoader() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = UIColor.gray
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func showProgress() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view.isUserInteractionEnabled = false
            self.activityIndicator.startAnimating()
            self.activityIndicator.isHidden = false
        }
    }
    
    private func hideProgress() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view.isUserInteractionEnabled = true
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
    
    private func relaodTableView(tableViewData: [[String : Any]]) {
        self.tableViewData = tableViewData
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    private func showAPIFailureErrorMessage(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: StringConstants.ok, style: .default, handler: { _ in
            //TODO: need to handle Try Again Action.
        })
        
        alertController.addAction(alertAction)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    private func navigateToPetsInfoScreen(contentUrl: String) {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PetsInformationViewController") as? PetsInformationViewController else { return }
        let viewModel = PetsInformationViewModel(contentUrl: contentUrl)
        viewModel.view = viewController
        viewController.viewModel = viewModel
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: StringConstants.ok, style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
