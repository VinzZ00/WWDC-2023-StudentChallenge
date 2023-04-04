//
//  homePage.swift
//  WWDCStudentChallenge
//
//  Created by Elvin Sestomi on 01/04/23.
//

import SwiftUI

struct LoginPage: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var users : FetchedResults<User>
    @StateObject var data : Data = Data();
    @State var loginValid : Bool = false;
    @State var registerValid : Bool = false;
    
    
    var body: some View {
        NavigationView() {
            
            VStack{
                Image("logo")
                    .frame(width: .infinity, height: 200)
                    .padding(.bottom, 20)
                
                Text("Login").frame(width: .infinity)
                    .font(.system(size: 30) .weight(.heavy))
                
                VStack(alignment: .leading){
                    Text("User Name").frame(width: .infinity).font(.system(size: 16))
                    
                    TextField("Type your user name", text: $data.userName)
                        .padding(.leading, 5)
                        .frame(width: 320, height: 50)
                        .border(.gray)
                        .cornerRadius(5);
                    
                }.padding(EdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10))
                
                Button() {
                    if data.userName != "" {
                        for user in users {
                            if (user.userName! == data.userName) {
                                loginValid = true;
                            }
                        }
                    }
                } label : {
                    Text("Login")
                        .frame(width: 320, height: 50)
                            .background(.white)
                            .cornerRadius(8)
                            .foregroundColor(.black)
                            .border(.gray)
                            .shadow(color: .gray, radius: 5)
                            .font(.system(size:15) .weight(.regular))
                }
                
//                Text("\(registerValid ? "True" : "False")")
                

                
                Button{
                    var uniqueName : Bool = false
                    for x in users {
                        if x.userName! != data.userName {
                            uniqueName = true;
                        }
                    }
//                    print(users.first?.userName!)
//                    print(uniqueName)
//                    print(users.count)
                    if (uniqueName || users.count < 1) {
                        let user = User(context: moc)
                        user.userName = data.userName;
                        user.financialType = "unSpecified"
                        user.id = UUID()
                        user.salary = 0.00;
                        
                        data.newUser = user;
//                        registerValid = true
                    } else {
                        registerValid = false;
                    }
//                    print(users.count)
//                    print("RegisterValid : \(registerValid)")
                } label: {
                    Text("Register with User Name")
                        .frame(width: 320, height: 50)
                        .background(.black)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .font(.system(size:15) .weight(.regular))
                        .shadow(color: .gray, radius: 5)
                }
                
                NavigationLink("", destination: PreHomePage().navigationBarHidden(true), isActive: $registerValid)
                NavigationLink("", destination:PreHomePage().navigationBarHidden(true), isActive: $loginValid)
                
                
                Spacer();
            }
        }.environmentObject(data)
            .navigationBarHidden(true)
    }
}
