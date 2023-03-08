import SwiftUI

struct BookList: View {
    @EnvironmentObject var bookStore: DataStore
    @StateObject var synopsisLoader = SynopsisLoader(apiClient: SysnopsisAPIClient())
    
    @State var bookFormOpen: Bool = false
    @State var newBookForm = Book.FormData()
    
    var body: some View {
        VStack {
            List(bookStore.books) {book in
                NavigationLink(destination: BookDetail(book: book)
                    .environmentObject(bookStore)
                    .environmentObject(synopsisLoader)
                ) {
                    HStack{
                        if book.coverUrl != nil {
                            AsyncImage(
                                url: book.coverUrl,
                                content: { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxHeight: 50)
                                },
                                placeholder: {
                                    Image(systemName: "book")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxHeight: 25)
                                }
                            )
                        }
                        else {
                            Image(systemName: "book")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxHeight: 25)
                        }
                        
                        VStack(alignment: .leading){
                            Text(book.title)
                                .bold()
                            Text(book.author)
                        }
                    }
                }
            }
        }
        .navigationTitle("Books")
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Create") {
                    bookFormOpen.toggle()
                }
            }
        }
        
        .sheet(isPresented: $bookFormOpen) {
            NavigationStack {
                BookForm(bookFormData: $newBookForm)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading){
                            Button("Cancel") {
                                bookFormOpen = false
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Save") {
                                let newBook = Book.create(from: newBookForm)
                                bookStore.createNewBook(book: newBook)
                                bookFormOpen = false
                            }
                        }
                    }
            }
        }
    }
}

struct BookList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BookList()
        }
    }
}
