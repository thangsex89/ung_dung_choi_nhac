//
//  ViewController.swift
//  ung_dung_choi_nhac
//
//  Created by Thang on 12/12/16.
//  Copyright © 2016 Thang. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController ,  AVAudioPlayerDelegate {
    
    var audio = AVAudioPlayer()
    @IBOutlet weak var btn_outlet_play: UIButton!
    
    @IBOutlet weak var switch_outlet_on_off: UISwitch!
   
    @IBOutlet weak var slider_outlet_volume: UISlider!
    var check = Bool()
    
    @IBOutlet weak var lbl_timetotal: UILabel!
    @IBOutlet weak var lbl_timeleft: UILabel!
    @IBOutlet weak var slider_outlet_duration: UISlider!
    
    override func viewDidLoad() {//start
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let filePath = Bundle.main.path(forResource: "music", ofType: ".mp3")
        let url = URL(fileURLWithPath: filePath!)
        audio = try! AVAudioPlayer(contentsOf: url)
        audio.delegate = self // để cho cái hàm audioPlayerDidFinishPlaying chạy
        audio.prepareToPlay()
        add_thumb_img_for_slider()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updatetimeleft), userInfo: nil, repeats: true)
       // audio.numberOfLoops = -1
      
    }//end
    func updatetimeleft() -> Void {
//        print ("ham dang chay")
//        print (audio.duration)
        self.lbl_timeleft.text = String(format :"%2.2f",audio.currentTime / 60)
        self.slider_outlet_duration.value = Float ( audio.currentTime / audio.duration)
        self.lbl_timetotal.text = String(format :"%2.2f" ,  (audio.duration - audio.currentTime)/60)
    }
    func add_thumb_img_for_slider() -> Void {
     
        slider_outlet_volume.setThumbImage(UIImage(named: "thumb.png"), for:.normal)
         slider_outlet_volume.setThumbImage(UIImage(named: "thumbHightLight.png"), for:.highlighted)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //start
    
    @IBAction func btn_action_play(_ sender: Any) {
        
        if (btn_outlet_play.currentBackgroundImage == UIImage(named:"play.png"))
        {
            check = true;
        
        }else
        {
            check = false;
        }
        
         if( check ==  true)
        
         {
             audio.play()
            btn_outlet_play.setBackgroundImage(UIImage(named: "pause.png"), for: .normal)
            
            
        }else
       
        {
            audio.pause()
            btn_outlet_play.setBackgroundImage(UIImage(named: "play.png"), for: .normal)
            
        }
       
    }
    @IBAction func slider_action_volume(_ sender: UISlider) {
        audio.volume = sender.value
    }
    
    @IBAction func slider_action_duration(_ sender: UISlider) {
        audio.currentTime = audio.duration *  Double(sender.value)
        
    }
    
    @IBAction func switch_action_on_off(_ sender: UISwitch) {
        if (sender.isOn == true)
        {
            audio.numberOfLoops = -1
        }
        else
        {
            audio.numberOfLoops = 0
        }
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
       if( switch_outlet_on_off.isOn == false)
       {
        btn_outlet_play.setBackgroundImage(UIImage(named: "play.png"), for: .normal)
        }
        
    }
    
    
    
    //end
    

}

