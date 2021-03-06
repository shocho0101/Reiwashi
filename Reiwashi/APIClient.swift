//
//  APIClient.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/19.
//  Copyright © 2020 2222_d. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

enum APIClient {
    private static let baseUrl = "https://neo-tokyo.work:10283/"
    
    // TODO: リファクタリングしたい
    static func request<Body: Encodable, Response: Decodable>(_ method: HTTPMethod, path: String, body: Body, needAuth: Bool, responseType: Response.Type) -> Observable<Response> {
        guard let url = URL(string: baseUrl + path) else {
            return Observable<Response>.error(ReiwashiError.invalidPath)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if needAuth {
            guard let token = Auth.token else {
                return Observable<Response>.error(ReiwashiError.notLoggedIn)
            }
            request.setValue("Token " + token, forHTTPHeaderField: "Authorization")
        }
        
        do {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            encoder.dateEncodingStrategy = .formatted(formatter)
            let jsonBody = try encoder.encode(body)
            request.httpBody = jsonBody
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            return Observable<Response>.error(ReiwashiError.encodeError)
        }
        
        
        return RxAlamofire.request(request)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .data()
            .map {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                let decoder: JSONDecoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(formatter)
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try decoder.decode(Response.self, from: $0)
        }
    }
    
    static func request<Response: Decodable>(_ method: HTTPMethod, path: String, needAuth: Bool, responseType: Response.Type) -> Observable<Response> {
        guard let url = URL(string: baseUrl + path) else {
            return Observable<Response>.error(ReiwashiError.invalidPath)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if needAuth {
            guard let token = Auth.token else {
                return Observable<Response>.error(ReiwashiError.notLoggedIn)
            }
            request.setValue("Token " + token, forHTTPHeaderField: "Authorization")
        }
        
        return RxAlamofire.request(request)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .data()
            .map {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                let decoder: JSONDecoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(formatter)
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try decoder.decode(Response.self, from: $0)
        }
    }
}

