//
//  ViewController.swift
//  Companies
//
//  Created by Andrea Agudo on 16/02/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import UIKit

final class CompaniesListVC: UIViewController {

    @IBOutlet weak var companiesTableView: UITableView!

    private let companiesPresenter = CompaniesPresenter(companiesService: CompaniesService())

    private var lastResults: CompaniesResponse?
    private var results: CompaniesResponse? {
        didSet {
            DispatchQueue.main.async {
                guard let lastResults = self.lastResults else {
                    self.companiesTableView.reloadData()
                    return
                }

                 guard let results = self.results else {
                    return
                }

                self.companiesTableView.insertAndDeleteCellsForObjects(objects: results.companies, originalObjects: lastResults.companies)
                self.lastResults = self.results

            }
        }
    }

    var timer = Timer()
    var secondsToReload = 20.0

    override func viewDidLoad() {
        super.viewDidLoad()
        setTable()
        configureView()
        callCompanies()
        setTimer()
    }

    private func configureView() {
        companiesPresenter.attachView(self)
        title = "Companies"
    }

    private func setTable() {
        companiesTableView.delegate = self
        companiesTableView.dataSource = self
        companiesTableView.tableFooterView = UIView()
    }

    private func setTimer() {
        self.timer = Timer(timeInterval: secondsToReload, target: self, selector: #selector(callCompanies), userInfo: nil, repeats: true)
        RunLoop.main.add(self.timer, forMode: RunLoop.Mode.default)
    }

    @objc private func callCompanies() {
          companiesPresenter.getCompanies()
    }

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

extension CompaniesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let results = self.results else {
            return 0
        }
        return results.companies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: CompanyCell.identifier, for: indexPath) as? CompanyCell,
            let results = self.results else {
            return UITableViewCell()
        }

        let company = results.companies[indexPath.row]
        cell.company = company

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

extension CompaniesListVC: CompaniesListView {
    func error(err: WebError<CustomError>) {
        self.handleError(err)
    }

    func companiesDataReceived() {

    }

    func setData(_ data: CompaniesResponse) {
        self.results = data
    }

    func getCompanies() {}
}
