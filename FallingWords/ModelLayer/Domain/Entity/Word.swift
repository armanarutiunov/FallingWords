//
//  Word.swift
//  FallingWords
//
//  Created by Arman Arutyunov on 15/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

public struct Word {
    let original: String
    let translations: [Translation]
    var translation: String {
        return translations.first!.title
    }
}
