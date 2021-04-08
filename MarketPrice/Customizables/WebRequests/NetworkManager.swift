//
//  NetworkManager.swift
//  MarketPrice
//
//  Created by Emiliano Alfredo Martinez Vazquez on 08/04/21.
//

import Foundation

protocol WebService {
    func getRequest<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void)
    func postRequest<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void)
    func postRequest2<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void)
    func putRequest<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void)
    func postDataFormRequest(resource: TokenRequest, completion: @escaping (Result<Token, NetworkError>) -> Void)
}

class NetworkManager: WebService {

    // MARK: - putRequest
    
    /**
    ## Método utilizado para realizar una petición PUT a una API

    Método  que permite realizar una petición POST  tomando en cuenta un recurso proporcionado(url - parameters), este método a través de la implementación del Result Type es capaz de devolver un objeto esperado o una respuesta de error si es el caso.

    - Note: El método es genérico y puede devolver cualquier objeto decodeado.
    - Returns: El objeto decodeado requerido.
    - parameters:
        - resource: Este objeto contiene la url y los parametros requeridos para realizar la petición.
        - completion: Obtiene la respuesta del servicio y la maneja ccual sea el caso.
    - Version: 1.0
    - Author: David Valencia
     */
    
    func putRequest<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable, T : Encodable {
        
        guard let enconded = try? JSONEncoder().encode(resource.parameters) else {
            return
        }
        
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(resource.authorizationKey ?? "")"
        ]
        
        var request = URLRequest(url: resource.url)
        request.httpMethod = HTTPMethods.PUT
        request.timeoutInterval = 60
        request.httpBody = enconded
        request.allHTTPHeaderFields = headers
        
        let json = try? JSONSerialization.jsonObject(with: enconded, options: JSONSerialization.ReadingOptions.mutableContainers)
        print(json ?? (Any).self)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in

            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }

            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            print(json)
            let result = try? JSONDecoder().decode(T.self, from: data)
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
    
    func postRequest2<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable, T : Encodable {
        
        guard let enconded = try? JSONEncoder().encode(resource.parameters) else {
            return
        }
        
        let headers = [
            "Content-Type": "application/json"
        ]
        
        var request = URLRequest(url: resource.url)
        request.httpMethod = HTTPMethods.POST
        request.timeoutInterval = 60
        request.httpBody = enconded
        request.allHTTPHeaderFields = headers
        
        let json = try? JSONSerialization.jsonObject(with: enconded, options: JSONSerialization.ReadingOptions.mutableContainers)
        print(json ?? (Any).self)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in

            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }

            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            print(json)
            let result = try? JSONDecoder().decode(T.self, from: data)
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
    
    
    // MARK: - postRequest
    
    /**
    ## Método utilizado para realizar una petición POST a una API

    Método  que permite realizar una petición POST  tomando en cuenta un recurso proporcionado(url - parameters), este método a través de la implementación del Result Type es capaz de devolver un objeto esperado o una respuesta de error si es el caso.

    - Note: El método es genérico y puede devolver cualquier objeto decodeado.
    - Returns: El objeto decodeado requerido.
    - parameters:
        - resource: Este objeto contiene la url y los parametros requeridos para realizar la petición.
        - completion: Obtiene la respuesta del servicio y la maneja ccual sea el caso.
    - Version: 1.0
    - Author: David Valencia
     */
    
    func postRequest<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable, T : Encodable {
        
        guard let enconded = try? JSONEncoder().encode(resource.parameters) else {
            return
        }
        
        var headers: [String:String] = [String:String]()
        
        if let key = resource.authorizationKey {
            if let commerceId = resource.membership {
                headers = [
                    "Content-Type": "application/json",
                    "Authorization": "Bearer" + key,
                    "commerce-id": commerceId
                ]
            } else {
                headers = [
                    "Content-Type": "application/json",
                    "Authorization": "Bearer" + key
                ]
            }
        } else {
            if let commerceId = resource.membership {
                headers = [
                    "Content-Type": "application/json",
                    "Authorization": "Bearer \(resource.authorizationKey ?? "")",
                    "commerce-id": commerceId
                ]
            } else {
                headers = [
                    "Content-Type": "application/json",
                    "Authorization": "Bearer \(resource.authorizationKey ?? "")"
                ]
            }
        }

        print(resource.url)
        var request = URLRequest(url: resource.url)
        request.httpMethod = HTTPMethods.POST
        request.timeoutInterval = 60
        request.httpBody = enconded
        request.allHTTPHeaderFields = headers
        
        let json = try? JSONSerialization.jsonObject(with: enconded, options: JSONSerialization.ReadingOptions.mutableContainers)
        print(json ?? (Any).self)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in

            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }

            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            print(json)
            
            //---
            do {
                let r = try JSONDecoder().decode(T.self, from: data)
                print(r)
            } catch let error {
                print(error.self)
            }
            //---
            
            let result = try? JSONDecoder().decode(T.self, from: data)
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                DispatchQueue.main.async {
                    print(error?.localizedDescription)
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
    
    // MARK: - getRequest
    
    /**
    ## Método utilizado para realizar una petición GET a una API

    Método  que permite realizar una petición GET  tomando en cuenta un recurso proporcionado(url), este método a través de la implementación del Result Type es capaz de devolver un objeto esperado o una respuesta de error si es el caso.

    - Note: El método es genérico y puede devolver cualquier objeto decodeado.
    - Returns: El objeto decodeado requerido.
    - parameters:
        - resource: Este objeto contiene la url requeridA para realizar la petición.
        - completion: Obtiene la respuesta del servicio y la maneja ccual sea el caso.
    - Version: 1.0
    - Author: David Valencia
     */

    func getRequest<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable, T : Encodable {
        
        let headers: [String : String]
        if resource.authorizationKey == nil {
            headers = [
                "Content-Type": "application/json"
            ]
        } else {
            headers = [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(resource.authorizationKey ?? "")"
            ]
        }
        
        var request = URLRequest(url: resource.url)
        request.httpMethod = HTTPMethods.GET
        request.timeoutInterval = 60
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in

            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }

            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            print(json)
            let result = try? JSONDecoder().decode(T.self, from: data)
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
    
    // MARK: - For dataForm
    
    func postDataFormTrxRequest(resource: TokenRequest, completion: @escaping (Result<TrxToken, NetworkError>) -> Void) {
        
        let parameters = [
            [
                "key": "grant_type",
                "value": resource.grant_type,
                "type": "text"
            ],
            [
                "key": "username",
                "value": resource.username,
                "type": "text"
            ],
            [
                "key": "password",
                "value": resource.password,
                "type": "text"
        
            ]
        ]

        let boundary = "Boundary-\(UUID().uuidString)"
        var body = ""
        
        for param in parameters {
            if param["disabled"] == nil {
                let paramName = param["key"] ?? ""
                body += "--\(boundary)\r\n"
                body += "Content-Disposition:form-data; name=\"\(paramName)\""
                let paramType = param["type"] ?? ""
                
                if paramType == "text" {
                    let paramValue = param["value"] ?? ""
                    body += "\r\n\r\n\(paramValue)\r\n"
                } else {
                    let paramSrc = param["src"] ?? ""
                
                    if let fileData = try? NSData(contentsOfFile: paramSrc, options: .alwaysMapped) {
                        let fileContent = String(data: fileData as Data, encoding: .utf8) ?? ""
                        body += "; filename=\"\(paramSrc)\"\r\n" + "Content-Type: \"content-type header\"\r\n\r\n\(fileContent)\r\n"
                    }
                }
            }
        }
        
        body += "--\(boundary)--\r\n";
        
        let postData = body.data(using: .utf8)
        
        guard let url = URL(string: "http://34.194.162.119:9000/oauth/token") else { return }
//        guard let url = URL(string: "http://3.231.199.162:9000/oauth/token") else { return }

        var request = URLRequest(url: url,timeoutInterval: Double.infinity)
        request.addValue("Basic \(resource.basic)", forHTTPHeaderField: "Authorization")
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpMethod = HTTPMethods.POST
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            print(json)

            let result = try? JSONDecoder().decode(TrxToken.self, from: data)
            
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                completion(.failure(.decodingError))
            }
        }

        task.resume()
    }
        
    
    func postDataFormRequest(resource: TokenRequest, completion: @escaping (Result<Token, NetworkError>) -> Void) {
        
        let parameters = [
            [
                "key": "grant_type",
                "value": resource.grant_type,
                "type": "text"
            ],
            [
                "key": "username",
                "value": resource.username,
                "type": "text"
            ],
            [
                "key": "password",
                "value": resource.password,
                "type": "text"
        
            ]
        ]

        let boundary = "Boundary-\(UUID().uuidString)"
        var body = ""
        
        for param in parameters {
            if param["disabled"] == nil {
                let paramName = param["key"] ?? ""
                body += "--\(boundary)\r\n"
                body += "Content-Disposition:form-data; name=\"\(paramName)\""
                let paramType = param["type"] ?? ""
                
                if paramType == "text" {
                    let paramValue = param["value"] ?? ""
                    body += "\r\n\r\n\(paramValue)\r\n"
                } else {
                    let paramSrc = param["src"] ?? ""
                
                    if let fileData = try? NSData(contentsOfFile: paramSrc, options: .alwaysMapped) {
                        let fileContent = String(data: fileData as Data, encoding: .utf8) ?? ""
                        body += "; filename=\"\(paramSrc)\"\r\n" + "Content-Type: \"content-type header\"\r\n\r\n\(fileContent)\r\n"
                    }
                }
            }
        }
        
        body += "--\(boundary)--\r\n";
        
        let postData = body.data(using: .utf8)
        
        guard let url = URL(string: "http://34.194.162.119:9000/oauth/token") else { return }
        
//        guard let url = URL(string: "http://3.231.199.162:9000/oauth/token") else { return }
        

        var request = URLRequest(url: url,timeoutInterval: Double.infinity)
        request.addValue("Basic \(resource.basic)", forHTTPHeaderField: "Authorization")
//        request.addValue("Basic Ymx1bW9uX3BheV9tb2JpbGVfcG9zX2FwaTpibHVtb25fcGF5X21vYmlsZV9wb3NfYXBpX3Bhc3N3b3Jk", forHTTPHeaderField: "Authorization")
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpMethod = HTTPMethods.POST
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            print(json)

            let result = try? JSONDecoder().decode(Token.self, from: data)
            
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                completion(.failure(.decodingError))
            }
        }

        task.resume()
    }
    
}


