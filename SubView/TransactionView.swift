//
//  SwiftUIView.swift
//  
//
//  Created by Elvin Sestomi on 05/04/23.
//

import SwiftUI
import CoreData

extension Date {
    func get (getWhat component : Calendar.Component, calendar : Calendar = Calendar.current) -> Int{
        calendar.component(component, from: self)
    }
}

struct TransactionSubView : View {
    
    @EnvironmentObject var data : Data
    var user = User();
    var twentyTo50Type : [String] = ["Investment", "Secondary Need", "Primary Need"]
    var tenTo40Type : [String] = ["Charity", "Investment", "Productive Loan", "Primary Needs"]
    @State var transPrice : String = "";
    @State var transDesc : String = "";
    @State var type : String = "Primary Need"
    @State var description : String = ""
    @Environment(\.managedObjectContext) var moc
    @State var moneyToPayforLoan : Double;
    @State var moneyToPrimaryNeeds : Double;
    @State var moneyToSecondaryNeeds : Double;
    
    
    
    init(_ data : Data, _ usersTransactions : FetchedResults<User>) {
        
        
        var dateTrans : [DateTransaction] = [];
        
        var userTransactions =  usersTransactions.filter{
            $0.userName == data.userName
        } // Still in user
        
        userTransactions.forEach{
            var transactions = $0.transactionArray;
            
            transactions = transactions.filter{
                $0.dateTime?.get(getWhat: .month) == Date().get(getWhat: .month)
            } // in transactions
            
            dateTrans = transactions;
        }
        

        
        var totalNeeds = 0.0;
        var totalSecondaryNeeds = 0.0
        var totalLoan = 0.0;
        if data.currentUser?.financialType == "10 20 30 40" {
            print("Masuk")
            for x in dateTrans {
                    print("Price: ", x.transactionPrice)
                    if x.detail == "primary Need" {
                        
                        totalNeeds += Double(x.transactionPrice ?? "0") ?? 0
                    } else {
                            totalLoan += Double(x.transactionPrice ?? "0") ?? 0
                        }

                }
            self.moneyToPayforLoan = (Double(data.currentUser?.salary ?? "0") ?? 0) / 100 * 30 - totalLoan
            self.moneyToPrimaryNeeds = (Double(data.currentUser?.salary ?? "0") ?? 0) / 100 * 40 - totalNeeds
            self.moneyToSecondaryNeeds = 0
        } else {
            print("masuk 2")
                for y in dateTrans {
                    print("masuk 4")
                    print("Price: ", y.transactionPrice)
                    if y.detail == "primary Need" {
                        print("masuk 5")
                        totalNeeds += Double(y.transactionPrice ?? "0") ?? 0
                    } else {
                        print("masuk 6")
                            totalSecondaryNeeds += Double(y.transactionPrice ?? "0") ?? 0
                        }
                    }
            self.moneyToPayforLoan = 0
            self.moneyToPrimaryNeeds = (Double(data.currentUser?.salary ?? "0") ?? 0) / 100 * 40 - totalNeeds
            self.moneyToSecondaryNeeds = (Double(data.currentUser?.salary ?? "0") ?? 0) / 100 * 40 - totalSecondaryNeeds
            }

        
        
    }
    
    var body : some View {
        var investment = (Double(data.salary ) ?? 0) / 100 * 20
        var charity = (Double(data.salary ) ?? 0) / 100 * 10
        VStack {
            VStack(alignment: .leading){
                VStack(alignment: .leading) {
                    HStack(alignment: .top){
                        Text("For Investment").font(.system(size: 40))
                        Spacer()
                        Text("\(investment)").font(.system(size: 40))
                    }
                    HStack(alignment: .top) {
                        if data.currentUser?.financialType == "10 20 30 40" {
                            Text("Total charity you can give : ").font(.system(size: 40))
                            Spacer()
                            Text("\(charity)").font(.system(size: 40))
                        }
                    }
                }.padding(.bottom, 30)
                Text("Total money you can use to buy").font(.system(size: 50))
                HStack(alignment: .top){
                    Text("Primary : ").font(.system(size: 40))
                    Spacer()
                    Text("\(moneyToPrimaryNeeds)").font(.system(size: 40))
                }
                
                    if data.currentUser?.financialType == "10 20 30 40" {
                        HStack(alignment: .top){
                            Text("Productive Loans : " ).font(.system(size: 40))
                            Spacer()
                            Text("\(moneyToPayforLoan)").font(.system(size: 40))
                        }
                    } else {
                        HStack{
                            Text("Secondary : ").font(.system(size: 40))
                            Spacer()
                            Text("\(moneyToSecondaryNeeds)").font(.system(size: 40))
                            
                        }
                    }
            }.padding(.trailing, 20)
                .padding(.leading, 20)
            
            Text("Transaction Type")
                .bold()
                .font(.system(size: 40))
                .padding(.top, 30)
            
            Picker("e", selection : $type) {
                ForEach((data.currentUser?.financialType == "10 20 30 40") ? Array(tenTo40Type[2..<4]) : Array(twentyTo50Type[1..<3]), id: \.self) {
                    Text($0).font(.system(size: 30))
                }
            }
            .pickerStyle(.wheel)
            .frame(width: 1000, height: 125)
            .cornerRadius(5)
            .contentShape(Rectangle())
            
            VStack(alignment: .leading) {
                Text("Transaction Total Nominal")
                    .bold()
                    .font(.system(size: 50))
                    
                
                TextField("0", text: $transPrice)
                    .font(.system(size: 40))
                    .padding(.leading, 20)
                    .frame(width: 1000, height: 50)
                    .border(.gray)
                    .cornerRadius(10);
                
            }
            
            VStack(alignment: .leading) {
                Text("Transaction Description").bold()
                    .font(.system(size : 50))
                
                TextField("Is there Any Description?", text: $transDesc)
                    .font(.system(size : 40))
                    .padding(.leading, 20)
                    .frame(width: 1000, height: 50)
                    .border(.gray)
                    .cornerRadius(10)
            }
            
            Button {
                if type == "Primary Need" {
                    moneyToPrimaryNeeds -= Double(transPrice) ?? 0;
                } else if type == "Productive Loan" {
                    moneyToPayforLoan -= Double(transPrice) ?? 0;
                } else if type ==  "Secondary Need" {
                    moneyToSecondaryNeeds -= Double(transPrice) ?? 0;
                    print(moneyToSecondaryNeeds)
                    print(data.currentUser!.userName ?? "")
                    
                    
                }
                
                
                let Ntransaction = DateTransaction(context: moc)
                
                Ntransaction.id = UUID();
                Ntransaction.transactionPrice = transPrice;
                Ntransaction.dateTime = Date();
                Ntransaction.detail = type;
                Ntransaction.dateTransaction = data.currentUser;
                
                do {
                    try moc.save()
                    print("Succed")
                } catch {
                    print("error saving")
                }
            }label: {
                Text("Submit")
                    .font(.system(size: 50, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 1000, height: 100, alignment: .center)
                    .background(Color(red: 201/255, green: 238/255, blue: 68/255))
                    .border(.gray, width: 3)
                    .shadow(color: .gray, radius: 10, x: 5, y: 8)
                    .cornerRadius(10)
            }.shadow(color : .gray, radius: 10)
                .padding(.top, 40)
            
            
        }.navigationTitle("Save your Transaction?")
            .padding(.top, 20)
    }
}

// So the frame is able to be set
extension UISegmentedControl {
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.setContentHuggingPriority(.defaultLow, for: .vertical)  // << here !!
    }
}

struct TransactionView : View {
    
    var menuList : [String] = ["Transaction", "History"]
    @State var selectedMenu = "Transaction"
    @EnvironmentObject var data : Data
    @FetchRequest(sortDescriptors: []) var userTransactions : FetchedResults<User>
    
    init() {


        //Background
        UISegmentedControl.appearance().backgroundColor = .darkGray



        //change the text color and size for various states
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor(red: 218/225, green: 165/225, blue: 32/225, alpha: 1)], for: .highlighted)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.black], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.white, .font : UIFont(name: "Arial Rounded MT Bold", size: 40)], for: .normal)
      }
    
    var body: some View {
        NavigationView{
            VStack{
                Picker("Menu", selection: $selectedMenu){
                    ForEach(menuList, id : \.self) {
                        Text($0)
                    }
                }.pickerStyle(.segmented)
                    .frame(height: 60)
                    .padding(.top, 20)

                
                switch selectedMenu {
                case "Transaction" :
                    
                    TransactionSubView(data, userTransactions);
                default :
                    VStack{}
                    
                }
                
                
                Spacer();
            }
        }.navigationViewStyle(StackNavigationViewStyle())
            .navigationBarHidden(true)
    }
}


