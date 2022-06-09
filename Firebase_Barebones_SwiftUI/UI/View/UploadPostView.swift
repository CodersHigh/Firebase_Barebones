//
//  UploadPostView.swift
//  Firebase_Barebones_SwiftUI
//
//  Created by 이로운 on 2022/06/03.
//

import SwiftUI

struct UploadPostView: View {
    @State var postText: String = ""
    
    var body: some View {
        TextField("하고 싶은 말이 있나요?", text: $postText)
            .navigationBarTitle("새 글", displayMode: .inline).toolbar {
                PostButton(selected: Post(id: "", text: postText, date: ""), postType: "upload")
            }
            .padding()
    }
}

struct UploadPostView_Previews: PreviewProvider {
    static var previews: some View {
        UploadPostView()
    }
}
