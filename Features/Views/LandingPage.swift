import SwiftUI

struct landingPage: View {
    @StateObject var dataController = DataController();
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                Spacer()
                HStack(alignment: .top){
                    Spacer()
                    Text("Hey, may I ask you something?\ndo you know what is money management?, don't know how to manage it?\n")
                        .font(.system(size: 30));
                    Spacer()
                }
                
                NavigationLink(destination : LoginPage().navigationBarHidden(true)) {
                    Text("Chill, We Got you!")
                        .frame(width: 700, height: 150)
                        .background(.black)
                        .cornerRadius(20)
                        .foregroundColor(Color(red: 218/225, green: 165/225, blue: 32/225))
                        .font(.system(size:60) .weight(.heavy))
                }.padding()
                
                
                Spacer();
            }.background(
                Image("freePikWallpaper")
                    .opacity(0.1)
            )
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
