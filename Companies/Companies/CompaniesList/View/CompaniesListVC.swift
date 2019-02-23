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

    private var lastResults: [Company]?
    private var results: [Company]? {
        didSet {
            DispatchQueue.main.async {
                if let lastResults = self.lastResults {
                    guard let results = self.results else {
                        return
                    }
                    self.companiesTableView.insertAndDeleteCellsForObjects(objects: results, originalObjects: lastResults)
                    self.lastResults = self.results
                    return
                } else {
                    self.lastResults = self.results
                    self.companiesTableView.reloadData()
                }
            }
        }
    }

    var timer: Timer?
    var secondsToReload = 20.0

    override func viewDidLoad() {
        super.viewDidLoad()
        setTable()
        configureView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTimer()
    }

    private func configureView() {
        companiesPresenter.attachView(self)
        title = "Companies"
    }

    // MARK: Segue
    private func goToDetail(with company: Company) {
        let storyboard = Storyboard.main
        if let controller = storyboard.instantiateViewController(withIdentifier: CompanyDetailVC.cvIdentifier) as? CompanyDetailVC {
            controller.companyToSearch = company
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }

    // MARK: TableView
    private func setTable() {
        companiesTableView.delegate = self
        companiesTableView.dataSource = self
        companiesTableView.tableFooterView = UIView()
    }

    // MARK: Timer
    private func setTimer() {
        self.timer = Timer(timeInterval: secondsToReload, target: self, selector: #selector(callCompanies), userInfo: nil, repeats: true)
        if let timer = self.timer {
            RunLoop.main.add(timer, forMode: RunLoop.Mode.default)
        }
        timer?.fire()
    }

    // MARK: getCompanies
    @objc private func callCompanies() {
          companiesPresenter.getCompanies()
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

extension CompaniesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let results = self.results else {
            return 0
        }
        return results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: CompanyCell.identifier, for: indexPath) as? CompanyCell,
            let results = self.results else {
            return UITableViewCell()
        }

        let company = results[indexPath.row]
        cell.company = company

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let  results = self.results else { return }
        let selected = results[indexPath.row]
        goToDetail(with: selected)
        tableView.deselectRow(at: indexPath, animated: true)
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

    func setData(_ data: [Company]) {
        self.results = data
    }

    func getCompanies() {}
}
