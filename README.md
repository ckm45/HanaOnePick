# 손님 맞춤형 카드 혜택 추천 플랫폼, 하나OnePick
# 1. 프로젝트 개요

## 1-1. 프로젝트 배경

![개요1.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/b0ab2d5c-d6ed-4815-92d0-b67c7ebd29cc/55e11e80-1a55-47ef-a56d-d6f870fb9ca1/%EA%B0%9C%EC%9A%941.png)

![개요2.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/b0ab2d5c-d6ed-4815-92d0-b67c7ebd29cc/dc0a845a-a486-4515-bfb2-683173792ffa/%EA%B0%9C%EC%9A%942.png)

- 요즘 '베테크'가 주목을 받고 있습니다. 베테크(Benefit + 재테크)란 혜택으로 재테크를 한다는 의미로 , 기업이 제공하는 각종 맞춤형 할인 혜택을 활용하는 것을 뜻합니다. 실제로 한 카드사가 개인 맞춤형 서비스 '#마이태그' 를 제공하며 이용자수가 2년 사이 190% 증가했습니다. 그만큼 '베테크'를 활용하는 사람이 많이 늘었다는 것을 확인할 수 있습니다
- 지난해 코로나19 사태 여파로 경제 상황 어려움이 지속되는 가운데 우리나라 국민 1인당 신용카드 보유량은 늘어났습니다. 1인당 신용카드 보유량도 4.4장으로 전년보다 0.2장 증가했습니다. 지난 2012년에 기록한 4.5장 이후 가장 많은 수치라고 합니다.

## 1-2. 프로젝트 목적

- 본 프로젝트는 베테크를 하는 손님들, 카드가 많아 결제 시 선택을 고민하는 손님들을 위한 맞춤형 카드 서비스 필요하다고 생각했습니다.
- 손님들에게 맞춤형 서비스를 제공 하며 결제 시 유리한 카드를 추천 및 손쉬운 실적 관리를 통해 합리적인 소비를 도울 것입니다.
- 손님의 위치와 보유 카드를 기반으로 주변 가맹점의 혜택 정보를 제공합니다.

## 1-3. 타사 기능 비교

![타사기능비교.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/b0ab2d5c-d6ed-4815-92d0-b67c7ebd29cc/067a0c3d-2075-40c0-a3f5-fea49eb8544b/%ED%83%80%EC%82%AC%EA%B8%B0%EB%8A%A5%EB%B9%84%EA%B5%90.png)

## 1-4. 프로젝트 제안서

## 1-5. 개발환경

```
- OS : Window11, Ubuntu Linux 20.04
- Framework : Spring Boot
- Server : tomcat9
- Tool : Eclipse, Sql Developer, IntelliJ, Github
- DBMS : Oracle DBMS
- Cloud : Azure
```

# 2. 프로젝트 일정

![프로젝트일정.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/b0ab2d5c-d6ed-4815-92d0-b67c7ebd29cc/0c4f46ab-4cf4-4d22-9911-8ffcc1ac13bf/%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8%EC%9D%BC%EC%A0%95.png)

# 3. 프로젝트 결과

최종 발표 PPT

## 3-1. 주요 기능

![주요기능.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/b0ab2d5c-d6ed-4815-92d0-b67c7ebd29cc/c3f5ed2e-34a1-4dc9-b36f-5ca1070f9930/%EC%A3%BC%EC%9A%94%EA%B8%B0%EB%8A%A5.png)

## 3-2. 카드 혜택

하나 카드에서 제공하는 카드 29개를 (신용카드 + 체크카드) 데이터베이스에 카드 이름, 카드 부연 설명, 연회비, 전월 실적 등을 입력해두었습니다. 또한 혜택을 데이터베이스 따로 관리해보았습니다.

데이터베이스에 카드 혜택을 카드 상품 ID, 카드 실적, 혜택 코드, 업종 코드, 업종명, 혜택제공량, 혜택한도를 입력했습니다. 혜택을 카드 상품별, 실적별로 관리했습니다. 또한 카드 혜택 제공량과 혜택 한도에 대한 다양한 조건의 처리는 혜택 코드를 통해 구분해보았습니다.

![혜택정리.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/b0ab2d5c-d6ed-4815-92d0-b67c7ebd29cc/8ae289a4-0df3-4521-a136-8ead2e6c9cc1/%ED%98%9C%ED%83%9D%EC%A0%95%EB%A6%AC.png)

 

## 3-3. 데이터 생성

본 프로젝트의 기능 중 사용자의 1년의 소비내역을 토대로 같은 거래내역에 다른 카드를 적용했을 시에 지금보다 더 많은 혜택을 받을 수 있는 카드를 추천해주는 기능이 있습니다. 이에 하나 OnePick을 1년간 사용했다는 가정의 소비내역 데이터가 필요했습니다. 따라서 PL/SQL 프로시저를 통해 결제에 유리한 카드를 고르고 혜택 방식에 맞는 결제를 해서 거래내역 테이블에 INSERT 하면서 소비내역 데이터를 생성하였습니다.

### 3-3-1. 카드 선택 PL/SQL 프로시저 흐름도

![카드선택프로시저.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/b0ab2d5c-d6ed-4815-92d0-b67c7ebd29cc/c064a8cc-875d-4e56-8951-c6be97bf17f1/%EC%B9%B4%EB%93%9C%EC%84%A0%ED%83%9D%ED%94%84%EB%A1%9C%EC%8B%9C%EC%A0%80.png)

### 3-3-2. 결제 PL/SQL 프로시저 흐름도

![카드결제프로시저.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/b0ab2d5c-d6ed-4815-92d0-b67c7ebd29cc/98b08b6c-01fe-4c47-b8a2-c0bdad968a5d/%EC%B9%B4%EB%93%9C%EA%B2%B0%EC%A0%9C%ED%94%84%EB%A1%9C%EC%8B%9C%EC%A0%80.png)

## 3-4. 적용 기술

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/b0ab2d5c-d6ed-4815-92d0-b67c7ebd29cc/d06cffce-a91f-4849-8cb3-5e781b071c30/Untitled.png)

## 4. 아키텍쳐

## 4-1. 시스템 아키텍쳐

![시스템아키텍쳐.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/b0ab2d5c-d6ed-4815-92d0-b67c7ebd29cc/db9b34aa-60a7-43d9-8f91-05037a609d67/%EC%8B%9C%EC%8A%A4%ED%85%9C%EC%95%84%ED%82%A4%ED%85%8D%EC%B3%90.png)

## 4-2. 서비스 아키텍쳐

![서비스아키텍쳐.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/b0ab2d5c-d6ed-4815-92d0-b67c7ebd29cc/5e544346-22a4-494e-8782-c5cb2ff8a3bb/%EC%84%9C%EB%B9%84%EC%8A%A4%EC%95%84%ED%82%A4%ED%85%8D%EC%B3%90.png)

 

## 5. ERD

![ERD.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/b0ab2d5c-d6ed-4815-92d0-b67c7ebd29cc/771e35a1-5483-42f5-8942-d12c0c1e2d3c/ERD.png)
