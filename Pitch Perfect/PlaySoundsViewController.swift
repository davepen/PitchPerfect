import UIKit
import AVFoundation

class PlaySoundsViewController : UIViewController
{
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    @IBOutlet weak var reverbButton:UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        reverbButton.frame = CGRectMake(0, 0, 100.0, 100.0)
        reverbButton.layer.borderColor = UIColor.blackColor().CGColor
        reverbButton.layer.borderWidth = 1.0
        
        audioPlayer = AVAudioPlayer(contentsOfURL:receivedAudio.fileAtPathUrl!, error:nil)
        audioPlayer.enableRate = true;
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading:receivedAudio.fileAtPathUrl, error:nil)
    }

    /**
    Plays the recorded audio with the given rate.
    
    :param: rate The playback rate for the audio player
    */
    func playAudioWithRate(rate:Float)
    {
        stopAndReset()
        
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    /**
    Plays the recorded audio with the given pitch
    
    :param: pitch The amount by which the input signal is pitch shifted.
    */
    func playAudioWithPitch(pitch:Float)
    {
        stopAndReset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to:changePitchEffect, format:nil)
        audioEngine.connect(changePitchEffect, to:audioEngine.outputNode, format:nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime:nil, completionHandler:nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    /**
    Stop and reset the audio player and engine
    */
    func stopAndReset()
    {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    @IBAction func playReverbAudio(sender:UIButton)
    {
        stopAndReset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var audioUnitReverb = AVAudioUnitReverb()
        audioUnitReverb.wetDryMix = 75.0;
        audioEngine.attachNode(audioUnitReverb)
        
        audioEngine.connect(audioPlayerNode, to:audioUnitReverb, format:nil)
        audioEngine.connect(audioUnitReverb, to:audioEngine.outputNode, format:nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime:nil, completionHandler:nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func playSlowAudio(sender:UIButton)
    {
        playAudioWithRate(0.5)
    }

    @IBAction func playFastAudio(sender:UIButton)
    {
        playAudioWithRate(2.0)
    }
    
    @IBAction func playChipmunkAudio(sender:UIButton)
    {
        playAudioWithPitch(1000)
    }
    
    @IBAction func playDarthVaderAudio(sender:UIButton)
    {
        playAudioWithPitch(-1000)
    }
    
    @IBAction func stopAudio(sender:UIButton)
    {
        stopAndReset()
    }
}
