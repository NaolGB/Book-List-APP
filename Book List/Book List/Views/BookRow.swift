import SwiftUI

struct BookRow: View {
    let book: Book
    
    var body: some View {
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

struct BookRow_Previews: PreviewProvider {
    static var previews: some View {
        BookRow(book: Book.previewData[0])
    }
}
