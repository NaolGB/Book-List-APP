import SwiftUI

struct BookDetail: View {
    @EnvironmentObject var bookStore: DataStore
    @EnvironmentObject var synopsisLoader: SynopsisLoader
    
    let book: Book
    
    var body: some View {
        VStack(spacing: 3) {
            ScrollView {
                //                image
                if book.coverUrl != nil {
                    AsyncImage(
                        url: book.coverUrl,
                        content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxHeight: 300)
                                .padding(15)
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
                
                //                title and author
                Text(book.title)
                    .font(.title)
                Text(book.author)
                    .font(.subheadline)
                
                //                synopsis
                switch synopsisLoader.synopsisLoaderState {
                case .idle: Color.clear
                case .loading :  ProgressView()
                case .failed(let _): Text("Could not load description").padding()
                case .success(let data) : Text(data.responseContainer.synopsis).padding()
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if bookStore.booksOnReadingList.contains(where: {$0.id == book.id}) {
                        Button("Remove from List") {
                            bookStore.removeBookFromReadingList(book: book)
                        }
                    }
                    else {
                        Button("Add to List") {
                            bookStore.addBooktoReadingList(book: book)
                        }
                    }
                }
            }
            .task {
                await synopsisLoader.loadSynopsis(bookId: book.id)
            }
        }
    }
}

struct BookDetail_Previews: PreviewProvider {
    static var previews: some View {
        BookDetail(book: Book.previewData[0])
            .environmentObject(SynopsisLoader(apiClient: SysnopsisAPIClient()))
    }
}
