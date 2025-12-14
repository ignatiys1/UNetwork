//
//  UNetworkMocks.swift
//  UNetwork
//
//  Created by Ignat Urbanovich on 14/12/2025.
//

import Combine
import UNetwork

open class UNetworkConfigsMock: UNetworkConfigs {
    
    public static var baseURLStringGetWasCalled: Int = .zero
    public static var baseURLStringGetStub: String! = nil
    public static var baseURLString: String {
        get {
            baseURLStringGetWasCalled += 1
            return baseURLStringGetStub
        }
    }
    
    public static var commonHTTPHeaderGetWasCalled: Int = .zero
    public static var commonHTTPHeaderGetStub: [String: String]! = nil
    public static var commonHTTPHeader: [String: String] {
        get {
            commonHTTPHeaderGetWasCalled += 1
            return commonHTTPHeaderGetStub
        }
    }
    
    public static var commonQueryParamsGetWasCalled: Int = .zero
    public static var commonQueryParamsGetStub: [String: String?]! = nil
    public static var commonQueryParams: [String: String?] {
        get {
            commonQueryParamsGetWasCalled += 1
            return commonQueryParamsGetStub
        }
    }
    
    public static var tokenProviderGetWasCalled: Int = .zero
    public static var tokenProviderGetStub: ProvidesToken? = nil
    public static var tokenProvider: ProvidesToken? {
        get {
            tokenProviderGetWasCalled += 1
            return tokenProviderGetStub
        }
    }
}

open class UNetworkServiceMock<PathContext, Response>: UNetworkService where Response: Decodable {
    public typealias Configs = UNetworkConfigsMock
    public typealias PathContext = PathContext
    public typealias Response = Response
    
    
    public init() { }
    
    public var methodGetWasCalled: Int = .zero
    public var methodGetStub: HTTPMethod! = nil
    public var method: HTTPMethod {
        get {
            methodGetWasCalled += 1
            return methodGetStub
        }
    }
    
    public var httpHeaderGetWasCalled: Int = .zero
    public var httpHeaderGetStub: [String: String]! = nil
    public var httpHeader: [String: String] {
        get {
            httpHeaderGetWasCalled += 1
            return httpHeaderGetStub
        }
     }
    
    public var tokenProviderGetWasCalled: Int = .zero
    public var tokenProviderGetStub: ProvidesToken! = nil
    public var tokenProvider: ProvidesToken? {
        get {
            tokenProviderGetWasCalled += 1
            return tokenProviderGetStub
        }
     }

    
    public var endpointContextWasCalled: Int = .zero
    public var endpointContextRecievedContext: PathContext? = nil
    public var endpointContextRecievedCalls: [PathContext] = []
    public var endpointContextStub: String! = nil
    public func endpoint(_ context: PathContext) -> String {
        endpointContextWasCalled += 1
        endpointContextRecievedContext = context
        endpointContextRecievedCalls.append(context)
        return endpointContextStub
    }
      
    public var sendRequestWithBodyParamsPathContextQueryParamsWasCalled: Int = .zero
    public var sendRequestWithBodyParamsPathContextQueryParamsRecievedArguments: (bodyParams: [String: Any], pathContext: PathContext, queryParams: [String: String?])? = nil
    public var sendRequestWithBodyParamsPathContextQueryParamsRecievedCalls: [(bodyParams: [String: Any], pathContext: PathContext, queryParams: [String: String?])] = []
    public var sendRequestWithBodyParamsPathContextQueryParamsStub: AnyPublisher<Response, UNetworkRequestError>! = nil
    public func sendRequest(with bodyParams: [String: Any], pathContext: PathContext, queryParams: [String: String?]) -> AnyPublisher<Response, UNetworkRequestError> {
        sendRequestWithBodyParamsPathContextQueryParamsWasCalled += 1
        sendRequestWithBodyParamsPathContextQueryParamsRecievedArguments = (bodyParams: bodyParams, pathContext: pathContext, queryParams: queryParams)
        sendRequestWithBodyParamsPathContextQueryParamsRecievedCalls.append((bodyParams: bodyParams, pathContext: pathContext, queryParams: queryParams))
        return sendRequestWithBodyParamsPathContextQueryParamsStub
    }
    
    public var sendRequestPathContextQueryParamsWasCalled: Int = .zero
    public var sendRequestPathContextQueryParamsRecievedArguments: (pathContext: PathContext, queryParams: [String: String?])? = nil
    public var sendRequestPathContextQueryParamsRecievedCalls: [(pathContext: PathContext, queryParams: [String: String?])] = []
    public var sendRequestPathContextQueryParamsStub: AnyPublisher<Response, UNetworkRequestError>! = nil
    
    public func sendRequest(pathContext: PathContext, queryParams: [String: String?]) -> AnyPublisher<Response, UNetworkRequestError> {
        sendRequestPathContextQueryParamsWasCalled += 1
        sendRequestPathContextQueryParamsRecievedArguments = (pathContext: pathContext, queryParams: queryParams)
        sendRequestPathContextQueryParamsRecievedCalls.append((pathContext: pathContext, queryParams: queryParams))
        return sendRequestPathContextQueryParamsStub
    }
    
    public var sendRequestWithBodyParamsQueryParamsWasCalled: Int = .zero
    public var sendRequestWithBodyParamsQueryParamsRecievedArguments: (bodyParams: [String: Any], queryParams: [String: String?])? = nil
    public var sendRequestWithBodyParamsQueryParamsRecievedCalls: [(bodyParams: [String: Any], queryParams: [String: String?])] = []
    public var sendRequestWithBodyParamsQueryParamsStub: AnyPublisher<Response, UNetworkRequestError>! = nil
    public func sendRequest(with bodyParams: [String : Any], queryParams: [String : String?]) -> AnyPublisher<Response, UNetworkRequestError> {
        sendRequestWithBodyParamsQueryParamsWasCalled += 1
        sendRequestWithBodyParamsQueryParamsRecievedArguments = (bodyParams: bodyParams, queryParams: queryParams)
        sendRequestWithBodyParamsQueryParamsRecievedCalls.append((bodyParams: bodyParams, queryParams: queryParams))
        return sendRequestWithBodyParamsQueryParamsStub
    }
    
    public var sendRequestWithBodyParamsPathContextWasCalled: Int = .zero
    public var sendRequestWithBodyParamsPathContextRecievedArguments: (bodyParams: [String: Any], pathContext: PathContext)? = nil
    public var sendRequestWithBodyParamsPathContextRecievedCalls: [(bodyParams: [String: Any], pathContext: PathContext)] = []
    public var sendRequestWithBodyParamsPathContextStub: AnyPublisher<Response, UNetworkRequestError>! = nil
    public func sendRequest(with bodyParams: [String: Any], pathContext: PathContext) -> AnyPublisher<Response, UNetworkRequestError> {
        sendRequestWithBodyParamsPathContextWasCalled += 1
        sendRequestWithBodyParamsPathContextRecievedArguments = (bodyParams: bodyParams, pathContext: pathContext)
        sendRequestWithBodyParamsPathContextRecievedCalls.append((bodyParams: bodyParams, pathContext: pathContext))
        return sendRequestWithBodyParamsPathContextStub
    }
    
    public var sendRequestQueryParamsWasCalled: Int = .zero
    public var sendRequestQueryParamsRecievedArguments: [String: String?]? = nil
    public var sendRequestQueryParamsRecievedCalls: [[String: String?]] = []
    public var sendRequestQueryParamsStub: AnyPublisher<Response, UNetworkRequestError>! = nil
    public func sendRequest(queryParams: [String: String?]) -> AnyPublisher<Response, UNetworkRequestError> {
        sendRequestQueryParamsWasCalled += 1
        sendRequestQueryParamsRecievedArguments = queryParams
        sendRequestQueryParamsRecievedCalls.append(queryParams)
        return sendRequestQueryParamsStub
    }

    public var sendRequestWithBodyParamsWasCalled: Int = .zero
    public var sendRequestWithBodyParamsRecievedArguments: [String: Any]? = nil
    public var sendRequestWithBodyParamsRecievedCalls: [[String: Any]] = []
    public var sendRequestWithBodyParamsStub: AnyPublisher<Response, UNetworkRequestError>! = nil
    public func sendRequest(with bodyParams: [String: Any]) -> AnyPublisher<Response, UNetworkRequestError> {
        sendRequestWithBodyParamsWasCalled += 1
        sendRequestWithBodyParamsRecievedArguments = bodyParams
        sendRequestWithBodyParamsRecievedCalls.append(bodyParams)
        return sendRequestWithBodyParamsStub
    }
    
    public var sendRequestPathContextWasCalled: Int = .zero
    public var sendRequestPathContextRecievedArguments: PathContext? = nil
    public var sendRequestPathContextRecievedCalls: [PathContext] = []
    public var sendRequestPathContextStub: AnyPublisher<Response, UNetworkRequestError>! = nil
    public func sendRequest(pathContext: PathContext) -> AnyPublisher<Response, UNetworkRequestError> {
        sendRequestPathContextWasCalled += 1
        sendRequestPathContextRecievedArguments = pathContext
        sendRequestPathContextRecievedCalls.append(pathContext)
        return sendRequestPathContextStub
    }
    
    public var sendRequestWasCalled: Int = .zero
    public var sendRequestStub: AnyPublisher<Response, UNetworkRequestError>! = nil
    public func sendRequest() -> AnyPublisher<Response, UNetwork.UNetworkRequestError> {
        sendRequestWasCalled += 1
        return sendRequestStub
    }
}
