//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by davepen on 3/4/15.
//  Copyright (c) 2015 penaskovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func recordAudio(sender: UIButton)
    {
        println("recording in progress")
        recordingLabel.hidden = false;
        stopButton.hidden = false;
    }
    
    @IBAction func stopAudio(sender: UIButton)
    {
        recordingLabel.hidden = true;
        stopButton.hidden = true;
    }
}

