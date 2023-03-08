import Foundation


class SynopsisLoader: ObservableObject {
    let apiClient: SynopsisAPI
    
    @Published private(set) var synopsisLoaderState: LoadingState = .idle
    
    enum LoadingState {
        case idle
        case loading
        case success(data: OpenLibraryResponse)
        case failed(error: Error)
    }
    
    init(apiClient: SynopsisAPI) {
        self.apiClient = apiClient
    }
    
    @MainActor
    func loadSynopsis(bookId: String) async {
        self.synopsisLoaderState = .loading
        
        do{
            let synopsis: OpenLibraryResponse = try await apiClient.fetchSynopsis(bookId: bookId)
            self.synopsisLoaderState = .success(data: synopsis)
        }
        catch {
            self.synopsisLoaderState = .failed(error: error)
        }
        
        
    }
}
