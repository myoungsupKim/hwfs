﻿//XJS=sz_fsp_mobile_xp.xjs
(function()
{
    return function(path)
    {
        var obj;
    
        // User Script
        this.registerScript(path, function(exports) {
        /*
         * FSPmobile의 하이브리드 API를 호출한다.<p>
         * 실제 처리된 결과는 파라메터로 제공된 callbackName 으로 리턴받을 수 있다.
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {String} apiName 하이브리드에서 제공하는 api 명
         * @param {String} methodName api중에서 호출할 실제 처리 함수 명
         * @param {Array} args 처리에 필요한 객체 배열
         * @param {String} callbackName 처리 결과를 리턴받을 콜백 함수 명
         */
        this.fspmob_execute = function (formObj,apiName,methodName,args,callbackName)
        {
        	if (system.fspmob) 
        	{
        		try 
        		{
        			system.fspmob(formObj, apiName, methodName, this.stringify(args), callbackName);
        		}
        		catch (e) 
        		{
        			this.alert("fspmob_execute:" + e.errmsg);
        		}
        	}
        }

        // -------------------------------- fsp.mobile.h.mapp
        /**
         * 앱 설정에 관한 정보를 가져온다.
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         */
        this.fspmob_getAppInfo = function (formObj,callbackName)
        {
        	var apiName = "mapp";
        	var methodName = "getAppInfo";
        	var args = [];

        	this.fspmob_execute(formObj, apiName, methodName, args, callbackName);
        }

        // -------------------------------- fsp.mobile.h.app
        /**
         * 디바이스에 대한 정보를 가져온다.
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         */
        this.fspmob_getDeviceInfo = function (formObj,callbackName)
        {
        	var apiName = "app";
        	var methodName = "getDeviceInfo";
        	var args = [];

        	this.fspmob_execute(formObj, apiName, methodName, args, callbackName);
        }
        /**
         * 화면 상단의 타이틀 바에 있는 뒤로가기 버튼에 대한 처리를 재정의한다.
         * 기본적으로 뒤로가기 버튼은 이전 화면 또는 웹뷰의 이전페이지로 이동하도록 되어 있다.
         * xplatform에서는 main frame 등에서 뒤로 가기를 재정의해서 사용하도록 한다.
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {String} callbackName 뒤로가기 선택 시에 호출할 스크립트 함수 명
         */
        this.fspmob_overrideBack = function (formObj,callbackName)
        {
        	this.fspmob_execute(formObj, "app", "overrideBack", [], callbackName);
        }
        /**
         * 현재 화면의 방향을 가져온다.
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         */
        this.fspmob_getScreenOrientation = function (formObj,callbackName)
        {
        	this.fspmob_execute(formObj, "app", "getScreenOrientation", [], callbackName);
        }
        /**
         * 화면의 가로,세로 방향을 설정한다.
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {String} requestOrientation 변경할 화면 방향
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         */
        this.fspmob_setScreenOrientation = function (formObj,requestOrientation,callbackName)
        {
        	this.fspmob_execute(formObj, "app", "setScreenOrientation", [requestOrientation], callbackName);
        }
        /**
         * 현재 화면을 종료한다.
         */
        this.fspmob_remove = function ()
        {
        	this.fspmob_execute(this.lookup("formObj"), "app", "remove", [], null);
        }

        // -------------------------------- fsp.mobile.h.extApp
        /**
         * 별도의 프로세스로 웹 브라우저를 실행한다.
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {String} httpUrl 웹 브라우저로 실행할 페이지 주소
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         */
        this.fspmob_browser = function (formObj,httpUrl,callbackName)
        {
        	this.fspmob_execute(formObj, "extApp", "browser", [httpUrl], callbackName);
        }

        /**
         * 전화번호부 화면을 실행한다.
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         */
        this.fspmob_contact = function (formObj,callbackName)
        {
        	this.fspmob_execute(formObj, "extApp", "contact", [], callbackName);
        }
        /**
         * 주어진 이름에 해당하는 APP을 실행한다.
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {String} appName 실행할 앱 이름
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         */
        this.fspmob_run = function (formObj,appName,callbackName)
        {
        	this.fspmob_execute(formObj, "extApp", "run", [appName], callbackName);
        }

        // -------------------------------- fsp.mobile.h.phone
        /**
         * 주어진 전화번호를 전화를 건다. ( 실제 전화 연결 )
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {String} phoneNumber 전화걸기를 요청할 전화번호
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         */
        this.fspmob_call = function (formObj,phoneNumber,callbackName)
        {
        	this.fspmob_execute(formObj, "phone", "call", [phoneNumber], callbackName);
        }
        /**
         * 실제 전화연결은 하지 않고, 전화번호를 가지고 전화걸기 화면으로만 이동한다.
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {String} phoneNumber 화면에 표시할 전화번호
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         */
        this.fspmob_dial = function (formObj,phoneNumber,callbackName)
        {
        	this.fspmob_execute(formObj, "phone", "dial", [phoneNumber], callbackName);
        }

        // -------------------------------- fsp.mobile.h.sms
        /**
         * 문자를 전송한다.
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {String} phoneNumber 문자를 전송할 전화번호. 다중으로 전송하고자 하는 경우 콤마(,)로 구분하여 전화번호를 지정
         * @param {String} message 전송할 메시지
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         */
        this.fspmob_smsSend = function (formObj,phoneNumber,message,callbackName)
        {
        	var args = {
        		callNo : phoneNumber,
        		msg : message,
        		viewStatus : true
        	};

        	this.fspmob_execute(formObj, "sms", "send", [args], callbackName);
        }

        // -------------------------------- fsp.mobile.h.notification
        /**
         * 소리를 발생시킨다.
         * 주어진 건수 만큰 기본 비프음을 반복적으로 발생시킨다.
         * 만약 해당 디바이스가 무음모드라면 소리는 발생되지 않는다.
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {Number} count 소리 발생 건수
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         */
        this.fspmob_beep = function (formObj,count,callbackName)
        {
        	this.fspmob_execute(formObj, "notification", "beep", [count], callbackName);
        }
        /**
         * 진동음을 발생시킨다.
         * 주어진 초 만큼 진동이 발생된다.
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {Number} seconds 진동이 지속될 초, 0보다 작을 경우 0.5초로 설정
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         */
        this.fspmob_vibrator = function (formObj,seconds,callbackName)
        {
        	if (seconds <= 0) 
        	{
        		seconds = 0.5; //0.5 초
        	}
        	this.fspmob_execute(formObj, "notification", "vibrator", [seconds], callbackName);
        }
        /**
         * 토스트 메시지를 표시한다.
         * 
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {String} message 메시지 
         * @param {String} [showPos] 메시지 표시 위치 ( TOP, CENTER, BOTTOM ) 
         * @param {String} [imgPos] 아이콘 표시 위치 ( TOP, BOTTOM, LEFT, RIGHT, NONE ) 
         * @param {int} [showTime] 초 단위로 메시지 표시 시간 ( 기본 2초 )
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
        */
        this.fspmob_toast = function (formObj,message,showPos,imgPos,showTime,callbackName) {
        	if( !message ) {
        		return;
        	}
        	
        	if( !showPos || showPos == null ) {
        		showPos = "CENTER";
        	}
        	
        	if( !imgPos || imgPos == null ) {
        		imgPos = "NONE";
        	}
        	if( !showTime || showTime == null ) {
        		showTime = 2;
        	}
        	
        	var options = {
        		toastPosition : showPos
        		, imgPosition : imgPos
        		, toastTime : showTime
        	};
        	
        	this.fspmob_execute(formObj, "notification", "toast", [message, options], callbackName);
        }
        /**
         * 현재 소리 모드를 가져온다.
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         */
        this.fspmob_getSoundMode = function (formObj,callbackName)
        {
        	this.fspmob_execute(formObj, "notification", "getSoundMode", [], callbackName);
        }
        /**
         * 현재 소리 모드를 설정한다.
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {Number} soundType soundType 무음(0), 진동(1), 소리(2)	
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         */
        this.fspmob_changeSoundMode = function (formObj,soundType,callbackName)
        {
        	this.fspmob_execute(formObj, "notification", "changeSoundMode", [soundType], callbackName);
        }
        // -------------------------------- fsp.mobile.h.gps
        /**
         * 현재 위치 정보를 가져온다.
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         */
        this.fspmob_getLocation = function (formObj,callbackName)
        {
        	this.fspmob_execute(formObj, "gps", "getLocation", [], callbackName);
        }
        /**
         * GPS가 사용 가능한지를 화인한다.<p>
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         */
        this.fspmob_isGpsUse = function (formObj,callbackName)
        {
        	this.fspmob_execute(formObj, "gps", "isUse", [], callbackName);
        }

        /**
         * GPS 통한 위치 정보 수신을 시작한다.
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {Number} [minTime] 수신을 갱신한 최소 시간 (초단위)
         * @param {Number} [minDistance] 수신을 갱신할 최소 이동 거리 (m 단위)
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         */
        this.fspmob_gpsStart = function (formObj,minTime,minDistance,callbackName)
        {
            //system.fspmob_gpsStart(formObj, minTime, minDistance, callbackName);
            var args = {
                "minTime" : minTime
                ,"minDistance" : minDistance
            }
            this.fspmob_execute(formObj,"gps","start",[args],callbackName);
        }

        /**
         * GSP 위치 수신을 시작해 놓은 경우 해당하는 수신 이벤트를 중지시킨다.
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         */
        this.fspmob_gpsStop = function (formObj,callbackName)
        {
        	this.fspmob_execute(formObj, "gps", "stop", [], callbackName);
        }
        // -------------------------------- fsp.mobile.h.sharedData
        /**
         * 해당하는 키에 대한 값을 가져온다.
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {String} dataKey 값을 가져올 키
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         * @returns 주어진 키에 대한 저장된 값
         */
        this.fspmob_getValue = function (formObj,dataKey,callbackName)
        {
        	this.fspmob_execute(formObj, "sharedData", "getValue", [dataKey], callbackName);
        }
        /**
         * 키에 해당하는 데이터를 저장한다.
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {String} dataKey 값을 저장할 키
         * @param {String} dataValue 속성 값
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         * @returns 처리 성공 여부
         */
        this.fspmob_setValue = function (formObj,dataKey,dataValue,callbackName)
        {
        	this.fspmob_execute(formObj, "sharedData", "setValue", [dataKey, dataValue], callbackName);
        }
        /**
         * 주어진 키에 해당하는 값을 삭제한다.
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {String} dataKey 값을 저장한 키
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         * @returns 처리 성공 여부
         */
        this.fspmob_removeValue = function (formObj,dataKey,callbackName)
        {
        	this.fspmob_execute(formObj, "sharedData", "remove", [dataKey], callbackName);
        }

        // -------------------------------- fsp.mobile.h.database
        /**
         * 로컬 데이터베이스에서 주어진 쿼리로 조회를 처리한다.
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {String} sql 조회할 select SQL
         * @param {JSON} options 처리 옵션 JSON 객체
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         * @returns 조회 결과 JSON 객체
         */
        this.fspmob_sqlQuery = function (formObj,sql,options,callbackName)
        {
        	if (!sql) 
        	{
        		return;
        	}

        	if (!options) 
        	{
        		options = {
        			startIndex : 0,
        			endIndex : 0,
        			dbName : "",
        			dbVersion : null// 이렇게 지정하지 않는다면 기본 디폴트값으로 하겠다.
        		};
        	}

        	this.fspmob_execute(formObj, "database", "query", [sql, options], callbackName);
        }
        /**
         * drop/create/insert/delete 등 select 구문을 제외한 처리 결과 여부를 반환하는 SQL을 처리한다.
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {Array} sqls 처리할 sql 구문 문자 배열
         * @param {JSON} options 처리 옵션 JSON 객체
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         * @returns 조회 결과 JSON 객체
         */
        this.fspmob_sqlExecute = function (formObj,sqls,options,callbackName)
        {
        	if (!sqls) 
        	{
        		return;
        	}

        	if (!options) 
        	{
        		options = {
        			dbName : "",
        			dbVersion : null
        		};
        	}

        	this.fspmob_execute(formObj, "database", "exec", [sqls, options], callbackName);
        }

        // -------------------------------- fsp.mobile.h.util
        /**
         * 웹 화면 내에서 팝업으로 HTML을 표시할수 있는 팝업웹뷰를 띄운다.
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {JSON} [options] 팝업을 띄울 웹화면 정보
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         * @returns 처리 성공여부
         */
        this.fspmob_popupWebViewUrl = function (formObj,options,callbackName)
        {
        	if (!options) 
        	{
        		options = {
        		};
        	}
        	if (options.popupViewUrl == undefined) 
        	{
        		options.popupViewUrl = "";
        	}

        	alert(options.popupViewUrl);
        	this.fspmob_execute(formObj, "util", "popupWebViewUrl", [options], callbackName);
        }
        /**
         * 문자열 데이터를 받아 팝업웹뷰를 띄운다.
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {JSON} [options] 팝업을 띄울 웹화면 정보
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         * @returns 처리 성공여부
         */
        this.fspmob_popupViewByteString = function (formObj,options,callbackName)
        {
        	if (!options) 
        	{
        		options = {
        		};
        	}

        	if (options.popupViewByteString == undefined) 
        	{
        		options.popupViewByteString = "";
        	}

        	this.fspmob_execute(formObj, "util", "popupWebViewByteString", [options], callbackName);
        }
        /**
         * 메일 전송 화면을 표시한다.
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {JSON} [options] 메일 전송과 관련된 옵션
         {
         mail : 메일 주소 (다중메일 시 ","로 구분)
         , mailBody : 메일 내용
         , subject : 메일 제목
         , cc : 메일 참조 (다중메일시 ","로 구분)
         , bcc : 메일 숨은 참조 (다중메일시 ","로 구분)
         }
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         * @returns 처리 성공여부
         */
        this.fspmob_mailto = function (formObj,options,callbackName)
        {
        	this.fspmob_execute(formObj, "util", "mailto", [options], callbackName);
        }

        /**
         * 주어진 경로의 파일을 로컬에 다운로드한다.
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {String} fileUrl 다운로드 받을 파일의 경로
         * @param {String} callbackName  실행결과를 리턴받을 콜백함수
         * @returns 처리 성공여부
         */
        this.fspmob_fileDown = function (formObj,fileUrl,callbackName)
        {
        	this.fspmob_execute(formObj, "file", "download", [fileUrl], callbackName);
        }
        /**
         * 주어진 서버 경로에 서버에 파일 업로드 처리를 한다.
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         * @param {String} svcUrl 서버에 파일 업로드를 처리할 경로
         * @param {String} localFileName 서버로 업로드할 로컬 파일 경로
         * @param {String} [saveFileName] 서버에 저장할 파일명, 지정하지 않을 경우 로컬 파일명과 동일하게 저장
         * @param {JSON} [jsonArgs] 파일업로드시 전달할 추가 파라메터 JSON 객체
         * @param {String} [mimeType] 파일의 Mime Type, 지정하지 않을 경우 파일에서 획득
         * @param {Boolean} [trustAllHost] SSL 전송일 경우 Trust All Host 설정
         * @returns 처리 결과 JSON 객체
         */
        this.fspmob_fileUpload = function (formObj,callbackName,svcUrl,localFileName,saveFileName,jsonArgs,mimeType,trustAllHost)
        {
        	this.fspmob_execute(formObj, "file", "upload", [svcUrl, localFileName, saveFileName, mimeType, jsonArgs, trustAllHost], callbackName);
        }
        // -------------------------------- fsp.mobile.h.media
        /**
         * 웹뷰에서 동영상을 기기가 제공하는 플레이어를 통해 실행한다.
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {String} mediaName 동영상 플레이어할 이름
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         * @returns 처리 성공여부
         */
        this.fspmob_play = function (formObj,mediaName,callbackName)
        {
        	this.fspmob_execute(formObj, "media", "play", [mediaName], callbackName);
        }

        /**
         * 푸시 메시지 등록.<p>
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         */
        this.fspmob_push = function (formObj,callbackName)
        {
        	this.fspmob_execute(formObj, "push", "getMessage", [], callbackName);
        }

        /**
         * 바코드를 읽어들인다.<p>
         *
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
         */
        this.fspmob_getBarcode = function (formObj,callbackName)
        {
        	this.fspmob_execute(formObj, "barcode", "getValue", ["BAR"], callbackName);
        }

        /**
         * 카메라를 실행해서 촬영 후 사진에 대한 경로를 가져온다.
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {JSON} [options] 관련 옵션 
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
        */
        this.fspmob_getPicture = function (formObj,options,callbackName) {
        	if( !options ) {
        		// 초기 값을 설정한다. 
        		options = {
        		};
        	}
        	this.fspmob_execute(formObj, "camera", "getPicture", [options], callbackName);
        }

        /**
         * 앨범에서 사진을 선택하여 경로를 가져온다.
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {JSON} [options] 관련 옵션 
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
        */
        this.fspmob_getPictureFromAlbum = function (formObj,options,callbackName) {
        	if( !options ) {
        		// 초기 값을 설정한다. 
        		options = {
        		};
        	}
        	
        	this.fspmob_execute(formObj, "camera", "getPictureFromAlbum", [options], callbackName);
        }

        /**
         * 화면에 대한 잠금 처리를 한다. 
         * 
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {String} password 숫자로되어 있는 비밀번호 
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
        */
        this.fspmob_lockScreen = function (formObj,password,callbackName) {
        	this.fspmob_execute(formObj, "mapp", "lockScreen", [password], callbackName);
        }

        /**
         * 연락처를 조회한다.
         * 
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {Array} [columns] 조회할 컬럼명 배열
         * @param {JSON} [options] 조회 시 사용할 옵션 값 
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
        */
        this.fspmob_queryContact = function (formObj,columns,options,callbackName) {
        	if( !options ) {
        		// 초기 값을 설정한다. 
        		options = {
        			startPos : 0
        			, fetchSize : 1000
        			, condKeys : []
        			, condValues : []
        		};
        	}
        	
        	if (!columns) {
        		columns = ["*"];
        	}
        	this.fspmob_execute(formObj, "contact", "query", [columns, options], callbackName);
        }

        /**
         * 스케줄을 조회한다.
         * 
         * @param {Object} formObj 호출하는 객체 (일반적으로 this)
         * @param {Array} [columns] 조회할 컬럼명 배열
         * @param {JSON} [options] 조회 시 사용할 옵션 값 
         * @param {String} callbackName callback 실행결과를 리턴받을 콜백함수
        */
        this.fspmob_queryScheduler = function (formObj,columns,options,callbackName) {
        	if( !options ) {
        		// 초기 값을 설정한다. 
        		options = {
        		};
        	}
        	
        	if (!columns) {
        		columns = [
        			"dtstart"
        			, "dtend"   
        			, "description"
        			, "title"
        			, "eventLocation"
        			, "hasAlarm"
        			, "eventStatus"
        			, "allDay"
        		];
        	}
        	
        	this.fspmob_execute(formObj, "scheduler", "query", [columns, options], callbackName);
        }

        /**
         * 객체를 JSON 문자열로 가져오기.<p>
         */
        this.stringify = function (args)
        {
        	return JSON.stringify(args); 
        }
        ;
        
        });


    
        this.loadIncludeScript(path, true);
        
        obj = null;
    };
}
)();