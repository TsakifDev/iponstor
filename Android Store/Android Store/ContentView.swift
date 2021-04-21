//
//  ContentView.swift
//  Android Store
//
//  Created by Darwin D jarot on 21/04/21.
//
import SwiftUI

struct ContentView: View {
    
    private var gridItem = [GridItem(.flexible()),GridItem(.flexible())]
   
    @State var jumlahkeranjang: Int = 0
    //state untuk memanipulasi data satu komponen
    
    var body: some View {
        //product
        NavigationView{
            ScrollView{
                LazyVGrid(columns: gridItem){
                    ForEach(data){ row in
                        VStack{
                            Product(data: row, jumlahproduk: self.$jumlahkeranjang)
                        }
                        .padding()
                        .frame(height: 400)
                    }
                }
            }
            .navigationBarTitle("IBox")
            .navigationBarItems(
                trailing:
                    HStack{
                        Button(action: {print()}){
                            Image(systemName: "heart")
                                .foregroundColor(.black)
                                .frame(width: 20, height: 20)
                        }
                        
                        keranjangView(jumlah: $jumlahkeranjang)
                    }
            )
        }
    }
}

struct keranjangView : View {
    @Binding var jumlah: Int
 
    var body : some View {
        ZStack{
            Button(action: {print("Oke")}){
                Image(systemName: "bag")
                    .resizable()
                    .foregroundColor(.black)
                    .frame(width:20, height:20)
 
            }
 
            Text("\(jumlah)")
                .foregroundColor(Color.white)
                .frame(width:10, height:10)
                .font(.body)
                .padding(5)
                .background(Color.red)
                .clipShape(Circle())
                .offset(x:10,y:-10)
        }
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
 
struct Product: View {
 
    let data: DataModel
 
    @Binding var jumlahproduk: Int
 
    var body: some View {
 
            VStack{
                //Foto
                VStack{
                    ZStack(alignment:.topTrailing){
                        Image(self.data.fotoProduk)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 200)
                            .cornerRadius(15)
                            .clipped()
                        Button(action: {print("OK")}){
                            Image(systemName: "heart")
                                .padding()
                                .foregroundColor(Color.black)
                        }
 
 
                    }
 
                    VStack(alignment:.leading){
                        //Text
                        Text(self.data.namaProduk)
                            .font(.title3)
                            .bold()
                            .padding(.leading)
                            .padding(.trailing)
                        Text("Rp.\(self.data.hargaProduk)")
                            .font(.title3)
                            .foregroundColor(.orange)
                            .bold()
                            .padding(.leading)
                            .padding(.trailing)
 
                        HStack{
                            Image(systemName: "mappin.circle")
                            Text(self.data.lokasi)
                        }
                        .padding(.leading)
                        .padding(.trailing)
 
                        HStack{
                            HStack{
                                //Menghitung Bintang
                                ForEach(0..<self.data.ratingCount){
                                    items in
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.orange)
                                }
                            }
                            .padding(.leading)
                            .padding(.trailing)
 
                        }
                    }
 
                    //buat komponen baru jumlah
                    //ambil data binding dari komponen tambahkeranjang
                    tambahKeranjang(jumlah: $jumlahproduk)
 
 
                }
                .background(Color("AccentColor"))
                .cornerRadius(15)
 
            }
            .padding()
    }
}
 
//button tambah keranjang
struct tambahKeranjang : View {
    //buat binding data
    @Binding var jumlah: Int
 
    var body : some View {
        Button(action: {self.jumlah += 1}){
            HStack{
                Spacer()
                HStack{
                    Image(systemName: "cart")
                    Text("Keranjang")
                        .font(.callout)
                        .padding()
                }
                Spacer()
 
            }
        }
        .background(Color.black)
        .foregroundColor(Color.white)
        .cornerRadius(10)
        .padding(10)
    }
}
