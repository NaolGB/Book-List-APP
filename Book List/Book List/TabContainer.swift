import SwiftUI

struct TabContainer: View {
    @StateObject var initializedDataStore = DataStore()
    
    var body: some View {
        TabView{
            NavigationView {
                BookList()
                    .environmentObject(initializedDataStore)
            }
            .tabItem {
                Label("Books", systemImage: "book")
            }
            NavigationView {
                ReadingList()
                    .environmentObject(initializedDataStore)
            }
            .tabItem {
                Label("Reading List", systemImage: "list.star")
            }
        }
    }
}

struct TabContainer_Previews: PreviewProvider {
    static var previews: some View {
        TabContainer()
    }
}
