//
//  ApiModel.swift
//  SportsApp
//
//  Created by rahma zakaria on 3/25/21.
//

import Foundation
import Alamofire

class ApiModal {
    static let instance = ApiModal()
    func getData<T :Decodable>(url: String, completion: @escaping (T?,Error?)->Void) {
        Alamofire.request(url).responseJSON { (response) in
            guard let data = response.data else{ return }
            switch response.result{
            case .success(_):
                    do {
                        let myData = try JSONDecoder().decode(T.self, from: data)
                        completion(myData, nil)
                    } catch let jsonError {
                        print(jsonError)
                    }
            case .failure(let error):
                completion(nil,error)
            }
        }
    }
}

