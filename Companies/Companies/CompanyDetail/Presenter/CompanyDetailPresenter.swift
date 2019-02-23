//
//  CompanyDetailPresenter.swift
//  Companies
//
//  Created by Andrea Agudo on 23/02/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import Foundation

protocol CompanyDetailView {
    func companiesDataReceived()
    func setData(_ data: Company)
    func error(err: WebError<CustomError>)
}

class CompanyDetailPresenter {

    let companiesService: CompaniesService
    var companyDetailView: CompanyDetailView?

    init(companiesService: CompaniesService) {
        self.companiesService = companiesService
    }

    func attachView(_ view: CompanyDetailView) {
        companyDetailView = view
    }

    func detachView() {
        companyDetailView = nil
    }

    func getCompanyDetail(id: Int) {
        companiesService.getCompanyDetail(id: id) { (response) in
            switch response {
            case .success(let data):
                self.companyDetailView?.setData(data)
            case .failure(let error):
                self.companyDetailView?.error(err: error)
            }
        }

    }

}
