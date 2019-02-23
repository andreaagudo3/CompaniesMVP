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

    static let cvIdentifier = "companyDetailVC"
    var companyToSearch: Company? {
        didSet {
            getDetail()
        }
    }
    var companyDetail: Company? {
        didSet {
            setData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    private func initView() {
        title = companyToSearch?.name
    }

    private func getDetail() {
        guard let companyToSearch = companyToSearch else { return }
    }

    private func setData() {
        guard let companyDetail = companyDetail else { return }

    }
}
