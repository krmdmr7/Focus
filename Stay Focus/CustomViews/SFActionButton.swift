//
//  SFButton.swift
//  Stay Focus
//
//  Created by Kerem Demır on 15.02.2023.
//

import UIKit

final class SFActionButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .systemGreen
        layer.cornerRadius = 10
        tintColor = .label
        
        setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
