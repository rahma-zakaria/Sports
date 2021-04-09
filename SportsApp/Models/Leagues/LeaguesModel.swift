
import Foundation
struct LeaguesModel : Codable {
	let leagues : [Leagues]?

	enum CodingKeys: String, CodingKey {

		case leagues = "leagues"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		leagues = try values.decodeIfPresent([Leagues].self, forKey: .leagues)
	}
    init(){
        leagues = []
    }
}
