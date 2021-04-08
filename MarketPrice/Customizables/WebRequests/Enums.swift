//
//  Enums.swift
//  MapTestAl
//
//  Created by Emiliano Alfredo Martinez Vazquez on 10/03/21.
//

import UIKit

public enum CodeResponse: Int {
    case ok = 200
    case content = 201
    case bad_request = 400
    case request_source_not_exist = 404
    case max_requests = 104
    case not_specific_date = 301
    case server_error = 500
    case unknow = 520
    case not_results = 106
    case not_connection = 100
    case bad_url = -1
    case bad_decodable = -2
    case not_implemented = -3
}

enum ImageMultiType: String {
    case front
}

enum NetworkError: String, Swift.Error {
    case decodingError = "Error al decodificar el objeto"
    case domainError = "Ocurrió un problema con el servidor"
    case urlError = "Ocurrió un error al obtener la información ser servidor"
}

enum HTTPMethods {
    static let GET: String = "GET"
    static let POST: String = "POST"
    static let PUT: String = "PUT"
    static let DELETE: String = "DELETE"
}
