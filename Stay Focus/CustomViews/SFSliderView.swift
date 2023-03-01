//
//  SFSliderView.swift
//  Stay Focus
//
//  Created by Kerem Demır on 17.02.2023.
//

import UIKit

class SFSliderView: UIView {
    
    
    private let focusTimeSliderLabel:UILabel = {
        let focusTimeSliderLabel = UILabel()
        focusTimeSliderLabel.translatesAutoresizingMaskIntoConstraints = false
        focusTimeSliderLabel.text = "Focus Time"
        focusTimeSliderLabel.textColor = .label
        return focusTimeSliderLabel
    }()
    
    private let focusTimeSliderValueLabel:UILabel = {
        let focusTimeSliderValueLabel = UILabel()
        focusTimeSliderValueLabel.translatesAutoresizingMaskIntoConstraints = false
        focusTimeSliderValueLabel.text = "25"
        focusTimeSliderValueLabel.textColor = .label
        return focusTimeSliderValueLabel
    }()
    
    private var slider = UISlider()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    private func configure(){
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
