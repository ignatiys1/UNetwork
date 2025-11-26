//
//  NetworkConfigs.swift
//  Network
//
//  Created by Ignat Urbanovich on 12/08/2025.
//

public protocol NetworkConfigs {
    static var baseURLString: String { get }
    static var commonHTTPHeader: [String: String] { get }
    static var tokenProvider: ProvidesToken? { get }
}
