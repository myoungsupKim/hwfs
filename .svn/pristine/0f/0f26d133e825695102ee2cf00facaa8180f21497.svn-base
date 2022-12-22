
//==============================================================================
//LGUtils
//==============================================================================

//==============================================================================
//nexacro.Event.LGUtilsEventInfo
//LGUtils에 요청된 작업이 성공했을 때 발생되는 이벤트에서 사용되는 EventInfo Object
//==============================================================================

if (!nexacro.Event.LGUtilsEventInfo) {
	nexacro.Event.LGUtilsEventInfo = function (strEventId, intReason, strReturnValue) {
		this.eventid = strEventId;												// 이벤트ID
		this.reason = intReason;												// 이벤트 발생분류 코드
		this.returnvalue = strReturnValue;										// 이벤트 수행결과 (type:Variant)
	}
	_pLGUtilsEventInfo = nexacro.Event.LGUtilsEventInfo.prototype = nexacro._createPrototype(nexacro.Event);
	_pLGUtilsEventInfo._type = "nexacroLGUtilsEventInfo";
	_pLGUtilsEventInfo._type_name = "LGUtilsEventInfo";
	_pLGUtilsEventInfo = null;
}

//==============================================================================
//nexacro.Event.LGUtilsErrorEventInfo
//LGUtils에 요청된 작업이 실패했을 때 발생되는 이벤트에서 사용되는 EventInfo Object
//==============================================================================
if (!nexacro.Event.LGUtilsErrorEventInfo) {
	nexacro.Event.LGUtilsErrorEventInfo = function (strEventId, intReason, intErrorCode, strErrorMsg) {
		this.eventid = strEventId;												// 이벤트ID
		this.reason = intReason;
		this.errorcode = intErrorCode;
		this.errormsg = strErrorMsg;

	}
	_pLGUtilsErrorEventInfo = nexacro.Event.LGUtilsErrorEventInfo.prototype = nexacro._createPrototype(nexacro.Event);
	_pLGUtilsErrorEventInfo._type = "nexacroLGUtilsErrorEventInfo";
	_pLGUtilsErrorEventInfo._type_name = "LGUtilsErrorEventInfo";
	_pLGUtilsErrorEventInfo = null;
}

//==============================================================================
//nexacro.LGUtils
//LGUtils를 연동하기 위해 사용한다.
//==============================================================================
if (!nexacro.LGUtils) {
	nexacro.LGUtils = function(name, obj) {
		
		this._id = nexacro.Device.makeID();
		nexacro.Device._userCreatedObj[this._id] = this;
		this.name = name || "";

		this.enableevent = true;

		this.timeout = 10;

		this._clsnm = ["LGUtilsPlugin"];
		this._reasoncode = {
			constructor : {code: -2, ifcls: 0, fn: "constructor"},
			destroy : {code: -1, ifcls: 0, fn: "destroy"},
			LGE_b64enceuc : {code: 0, ifcls: 0, fn: "LGE_b64enceuc"},
			LGE_b64deceuc : {code: 1, ifcls: 0, fn: "LGE_b64deceuc"},
			LGE_btBondedList : {code: 2, ifcls: 0,  fn: "LGE_btBondedList"},
			LGE_toast : {code: 3, ifcls: 0,  fn: "LGE_toast"},
			LGE_execProc : {code: 4,  ifcls: 0, fn: "LGE_execProc"},
			LGE_isFileExist : {code: 5,  ifcls: 0, fn: "LGE_isFileExist"},
			LGE_touch : {code: 6,  ifcls: 0, fn: "LGE_touch"},
			LGE_scanMedia : {code: 7,  ifcls: 0, fn: "LGE_scanMedia"},
			LGE_resample : {code: 8,  ifcls: 0, fn: "LGE_resample"},
			LGE_reverseImage : {code: 9,  ifcls: 0, fn: "LGE_reverseImage"},
			LGE_enableBT : {code: 10,  ifcls: 0, fn: "LGE_enableBT"},
			LGE_disableBT : {code: 11,  ifcls: 0, fn: "LGE_disableBT"},
			LGE_decompGzip : {code: 12,  ifcls: 0, fn: "LGE_decompGzip"},
			LGE_isInstalled : {code: 13,  ifcls: 0, fn: "LGE_isInstalled"},
			LGE_pkgVersion : {code: 14,  ifcls: 0, fn: "LGE_pkgVersion"},
			LGE_openURL : {code: 15,  ifcls: 0, fn: "LGE_openURL"},
			LGE_openSign : {code: 16,  ifcls: 0, fn: "LGE_openSign"},
			LGE_ONSIGN : {code: 17, ifcls: 0,  fn: ""},

		};



		this._usererrcode = {
			INVALID_IMAGE : {errcode : -25, errmsg : "Invalid image or image load failed."},
			INVALID_ARGUMENT : {errcode : -27, errmsg : "Invalid argument."}
		};

		
		this._event_list = {
            "onsuccess": 1, "onerror": 1, "onsign": 1,
        };

		// event
		this.onsuccess = null;//new nexacro.EventListener("onsuccess");					// 요청한 작업이 성공했을 때 발생하는 이벤트
		this.onerror = null;//new nexacro.EventListener("onerror");						// 요청한 작업이 실패했을 때 발생하는 이벤트

		// native constructor
		
		var params = {} ;
		var fninfo = this._reasoncode.constructor;
		this._execFn(fninfo, params);
	};
/*

    var _pAsyncUltraLiteStatement = nexacro.AsyncUltraLiteStatement.prototype = nexacro._createPrototype(nexacro.EventSinkObject);
    _pAsyncUltraLiteStatement._type = "nexacroAsyncUltraLiteStatement";
    _pAsyncUltraLiteStatement._type_name = "AsyncUltraLiteStatement";

*/

	
	
	var _pLGUtils = nexacro.LGUtils.prototype = nexacro._createPrototype(nexacro.EventSinkObject);
	
	_pLGUtils._type = "nexacroLGUtils";
	_pLGUtils._type_name = "LGUtils";

	_pLGUtils.destroy = function(){
		var params = {};
		var jsonstr;

		delete nexacro.Device._userCreatedObj[this._id];
		
		
		var fninfo = this._reasoncode.destroy;
		this._execFn(fninfo, params);
		return true;
	};

	_pLGUtils.LGE_b64enceuc = function( strinput)
	{
		var fninfo = this._reasoncode.LGE_b64enceuc;
		var params = {};
		params.arg0 =  strinput;
		//params.img =  img;

		this._execFn(fninfo, params);
	};
	_pLGUtils.LGE_b64deceuc = function( strinput)
	{
		var fninfo = this._reasoncode.LGE_b64deceuc;
		var params = {};
		params.arg0 =  strinput;
		//params.img =  img;

		this._execFn(fninfo, params);
	};
	_pLGUtils.LGE_btBondedList= function()
	{
		var fninfo = this._reasoncode.LGE_btBondedList;
		var params = {};
		//params.arg0 =  strinput;
		//params.img =  img;

		this._execFn(fninfo, params);
	};
	_pLGUtils.LGE_toast = function( str)
	{
		var fninfo = this._reasoncode.LGE_toast;
		var params = {};
		params.arg0 =  str;
		//params.img =  img;

		this._execFn(fninfo, params);
	};
	_pLGUtils.LGE_execProc = function  (arg0, arg1, arg2, arg3, arg4)
	{
		var fninfo = this._reasoncode.LGE_execProc;
		var params = {};
		params.arg0 =  arg0;
		params.arg1 =  arg1;
		params.arg2 =  arg2;
		params.arg3 =  arg3;
		params.arg4 =  arg4;

		//params.img =  img;

		this._execFn(fninfo, params);
	};
	_pLGUtils.LGE_isFileExist = function( str)
	{
		var fninfo = this._reasoncode.LGE_isFileExist;
		var params = {};
		params.arg0 =  str;
		//params.img =  img;

		this._execFn(fninfo, params);
	};
	_pLGUtils.LGE_touch = function( fname)
	{
		var fninfo = this._reasoncode.LGE_touch;
		var params = {};
		params.arg0 =  fname;
		//params.img =  img;

		this._execFn(fninfo, params);
	};
	
	_pLGUtils.LGE_scanMedia = function( path)
	{
		var fninfo = this._reasoncode.LGE_scanMedia;
		var params = {};
		params.arg0 =  path;
		//params.img =  img;

		this._execFn(fninfo, params);
	};
	
	_pLGUtils.LGE_resample = function(data, width, height, dept)
	{
		var fninfo = this._reasoncode.LGE_resample;
		var params = {};
		params.arg0 =  data;
		params.arg1 =  width;
		params.arg2 =  height;
		params.arg3 =  dept;

		//params.img =  img;

		this._execFn(fninfo, params);
	};
	
	_pLGUtils.LGE_reverseImage = function( img)
	{
		var fninfo = this._reasoncode.LGE_reverseImage;
		var params = {};
		params.arg0 =  img;


		//params.img =  img;

		this._execFn(fninfo, params);
	};
	
	_pLGUtils.LGE_enableBT = function()
	{
		var fninfo = this._reasoncode.LGE_enableBT;
		var params = {};
		//params.arg0 =  img;

		this._execFn(fninfo, params);
	};
	
	_pLGUtils.LGE_disableBT = function()
	{
		var fninfo = this._reasoncode.LGE_disableBT;
		var params = {};
		//params.arg0 =  img;

		this._execFn(fninfo, params);
	};
	
	_pLGUtils.LGE_decompGzip = function( inpath,  outpath)
	{
		var fninfo = this._reasoncode.LGE_disableBT;
		var params = {};
		params.arg0 =  inpath;
		params.arg1 =  outpath;
		this._execFn(fninfo, params);
	};
	
	_pLGUtils.LGE_isInstalled = function( pkgname)
	{
		var fninfo = this._reasoncode.LGE_isInstalled;
		var params = {};
		params.arg0 =  pkgname;

		this._execFn(fninfo, params);
	};
	
	_pLGUtils.LGE_pkgVersion = function( pkgname)
	{
		var fninfo = this._reasoncode.LGE_pkgVersion;
		var params = {};
		params.arg0 =  pkgname;

		this._execFn(fninfo, params);
	};
	
	
	_pLGUtils.LGE_openURL = function( arg0, arg1)
	{
		var fninfo = this._reasoncode.LGE_openURL;
		var params = {};
		params.arg0 =  arg0;
		params.arg1 =  arg1;
		this._execFn(fninfo, params);
	};
	_pLGUtils.LGE_openSign = function()
	{
		var fninfo = this._reasoncode.LGE_openSign;
		var params = {};
//		params.arg0 =  arg0;
//		params.arg1 =  arg1;
		this._execFn(fninfo, params);
	};	
	
/*
	_pLGUtils._dirtyclone = function(obj) {
		var ret = [];
		for(var i = 0; i < obj.length; i++)
		{
			var val = obj[i];
			if(typeof(val) == 'object'){
				//this._log(val.data);
				var dval  = nexacro.Device.encodeString(val.data);
				//this._log(dval);
				var encval = this._getDefVal(val.enc, 0, 1, 0);


				ret.push({enc: encval, data: dval});
			} else {
				ret.push(val);

			}
		}
		return ret;
	};
	

	_pLGUtils._isnullor0len = function(arg){
		if(arg == null || arg.length == 0) return true;
		return false;
	};
	
	_pLGUtils._getDefVal = function(arg, min, max, defval)
	{
		var rtn = isNaN(arg);
		var value = parseInt(arg);
		if(min == null)
		{
			if( max == null)
			{
				return defval;
			} else {
				if(rtn == true || value > max) return defval;
			}
		} else {

			if( max == null)
			{
				if(rtn == true || value < min) return defval;
			} else {

				if(rtn == true || ( value < min || value > max)) return defval;

			}
		}

		return value;
	};
*/
	_pLGUtils._getJSONStr = function(_obj, _param)
	{
		var _id = this._id;
		var _clsnm = this._clsnm[_obj.ifcls];
		var _fnnm = _obj.fn;
		_param.reason = _obj.code;
		var value = {};
		value.id = _id;
		value.div = _clsnm;
		value.method = _fnnm;
		value.params = _param;
		//return "";
		
		//if(JSON) alert("json");
		return 	JSON.stringify(value);
	}
	
	_pLGUtils._execFn = function(_obj, _param)
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
	}
	_pLGUtils._log = function(arg)
	{
		//return;
		// trace(arg);
		if(trace) {
			trace(arg);
		} 
	}


	
	//===================EVENT=========================//
	_pLGUtils._onsuccess = function(objData) {
		var e = new nexacro.Event.LGUtilsEventInfo("onsuccess", objData.reason, objData.returnvalue);
		this.$fire_onsuccess(this, e);
	};
	_pLGUtils.$fire_onsuccess = function (objLGUtils, eLGUtilsEventInfo) {
		if (this.onsuccess && this.onsuccess._has_handlers) {
			return this.onsuccess._fireEvent(this, eLGUtilsEventInfo);
		}
		return true;
	};

	_pLGUtils._onerror = function(objData) {
		var e = new nexacro.Event.LGUtilsErrorEventInfo("onerror", objData.reason, objData.errorcode, objData.errormsg);
		this.$fire_onerror(this, e);
	};
	_pLGUtils.$fire_onerror = function (objLGUtils, eLGUtilsErrorEventInfo) {
		if (this.onerror && this.onerror._has_handlers) {
			return this.onerror._fireEvent(this, eLGUtilsErrorEventInfo);
		}
		return true;
	};
	
	
	_pLGUtils._onsign = function(objData) {
		var reason = this._reasoncode.LGE_ONSIGN.code;
		var e = new nexacro.Event.LGUtilsEventInfo("onsign", reason, objData.returnvalue);
		this.$fire_onsign(this, e);
	};
	_pLGUtils.$fire_onsign = function (objLGUtils, eLGUtilsEventInfo) {
		if (this.onsign && this.onsign._has_handlers) {
			return this.onsign._fireEvent(this, eLGUtilsEventInfo);
		}
		return true;
	};
	
	//trace(_pLGUtils);
	delete _pLGUtils;
}



