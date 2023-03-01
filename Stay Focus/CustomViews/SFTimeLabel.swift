//
//  SFTimeLabel.swift
//  Stay Focus
//
//  Created by Kerem Demır on 15.02.2023.
//

import UIKit

final class SFTimeLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        confgiure()
        
    }
    
    convenience init(text:String){
        self.init(frame: .zero)
        self.text = text
    }
    
    private func confgiure(){
        translatesAutoresizingMaskIntoConstraints = false
        
        textColor = .label
        
        font = .systemFont(ofSize: 130, weight:  .heavy)
        numberOfLines = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
