//
//  Model.swift
//  TestProjectJson
//
//  Created by Вадим Пустовойтов on 29/07/2019.
//  Copyright © 2019 Вадим Пустовойтов. All rights reserved.
//

import UIKit
import Alamofire

class Model: NSObject, XMLParserDelegate {
    static let shared = Model()
    let baseURL: String = "https://api.github.com"
    
    // распарсить JSON
    
    func parseSearchJson(search: String, complition: @escaping (SearchModel?) -> Void) {
        let urlStr = "\(baseURL)/search/repositories?q=\(search)&sort=stars&order=desc"
        guard let urlEncoding = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = URL(string: urlEncoding)!
        request(url).responseJSON { response in
            switch response.result {
            case .success(_):
                if let data = response.data {
                    do {
                        let object: SearchModel = try JSONDecoder().decode(SearchModel.self, from: data)
                        complition(object)
                    }
                    catch {
                        complition(nil)
                        print(error)
                    }
                }
                
            case .failure(let error):
                complition(nil)
                print(error)
            }
        }
    }
}
