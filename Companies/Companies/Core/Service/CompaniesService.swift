//
//  CompaniesService.swift
//  Companies
//
//  Created by Andrea Agudo on 17/02/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import UIKit

protocol CompaniesServiceProtocol {
    func getCompanies(completion: @escaping (Result<CompaniesResponse, CustomError>) -> Void)
}

class CompaniesService: CompaniesServiceProtocol {

    let key = URLKeys.getCompanies.key
    var sharedWebClient: WebClient {
        if let path = Bundle.main.path(forResource: "APIProperties", ofType: "plist"),
            let properties = NSDictionary(contentsOfFile: path),
            let plistURL = properties.object(forKey: key) as? String {
            return WebClient(baseUrl: plistURL)
        }
        return WebClient(baseUrl: "")
    }

    internal func getCompanies(completion: @escaping (Result<CompaniesResponse, CustomError>) -> Void) {
        let companiesResource = Resource<CompaniesResponse, CustomError>(jsonDecoder: JSONDecoder(), path: "")
        sharedWebClient.load(resource: companiesResource) { response in
            if let companies = response.value {
                completion(Result.success(companies))
            } else if let error = response.error {
                completion(Result.failure(error))
            }
        }
    }

//    internal func getCompanyDetail(id: Int, companiesRequest: GetCompanyDetailRequest, completion: @escaping ResultCallback<Company>) {
//        apiClient.perform(request: companiesRequest) { (transaction) in
//            switch transaction {
//            case .success(let data):
//                completion(Result.success(data))
//            case .failure(let error):
//                Log.debug(error.localizedDescription)
//                completion(Result.failure(ResultError.global))
//            }
//        }
//    }
}
