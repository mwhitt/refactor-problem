import Foundation

protocol APICallable {
    func getVideo(_ guid: String, onSuccess: (Video) -> Void, onFailure: (ServiceError) -> Void)
}

class APIManager: APICallable {
    func getVideo(_ guid: String, onSuccess: (Video) -> Void, onFailure: (ServiceError) -> Void) {
        let exampleVideo = Video(title: "someTitle", guid: "someGuid")
        if exampleVideo.guid == guid {
            onSuccess(exampleVideo)
        }
        else {
            onFailure(.someError)
        }
    }
}
