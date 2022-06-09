//
//  DetailPostView.swift
//  Firebase_Barebones_SwiftUI
//
//  Created by 이로운 on 2022/06/03.
//

import SwiftUI

struct DetailPostView: View {
    @ObservedObject var selected: Post

    var body: some View {
        VStack {
            List{
                Text(selected.text)
                Text(selected.date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            DetailPostControlView(selected: selected)
            .navigationBarTitle("게시글 보기", displayMode: .inline)
        }
    }
}

struct DetailPostControlView: View {
    @ObservedObject var viewModel = PostViewModel()
    @ObservedObject var selected: Post
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
    
    var body: some View {
        HStack {
            Button(action: {
                self.showingAlert = true
            }) {
                Text("삭제")
                    .foregroundColor(.red)
            }
            .padding()
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("삭제"), message: Text("게시글을 삭제할까요?"), primaryButton: .destructive(Text("삭제"), action: {
                    self.viewModel.deleteData(id: selected.id)
                    presentationMode.wrappedValue.dismiss()
                }), secondaryButton: .cancel(Text("취소")))
            }
            Spacer()
            NavigationLink(destination: UpdatePostView(selected: selected), label: {
                Text("수정")
                    .foregroundColor(.black)
            })
            .padding()
        }
    }
}

struct DetailPostView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPostView(selected: Post(id: "a", text: "안녕", date: "하이"))
    }
}
