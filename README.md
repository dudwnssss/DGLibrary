# DGLibrary

## Overview
DGLibrary는 IT Book Store API를 활용한 도서 검색 및 상세 정보 확인 애플리케이션입니다. Clean Architecture를 적용하여 확장성과 유지보수성 테스트 용이성을 고려하여 설계했습니다.
과제 요구사항을 우선으로 구현하였고 명세되지 않은 세부 사항들은 당근에서 사용 중인 정책을 참고 및 합리적이라고 생각하는 방식으로 구현했습니다.

## Features

### Core Features
-  도서 검색 및 결과 표시
-  도서 상세 정보 조회
-  PDF 미리보기 (pdf형식이 아닐 경우, 외부 브라우저 연동)
-  무한 스크롤 페이지네이션
-  2-Tier 이미지 캐싱 

### Performance Optimization
- **Memory Cache**: 전체 메모리의 5% 제한
- **Disk Cache**: 100MB 최대 용량, 7일 유효기간
- **Network**: 30초 타임아웃 설정
- **Memory Warning**: 자동 캐시 삭제
- **LRU Algorithm**: 디스크 캐시 자동 정리

---

## Clean Architecture (VIP Pattern)

### Layer Responsibilities

**View**
- UI 렌더링 및 사용자 입력 처리
- 사용자 액션을 Interactor에 전달

**Presenter**
- 데이터 포맷팅 및 변환
- View 업데이트 로직 처리

**Interactor**
- 비즈니스 로직 실행
- 데이터 플로우 제어

**Router**
- 화면 전환 로직
- 내비게이션 처리

**Repository**
- 네트워크 통신
- 데이터 소스 추상화

### Data Flow

```swift
// Request → Response → ViewModel 패턴
View → Interactor: Request
Interactor → Presenter: Response  
Presenter → View: ViewModel
```

---

## Tech Stack

### Core
- **Language**: Swift 5.9+
- **Framework**: UIKit
- **Architecture**: Clean Architecture (VIP/Clean Swift)
- **Minimum iOS**: 16.0

### Network & Data
- **Networking**: URLSession (Protocol-based abstraction)
- **Serialization**: Codable
- **Image Loading**: Custom ImageDownloader with 2-Tier Caching

### Testing
- **Framework**: XCTest
- **Coverage**: 58%
- **Strategy**: Protocol-based Mock Objects

### Development Tools
- **Xcode**: 16.4
- **Version Control**: Git
- **Dependency Manager**: None (Zero-dependency architecture)

---

## Project Structure

```
DGLibrary/
├── App/
│   ├── Delegates/              # AppDelegate, SceneDelegate
│   └── Info.plist
│
├── Common/
│   ├── Const/                  # 상수 정의 (Secrets)
│   ├── Extensions/             # String+MD5, UIImageView+Extension
│   ├── Resources/              # Assets, Storyboard
│   └── Utils/
│       ├── CacheManager/       # 2-tier 이미지 캐싱
│       ├── ImageDownloader/    # 이미지 다운로드 로직
│       └── NetworkService/     # 네트워크 추상화 레이어
│
├── Domain/
│   ├── Entity/                 # 비즈니스 모델 (BookSearch, BookDetail)
│   └── RepositoryInterface/    # Repository Protocol
│
├── Data/
│   ├── API/                    # API Endpoint 정의
│   ├── DTO/                    # Data Transfer Objects
│   └── Repository/
│       ├── Sources/            # Repository 구현체
│       └── Tests/              # Repository 테스트
│
└── Presentation/
    ├── Search/
    │   ├── Sources/
    │   │   ├── Interactor/     # 비즈니스 로직
    │   │   ├── Presenter/      # 프레젠테이션 로직
    │   │   ├── Router/         # 내비게이션
    │   │   └── VIew/           # UI 컴포넌트
    │   └── Tests/              # Unit Tests
    │
    └── Detail/
        ├── Sources/            # (동일 구조)
        └── Tests/
```

---

## Implementation Details

### Network Layer

**Protocol-based Architecture**
```swift
protocol NetworkService {
    func request<T: Decodable>(_ endpoint: URLRequestConvertible) async throws -> T
}
```

**Features**
- Protocol 기반 추상화로 테스트 용이성 확보
- async/await를 활용한 현대적인 비동기 처리

**Error Types**
```swift
enum NetworkError: Error {
    case noInternetConnection
    case timeout
    case serverDown
    case serverError(statusCode: Int)
    case decodingError
}
```

### Image Caching System

**Memory Cache**
- 전체 시스템 메모리의 5% 제한
- NSCache를 활용한 자동 메모리 관리
- 메모리 경고 시 전체 캐시 삭제
- 비트맵 크기 계산으로 cost 추적

**Disk Cache**
- 최대 용량: 100MB
- 정리 후 목표 용량: 80MB
- 만료 기간: 7일
- MD5 해시 기반 파일명
- LRU 알고리즘 자동 정리

### Pagination

```swift
func next(request: BookSearchModel.Next.Request) {
    guard hasNextPage, !isLoadingMore else { return }
    
    isLoadingMore = true
    // Next page loading logic
}
```

**Features**
- 무한 스크롤 지원
- 중복 요청 방지
- 하단 로딩 인디케이터

---

## Error Handling

### Network Errors
- **Connection Unavailable**: noInternetConnection
- **Request Timeout**: timeout (30초)
- **Server Down**: serverDown
- **HTTP Errors**: serverError(statusCode)
- **JSON Decoding Failures**: decodingError

### Input Validation
- 빈 검색어 체크
- 공백만 포함된 쿼리 검증
- 특수 문자 URL 인코딩

### API Response Validation
- 일관되지 않은 API 응답에 대한 방어적 프로그래밍
- Type-safe 에러 처리
- 누락되거나 잘못된 데이터에 대한 Fallback 값

---

## Testing

### Test Coverage
- **Overall Coverage**: 58%
- **Success Rate**: 100%

### Tested Components
-  BookSearchInteractor
-  BookSearchPresenter  
-  BookDetailInteractor
-  BookDetailPresenter
-  BookRepository

### Testing Strategy
- Protocol 기반 Mock 객체 활용
- 각 레이어별 독립적인 Unit Test
- 비즈니스 로직 중심 테스트

---

## Performance Metrics

### Network
- Request timeout: 30초
- Image download timeout: 30초
- Concurrent requests: Managed by URLSession

### Caching
- Memory cache limit: 시스템 메모리의 25%
- Disk cache limit: 100MB (정리 후 80MB)
- Cache expiration: 7일

### Testing
- Code coverage: 58%
- Test success rate: 100%

---

## Known Issues & Solutions

### 1. API Specification Inconsistency
**문제**: PDF 응답값이 명세와 다름  
**해결**: Safari 또는 기본 브라우저를 통한 외부 처리

### 2. API Type Safety
**문제**: error "0"이 항상 성공을 의미하지 않음  
**해결**: 방어적 프로그래밍 - 응답 데이터 검증 로직 추가

### 3. String Type Response
**문제**: 숫자값이 String으로 전달되는 경우 (price, rating 등)  
**해결**: DTO 레이어에서 타입 변환 로직 구현

---

## Future Improvements

### Technical Improvements

**1. Test Coverage Enhancement**
- 메모리 캐시 및 디스크 캐시 테스트
- Integration 테스트 
- View 레이어 UI 테스트 
- Edge case 테스트 보강

**2. Network Layer Enhancement**
- Retry 로직 구현
...
---
