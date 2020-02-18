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
    private static let baseUrl = "https://neo-tokyo.work:10282/"
    
    // TODO: リファクタリングしたい
    static func request<Body: Encodable, Response: Decodable>(_ method: HTTPMethod, path: String, body: Body? = nil, needAuth: Bool, responseType: Response.Type) -> Observable<Response> {
        guard let url = URL(string: baseUrl + path) else {
            return Observable<Response>.error(RequestError.invalidPath)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if needAuth {
            request.setValue("Token AVuaN6VRD9nnEaHPLJQ8LA7A", forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            do {
                let jsonBody = try JSONEncoder().encode(body)
                request.httpBody = jsonBody
            } catch {
                return Observable<Response>.error(RequestError.encodeError)
            }
        }
        
        return RxAlamofire.request(request)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .data()
            .map { try JSONDecoder().decode(Response.self, from: $0) }
    }
    
    enum RequestError: Error {
        case invalidPath
        case encodeError
    }
}

