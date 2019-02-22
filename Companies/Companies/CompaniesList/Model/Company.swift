//
//  Compaines.swift
//  Companies
//
//  Created by Andrea Agudo on 16/02/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import Foundation

struct Company: Decodable, Equatable {
    var id: Int?
    var name: String?
    var sharePrice: Float?
    var description: String?

    enum CodingKeys: String, CodingKey {
        case id, name, sharePrice, description
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: CodingKeys.id)
        name = try values.decodeIfPresent(String.self, forKey: CodingKeys.name)
        sharePrice = try values.decodeIfPresent(Float.self, forKey: CodingKeys.sharePrice)
        description = try values.decodeIfPresent(String.self, forKey: CodingKeys.description)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(sharePrice, forKey: .sharePrice)
        try container.encodeIfPresent(description, forKey: .description)
    }
}

struct CompaniesResponse: Decodable, Equatable {
    static func == (lhs: CompaniesResponse, rhs: CompaniesResponse) -> Bool {
        return lhs.companies == rhs.companies
    }

    var companies: [Company]

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        companies = try container.decodeArray(Company.self)
    }

    func encode(to encoder: Encoder) throws {}
}
