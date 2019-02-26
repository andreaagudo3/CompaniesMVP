//
//  CompaniesPresenter.swift
//  Companies
//
//  Created by Andrea Agudo on 16/02/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

protocol CompaniesListView: AnyObject {
    func companiesDataReceived()
    func setData(_ data: [Company])
    func error(err: WebError<CustomError>)
}

class CompaniesPresenter {

     let companiesService: CompaniesService
     weak var companiesView: CompaniesListView?

    init(companiesService: CompaniesService) {
        self.companiesService = companiesService
    }

    func attachView(_ view: CompaniesListView) {
        companiesView = view
    }

    func detachView() {
        companiesView = nil
    }

    func getCompanies() {
        companiesService.getCompanies { (response) in
            switch response {
            case .success(let data):
                let sorted = data.companies.sorted(by: { $1.sharePrice!.isLess(than: $0.sharePrice!) })
                self.companiesView?.setData(sorted)
            case .failure(let error):
                self.companiesView?.error(err: error)
            }
        }

    }

}
