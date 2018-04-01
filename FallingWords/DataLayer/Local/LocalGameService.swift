//
//  LocalGameService.swift
//  FallingWords
//
//  Created by Arman Arutyunov on 15/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import RxSwift

class LocalGameService: GameService {
    
    func getWords() -> Observable<[JSONWord]> {
        return Observable.create { observer in
            if let path = Bundle.main.path(forResource: "words", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                    let words = try JSONDecoder().decode([JSONWord].self, from: data)
                    observer.onNext(words)
                } catch {
                    observer.onError(ErrorCase.parseError)
                }
            } else {
                observer.onError(ErrorCase.invalidJSONPath)
            }
            return Disposables.create()
        }
    }
    
}
