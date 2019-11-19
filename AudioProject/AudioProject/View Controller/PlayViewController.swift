//
//  PlayViewController.swift
//  AudioProject
//
//  Created by Xcode User on 2019-03-14.
//  Copyright © 2019 Xcode User. All rights reserved.
//

import UIKit
import AVFoundation
class PlayViewController: UIViewController, AVAudioPlayerDelegate{
    
    
    @IBOutlet var timerLabel:UILabel!
    @IBOutlet var durationLabel:UILabel!
    @IBOutlet weak var progressView:UIProgressView!
    @IBOutlet var playbtn :UIButton!
    @IBOutlet var pausebtn :UIButton!
    @IBOutlet var nextbtn :UIButton!
    @IBOutlet var prevbtn :UIButton!
    @IBOutlet var songName :UILabel!
    @IBOutlet var songArtist :UILabel!
    @IBOutlet var imageView:UIImageView!
    //@IBOutlet var barButton:UIBarButtonItem!

    
    var playData:PlayData! = PlayData.init()
    var seconds = 0
    var timer = Timer()
    var isTimerRunning = false
    var soundPlayer : AVAudioPlayer?
    var incrementTime = "0.0"
    var isPaused = false
    var isPlaying = false
    var pausedTime = 0.0
    var id:Int!
    var sound:String!
    var artist:String!
    var time:String!
    var image:String!
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        //barButton.performSelector(inBackground: Selector(("backStop")), with: Any?.self)
        prevbtn.transform = CGAffineTransform(rotationAngle: 3.2)
        // Do any additional setup after loading the view.
        id = playData.id
        //Play Data
        //print(playData.songname)
        sound = playData.songname
        artist = playData.artist
        time = playData.time
        image = playData.songimage
        let imageName = image.components(separatedBy: ".")
        imageView.image = UIImage(contentsOfFile: Bundle.main.path(forResource: imageName[0], ofType: "jpeg")!)
        //set data
        songName.text = sound
        songArtist.text = artist
        durationLabel.text = time
        
        let soundURL = Bundle.main.path(forResource:artist,ofType:"mp3")
        
        let url = URL(fileURLWithPath: soundURL!)
        soundPlayer = try! AVAudioPlayer.init(contentsOf: url)
        
        soundPlayer?.currentTime = 0
        
        soundPlayer?.numberOfLoops = 1
        
        
        //durationLabel.text = String(format:"%0.1f", soundPlayer?.duration ?? -1)
        let duration = soundPlayer?.duration ?? -1
        
        incrementTime = String(format:"%f",1 / duration)
        
        pausebtn.isHidden = true
        progressView.progress = 0.0
        
    }
    
    
    @IBAction func play(sender: UIButton){
        
        
        
        if isPaused{
            isPaused = false
            startTimer()
            soundPlayer?.currentTime = pausedTime
            soundPlayer?.play()
            isPlaying = true
            playbtn.isHidden = true
            pausebtn.isHidden = false
        }
        else if isPlaying{
            progressView.progress = 0.0
            soundPlayer?.currentTime = 0
            seconds = 0
            stopTimer()
            startTimer()
            soundPlayer?.pause()
            soundPlayer?.play()
            playbtn.isHidden = false
            pausebtn.isHidden = true
        }
        else {
            progressView.progress = 0.0
            soundPlayer?.currentTime = 0
            seconds = 0
            startTimer()
            soundPlayer?.play()
            isPlaying = true
            playbtn.isHidden = true
            pausebtn.isHidden = false
        }
        
        
    }
    
    @IBAction func pause(sender: UIButton){
        
        
        soundPlayer?.pause()
        pausedTime = (soundPlayer?.currentTime)!
        stopTimer()
        isPaused = true
        isPlaying = false
        pausebtn.isHidden = true
        playbtn.isHidden = false
        
        
    }
    
    @IBAction func stop(sender: UIButton){
        
        
        
        
        
    }
    
    
    func startTimer(){
        
        
        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: (#selector(PlayViewController.updateTimer)), userInfo:nil, repeats:true)
        
        
    }
    
    
    func stopTimer(){
        timer.invalidate()
    }
    func resetTimer(){
        
        
        
        
        
    }
    @objc func updateTimer(){
        
        if Int((soundPlayer?.duration)!) == seconds{
            seconds += 1
            stopTimer()
            soundPlayer?.stop()
            
            isPlaying = false
            playbtn.isHidden = false
            pausebtn.isHidden = true
        }
        else{
            seconds += 1
            timerLabel.text = timeFormat(time: TimeInterval(seconds))
            progressView.progress += Float(incrementTime)!
        }
    }
    
    func timeFormat(time:TimeInterval) -> String {
        
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i",minutes, seconds)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    @IBAction func next(sender:UIButton){
        
        
        print(id)
        if(id < 5){
        sound = mainDelegate.song[id].songName!
        artist = mainDelegate.song[id].artist!
        time = mainDelegate.song[id].time!
        image = mainDelegate.song[id].songImg!
        id = mainDelegate.song[id].id!
        print(id)
        
        }
        else {
            id = mainDelegate.song[0].id!
            sound = mainDelegate.song[0].songName!
            artist = mainDelegate.song[0].artist!
            time = mainDelegate.song[0].time!
            image = mainDelegate.song[0].songImg!
            
        }
        resetValues()
    }
    
    func resetValues(){
        
        let imageName = image.components(separatedBy: ".")
        imageView.image = UIImage(contentsOfFile: Bundle.main.path(forResource: imageName[0], ofType: "jpeg")!)
        //set data
        songName.text = sound
        songArtist.text = artist
        durationLabel.text = time
        
        let soundURL = Bundle.main.path(forResource:artist,ofType:"mp3")
        
        let url = URL(fileURLWithPath: soundURL!)
        soundPlayer = try! AVAudioPlayer.init(contentsOf: url)
        
        soundPlayer?.currentTime = 0
        
        soundPlayer?.numberOfLoops = 1
        
        
        //durationLabel.text = String(format:"%0.1f", soundPlayer?.duration ?? -1)
        let duration = soundPlayer?.duration ?? -1
        
        incrementTime = String(format:"%f",1 / duration)
        
        pausebtn.isHidden = true
        playbtn.isHidden = false
        progressView.progress = 0.0
        stopTimer()
        isPaused = false
        isPlaying = false
        timerLabel.text="00:00"
        
    }
    
    func backStop(){
        
        print("Bar Button")
        soundPlayer?.stop()
        
    }
    
}













