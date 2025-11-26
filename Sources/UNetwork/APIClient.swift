//
//  APIClient.swift
//  UNetwork
//
//  Created by Ignat Urbanovich on 12/08/2025.
//

import Foundation
import Combine

struct APIClient {
    private var jsonDecoder: JSONDecoder = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
    
    private let urlSession: URLSession!
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    /// Dispatches an URLRequest and returns a publisher
    /// - Parameter request: URLRequest
    /// - Returns: A publisher with the provided decoded data or an error
    func dispatch<Response: Decodable>(request: URLRequest) -> AnyPublisher<Response, UNetworkRequestError> {
        return urlSession
            .dataTaskPublisher(for: request)
        // Map on Request response
            .tryMap({ data, response in
                // If the response is invalid, throw an error
                if let response = response as? HTTPURLResponse,
                   !(200...299).contains(response.statusCode) {
                    throw httpError(response.statusCode)
                }
                // Return Response data
                return data
            })
        // Decode data using our ReturnType
            .decode(type: Response.self, decoder: jsonDecoder)
        // Handle any decoding errors
            .mapError { error in
                handleError(error)
            }
        // And finally, expose our publisher
            .eraseToAnyPublisher()
    }
}

private extension APIClient {
    /// Parses a HTTP StatusCode and returns a proper error
    /// - Parameter statusCode: HTTP status code
    /// - Returns: Mapped Error
    private func httpError(_ statusCode: Int) -> UNetworkRequestError {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 402, 405...499: return .error4xx(statusCode)
        case 500: return .serverError
        case 501...599: return .error5xx(statusCode)
        default: return .unknownError
        }
    }
    /// Parses URLSession Publisher errors and return proper ones
    /// - Parameter error: URLSession publisher error
    /// - Returns: Readable UNetworkRequestError
    private func handleError(_ error: Error) -> UNetworkRequestError {
        switch error {
        case is Swift.DecodingError:
            return .decodingError
        case let urlError as URLError:
            return .urlSessionFailed(urlError)
        case let error as UNetworkRequestError:
            return error
        default:
            return .unknownError
        }
    }
}
