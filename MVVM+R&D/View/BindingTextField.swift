//
//  BindingTextField.swift
//  MVVM+R&D
//
//  Created by SAHIL AMRUT AGASHE on 12/01/24.
//

import UIKit

class BindingTextField: UITextField {
    
    // MARK: - Properties
    private var textChanged: ((String) -> Void)?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Private Helpers
    private func setupUI() {
        addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
    
    @objc private func textFieldDidChanged(_ textField: UITextField) {
        
        if let text = textField.text, let textChanged {
            textChanged(text)
        }
    }
    
    // MARK: - Public Helpers
    public func bind(callback: @escaping (String) -> Void) {
        textChanged = callback
    }
    
}
