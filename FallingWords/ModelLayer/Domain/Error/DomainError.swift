//
//  DomainError.swift
//  FallingWords
//
//  Created by Arman Arutyunov on 19/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

public protocol DomainError: Error {
    var description: String { get }
}

extension DomainError {
    var string: String {
        return self as? String ?? description
    }
}

