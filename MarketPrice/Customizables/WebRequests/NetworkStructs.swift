//
//  NetworkStructs.swift
//  MarketPrice
//
//  Created by Emiliano Alfredo Martinez Vazquez on 08/04/21.
//

import Foundation

struct Resource<T: Codable> {
    let url: URL
    let parameters: AnyEncodable?
    let authorizationKey: String?
    let membership: String?
    
    init(url: URL, parameters: AnyEncodable? = nil, authorizationKey: String?, membership: String?) {
        self.url = url
        self.parameters = parameters
        self.authorizationKey = authorizationKey
        self.membership = membership
    }
}

struct AnyEncodable: Encodable {
    let value: Encodable

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try value.encode(to: &container)
    }
}

extension Encodable {
    func encode(to container: inout SingleValueEncodingContainer) throws {
        try container.encode(self)
    }
}

struct ServiceError: Initiable {
    
    let code: String?
    let description: String?
    let httpStatusCode: Int?
    
    init() {
        self.code = ""
        self.description = ""
        self.httpStatusCode = 0
    }
}
