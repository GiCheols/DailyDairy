# Diary Daily
### 하루 한 장 일기 작성 어플리케이션
2171278 남기철

## 1. 프로젝트 수행 목적
### 1-1. 프로젝트 정의
- 하루에 한 장씩 일기를 작성할 수 있는 어플리케이션

### 1-2. 프로젝트 배경
- 2024학년도 1학기 iOS 프로그래밍 과목에서 배운 내용들을 토대로 Swift를 사용하여 iOS 앱을 개발했습니다.

### 1-3. 프로젝트 목표
- 일기 등록, 조회, 수정, 삭제
  - 일기 등록 화면을 통해 새 일기 등록할 수 있습니다.
  - 홈 화면에서는 날짜를 선택할 수 있고 선택한 날짜에 대한 일기를 조회해 보여줍니다.
  - 일기가 조회되었다면 조회한 일기를 '수정하기'버튼을 눌러 수정 및 삭제가 가능합니다.
- 날짜 선택
  - FSCalendar 모듈을 사용해 날짜를 선택할 수 있습니다.
  - 선택한 날짜에 작성한 일기가 있다면 일기의 내용을 보여줍니다.

## 2. 프로젝트 개요
### 2-1. 프로젝트 설명
- 사용자는 홈 화면에서 달력을 볼 수 있고, 달력 화면에서는 일기를 쓴 날짜와 쓰지 않은 날짜를 확인할 수 있습니다.
- 날짜를 선택하면 선택한 날짜에 작성한 일기를 달력 아래에서 확인할 수 있습니다.
  - 이 때, '수정하기' 버튼을 눌러 일기 수정화면으로 이동할 수 있습니다.
- 탭 바에서 새 일기를 등록할 수 있습니다.
  - 새 일기 등록화면에서는 DatePicker를 사용해 등록할 날짜를 선택할 수 있습니다.
  - UIImageView를 클릭하면 앨범에서 사진을 가져올 수 있습니다.
  - 제목과 내용을 입력하고 저장하면 새 일기가 등록됩니다.
    - 제목과 내용을 입력하지 않았다면 일기가 등록되지 않습니다.
  - 사진은 등록하지 않아도 새 일기를 등록할 수 있습니다.
- 일기 수정이 가능합니다.
  - Navigation Controller를 사용해 수정 화면으로 넘어갑니다.
  - 작성했던 일기의 내용을 불러옵니다. 뒤로 가기를 원한다면 뒤로가기 버튼을 눌러 뒤로갈 수 있습니다.
  - '삭제'버튼을 누를 경우 삭제 확인 알림창이 나타나며 확인을 누르면 일기가 삭제됩니다.
 
### 2-2. 프로젝트 구조
- Swift만을 사용해 개발되었습니다.

### 2-3. 결과물
#### 메인화면
  ![Simulator Screen Shot - iPhone 13 Pro Max - 2024-06-09 at 03 05 51](https://github.com/GiCheols/DiaryDaily/assets/94215392/e0a110e2-6453-4a7d-9e58-ff03c79a4f29)
  ![Simulator Screen Shot - iPhone 13 Pro Max - 2024-06-09 at 03 08 39](https://github.com/GiCheols/DiaryDaily/assets/94215392/fac87218-b6fa-42f0-93d8-e413b47b4323)
  ![Simulator Screen Shot - iPhone 13 Pro Max - 2024-06-09 at 03 08 39](https://github.com/GiCheols/DiaryDaily/assets/94215392/792ad529-bf5a-429d-8a4a-1bd5a590c3d7)
  ![Simulator Screen Shot - iPhone 13 Pro Max - 2024-06-09 at 03 21 07](https://github.com/GiCheols/DiaryDaily/assets/94215392/f6474586-7d1d-413a-afb9-664102875998)

#### 새 일기 등록화면
  ![Simulator Screen Shot - iPhone 13 Pro Max - 2024-06-09 at 03 09 50](https://github.com/GiCheols/DiaryDaily/assets/94215392/8b702c2f-ef65-416e-8c62-3a9772289b18)
  ![Simulator Screen Shot - iPhone 13 Pro Max - 2024-06-09 at 03 09 50](https://github.com/GiCheols/DiaryDaily/assets/94215392/3c71bd7e-6f24-4e79-9925-fe6f031c8d00)
  ![Simulator Screen Shot - iPhone 13 Pro Max - 2024-06-09 at 03 10 46](https://github.com/GiCheols/DiaryDaily/assets/94215392/6016a371-b641-4e50-b75d-e7427245aea6)
  ![Simulator Screen Shot - iPhone 13 Pro Max - 2024-06-09 at 03 11 51](https://github.com/GiCheols/DiaryDaily/assets/94215392/3900e0d0-cee0-4366-af99-49dfe8b3b021)
  ![Simulator Screen Shot - iPhone 13 Pro Max - 2024-06-09 at 03 13 05](https://github.com/GiCheols/DiaryDaily/assets/94215392/c0cc318e-95e0-46b2-8b1e-0baf0ae49cfe)
#### 수정 화면
  ![Simulator Screen Shot - iPhone 13 Pro Max - 2024-06-09 at 03 13 42](https://github.com/GiCheols/DiaryDaily/assets/94215392/bb209b51-f44a-429e-8f42-46dd75683b9b)
  ![Simulator Screen Shot - iPhone 13 Pro Max - 2024-06-09 at 03 14 25](https://github.com/GiCheols/DiaryDaily/assets/94215392/60275a69-979f-4add-9cb9-a5a9519e6566)
  ![Simulator Screen Shot - iPhone 13 Pro Max - 2024-06-09 at 03 14 38](https://github.com/GiCheols/DiaryDaily/assets/94215392/c39ee184-119f-4f9f-8fbf-ce6fbc03fc8a)
  ![Simulator Screen Shot - iPhone 13 Pro Max - 2024-06-09 at 03 15 23](https://github.com/GiCheols/DiaryDaily/assets/94215392/5ca7e5f0-fe57-4c33-ac2a-9a1cea274edf)
  ![Simulator Screen Shot - iPhone 13 Pro Max - 2024-06-09 at 03 15 37](https://github.com/GiCheols/DiaryDaily/assets/94215392/45409a6e-9e3f-40fe-8465-881a96697171)
  ![Simulator Screen Shot - iPhone 13 Pro Max - 2024-06-09 at 03 15 44](https://github.com/GiCheols/DiaryDaily/assets/94215392/a420647f-9d5f-403b-ba7e-ae9002464a5d)
#### 앱 로고
  - <img width="78" alt="스크린샷 2024-06-09 오전 3 17 43" src="https://github.com/GiCheols/DiaryDaily/assets/94215392/9686ff1d-6603-43fc-a3b0-03fcd679029d">

### 2-4. 기대효과
- 하루 한 장 일기를 작성할 수 있습니다.
- 사진도 저장할 수 있습니다.
- CoreData를 사용해 작성했기 때문에 데이터 사용 없이 일기를 저장할 수 있습니다.

### 2.5 발표 영상
- 유튜브 링크
