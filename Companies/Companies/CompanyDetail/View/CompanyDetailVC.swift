//
//  CompanyDetailVC.swift
//  Companies
//
//  Created by Andrea Agudo on 23/02/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import UIKit

final class CompanyDetailVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var customizedView: UIView!
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var countryTitleLabel: UILabel!

    private let companyDetailPresenter = CompanyDetailPresenter(companiesService: CompaniesService())

    static let cvIdentifier = "companyDetailVC"
    var companyToSearch: Company? {
        didSet {
            getDetail()
        }
    }
    var companyDetail: Company? {
        didSet {
            DispatchQueue.main.async {
                self.setData()
            }
        }
    }

    var timer = Timer()
    var secondsToReload = 20.0

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        setLocale()
        setTimer()
    }

    deinit {
        print("CompanyDetailVC was de-initialized")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
    }

    private func initView() {
        title = companyToSearch?.name
        companyDetailPresenter.attachView(self)
        customizedView.setCustomizedShadow()
    }

    private func setLocale() {
        descriptionTitleLabel.text = localized("description")
        countryTitleLabel.text = localized("country")
    }

    // MARK: Timer
    private func setTimer() {
        self.timer = Timer(timeInterval: secondsToReload, target: self, selector: #selector(getDetail), userInfo: nil, repeats: true)
        RunLoop.main.add(self.timer, forMode: RunLoop.Mode.default)
    }

    @objc private func getDetail() {
        guard let companyToSearch = companyToSearch, let id = companyToSearch.id else { return }
        companyDetailPresenter.getCompanyDetail(id: id)
    }

    private func setData() {
        guard let companyDetail = companyDetail else { return }
        nameLabel.text = companyDetail.name
        if let price = companyDetail.sharePrice {
            priceLabel.text = "$ " + price.description
        }
        descriptionLabel.text = companyDetail.description
        countryLabel.text = companyDetail.country
    }

    // MARK: Errors
    private func handleError(_ error: WebError<CustomError>) {
        switch error {
        case .noInternetConnection:
            showErrorAlert(with: "The internet connection is lost")
        case .unauthorized:
            showErrorAlert(with: "Unautohorized")
        case .other:
            showErrorAlert(with: "Unfortunately something went wrong")
        case .custom(let error):
            showErrorAlert(with: error.message)
        }
    }

    private func showErrorAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension CompanyDetailVC: CompanyDetailView {
    func companiesDataReceived() {}

    func setData(_ data: Company) {
        self.companyDetail = data
    }

    func error(err: WebError<CustomError>) {
        self.handleError(err)
    }

}
