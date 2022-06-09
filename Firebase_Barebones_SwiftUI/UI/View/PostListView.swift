//
//  ContentView.swift
//  Firebase_Barebones_SwiftUI
//
//  Created by 이로운 on 2022/06/03.
//

import SwiftUI

struct PostListView: View {
    @ObservedObject var viewModel = PostViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List(viewModel.posts){ post in
                NavigationLink(post.text) {
                    DetailPostView(selected: post)
                }
            }
            .navigationBarTitle("게시판", displayMode: .inline).toolbar {
                NavigationLink(destination: UploadPostView(), label: {
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                })
            }
            .onAppear() {
                self.viewModel.fetchData()
            }
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView()
    }
}
