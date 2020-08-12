//
//  ContentView.swift
//  GroupProject
//
//  Created by Oreoluwa Omomofe on 8/6/20.
//  Copyright © 2020 One Summer Chicago. All rights reserved.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI

struct ContentView: View {
    var body: some View {
       
        NavigationView{
            
            Home()
            .navigationBarTitle("Books")
        }
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    
    @ObservedObject var Books = getData()
    
    var body: some View{
        
        List(Books.data){i in
            
            HStack{
                
                if i.imurl != ""{
                    
                    WebImage(url: URL(string: i.imurl)!).resizable().frame(width: 120, height:170).cornerRadius(10)
                }
                else{
                    Image("books").resizable().frame(width: 120, height: 170).cornerRadius(10)
                }
                
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(i.title).fontWeight(.bold)
                    
                    Text(i.authors)
                    
                    Text(i.desc).font(.caption).lineLimit(4).multilineTextAlignment(.leading)
                    
                    
                }
            }
            
        }
    }
}

class getData : ObservableObject{
    
    @Published var data = [Book]()
    
    init()  {
        
        // any search query....
        //spaces must be replaced by +...
        let url = "https://www.googleapis.com/books/v1/volumes?q=java"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
        
            let json = try! JSON(data: data!)
            
            let items = json["items"].array!
            
            for i in items{
                
                let id = i["id"].stringValue
                
                let title = i["volumeInfo"]["title"].stringValue
                    
                let authors = i["volumeInfo"]["authors"].array!
                    
                var author = ""
                
                for j in authors{
                    
                    author += "\(j.stringValue)"
                }
                
                let description = i["volumeInfo"]["description"].stringValue
                
                let imurl = i["imageLinks"]["thumbnail"].stringValue
                
                let url1 = i["webReaderLink"].stringValue
                
                
                    
                DispatchQueue.main.async {
                    
                    self.data.append(Book(id: id, title: title, authors: author, desc: description,  imurl: imurl, url: url1))
                }
            }
        }.resume()
    }
}
 
struct Book : Identifiable {

    var id : String
    var title : String
    var authors : String
    var desc : String
    var imurl : String
    var url : String

}

