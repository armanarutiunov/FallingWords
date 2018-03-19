//
//  ErrorCase.swift
//  FallingWords
//
//  Created by Arman Arutyunov on 19/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

enum ErrorCase: DomainError {
    
    case parseError
    case invalidJSONPath
    
    var description: String {
        switch self {
        case .parseError:
            return "Problems with JSON parsing"
        case .invalidJSONPath:
            return "Invalid JSON filename or path"
        }
    }
}
