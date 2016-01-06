IoT를 위한 PaaS(Platform as Service)
=======

이 프로젝트는 하드웨어 개발자들을 위한 IoT 환경에서 빠른 개발을 도와주는 Platform as Service 입니다.

하드웨어 프로젝트 진행시에 서버를 별도로 셋업하거나 직접 시각화나 데이터 전송 모듈을 구축을 하지 않아도 쉽게 그런 서비스를 제공을 할 것이고, 디바이스에서 쉽게 연결이 될 수 있도록 디바이스의 엔드포인트를 제공할 예정입니다.

저희 프로젝트의 주요 사용자들은 교육을 목적으로 하드웨어를 처음 배우는 사람은 물론이거니와, 실제로 하드웨어를 가지고 서비스를 할려는 사람들까지 모두 필요한 서비스가 될 것이라고 생각합니다.

라이센스는 Repository 내 LICENSE.txt, 라이브러리 정도는 NOTICE.txt 를 참조하세요.

## 링크

[데모](http://tranquil-sands-4879.herokuapp.com)

## 실헹방법

### Server Side


```
git clone https://github.com/nicholaskim94/iotpaas
cd iotpaas
```

Gemfile 에 Ruby Version 를 수정하고 migration 후 서버를 가동하면 https request 를 listening 하게 됩니다.
```
bundle install
rake db:migrate
rails server
```

### Client Side

####esp8266 library
wifi chip esp8266 can be used with nodemcu firmware or sdk provided by espressif. In esp8266 library folder both lua for nodemcu firmware and c project with espressif sdk is porvided. (Currently, only lua library is updated)

## API

현재 API endpoint 는 Device Client 가 있습니다
```
POST /api/v1/projects/:name
```
지원하지 않는 디바이스 경우 다음과 같은 JSON 형태로 POST REQUEST를 받을 수 있습니다

```
{
    "projectName": "myTestApp",
    "sensorModel": "TI000001",
    "sensorType": "Thermal",
    "unit": "Celcius",
    "time": "2016-01-06",
    "value": 20,
    "access_token":"2f2df5d383813d72e07a3f0dc2d4ec12"
}
```

## 업그레이드

최신 버젼에 대한 정보는 CHANGELOG.md 를 참조해주세요.

IoT PaaS 프로젝트는 [semantic versioning](http://semver.org/)를 따릅니다.

## License

MIT License. Copyright 2016 Seung Ju Kim, Dong Jae Kim


## 라이브러리 정보


## 주요 스크린샷
### POST REQUEST
![](http://i.imgur.com/uAePIdQ.png))

### 웹서비스
![](http://i.imgur.com/Z6fpqiq.png)
