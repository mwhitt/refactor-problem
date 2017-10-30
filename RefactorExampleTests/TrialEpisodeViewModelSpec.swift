import Quick
import Nimble
@testable import RefactorExample

// MARK: Mocking classes

var mockShouldReturnSuccess = false

class AppContextMock: ShareableContext {
    var apiManager: APICallable = APIManagerMock()
}

class APIManagerMock: APICallable {
    func getVideo(_ guid: String, onSuccess: (Video) -> Void, onFailure: (ServiceError) -> Void) {
        let exampleVideo = Video(title: "someTitle", guid: "someGuid")
        if mockShouldReturnSuccess {
            onSuccess(exampleVideo)
        } else {
            onFailure(.someError)
        }
    }
}

class TrialEpisodeViewModelDelegateStub: NSObject, TrialEpisodeViewModelDelegate {
    var didCompleteLoadCalled = false
    var didFailToLoadCalled = false
    
    func didCompleteLoad(_ video: Video) {
        didCompleteLoadCalled = true
    }
    
    func didFailToLoad(_ error: ServiceError) {
        didFailToLoadCalled = true
    }
}

// MARK: Main tests

class TrialEpisodeViewModelSpec : QuickSpec {
    
    override func spec() {
        describe("TrialEpisodeViewModel") {
            let videoGUID = "123xyz"
            var trialEpisodeVM = TrialEpisodeViewModel()
            var delegateStub = TrialEpisodeViewModelDelegateStub()
            let contextMock = AppContextMock()
            
            beforeEach {
                trialEpisodeVM = TrialEpisodeViewModel()
                delegateStub = TrialEpisodeViewModelDelegateStub()
                trialEpisodeVM.delegate = delegateStub
            }
            
            context("onSuccess", closure: {
                it("delegate will recieve didCompleteLoad") {
                    mockShouldReturnSuccess = true
                    trialEpisodeVM.loadModel(videoGUID, appContext: contextMock)
                    expect(delegateStub.didCompleteLoadCalled).to(equal(true))
                }
            })
            
            context("onFailure", closure: {
                it("delegate will recieve didFailToLoad with an error") {
                    mockShouldReturnSuccess = false
                    trialEpisodeVM.loadModel(videoGUID, appContext: contextMock)
                    expect(delegateStub.didFailToLoadCalled).to(equal(true))
                }
            })
            
        }
    }
}
