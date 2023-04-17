//
//  homePage.swift
//  WWDCStudentChallenge
//
//  Created by Elvin Sestomi on 01/04/23.
//

import SwiftUI

struct PreHomePage: View {
    @EnvironmentObject var data : Data;
    @State var lCardSelected : Bool = false
    @State var rCardSelected : Bool = false

    @State var goToHome : Bool = false;
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                Text("Financial management is the process of strategically managing one's financial resources to achieve its objectives, including budgeting, forecasting, analysis, cash and investment management, and risk management.").font(.system(size: 30))
                
                Text("Choose One")
                    .font(.system(size: 40))
                    .bold()
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                
                VStack(alignment: .leading, spacing: 20){
                    
                    HStack(spacing: 40){
                        VStack {
                            Text("Rule 10 20 30 40")
                                .padding(.bottom, 10)
                                .font(.system(size: 40).weight(.bold))
                            
                            Text("40 percent of living needs,\n30 percent for produtive loans,\n20 percent for investment,\n10 percent for charity")
                                .font(.system(size: 30).weight(.regular))
                                .padding()
                        }
                        .frame(width: 400, height: 400)
                        .background(Color(red: 246/225, green: 255/225, blue: 212/225))
                        .opacity(lCardSelected ? 1 : 0.5)
                        .cornerRadius(8)
                        .shadow(color: .gray, radius: 8)
                        .onTapGesture {
                            lCardSelected = true;
                            rCardSelected = false;
                            data.currentUser?.financialType = "10 20 30 40"
                        }
                        VStack {
                            Text("Rule 50 30 20")
                                .padding(.bottom, 10)
                                .font(.system(size: 40).weight(.bold))
                            
                            Text("50 percent for primary needs,\n30 percent for secondary needs,\nand 20 percent for investment")
                                .font(.system(size: 30).weight(.regular))
                                .padding()
                        }
                        .frame(width: 400, height: 400)
                        .background(Color(red: 246/225, green: 255/225, blue: 212/225))
                        .opacity(rCardSelected ? 1 : 0.5)
                        .cornerRadius(8)
                        .shadow(color: .gray, radius: 8)
                        .onTapGesture {
                            rCardSelected = true;
                            lCardSelected = false;
                            data.currentUser?.financialType = "50 30 20"
                            
                            
                        }
                    }
                }
                
                Text("Input your Monthly Salary")
                    .font(.system(size : 40))
                    .padding(.bottom, 10)
                    .padding(.top, 20)
                
                TextField("\(data.currentUser?.salary ?? "0")", text: $data.salary)
                    .font(.system(size: 40))
                    .padding(.leading, 10)
                    .frame(width: 1000, height: 75)
                    .border(.gray)
                    .cornerRadius(5)
                    
                
                                Button{
                                    data.currentUser?.salary = data.salary
                                    do {
                                        try moc.save()
                                        goToHome = true;
                                    } catch{
                                        print("error saving")
                                    }
                                    
                                    
                                    
                                } label :{
                                    Text("Submit")
                                        .frame(width: 1000, height: 100)
                                        .background(.black)
                                        .cornerRadius(8)
                                        .font(.system(size : 50))
                                        .foregroundColor(.white)
                                        .font(.system(size:15) .weight(.regular))
                                        .shadow(color: .gray, radius: 5)
                                }
                NavigationLink("", destination: Home().navigationBarHidden(true), isActive: $goToHome)
                Spacer();
            }.navigationBarTitle("Hello, \(data.userName)")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
