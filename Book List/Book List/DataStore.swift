import Foundation

class DataStore: ObservableObject {
    @Published var books: [Book] = Book.previewData
    @Published var booksOnReadingList: [Book] = []
    
    func createNewBook(book: Book) {
        self.books.append(book)
    }
    
    func addBooktoReadingList(book: Book) {
        self.booksOnReadingList.append(book)
    }
    
    func removeBookFromReadingList(book: Book) {
        if let index = booksOnReadingList.firstIndex(where: {$0.id == book.id}) {
            self.booksOnReadingList.remove(at: index)
        }
    }
}
