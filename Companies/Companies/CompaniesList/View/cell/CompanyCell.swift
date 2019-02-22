//
//  companyCell.swift
//  Companies
//
//  Created by Andrea Agudo on 22/02/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import UIKit

final class CompanyCell: UITableViewCell {

    @IBOutlet weak var customizedView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    static let identifier = "companyCell"
    static let nibName = "CompanyCell"

    var company: Company? {
        didSet {
            setData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }

    private func initView() {
        customizedView.setCustomizedShadow()
    }

    private func setData() {
        guard let company = self.company else { return }

        if let name =  company.name {
            titleLabel.text = name
        }
        if let price = company.sharePrice {
            priceLabel.text = price.description + " €"
        }
    }

}
