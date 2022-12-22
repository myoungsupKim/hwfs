﻿//XJS=lib_String.xjs
(function()
{
    return function(path)
    {
        var obj;
    
        // User Script
        this.registerScript(path, function(exports) {
        /*
         ===============================================================================
         == 문자관련 공통함수들은 여기에 작성한다.
         ===============================================================================/
         ● gfn_Right     : 문자열의 오른쪽부분을 지정한 길이만큼 Return 한다.
         ● gfn_Left      : 문자열의 왼쪽부분을 지정한 길이만큼 Return 한다.
         ● gfn_StripBlank : 문자열 중 "=" 좌우의 빈공백을 제거하는 함수
         
         ● gfn_Trim      : 입력된 문자열의 좌우측 공백을 제거한 문자열을 구함.
         ● gfn_Ltrim     : 입력된 문자열의 왼쪽 공백을 제거한 문자열을 구함.
         ● gfn_Rtrim     : 입력된 문자열의 오른쪽 공백을 제거한 문자열을 구함.
         
         ● gfn_Length    : 입력값 형태에 따라서 길이 또는 범위를 구하는 함수
         ● gfn_LengthB   : 문자열 길이 반환(byte 기준)
         ● gfn_Replace   : 입력된 문자열의 일부분을 다른 문자열로 치환하는 함수
         
         ● gfn_IndexOf   : 입력된 문자열에서 찾는 문자열의 처음 나오는 문자 위치를 반환
         ● gfn_pos       : 문자열의 위치를 대소문자 구별하여 찾는다
         ● gfn_CharAt    : 지정한 인덱스에 해당하는 문자를 반환
         ● gfn_LPad      : 문자열이 지정된 길이가 되도록 왼쪽을 채움
         ● gfn_RPad      : 문자열이 지정된 길이가 되도록 오른쪽을 채움
         
         ● gfn_Split     : 문자열을 지정한 형태로 Parsing 한 후 배열로 만드는 함수
         ● gfn_ToFixed   : 소수점 자리수 지정 함수
         ● gfn_NumFormat : 입력된 실수를 문자열 표현법으로 표현하는 함수
         
         ● gfn_Quote     : 입력된 문자열의 양쪽에 쌍따옴표를 붙여 반환합니다.
         ● gfn_subStr    : 지정한 위치에서 시작하고 지정한 길이를 갖는 부분 문자열을 반환하는 함수
         ● gfn_subStrB   : 맨 마지막 문자열 제거
         ● gfn_transNullToEmpty : gfn_IsNull() 일 경우 ""을 리턴한다.
         ● gfn_Nvl       : Null값을 대체 값으로 변환
         ● gfn_split     : 특정 문자열을 기준으로 전체 문자열을 나누어서 하나의 배열(Array)로 만들어 반납하는 함수
         
         ● gfn_right     : 문자열의 오른쪽부분을 지정한 길이만큼 Return
         ● gfn_toString  : 입력값을 String으로 변경
         ● NumFormat     : 입력된 실수를 문자열 표현법으로 표현하는 함수
         ● ToUpper       : 문자열에 있는 모든 영어를 대문자로 바꾸는 Basic API
         ● iif           : 조건식이 true일 경우 trueVal, false일경우 falseVal를 반환한다.
         
         ● fn_Sign       : 넘어온 값의 양/음 판단
         ● GetRowType    : 로우타입
         ● fn_AlertMsg   : 메세지 공통
         ● gfn_isEmail   : 입력값이 e-mail Type인지 체크하는 함수
         */

        /**********************************************************************************
         * 함수명     : gfn_Right
         * 설명       : 문자열의 오른쪽부분을 지정한 길이만큼 Return 한다.
         * argument    : strString (오른부분을 얻어올 원본 문자열)
         *                     nSize (얻어올 크기. [Default Value = 0])
         * return Type : String
         * return 내용  : 오른쪽 부분이 얻어진 문자열.
         **********************************************************************************/
        this.gfn_Right = function (strString,nSize)
        { 
        	var nStart = String(strString).length;
        	var nEnd = Number(nStart) - Number(nSize);
        	var rtnVal = strString.substring(nStart, nEnd);

        	return rtnVal;
        }

        /**********************************************************************************
         * 함수명        : gfn_Left
         * 설명           : 문자열의 왼쪽부분을 지정한 길이만큼 Return 한다.
         * argument    : strString (외쪽부분을 얻어올 원본 문자열)
         *                     nSize (얻어올 크기. [Default Value = 0])
         * return Type : String
         * return 내용  : 오른쪽 부분이 얻어진 문자열.
         **********************************************************************************/
        this.gfn_Left = function (strString,nSize)
        {
        	if (application.gfn_IsNull(strString)) 
        	{
        		return "";
        	}

        	var rtnVal = "";
        	if (nSize > String(strString).length || nSize == null) 
        	{
        		rtnVal = strString;
        	}
        	else 
        	{
        		rtnVal = strString.substring(0, nSize);
        	}

        	return rtnVal;
        }

        /******************************************************************************
         * 함수명        : gfn_StripBlank(strArg)
         * 설명          : 문자열 중 "=" 좌우의 빈공백을 제거하는 함수
         ※ gfn_Transaction 에서 사용
         * argument       : strArg    문자열
         * return         : "=" 좌우의 빈공백 제거된 문자열
         * gfn_StripBlank("a = \" b = d \" c='1'  d = \"b = d\" e =  " + wrapQuote("qqqqqq\"eeeee=eeee\"ffffffff"))
         * a=" b = d " c='1'  d="b = d" e="qqqqqq\"eeeee=eeee\"ffffffff"
         ******************************************************************************/
        this.gfn_StripBlank = function (strArg)
        {
        	var nChrPos;
        	var strLeft;
        	var strRight = strArg;
        	var strChr;
        	var retVal = "";

        	if (application.gfn_IsNull(strArg)) 
        	{
        		return "";
        	}

        	while (true) 
        	{
        		nChrPos = strRight.indexOf("=");
        		if (nChrPos == -1) 
        		{
        			retVal += strRight;
        			break;
        		}

        		strLeft = strRight.substr(0, nChrPos).trimRight();
        		strRight = strRight.substr(nChrPos + 1).trimLeft();
        		strChr = strRight.charAt(0);

        		retVal += strLeft + "=";
        		if (strChr != "\"" && strChr != "'") 
        		{
        			strChr = " ";
        		}

        		nChrPos = strRight.indexOf(strChr, 1);
        		if (nChrPos > -1) 
        		{
        			retVal += strRight.slice(0, nChrPos + 1);
        			strRight = strRight.substr(nChrPos + 1);
        		}
        		else 
        		{
        			retVal += strRight;
        			strRight = "";
        		}
        	}

        	return retVal;
        }

        /******************************************************************************
         * 함수명        : gfn_Trim()
         * 설명          : 입력된 문자열의 좌우측 공백을 제거한 문자열을 구함.
         * argument       : arg(좌우측 공백문자를 제거하려는 문자열)
         * return         : 입력된 문자열에서 좌우측 공백이 제거된 문자열
         * gfn_Trim("   a   ");
         ******************************************************************************/
        this.gfn_Trim = function (arg)
        {
        	if (application.gfn_IsNull(arg)) 
        	{
        		return "";
        	}

        	var sArg = arg.toString();
        	return sArg.split(/(^\s*)|(\s*$)/g).join("");
        }

        /******************************************************************************
         * 함수명        : gfn_Ltrim()
         * 설명          : 입력된 문자열의 왼쪽 공백을 제거한 문자열을 구함.
         * argument       : 왼쪽 공백문자를 제거하려는 문자열
         * return         : 입력된 문자열에서 왼쪽 공백이 제거된 문자열
         * gfn_Ltrim("   a   ");
         ******************************************************************************/
        this.gfn_Ltrim = function (arg)
        {
        	if (application.gfn_IsNull(arg)) 
        	{
        		return "";
        	}

        	var sArg = arg.toString();
        	return sArg.split(/(^\s*)/).join("");
        }

        /******************************************************************************
         * 함수명        : gfn_Rtrim()
         * 설명          : 입력된 문자열의 오른쪽 공백을 제거한 문자열을 구함.
         * argument       : 오른쪽 공백문자를 제거하려는 문자열
         * return         : 입력된 문자열에서 오른쪽 공백이 제거된 문자열
         * gfn_Rtrim("   a   ");
         ******************************************************************************/
        this.gfn_Rtrim = function (arg)
        {
        	if (application.gfn_IsNull(arg)) 
        	{
        		return "";
        	}

        	var sArg = arg.toString();
        	return sArg.split(/(\s*$)/).join("");
        }

        /******************************************************************************
         * 함수명        : gfn_Length()
         * 설명          : 입력값 형태에 따라서 길이 또는 범위를 구하는 함수
         * argument       : 객체, 문자열, 배열
         * return         : Type에 따라 구해진 길이 또는 범위
         * gfn_Length("123")
         ******************************************************************************/
        this.gfn_Length = function (sValue)
        {
        	if(this.gfn_isNull(sValue)) return 0;
         
         	if ( typeof(sValue) == "object" ) 
         	{
        		var rtnVal = 0;
        		
        		// Container
        		if(sValue.components)
        		{
        			rtnVal = sValue.components.length;
        		}
        		// 배열일 경우
        		else if(sValue.constructor == Array) {
        			rtnVal = sValue.length;
        		}
        		// 캘린더 등
        		else {
        			rtnVal = String(sValue).length;
        		}
        		
        		return rtnVal;
         	} 
         	else {
        		return sValue.toString().length;//string, number인 경우
         	}
        }

        /*********************************************************************************************
         * ★ Function명 : gfn_LengthB
         * ★ 설명       : 문자열 길이 반환.
         * ★ Params     :  1. sValue -
         * ★ Return     : length
         *********************************************************************************************/
        this.gfn_LengthB = function (sValue)
        {
        	if (application.gfn_IsNull(sValue)) 
        	{
        		return 0;
        	}

        	var v_ChkStr = sValue.toString();
        	var v_cnt = 0;

        	for (var i = 0; i < v_ChkStr.length; i++) 
        	{
        		if (v_ChkStr.charCodeAt(i) > 127) 
        		{
        			v_cnt += 2;
        		}
        		else 
        		{
        			v_cnt += 1;
        		}
        	}

        	return v_cnt;
        }

        /******************************************************************************
         * 함수명        : gfn_Replace()
         * 설명          : 입력된 문자열의 일부분을 다른 문자열로 치환하는 함수
         * argument       : strString 원본 문자열.
         *                  strOld    원본 문자열에서 찾을 문자열.
         *                  strNew    새로 바꿀 문자열.
         * return         : 대체된 문자열
         * gfn_Replace("abc", "b", "*")
         *  - coolmind 2011.12.13 :  Ajax에서 정규식을 사용하지 않으면 처음찾은 문자열만 변경한다고 주의사항에 가이드 되어 있음
         *                           해당하는 문자열을 모두 변경하려면 이 함수를 사용하지 말아야함, 전부 변경할 수 있도록 함수 수정 필요
         ******************************************************************************/
        this.gfn_Replace = function ()
        {
        	var varRtnValue = null;
        	var arrArgument = this.gfn_Replace.arguments;

        	if (arrArgument.length < 3) 
        	{
        		varRtnValue = arrArgument[0];
        	}
        	else 
        	{
        		if (application.gfn_IsEmpty(arrArgument[0])) 
        		{
        			return varRtnValue;
        		}
        		varRtnValue = arrArgument[0].toString().replace(arrArgument[1], arrArgument[2]);
        	}

        	return varRtnValue;
        }

        /******************************************************************************
         * 함수명        : gfn_IndexOf()
         * 설명          : 입력된 문자열에서 찾는 문자열의 처음 나오는 문자 위치를 반환
         * argument       : strString 원본 문자열.
         *                  strOld    원본 문자열에서 찾을 문자열.
         * return         : 문자열에서 찾은 위치
         * gfn_IndexOf("abc", "b")
         ******************************************************************************/
        this.gfn_IndexOf = function ()
        {
        	var varRtnValue = null;
        	var arrArgument = this.gfn_IndexOf.arguments;

        	if (arrArgument.length < 2) 
        	{
        		varRtnValue = -1;
        	}
        	else 
        	{
        		var nOffset = 0;
        		if (application.gfn_IsEmpty(arrArgument[0]) || application.gfn_IsEmpty(arrArgument[1])) 
        		{
        			return varRtnValue;
        		}

        		if (!application.gfn_IsEmpty(arrArgument[2])) 
        		{
        			nOffset = parseInt(arrArgument[2], 10);
        		}
        		varRtnValue = arrArgument[0].toString().indexOf(arrArgument[1], nOffset);
        	}

        	return varRtnValue;
        }

        /*********************************************************************************************
         * ★ Function명 : gfn_pos()
         * ★ 설명       : 문자열의 위치를 대소문자 구별하여 찾는다
         * ★ Params      : 1. sOrg - 원래 문자열( 예 : "aaBBbbcc" )
         2. sFind - 찾고자 하는 문자열( 예 : "bb" )
         3. nStart - 검색 시작위치 (옵션 : Default=0) ( 예 : 1 )
         * ★ Return      : - 성공 = 찾고자 하는 문자열의 시작위치 ( 예 : 4 )
         - 실패 = -1
         *********************************************************************************************/
        this.gfn_pos = function (sOrg,sFind,nStart)
        {
        	if (application.gfn_IsNull(sOrg)) 
        	{
        		return -1;
        	}
        	if (application.gfn_IsNull(sFind)) 
        	{
        		return -1;
        	}

        	if (application.gfn_IsNull(nStart)) 
        	{
        		nStart = 0;
        	}

        	return sOrg.indexOf(sFind, nStart);
        }

        /******************************************************************************
         * 함수명        : gfn_CharAt()
         * 설명          : 지정한 인덱스에 해당하는 문자를 반환
         * argument       : strString 원본 문자열.
         *                  nIndex    원본 문자열에서 찾을 문자열.
         * return         : 문자 반환
         * gfn_CharAt("abc", nIndex)
         ******************************************************************************/
        this.gfn_CharAt = function ()
        {
        	var varRtnValue = null;
        	var arrArgument = this.gfn_CharAt.arguments;

        	if (arrArgument.length < 2) 
        	{
        		varRtnValue = "";
        	}
        	else 
        	{
        		var nIndex = parseInt(arrArgument[1], 10);
        		varRtnValue = arrArgument[0].toString().charAt(nIndex);
        	}

        	return varRtnValue;
        }

        /******************************************************************************
         * 함수명        : gfn_LPad()
         * 설명          : 문자열이 지정된 길이가 되도록 왼쪽을 채움
         * argument       : strString  원본 문자열.
         *                  strPadChar 원본 문자열에 왼쪽에 채울 문자열.
         nCount     문자열을 채워서 만들어지는 문자열의 길이
         * return         : 문자 반환
         ******************************************************************************/
        this.gfn_LPad = function (strString,strPadChar,nCount)
        {
        	var rtnStr = "";
        	nCount = parseInt(nCount, 10);

        	if (this.gfn_Length(strString) < nCount) 
        	{
        		var tmpStrPad = "";
        		var cnt = nCount - this.gfn_Length(strString);
        		for (var i = 0; i < cnt; i++) 
        		{
        			tmpStrPad += strPadChar;
        		}

        		rtnStr = tmpStrPad + strString;
        	}
        	else 
        	{
        		rtnStr = strString;
        	}

        	return rtnStr;
        }

        /******************************************************************************
         * 함수명        : gfn_RPad()
         * 설명          : 문자열이 지정된 길이가 되도록 오른쪽을 채움
         * argument       : strString  원본 문자열.
         *                  strPadChar 원본 문자열에 오른쪽에 채울 문자열.
         nCount     문자열을 채워서 만들어지는 문자열의 길이
         * return         : 문자 반환
         ******************************************************************************/
        this.gfn_RPad = function (strString,strPadChar,nCount)
        {
        	var rtnStr = "";
        	nCount = parseInt(nCount, 10);
        	if (strString.length < nCount) 
        	{
        		var tmpStrPad = "";
        		var cnt = nCount - strString.length;
        		for (var i = 0; i < cnt; i++) 
        		{
        			tmpStrPad += strPadChar;
        		}

        		rtnStr = strString + tmpStrPad;
        	}
        	else 
        	{
        		rtnStr = strString;
        	}

        	return rtnStr;
        }

        /******************************************************************************
         * 함수명        : gfn_Split(strString,strDelimiter);
         * 설명          : 문자열을 지정한 형태로 Parsing 한 후 배열로 만드는 함수
         * argument       : strString    Parsing 해야될 문자열.
         *                  strDelimiter Parsing 할 때 분리의 기준이 되는 문자들의 문자열.
         * return         : Split 처리결과의 문자열 배열
         * gfn_Split(("aa::bb::cc::dd", "::")
         ******************************************************************************/
        this.gfn_Split = function ()
        {
        	var rtnArr = new Array();
        	var arrArgument = this.gfn_Split.arguments;

        	if (arrArgument.length < 1) 
        	{
        	}
        	else if (arrArgument.length < 2) 
        	{
        		if (!application.gfn_IsEmpty(arrArgument[0])) 
        		{
        			rtnArr[0] = arrArgument[0];
        		}
        	}
        	else 
        	{
        		if (!application.gfn_IsEmpty(arrArgument[0])) 
        		{
        			rtnArr = arrArgument[0].toString().split(arrArgument[1]);
        		}
        	}

        	return rtnArr;
        }

        /******************************************************************************
         * 함수명        : gfn_ToFixed(sNum);
         * 설명          : 소수점 자리수 지정 함수
         * argument       : sNum   입력값.
         *                : cnt    자리수.
         * return         : rtn    처리결과의 문자열 배열
         ******************************************************************************/
        this.gfn_ToFixed = function (sNum,cnt)
        {
        	return nexacro.toNumber(sNum).toFixed(cnt).toLocaleString();
        }

        
        /******************************************************************************
         * 함수명        : gfn_NumFormat(dNumber);
         * 설명          : 입력된 실수를 문자열 표현법으로 표현하는 함수
         * argument       : sNum    문자열로 출력할 실수
         *                  digit    출력시 소숫점 이하의 자릿수(Default : 0)
         * return         : 문자열로 바뀐 실수
         *                  출력되는 실수는 정수부분에 3자리마다 ',' 가 삽입됩니다.
         * gfn_NumFormat(12345.66)
         ******************************************************************************/
        this.gfn_NumFormat = function (sNum,digit)
        {
        // 	var rtnStr;
        // 	if (application.gfn_IsEmpty(nDetail)) 
        // 	{
        // 		nDetail = 0;
        // 	}
        // 
        // 	return nexacro.toNumber(dNumber).toFixed(nDetail).toLocaleString();

        	// 소숫점 반올림 처리
        	if(!this.gfn_isNull(digit))
        	{
        		if ( (typeof sNum) == "string" ) {
        			sNum = parseFloat(sNum);
        		}
        		sNum = this.gfn_round(sNum, digit);
        	}
        	
            if ( (typeof sNum) != "string" ) {
                sNum = sNum.toString();
            }

            sNum = this.gfn_Trim(sNum);  //string
        	var ppos, sDigit, nEnd, nStart=0, sRet="";
        	
        	if(this.gfn_isNull(sNum))
        	    return "";
        	
        	if( sNum.charAt(0) == "+" || sNum.charAt(0) == "-" )
        	{
        		sRet += sNum.charAt(0);
        		nStart = 1;
        	}
        		
        	ppos = sNum.indexOf(".",nStart);
        	if( ppos < 0 )
        		nEnd = sNum.length;
        	else
        		nEnd = ppos;	
        			
        	// 양수 영역 , 처리
        	sDigit = sNum.substr(nStart, nEnd-nStart);
        	for( pos = 0 ; pos < sDigit.length ; pos ++ )
        	{
        		if( pos != 0 && (sDigit.length-pos)%3 == 0 )
        			sRet += ",";
        		sRet += sDigit.charAt(pos);
        	}
        	// 소숫점 자리수 더하기
        	sRet += sNum.substr(nEnd);
        	
        	return sRet;
        }

        /******************************************************************************
         * 함수명        : gfn_round(dNumber);
         * 설명          : 주어진 수식을 반올림하여 가장 가까운 정수 또는 고정 소수점 실수를 반환
         * argument       : val - 숫자값
         *                  digit - 자리수
         * return         : 정수 또는 부동 소수점 숫자
         ******************************************************************************/
        this.gfn_round = function (val,digit)
        {
            if (this.gfn_isNull(digit))
                digit = 0;
                
            var nRetVal = Math.round(val, digit);

            return nRetVal;
        }

        /**********************************************************************************
         * 함수명        : gfn_Quote
         * 설명          : 입력된 문자열의 양쪽에 쌍따옴표를 붙여 반환합니다.
         * argument       : strString 대상 문자열
         
         * return Type    : String
         * return 내용   : 쌍따옴표가 붙여진 문자열
         **********************************************************************************/
        this.gfn_Quote = function ()
        {
        	var retVal = '""';
        	var arrArgument = this.gfn_Quote.arguments;

        	if ((arrArgument != null) && (arrArgument.length >= 1) && (!application.gfn_IsEmpty(arrArgument[0]))) 
        	{
        		retVal = wrapQuote(new String(arrArgument[0]));
        	}
        	return retVal;
        }

        /**********************************************************************************
         * 함수명        : gfn_SubStr
         * 설명          : 지정한 위치에서 시작하고 지정한 길이를 갖는 부분 문자열을 반환하는 함수
         * argument       : strString String  가운데 부문을 얻어올 원본 문자열.
         nIndex    Integer 얻어올 첫 글자의 Index.
         nSize     Integer 얻어올 글자수. [Default length(해당 개채의 길이)]
         * return Type    : String
         * return 내용   : 가운데 부분이 얻어진 문자열.
         **********************************************************************************/  
        this.gfn_subStr = function(sVal,nStart,nLength){
        	var retVal = "";
        	if (!this.gfn_isNull(sVal)) {
        		if (this.gfn_isNull(nLength)) {
        			retVal = String(sVal).substr(nStart);
        		} else {
        			retVal = String(sVal).substr(nStart, nLength);
        		}		
        	}

        	return retVal;
        }

        /**********************************************************************************
         * 함수명        : gfn_subStrB
         * 설명          : 맨 마지막 문자 제거
         * argument       : sVal  문자열
         * return Type    : String
         * return 내용   : 맨 마지막 문자열이 제거된 값
         **********************************************************************************/  
        this.gfn_subStrB = function(sVal){
        	var retVal = "";
        	
        	if (!this.gfn_isNull(sVal)) {
        		retVal = sVal.slice(0,-1)				
        	}
        	
        	return retVal;
        }

        /*********************************************************************************************
         * ★ Function명 : gfn_NvlToEmpty
         * ★ 설명       : NULL 일 경우 빈 값을 리턴한다.
         * ★ Params     :  1. sValue - String
         * ★ Return     : sValue 리턴값(입력값이 null = "", Not Null = 원래의 값)
         *********************************************************************************************/
        this.gfn_NvlToEmpty = function (sValue)
        {
        	if (application.gfn_IsNull(sValue)) 
        	{
        		return "";
        	}
        	return sValue;
        }

        /*********************************************************************************************
         * ★ Function명 : gfn_transNullToEmpty
         * ★ 설명       : NULL 일 경우 빈 값을 리턴한다.
         * ★ Params     :  1. sValue - String
         * ★ Return     : sValue 리턴값(입력값이 null = "", Not Null = 원래의 값)
         * - coolmind 2011.12.13 : gfn_NvlToEmpty와 같은 함수이므로 해당 함수 삭제
         *********************************************************************************************/
        this.gfn_transNullToEmpty = function (sValue)
        {
        	return this.gfn_NvlToEmpty(sValue);
        }

        /**********************************************************************************
         * 함수명        : gfn_Nvl
         * 설명          : Null값을 실제 값으로 변환
         * argument       : expr1 : Null을 포함하는 소스 값
         expr2 : Null을 대치할 값
         * return Type    :
         * return 내용   :
         **********************************************************************************/
        this.gfn_Nvl = function ()
        {
        	var retVal = "";
        	var arrArgument = this.gfn_Nvl.arguments;

        	if (arrArgument.length == 1) 
        	{
        		if (!application.gfn_IsEmpty(arrArgument[0])) 
        		{
        			retVal = arrArgument[0];
        		}
        	}
        	else if (arrArgument.length == 2) 
        	{
        		if (application.gfn_IsEmpty(arrArgument[0])) 
        		{
        			retVal = arrArgument[1];
        		}
        		else 
        		{
        			retVal = arrArgument[0];
        		}
        	}

        	return retVal;
        }

        /*********************************************************************
         * 함 수 명 	: gfn_Mid
         * 함수설명 	: 입력된 문자열에서 가운데 부분을 주어진 길이만큼 Return 한다.
         * 입    력 	: trString	- 가운데 부문을 얻어올 원본 문자열
         *                nIndex 	- 얻어올 첫 글자의 Index
         *                nSize 	- 얻어올 글자수
         * 결    과 	: 얻어진 문자열.
         *********************************************************************/
        this.gfn_Mid = function (strString,nIndex,nSize)
        {
        	var nStart = ((nIndex == null) ? 0 : ((nIndex.toString().length <= 0) ? 0 : nIndex - 1));
        	var nEnd = ((nSize == null) ? strString.toString().length : ((nSize.toString().length <= 0) ? strString.toString().length : nSize));
        	var rtnVal = strString.substr(nStart, nEnd);

        	return String(rtnVal); 
        }

        /*********************************************************************
         * 함 수 명 	: gfn_setCommaValue
         * 함수설명 	: 숫자를 금액 표현으로 바꾸어 준다.
         * 입    력 	: sValue	- 최초 숫자
         * 결    과 	: 얻어진 문자열.
         *********************************************************************/
        this.gfn_setCommaValue = function(sValue)
        {
        	var i;
        	var temp = "";
        	sValue = nexacro.toNumber(sValue);
        	var idx = sValue.toString().trim().length % 3;

        	if(idx>0 && sValue.toString().trim().length > 3)
        	{
        		temp = sValue.toString().substring(0, idx) + ',';
        		sValue = sValue.toString().substring(idx);
        	}

        	for(i=(sValue.toString().trim().length/3) - 1; i>0; i--)
        	{
        		temp += sValue.toString().substring(0, 3) + ',';
        		sValue = sValue.toString().substring(3);  
        	}

        	temp += sValue;
        	return temp;
        }

        /*********************************************************************
         * 함 수 명 	: gfn_setCommaValueWithDot
         * 함수설명 	: 숫자를 금액 표현으로 바꾸어 준다. (소숫점)
         * 입    력 	: sValue	- 최초 숫자
         * 결    과 	: 얻어진 문자열.
         *********************************************************************/
        this.gfn_setCommaValueWithDot = function(sValue)
        {
        	var i;
        	var sRtnValue = "";
        	var iDotPos = "";
        	var sConvValue = "";
        	var sDotValue = "";

        	// sValue = nexacro.toNumber(sValue);

        	iDotPos = sValue.toString().indexOf(".");

        	if(iDotPos > 0)
        	{
        		sDotValue = sValue.toString().substring(iDotPos); 
        		sConvValue = sValue.toString().substring(0,iDotPos);  
        	} 
        	else 
        	{
        		sConvValue = sValue;
        	}

        	var idx = sConvValue.toString().trim().length % 3;

        	if(idx>0 && sConvValue.toString().trim().length > 3)
        	{
        		sRtnValue = sConvValue.toString().substring(0, idx) + ',';
        		sConvValue = sConvValue.toString().substring(idx);
        	}

        	for(i=(sConvValue.toString().trim().length/3) - 1; i>0; i--)
        	{
        		sRtnValue += sConvValue.toString().substring(0, 3) + ',';
        		sConvValue = sConvValue.toString().substring(3);  
        	}

        	if(iDotPos > 0)
        	{
        		sRtnValue += sConvValue + sDotValue;
        	}
        	else
        	{
        		sRtnValue += sConvValue;
        	}

        	return sRtnValue;
        }

        /**
         * @class JSON Object를 JSON String으로 변환하여 리턴한다.
         * @param object - JSON Object
         * @return JSON String
         */
        this.gfn_jsonObjectToString = function(object) {
            var isArray = (object.join && object.pop && object.push
                            && object.reverse && object.shift && object.slice && object.splice);
            var results = [];
            
            for (var i in object) {
                var value = object[i];
                
                if (typeof value == "object"){
                    results.push((isArray ? "" : "\"" + i.toString() + "\" : ") + this.gfn_jsonObjectToString(value));
                }else if (value){
        			value=this.gfn_addSlash(value);
                    results.push((isArray ? "" : "\"" + i.toString() + "\" : ") + (typeof value == "string" ? "\"" + value + "\"" : value));
                }
            }
            
            return (isArray ? "[" : "{") + results.join(", ") + (isArray ? "]" : "}");
        }

        /**
         * @class JSON String을 JSON Object으로 변환하여 리턴한다.
         * @param strJson - JSON String
         * @return JSON Object
         */
        this.gfn_jsonStringToObject = function(strJson){
            return eval("(" + strJson + ")");
        }

        this.gfn_addSlash = function(strValue){
        	var str=strValue;
        	if(typeof(str)=="string"){
        		str=str.replace('\\','\\\\');
        		str=str.replace('"','\\"');
        		str=str.replace('\'','\\\'');
        		str=str.replace('\n','\\n');
        		str=str.replace('\r','\\r');
        		//str=str.replace('\s','\\s');
        		str=str.replace('\t','\\t');
        	}
        	return str;
        }

         /**
         * @class 입력값이 null에 해당하는 경우 모두를 한번에 체크한다.
         * @param sValue - 체크할 문자열( 예 : null 또는 undefined 또는 "" 또는 "abc" )
         * @return Boolean sValue이 undefined, null, NaN, "", Array.length = 0인 경우 true
         */   
        this.gfn_isNull = function(sValue){
        	
        	if (new String(sValue).valueOf() == "undefined") return true;
            if (sValue == null) return true;
            
            var v_ChkStr = new String(sValue);
            
            if (v_ChkStr == null) return true;
            if (v_ChkStr.toString().length == 0 ) return true;
            
            return false;
        }

         /**
         * @class 입력값이 null에 해당하는 경우 모두를 한번에 체크한다.
         * @param sValue - 체크할 문자열( 예 : null 또는 undefined 또는 "" 또는 "abc" )
         * @return Boolean sValue이 undefined, null, NaN, "", Array.length = 0인 경우 true
         */   
        this.gfn_isNullNan = function(sValue){
        	
        	if(sValue == null||sValue == NaN||sValue == undefined||sValue.length == 0) return 0;
        	if (new String(sValue).valueOf() == "NaN") return 0;
        	if (new String(sValue).valueOf() == "Infinity") return 0;
            
            var v_ChkStr = new String(sValue);
            if (v_ChkStr == null||v_ChkStr.length == 0 ) return 0;

            return sValue;
        }

        /******************************************************************************
        * Function Name: getMaskFormat
        * Description  : 문자 포맷 형식 변환 ( 해당 문자는 포맷에서 @ 사용)
        * Arguments    : Val: 문자열, 
        *                strMask: 문자열 포맷, (@:문자, 포맷스트링("-", ",", ".")등
        * return       : 포맷된 문자
        ******************************************************************************/
        this.getMaskFormat = function (Val,Mask) {
            
            var strRetVal = "";
        	var sUnit;
        	
        	if(this.gfn_isNull(Val)) return null;
        	
        	var strVal  = String(Val);
        	var strMask = this.gfn_Nvl(Mask, "");
        	
        	for(var i = 0; i < strMask.length; i++) {
        		sUnit = strMask.substr(i, 1);
        		
        		if(sUnit == "@")
        		{
        		    strRetVal += strVal.substr(0, 1);
        		    strVal = strVal.substr(1);
        		    if(strVal.length == 0) break;
        		}
        		else
        		{
        		    strRetVal += sUnit;
        		}
            }
            return strRetVal;
        }

        /******************************************************************************
         * 함수명        : gfn_split()
         * 설명          : 특정 문자열을 기준으로 전체 문자열을 나누어서 하나의 배열(Array)로 만들어 반납하는 함수
         * argument       : 나눌 기준이 되는 문자
         * return         : 1 차원 배열
         ******************************************************************************/
        this.gfn_split = function ()
        {
        	var rtnArr = new Array();
        	var arrArgument = this.gfn_split.arguments;

        	if (arrArgument.length < 1) {
        	} else if (arrArgument.length < 2) {
        		if (!this.gfn_isNull(arrArgument[0])) {
        			rtnArr[0] = arrArgument[0];
        		}
        	} else if (arrArgument.length == 2) {
        		if (!this.gfn_isNull(arrArgument[0])) {
        			rtnArr = arrArgument[0].toString().split(arrArgument[1]);
        		}
        	} else {
        		if (!this.gfn_isNull(arrArgument[0])) {
        			rtnArr = arrArgument[0].toString().split(arrArgument[1]);
        		}
        	}
        	
        	return rtnArr;
        }

        /******************************************************************************
         * 함수명        : gfn_right()
         * 설명          : 문자열의 오른쪽부분을 지정한 길이만큼 Return
         * argument       : 오른 부분을 얻어올 원본 문자열, 얻어올 크기. [Default Value = 0]
         * return         : 문자열
         ******************************************************************************/
        this.gfn_right = function (Val,nSize)
        {
        	var nStart = this.gfn_toString(Val).length;
        	var nEnd = nexacro.toNumber(nStart) - nexacro.toNumber(nSize);
        	var rtnVal = Val.substring(nStart, nEnd);

        	return rtnVal;
        }

        /******************************************************************************
         * 함수명        : gfn_toString()
         * 설명          : 입력값을 String으로 변경
         * argument       : 문자열
         * return         : 문자열
         ******************************************************************************/   
        this.gfn_toString = function (Val)
        {
        	if (this.gfn_isNull(Val)) 
        	{
        		return new String();
        	}
        	return new String(Val);
        }

        /******************************************************************************
         * 함수명        : NumFormat(dNumber);
         * 설명          : 입력된 실수를 문자열 표현법으로 표현하는 함수
         * argument       : dNumber    문자열로 출력할 실수
         *                  nDetail    출력시 소숫점 이하의 자릿수(Default : 0)
         * return         : 문자열로 바뀐 실수
         *                  출력되는 실수는 정수부분에 3자리마다 ',' 가 삽입됩니다.
         * NumFormat(12345.66)
         ******************************************************************************/
        this.numFormat = function (dNumber,nDetail){ 
        	if (this.gfn_isNull(dNumber)) dNumber = 0;
        	if (this.gfn_isNull(nDetail)) nDetail = 0; 
        	
        	//return toNumber(dNumber.toFixed(nDetail)).toLocaleString();
        	return nexacro.toNumber(dNumber).toFixed(nDetail).toLocaleString();
        } 

        /********************************************************************
         * 문자열에 있는 모든 영어를 대문자로 바꾸는 Basic API 
         ********************************************************************/
        this.ToUpper = function (args)
        {			
        	if( this.gfn_isNull(args)) return "";
        	return	String(args).toUpperCase();
        }

        /******************************************************************************
         * 함수명        : iif
         * 설명          : 조건식이 true일 경우 trueVal, false일경우 falseVal를 반환한다.
         * argument       : 조건식
         * return         : true일 경우 trueVal, false일경우 falseVal
         ******************************************************************************/ 
        this.iif = function (cond,rtnTrue,rtnFalse)
        {
        	if(cond) 
        	{
        		return rtnTrue;
        	} 
        	else {
        		return rtnFalse;
        	}
        } 

        
        /******************************************************************************
         * 함수명        : fn_Sign
         * 설명          : 넘어온 값의 양/음 판단
         * argument       : varValue - 판단할 값
         * return         : 양수(1), 음수(-1), Zero(0)
         ******************************************************************************/ 
        this.fn_Sign = function (varValue)
        {
        	if (nexacro.toNumber(varValue) == 0) return 0;
        	if (nexacro.toNumber(varValue) > 0) return 1;
        	if (nexacro.toNumber(varValue) < 0) return -1;
        }

        /********************************************************************
         * 로우타입
         ********************************************************************/
        this.GetRowType = function (XDataObject,nRow){
        	var rtnVal;
        	var nRowType = XDataObject.getRowType(nRow);
        	
        	if(nRowType==1)
        		rtnVal = "normal";
        	else if(nRowType==2)
        		rtnVal = "insert";
        	else if(nRowType==4)
        		rtnVal = "update";
        	else if(nRowType==8)
        		rtnVal = "delete";
        	else if(nRowType==16)//ROWTYPE_GROUP
        		rtnVal = "logical";
        	else if(nRowType==0)//ROWTYPE_EMPTY
        		rtnVal = "normal";	
        				
        	return rtnVal;
        }

        //********************************************************************
        // 메세지 공통
        //********************************************************************
        this.fn_AlertMsg = function(cd)
        {
        	var v_Msg="";
        	switch(cd)
        	{
        		case "000":
        			v_Msg= "이(가) 저장되었습니다.";
        			break;
        		case "001":
        			v_Msg= "버튼이 정의 되어 있지않습니다.";
        			break;
        		case "002":
        			v_Msg="서비스 오류:시스템 관리자에게 문의하십시오";
        			break;
        		case "003":
        			v_Msg="필수항목은 반드시 선택하시기 바랍니다.";
        			break;	
        		case "004":
        			v_Msg="작업대상 본사를 선택하세요.";
        			break;
        		case "005":
        			v_Msg="을(를) 입력하세요";
        			break;
        		case "006":
        			v_Msg="삭제할 데이터가 없습니다.";
        			break;
        		case "007":
        			v_Msg="변경된 데이터가 없습니다.";
        			break;
        		case "008":
        			v_Msg="시스템ID가 없습니다.";
        			break;			
        /*			
        		case "":
        			v_Msg="";
        			break;
        */			
        		default:
        			break;			
        	}
        	return v_Msg;
        }
          
        /******************************************************************************
         * 함수명        : gfn_isEmail
         * 설명          : 입력값이 e-mail Type인지 체크하는 함수
         * argument       : strValue
         * return         : boolean
         ******************************************************************************/  
        this.gfn_isEmail = function(strValue)
        {
        	if (this.gfn_isNull(strValue)) 
        	{
        		return false;
        	}

        	var nIndexOfAt = strValue.indexOf("@");
        	var nIndexOfDot = strValue.indexOf(".");
        	var nLength = strValue.length;

        	// "@" 이 하나도 없거나 맨 끝에 위치한  경우
        	if (nIndexOfAt <= 0 || nIndexOfAt == nLength) 
        	{
        		return false;
        	}

        	// "." 이 하나도 없거나 맨 끝에 위치한 경우
        	if (nIndexOfDot <= 0 || nIndexOfDot == nLength) 
        	{
        		return false;
        	}

        	// "@"이 두개 이상 존재하는 경우
        	if (strValue.indexOf("@", nIndexOfAt + 1) != -1) 
        	{
        		return false;
        	}

        	// ".@" 인 경우 또는 "@."인 경우
        	if (strValue.substr(nIndexOfAt - 1, 1) == "." || strValue.substr(nIndexOfAt + 1, 1) == ".") 
        	{
        		return false;
        	}

        	// "@" 이후에 "."이 존재하지 않는 경우
        	if (strValue.indexOf(".", (nIndexOfAt + 2)) == -1) 
        	{
        		return false;
        	}

        	// 공백문자가 존재하는 경우
        	if (strValue.indexOf(" ") != -1) 
        	{
        		return false;
        	}

        	return true;
        }

        /******************************************************************************
         * 함수명        : fn_clearNaN
         * 설명          : isNaN 경우 0으로 리턴
         * argument       : inVal
         * return         : outVal
         ******************************************************************************/  
        this.fn_clearNaN = function (inVal)
        {
        	var outVal = 0;
         
        	if(isFinite(inVal)) 
        	{
        		outVal = inVal;
        	} 
        	else if(isNaN(inVal)) 
        	{
        		outVal = 0;
        	}
        	else
        	{
        		outVal = 0;
        	}
         
        	return outVal;
        }

        /******************************************************************************
         * 함수명        : gfn_getValue
         * 설명          : 해당 객체의 value를 받아온다. disable 상태이면 ""을 리턴한다.
         * argument       : element
         * return         : 객체의 vlue
         ******************************************************************************/ 
        this.gfn_getValue = function (element){
        	if(element == null){
        		return "";
        	}
        	if (element.enable == true)
        		return element.value
        	return 	null;
        }

        
        });


    
        this.loadIncludeScript(path, true);
        
        obj = null;
    };
}
)();