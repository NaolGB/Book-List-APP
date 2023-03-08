import Foundation

struct SynopsisEndPoint {
    static func apiPath(bookId: String) -> String {
        let baseUrl: String = "https://openlibrary.org/works"
        let path: String = "\(baseUrl)/\(bookId).json"
        return path
    }
}
