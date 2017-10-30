
protocol TrialEpisodeViewModelDelegate : class {
    func didCompleteLoad(_ video: Video)
    func didFailToLoad(_ error: ServiceError)
}

