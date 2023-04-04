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
    @State var salary : String = "0"
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        
        var selectedFinancialState : String = "";
        
        NavigationView {
            VStack(alignment: .leading){
                Text("Financial management is the process of strategically managing one's financial resources to achieve its objectives, including budgeting, forecasting, analysis, cash and investment management, and risk management.")
                
                Text("Choose One")
                    .bold()
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                
                VStack(alignment: .leading, spacing: 20){
                    
                    HStack{
                        VStack {
                            Text("Rule 10 20 30 40")
                                .padding(.bottom, 10)
                                .font(.system(size: 16).weight(.bold))
                            
                            Text("40 percent of living needs,\n30 percent for produtive loans,\n20 percent for investment,\n10 percent for charity")
                                .font(.system(size: 12).weight(.regular))
                                .padding()
                        }
                        .frame(width: 150, height: 200)
                        .background(Color(red: 246/225, green: 255/225, blue: 212/225))
                        .opacity(lCardSelected ? 1 : 0.5)
                        .cornerRadius(8)
                        .shadow(color: .gray, radius: 8)
                        .onTapGesture {
                            lCardSelected = true;
                            rCardSelected = false;
                            selectedFinancialState = "10 20 30 40"
                        }
                        
                        VStack {
                            Text("Rule 50 30 20")
                                .padding(.bottom, 10)
                                .font(.system(size: 16).weight(.bold))
                            
                            Text("50 percent for primary needs,\n30 percent for secondary needs,\nand 20 percent for investment")
                                .font(.system(size: 12).weight(.regular))
                                .padding()
                        }
                        .frame(width: 150, height: 200)
                        .background(Color(red: 246/225, green: 255/225, blue: 212/225))
                        .opacity(rCardSelected ? 1 : 0.5)
                        .cornerRadius(8)
                        .shadow(color: .gray, radius: 8)
                        .onTapGesture {
                            rCardSelected = true;
                            lCardSelected = false;
                            selectedFinancialState = "50 30 20"
                            
                            
                        }
                    }
                }
                
                Text("Input your Monthly Salary")
                    .padding(.bottom, 10)
                    .padding(.top, 20)
                
                TextField("Input your Salary", text: $salary)
                    .padding(.leading, 10)
                    .frame(width: 320, height: 50)
                    .border(.gray)
                    .cornerRadius(5);
                
                                Button{
                                    data.newUser?.financialType = selectedFinancialState;
                
                                    try? moc.save()
                                } label :{
                                    Text("Submit")
                                        .frame(width: 320, height: 50)
                                        .background(.black)
                                        .cornerRadius(8)
                                        .foregroundColor(.white)
                                        .font(.system(size:15) .weight(.regular))
                                        .shadow(color: .gray, radius: 5)
                                }
                
                Spacer();
                
            }.navigationBarTitle("Hello, \(data.userName)")
                .padding();
        }
    }
}
