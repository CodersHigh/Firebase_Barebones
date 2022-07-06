# Firebase_Barebones
<br/>

### 프로젝트 소개
* Firebase의 기본적인 기능 구현을 익히는 데에 도움을 주는 Bare-bones 프로젝트입니다.
* Firebase를 통해 **SwiftUI 기반의 간단한 온라인 게시판**을 구현합니다.
* Firebase를 처음 활용해 보는 경우, 이 프로젝트의 코드를 살펴보면 도움이 됩니다. 



https://user-images.githubusercontent.com/74223246/177436586-941d633e-6a4c-4e7b-8835-d2618ad7e0de.mp4



<br/>

### Firebase란? 
직접 서버를 구축할 필요 없이 서버의 기본적인 기능과 유저 인증, 활동 분석, 파일 저장소 등을 제공해주는 서비스이며, Google에서 제공합니다.  
Firebase를 사용하려면, 우선 [Firebase와 프로젝트의 연동 과정](https://lyrical-witness-ae6.notion.site/Firebase-56e5ca8e87974151be10651a89b79b9e)에 대해 쉽고 꼼꼼하게 살펴보세요.
<br/>
<br/>
<br/>

### 핵심 코드
Firestore Database에서 데이터를 **불러오고(fetch), 추가하고(upload), 수정하고(update), 삭제합니다(delete)**   
Firebase와 상호작용하는 핵심적인 코드를 참고하세요.

```Swift
// 데이터 불러오기
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
```
```Swift
// 데이터 추가하기 
db.collection("posts").addDocument(data: [
    "text": text,
    "date": Timestamp(date: date)
]) { err in
    if let err = err { print(err) }
}
```
```Swift
// 데이터 수정하기 
db.collection("posts").document(id).getDocument { (document, err) in
    if let err = err {
        print(err.localizedDescription)
    } else {
        document?.reference.updateData([
            "text": text
        ])
    }
}
```
```Swift
// 데이터 삭제하기 
db.collection("posts").document(id).getDocument { (document, err) in
    if let err = err {
        print(err.localizedDescription)
    } else {
        document?.reference.delete()
    }
}
```
