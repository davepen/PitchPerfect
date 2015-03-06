import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController
{
    var audioPlayer:AVAudioPlayer!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        if let path = NSBundle.mainBundle().pathForResource("movie_quote", ofType:"mp3")
        {
            let nsurl = NSURL.fileURLWithPath(path)
            audioPlayer = AVAudioPlayer(contentsOfURL: nsurl!, error: nil)
            audioPlayer.enableRate = true;
        }
        else
        {
            println("the file path is empty")
        }
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
