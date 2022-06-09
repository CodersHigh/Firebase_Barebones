//
//  UpdatePostView.swift
//  Firebase_Barebones_SwiftUI
//
//  Created by 이로운 on 2022/06/03.
//

import SwiftUI

struct UpdatePostView: View {
    @ObservedObject var selected: Post
    
    var body: some View {
        
        TextField("하고 싶은 말이 있나요?", text: $selected.text)
            .navigationBarTitle("글 수정", displayMode: .inline).toolbar {
                PostButton(selected: selected, postType: "update")
            }
            .padding()
    }
}

struct UpdatePostView_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePostView(selected: Post(id: "a", text: "안녕", date: "하이"))
    }
}
