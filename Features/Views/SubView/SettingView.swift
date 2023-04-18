import SwiftUI
import CoreData

struct SettingView : View {
    @EnvironmentObject var data : Data;
    @State var lCardSelected : Bool = false
    @State var rCardSelected : Bool = false
    @Environment(\.managedObjectContext) var moc
    
//    @State var loginPage : Bool = false;
    

    var body : some View {
        NavigationView{
            VStack(alignment: .leading){
                Text("Change Profile?")
                    .font(.system(size:60)).bold()
                
                Text("Input your Monthly Salary")
                    .font(.system(size : 30))
                    .padding(.bottom, 10)
                    .padding(.top, 20)
                
                TextField("\(data.currentUser?.salary ?? "0")", text: $data.salary)
                    .padding(.leading, 10)
                    .font(.system(size : 30))
                    .frame(width: 1000, height: 60)
                    .border(.gray)
                    .cornerRadius(5)
                    .padding(.bottom, 50)
                
                HStack{
                    Spacer()
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
                    }
                    Spacer();
                }
                
                Spacer()
                
                VStack{
                    HStack{
                        quotesView(quotesInd: "\"Sedikit - Sedikit lama-lama jadi bukit\"", quotesEnglish: "\"little by little/bit by bit fills the purse\"", title: "A little Quotes of the day, that inspires this apps:")
                        Spacer()
                    }
                        
                    
                    HStack{
                        Spacer()
                        quotesView(quotesInd: "\"Pencapaian besar dimulai dari keberhasilan melakukan satu hal kecil.\"", quotesEnglish: "\"the journey of a thousand miles starts with a single step indoneisa\"", title: "~ Quotes from Laozhu ~")
                    }
                }.padding();
                
                Spacer()
                
                
                
                
                HStack{
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
                    
                    Spacer()
                }
                
                
            }.navigationBarTitle("Hello, \(data.userName)")
                .padding();
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}


struct quotesView : View {
    
    var quotesInd : String;
    var quotesEnglish : String;
    var title : String;
    var body : some View {
        VStack(alignment: .leading){
            HStack {
                Spacer()
                Text("\(title)")
                    .font(.custom("American Typewriter", size: 30))
            }.padding()
            
            VStack(alignment: .leading) {
                Text("\(quotesInd)")
                    .font(.custom("Bondoni 72", size: 40))
                    .padding(.leading, 20)
                HStack{
                    Spacer()
                    Text("Translated,")
                        .font(.system(size : 30))
                        .bold()
                    Spacer()
                }
                HStack{
                    Spacer();
                    Text("\(quotesEnglish)")
                        .font(.custom("Bondoni 72", size: 40))
                        .padding(.bottom, 20)
                }.padding(.trailing, 20)
            }
        }.frame(width: 900)
            .background(Color(red: 241/255, green: 255/255, blue: 190/255))
            .border(.black).opacity(0.75)
    }
}
