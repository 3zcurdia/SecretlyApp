//
//  RequestBuilder.swift
//  Secretly
//
//  Created by LuisE on 2/17/20.
//  Copyright © 2020 3zcurdia. All rights reserved.
//

import Foundation

struct RequestBuilder: CustomDebugStringConvertible {
    enum ContentMode {
        case jsonApp

        func accept() -> String {
            switch self {
            case .jsonApp:
                return "application/json"
            }
        }

        func contentType() -> String {
            switch self {
            case .jsonApp:
                return "application/json"
            }
        }
    }
    private let urlComponents: URLComponents
    public var scheme: String = "https"
    public var method: String = "get"
    public var path: String = "/"
    public var body: Data?
    public var headers: [String: String]?
    public var contentMode: ContentMode = .jsonApp

    var debugDescription: String {
        let urlString = url()?.absoluteString ?? "Invalid url at \(path)"
        var desc = "\(method.uppercased()) \"\(urlString)\""
        if let uheaders = headers {
            for (key, value) in uheaders {
                desc += " -H '\(key): \(value)'"
            }
        }
        if let ubody = body, let bodyString = String(data: ubody, encoding: .utf8) {
            desc += " -d $'\(bodyString)'"
        }
        return desc
    }

    static func build(method: String, baseUrl: String, path: String, body: Data?) -> URLRequest? {
        var builder = RequestBuilder(baseUrl: baseUrl)
        builder.method = method
        builder.path = path
        builder.body = body
        if let token = AmacaConfig.shared.apiToken {
            builder.headers = ["Authorization": "Bearer \(token)"]
        }
        #if DEBUG
        print("=========================[REQUEST]==========================")
        debugPrint(builder)
        #endif
        return builder.request()
    }

    init(baseUrl: String) {
        self.urlComponents = URLComponents(string: baseUrl)!
    }

    func url() -> URL? {
        var comps = self.urlComponents
        comps.scheme = scheme
        comps.path = path
        return comps.url
    }

    func request() -> URLRequest? {
        guard let url = url() else { return nil }
        var req = URLRequest(url: url)
        req.httpMethod = method
        req.httpBody = body
        req.addValue(contentMode.accept(), forHTTPHeaderField: "Accept")
        req.addValue(contentMode.contentType(), forHTTPHeaderField: "Content-Type")
        if let headers = self.headers {
            for (key, value) in headers {
                req.addValue(value, forHTTPHeaderField: key)
            }
        }
        return req
    }
}
