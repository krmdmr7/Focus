//
//  SFView.swift
//  Stay Focus
//
//  Created by Kerem Demır on 1.03.2023.
//

import UIKit

final class SFView: UIView {
    
    let stateImage = UIImageView()
    let stateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(text:String){
        self.init(frame: .zero)
        stateLabel.text = text
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 20
        backgroundColor = .systemGreen
        
        
        
        let stack = UIStackView(arrangedSubviews: [stateImage, stateLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.distribution = .fill
        stack.spacing = 8
        stack.layer.cornerRadius = 15
        addSubview(stack)
        
        stateImage.tintColor = .label
        stateLabel.tintColor = .label
        
        stateImage.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            stateImage.widthAnchor.constraint(equalToConstant: 35),
            stack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stack.widthAnchor.constraint(equalToConstant: 100),
            stack.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
