import Foundation

class TrialEpisodeViewModel {
    fileprivate (set) var videoGuid: String?
    fileprivate (set) var video: Video?
    
    weak var delegate: TrialEpisodeViewModelDelegate?
    
    func loadModel(_ videoGuid: String) {
        self.videoGuid = videoGuid
        
        Video.videoFor(guid: videoGuid, appContext: MyAppDelegate.sharedAppContext,
                       onSuccess: { [weak self] video in
                        self?.video = video
                        self?.delegate?.didCompleteLoad(video)
            },
                       onFailure: { [weak self] error in
                        self?.delegate?.didFailToLoad(error)
        })
    }
}
