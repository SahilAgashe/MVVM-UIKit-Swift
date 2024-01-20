//
//  LoginViewModel.swift
//  MVVM+R&D
//
//  Created by SAHIL AMRUT AGASHE on 12/01/24.
//

import Foundation

class Dynamic<T> {
    typealias Listener = (T) -> Void
    
    // MARK: - Properties
    private var listner: Listener?
    
    var value: T {
        didSet {
            listner?(value)
        }
    }
    
    // MARK: - Init
    init(_ value: T) {
        self.value = value
    }
    
    // MARK: - Public Helpers
    func bind(callback: @escaping Listener) {
        self.listner = callback
    }
}

struct LoginViewModel {
    var username = Dynamic("")
    var password = Dynamic("")
}
