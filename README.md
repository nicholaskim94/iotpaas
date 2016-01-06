IoT를 위한 PaaS(Platform as Service)
=======

이 프로젝트는 하드웨어 개발자들을 위한 IoT 환경에서 빠른 개발을 도와주는 Platform as Service 입니다.

하드웨어 프로젝트 진행시에 서버를 별도로 셋업하거나 직접 시각화나 데이터 전송 모듈을 구축을 하지 않아도 쉽게 그런 서비스를 제공을 할 것이고, 디바이스에서 쉽게 연결이 될 수 있도록 디바이스의 엔드포인트를 제공할 예정입니다.

저희 프로젝트의 주요 사용자들은 교육을 목적으로 하드웨어를 처음 배우는 사람은 물론이거니와, 실제로 하드웨어를 가지고 서비스를 할려는 사람들까지 모두 필요한 서비스가 될 것이라고 생각합니다.

라이센스는 Repository 내 LICENSE.txt, 라이브러리 정도는 NOTICE.txt 를 참조하세요.

## 링크

[데모](http://tranquil-sands-4879.herokuapp.com)

## 실행방법

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

### esp8266 library

Wifi chip esp8266 can be used with nodemcu firmware or sdk provided by espressif.
In esp8266 library folder both Lua for nodemcu firmware and c project with espressif sdk is porvided. (Currently, only Lua library is updated)

## Lua library composition
In Lua library, all the modules to run this project is uploaded. Modules are already connected, thus, as soon as they are uploaded, it will work fine.
However, due to nodemcu memory problem we will upload both optimzed Lua code and Lua compiled chunk on optimzed folder which will be used in our sample device. 
To solve memory shortage problem, Lua code will be written with less legibilty.

## versions
nodmcu firmware: float_0.9.6

Lua: 5.1.4

espressif sdk: 1.5.0


## modules in Lua library

/ init.lua - SSID and password of AP should be written on init.lua. It passses AP information to connectwifi.lua
/ connectwifi.lua - Connect with AP
/ request.lua - Send POST, GET request to server with TCP/IP socket
/ datatoserver.lua - Bring data from sensors and pass them to reuqest.lua to send it to serever. 
/  			   		 Url, data information, request type should be set
/ initialization.lua - Bring time and location infromation to nodemcu.

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

### 구현 예정
/ 유저 혹은 외부 어플리케어션에서 API를 통한 데이터 요청
클라이언트가 API를 통해 데이터 베이스에서 데이터를 요청하여 Raw 데이터를 수집할 수 있으며 자기 권한에 맞는 데이터만 가져갈 수 있도록 구현한다.
각 유저는 자기 프로젝트에 대한 권한을 가지고 자신의 프로젝트로 업로드 되는 데이터에 접근 할 수 있지만 다른 유저의 프로젝트에 대해 접근이 불가능하며
자신의 프로젝트로 업로드 된 정보에 대한 권한을 다른 유저에게 부여할 수도 있도록 구현한다.

API를 이용하여 Raw 데이터를 가져올 수도 있고 특정 기간 동안의 데이터를 도표화한 이미지나 그 외 통계자료의 형식으로도 export할 수 있고 특정 상황에서
event를 취할 수도 있도록 구현한다. 예를 들어, 방의 온도가 60도가 넘으면 화재 위험 경보 메일을 자신의 이메일로 전송하여 주도록 설정할 수 있도록 한다.

/ C 언어 라이브러리 및 라이브러리 개선
현재 Nodemcu 펌웨어에서 돌아갈 LUA 언어를 기반으로한 라이브러리만 완성되어 있으며 이를 C 언어로도 사용가능 하도록 C 언어 라이브러리도 구축한다.
C 언어를 이용하여 컴파일된 바이너리 파일을 업로드하면 메모리 효율/처리 속도면에서 현재보다 월등한 능력을 보여줄 것으로 기대된다.
현재는 하드웨어 모듈의 인터넷 연결이 잠시 끊어지면 그 시간 동안의 데이터는 유실되지만 인터넷 연결이 끊긴 동안은 데이터를 flash에 저장하고 대기하다
다시 인터넷에 연결되면 데이터를 보내도록 개선할 것입니다.

/ 회로 구성 및 시연
현재는 앞으로 만들 설계된 회로에 대해 데이터를 수집하여 POST 형식으로 json으로 파싱된 데이터를 발신하여 주는 것까지 구현되어 있습니다. ESP8266에 탈부착
가능한 센서 보드를 만들고 이를 몇 장소에 설치하여 데이터 수집을 시연하고 이에 대한 동영상/사진 메뉴얼을 만들어 업로드할 예정입니다.
