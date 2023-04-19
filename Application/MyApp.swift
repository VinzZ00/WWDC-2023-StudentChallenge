// Made by Elvin Sestomi
// The apps has been test on iPad Pro 12.9 inch (2th Generation)
// For the best Experience please run on iPad Pro 12.9 inch (2 Generation)

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
