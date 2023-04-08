import SwiftUI

@main
struct MyApp: App {
    @StateObject var dataController = DataController()

    
    var body: some Scene {
        WindowGroup {
            landingPage()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                
        }
    }
}
