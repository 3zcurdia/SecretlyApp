//
//  RequestError.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 22/05/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

enum NetworkError: CustomError {
    case invalidRequest
    case invalidResponse
    case clientError
    case serverError

    var description: String {
        switch self {
        case .invalidRequest:
            return "Invalid Request"
        case .invalidResponse:
            return "Invalid Response"
        case .clientError:
            return "Client error"
        case .serverError:
            return "Internal Server error"
        }
    }
}
