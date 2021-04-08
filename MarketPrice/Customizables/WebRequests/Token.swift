//
//  Token.swift
//  MarketPrice
//
//  Created by Emiliano Alfredo Martinez Vazquez on 08/04/21.
//

import Foundation

struct Token: Initiable {
    
    let access_token: String?
    let country: String?
    let token_type: String?
    let refresh_token: String?
    let expires_in: Int?
    let scope: String?
    let user_entity: Int?
    let user_id: Int?
    let user_system: Int?
    let jti: String?
    
    init() {
        self.access_token = ""
        self.country = ""
        self.token_type = ""
        self.refresh_token = ""
        self.expires_in = 0
        self.scope = ""
        self.user_entity = 0
        self.user_id = 0
        self.user_system = 0
        self.jti = ""
    }
}

struct TokenRequest: Initiable {
    
    var grant_type: String = ""
    var username: String = ""
    var password: String = ""
    var basic: String = ""
    
    init() {}
    
    init(grand_type: String, username: String, password: String, basic: String) {
        self.grant_type = grand_type
        self.username = username
        self.password = password
        self.basic = basic
    }
}

struct TrxToken: Initiable {
    
    let access_token: String?
    let businessId: Int?
    let corpLogo: String?
    let expires_in: Int?
    let jti: String?
    let refresh_token: String?
    let scope: String?
    let token_type: String?
    
    init() {
        self.access_token = ""
        self.businessId = 0
        self.corpLogo = ""
        self.expires_in = 0
        self.jti = ""
        self.refresh_token = ""
        self.scope = ""
        self.token_type = ""
    }
    
}

protocol Initiable: Codable {
    init()
}
