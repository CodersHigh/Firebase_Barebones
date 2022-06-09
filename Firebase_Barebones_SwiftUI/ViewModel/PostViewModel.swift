//
//  PostViewModel.swift
//  Firebase_Barebones_SwiftUI
//
//  Created by 이로운 on 2022/06/03.
//

import Foundation
import FirebaseFirestore

class PostViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("posts").order(by: "date", descending: true).getDocuments { (querySnapsht, err) in
            if let err = err {
                print(err)
            } else {
                guard let documents = querySnapsht?.documents else {
                    print("No Document")
                    return
                }
                self.posts = documents.map { queryDocumentSnapshot -> Post in
                    let id = queryDocumentSnapshot.documentID
                    let text = queryDocumentSnapshot.data()["text"] as! String
                    let timestamp = queryDocumentSnapshot.data()["date"] as! Timestamp
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "YYYY년 MM월 dd일, HH시 mm분"
                    let date = dateFormatter.string(from: timestamp.dateValue())
                    return Post(id: id, text: text, date: date)
                }
            }
        }
    }
    
    func uploadData(text: String, date: Date) {
        db.collection("posts").addDocument(data: [
            "text": text,
            "date": Timestamp(date: date)
        ]) { err in
            if let err = err { print(err) }
        }
    }
    
    func updateData(id: String, text: String) {
        db.collection("posts").document(id).getDocument { (document, err) in
            if let err = err {
                print(err.localizedDescription)
            } else {
                document?.reference.updateData([
                    "text": text
                ])
            }
        }
    }
    
    func deleteData(id: String) {
        db.collection("posts").document(id).getDocument { (document, err) in
            if let err = err {
                print(err.localizedDescription)
            } else {
                document?.reference.delete()
            }
        }
    }
    
    // MARK: - BadWords View Model
    
    func checkBadWords(content: String) -> Bool {
        var badWords = [String]()
        
        if let path = Bundle.main.path(forResource: "badwords", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                do {
                    badWords = try JSONDecoder().decode(Badwords.self, from: data).badwords
                } catch {
                    print("decode error")
                }
            } catch {
                print("path error")
            }
        } else {
            print("path nil")
        }
        
        for badword in badWords {
            if content.contains(badword) { return true }
        }
        return false
    }

}
