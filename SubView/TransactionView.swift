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
    var tenTo40Type : [String] = ["Charity", "Investment", "Productive Loan", "Primary Need"]
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
        
        let userTransactions =  usersTransactions.filter{
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
            for x in dateTrans {
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
                for y in dateTrans {
                    if y.detail == "primary Need" {
                        totalNeeds += Double(y.transactionPrice ?? "0") ?? 0
                    } else {
                            totalSecondaryNeeds += Double(y.transactionPrice ?? "0") ?? 0
                        }
                    }
            self.moneyToPayforLoan = 0
            self.moneyToPrimaryNeeds = (Double(data.currentUser?.salary ?? "0") ?? 0) / 100 * 40 - totalNeeds
            self.moneyToSecondaryNeeds = (Double(data.currentUser?.salary ?? "0") ?? 0) / 100 * 40 - totalSecondaryNeeds
            }
        
        

        
        
    }
    
    var body : some View {
        let investment = (Double(data.salary ) ?? 0) / 100 * 20
        let charity = (Double(data.salary ) ?? 0) / 100 * 10
        VStack {
            VStack(alignment: .leading){
                VStack(alignment: .leading) {
                    HStack(alignment: .top){
                        Text("For Investment").font(.system(size: 40))
                        Spacer()
                        Text(String(format: "%.2f", investment)).font(.system(size: 40))
                    }
                    HStack(alignment: .top) {
                        if data.currentUser?.financialType == "10 20 30 40" {
                            Text("Total charity you can give : ").font(.system(size: 40))
                            Spacer()
                            Text(String(format: "%.2f", charity)).font(.system(size: 40))
                        }
                    }
                }.padding(.bottom, 30)
                Text("Total money you can use to buy").font(.system(size: 50))
                HStack(alignment: .top){
                    Text("Primary : ").font(.system(size: 40))
                    Spacer()
                    Text(String(format: "%.2f", moneyToPrimaryNeeds))
                        .font(.system(size: 40))
                        .foregroundColor((moneyToPrimaryNeeds > 0) ? .black : .red)
                }
                
                    if data.currentUser?.financialType == "10 20 30 40" {
                        HStack(alignment: .top){
                            Text("Productive Loans : " ).font(.system(size: 40))
                            Spacer()
                            Text(String(format: "%.2f", moneyToPayforLoan))
                                .font(.system(size: 40))
                                .foregroundColor((moneyToPayforLoan > 0) ? .black : .red)
                        }
                    } else {
                        HStack{
                            Text("Secondary : ").font(.system(size: 40))
                            Spacer()
                            Text(String(format: "%.2f", moneyToSecondaryNeeds))
                                .font(.system(size: 40))
                                .foregroundColor((moneyToSecondaryNeeds > 0) ? .black : .red)
                            
                        }
                    }
            }.padding(.trailing, 20)
                .padding(.leading, 20)
            
            Text("Transaction Type")
                .bold()
                .font(.system(size: 40))
                .padding(.top, 30)
            
            Picker("", selection : $type) {
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
                    .padding()
                
                TextField("0", text: $transPrice)
                    .font(.system(size: 40))
                    .padding(.leading, 20)
                    .frame(width: 970, height: 50)
                    .border(.black, width: 3)
                    .cornerRadius(10);
            }
            
            VStack(alignment: .leading) {
                Text("Transaction Description").bold()
                    .font(.system(size : 50))
                    .padding()
                
                TextField("Is there Any Description?", text: $transDesc)
                    .font(.system(size : 40))
                    .padding(.leading, 20)
                    .frame(width: 970, height: 100)
                    .border(.black, width: 3)
                    .cornerRadius(10)
            }
            
            Button {
                
                
                if type == "Primary Need" {
                    moneyToPrimaryNeeds -= Double(transPrice) ?? 0;
                } else if type == "Productive Loan" {
                    moneyToPayforLoan -= Double(transPrice) ?? 0;
                } else if type ==  "Secondary Need" {
                    moneyToSecondaryNeeds -= Double(transPrice) ?? 0;
                    
                    
                }
                
                
                let Ntransaction = DateTransaction(context: moc)
                
                Ntransaction.id = UUID();
                Ntransaction.transactionPrice = transPrice;
                Ntransaction.dateTime = Date();
                Ntransaction.detail = type;
                Ntransaction.dateTransaction = data.currentUser;
                Ntransaction.descriptionTransaction  = transDesc
                
                do {
                    try moc.save()
                } catch {
                    print("error saving")
                }
            }label: {
                Text("Submit")
                    .font(.system(size: 50, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 970, height: 100, alignment: .center)
                    .background(Color(red: 201/255, green: 238/255, blue: 68/255))
                    .border(.gray, width: 3)
                    .shadow(color: .gray, radius: 10, x: 5, y: 8)
                    .cornerRadius(10)
            }.shadow(color : .gray, radius: 10)
                .padding(.top, 40)
                .padding(.bottom, 20)
            Spacer()
            
        }.navigationTitle("Save your Transaction?")
            .padding(.top, 20)
            .background(.white.opacity(0.7))
    }
}

// So the frame is able to be set
extension UISegmentedControl {
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
}

struct TransactionView : View {
    
    var menuList : [String] = ["Transaction", "History"]
    @State var selectedMenu = "Transaction"
    @EnvironmentObject var data : Data
    @FetchRequest(sortDescriptors: []) var userTransactions : FetchedResults<User>
    
    init() {


        //Background
        UISegmentedControl.appearance().backgroundColor = UIColor(Color(red: 175/255, green: 198/255, blue: 91/255))



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
                    
                    TransactionSubView(data, userTransactions)
                        .cornerRadius(20)
                        .shadow(color: .gray, radius: 10)
                        
                default :
                    HistorySubView(data, userTransactions)
                        .navigationTitle("History")
                    
                }
                
                
                Spacer();
            }
            .padding()
            .background(
                LinearGradient(colors: [Color(red: 190/255, green: 201/255, blue: 112/255), Color(red: 19/255, green: 198/255, blue: 201/255)], startPoint: .leading, endPoint: .trailing)
            )
        }.navigationViewStyle(StackNavigationViewStyle())
            .navigationBarHidden(true)
    }
}





struct HistorySubView : View {
    
    var user : User?;
    @State var isShowedTrans : Bool = false;

    
    init(_ data : Data, _ usersTransactions : FetchedResults<User>) {
        usersTransactions.forEach{
            if $0.userName == data.userName {
                self.user = $0;
            }
        }
    }
    
    
    
    var body : some View {
        NavigationView {
            VStack{
                if let u = user!.transactionArray {
                    
                    let uniqueTransDate = getUniqueDateArray(trans: u)
                    
                    var dateSelected : Date = Date();

                    List(uniqueTransDate, id : \.self) {
                        transDate in
                        Button {
                            isShowedTrans = true
                            dateSelected = transDate;
                        } label: {
                            VStack{
                                HStack{
                                    Text(String(format: "Total : %.2f", getTotalDaily(transDate, u)))
                                    
                                    Spacer();
                                    
                                    Text(String("\(transDate.formatted(date: .abbreviated, time: .omitted))"))
                                }
                            }.sheet(isPresented: $isShowedTrans, content: {
                                let transactions : [DateTransaction] = filterTransactionbyDay(u, dateSelected);
                                
                                VStack{
                                    HStack{
                                        Text("Transaction : \(dateSelected.formatted(date: .abbreviated, time: .omitted))")
                                            .padding()
                                            .font(.system(size: 30, weight: .bold))
                                            .foregroundColor(.black)
                                        Spacer()
                                    }
                                    
                                    List(transactions, id : \.self) {trans in
                                        VStack{
                                            HStack{
                                                Text("\((trans.dateTime?.formatted(date: .abbreviated, time: .omitted))!)")
                                                Spacer()
                                                Text(String(trans.transactionPrice ?? ""))
                                            }.padding()
                                            Text(String(trans.descriptionTransaction ?? "No Description"))
                                        }
                                    }
                                    
                                }
                                
                                .background(
                                    LinearGradient(colors: [Color(red: 190/255, green: 201/255, blue: 112/255), Color(red: 19/255, green: 198/255, blue: 201/255)], startPoint: .leading, endPoint: .trailing)
                                )
                            })
                        }
                    }
                }
            }
            
        }.navigationViewStyle(StackNavigationViewStyle())
            .cornerRadius(20)
            .padding()
    }
}

func filterTransactionbyDay(_ trans : [DateTransaction], _ dateSelected : Date) -> [DateTransaction] {
    let transactions = trans.filter({
        ($0.dateTime?.get(getWhat: .day) == dateSelected.get(getWhat: .day) && $0.dateTime?.get(getWhat: .month) == dateSelected.get(getWhat: .month) && $0.dateTime?.get(getWhat: .year) == dateSelected.get(getWhat: .year))
    })
    
    return transactions
}

func getUniqueDateArray( trans : [DateTransaction]) -> [Date] {
    var uniqueTransactionDate : [Date] = []
    let calendar = Calendar(identifier: .gregorian)
    for x in trans {
        
        var DateComponents : DateComponents = DateComponents();
        
        DateComponents.day = x.dateTime?.get(getWhat: .day)
        DateComponents.month = x.dateTime?.get(getWhat: .month)
        DateComponents.year = x.dateTime?.get(getWhat: .year)
        
        let uniqueDate = calendar.date(from: DateComponents);
        
        if !uniqueTransactionDate.contains(uniqueDate!) {
            uniqueTransactionDate.append(uniqueDate!)
        }
    }
    return uniqueTransactionDate;
}

func getTotalDaily(_ dateCheck : Date, _ trans : [DateTransaction]) -> Double {
    
    var totalDaily : Double = 0;
    
    for x in trans {
        if (x.dateTime?.get(getWhat: .year) == dateCheck.get(getWhat: .year) && x.dateTime?.get(getWhat: .month) == dateCheck.get(getWhat: .month) && x.dateTime?.get(getWhat: .day) == dateCheck.get(getWhat: .day)) {
            totalDaily += Double(x.transactionPrice!) ?? 0
        }
    }
    return totalDaily;
}
