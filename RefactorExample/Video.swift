
class Video {
    let title: String
    let guid: String
    
    init(title: String, guid: String) {
        self.title = title
        self.guid = guid
    }
    
    static func videoFor(
        guid: String,
        appContext: AppContext,
        onSuccess: (Video) -> Void,
        onFailure: (ServiceError) -> Void)  {
        
        let exampleVideo = Video(title: "someTitle", guid: "someGuid")
        
        if exampleVideo.guid == guid {
            onSuccess(exampleVideo)
        }
        else {
            onFailure(.someError)
        }
    }
}
