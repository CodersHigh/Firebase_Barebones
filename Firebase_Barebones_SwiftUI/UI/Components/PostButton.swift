//
//  PostButton.swift
//  Firebase_Barebones_SwiftUI
//
//  Created by 이로운 on 2022/06/08.
//

import SwiftUI

struct PostButton: View {
    @ObservedObject var viewModel = PostViewModel()
    @ObservedObject var selected: Post
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
    @State var postType: String
    
    var body: some View {
        Button(action: {
            if self.viewModel.checkBadWords(content: selected.text) {
                self.showingAlert = true
            } else {
                switch postType {
                case "upload" :
                    self.viewModel.uploadData(text: selected.text, date: Date())
                case "update" :
                    self.viewModel.updateData(id: selected.id, text: selected.text)
                default:
                    break
                }
                presentationMode.wrappedValue.dismiss()
            }
        }) {
            Text("완료")
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("업로드 불가"), message: Text("사용이 제한된 단어가 포함되어 있어요."), dismissButton: .cancel(Text("확인")))
        }
    }
}

struct PostButton_Previews: PreviewProvider {
    static var previews: some View {
        PostButton(selected: Post(id: "", text: "", date: ""), postType: "")
    }
}
