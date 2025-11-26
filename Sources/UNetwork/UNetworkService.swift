//
//  UNetworkService.swift
//  UNetwork
//
//  Created by Ignat Urbanovich on 12/08/2025.
//

import Foundation
import Combine

public protocol ProvidesToken {
    var token: String { get }
}

public protocol UNetworkService: AnyObject {
    
    associatedtype Configs: UNetworkConfigs
    
    associatedtype PathContext = Void
    associatedtype Response: Decodable
    
    var method: HTTPMethod { get }
    var httpHeader: [String: String] { get }
    var tokenProvider: ProvidesToken? { get }

    func sendRequest(with params: [String: Any], pathContext: PathContext) -> AnyPublisher<Response, UNetworkRequestError>
    func sendRequest(pathContext: PathContext) -> AnyPublisher<Response, UNetworkRequestError>
    func endpoint(_ context: PathContext) -> String
}

public extension UNetworkService {
    private typealias RequestPublisher = AnyPublisher<Response, UNetworkRequestError>
    
    var method: HTTPMethod { .get }
    var httpHeader: [String: String] {
        [:]
    }
    var tokenProvider: ProvidesToken? { nil }

    private var assembleHTTPHeader: [String: String] {
        let authorization: [String: String] =
        if let tokenProvider = Configs.tokenProvider {
            ["Authorization": "Bearer \(tokenProvider.token)"]
        } else if let tokenProvider {
            ["Authorization": "Bearer \(tokenProvider.token)"]
        } else {
            [:]
        }
        
        return authorization
            .merging(Configs.commonHTTPHeader, uniquingKeysWith: { $1 })
            .merging(httpHeader, uniquingKeysWith: { $1 })
    }
    
    func sendRequest(pathContext: PathContext) -> AnyPublisher<Response, UNetworkRequestError> {
        sendRequest(with: [:], pathContext: pathContext)
    }
    
    func sendRequest(with params: [String: Any], pathContext: PathContext) -> AnyPublisher<Response, UNetworkRequestError> {
        guard let urlRequest = getRequest(with: params, pathContext: pathContext) else {
            return Fail(outputType: Response.self, failure: UNetworkRequestError.badRequest)
                .eraseToAnyPublisher()
        }
        
        let requestPublisher: RequestPublisher = APIClient().dispatch(request: urlRequest)
        
        return requestPublisher.eraseToAnyPublisher()
    }
    
    private func getRequest(with params: [String: Any], pathContext: PathContext) -> URLRequest? {
        guard var urlComponents = URLComponents(string: Configs.baseURLString) else { return nil }
        urlComponents.path = "\(urlComponents.path)\(endpoint(pathContext))"
        guard let finalURL = urlComponents.url else { return nil }
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.httpBody = requestBodyFrom(params)
        request.allHTTPHeaderFields = assembleHTTPHeader
        return request
    }
    
    private func requestBodyFrom(_ params: [String: Any]) -> Data? {
        guard
            !params.isEmpty,
            let httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        else {
            return nil
        }
        return httpBody
    }
}
