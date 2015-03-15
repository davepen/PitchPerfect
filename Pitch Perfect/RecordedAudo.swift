import Foundation

class RecordedAudio
{
    var fileAtPathUrl:NSURL! = nil
    var title:String! = nil
    
    init(url:NSURL)
    {
        fileAtPathUrl = url
        title = url.lastPathComponent
    }
    
}
