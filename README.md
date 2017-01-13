# Pitch-Perfect
 
 
 
 
 
## 목차
* Application 설명 
* Application 기능
* Kick 추가 기능
 
 
 
 
### Application 설명
 
 * 녹음 및 저장 (wav 파일)
 * 재생 (6가지 기능에 맞춰 재생가능)
iOS 어플리케이션으로 녹음을 한 후 6가지 기능에 맞춰 사운드파일을 재생하여 들어볼 수 있습니다. 
관련 자료는 [유다시티](https://classroom.udacity.com/courses/ud585/lessons/6994652511/concepts/74230270480923#)에서 볼 수 있습니다.
 
 
 
 
 
### Application 기능
 
* ViewController를 이용한 씬 전환
* AVFoundation을 이용한 사운드 녹음, 재생
* Constrict 화면 구성
* UIButton 활성화/비활성화
* rate, pitch, echo, reverb 를 이용한 사운드 변조
* delegate를 이용한 이벤트 처리
 
 
 
 
 
 
### Kick 추가 기능
 
 

#### Recoed View
![스크린샷 1](https://github.com/enghks1414/PitchPerfect_DoohwanLee/blob/master/Scene_1.png)
* 상단 부분 StackView를 사용하여 3개자 View 추가.(Navigation Bar Hide)
* 이름 변경 -  UIAlertController로 파일 이름을 다양하게 저장하여 여러개의 wav 녹음 파일을 생성
* 음질 선택 - segmented 를 이용하여 간단히 녹음 설정 변경
* 녹음 시간 표시 - 타이머 기능으로 녹음이 진행되고 있는 시간을 표시
* 녹음 중 버튼 애니메이션 - 녹음 시작되면 시작적인 부분을 나타내기 위해 animate 반복.
 
 

#### Play View
![스크린샷 2](https://github.com/enghks1414/PitchPerfect_DoohwanLee/blob/master/Scene_2.png)
* Slider를 이용한 녹음 파일의 진행 상태
* 일반 재생 / 일시정지 - 재생 상태에 맞춰 UIButton 이미지 변경
* 파일의 전체 재생시간, 현재 재생 시간 표시
* 재생 파일 변경을 위한 Scene변경
 
 
 #### FileList View
![스크린샷 3](https://github.com/enghks1414/PitchPerfect_DoohwanLee/blob/master/Scene_3.png)
* Documents 디렉토리에서 .wav파일 목록을 TableView에 표시