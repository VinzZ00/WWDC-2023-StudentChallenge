import SwiftUI
import CoreData

struct SettingView : View {
    @EnvironmentObject var data : Data;
    @State var lCardSelected : Bool = false
    @State var rCardSelected : Bool = false
    @Environment(\.managedObjectContext) var moc
    
    @State var loginPage : Bool = false;
    

    var body : some View {
        NavigationView{
            VStack(alignment: .leading){
                Text("Change Profile?").font(.system(size:20)).bold()
                
                //                Text("Choose One")
                //                    .bold()
                //                    .padding(.top, 20)
                //                    .padding(.bottom, 10)
                //
                //                VStack(alignment: .leading, spacing: 20){
                //
                //                    HStack{
                //                        VStack {
                //                            Text("Rule 10 20 30 40")
                //                                .padding(.bottom, 10)
                //                                .font(.system(size: 16).weight(.bold))
                //
                //                            Text("40 percent of living needs,\n30 percent for produtive loans,\n20 percent for investment,\n10 percent for charity")
                //                                .font(.system(size: 12).weight(.regular))
                //                                .padding()
                //                        }
                //                        .frame(width: 150, height: 200)
                //                        .background(Color(red: 246/225, green: 255/225, blue: 212/225))
                //                        .opacity((lCardSelected || data.currentUser?.financialType == "10 20 30 40") ? 1 : 0.5)
                //                        .cornerRadius(8)
                //                        .shadow(color: .gray, radius: 8)
                //                        .onTapGesture {
                //                            lCardSelected = true;
                //                            rCardSelected = false;
                //                            data.currentUser?.financialType = "10 20 30 40"
                //                        }
                //
                //                        VStack {
                //                            Text("Rule 50 30 20")
                //                                .padding(.bottom, 10)
                //                                .font(.system(size: 16).weight(.bold))
                //
                //                            Text("50 percent for primary needs,\n30 percent for secondary needs,\nand 20 percent for investment")
                //                                .font(.system(size: 12).weight(.regular))
                //                                .padding()
                //                        }
                //                        .frame(width: 150, height: 200)
                //                        .background(Color(red: 246/225, green: 255/225, blue: 212/225))
                //                        .opacity((rCardSelected || data.currentUser?.financialType == "50 30 20") ? 1 : 0.5)
                //                        .cornerRadius(8)
                //                        .shadow(color: .gray, radius: 8)
                //                        .onTapGesture {
                //                            rCardSelected = true;
                //                            lCardSelected = false;
                //                            data.currentUser?.financialType  = "50 30 20"
                //
                //
                //                        }
                //                    }
                //                }
                
                Text("Input your Monthly Salary")
                    .padding(.bottom, 10)
                    .padding(.top, 20)
                
                TextField("\(data.currentUser?.salary ?? "0")", text: $data.salary)
                    .padding(.leading, 10)
                    .frame(width: 320, height: 50)
                    .border(.gray)
                    .cornerRadius(5);
                
                Button{
                    data.currentUser?.salary = data.salary;
                    do {
                        try moc.save()
                        data.logout = true;
                    } catch{
                        print("error saving")
                    }
                    
                } label :{
                    Text("Submit")
                        .frame(width: 750, height: 75)
                        .background(.black)
                        .cornerRadius(15)
                        .foregroundColor(.white)
                        .font(.system(size:40) .weight(.regular))
                        .shadow(color: .gray, radius: 5)
                }.padding(.bottom, 30)
                Spacer()
                
                Button {
                    data.logout = true
                } label: {
                    Text("Change user")
                        .frame(width: 750, height: 75)
                        .background(.red)
                        .cornerRadius(15)
                        .foregroundColor(.white)
                        .font(.system(size:40) .weight(.regular))
                        .shadow(color: .gray, radius: 5)
                }.padding(.bottom, 40)
//                Spacer();
                
            }.navigationBarTitle("Hello, \(data.userName)")
                .padding();
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
