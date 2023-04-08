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
//    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "userName == %@", "Justin" )) var users : FetchedResults<User>
    @StateObject var data : Data = Data();
    @State var loginValid : Bool = false;
    @State var registerValid : Bool = false;
    @State var alertLogin : Bool = false;
    init() {
//        @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "userName == %@", "Elvin")) var testingUsers : FetchedResults<User>
//        print("THe count of the User is : \(testingUsers.count)")
//        print("user name is : \(testingUsers.last?.userName)")
        
        
    }
    
    
    var body: some View {
        NavigationView() {
            VStack{
                Image("logo")
                    .resizable()
                    .frame(width: 600, height: 600, alignment: .center)
                    .padding(.bottom, -100)
                    .clipped()
                
                Text("Login")
                    .font(.system(size: 90))
                    .bold()
                VStack(alignment: .leading){
                    Text("User Name")
                        .font(.system(size: 50))
                    
                    TextField("Type your user name", text: $data.userName)
                        .disableAutocorrection(true)    
                        .textInputAutocapitalization(.never)
                        .font(.system(size: 40))
                        .padding(.leading, 5)
                        .frame(width: 720, height: 75)
                        .border(.gray)
                        .cornerRadius(10);
                    
                }.padding(EdgeInsets(top: 20, leading: 10, bottom: 70, trailing: 10))
                
                Button() {
                    if data.userName != "" {
                        for user in users {
                            print("User transaction : \(user.transactionArray.count)")
                            
                            if (user.userName! == data.userName) {
                                data.currentUser = user;
                                data.salary = user.salary!
                                loginValid = true;
                            }
                        }
                        
                        if !loginValid {
                            alertLogin = true;
                        }
                    }
                } label : {
                    Text("Login")
                        .frame(width: 520, height: 75)
                            .background(.white)
                            .cornerRadius(20)
                            .foregroundColor(.black)
                            .shadow(color: .gray, radius: 20)
                            .font(.system(size:40) .weight(.regular))
                }
                .padding(.bottom, 20)
                .alert(isPresented: $alertLogin) {
                    Alert(title: Text("Unrecognize User"), message: Text("the Username is wrong or maybe havent been used yet, Register?"))
                }
                

                
                Button{
                    var uniqueName : Bool = true
                    for x in users {
                        if x.userName! == data.userName {
                            uniqueName = false;
                        }
                        print(x.userName!)
                        print(x.salary)
                    }

                    if ((uniqueName || users.count < 1) && data.userName.count > 0) {
                        let user = User(context: moc)
                        user.userName = data.userName;
                        user.financialType = "unSpecified"
                        user.id = UUID()
                        user.salary = "0";
                        print("Masuk");
                        data.currentUser = user;
                        data.salary = user.salary ?? "0"
                        registerValid = true
                        
                    }
                    
//                    print(registerValid)
//                    print(users.count)
//                    print("RegisterValid : \(registerValid)")
                } label: {
                    Text("Register with User Name")
                        .frame(width: 520, height: 75)
                        .background(.black)
                        .cornerRadius(20)
                        .foregroundColor(.white)
                        .font(.system(size:40) .weight(.regular))
                        .shadow(color: .gray, radius: 5)
                }
                
                NavigationLink("", destination: PreHomePage().navigationBarHidden(true), isActive: $registerValid)
                NavigationLink("", destination:Home().navigationBarHidden(true), isActive: $loginValid)
                
                
                Spacer();
            }
        }.environmentObject(data)
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
    }
}
