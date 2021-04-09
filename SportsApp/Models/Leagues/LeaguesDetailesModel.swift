//
//  LeaguesDetailesModel.swift
//  SportsApp
//
//  Created by rahma zakaria on 3/26/21.
//

import Foundation

struct LeaguesDetailesModel:  Codable {
    let leagues : [LeaguesDetailes]?

    enum CodingKeys: String, CodingKey {

        case leagues = "leagues"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        leagues = try values.decodeIfPresent([LeaguesDetailes].self, forKey: .leagues)
    }

}
