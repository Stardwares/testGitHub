//
//  SearchItem.swift
//  TestProjectJson
//
//  Created by Вадим Пустовойтов on 09/09/2019.
//  Copyright © 2019 Вадим Пустовойтов. All rights reserved.
//

import Foundation

struct SearchItem: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case description
    }
    
    let id: Int
    let fullName: String
    let description: String?
    
    public init(id: Int, fullName: String, description: String?) {
        self.id = id
        self.fullName = fullName
        self.description = description
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        fullName = try container.decode(String.self, forKey: .fullName)
        description = try? container.decode(String.self, forKey: .description)
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(fullName, forKey: .fullName)
        try? container.encode(description, forKey: .description)
    }
    
}
