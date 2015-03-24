import UIKit
import AVFoundation

class RecordSoundsViewController : UIViewController, AVAudioRecorderDelegate
{
    @IBOutlet weak var recordingLabel:UILabel!
    @IBOutlet weak var stopButton:UIButton!
    @IBOutlet weak var recordButton:UIButton!

    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    let SEGUE_IDENTIFIER = "stopRecording"

    override func viewWillAppear(animated:Bool)
    {
        recordButton.enabled = true
        stopButton.hidden = true
        recordingLabel.text = "Tap to Record"
        recordingLabel.textColor = UIColor.blueColor()
    }
    
    @IBAction func recordAudio(sender:UIButton)
    {
        recordButton.enabled = false
        stopButton.hidden = false
        recordingLabel.text = "Recording"
        recordingLabel.textColor = UIColor.redColor()
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime) + ".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error:nil)
        
        audioRecorder = AVAudioRecorder(URL:filePath, settings:nil, error:nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopAudio(sender:UIButton)
    {
        recordButton.enabled = true
        stopButton.hidden = true
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
    /**
        Called by the system when a recording is stopped or has finished due to reaching its time limit.
    
        :param: recorder The audio recorder that has finished recording.
        :param: flag     YES on successful completion of recording; NO if recording stopped because of an audio encoding error.
    */
    func audioRecorderDidFinishRecording(recorder:AVAudioRecorder!, successfully flag:Bool)
    {
        if (flag)
        {
            recordedAudio = RecordedAudio(url:recorder.url)
            self.performSegueWithIdentifier(SEGUE_IDENTIFIER, sender:recordedAudio)
        }
        else
        {
            recordButton.enabled = true
            stopButton.hidden = true
        }
    }
    
    override func prepareForSegue(segue:UIStoryboardSegue, sender:AnyObject?)
    {
        if (segue.identifier == SEGUE_IDENTIFIER)
        {
            let playSoundViewController:PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            let data = sender as RecordedAudio
            playSoundViewController.receivedAudio = data
        }

    }
    
}