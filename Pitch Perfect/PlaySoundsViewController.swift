import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController
{
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!

    override func viewDidLoad()
    {
        super.viewDidLoad()

//        if let path = NSBundle.mainBundle().pathForResource("movie_quote", ofType:"mp3")
//        {
//            let nsurl = NSURL.fileURLWithPath(path)
//
//        }
//        else
//        {
//            println("the file path is empty")
//        }
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.fileAtPathUrl!, error: nil)
        audioPlayer.enableRate = true;
    }

    @IBAction func playSlow(sender: UIButton)
    {
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }

    @IBAction func playFast(sender: UIButton)
    {
        audioPlayer.stop()
        audioPlayer.rate = 2.0
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    @IBAction func playChipmunk(sender: UIButton)
    {
        
    }
    
    @IBAction func playStop(sender: UIButton)
    {
        audioPlayer.stop()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
