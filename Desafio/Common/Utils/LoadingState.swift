struct LoadingState {
    var isLoading: Bool
    var error: Error?
    
    init(isLoading: Bool, error: Error? = nil) {
        self.isLoading = isLoading
        self.error = error
    }
}
