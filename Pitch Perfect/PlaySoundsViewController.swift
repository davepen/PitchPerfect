import UIKit
import AVFoundation

class PlaySoundsViewController : UIViewController
{
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        audioPlayer = AVAudioPlayer(contentsOfURL:receivedAudio.fileAtPathUrl!, error:nil)
        audioPlayer.enableRate = true;
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading:receivedAudio.fileAtPathUrl, error:nil)
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
        audioPlayer.stop()
    }

    func playAudioWithRate(rate:Float)
    {
        stopAndReset()

        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
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
    
    func stopAndReset()
    {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
}
