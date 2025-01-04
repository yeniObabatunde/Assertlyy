//
//  SampleViewModel.swift
//  Assertly
//
//  Created by Sharon Omoyeni Babatunde on 06/07/2023.
//

import Foundation
import NetworkHandling

class AssertlySampleUseViewModel {
    
    private var networkHandler: NetworkHandling
    var userList: ((UserList?) -> Void)?
    var onError: ((Error) -> Void)?
    
    init(networkHandler: NetworkHandling) {
        self.networkHandler = networkHandler
    }
    
    func getUser() {
        networkHandler.request(with: AppConstants.BASE_URL, method: .GET, body: nil, headers: nil) { [weak self] (result: Result<UserList, Error>) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.userList?(user)
                    Logger.printIfDebug(data: "\(user): DATA GOTTEN SUCCESSFULLY", logType: .success)
                case .failure(let error):
                    self?.onError?(error)
                }
            }
        }
    }
}
