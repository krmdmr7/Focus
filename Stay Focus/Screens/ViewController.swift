// GITHUB BAK
// YAPILACAKLAR KONTROL ET
// 1-) Mola suresinde dakikalar saniyenin 00'i ile eslestiginde tek basamak olarak gozukuyor. Cift basamak olmali.
// 2-) Mola bittiginde tekrardan FOCUS TIME baslatilmali ve bunun kontrolu COUNTER ile yapilmali. Counter 4e ulastiginda uygulama sonlanacak.
// 3-)

//  ViewController.swift
//  Stay Focus
//
//  Created by Kerem Demır on 15.02.2023.
//

import UIKit
class ViewController: UIViewController {
    
    var focusMinutesTimer = Timer()
    var shortMinutesTimer = Timer()
    var longMinutesTimer = Timer()
    
    var secondsTimer = Timer()
    
    let startButton = SFActionButton()
    let pauseButton = SFActionButton()
    let stopButton = SFActionButton()
    
    var focusMinutesLabel = SFTimeLabel(text: "02")
    let secondsLabel = SFTimeLabel(text: "00")
    
    var shortMinutesLabel = SFTimeLabel(text: "05")
    
    var longMinutesLabel = SFTimeLabel(text: "31")
    
    var pauseMu:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        pauseButton.isHidden = true
        stopButton.isHidden = true
        shortMinutesLabel.isHidden = true
        longMinutesLabel.isHidden = true
        
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configure(){
        configureUI()
        rightBarButtonItem()
    }
    
    private func rightBarButtonItem(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "slider30px"), style: .plain, target: self, action: #selector(settingsAction))
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
    
    @objc func settingsAction(){
        let rootVC = SettingsVC()
        rootVC.callBackForSomething = { value in
            self.focusMinutesLabel.text = "\(Int(value.focusTime))"
            self.shortMinutesLabel.text = "\(Int(value.shortBreakTime))"
            self.longMinutesLabel.text  = "\(Int(value.longBreakTime))"
        }
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true, completion: nil)
    }
    
    //MARK: - Start Button Actions
    @objc func startButtonActions(){
        print("Start butonu calisti.")
        
        print("Focus Time       : \(focusMinutesLabel.text!)")
        print("Short Break Time : \(shortMinutesLabel.text!)")
        print("Long Break Time  : \(longMinutesLabel.text!)")
        
        startButton.isHidden = true
        pauseButton.isHidden = false
        stopButton.isHidden = false
        
        let minutesTimeValue = Int(focusMinutesLabel.text!)!
        focusMinutesLabel.text = String(minutesTimeValue - 1)
        secondsLabel.text = "09"
        
        //MARK: - Seconds Label Work Method
        secondsTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(secondsTimerStart), userInfo: nil, repeats: true)
        
        //MARK: - Minutes Label Work Method
        focusMinutesTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(focusMinutesTimerStart), userInfo: nil, repeats: true)
        
        shortMinutesTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(shortMinutesTimerStart), userInfo: nil, repeats: true)
    }
    
    //MARK: - Short Minutes Timer Set
    @objc func shortMinutesTimerStart(){
        var shortTimeValue = Int(shortMinutesLabel.text!)!
        shortMinutesLabel.text = String(shortTimeValue)
        shortTimeValue -= 1
        shortMinutesLabel.text = String(shortTimeValue)
        
        if ( shortTimeValue < 10){
            shortMinutesLabel.text = "0\(shortTimeValue)"
            if shortTimeValue == -1 {
                shortMinutesLabel.text = "00"
            }
        }
    }
    
    //MARK: - Focus Minutes Timer Set
    @objc func focusMinutesTimerStart(){
        var focusMinutesTimeValue = Int(focusMinutesLabel.text!)!
        focusMinutesLabel.text = String(focusMinutesTimeValue - 1)
        focusMinutesTimeValue -= 1
        focusMinutesLabel.text = String(focusMinutesTimeValue)
        
        //MARK: - Label 0'dan kucuk kontrolu.
        if (focusMinutesTimeValue < 10){
            focusMinutesLabel.text = "0\(focusMinutesTimeValue)"
            if focusMinutesTimeValue == -1 {
                focusMinutesLabel.text = "00"
            }
        }
    }
    
    //MARK: - Seconds Time Set
    @objc func secondsTimerStart(){
        let minutesTimeValue = Int(focusMinutesLabel.text!)!
        let shortTimeValue = Int(shortMinutesLabel.text!)!
        var secondsTimeValue = Int(secondsLabel.text!)!
        
        if secondsTimeValue == 00 {
            secondsTimeValue = 10
        }
        
        secondsTimeValue -= 1
        secondsLabel.text = String(secondsTimeValue)
        
        if (secondsTimeValue == 0 && minutesTimeValue == 0){
            focusMinutesLabel.isHidden = true
            shortMinutesLabel.isHidden = false
            shortMinutesLabel.text = String(shortTimeValue)
            
            if (shortTimeValue == 0 && secondsTimeValue == 00){
                
                secondsTimer.invalidate()
                focusMinutesTimer.invalidate()
                shortMinutesTimer.invalidate()
                // sayac ekle 
                print("Bitti.")
            }
        }
        //MARK: - Label 0'dan kucuk kontrolu.
        if (secondsTimeValue < 10){
            secondsLabel.text = "0\(secondsTimeValue)"
        }
    }
    
    @objc func pauseButtonActions(){
        focusMinutesTimer.invalidate()
        secondsTimer.invalidate()
        shortMinutesTimer.invalidate()
        longMinutesTimer.invalidate()
        
        if pauseMu == true {
            pauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            print("Stopped.")
            pauseMu = false
        }
        
        else if pauseMu == false {
            pauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            focusMinutesTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(focusMinutesTimerStart), userInfo: nil, repeats: true)
            secondsTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(secondsTimerStart), userInfo: nil, repeats: true)
            shortMinutesTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(shortMinutesTimerStart), userInfo: nil, repeats: true)
            
            print("Continues.")
            pauseMu = true
        }
        
    }
    
    @objc func stopButtonActions(){
        showAlert(
            title: "Alert",
            message: "Are you sure you want to finish Pomodoro?",
            handlerYes: { action in
                print("Done")
                
                self.pauseButton.isHidden = true
                self.stopButton.isHidden = true
                self.startButton.isHidden = false
                
                self.focusMinutesLabel.isHidden = false
                self.shortMinutesLabel.isHidden = true
                self.longMinutesLabel.isHidden = true
                
                self.focusMinutesTimer.invalidate()
                self.secondsTimer.invalidate()
                self.shortMinutesTimer.invalidate()
                self.longMinutesTimer.invalidate()
                
                self.focusMinutesLabel.text = "25"
                self.secondsLabel.text = "00"
            },
            handlerCancel: { actionCancel in
                // Cancel edildigine aksiyon olmicak.
            })}
    
    private func configureUI(){
        startButton.addTarget(self, action: #selector(startButtonActions), for: .touchUpInside)
        view.addSubview (startButton)
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 600),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 70),
            startButton.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        view.addSubview(focusMinutesLabel)
        NSLayoutConstraint.activate([
            focusMinutesLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            focusMinutesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            focusMinutesLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        view.addSubview(shortMinutesLabel)
        NSLayoutConstraint.activate([
            shortMinutesLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            shortMinutesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shortMinutesLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        view.addSubview(secondsLabel)
        NSLayoutConstraint.activate([
            secondsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 430),
            secondsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondsLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        view.addSubview(pauseButton)
        pauseButton.backgroundColor = .systemGreen
        pauseButton.addTarget(self, action: #selector(pauseButtonActions), for: .touchUpInside)
        pauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        NSLayoutConstraint.activate([
            pauseButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 600),
            pauseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120),
            pauseButton.heightAnchor.constraint(equalToConstant: 70),
            pauseButton.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        view.addSubview(stopButton)
        stopButton.backgroundColor = .red
        stopButton.addTarget(self, action: #selector(stopButtonActions), for: .touchUpInside)
        stopButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        NSLayoutConstraint.activate([
            stopButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 600),
            stopButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -110),
            stopButton.widthAnchor.constraint(equalToConstant: 70),
            stopButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
}

extension UIViewController {
    func showAlert(title: String, message: String, handlerYes: ((UIAlertAction) -> Void)?, handlerCancel: ((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Yes", style: .destructive, handler: handlerYes)
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: handlerCancel)
        alert.addAction(action)
        alert.addAction(actionCancel)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
            
        }
    }
}
