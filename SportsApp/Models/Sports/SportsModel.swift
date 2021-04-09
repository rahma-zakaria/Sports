
import Foundation
struct SportsModel : Codable {
	let sports : [Sports]?

	enum CodingKeys: String, CodingKey {

		case sports = "sports"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		sports = try values.decodeIfPresent([Sports].self, forKey: .sports)
	}
    init(){
        sports = []
        print("init")
    }

}
