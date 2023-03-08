import SwiftUI

struct BookForm: View {
    @Binding var bookFormData: Book.FormData
    
    var body: some View {
        Form {
            TextFieldWithLabel(label: "Id", text: $bookFormData.id)
            TextFieldWithLabel(label: "Title", text: $bookFormData.title)
            TextFieldWithLabel(label: "Author", text: $bookFormData.author)
        }
    }
}

struct TextFieldWithLabel: View {
    let label: String
    @Binding var text: String
    var prompt: String? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .bold()
                .font(.caption)
            TextField(label, text: $text, prompt: prompt != nil ? Text(prompt!) : nil)
                .padding(.bottom, 20)
        }
    }
}

struct BookForm_Previews: PreviewProvider {
    static var previews: some View {
        BookForm(bookFormData: Binding.constant(Book.previewData[0].dataForForm))
    }
}
