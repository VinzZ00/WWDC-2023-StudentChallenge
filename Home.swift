//
//  Home.swift
//  WWDCStudentChallenge
//
//  Created by Elvin Sestomi on 04/04/23.
//

import SwiftUI

struct Home: View {
    
    @EnvironmentObject var data : Data;
    
    
    var body: some View {
        NavigationView{
                TabView{
                    VStack{
                        TransactionView()
                        Spacer()
                    }
                    .tabItem{
                        Image(systemName: "doc.fill")
                        Text("Report")
                    }
                    VStack{
                            SettingView();
                        NavigationLink("", destination: LoginPage().navigationBarHidden(true), isActive: $data.logout)

                    }
                    .tabItem{
                        Image(systemName: "gearshape.fill")
                        Text("Setting")
                    }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}





struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
