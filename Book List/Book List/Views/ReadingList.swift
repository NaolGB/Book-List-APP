import SwiftUI

struct ReadingList: View {
    @EnvironmentObject var bookStore: DataStore
    
    var body: some View {
        VStack(spacing: 3) {
            List(bookStore.booksOnReadingList) {book in
                BookRow(book: book)
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            bookStore.removeBookFromReadingList(book: book)
                        }label: {
                            Label("Remove from List", systemImage: "trash")
                        }
                    }
            }
            
        }
        .navigationTitle("Read Books List")
    }
}

struct ReadingList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BookList()
        }
    }
}
