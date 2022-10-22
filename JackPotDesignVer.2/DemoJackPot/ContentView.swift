//
//  ContentView.swift
//  DemoJackPot
//
//  Created by 진준호 on 2022/10/21.
//
/*
다음 버전에 추가해볼것
 1. 화면구성 요소들을 더 예쁘게 해볼 것
 2. 결과창 꾸미기
 3. 애니메이션 Struct들을 간소화 시키는 방법 찾아보기
*/
import SwiftUI

// ContentView Struct ----------------------------------------------------------------------------------
struct ContentView: View {
    // 결과창을 사용자의 편의에 따라 끄고 켤 수 있도록 토글을 이용하기 위해 변수 선언
    @State private var modalToggle = true
    
    // 버튼을 누른 후 애니메이션이 끝나고 결과창이 출력될 수 있도록 하기위해 변수 선언
    @State private var showModal = false
    
    // 인덱스를 각각 준 이유 : 딜레이로만 숫자가 순서대로 나오게 하려니깐 두번째 칸까지는 괜찮은데 세번째 칸이 너무 느리게 돌아서 각각 인덱스를 할당하고 두번째 칸은 한바퀴, 세번째 칸은 두바퀴 더 돌게함
    // 첫번째 칸 인덱스 번호
    @State var IndexNum1 : Int = 0
    // 두번째 칸 인덱스 번호
    @State var IndexNum2 : Int = 0
    // 세번째 칸 인덱스 번호
    @State var IndexNum3 : Int = 0
    
    // 범위 내의 난수를 발생시켜서 할당해주기 위해 randonNum을 선언
    @State private var randomNum: Int = 0
    
    // selectedNumber는 피커에서 선택지 갯수 설정 배열
    @State private var selectedNumber : [String] = ["2명" , "3명" , "4명" , "5명" , "6명" , "7명" , "8명", "9명"]
    
    // selectIndex는 selectedNumber의 배열 인덱스 값
    @State private var selectIndex = 0
    
    // 애니메이션 동작 중 버튼이 눌러지면 앱이 꺼지는 문제가 발생, 그래서 애니메이션이 동작중일 동안 버튼을 비활성화 상태로 만들기 위해서 buttonTrigger 선언 및 내용을 채워서 초기화, 자세한 구동 방법은 아래 버튼부분 확인할 것
    @State private var buttonTrigger = "버튼동작중"
    
    //teamNamesArray는 미리 설정 된 이름 배열, 이전 버전의 잔재입니다. 종현님의 요청으로 남겨둡니다~!
    // @State private var teamNamesArray : [String] = ["종현" ," 정훈" ," 준호" , "은노", "민경" , "예슬" , "근섭", "진아"]
    
    //displayArray는 선택된 갯수 만큼 뽑아진 배열 ( 화면 상에서 보여질 배열 ), 이전 버전의 잔재입니다. 종현님의 요청으로 남겨둡니다~!
    // @State private var displayArray : [String] = []
    // @State private var randomNumber: Int = Int.random(in: 1...360)
    // @State private var appear = true
    
    // 메인으로 출력되는 View ------------------------------------------------------------------------------
    var body: some View {
        VStack {
            // 결과창을 사용자의 편의에 따라 끄고 켤 수 있도록 토글을 이용하기 위해 토글 사용, 14 Pro를 기준으로 UI를 구성해서 frame도 적용함
            Toggle("결과창 보기", isOn: $modalToggle)
                .frame(width: 300)
            Spacer()
            HStack {
                // Picker의 용도 설명을 위한 Text
                Text("게임 참여 인원을 선택해주세요")
                    .padding()
                    // Picker를 이용해서 선택지 갯수 설정 -----------------------------------------------------
                    Picker("게임 참여 인원을 선택해주세요", selection: $selectIndex){
                        ForEach(0..<selectedNumber.count, id: \.self){
                            Text(self.selectedNumber[$0])
                        }
                    }
                    // 애니메이션이 동작중일 때 피커를 누르면 원하는 결과가 나오지 않기 때문에 동작 중 Picker를 비활성화 시키기 위해 disabled 사용
                    .disabled(buttonTrigger.isEmpty)
                    .frame(width: 70, height: 50)
                    .pickerStyle(.menu)
            }
            .background(.yellow)
            .cornerRadius(15)
            .padding()
            
            Spacer()
            ZStack {
                Image("slot")
                    .resizable()
                    .frame(maxWidth: 300)
                HStack {
                    // 아래 코드를 보면 modifier부분이 다 똑같은데 뒤에 IndexNum을 다른 값을 불러온 이유는 위 선언부의 설명과 동일하게 첫번째, 두번째, 세번째 칸에 애니메이션이 끝나는 시간을 다르게 해주기 위해 각각 다른 값을 불러옴
                    // 첫번째 칸의 배경 이미지
                    RoundedRectangle(cornerRadius: 8).fill(.white)
                        .frame(maxWidth: 75, maxHeight: 120)
                    // CountingNumberAnimationModifier를 불러오는데 해당 modifier안에 있는 number에 contentView의 IndexNum1의 값을 할당해준다 (아래도 마찬가지로 각각 IndexNum2, 3을 할당해주는 방식
                        .modifier(CountingNumberAnimationModifier(number: CGFloat(IndexNum1)))
                        .offset(x: 0, y: -60)
                    
                    // 두번째 칸의 배경 이미지
                    RoundedRectangle(cornerRadius: 8).fill(.white)
                        .frame(maxWidth: 75, maxHeight: 120)
                        .modifier(CountingNumberAnimationModifier2(number: CGFloat(IndexNum2)))
                        .offset(x: 0, y: -60)
                    
                    // 두번째 칸의 배경 이미지
                    RoundedRectangle(cornerRadius: 8).fill(.white)
                        .frame(maxWidth: 75, maxHeight: 120)
                        .modifier(CountingNumberAnimationModifier3(number: CGFloat(IndexNum3)))
                        .offset(x: 0, y: -60)
                }
                .padding()
            }
            .frame(width: 400, height: 400)

            Spacer()
            // 시작버튼 ---------------------------------------------------------------------------------
            Button(action: {
                // buttonTrigger가 비워져있으면 버튼을 비활성화 시키도록 하기위해 우선 버튼을 누르면 즉각적으로 buttonTrigger를 비운다.
                buttonTrigger = ""
                
                // loopArray(funcSelectIndex: selectIndex) 해당 주석은 이전 버전의 잔재입니다. 종현님의 요청으로 남겨둡니다~!
                
                // 난수를 발생시키고 randomNum에 할당, 선언부가 아닌 해당 버튼에 넣은 이유는 버튼을 누를 때 마다 다른 랜덤 값을 불러와야지 매번 다른 결과가 나오기 때문에 버튼 액션부에 넣음
                // selectIndex에 2를 더한 이유는 Picker를 통해 selectedNumber라는 배열에서 숫자를 고르게 되는데 여기서 인덱스 값과 배열의 값에 2만큼의 차이가 발생하기 때문에 제대로 된 범위 안에서 난수를 발생시키려면 2를 더해야한다.
                self.randomNum = Int.random(in: 1...selectIndex+2)

                // 각 IndexNum을 0으로 초기화 시켜준 이유는 초기화하지 않으면 전에 할당된 값부터 애니메이션이 시작되기 때문
                // 주석처리를 하고 한번 실행시켜보면 확실하게 이해할 수 있음
                self.IndexNum1 = 0
                self.IndexNum2 = 0
                self.IndexNum3 = 0
                
                // Button을 눌렀을 때 Animation을 작동시키기 위해서 사용한 코드
                // duration은 애니메이션을 완료하는 시간을 나타내줌, 그래서 만약 아래 3개의 인덱스 값이 다 다르더라도 duration 값이 같으면 애니메이션은 동시에 끝남
                // IndexNum 값에 각각 26, 35, 44라는 숫자가 있는데 해당 숫자는 애니메이션을 좀 더 화려하게 연출하기 위해 더미값을 넣은 것임, 아래 modifierView로 가보면 repeatArray라는 배열이 있는데 해당 내용에 더미로 1~9까지를 각각 3번, 4번, 5번 반복해두었고, 인덱스 값이기 때문에 0부터 시작해서 1을 빼주어야한다.
                // 그래서 첫번째는 9 * 3 - 1 = 26, 두번째는 9 * 4 - 1 = 35, 세번째는 9 * 5 - 1 = 44로 값을 넣음
                // 더미 배열이 각각 3, 4, 5번씩 출력되고 나면 난수만큼 더 가서 멈추기 때문에 우리가 원하는 결과값이 화면에 표시됨
                withAnimation(Animation.linear(duration: 1)){
                    self.IndexNum1 = 26 + self.randomNum
                }
                withAnimation(Animation.linear(duration: 1.5)){
                    self.IndexNum2 = 35 + self.randomNum
                }
                withAnimation(Animation.linear(duration: 2)){
                    self.IndexNum3 = 44 + self.randomNum
                }
                
                // buttonTrigger를 다시 채워줘서 버튼이 동작하도록 해야하는데 그냥 채워주게되면 애니메이션이 끝나기전에 버튼이 다시 눌러져서 똑같은 문제가 발생한다. 여기서 애니메이션 중 가장 늦게 끝나는 세번째 칸의 duration이 2이기 때문에 DispatchQueue를 사용해서 2초간 딜레이를 주고 buttonTrigger를 다시 채워줘서 버튼이 눌러지도록 만들었음
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    buttonTrigger = "버튼동작중"
                }
                
                // 사용자의 편의를 위해 결과창 보기 토글을 On 했을 때만 결과창을 송출하도록 설정
                // 애니메이션이 끝나고 살짝 delay 후 결과창을 보여주는 것이 더 좋을 것 같다고 판단하여 버튼을 누르고 2.3초 후 동작하도록 설정
                if modalToggle == true {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
                        // showModal을 true로 만들어 줌으로써 결과창이 화면에 출력되도록 하기 위해 사용
                        self.showModal = true
                    }
                }
                // 버튼의 외형을 넣어줌
            }, label: {
                Image("coin")
            })
            // disabled를 사용해서 buttonTrigger가 비워져 있을 때에는 버튼을 비활성화 시킴
            .disabled(buttonTrigger.isEmpty)
            .padding()
            // 버튼을 눌렀을 때 결과창이 화면에 출력되도록 하기위해 사용
            .sheet(isPresented: self.$showModal, content: {
                ResultView(randomNum: $randomNum)
            })
            /*
             여기 주석은 이전 버전의 잔재입니다. 종현님의 요청으로 남겨둡니다~!
            // 버튼 클릭시 displayArray 생성됨!
            Button(action: {
                loopArray(funcSelectIndex: selectIndex)
            }){
                Text("버튼")
            }
             */
        }
    }
    /*
     여기 주석은 이전 버전의 잔재입니다. 종현님의 요청으로 남겨둡니다~!
    //displayArray배열을 뽑기 위해 만든 함수
    func loopArray(funcSelectIndex: Int){
        //피커를 한번 더 누르면 중복이 되기 때문에 함수 호출시 displayArray배열 클리어! 오류 방지 처리
        displayArray.removeAll()
        // 선택된 갯수 만큼 이름을 추가하는 for in문
        for i in 0...selectIndex {
            displayArray.append(teamNamesArray[i])
        }
     }
     */
}

// 애니메이션 뷰 1 ----------------------------------------------------------------------------------------
struct CountingNumberAnimationModifier: AnimatableModifier {
    
    // number선언 (Index로 사용)
    var number : CGFloat = 0
    
    // animatableData로 AnimatableModifier를 사용하려면 꼭 필요한 변수
    var animatableData: CGFloat {
        get { number }
        set { number = newValue }
    }
    
    // 해당 애니메이션을 메인 화면에 오버레이 시킴
    func body(content: Content) -> some View {
        content.overlay(NumberLabelView(number: number))
    }
    
    
    // 숫자 라벨 뷰
    struct NumberLabelView : View {
        var repeatArray : [String] = ["1" , "2" , "3" , "4" , "5" , "6" , "7" , "8", "9",
                                      "1" , "2" , "3" , "4" , "5" , "6" , "7" , "8", "9",
                                      "1" , "2" , "3" , "4" , "5" , "6" , "7" , "8", "9",
                                      "1" , "2" , "3" , "4" , "5" , "6" , "7" , "8", "9"]
        
        let number: CGFloat
        
        // 직접적으로 보이는 숫자 (슬롯부분)
        var body: some View {
            Text("\(repeatArray[Int(number)])")
                .foregroundColor(.red)
                .font(.largeTitle)
                .fontWeight(.black)
        }
    }
}

// 애니메이션 뷰 2 ----------------------------------------------------------------------------------------
struct CountingNumberAnimationModifier2: AnimatableModifier {
    
    // number선언 (Index로 사용)
    var number : CGFloat = 0
    
    // animatableData로 AnimatableModifier를 사용하려면 꼭 필요한 변수
    var animatableData: CGFloat {
        get { number }
        set { number = newValue }
    }
    
    // 해당 애니메이션을 메인 화면에 오버레이 시킴
    func body(content: Content) -> some View {
        content.overlay(NumberLabelView(number: number))
    }
    
    
    // 숫자 라벨 뷰
    struct NumberLabelView : View {
        var repeatArray : [String] = ["1" , "2" , "3" , "4" , "5" , "6" , "7" , "8", "9",
                                      "1" , "2" , "3" , "4" , "5" , "6" , "7" , "8", "9",
                                      "1" , "2" , "3" , "4" , "5" , "6" , "7" , "8", "9",
                                      "1" , "2" , "3" , "4" , "5" , "6" , "7" , "8", "9",
                                      "1" , "2" , "3" , "4" , "5" , "6" , "7" , "8", "9"]
        
        let number: CGFloat
        
        // 직접적으로 보이는 숫자 (슬롯부분)
        var body: some View {
            Text("\(repeatArray[Int(number)])")
                .foregroundColor(.red)
                .font(.largeTitle)
                .fontWeight(.black)
        }
    }
}

// 애니메이션 뷰 3 ----------------------------------------------------------------------------------------
struct CountingNumberAnimationModifier3: AnimatableModifier {
    
    // number선언 (Index로 사용)
    var number : CGFloat = 0
    
    // animatableData로 AnimatableModifier를 사용하려면 꼭 필요한 변수
    var animatableData: CGFloat {
        get { number }
        set { number = newValue }
    }
    
    // 해당 애니메이션을 메인 화면에 오버레이 시킴
    func body(content: Content) -> some View {
        content.overlay(NumberLabelView(number: number))
    }
    
    
    // 숫자 라벨 뷰
    struct NumberLabelView : View {
        var repeatArray : [String] = ["1" , "2" , "3" , "4" , "5" , "6" , "7" , "8", "9",
                                      "1" , "2" , "3" , "4" , "5" , "6" , "7" , "8", "9",
                                      "1" , "2" , "3" , "4" , "5" , "6" , "7" , "8", "9",
                                      "1" , "2" , "3" , "4" , "5" , "6" , "7" , "8", "9",
                                      "1" , "2" , "3" , "4" , "5" , "6" , "7" , "8", "9",
                                      "1" , "2" , "3" , "4" , "5" , "6" , "7" , "8", "9"]
        
        let number: CGFloat
        
        // 직접적으로 보이는 숫자 (슬롯부분)
        var body: some View {
            Text("\(repeatArray[Int(number)])")
                .foregroundColor(.red)
                .font(.largeTitle)
                .fontWeight(.black)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
