
//==============================================================================
//FSPMobile
//==============================================================================

//==============================================================================
//nexacro.Event.FSPMobileEventInfo
//FSPMobile에 요청된 작업이 성공했을 때 발생되는 이벤트에서 사용되는 EventInfo Object
//==============================================================================

if (!nexacro.Event.FSPMobileEventInfo) {
	nexacro.Event.FSPMobileEventInfo = function (strEventId, intReason, strReturnValue) {
		this.eventid = strEventId;												// 이벤트ID
		this.reason = intReason;												// 이벤트 발생분류 코드
		this.returnvalue = strReturnValue;										// 이벤트 수행결과 (type:Variant)
	}
	_pFSPMobileEventInfo = nexacro.Event.FSPMobileEventInfo.prototype = nexacro._createPrototype(nexacro.Event);
	_pFSPMobileEventInfo._type = "nexacroFSPMobileEventInfo";
	_pFSPMobileEventInfo._type_name = "FSPMobileEventInfo";
	_pFSPMobileEventInfo = null;
}

//==============================================================================
//nexacro.Event.FSPMobileErrorEventInfo
//FSPMobile에 요청된 작업이 실패했을 때 발생되는 이벤트에서 사용되는 EventInfo Object
//==============================================================================
if (!nexacro.Event.FSPMobileErrorEventInfo) {
	nexacro.Event.FSPMobileErrorEventInfo = function (strEventId, intReason, intErrorCode, strErrorMsg) {
		this.eventid = strEventId;												// 이벤트ID
		this.reason = intReason;
		this.errorcode = intErrorCode;
		this.errormsg = strErrorMsg;

	}
	_pFSPMobileErrorEventInfo = nexacro.Event.FSPMobileErrorEventInfo.prototype = nexacro._createPrototype(nexacro.Event);
	_pFSPMobileErrorEventInfo._type = "nexacroFSPMobileErrorEventInfo";
	_pFSPMobileErrorEventInfo._type_name = "FSPMobileErrorEventInfo";
	_pFSPMobileErrorEventInfo = null;
}

//==============================================================================
//nexacro.FSPMobile
//FSPMobile를 연동하기 위해 사용한다.
//==============================================================================
if (!nexacro.FSPMobile) {
	nexacro.FSPMobile = function(name, obj) {
		
		this._id = nexacro.Device.makeID();
		nexacro.Device._userCreatedObj[this._id] = this;
		this.name = name || "";

		this.enableevent = true;

		this.timeout = 10;

		this._clsnm = ["FSPmobilePlugin"];
		this._reasoncode = {
			constructor : {code: -2, ifcls: 0, fn: "constructor", apiName : "", methodName :""},
			destroy : {code: -1, ifcls: 0, fn: "destroy", apiName : "", methodName :""},

			getAppInfo 					: { code : 0  ,  ifcls: 0,  fn : "fspmob_execute", apiName : "mapp", methodName : "getAppInfo"},
			getDeviceInfo 				: { code : 1  ,  ifcls: 0,  fn : "fspmob_execute", apiName : "app", methodName : "getDeviceInfo"},
			overrideBack 				: { code : 2  ,  ifcls: 0,  fn : "fspmob_execute", apiName : "app", methodName : "overrideBack"},
			getScreenOrientation 		: { code : 3  ,  ifcls: 0,  fn : "fspmob_execute", apiName : "app", methodName : "getScreenOrientation"}, 
			setScreenOrientation 		: { code : 4  ,  ifcls: 0,  fn : "fspmob_execute", apiName : "app", methodName : "setScreenOrientation"},
			remove 						: { code : 5  ,  ifcls: 0,  fn : "fspmob_execute", apiName : "app", methodName : "remove"},
			browser 					: { code : 6  ,  ifcls: 0,  fn : "fspmob_execute", apiName : "extApp", methodName : "browser"},
			contact 					: { code : 7  ,  ifcls: 0,  fn : "fspmob_execute", apiName : "extApp", methodName : "contact"}, 
			run 						: { code : 8  ,  ifcls: 0,  fn : "fspmob_execute", apiName : "extApp", methodName : "run"},
			call 						: { code : 9  ,  ifcls: 0,  fn : "fspmob_execute", apiName : "phone", methodName : "call"}, 
			dial 						: { code : 10 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "phone", methodName : "dial"},
			smsSend 					: { code : 11 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "sms", methodName : "send"},
			beep 						: { code : 12 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "notification", methodName : "beep"}, 
			vibrator 					: { code : 13 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "notification", methodName : "vibrator"},
			toast 						: { code : 14 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "notification", methodName : "toast"}, 
			getSoundMode 				: { code : 15 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "notification", methodName : "getSoundMode"},
			changeSoundMode 			: { code : 16 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "notification", methodName : "changeSoundMode"},
			setBadgeCount 				: { code : 17 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "notification", methodName : "setBadgeCount"},
			getLocation 				: { code : 18 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "gps", methodName : "getLocation"},
			isGpsUse 					: { code : 19 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "gps", methodName : "isUse"},
			gpsStop 					: { code : 20 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "gps", methodName : "stop"},
			getValue 					: { code : 21 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "sharedData", methodName : "getValue"},
			getValues 					: { code : 22 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "sharedData", methodName : "getValues"},
			getValueAll 				: { code : 23 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "sharedData", methodName : "getValueAll"},
			setValue 					: { code : 24 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "sharedData", methodName : "setValue"},
			setValues 					: { code : 25 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "sharedData", methodName : "setValues"},
			removeValue 				: { code : 26 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "sharedData", methodName : "remove"},
			removeValues 				: { code : 27 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "sharedData", methodName : "removes"}, 
			removeAll 					: { code : 28 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "sharedData", methodName : "removeAll"},
			sqlQuery 					: { code : 29 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "database", methodName : "query"},
			sqlExecute 					: { code : 30 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "database", methodName : "exec"},
			popupWebViewUrl 			: { code : 31 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "util", methodName : "popupWebViewUrl"},
			popupViewByteString 		: { code : 32 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "util", methodName : "popupWebViewByteString"},
			mailto 						: { code : 33 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "util", methodName : "mailto"},
			fileDown 					: { code : 34 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "file", methodName : "download"},
			fileUpload 					: { code : 35 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "file", methodName : "upload"},
			fileDownList 				: { code : 36 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "file", methodName : "downloadList"},
			getFileSize 				: { code : 37 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "file", methodName : "getFileSize"},
			openFileDialog 				: { code : 38 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "file", methodName : "openFileDialog"},
			play 						: { code : 39 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "media", methodName : "play"}, 
			push 						: { code : 40 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "push", methodName : "getMessage"},
			getBarcode 					: { code : 41 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "barcode", methodName : "getValue"},
			getPicture 					: { code : 42 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "camera", methodName : "getPicture"},
			getPictureFromAlbum 		: { code : 43 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "camera", methodName : "getPictureFromAlbum"},
			getPictureByteString 		: { code : 44 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "camera", methodName : "getByteString"},
			lockScreen 					: { code : 45 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "mapp", methodName : "lockScreen"},
			decrypt 					: { code : 46 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "mapp", methodName : "decrypt"},
			encrypt 					: { code : 47 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "mapp", methodName : "encrypt"}, 
			getLocalFileContents 		: { code : 48 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "mapp", methodName : "getLocalFileContents"},
			getLocalURL 				: { code : 49 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "mapp", methodName : "getLocalURL"},
			getURL 						: { code : 50 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "mapp", methodName : "getURL"},
			moveMenu 					: { code : 51 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "mapp", methodName : "moveMenu"},
			transaction 				: { code : 52 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "mapp", methodName : "transaction"},
			queryContact 				: { code : 53 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "contact", methodName : "query"},
			saveContact 				: { code : 54 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "contact", methodName : "save"},
			queryScheduler				: { code : 55 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "scheduler", methodName : "query"},
			saveScheduler 				: { code : 56 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "scheduler", methodName : "save"},
			getNetworkStatus 			: { code : 57 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "network", methodName : "getNetworkStatus"},
			setNetworkStatus 			: { code : 58 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "network", methodName : "setNetworkStatus"},
			isNetworkStatus 			: { code : 59 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "network", methodName : "isNetworkStatus"},
			isNfcUse 					: { code : 60 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "nfc", methodName : "isUse"},
			nfcStart 					: { code : 61 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "nfc", methodName : "start"},
			nfcStop 					: { code : 62 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "nfc", methodName : "stop"},
			sensorStart 				: { code : 63 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "sensor", methodName : "start"},
			sensorStop 					: { code : 64 ,  ifcls: 0,  fn : "fspmob_execute", apiName : "sensor", methodName : "stop"},
					
		};



		
		this._event_list = {
            "onsuccess": 1, "onerror": 1, "onscan": 1
        };

		// event
		this.onsuccess = null;//new nexacro.EventListener("onsuccess");					// 요청한 작업이 성공했을 때 발생하는 이벤트
		this.onerror = null;//new nexacro.EventListener("onerror");						// 요청한 작업이 실패했을 때 발생하는 이벤트

		// native constructor
		
		var params = {} ;
		var fninfo = this._reasoncode.constructor;
		return this._execFn(fninfo, params);
	};


	
	
	var _pFSPMobile = nexacro.FSPMobile.prototype = nexacro._createPrototype(nexacro.EventSinkObject);
	
	_pFSPMobile._type = "nexacroFSPMobile";
	_pFSPMobile._type_name = "FSPMobile";

	_pFSPMobile.destroy = function(){
		var params = {};
		var jsonstr;

		delete nexacro.Device._userCreatedObj[this._id];
		
		
		var fninfo = this._reasoncode.destroy;
		return this._execFn(fninfo, params);
	};




	// -------------------------------- fsp.mobile.h.mapp
	/**
	 * 앱 설정에 관한 정보를 가져온다.
	 *
	 
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 */
	_pFSPMobile.getAppInfo = function ()
	{
		var args = [];	
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.getAppInfo;
		return this._execFn(fninfo, params);

	}

	// -------------------------------- fsp.mobile.h.app
	/**
	 * 디바이스에 대한 정보를 가져온다.
	 *
	 
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 */
	_pFSPMobile.getDeviceInfo = function ()
	{
		var args = [];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.getDeviceInfo;
		return this._execFn(fninfo, params);
	}
	/**
	 * 화면 상단의 타이틀 바에 있는 뒤로가기 버튼에 대한 처리를 재정의한다.
	 * 기본적으로 뒤로가기 버튼은 이전 화면 또는 웹뷰의 이전페이지로 이동하도록 되어 있다.
	 * xplatform에서는 main frame 등에서 뒤로 가기를 재정의해서 사용하도록 한다.
	 *
	 
	 * @param {String}  뒤로가기 선택 시에 호출할 스크립트 함수 명
	 */
	_pFSPMobile.overrideBack = function ()
	{
		var args = [];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.overrideBack;
		return this._execFn(fninfo, params);
	}
	/**
	 * 현재 화면의 방향을 가져온다.
	 *
	 
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 */
	_pFSPMobile.getScreenOrientation = function ()
	{
		var args = [];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.getScreenOrientation;
		return this._execFn(fninfo, params);
	}
	/**
	 * 화면의 가로,세로 방향을 설정한다.
	 *
	 
	 * @param {String} requestOrientation 변경할 화면 방향
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 */
	_pFSPMobile.setScreenOrientation = function ( requestOrientation)
	{
		var args = [requestOrientation];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.setScreenOrientation;
		return this._execFn(fninfo, params);
	}
	/**
	 * 현재 화면을 종료한다.
	 */
	_pFSPMobile.remove = function ()
	{
		var args = [];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.remove;
		return this._execFn(fninfo, params);
	}


	// -------------------------------- fsp.mobile.h.extApp
	/**
	 * 별도의 프로세스로 웹 브라우저를 실행한다.
	 *
	 
	 * @param {String} httpUrl 웹 브라우저로 실행할 페이지 주소
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 */
	_pFSPMobile.browser = function ( httpUrl)
	{
		var args = [httpUrl];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.browser;
		return this._execFn(fninfo, params);
	}

	/**
	 * 전화번호부 화면을 실행한다.
	 *
	 
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 */
	_pFSPMobile.contact = function ()
	{
		var args = [];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.contact;
		return this._execFn(fninfo, params);
	}
	/**
	 * 주어진 이름에 해당하는 APP을 실행한다.
	 *
	 
	 * @param {String} appName 실행할 앱 이름
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 */
	_pFSPMobile.run = function ( appName)
	{
		var args = [appName];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.run;
		return this._execFn(fninfo, params);
	}

	// -------------------------------- fsp.mobile.h.phone
	/**
	 * 주어진 전화번호를 전화를 건다. ( 실제 전화 연결 )
	 *
	 
	 * @param {String} phoneNumber 전화걸기를 요청할 전화번호
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 */
	_pFSPMobile.call = function ( phoneNumber)
	{
		var args = [phoneNumber];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.call;
		return this._execFn(fninfo, params);
	}
	/**
	 * 실제 전화연결은 하지 않고, 전화번호를 가지고 전화걸기 화면으로만 이동한다.
	 *
	 
	 * @param {String} phoneNumber 화면에 표시할 전화번호
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 */
	_pFSPMobile.dial = function ( phoneNumber)
	{
		var args = [phoneNumber];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.dial;
		return this._execFn(fninfo, params);
	}

	// -------------------------------- fsp.mobile.h.sms
	/**
	 * 문자를 전송한다.
	 *
	 
	 * @param {String} phoneNumber 문자를 전송할 전화번호. 다중으로 전송하고자 하는 경우 콤마(,)로 구분하여 전화번호를 지정
	 * @param {String} message 전송할 메시지
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 */
	_pFSPMobile.smsSend = function ( phoneNumber, message)
	{
		var arg = {
			callNo : phoneNumber,
			msg : message,
			viewStatus : true
		};

		var args = [arg];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.smsSend;
		return this._execFn(fninfo, params);
	}

	// -------------------------------- fsp.mobile.h.notification
	/**
	 * 소리를 발생시킨다.
	 * 주어진 건수 만큰 기본 비프음을 반복적으로 발생시킨다.
	 * 만약 해당 디바이스가 무음모드라면 소리는 발생되지 않는다.
	 *
	 
	 * @param {Number} count 소리 발생 건수
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 */
	_pFSPMobile.beep = function ( count)
	{
		var args = [count];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.beep;
		return this._execFn(fninfo, params);
	}
	/**
	 * 진동음을 발생시킨다.
	 * 주어진 초 만큼 진동이 발생된다.
	 *
	 
	 * @param {Number} seconds 진동이 지속될 초, 0보다 작을 경우 0.5초로 설정
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 */
	_pFSPMobile.vibrator = function ( seconds)
	{
		if (seconds <= 0) 
		{
			seconds = 0.5; //0.5 초
		}
		
		var args = [seconds];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.vibrator;
		return this._execFn(fninfo, params);
	}
	/**
	 * 토스트 메시지를 표시한다.
	 * 
	 
	 * @param {String} message 메시지 
	 * @param {String} [showPos] 메시지 표시 위치 ( TOP, CENTER, BOTTOM ) 
	 * @param {String} [imgPos] 아이콘 표시 위치 ( TOP, BOTTOM, LEFT, RIGHT, NONE ) 
	 * @param {int} [showTime] 초 단위로 메시지 표시 시간 ( 기본 2초 )
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	*/
	_pFSPMobile.toast = function ( message, showPos, imgPos, showTime) {
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
		
		
		var args = [message, options];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.toast;
		return this._execFn(fninfo, params);
	}
	/**
	 * 현재 소리 모드를 가져온다.
	 *
	 
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 */
	_pFSPMobile.getSoundMode = function ()
	{
		var args = [];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.getSoundMode;
		return this._execFn(fninfo, params);
	}
	/**
	 * 현재 소리 모드를 설정한다.
	 *
	 
	 * @param {Number} soundType soundType 무음(0), 진동(1), 소리(2)	
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 */
	_pFSPMobile.changeSoundMode = function ( soundType)
	{
		
		var args = [soundType];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.changeSoundMode;
		return this._execFn(fninfo, params);
	}

	/**
	 * 뱃지의 숫자를 설정한다.
	 *
	 
	 * @param {Number} badgeCount 변경할 뱃지 숫자.	
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 */
	_pFSPMobile.setBadgeCount = function ( badgeCount)
	{
		var args = [badgeCount];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.setBadgeCount;
		return this._execFn(fninfo, params);
	}

	// -------------------------------- fsp.mobile.h.gps
	/**
	 * 현재 위치 정보를 가져온다.
	 *
	 
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 */
	_pFSPMobile.getLocation = function ()
	{
		
		var args = [];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.getLocation;
		return this._execFn(fninfo, params);
	}
	/**
	 * GPS가 사용 가능한지를 화인한다.<p>
	 *
	 
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 */
	_pFSPMobile.isGpsUse = function ()
	{
		var args = [];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.isGpsUse;
		return this._execFn(fninfo, params);
	}
	/**
	 * GPS 통한 위치 정보 수신을 시작한다.
	 *
	 
	 * @param {Number} [minTime] 수신을 갱신한 최소 시간 (초단위)
	 * @param {Number} [minDistance] 수신을 갱신할 최소 이동 거리 (m 단위)
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 
	_pFSPMobile.gpsStart = function ( minTime, minDistance)
	{
		system.fspmob_gpsStart( minTime, minDistance);
	}
	*/

	/**
	 * GSP 위치 수신을 시작해 놓은 경우 해당하는 수신 이벤트를 중지시킨다.
	 *
	 
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 */
	_pFSPMobile.gpsStop = function ()
	{
		//_pFSPMobile.execute( "gps", "stop", []);
		var args = [];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.gpsStop;
		return this._execFn(fninfo, params);
	}
	// -------------------------------- fsp.mobile.h.sharedData
	/**
	 * 해당하는 키에 대한 값을 가져온다.
	 *
	 
	 * @param {String} dataKey 값을 가져올 키
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 * @returns 주어진 키에 대한 저장된 값
	 */
	_pFSPMobile.getValue = function ( dataKey)
	{
		
		var args = [dataKey];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.getValue;
		return this._execFn(fninfo, params);
	}
	/**
	 * 해당하는 키에 대한 값들을 가져온다.
	 *
	 
	 * @param {String} dataKeys 저장한 여러 변수 명( ',' 로 구분)
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 * @returns 주어진 키에 대한 저장된 값들의 JSON객체 
			result : {
					key : value
					, key1 : value1
					}
			} 
	 */
	_pFSPMobile.getValues = function ( dataKeys)
	{
		
		var args = [dataKeys];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.getValues;
		return this._execFn(fninfo, params);
	}
	/**
	 * 저장된 전체 정보를 가져온다.
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 * @returns 변수 명에 해당하는 저장된 값 배열
	 */
	_pFSPMobile.getValueAll = function()
	{
		var args = [];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.getValueAll;
		return this._execFn(fninfo, params);
	}
	/**
	 * 키에 해당하는 데이터를 저장한다.
	 *
	 
	 * @param {String} dataKey 값을 저장할 키 
	 * @param {String} dataValue 속성 값
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 * @returns 처리 성공 여부
	 */
	_pFSPMobile.setValue = function (dataKey, dataValue)
	{
		//_pFSPMobile.execute( "sharedData", "setValue", [dataKey, dataValue]);
		var args = [dataKey, dataValue];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.setValue;
		return this._execFn(fninfo, params);
	}
	/**
	 * 키에 해당하는 데이터들을 저장한다.
	 *
	 
	 * @param {JSON} dataObject 저장할 값 
				{ key : value
				  , key1 : value1
				}
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 * @returns 처리 성공 여부
	 */
	_pFSPMobile.setValues = function (  dataObject)
	{
		//_pFSPMobile.execute( "sharedData", "setValues",[dataObject] );
		var args = [dataObject];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.setValues;
		return this._execFn(fninfo, params);
	}
	/**
	 * 주어진 키에 해당하는 값을 삭제한다.
	 *
	 
	 * @param {String} dataKey 값을 저장한 키
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 * @returns 처리 성공 여부
	 */
	_pFSPMobile.removeValue = function ( dataKey)
	{
		//_pFSPMobile.execute( "sharedData", "remove", [dataKey]);
		var args = [dataKey];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.removeValue;
		return this._execFn(fninfo, params);
	}
	/**
	 * 주어진 키에 해당하는 값들을 삭제한다.
	 *
	 
	 * @param {String} dataKeys 값을 저장한 키 ( "," 로구분)
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 * @returns 처리 성공 여부
	 */
	_pFSPMobile.removeValues = function ( dataKeys)
	{
		//_pFSPMobile.execute( "sharedData", "removes", [dataKeys]);
		var args = [dataKeys];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.removeValues;
		return this._execFn(fninfo, params);
	}

	/**
	 * 저장된 전체 정보를 삭제한다.
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 * @returns 처리 성공 여부
	 */
	_pFSPMobile.removeAll = function()
	{
		//_pFSPMobile.execute( "sharedData", "removeAll", []);
		var args = [];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.removeAll;
		return this._execFn(fninfo, params);
	}

	// -------------------------------- fsp.mobile.h.database
	/**
	 * 로컬 데이터베이스에서 주어진 쿼리로 조회를 처리한다.
	 *
	 
	 * @param {String} sql 조회할 select SQL
	 * @param {JSON} options 처리 옵션 JSON 객체
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 * @returns 조회 결과 JSON 객체
	 */
	_pFSPMobile.sqlQuery = function ( sql, options)
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

		//_pFSPMobile.execute( "database", "query", [sql, options]);
		var args = [sql, options];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.sqlQuery;
		return this._execFn(fninfo, params);
	}
	/**
	 * drop/create/insert/delete 등 select 구문을 제외한 처리 결과 여부를 반환하는 SQL을 처리한다.
	 *
	 
	 * @param {Array} sqls 처리할 sql 구문 문자 배열
	 * @param {JSON} options 처리 옵션 JSON 객체
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 * @returns 조회 결과 JSON 객체
	 */
	_pFSPMobile.sqlExecute = function ( sqls, options)
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

		//_pFSPMobile.execute( "database", "exec", [sqls, options]);
		var args = [sqls, options];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.sqlExecute;
		return this._execFn(fninfo, params);
	}

	// -------------------------------- fsp.mobile.h.util
	/**
	 * 웹 화면 내에서 팝업으로 HTML을 표시할수 있는 팝업웹뷰를 띄운다.
	 *
	 
	 * @param {JSON} [options] 팝업을 띄울 웹화면 정보
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 * @returns 처리 성공여부
	 */
	_pFSPMobile.popupWebViewUrl = function ( options)
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

		//_pFSPMobile.execute( "util", "popupWebViewUrl", [options]);
		var args = [options];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.popupWebViewUrl;
		return this._execFn(fninfo, params);
	}
	/**
	 * 문자열 데이터를 받아 팝업웹뷰를 띄운다.
	 *
	 
	 * @param {JSON} [options] 팝업을 띄울 웹화면 정보
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 * @returns 처리 성공여부
	 */
	_pFSPMobile.popupViewByteString = function ( options)
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

		//_pFSPMobile.execute( "util", "popupWebViewByteString", [options]);
		var args = [options];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.popupViewByteString;
		return this._execFn(fninfo, params);
	}
	/**
	 * 메일 전송 화면을 표시한다.
	 *
	 
	 * @param {JSON} [options] 메일 전송과 관련된 옵션
	 {
	 mail : 메일 주소 (다중메일 시 ","로 구분)
	 , body : 메일 내용
	 , subject : 메일 제목
	 , cc : 메일 참조 (다중메일시 ","로 구분)
	 , bcc : 메일 숨은 참조 (다중메일시 ","로 구분)
	 }
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 * @returns 처리 성공여부
	 */
	_pFSPMobile.mailto = function ( options)
	{
		//_pFSPMobile.execute( "util", "mailto", [options]);
		var args = [options];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.mailto;
		return this._execFn(fninfo, params);
	}

	// -------------------------------- fsp.mobile.h.file
	/**
	 * 주어진 경로의 파일을 로컬에 다운로드한다.
	 *
	 
	 * @param {String} fileUrl 다운로드 받을 파일의 경로
	 * @param {String} fileName 다운로드 파일을 로컬에 저장할 저장 파일명.
	 * @param {String}   실행결과를 리턴받을 콜백함수
	 * @returns 처리 성공여부
	 */
	_pFSPMobile.fileDown = function ( fileUrl, fileName)
	{
		var options = {
			saveName : fileName
		};
		//_pFSPMobile.execute( "file", "download", [fileUrl, options]);
		var args = [fileUrl, options];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.fileDown;
		return this._execFn(fninfo, params);
	}

	/**
	 * 주어진 서버 경로에 서버에 파일 업로드 처리를 한다.
	 *
	 
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 * @param {String} svcUrl 서버에 파일 업로드를 처리할 경로
	 * @param {String} localFileName 서버로 업로드할 로컬 파일 경로
	 * @param {String} [saveFileName] 서버에 저장할 파일명, 지정하지 않을 경우 로컬 파일명과 동일하게 저장
	 * @param {JSON} [jsonArgs] 파일업로드시 전달할 추가 파라메터 JSON 객체
	 * @param {String} [mimeType] 파일의 Mime Type, 지정하지 않을 경우 파일에서 획득
	 * @param {Boolean} [trustAllHost] SSL 전송일 경우 Trust All Host 설정
	 * @returns 처리 결과 JSON 객체
	 */
	_pFSPMobile.fileUpload = function (svcUrl, localFileName, saveFileName, jsonArgs, mimeType, trustAllHost)
	{
		//_pFSPMobile.execute( "file", "upload", [svcUrl, localFileName, saveFileName, mimeType, jsonArgs, trustAllHost]);
		var args = [svcUrl, localFileName, saveFileName, mimeType, jsonArgs, trustAllHost];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.fileUpload;
		return this._execFn(fninfo, params);
	}

	/**
	 *	다운로드한 파일의 목록을 나타낸다.
	 *	@param	{Object} formObj 호출하는 객체 (일반적으로 this)
	 *	@param	{bool} isImgZoom 이미지 뷰어의 확대/축소 기능 사용 여부
	 *	@param	{String}  실행결과를 리턴받을 콜백함수
	 */
	_pFSPMobile.fileDownList = function ( isImgZoom)
	{
		var options = {
			isZoom : isImgZoom
		}
		//_pFSPMobile.execute( "file", "downloadList", [options]);
		var args = [options];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.fileDownList;
		return this._execFn(fninfo, params);
	}

	/**
	 *	선택한 파일의 사이즈를 가져온다.
	 *	@param	{Object} formObj 호출하는 객체 (일반적으로 this)
	 *	@param	{String} fileUrl 파일의 경로
	 *	@param	{String}  실행결과를 리턴받을 콜백함수
	 */
	_pFSPMobile.getFileSize = function ( fileUrl)
	{
		//_pFSPMobile.execute( "file", "getFileSize", [fileUrl]);
		var args = [fileUrl];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.getFileSize;
		return this._execFn(fninfo, params);
	}

	/**
	 *	로컬에 저장된 파일을 선택하여 가져온다. (안드로이드 만 지원)
	 *	@param	{Object} formObj 호출하는 객체 (일반적으로 this)
	 *	@param	{String} fileExtention 파일의 확장자
	 *	@param	{String}  실행결과를 리턴받을 콜백함수
	 */
	_pFSPMobile.openFileDialog = function ( fileExtention)
	{
		var options = {
			fileExtension : fileExtention
		};
		
		//_pFSPMobile.execute( "file", "openFileDialog", [options]);
		var args = [options];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.openFileDialog;
		return this._execFn(fninfo, params);
	}

	// -------------------------------- fsp.mobile.h.media
	/**
	 * 웹뷰에서 동영상을 기기가 제공하는 플레이어를 통해 실행한다.
	 *
	 
	 * @param {String} mediaName 동영상 플레이어할 이름
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 * @returns 처리 성공여부
	 */
	_pFSPMobile.play = function ( mediaName)
	{
		//_pFSPMobile.execute( "media", "play", [mediaName]);
		var args = [mediaName];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.play;
		return this._execFn(fninfo, params);
	}

	/**
	 * 푸시 메시지 등록.<p>
	 *
	 
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 */
	_pFSPMobile.push = function ()
	{
		//_pFSPMobile.execute( "push", "getMessage", []);
		var args = [];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.push;
		return this._execFn(fninfo, params);
	}

	// -------------------------------- fsp.mobile.h.barcode
	/**
	 * 바코드를 읽어들인다.<p>
	 *
	 
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 */
	_pFSPMobile.getBarcode = function ()
	{
		//_pFSPMobile.execute( "barcode", "getValue", ["BAR"]);
		var args = ["BAR"];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.getBarcode;
		return this._execFn(fninfo, params);
	}

	/**
	 * 카메라를 실행해서 촬영 후 사진에 대한 경로를 가져온다.
	 
	 * @param {JSON} [options] 관련 옵션 
		{
			returnType : 'F' or 'D'   이미지 파일 반환 타입
			, saveType : 'JPEG' or 'PNG'   이미지 파일 저장 타입
			, targetWidth : 반환 이미지 넓이
			, targetHeight : 반환 이미지 높이
			, fileName : 실행결과 타입이 파일일 경우에 파일 명 
						지정하지 않을 경우 기본값은 
						fsp_%yyyyMMddHHmmss% 의 이름을 사용
			, quality : 이미지 저장 품질 ( 1 ~ 100 )
			, deleteFile : 파일을 이미지 바이트 문자열로 제공할 경우에 파일의 삭제여부. Y or N ( 기본값 N , 'N'일 경우 파일로 저장된다.) 
			, crop : 'YES' or 'NO'   crop 사용여부 타입
			, cropWidth : 크롭된 사진의 넓이
			, cropHeight : 크롭된 사진의 높이
			, resizeFile : 이미지의 사이즈 변환 여부. Y or N (기본값 Y, 'N'일 경우 원본이미지)
		}
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	*/
	_pFSPMobile.getPicture = function ( options) {
		if( !options ) {
			// 초기 값을 설정한다. 
			options = {
			};
		}
		//_pFSPMobile.execute( "camera", "getPicture", [options]);
		var args = [options];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.getPicture;
		return this._execFn(fninfo, params);
	}

	/**
	 * 앨범에서 사진을 선택하여 경로를 가져온다.
	 
	 * @param {JSON} [options] 관련 옵션 
		{
			returnType : 'F' or 'D'   이미지 파일 반환 타입
			, targetWidth : 반환 이미지 넓이
			, targetHeight : 반환 이미지 높이
			, quality : 이미지 저장 품질 ( 1 ~ 100 )
			, crop : 'YES' or 'NO'   crop 사용여부 타입
			, cropWidth : 크롭된 사진의 넓이
			, cropHeight : 크롭된 사진의 높이
			, resizeFile : Y or N    이미지의 사이즈 변환 여부. (기본값 Y, 'N'일 경우 원본이미지)
		}
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	*/
	_pFSPMobile.getPictureFromAlbum = function ( options) {
		if( !options ) {
			// 초기 값을 설정한다. 
			options = {
			};
		}
		
		//_pFSPMobile.execute( "camera", "getPictureFromAlbum", [options]);
		var args = [options];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.getPictureFromAlbum;
		return this._execFn(fninfo, params);
	}

	/**
	 *	앨범에서 선택한 사진 파일을 이미지 바이트 문자열로 가져온다.
	 
	 * @param {JSON} [options] 관련 옵션 
		{
			, targetWidth : 반환 이미지 넓이
			, targetHeight : 반환 이미지 높이
			, fileName : 실행결과 타입이 파일일 경우에 파일 명 
						지정하지 않을 경우 기본값은 
						fsp_%yyyyMMddHHmmss% 의 이름을 사용
			, quality : 이미지 저장 품질 ( 1 ~ 100 )
		}
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	 */
	_pFSPMobile.getPictureByteString = function ( options) {
		if (!options ){
			options = {
			};
		}	
		//_pFSPMobile.execute( "camera", "getByteString", [options]);
		var args = [options];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.getPictureByteString;
		return this._execFn(fninfo, params);
	}

	// -------------------------------- fsp.mobile.h.mapp
	/**
	 * 화면에 대한 잠금 처리를 한다. 
	 * 
	 
	 * @param {String} password 숫자로되어 있는 비밀번호 
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	*/
	_pFSPMobile.lockScreen = function ( password) {
		//_pFSPMobile.execute( "mapp", "lockScreen", [password]);
		var args = [password];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.lockScreen;
		return this._execFn(fninfo, params);
	}
	/**
	 *	복호화 처리를 한다.
	 *	@param	{Object} formObj 호출하는 객체 (일반적으로 this)
	 *	@param	{String} message 복호화할 원본 문자열
	 *	@param	{String} type 복호화에 사용할 타입 AES (RSA방식의 복호화는 지원하지 않음.)
	 *	@param	{String}  callback 실행결과를 리턴받을 콜백함수
	 *	@return	복호화된 문자열.
	 */
	_pFSPMobile.decrypt = function ( message, type)
	{
		//_pFSPMobile.execute( "mapp", "decrypt", [message, type]);
		var args = [message, type];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.decrypt;
		return this._execFn(fninfo, params);
	}
	/**
	 *	암호화 처리를 한다.
	 *	@param	{Object} formObj 호출하는 객체 (일반적으로 this)
	 *	@param	{String} message 암호화할 원본 문자열
	 *	@param	{String} type 암호화에 사용할 타입 (AES or RSA)
	 *	@param	{String}  callback 실행결과를 리턴받을 콜백함수
	 *	@return	암호화된 문자열.
	 */
	_pFSPMobile.encrypt = function ( message, type)
	{
		//_pFSPMobile.execute( "mapp", "encrypt", [message, type]);
		var args = [message, type];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.encrypt;
		return this._execFn(fninfo, params);
	}
	/**
	 *	로컬 파일의 내용을 가져온다.
	 *	@param	{Object} formObj 호출하는 객체 (일반적으로 this)
	 *	@param	{String} fileType 파일의 타입 ( X or N ) X = XPLATFORM, N = FSPmobile
	 *	@param	{String} fileName 파일 명
	 *	@param	{String}  callback 실행결과를 리턴받을 콜백함수
	 *	@return	주어진 로컬 파일의 내용에 대한 문자형
	 */
	_pFSPMobile.getLocalFileContents = function ( fileType, fileName)
	{
		//_pFSPMobile.execute( "mapp", "getLocalFileContents", [fileType, fileName]);
		var args = [fileType, fileName];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.getLocalFileContents;
		return this._execFn(fninfo, params);
	}
	/**
	 *	로컬파일에 대한 경로를 가져온다.
	 *	@param	{Object} formObj 호출하는 객체 (일반적으로 this)
	  *	@param	{String} fileType 파일의 타입 ( X or N ) X = XPLATFORM, N = FSPmobile
	 *	@param	{String} fileName 파일 명
	*	@param	{String}  callback 실행결과를 리턴받을 콜백함수
	 *	@return	주어진 로컬 파일의 경로에 대한 문자형
	 */
	_pFSPMobile.getLocalURL = function ( fileType, fileName)
	{	
		//_pFSPMobile.execute( "mapp", "getLocalURL", [fileType, fileName]);
		var args = [fileType, fileName];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.getLocalURL;
		return this._execFn(fninfo, params);
	}
	/**
	 *	URL 경로를 가져온다.
	 *	@param	{Object} formObj 호출하는 객체 (일반적으로 this)
	 *	@param	{String} url 경로
	 *	@param	{String}  callback 실행결과를 리턴받을 콜백함수
	 *	@return	URL 경로에 대한 JSON 객체.
	 */
	_pFSPMobile.getURL = function ( url)
	{
		//_pFSPMobile.execute( "mapp", "getURL", [url]);
		var args = [url];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.getURL;
		return this._execFn(fninfo, params);
	}
	/**
	 *	주어진 메뉴 아이디로 이동한다.
	 *	@param	{Object} formObj 호출하는 객체 (일반적으로 this)
	 *	@param	{String}  callback 실행결과를 리턴받을 콜백함수
	 *	@return	처리 성공 여부.
	 */
	_pFSPMobile.moveMenu = function ( menuId)
	{
		//_pFSPMobile.execute( "mapp", "moveMenu", [menuId]);
		var args = [menuId];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.moveMenu;
		return this._execFn(fninfo, params);
	}
	/**
	 *	서버의 트랜잭션을 대신 처리한다.
	 *	@param	{Object} formObj 호출하는 객체 (일반적으로 this)
	 *	@param	{String} serverURL 호출한 서비스 경로
	 *	@param	{JSON} sendData 서버에 전송할 데이터
	 *	@param	{JSON} options 처리 옵션 정보
						{ 
							compress : 압축 적용 여부
							auth : 로그인 여부
							waiting : 프로그래스 여부
							waitingMsg : 프로그래스 메시지
							encryptType : 암호화 타입
						}
	 *	@param	{String}  callback 실행결과를 리턴받을 콜백함수
	 *	@return	JSON 객체.
	 */
	_pFSPMobile.transaction = function ( serverURL, sendData, options)
	{
		//_pFSPMobile.execute( "mapp", "transaction",[svrUrl, sendData, options]);
		var args = [svrUrl, sendData, options];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.transaction;
		return this._execFn(fninfo, params);
	}

	// -------------------------------- fsp.mobile.h.contact
	/**
	 * 연락처를 조회한다.
	 * 
	 
	 * @param {Array} [columns] 조회할 컬럼명 배열
	 * @param {JSON} [options] 조회 시 사용할 옵션 값 
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	*/
	_pFSPMobile.queryContact = function ( columns, options) {
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
		//_pFSPMobile.execute( "contact", "query", [columns, options]);
		var args = [columns, options];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.queryContact;
		return this._execFn(fninfo, params);
	}

	/**
	 *	연락처 정보를 저장한다.
	 *	@param	{Object} formObj 호출하는 객체 (일반적으로 this)
	 *	@param	{JSON} options 저장할 데이터
		{
			displayName : 표시 이름
			phoneNums : 전화번호 객체
			names : 이름 객체
			emails : 이메일 정보 객체
			addresses : 주소 정보 객체
			nickname : 별명
			ims : IM 주소 정보 객체
			orgs : 조직 정보 객체
			urls : 홈페이지 주소 객체
			photos : 사진 정보 객체
			birthday : 생년월일
			note : 메모
		}
	 *	@param	{String}  callback 실행결과를 리턴받을 콜백함수 
	 */
	_pFSPMobile.saveContact = function ( options)
	{	
		//_pFSPMobile.execute( "contact", "save", [options]);		
		var args = [options];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.saveContact;
		return this._execFn(fninfo, params);
	}

	// -------------------------------- fsp.mobile.h.scheduler
	/**
	 * 스케줄을 조회한다.
	 * 
	 
	 * @param {Array} [columns] 조회할 컬럼명 배열
	 * @param {JSON} [options] 조회 시 사용할 옵션 값 
	 * @param {String}  callback 실행결과를 리턴받을 콜백함수
	*/
	_pFSPMobile.queryScheduler = function ( columns, options) {
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
		
		//_pFSPMobile.execute( "scheduler", "query", [columns, options]);
		var args = [columns, options];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.queryScheduler;
		return this._execFn(fninfo, params);
	}

	/**
	 *	일정을 저장한다.
	 *	@param	{Object} formObj 호출하는 객체 (일반적으로 this)
	 *	@param	{JSON} options 저장할 데이터
		{
			_id : 일정 아이디
			calendar_id : 일정이 포함된 캘린더 아이디
			description : 설명
			dtstart : 일정 시작일자
			dtend :일정 종료일자
			title : 일정 제목
			duration : RFC2445 형태를 가지는 지속 시간
			eventLocation : 장소
			eventStatus : 일정 상태 
			exdate : 반복 일정일 경우 제외 일자
			exrule :반복 일정일 경우 제외 규칙
			guestsCanInviteOthers : 다른 사용자가 참석자를 추가할 수 있는지 여부
			guestsCanModify : 다른 사용자가 일정 수정이 가능한지 여부
			guestsCanSeeGuests : 다른 사용자가 일정 참석자 목록을 볼수 있는지 여부
			hasAlarm : 알람 설정 여부
			hasAttendeeData : 일정이 참석자 목록을 가지고 있는지 여부
			hasExtendedProperties : 확장된 속성을 가지고 있는지 여부
			lastDate : 일정이 반복된 마지막 일자
			organizer : 일정 소유작의 이메일
			rdate : 반복되는 일정의 일자
			rrule : 반복되는 일정의 규칙
			allDay : 온종일 일정인지 여부
		}
	 *	@param	{String} dateFormat 날짜 포맷 (기본 값 : yyyyMMddHHmmss)
	 *	@param	{String}  callback 실행결과를 리턴받을 콜백함수 
	 */
	_pFSPMobile.saveScheduler = function ( scheduleObj, dateFormat)
	{
		if ( !dateFormat ){
			dateFormat = "yyyyMMddHHmmss";
		}
		
		var options = {
			dateFormat : dateFormat
		}
		
		//_pFSPMobile.execute( "scheduler", "save", [scheduleObj, options]);
		var args = [scheduleObj, options];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.saveScheduler;
		return this._execFn(fninfo, params);
	}

	// -------------------------------- fsp.mobile.h.network
	/**
	 *	디바이스의 네트워크 연결상태를 가져온다.
	 *	@param	{Object} formObj 호출하는 객체 (일반적으로 this)
	 *	@param	{int} type 네트워크 타입 ( 0 : 3g, 1 : wifi, 2 : 연결 안됨)
	 *	@param	{String}  callback 실행결과를 리턴받을 콜백함수 
	 *	@return	네트워크 연결 여부
	 */
	_pFSPMobile.getNetworkStatus = function ( type)
	{
		_pFSPMobile.execute( "network", "getNetworkStatus", [type]);
	}
	/**
	 *	디바이스의 네트워크 연결상태를 변경한다.
	 *	@param	{Object} formObj 호출하는 객체 (일반적으로 this)
	 *	@param	{int} type 네트워크 타입
	 *	@param	{bool} status 연결상태 ( true, false)
	 *	@param	{String}  callback 실행결과를 리턴받을 콜백함수 
	 *	@return	성공 여부
	 */
	_pFSPMobile.setNetworkStatus = function ( type, status)
	{
		//_pFSPMobile.execute( "network", "setNetworkStatus", [type, status]);
		var args = [type, status];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.setNetworkStatus;
		return this._execFn(fninfo, params);
	}
	/**
	 *	디바이스의 네트워크 연결상태를 가져온다.
	 *	@param	{Object} formObj 호출하는 객체 (일반적으로 this)
	 *	@param	{String}  callback 실행결과를 리턴받을 콜백함수 
	 *	@return	네트워크 연결 여부.
	 */
	_pFSPMobile.isNetworkStatus = function ()
	{
		//_pFSPMobile.execute( "network", "isNetworkStatus", []);
		var args = [];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.isNetworkStatus;
		return this._execFn(fninfo, params);
	}

	// -------------------------------- fsp.mobile.h.nfc 
	/**
	 *	현재 NFC가 사용 가능 상태인지를 확인한다. (안드로이드만 지원)
	 *	@param	{Object} formObj 호출하는 객체 (일반적으로 this)
	 *	@param	{String}  callback 실행결과를 리턴받을 콜백함수 
	 *	@return	처리 성공 여부
	 */
	_pFSPMobile.isNfcUse = function ()
	{
		//_pFSPMobile.execute( "nfc", "isUse", []);
		var args = [];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.isNfcUse;
		return this._execFn(fninfo, params);
	}
	/**
	 *	NFC를 시작한다. (안드로이드만 지원)
	 *	@param	{Object} formObj 호출하는 객체 (일반적으로 this)
	 *	@param	{String}  callback 실행결과를 리턴받을 콜백함수 
	 *	@return	NFC 데이터 JSON 객체
	 */
	_pFSPMobile.nfcStart = function ()
	{
		//_pFSPMobile.execute( "nfc", "start", []);
		var args = [];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.nfcStart;
		return this._execFn(fninfo, params);
	}
	/**
	 *	NFC를 중지한다. (안드로이드만 지원)
	 *	@param	{Object} formObj 호출하는 객체 (일반적으로 this)
	 *	@param	{String}  callback 실행결과를 리턴받을 콜백함수 
	 *	@return	처리 성공 여부
	 */
	_pFSPMobile.nfcStop = function ()
	{
		//_pFSPMobile.execute( "nfc", "stop", []);
		var args = [];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.nfcStop;
		return this._execFn(fninfo, params);
	}

	// -------------------------------- fsp.mobile.h.sensor 
	/**
	 *	센서를 활성화 시킨다. 
	 *	@param	{Object} formObj 호출하는 객체 (일반적으로 this)
	 *	@param	{Array} sensorType 정보를 가져올 센서 타입
	 *	@param	{String}  callback 실행결과를 리턴받을 콜백함수 
	 *	@return	센서에서 취득한 정보 JSON 객체
	 */
	_pFSPMobile.sensorStart = function ( sensorType)
	{
		//_pFSPMobile.execute( "sensor", "start", [sensorType]);
		var args = [sensorType];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.sensorStart;
		return this._execFn(fninfo, params);
	}
	/**
	 *	센서를 비활성화 시킨다.
	 *	@param	{Object} formObj 호출하는 객체 (일반적으로 this)
	 *	@param	{String}  callback 실행결과를 리턴받을 콜백함수 
	 *	@return	처리 성공 여부
	 */
	_pFSPMobile.sensorStop = function ()
	{
		_pFSPMobile.execute( "sensor", "stop", []);
		var args = [];
		var params = {} ;
		params.options = args;
		var fninfo = this._reasoncode.sensorStop;
		return this._execFn(fninfo, params);
	}

	
	_pFSPMobile._getJSONStr = function(_obj, _param)
	{
		var _id = this._id;
		var _clsnm = this._clsnm[_obj.ifcls];
		var _fnnm = _obj.fn;
		_param.reason = _obj.code;
		_param.apiName = _obj.apiName;
		_param.methodName = _obj.methodName;
		var value = {};
		value.id = _id;
		value.div = _clsnm;
		value.method = _fnnm;
		value.params = _param;
		
		//return "";
		
		//if(JSON) alert("json");
		return 	JSON.stringify(value);
	}
	
	_pFSPMobile._execFn = function(_obj, _param)
	{
		//alert("xx");
	    if(nexacro.Device.curDevice == 0) {
	        var jsonstr = this._getJSONStr(_obj, _param);
			this._log(jsonstr);
	        nexacro.Device.exec(jsonstr);
	    }else{
	        var jsonstr = this._getJSONStr(_obj, _param);
			this._log(jsonstr);
	        nexacro.Device.exec(jsonstr);
	    }
		return true;
	}
	_pFSPMobile._log = function(arg)
	{
		//return;
		// trace(arg);
		if(trace) {
			trace(arg);
		} else if(console) {
			console.log(arg);
		} 
	}


	
	//===================EVENT=========================//
	_pFSPMobile._onsuccess = function(objData) {
		var e = new nexacro.Event.FSPMobileEventInfo("onsuccess", objData.reason, objData.returnvalue);
		this.$fire_onsuccess(this, e);
	};
	_pFSPMobile.$fire_onsuccess = function (objFSPMobile, eFSPMobileEventInfo) {
		if (this.onsuccess && this.onsuccess._has_handlers) {
			return this.onsuccess._fireEvent(this, eFSPMobileEventInfo);
		}
		return true;
	};

	_pFSPMobile._onerror = function(objData) {
		var e = new nexacro.Event.FSPMobileErrorEventInfo("onerror", objData.reason, objData.errorcode, objData.errormsg);
		this.$fire_onerror(this, e);
	};
	_pFSPMobile.$fire_onerror = function (objFSPMobile, eFSPMobileErrorEventInfo) {
		if (this.onerror && this.onerror._has_handlers) {
			return this.onerror._fireEvent(this, eFSPMobileErrorEventInfo);
		}
		return true;
	};
	//trace(_pFSPMobile);
	delete _pFSPMobile;
}



