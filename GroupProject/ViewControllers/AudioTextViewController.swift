//
//  AudioTextViewController.swift
//  GroupProject
//
//  Created by Oreoluwa Omomofe on 7/29/20.
//  Copyright © 2020 One Summer Chicago. All rights reserved.
//

import AVFoundation
import UIKit

class AudioTextViewController: UIViewController {
// imported audio book of pdf file
    @IBOutlet var button: UIButton!
    
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTapButton () {
        if let player = player, player.isPlaying {
            // stop playback
            button.setTitle("Stop", for: .normal)
            player.stop()
            
        }
        else {
               // set up player, and play
            button.setTitle("Play", for: .normal)
            let urlString = Bundle.main.path(forResource: "audio", ofType: "mp3")
         
            
            do {
               try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else{
                    return
                }
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                
                guard let player = player else{
                    return
                }
                player.play()
            }
            catch {
                print("something went wrong")
            }
        }
    }

}
