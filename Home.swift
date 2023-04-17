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
            VStack {
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
                        SettingView()
                            .background(
                                LinearGradient(colors: [Color(red: 241/255, green: 255/255, blue: 190/255), Color(red: 15/255, green: 195/255, blue: 14/255)], startPoint: .leading, endPoint: .trailing)
                            );
                    }
                    .tabItem{
                        Image(systemName: "gearshape.fill")
                        Text("Setting")
                    }
                }
                NavigationLink("", destination: LoginPage().navigationBarHidden(true), isActive: $data.logout)
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
