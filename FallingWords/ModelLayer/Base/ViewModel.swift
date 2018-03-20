//
//  ViewModel.swift
//  FallingWords
//
//  Created by Arman Arutyunov on 13/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import RxSwift
import RxCocoa

/// Base view model class
/// To start presenting anything, attach view to ViewModel
/// To stop, detach view
class ViewModel<V: ViewIO> {
    
    private(set) weak var viewIO: V?
    private var isSetup = false
    internal var disposeBag = DisposeBag()
    
    /// Attaches view to view model; view model will subscribe to outputs of View and performs all its internal operations after attachView is called
    ///
    /// - Parameter view: view to attach
    final public func attachView(viewIO: V) -> Disposable {
        self.viewIO = viewIO
        self.disposeBag = DisposeBag() // clean up previous subscriptions
        
        // lazy setup
        if !isSetup {
            isSetup = true
            setup()
        }
        
        return viewAttached()
    }
    
    /// Main entry point to View Model, manage subscriptions here
    internal func viewAttached() -> Disposable {
        fatalError("This function should be overriden")
    }
    
    /// Setups view model's initial state, start async operation, etc
    /// Called only once upon `attachView`
    internal func setup() {
        //no op
    }
    
    /// Disposable builder
    internal func disposable(_ disposables: Disposable?...) -> Disposable {
        return Disposables.create(disposables.flatMap{ $0 })
    }
    
}

// Shortcut
public typealias Action = Driver<Void>

