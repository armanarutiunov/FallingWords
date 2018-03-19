//
//  LocalGameService.swift
//  FallingWords
//
//  Created by Arman Arutyunov on 15/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import RxSwift
import SwiftyJSON

class LocalGameService: GameService {
    
    func getWords() -> Observable<[JSONWord]> {
        return Observable.create { observer in
            if let path = Bundle.main.path(forResource: "words", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                    let jsonObj = try JSON(data: data).arrayObject as? [[String: String]]
                    if let json = jsonObj {
                        let words = json.map { JSONWord(original: $0["text_eng"]!, translation: $0["text_spa"]!) }
                        observer.onNext(words)
                    } else { observer.onError(ErrorCase.parseError) }
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
