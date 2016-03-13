IoT를 위한 PaaS(Platform as Service)
=======

이 프로젝트는 하드웨어 개발자들을 위한 IoT 환경에서 빠른 개발을 도와주는 Platform as Service 입니다.

하드웨어 프로젝트 진행시에 서버를 별도로 셋업하거나 직접 시각화나 데이터 전송 모듈을 구축을 하지 않아도 쉽게 그런 서비스를 제공을 할 것이고, 디바이스에서 쉽게 연결이 될 수 있도록 디바이스의 엔드포인트를 제공할 예정입니다.

저희 프로젝트의 주요 사용자들은 교육을 목적으로 하드웨어를 처음 배우는 사람은 물론이거니와, 실제로 하드웨어를 가지고 서비스를 할려는 사람들까지 모두 필요한 서비스가 될 것이라고 생각합니다.

라이센스는 Repository 내 LICENSE.txt, 라이브러리 정도는 NOTICE.txt 를 참조하세요.

## 링크

[데모](http://tranquil-sands-4879.herokuapp.com)

[소개영상](https://youtu.be/dSnTijeqJ2s)

[슬라이드](https://www.slideshare.net/secret/97yiFrM0AWUhUb)

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

## esp8266 library

ESP8266라이브러리에 있는 루아 코드들은 기본적으로 Nodemcu 펌웨어 위에서 동작하는 코드들입니다.
Nodemcu 펌웨어는 nodemcu-flasher를 이용하여 업로드 하였고 루아 코드들은 Lua Loader를 이용하여 올려서 사용한 코드들입니다.
config.lua 파일에 설정사항을 입력하고 센서 모듈과 라이브러리를 올리게 되면 esp8266 mcu는 지정된 시간 마다 센서의 시간을 읽어와 서버에 POST 또는 GET 방식으로 리퀘스트를 전송합니다.
이 프로젝트에 사용된 주요 툴의 버전은 아래와 같습니다.

### Versions
- Nodmcu firmware: float_0.9.6
- Lua: 5.1.4
- Lua Loader: 0.87


### Config 설정

```
SSID = "SSID" --Put Your Wifi SSID on Here!
Pass = "PASSWORD" --Put Your Wifi Password on Here!
TimeOut = 10000 --Connection Closed after Timor, Put Nil to Run 'connect_wifi.lua' until Wifi Connected!
Host = node.chipid()  -- set Host
IP = "" -- set your IP
Path = "/post"
```
SSID 와 Pass는 모듈이 접속할 근처의 AP의 SSID와 비밀번호를 입력하면 됩니다.
가끔 ESP8266이 주변의 AP에 계속 접속하지 못하고 무한 접속시도만 반복하는 경우가 있습니다.
TimeOut은 이를 방지하기 위해 있는 것으로 AP에 TimeOut에 적힌 시간만큼 연결되지 않으면 모듈을 재부팅합니다.
HOST는 리퀘스트에 전송될 HOST명으로 node.chipid()이란 함수로 esp8266이 부여받은 고유의 아이디를 불러와 사용하고 있습니다.
고유의 네이밍을 기법을 보유하시고 있다면 변경하시면 됩니다.
IP와 Path는 연결된 서버의 IP와 서버내 리소스의 Path 입니다.
예를 들어 http://d2campusfest.kr/2015/ 가 접속하고자 하는 url이면 
IP와 Path는 각각 d2campusfest.kr의 ip와 /2015 가 됩니다.
```
ReqType = "POST"
UploadInterval = 10000 -- Unit: ms
MuxSelPinArray = {0, 1, 2} --muxpin setting	0, 1, 2 for sel pin
MuxEnablePin = 3 --muxpin enable pin setting
if (MuxEnablePin) then
	gpio.mode(MuxEnablePin, gpio.OUTPUT)
	gpio.write(MuxEnablePin, gpio.LOW)
end
DataModuleArray = {"HT01SV-TempSensor"}
Header = "Host: "..Host.."\r\n"..
		"Authorization: \r\n"..
		"Content-Type: application/json\r\n"
DataContainer = {
    ["projectName"] = "hi",
    ["sensorModel"] = "TI000001",
    ["sensorType"]= "Thermal",
    ["unit"] = "Celcius",
    ["time"] = "",
    ["value"] = 110,
    ["lat"] = 0,
    ["lng"] = 0,
	["access_token"] = "16586e3d75a12ea0c560ed5045ee9af1" -- put your access_token
}

```
위 부분에서는 전송할 리퀘스트의 타입과 정송될 정보의 주기를 ReqType과 UploadInterval 변수를 통해 설정할 수 있습니다.
ESP8266에는 ADC 핀이 하나밖에 없습니다. 복수의 ADC 센서를 이용하려면 MUX를 사용하여야 하고 MuxSelPinArray와 MuxEnablePin 이에 대한 설정입니다.
단일 ADC 센서만 사용하신다면 설정하실 필요는 없습니다.

DataModuleArray에는 각 센서로 부터 데이터를 추출하는 모듈을 입력하시면 됩니다.
Header는 리퀘스트에 전송될 헤더이고
DataContainer 를 통해 전송될 데이터의 파라미터를 정할 수 있습니다. 위도 경도 정보 lat과 lng는 모듈이 설치될 위치의 좌표를 입력하시면 됩니다.

코드는 매 주기마다 DataModuleArray에 있는 모듈들을 실행합니다. 즉, 사용하는 센서의 종류만큼 모듈을 추가해 주고 모듈의 이름을 어레이에 입력하시면 됩니다.

### 모듈 예제

```
--Volatage input 3.3V
local gpio = gpio
local adc = adc
local MuxSelPinArray = MuxSelPinArray
module('HT01SV-TempSensor')
function SensorModel() return "HT01SV" end
function SensorType() return "TEMP" end
function Unit() return "Cellcius" end
function GetValue()
	gpio.mode(MuxSelPinArray[1], gpio.OUTPUT)
	gpio.mode(MuxSelPinArray[2], gpio.OUTPUT)
	gpio.mode(MuxSelPinArray[3], gpio.OUTPUT)
	gpio.write(MuxSelPinArray[1], gpio.LOW)
	gpio.write(MuxSelPinArray[2], gpio.LOW)
	gpio.write(MuxSelPinArray[3], gpio.LOW)
	return (adc.read(0)*165/3.3 - 40)
end

```

라이브러리의 코드는 모듈로 부터 정보들을 불러옵니다. 즉 모듈에는 예제모듈에 있는 5가지의 함수가 있어야 합니다.
모듈 코드를 작성합에 있어서 파일명과 module('')에 들어갈 이름과 어레이에 들어갈 이름이 같도록 하면 됩니다.
GetValue 함수는 본격적으로 센서로 부터 값을 읽어오는 부분입니다. 모듈 내에서는 글로벌 변수 또는 함수를 사용할 수 없으므로
사용할 글로벌 변수 및 함수는 위에 예제처럼 ex) local gpio = gpio 지역변수에 주소를 저장해 두었다 사용하면 됩니다.

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

## 구현 예정
### 유저 혹은 외부 어플리케어션에서 API를 통한 데이터 요청
각 유저는 자기 프로젝트에 대한 권한을 가지고 자신의 프로젝트로 업로드 되는 데이터에 접근 할 수 있지만 다른 유저의 프로젝트에 대해 접근이 불가능합니다.

즉, 현재까지 구현 된 상태에서는 데이터베이스에 있는 데이터를 프로젝트 소유자만 사용할 수 있지만 저희는 IoT PaaS가 조금 더 유용하게 쓰일 수 있기를 바랍니다.

이를 위하여 프로젝트의 소유자가 프로젝트에 업로드 되어 있는 데이터에 대한 열람 권한을 나누어 주는 기능과

API 키 또한 복수로 생성 가능하고 각 API 키에 제한을 두어 이 서비스를 사용하고 있지 않은 유저에게도 데이터베이스의 데이터를 공유할 수도 있게 할 것입니다.

API를 이용하여 Raw 데이터를 가져올 수도 있고 특정 기간 동안의 데이터를 도표화한 이미지나 그 외 통계자료의 형식으로도 export할 수 있고 특정 상황에서 event를 취할 수도 있도록 구현하는 것이 최종 목표입니다.

예를 들어, 방의 온도가 60도가 넘으면 화재 위험 경보 메일을 자신의 이메일로 전송해 주는 이벤트를 설정할 수 있도록 업그레이드할 것입니다.

### C 언어 라이브러리 및 라이브러리 개선
C 언어를 이용하여 컴파일된 바이너리 파일을 업로드하면 메모리 효율/처리 속도면에서 현재보다 월등한 능력이 기대되지만 개발이 어렵고 오픈 소스가 많이 풀리지 않아 잘 쓰이지 않는 편입니다.

Nodemcu 펌웨어에서 돌아갈 LUA 언어를 기반으로한 라이브러리만 완성되어 있지만 C 언어 라이브러리도 구축하여 사용자의 입맛에 맞게 언어를 선택할 수 있도록 할 것입니다.

현재는 하드웨어 모듈의 인터넷 연결이 잠시 끊어지면 그 시간 동안의 데이터는 유실되지만 인터넷 연결이 끊긴 동안은 데이터를 지정된 시간마다 flash에 저장하다 다시 인터넷에 연결되면 데이터를 로드하여 보내는 기능을 추가할 것입니다.

### 회로 구성 및 시연
현재는 앞으로 만들 설계된 회로에 대해 데이터를 수집하여 POST 형식으로 json으로 파싱된 데이터를 발신하여 주는 것까지 구현되어 있습니다.

ESP8266에 탈부착 가능한 쉴드를 만들고 이를 몇 장소에 설치하여 데이터 수집을 시연하고 이에 대한 동영상/사진 메뉴얼을 만들어 업로드할 예정입니다.

사용하게 될 센서 및 MCU의 데이터시트와 쉴드의 하드웨어 Schematic은 hardware 폴더에 엎로드 되어 있습니다. 사용된 데이터시트, schematic의 출처는 hardware 디렉토리의 NOTICE.txt를 확인하여 주십시오.
