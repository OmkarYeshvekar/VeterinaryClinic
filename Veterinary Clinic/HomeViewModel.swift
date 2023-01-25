//
//  HomeViewModel.swift
//  Veterinary Clinic
//
//  Created by Yeshvekar.Suresh on 14/01/23.
//

import Foundation

protocol HomeViewModelProtocol {
    var completionForAPIFailureMessage: (_ message: String) -> Void { get set }
    var completionToReloadTableView: (_ tableViewData: [[String: Any]]) -> Void { get set }
    var showProgress: () -> Void { get set }
    var hideProgress: () -> Void { get set }
    func handleApiCalls()
    func checkClinicTimings(currentDate: Date) -> String
}

struct TableDataCellConstants {
    static let configScreenModel = StringConstants.configScreenModel
    static let petScreenModel = StringConstants.petScreenModel
}

class HomeViewModel: HomeViewModelProtocol {
    
    var tableViewData = [[String: Any]]()
    var configInfo: ConfigScreenModel? = nil
    var petInfo: [PetsInformationScreenModel]? = nil
    var apiFetcher: APIFetcherProtocol?
    
    var officeHours: String?
    
    var completionForAPIFailureMessage: (_ message: String) -> Void = { _ in }
    var completionToReloadTableView: (_ tableViewData: [[String: Any]]) -> Void = { _ in }
    var showProgress: () -> Void = {}
    var hideProgress: () -> Void = {}
    
    init(apiFetcher: APIFetcherProtocol?) {
        self.apiFetcher = apiFetcher
    }
    
    func handleApiCalls() {
        tableViewData = []

        showProgress()
        apiCallForClinicConfiguration { [weak self] in
            guard let self = self else { return }
            guard let config = self.configInfo else { return }
            self.tableViewData.append([TableDataCellConstants.configScreenModel: config])
            
            self.apiCallForClinicPetsInformation {
                guard let petsInfo = self.petInfo else { return }
                self.tableViewData.append([TableDataCellConstants.petScreenModel: petsInfo])
                self.completionToReloadTableView(self.tableViewData)
            }
        }
    }
    
    
    func apiCallForClinicConfiguration(completion: @escaping () -> Void) {
        let urlString = StringConstants.clinicConfigurationApi
        apiFetcher?.getClinicConfiguration(urlString: urlString, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.mapConfigScreenModel(response: response)
                completion()
                
            case .failure(let error):
                self.hideProgress()
                self.completionForAPIFailureMessage(error.text)
            }
        })
    }
    
    func apiCallForClinicPetsInformation(completion: @escaping () -> Void) {
        let urlString = StringConstants.clinicPetsInformationApi
        apiFetcher?.getClinicPetsInformation(urlString: urlString, completion: { [weak self] result in
            guard let self = self else { return }
            self.hideProgress()
            switch result {
            case .success(let response):
                self.mapPetsInformation(response: response)
                completion()
                
            case .failure(let error):
                self.completionForAPIFailureMessage(error.text)
            }
        })
    }
    
    
    private func mapConfigScreenModel(response: ConfigSettingsResponseModel) {
        
        let settings = response.settings
        var configInfo = ConfigScreenModel()
        configInfo = ConfigScreenModel(isChatEnabled: settings.isChatEnabled,
                                       isCallEnabled: settings.isCallEnabled,
                                       officeHours: settings.workHours ?? StringConstants.defaultWorkHours)
        self.configInfo = configInfo
        self.officeHours = self.configInfo?.officeHours
    }
    
    
    private func mapPetsInformation(response: PetsInformationResponseModel) {
        
        let pets = response.pets
        var petsInfo = [PetsInformationScreenModel]()
        
        for index in pets {
            
            let petInfo = PetsInformationScreenModel(petName: index.title ?? "",
                                                     imageUrl: index.image_url ?? "",
                                                     contentUrl: index.content_url ?? "")
            petsInfo.append(petInfo)
        }
        self.petInfo = petsInfo
    }
    
    
    func checkClinicTimings(currentDate: Date) -> String {
        
        guard let officeHour = self.officeHours else { return StringConstants.issueInContactingClinic }
        let officeHours = OfficeHourHelper()
        return officeHours.determineOfficeHours(officeHours: officeHour,
                                         currentDate: currentDate)
    }
    
}
