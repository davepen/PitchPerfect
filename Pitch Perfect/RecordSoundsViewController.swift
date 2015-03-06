import UIKit

class RecordSoundsViewController: UIViewController
{
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool)
    {
        recordButton.enabled = true;
        recordingLabel.hidden = true;
        stopButton.hidden = true;
    }
    
    @IBAction func recordAudio(sender: UIButton)
    {
        recordButton.enabled = false;
        recordingLabel.hidden = false;
        stopButton.hidden = false;
    }
    
    @IBAction func stopAudio(sender: UIButton)
    {
        recordButton.enabled = true;
        recordingLabel.hidden = true;
        stopButton.hidden = true;
    }
}

