
import Foundation
struct EventsModel : Codable {
	let events : [Events]?

	enum CodingKeys: String, CodingKey {

		case events = "events"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		events = try values.decodeIfPresent([Events].self, forKey: .events)
	}

}
