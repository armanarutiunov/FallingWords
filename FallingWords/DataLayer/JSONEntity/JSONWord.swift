//
//  JSONWord.swift
//  FallingWords
//
//  Created by Arman Arutyunov on 19/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

public struct JSONWord: Decodable {
    let original: String
    let translation: String
    
    enum CodingKeys: String, CodingKey {
        case original = "text_eng"
        case translation = "text_spa"
    }
    
    public init(original: String, translation: String) {
        self.original = original
        self.translation = translation
    }
}
