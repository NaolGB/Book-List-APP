// source code provided by Jon Philips https://www.linkedin.com/in/jonrphillips/

import Foundation

protocol SynopsisAPI {
    func fetchSynopsis(bookId: String) async throws -> OpenLibraryResponse
}

struct SysnopsisAPIClient: SynopsisAPI, APIClient {
    let session: URLSession = .shared
    
    func fetchSynopsis(bookId: String) async throws -> OpenLibraryResponse {
        let path = SynopsisEndPoint.apiPath(bookId: bookId)
        let response: OpenLibraryResponse = try await performRequest(url: path)
        return response
    }
}
