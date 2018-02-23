//
//  ViewController.swift
//  myMusikPlayer
//
//  Created by Bogdan Deshko on 24.10.2017.
//  Copyright © 2017 Bogdan Deshko. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var labelOfTime: UILabel!
    // images variable
    var imageRestart = UIImage(named: "icons8-Replay-50")
    var imagePlay = UIImage(named: "iconPlay")
    var imagePause = UIImage(named: "icon-Pause")
    var imageStop = UIImage(named: "icons8-Stop-50")
    var imageTrekPoint = UIImage(named: "if_player_stop_1829")
    var player = AVAudioPlayer()
    
    var trekslider = UISlider()
    
    var playPauseBtn = UIButton()
    var stopBtn = UIButton()
    var restartBtn = UIButton()
    
    var timer = Timer()
    var timerForSlider = Timer()
    var isRuning = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // ----Trek Slider
        trekslider.frame = CGRect(x: 60, y: 460, width: 255, height: 30)
        
        trekslider.setThumbImage(imageTrekPoint, for: .normal)
        trekslider.minimumTrackTintColor = UIColor.black
        trekslider.maximumTrackTintColor = UIColor.black
        trekslider.addTarget(self, action: #selector(trekSliderValue(sender:)), for: .valueChanged)
        view.addSubview(trekslider)
        
        // ----PlayPause Button
        playPauseBtn.frame = CGRect(x: 158, y: 500, width: 70, height: 70)
        playPauseBtn.addTarget(self, action: #selector(play(sender:)), for: .touchDown)
        playPauseBtn.setImage(imagePlay, for: .normal)
        self.view.addSubview(playPauseBtn)
        
        
        //----- Stop button
        
        stopBtn.frame = CGRect(x: 225, y: 500, width: 70, height: 70)
        //stopBtn.backgroundColor = UIColor.red
        stopBtn.addTarget(self, action: #selector(stop(sender:)), for: .touchDown)
        stopBtn.setImage(imageStop, for: .normal)
        self.view.addSubview(stopBtn)
        
        
        //----- restart button
        
        restartBtn.frame = CGRect(x: 80, y: 500, width: 70, height: 70)
        //stopBtn.backgroundColor = UIColor.red
        restartBtn.addTarget(self, action: #selector(restart(sendr:)), for: .touchDown)
        restartBtn.setImage(imageRestart, for: .normal)
        self.view.addSubview(restartBtn)
        
        //----- Player
        do {
            if let audioPath = Bundle.main.path(forResource: "08 Mouth Of The River", ofType: "mp3"){
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            }
        } catch  {
            print("Error")
        }
        
        trekslider.minimumValue = 0.0
        trekslider.maximumValue = Float(player.duration)
        timerForSlider = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatebleSliderThumb), userInfo: nil, repeats: true)
    }//--------  viewDidLoad()
    
    @objc func updatebleSliderThumb() {
        trekslider.value = Float(player.currentTime)
    }
    
    @objc func trekSliderValue (sender: UISlider){
        if sender == trekslider {
            player.currentTime = TimeInterval(trekslider.value)
        }
        
    }
    
    @objc func play (sender: UIButton){
        if !player.isPlaying{
            playPauseBtn.setImage(imagePause, for: .normal)
            player.play()
        } else {
            playPauseBtn.setImage(imagePlay, for: .normal)
            player.stop()
        }
        if isRuning {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func updateTimer() {
        let curentTime = Int(player.currentTime)
        let minutes = curentTime/60
        let second = curentTime - minutes*60
        labelOfTime.text = NSString(format: "%02d:%02d", minutes, second) as String
    }
    
    @objc func stop (sender: UIButton){
        player.stop()
        player.currentTime = 0
        trekslider.value = 0.0
        playPauseBtn.setImage(imagePlay, for: .normal)
        
    }
    
    @objc func restart (sendr: UIButton){
        player.currentTime = 0
        trekslider.value = 0.0
        
    }
    
    
}

