//XJS=lib_Date.xjs
(function()
{
    return function(path)
    {
        var obj;
    
        // User Script
        this.registerScript(path, function(exports) {
        /*
         ===============================================================================
         == 날짜관련 공통함수들은 여기에 작성한다.
         ===============================================================================
         ● gfn_Today : 해당 PC(단말)의 오늘 날짜를 가져온다.
         ● gfn_TodayTime : 해당 PC(단말)의 오늘 날짜+시간를 가져온다.
         ● gfn_AddDate : 입력된 날자에 OffSet 으로 지정된 만큼의 일을 더한다.
         ● gfn_AddMonth : 입력된 날자에 OffSet 으로 지정된 만큼의 달을 더한다.
         ● gfn_AddYear : 입력된 날자에 OffSet 으로 지정된 만큼의 년을 더한다.
         ● gfn_getYearList : 현재부터 n년 간의 년도를 Dataset으로 넘겨준다
         ● gfn_Datetime : MiPlatform에서 사용하던 Datetime형식으로 변환
         
         ● gfn_GetDiffDay : 2개의 날짜간의 Day count
         ● gfn_DateCheck : 날짜에 대한 형식 체크
         ● gfn_GetDay : 입력된 날자로부터 요일을 구함
         
         ● gfn_GetDayName : 입력된 날자로부터 요일명을 구함
         ● gfn_IsLeapYear : 윤년여부 확인
         ● gfn_LastDateNum : 해당월의 마지막 날짜를 숫자로 구하기
         
         ● gfn_LastDate : 해당월의 마지막 날짜를 yyyyMMdd형태로 구하기
         
         //● gfn_Solar2Lunar : 양력을 음력으로 변환해주는 함수 (처리가능 기간  1841 - 2043년)
         //● gfn_Lunar2Solar : 음력을 양력으로 변환해주는 함수 (처리가능 기간  1841 - 2043년)
         //● gfn_GetHolidays : 양력 nYear에 해당하는 년도의 법정 공휴일(양력) List 모두 구하기
         
         ● _SolarBase      : 각 월별 음력 기준 정보를 처리하는 함수(처리가능 기간  1841 - 2043년) 단, 내부에서 사용하는 함수임
         ● gfn_DateToStr   : 날짜타입을 문자열로 변환
         ● gfn_StrToDate   : 문자타입을 날짜로 변환
         ● gfn_getEpTime   : 총사용시간을 구한다.
         */

        /*******************************************************************************
         * Function명 : gfn_IsDate
         * 설명       : 날짜에 대한 형식 체크
         * parameter  : None
         * return     : string
         ******************************************************************************/
        this.gfn_IsDate = function (v)
        {
        	return this.gfn_DateCheck(v);
        }

        /*******************************************************************************
         * Function명 : gfn_Today
         * 설명          : 해당 PC의 오늘 날짜를 가져온다.
         * parameter  : None
         * return        : string
         ******************************************************************************/
        this.gfn_Today = function ()
        {
        	var strToday = "";
        	var objDate = new Date();

        	var yyyy = objDate.getFullYear();
        	var month = objDate.getMonth() + 1;
        	var day = objDate.getDate();

        	strToday = String(yyyy) + String(month).padLeft(2, "0") + String(day).padLeft(2, "0");
        	objDate = null;

        	return strToday;
        }

        /*******************************************************************************
         * Function명 : gfn_TodayTime
         * 설명       : 해당 PC의 오늘 날짜+시간를 가져온다.
         * parameter : None
         * return         : string
         ******************************************************************************/
        this.gfn_TodayTime = function ()
        {
        	var strToday = "";
        	var objDate = new Date();
        	/*
        	 var strToday  = objDate.getFullYear() + "";
        	 strToday += gfn_Right("0" + (objDate.getMonth() + 1), 2);
        	 strToday += gfn_Right("0" + objDate.getDate(), 2);
        	 strToday += gfn_Right("0" + objDate.getHours(), 2);
        	 strToday += gfn_Right("0" + objDate.getMinutes(), 2);
        	 strToday += gfn_Right("0" + objDate.getSeconds(), 2);
        	 */
        	// return objDate.toFormatString("%Y%m%d%H%M%S");  --> Ajax에서 toFormatString함수가 정상동작 하지 않아 아래 로직으로 수정함

        	var hh = objDate.getHours();
        	var mm = objDate.getMinutes();
        	var ss = objDate.getSeconds();

        	var yyyy = objDate.getFullYear();
        	var month = objDate.getMonth() + 1;
        	var day = objDate.getDate();

        	strToday = String(yyyy) + String(month).padLeft(2, "0") + String(day).padLeft(2, "0") + String(hh).padLeft(2, "0") + String(mm).padLeft(2, "0") + String(ss).padLeft(2, "0");
        	objDate = null;

        	return strToday;
        }

        /**********************************************************************************
         * 함수명      : gfn_AddDate
         * 설명        : 입력된 날자에 OffSet 으로 지정된 만큼의 일을 더한다.
         *               Date Type을 String으로 변환
         * argument    : date ('yyyyMMdd' 형태로 표현된 날자)
         *               nOffSet (날짜로부터 증가 감소값. 지정하지 않으면 Default Value = 1 로 적용됩니다)
         * return Type : String
         * return 내용 : Date에 nOffset이 더해진 결과를 'yyyyMMdd'로 표현된 날자.
         **********************************************************************************/
        // this.gfn_AddDate = function (date, nOffSet)
        // {
        // 	date = String(date).substr(0, 8);
        // 	var tempDate = this.gfn_StrToDate(date);
        // 	
        // 	var tempAddDate = tempDate.addDate(nOffSet);
        // 	tempDate = new Date(tempAddDate);
        // 	return this.gfn_DateFormatString(tempDate, "%Y%m%d");
        // }
        this.gfn_AddDate = function (sDate,nOffSet)
        {
        	if(this.gfn_isNull(sDate)) return;
        	var nYear  = parseInt(this.gfn_subStr(sDate,0, 4));
        	var nMonth = parseInt(this.gfn_subStr(sDate,4, 2));
        	var nDate  = parseInt(this.gfn_subStr(sDate,6, 2)) + parseInt(nOffSet);
        	
        	return this.gfn_dateTime(nYear, nMonth, nDate);
        }

        this.gfn_dateTime = function (nYear,nMonth,nDate)
        {
        	if (nYear.toString().trim().length >= 5) 
        	{
        		var sDate = new String(nYear);
        		var nYear = sDate.substr(0, 4);
        		var nMonth = sDate.substr(4, 2);
        		var nDate = ((sDate.substr(6, 2) == "") ? 1 : sDate.substr(6, 2));
        		var nHours = ((sDate.substr(8, 2) == "") ? 0 : sDate.substr(8, 2));
        		var nMinutes = ((sDate.substr(10, 2) == "") ? 0 : sDate.substr(10, 2));
        		var nSeconds = ((sDate.substr(12, 2) == "") ? 0 : sDate.substr(12, 2));

        		var objDate = new Date(parseInt(nYear), parseInt(nMonth) - 1, parseInt(nDate), parseInt(nHours), parseInt(nMinutes), parseInt(nSeconds));
        	}
        	else 
        	{
        		var objDate = new Date(parseInt(nYear), parseInt(nMonth) - 1, parseInt(((nDate == null) ? 1 : nDate)));
        	}
        	var strYear = objDate.getYear().toString();
        	var strMonth = (objDate.getMonth() + 1).toString();
        	var strDate = objDate.getDate().toString();

        
        	if (strYear.length == 2)
        	{
        		strYear = "19" + strYear;
        	}

        	if (strMonth.length == 1) 
        	{
        		strMonth = "0" + strMonth;
        	}
        	if (strDate.length == 1) 
        	{
        		strDate = "0" + strDate;
        	}

        	return strYear + strMonth + strDate;
        }

        /**********************************************************************************
         * 함수명      : gfn_AddMonth
         * 설명        : 입력된 날자에 OffSet 으로 지정된 만큼의 달을 더한다.
         *               Date Type을 String으로 변환
         * argument    : date ('yyyyMMdd' 형태로 표현된 날자)
         *               nOffSet (날짜로부터 증가 감소값. 지정하지 않으면 Default Value = 1 로 적용됩니다)
         * return Type : String
         * return 내용 : Date에 nOffset이 더해진 결과를 'yyyyMMdd'로 표현된 날자.
         **********************************************************************************/
        this.gfn_AddMonth = function (date,nOffSet)
        {
        	var tempDate = this.gfn_StrToDate(date);

        	var tempAddMonth = tempDate.addMonth(nOffSet);
        	tempDate = new Date(tempAddMonth);
        	return this.gfn_DateFormatString(tempDate, "%Y%m%d");
        }

        /**********************************************************************************
         * 함수명      : gfn_AddYear
         * 설명        : 입력된 날자에 OffSet 으로 지정된 만큼의 년을 더한다.
         *               Date Type을 String으로 변환
         * argument    : date ('yyyyMMdd' 형태로 표현된 날자)
         *               nOffSet (날짜로부터 증가 감소값. 지정하지 않으면 Default Value = 1 로 적용됩니다)
         * return Type : String
         * return 내용 : Date에 nOffset이 더해진 결과를 'yyyy'로 표현된 날자.
         **********************************************************************************/
        this.gfn_AddYear = function (date,nOffSet)
        {
        	var tempDate = this.gfn_StrToDate(date);

        	var tempAddYear = tempDate.addYear(nOffSet);
        	tempDate = new Date(tempAddYear);
        	return this.gfn_DateFormatString(tempDate, "%Y");
        }
        /*******************************************************************************
        * Function명 : gfn_getYearList
        * 설명          : 현재부터 n년 간의 년도를 Dataset으로 넘겨준다
        * parameter  : argN : 반복되는 횟수
        * return        : dataset
        ******************************************************************************/
        this.gfn_getYearList = function (argN)
        {
        	var strToday = "";
        	var objDate = new Date();
        	var ds_Year = new Dataset;
        	var nRow, i;

        	ds_Year.addColumn("year", "string", 4);

        	var yyyy = objDate.getFullYear();
        	var nYear = nexacro.toNumber(yyyy);

        	for(i = 0; i < argN; i++)
        	{
        		nRow = ds_Year.addRow();

        		nYear = nexacro.toNumber(yyyy) - i;

        		ds_Year.setColumn(nRow, "year", nYear);
        	}
        	objDate = null;

        	return ds_Year;
        }

        /**********************************************************************************
         * 함수명      : gfn_Datetime
         * 설명        : MiPlatform에서 사용하던 Datetime형식으로 변환
         *               Date Type을 String으로 변환
         * argument    : nYear (년도)
         *               nMonth (월)
         *               nDate (일)
         * return Type : String
         * return 내용 : 조합한 날짜를 리턴
         **********************************************************************************/
        this.gfn_Datetime = function (nYear,nMonth,nDate)
        {
        	if (nYear.toString().trim().length >= 5) 
        	{
        		var sDate = new String(nYear);
        		var nYear = sDate.substr(0, 4);
        		var nMonth = sDate.substr(4, 2);
        		var nDate = ((sDate.substr(6, 2) == "") ? 1 : sDate.substr(6, 2));
        		var nHours = ((sDate.substr(8, 2) == "") ? 0 : sDate.substr(8, 2));
        		var nMinutes = ((sDate.substr(10, 2) == "") ? 0 : sDate.substr(10, 2));
        		var nSeconds = ((sDate.substr(12, 2) == "") ? 0 : sDate.substr(12, 2));

        		var objDate = new Date(parseInt(nYear, 10), parseInt(nMonth, 10) - 1, parseInt(nDate, 10), parseInt(nHours, 10), parseInt(nMinutes, 10), parseInt(nSeconds, 10));
        	}
        	else 
        	{
        		var objDate = new Date(parseInt(nYear, 10), parseInt(nMonth, 10) - 1, parseInt(((nDate == null) ? 1 : nDate), 10));
        	}

        	var strYear = objDate.getFullYear() + "";
        	var strMonth = (objDate.getMonth() + 1).toString();
        	var strDate = objDate.getDate().toString();

        	if (strMonth.length == 1) 
        	{
        		strMonth = "0" + strMonth;
        	}
        	if (strDate.length == 1) 
        	{
        		strDate = "0" + strDate;
        	}

        	return strYear + strMonth + strDate;
        }

        /******************************************************************************
         * Function명 : gfn_GetDiffDay
         * 사용법 : gfn_GetDiffDay("20090808", "20091001")
         * 설명       : 2개의 날짜간의 Day count
         * Params     : sFdate   시작일자
         *              sTdate   종료일자
         * Return     : 양 일자간의 Day count
         ******************************************************************************/
        this.gfn_GetDiffDay = function (sFdate,sTdate)
        {
        	sFdate = new String(sFdate);
        	sFdate = sFdate.split(" ").join("").split("-").join("").split("/").join("");
        	sTdate = new String(sTdate);
        	sTdate = sTdate.split(" ").join("").split("-").join("").split("/").join("");

        	sFdate = this.gfn_Left(sFdate, 8);
        	sTdate = this.gfn_Left(sTdate, 8);

        	if (sFdate.length != 8 || sTdate.length != 8
        		 || nexacro.isNumeric(sFdate) == false || nexacro.isNumeric(sTdate) == false
        		 || this.gfn_GetDay(sFdate) == -1 || this.gfn_GetDay(sTdate) == -1) 
        	{
        		return null;
        	}

        	var nDiffDate = this.gfn_StrToDate(sTdate) - this.gfn_StrToDate(sFdate);
        	var nDay = 1000 * 60 * 60 * 24;

        	nDiffDate = parseInt(nDiffDate / nDay, 10);
        	if (nDiffDate < 0) 
        	{
        		nDiffDate = nDiffDate - 1;
        	}
        	else 
        	{
        		nDiffDate = nDiffDate + 1;
        	}

        	return nDiffDate;
        }

        /******************************************************************************
         * Function명 : gfn_DateCheck
         * 설명       : 날짜에 대한 형식 체크
         * Params     : sFdate   검사일자
         * Return     : 유효성반환 (날짜형식이 아닐경우 FLASE)
         ******************************************************************************/
        this.gfn_DateCheck = function (sDate)
        {
        	sDate = sDate.split(" ").join("").split("-").join("").split("/").join("");

        	if (nexacro.isNumeric(sDate) == false || this.gfn_GetDay(sDate) == -1/*|| datetime(sDate) == datetime("00000101")*/) 
        	{
        		return false;
        	}

        	return true;
        }

        /******************************************************************************
         * Function명 : gfn_GetDay
         * 설명       : 입력된 날자로부터 요일을 구함
         * Params     : sDate  8자리 형식으로된 날짜. yyyyMMdd의 형식으로 입력됩니다.
         * Return     : 요일에 따른 숫자.
         *              0 = 일요일 ~ 6 = 토요일 로 대응됩니다.
         *              오류가 발생할 경우 -1이 Return됩니다.
         ******************************************************************************/
        this.gfn_GetDay = function (sDate)
        {
        	var objDate = this.gfn_StrToDate(sDate);
        	return objDate.getDay();
        }

        
        /******************************************************************************
         * Function명 : gfn_GetDayName
         * 설명       : 입력된 날자로부터 요일명을 구함
         * Params     : sDate  8자리 형식으로된 날짜. yyyyMMdd의 형식으로 입력됩니다.
         * Return     : 요일명
         
         ******************************************************************************/
        this.gfn_GetDayName = function (sDate)
        {
        	var objDayName = new Array("SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT");
        	var objDate = this.gfn_GetDay(sDate);

        	return objDayName[objDate];
        }

        /******************************************************************************
         * Function명 : gfn_IsLeapYear
         * 설명       : 윤년여부 확인
         * Params     : sDate : yyyyMMdd형태의 날짜 ( 예 : "20121122" )
         * Return     :
         *              	- sDate가 윤년인 경우 = true
         *					- sDate가 윤년이 아닌 경우 = false
         *   				- sDate가 입력되지 않은 경우 = false
         ******************************************************************************/
        this.gfn_IsLeapYear = function (sDate)
        {
        	var ret;
        	var nY;

        	if (application.gfn_IsEmpty(sDate)) 
        	{
        		return false;
        	}

        	nY = parseInt(sDate.substring(0, 4), 10);

        	if ((nY % 4) == 0) 
        	{
        		if ((nY % 100) != 0 || (nY % 400) == 0) 
        		{
        			ret = true;
        		}
        		else 
        		{
        			ret = false;
        		}
        	}
        	else 
        	{
        		ret = false;
        	}

        	return ret;
        }

        /******************************************************************************
         * Function명 : gfn_LastDateNum
         * 설명       : 해당월의 마지막 날짜를 숫자로 구하기
         * Params     : sDate : yyyyMMdd형태의 날짜 ( 예 : "20121122" )
         * Return     :
         *              	- 성공 = 마지막 날짜 숫자값 ( 예 : 30 )
         *					- 실패 = -1
         ******************************************************************************/
        this.gfn_LastDateNum = function (sDate)
        {
        	var nMonth,nLastDate;

        	if (application.gfn_IsEmpty(sDate)) 
        	{
        		return -1;
        	}

        	nMonth = parseInt(sDate.substr(4, 2), 10);
        	if (nMonth == 1 || nMonth == 3 || nMonth == 5 || nMonth == 7 || nMonth == 8 || nMonth == 10 || nMonth == 12) 
        	{
        		nLastDate = 31;
        	}
        	else if (nMonth == 2) 
        	{
        		if (this.gfn_IsLeapYear(sDate) == true) 
        		{
        			nLastDate = 29;
        		}
        		else 
        		{
        			nLastDate = 28;
        		}
        	}
        	else 
        	{
        		nLastDate = 30;
        	}

        	return nLastDate;
        }

        /******************************************************************************
         * Function명 : gfn_LastDate
         * 설명       : 해당월의 마지막 날짜를 yyyyMMdd형태로 구하기
         * Params     : sDate : yyyyMMdd형태의 날짜 ( 예 : "20121122" )
         * Return     :
         *              	- 성공 = yyyyMMdd형태의 마지막 날짜 ( 예 : "20121130" )
         *					- 실패 = ""
         ******************************************************************************/
        this.gfn_LastDate = function (sDate)
        {
        	if (application.gfn_IsEmpty(sDate)) 
        	{
        		return "";
        	}

        	var nLastDate = this.gfn_LastDateNum(sDate);

        	return sDate.substr(0, 6) + nLastDate.toString();
        }

        
        /*********************************************************************************************
         * ★ Function명 : gfn_getLastMonth()
         * ★ 설명       : nMonth만큼 날짜 구하는 함수.
         * ★ Params     : 1. sDate -
         2. nMonth -
         * ★ Return     : - 해당날짜를 리턴.
         *********************************************************************************************/
        this.gfn_getLastMonth = function (sDate,nMonth)
        {
        	var d;

        	nMonth = parseInt(nMonth, 10);

        	if (sDate) 
        	{
        		var date = this.gfn_str2Date(sDate);
        		d = (new Date(date)).addMonth(nMonth);
        	}
        	else 
        	{
        		d = (new Date).addMonth(nMonth);
        	}

        	var s = (new Date(d)).getFullYear();
        	var m = (((new Date(d)).getMonth() + 1) + "");
        	m = m.length == 1 ? "0" + m : m;

        	var dd = (((new Date(d)).getDate()) + "");
        	dd = dd.length == 1 ? "0" + dd : dd;

        	return (s + m + dd);
        }

        this.gfn_DateFormatString = function (objDate,strFormat)
        {
        	if (application.gfn_IsNull(strFormat)) 
        	{
        		return "";
        	}
        	var fY = String(objDate.getFullYear());
        	var fY2 = fY.substr(fY.length-2, 2);

        	strFormat = strFormat.toString();
        	strFormat = strFormat.split("%Y").join(String(objDate.getFullYear()));
        	strFormat = strFormat.split("%y").join(fY2);
        	strFormat = strFormat.split("%m").join(String(objDate.getMonth() + 1).padLeft(2, "0"));
        	strFormat = strFormat.split("%d").join(String(objDate.getDate()).padLeft(2, "0"));
        	strFormat = strFormat.split("%H").join(String(objDate.getHours()).padLeft(2, "0"));
        	strFormat = strFormat.split("%M").join(String(objDate.getMinutes()).padLeft(2, "0"));
        	strFormat = strFormat.split("%S").join(String(objDate.getSeconds()).padLeft(2, "0"));

        	return strFormat;
        }

        /*********************************************************************************************
         * ★ Function명 : gfn_getFirstDate()
         * ★ 설명       : 현재월 1일 만들기.
         * ★ Params     : 1. sDate -
         * ★ Return     : - 해당날짜를 리턴.
         *********************************************************************************************/
        this.gfn_getFirstDate = function (sDate)
        {
        	var s = "";

        	if (sDate == null) 
        	{
        		s = getToday().substr(0,6) + "01"; 
        	}
        	else 
        	{
        		var date = new Date(parseInt(sDate.substr(0, 4), 10), parseInt(sDate.substr(4, 2), 10) - 1, 1);
        		s = (new Date(date)).getFullYear()
        			 + (((new Date(date)).getMonth() + 1) + "").padLeft(2, '0')
        			 + ((new Date(date)).getDate() + "").padLeft(2, '0');
        	}
        	return (s);
        }

        /*********************************************************************************************
         * ★ Function명 : gfn_getLastDate()
         * ★ 설명       : 현재월 마지막일 만들기.
         * ★ Params     : 1. sDate -
         * ★ Return     : - 해당날짜를 리턴.
         *********************************************************************************************/
        this.gfn_getLastDate = function (sDate)
        {
        	var s = "";
        	if (sDate == null) 
        	{
        		var date = (new Date()).addMonth(1);
        	}
        	else 
        	{
        		var date = new Date(parseInt(sDate.substr(0, 4), 10), parseInt(sDate.substr(4, 2), 10), 1);
        	}

        	date = (new Date(date)).addDate((new Date(date)).getDate() * -1);

        	s = (new Date(date)).getFullYear()
        		 + (((new Date(date)).getMonth() + 1) + "").padLeft(2, '0')
        		 + ((new Date(date)).getDate() + "").padLeft(2, '0');

        	return (s);
        }

        /*********************************************************************************************
         * ★ Function명 : gfn_getOneMonthAfter()
         * ★ 설명       : 한달후 날짜 구하는 함수.
         * ★ Params     : 1. sDate -
         * ★ Return     : - 해당날짜를 리턴.
         *********************************************************************************************/
        this.gfn_getOneMonthAfter = function (sDate)
        {
        	if (sDate) 
        	{
        		var date = this.gfn_str2Date(sDate);
        		var d = (new Date(date)).addMonth(1);
        	}
        	else 
        	{
        		var d = (new Date).addMonth(1);
        	}

        	var s = (new Date(d)).getFullYear()
        		 + (((new Date(d)).getMonth() + 1) + "").padLeft(2, '0')
        		 + (((new Date(d)).getDate()) + "").padLeft(2, '0');

        	return (s);
        }

        /*********************************************************************************************
         * ★ Function명 : gfn_getDate()
         * ★ 설명       : 한달후 날짜 구하는 함수.
         * ★ Params     : 1. sDate -
         2. nDiff -
         * ★ Return     : - 해당날짜를 리턴.
         *********************************************************************************************/
        this.gfn_getDate = function (sDate,nDiff)
        {
        	if (sDate) 
        	{
        		var date = this.gfn_str2Date(sDate);
        		var d = (new Date(date)).addDate(nDiff);
        	}
        	else 
        	{
        		var d = (new Date).addDate(nDiff);
        	}

        	var s = (new Date(d)).getFullYear()
        		 + (((new Date(d)).getMonth() + 1) + "").padLeft(2, '0')
        		 + (((new Date(d)).getDate()) + "").padLeft(2, '0');

        	return (s);
        }

        this.gfn_DateToStr = function (v)
        {
        	if (typeof (v) == "string") 
        	{
        		return v;
        	}
        	return this.gfn_DateFormatString(v, "%Y%m%d%H%M%S");
        }

        this.gfn_StrToDate = function (v)
        {
        	if (typeof (v) == "date") 
        	{
        		return v;
        	}
        	var d = new Date();
        //	v = String(v).padRight(14, "0");
        	v = v.toString().padRight(14, "0");
        	d.setFullYear(parseInt(this.gfn_Left(v, 4), 10), parseInt(v.substr(4, 2), 10) - 1, parseInt(v.substr(6, 2), 10));
        	d.setHours(parseInt(v.substr(8, 2), 10), parseInt(v.substr(10, 2), 10), parseInt(v.substr(12, 2), 10));
        	return d;
        }

        /*********************************************************************************************
         * ★ Function명 : gfn_getEpTime
         * ★ 설명       : 총사용시간을 구한다.
         * ★ Params     :  1. sLoginDate - 로그인일시
         2. sLogoutDate - 로그아웃일시
         * ★ Return     : sRetVal 리턴값(총사용시간)
         *********************************************************************************************/
        this.gfn_getEpTime = function (sLoginDate,sLogoutDate)
        {
        	// 총사용시간
        	var nSecMilli = 1000;
        	var nMinMilli = 1000 * 60;
        	var nHrMilli = nMinMilli * 60;
        	var nDyMilli = nHrMilli * 24;

        	var objLoginDate = new Date(sLoginDate.substr(0, 4), sLoginDate.substr(4, 2), sLoginDate.substr(6, 2),
        		sLoginDate.substr(8, 2), sLoginDate.substr(10, 2), sLoginDate.substr(12, 2));
        	var objLogoutDate = new Date(sLogoutDate.substr(0, 4), sLogoutDate.substr(4, 2), sLogoutDate.substr(6, 2),
        		sLogoutDate.substr(8, 2), sLogoutDate.substr(10, 2), sLogoutDate.substr(12, 2));
        	var nDiffDate = objLogoutDate - objLoginDate;

        	var nDays = parseInt(nDiffDate / nDyMilli, 10);
        	var nHours = parseInt((nDiffDate / nHrMilli) % 24, 10);
        	var nMin = parseInt((nDiffDate / nMinMilli) % 60, 10);
        	var nSec = parseInt((nDiffDate / nSecMilli) % 60, 10);

        	var sRetVal = "";
        	if (nDays != 0) 
        	{
        		sRetVal += nDays + "일 ";
        	}
        	if (nHours != 0) 
        	{
        		sRetVal += nHours + "시간 ";
        	}
        	if (nMin != 0) 
        	{
        		sRetVal += nMin + "분 ";
        	}
        	if (nSec != 0) 
        	{
        		sRetVal += nSec + "초";
        	}
        	return (sRetVal);
        }

        this.gfn_GetDateMaskFormat = function (sDate,sMask,sDispSect)
        {
        	var sRtnVal = "";
        	if (sDate.length > 6) 
        	{
        		if (sDispSect == "1") 
        		{
        			sRtnVal = sDate.substr(0, 4) + sMask + sDate.substr(4, 2) + sMask + sDate.substr(6, 2);
        		}
        		else 
        		{
        			sRtnVal = sDate.substr(0, 4) + sMask + parseInt(sDate.substr(4, 2), 10) + sMask + parseInt(sDate.substr(6, 2), 10);
        		}
        	}
        	else if (sDate.length > 4) 
        	{
        		if (sDispSect == "1") 
        		{
        			sRtnVal = sDate.substr(0, 4) + sMask + sDate.substr(4, 2);
        		}
        		else 
        		{
        			sRtnVal = sDate.substr(0, 4) + sMask + parseInt(sDate.substr(4, 2), 10);
        		}
        	}
        	return sRtnVal;
        }

        /**********************************************************************************
         * 함수명      : utlf_GetHolidays
         * 설명        : 양력 nYear에 해당하는 년도의 법정 공휴일(양력) List 모두 구하기
         * argument     : nYear에 ( 년도 )( 예 : 2012 )
         * return Type : Array
         **********************************************************************************/
        this.gfn_GetHolidays = function (nYear)
        {
        	var nYear;
        	var aHoliday = new Array();

        	if (application.gfn_IsEmpty(nYear)) 
        	{
        		return aHoliday;
        	}

        	// ///// 음력 체크
        	// 구정
        	aHoliday[0] = this.gfn_Lunar2Solar("0" + (nYear - 1) + "1230") + "설날";
        	aHoliday[1] = this.gfn_AddDate(aHoliday[0], 1) + "설날";
        	aHoliday[2] = this.gfn_AddDate(aHoliday[1], 1) + "설날";
        	// 석가탄신일
        	aHoliday[3] = this.gfn_Lunar2Solar("0" + nYear + "0408") + "석가탄신일";
        	// 추석
        	aHoliday[4] = this.gfn_Lunar2Solar("0" + nYear + "0814") + "추석";
        	aHoliday[5] = this.gfn_AddDate(aHoliday[4], 1) + "추석";
        	aHoliday[6] = this.gfn_AddDate(aHoliday[5], 1) + "추석";

        	// ///// 양력 체크
        	aHoliday[7] = nYear + "0101" + "신정";
        	aHoliday[8] = nYear + "0301" + "삼일절";
        	aHoliday[9] = nYear + "0505" + "어린이날";
        	aHoliday[10] = nYear + "0606" + "현충일";
        	aHoliday[11] = nYear + "0815" + "광복절";
        	aHoliday[12] = nYear + "1225" + "성탄절";

        	return aHoliday.sort();
        }

        /**********************************************************************************
         * 함수명      : gfn_Lunar2Solar
         * 설명        : 음력을 양력으로 변환해주는 함수 (처리가능 기간  1841 - 2043년)
         * argument     : sDate ( 날짜 )( 예 : "20121122" )
         * return Type : String
         **********************************************************************************/
        this.gfn_Lunar2Solar = function (sDate)
        {
        	var sMd = "31,0,31,30,31,30,31,31,30,31,30,31";
        	var aMd = new Array();
        	var aBaseInfo = new Array();

        	var nLy,nLm,nLd,sLflag;
        	var nSy,nSm,nSd;
        	var y1,m1,i,j,y2,y3;
        	var leap;

        	if (application.gfn_IsEmpty(sDate)) 
        	{
        		return "";
        	}
        	if (sDate.length != 9) 
        	{
        		return "";
        	}

        	sLflag = sDate.substr(0, 1);
        	nLy = parseInt(sDate.substr(1, 4), 10);
        	nLm = parseInt(sDate.substr(5, 2), 10);
        	nLd = parseInt(sDate.substr(7, 2), 10);
        	if (nLy < 1841 || nLy > 2043) 
        	{
        		return "";
        	}
        	if (sLflag != "0" && sLflag != "1") 
        	{
        		return "";
        	}

        	aBaseInfo = this.gfn_SolarBase();
        	aMd = sMd.split(",");
        	if (this.gfn_IsLeapYear(sDate.substr(1, 8)) == true) 
        	{
        		aMd[1] = 29;
        	}
        	else 
        	{
        		aMd[1] = 28;
        	}

        	y1 = nLy - 1841;
        	m1 = nLm - 1;
        	leap = 0;
        	if (parseInt(aBaseInfo[y1 * 12 + m1], 10) > 2) 
        	{
        		leap = this.IsLeayYear(nLy + "0101");
        	}
        	var mm;
        	if (leap == 1) 
        	{
        		switch (parseInt(aBaseInfo[y1 * 12 + m1], 10)) 
        		{
        			case 3:
        				mm = 29;
        				break;
        			case 4:
        				mm = 30;
        				break;
        			case 5:
        				mm = 29;
        				break;
        			case 6:
        				mm = 30;
        				break;
        		}
        	}
        	else 
        	{
        		switch (parseInt(aBaseInfo[y1 * 12 + m1], 10)) 
        		{
        			case 1:
        				mm = 29;
        				break;
        			case 2:
        				mm = 30;
        				break;
        			case 3:
        				mm = 29;
        				break;
        			case 4:
        				mm = 29;
        				break;
        			case 5:
        				mm = 30;
        				break;
        			case 6:
        				mm = 30;
        				break;
        		}
        	}
        	var td;
        	td = 0;
        	for (i = 0; i <= y1 - 1; i++) 
        	{
        		for (j = 0; j <= 11; j++) 
        		{
        			switch (parseInt(aBaseInfo[i * 12 + j], 10)) 
        			{
        				case 1:
        					td = td + 29;
        					break;
        				case 2:
        					td = td + 30;
        					break;
        				case 3:
        					td = td + 58;
        					break;
        				case 4:
        					td = td + 59;
        					break;
        				case 5:
        					td = td + 59;
        					break;
        				case 6:
        					td = td + 60;
        					break;
        			}
        		}
        	}

        	for (j = 0; j <= m1 - 1; j++) 
        	{
        		switch (parseInt(aBaseInfo[y1 * 12 + j], 10)) 
        		{
        			case 1:
        				td = td + 29;
        				break;
        			case 2:
        				td = td + 30;
        				break;
        			case 3:
        				td = td + 58;
        				break;
        			case 4:
        				td = td + 58;
        				break;
        			case 5:
        				td = td + 59;
        				break;
        			case 6:
        				td = td + 60;
        				break;
        		}
        	}

        	if (leap == 1) 
        	{
        		switch (parseInt(aBaseInfo[y1 * 12 + m1], 10)) 
        		{
        			case 3:
        				mm = 29;
        				break;
        			case 4:
        				mm = 29;
        				break;
        			case 5:
        				mm = 30;
        				break;
        			case 6:
        				mm = 30;
        				break;
        		}
        	}

        	td = td + nLd + 22;

        	if (sLflag == "1") 
        	{
        		switch (parseInt(aBaseInfo[y1 * 12 + m1], 10)) 
        		{
        			case 3:
        				td = td + 29;
        				break;
        			case 4:
        				td = td + 30;
        				break;
        			case 5:
        				td = td + 29;
        				break;
        			case 6:
        				td = td + 30;
        				break;
        		}
        	}

        	y1 = 1840;
        	do {
        		y1 = y1 + 1;
        		leap = this.gfn_IsLeapYear(y1 + "0101");

        		if (leap == 1) 
        		{
        			y2 = 366;
        		}
        		else 
        		{
        			y2 = 365;
        		}

        		if (td <= y2) 
        		{
        			break;
        		}

        		td = td - y2;
        	} while (1);

        	nSy = y1;
        	aMd[1] = y2 - 337;
        	m1 = 0;
        	do {
        		m1 = m1 + 1;
        		if (td <= parseInt(aMd[m1 - 1], 10)) 
        		{
        			break;
        		}
        		td = td - parseInt(aMd[m1 - 1], 10);
        	} while (1);

        	nSm = m1;
        	nSd = td;
        	y3 = nSy;
        	td = y3 * 365 + parseInt(y3 / 4, 10) - parseInt(y3 / 100, 10) + parseInt(y3 / 400, 10);
        	for (i = 0; i <= nSm - 1; i++) 
        	{
        		td = td + parseInt(aMd[i], 10);
        	}

        	td = td + nSd;
        	return y3 + this.gfn_Right("0" + nSm, 2) + this.gfn_Right("0" + nSd, 2);
        }

        /**********************************************************************************
         * 함수명      : gfn_SolarBase
         * 설명        : 각 월별 음력 기준 정보를 처리하는 함수(처리가능 기간  1841 - 2043년)
         단, 내부에서 사용하는 함수임
         * argument     :
         * return Type : Array
         **********************************************************************************/
        this.gfn_SolarBase = function ()
        {
        	var kk;

        	// 1841
        	kk = "1,2,4,1,1,2,1,2,1,2,2,1,";
        	kk += "2,2,1,2,1,1,2,1,2,1,2,1,";
        	kk += "2,2,2,1,2,1,4,1,2,1,2,1,";
        	kk += "2,2,1,2,1,2,1,2,1,2,1,2,";
        	kk += "1,2,1,2,2,1,2,1,2,1,2,1,";
        	kk += "2,1,2,1,5,2,1,2,2,1,2,1,";
        	kk += "2,1,1,2,1,2,1,2,2,2,1,2,";
        	kk += "1,2,1,1,2,1,2,1,2,2,2,1,";
        	kk += "2,1,2,3,2,1,2,1,2,1,2,2,";
        	kk += "2,1,2,1,1,2,1,1,2,2,1,2,";
        	// 1851
        	kk += "2,2,1,2,1,1,2,1,2,1,5,2,";
        	kk += "2,1,2,2,1,1,2,1,2,1,1,2,";
        	kk += "2,1,2,2,1,2,1,2,1,2,1,2,";
        	kk += "1,2,1,2,1,2,5,2,1,2,1,2,";
        	kk += "1,1,2,1,2,2,1,2,2,1,2,1,";
        	kk += "2,1,1,2,1,2,1,2,2,2,1,2,";
        	kk += "1,2,1,1,5,2,1,2,1,2,2,2,";
        	kk += "1,2,1,1,2,1,1,2,2,1,2,2,";
        	kk += "2,1,2,1,1,2,1,1,2,1,2,2,";
        	kk += "2,1,6,1,1,2,1,1,2,1,2,2,";
        	// 1861
        	kk += "1,2,2,1,2,1,2,1,2,1,1,2,";
        	kk += "2,1,2,1,2,2,1,2,2,3,1,2,";
        	kk += "1,2,2,1,2,1,2,2,1,2,1,2,";
        	kk += "1,1,2,1,2,1,2,2,1,2,2,1,";
        	kk += "2,1,1,2,4,1,2,2,1,2,2,1,";
        	kk += "2,1,1,2,1,1,2,2,1,2,2,2,";
        	kk += "1,2,1,1,2,1,1,2,1,2,2,2,";
        	kk += "1,2,2,3,2,1,1,2,1,2,2,1,";
        	kk += "2,2,2,1,1,2,1,1,2,1,2,1,";
        	kk += "2,2,2,1,2,1,2,1,1,5,2,1,";
        	// 1871
        	kk += "2,2,1,2,2,1,2,1,2,1,1,2,";
        	kk += "1,2,1,2,2,1,2,1,2,2,1,2,";
        	kk += "1,1,2,1,2,4,2,1,2,2,1,2,";
        	kk += "1,1,2,1,2,1,2,1,2,2,2,1,";
        	kk += "2,1,1,2,1,1,2,1,2,2,2,1,";
        	kk += "2,2,1,1,5,1,2,1,2,2,1,2,";
        	kk += "2,2,1,1,2,1,1,2,1,2,1,2,";
        	kk += "2,2,1,2,1,2,1,1,2,1,2,1,";
        	kk += "2,2,4,2,1,2,1,1,2,1,2,1,";
        	kk += "2,1,2,2,1,2,2,1,2,1,1,2,";
        	// 1881
        	kk += "1,2,1,2,1,2,5,2,2,1,2,1,";
        	kk += "1,2,1,2,1,2,1,2,2,1,2,2,";
        	kk += "1,1,2,1,1,2,1,2,2,2,1,2,";
        	kk += "2,1,1,2,3,2,1,2,2,1,2,2,";
        	kk += "2,1,1,2,1,1,2,1,2,1,2,2,";
        	kk += "2,1,2,1,2,1,1,2,1,2,1,2,";
        	kk += "2,2,1,5,2,1,1,2,1,2,1,2,";
        	kk += "2,1,2,2,1,2,1,1,2,1,2,1,";
        	kk += "2,1,2,2,1,2,1,2,1,2,1,2,";
        	kk += "1,5,2,1,2,2,1,2,1,2,1,2,";
        	// 1891
        	kk += "1,2,1,2,1,2,1,2,2,1,2,2,";
        	kk += "1,1,2,1,1,5,2,2,1,2,2,2,";
        	kk += "1,1,2,1,1,2,1,2,1,2,2,2,";
        	kk += "1,2,1,2,1,1,2,1,2,1,2,2,";
        	kk += "2,1,2,1,5,1,2,1,2,1,2,1,";
        	kk += "2,2,2,1,2,1,1,2,1,2,1,2,";
        	kk += "1,2,2,1,2,1,2,1,2,1,2,1,";
        	kk += "2,1,5,2,2,1,2,1,2,1,2,1,";
        	kk += "2,1,2,1,2,1,2,2,1,2,1,2,";
        	kk += "1,2,1,1,2,1,2,5,2,2,1,2,";
        	// 1901
        	kk += "1,2,1,1,2,1,2,1,2,2,2,1,";
        	kk += "2,1,2,1,1,2,1,2,1,2,2,2,";
        	kk += "1,2,1,2,3,2,1,1,2,2,1,2,";
        	kk += "2,2,1,2,1,1,2,1,1,2,2,1,";
        	kk += "2,2,1,2,2,1,1,2,1,2,1,2,";
        	kk += "1,2,2,4,1,2,1,2,1,2,1,2,";
        	kk += "1,2,1,2,1,2,2,1,2,1,2,1,";
        	kk += "2,1,1,2,2,1,2,1,2,2,1,2,";
        	kk += "1,5,1,2,1,2,1,2,2,2,1,2,";
        	kk += "1,2,1,1,2,1,2,1,2,2,2,1,";
        	// 1911
        	kk += "2,1,2,1,1,5,1,2,2,1,2,2,";
        	kk += "2,1,2,1,1,2,1,1,2,2,1,2,";
        	kk += "2,2,1,2,1,1,2,1,1,2,1,2,";
        	kk += "2,2,1,2,5,1,2,1,2,1,1,2,";
        	kk += "2,1,2,2,1,2,1,2,1,2,1,2,";
        	kk += "1,2,1,2,1,2,2,1,2,1,2,1,";
        	kk += "2,3,2,1,2,2,1,2,2,1,2,1,";
        	kk += "2,1,1,2,1,2,1,2,2,2,1,2,";
        	kk += "1,2,1,1,2,1,5,2,2,1,2,2,";
        	kk += "1,2,1,1,2,1,1,2,2,1,2,2,";
        	// 1921
        	kk += "2,1,2,1,1,2,1,1,2,1,2,2,";
        	kk += "2,1,2,2,3,2,1,1,2,1,2,2,";
        	kk += "1,2,2,1,2,1,2,1,2,1,1,2,";
        	kk += "2,1,2,1,2,2,1,2,1,2,1,1,";
        	kk += "2,1,2,5,2,1,2,2,1,2,1,2,";
        	kk += "1,1,2,1,2,1,2,2,1,2,2,1,";
        	kk += "2,1,1,2,1,2,1,2,2,1,2,2,";
        	kk += "1,5,1,2,1,1,2,2,1,2,2,2,";
        	kk += "1,2,1,1,2,1,1,2,1,2,2,2,";
        	kk += "1,2,2,1,1,5,1,2,1,2,2,1,";
        	// 1931
        	kk += "2,2,2,1,1,2,1,1,2,1,2,1,";
        	kk += "2,2,2,1,2,1,2,1,1,2,1,2,";
        	kk += "1,2,2,1,6,1,2,1,2,1,1,2,";
        	kk += "1,2,1,2,2,1,2,2,1,2,1,2,";
        	kk += "1,1,2,1,2,1,2,2,1,2,2,1,";
        	kk += "2,1,4,1,2,1,2,1,2,2,2,1,";
        	kk += "2,1,1,2,1,1,2,1,2,2,2,1,";
        	kk += "2,2,1,1,2,1,4,1,2,2,1,2,";
        	kk += "2,2,1,1,2,1,1,2,1,2,1,2,";
        	kk += "2,2,1,2,1,2,1,1,2,1,2,1,";
        	// 1941
        	kk += "2,2,1,2,2,4,1,1,2,1,2,1,";
        	kk += "2,1,2,2,1,2,2,1,2,1,1,2,";
        	kk += "1,2,1,2,1,2,2,1,2,2,1,2,";
        	kk += "1,1,2,4,1,2,1,2,2,1,2,2,";
        	kk += "1,1,2,1,1,2,1,2,2,2,1,2,";
        	kk += "2,1,1,2,1,1,2,1,2,2,1,2,";
        	kk += "2,5,1,2,1,1,2,1,2,1,2,2,";
        	kk += "2,1,2,1,2,1,1,2,1,2,1,2,";
        	kk += "2,2,1,2,1,2,3,2,1,2,1,2,";
        	kk += "2,1,2,2,1,2,1,1,2,1,2,1,";
        	// 1951
        	kk += "2,1,2,2,1,2,1,2,1,2,1,2,";
        	kk += "1,2,1,2,4,2,1,2,1,2,1,2,";
        	kk += "1,2,1,1,2,2,1,2,2,1,2,2,";
        	kk += "1,1,2,1,1,2,1,2,2,1,2,2,";
        	kk += "2,1,4,1,1,2,1,2,1,2,2,2,";
        	kk += "1,2,1,2,1,1,2,1,2,1,2,2,";
        	kk += "2,1,2,1,2,1,1,5,2,1,2,2,";
        	kk += "1,2,2,1,2,1,1,2,1,2,1,2,";
        	kk += "1,2,2,1,2,1,2,1,2,1,2,1,";
        	kk += "2,1,2,1,2,5,2,1,2,1,2,1,";
        	// 1961
        	kk += "2,1,2,1,2,1,2,2,1,2,1,2,";
        	kk += "1,2,1,1,2,1,2,2,1,2,2,1,";
        	kk += "2,1,2,3,2,1,2,1,2,2,2,1,";
        	kk += "2,1,2,1,1,2,1,2,1,2,2,2,";
        	kk += "1,2,1,2,1,1,2,1,1,2,2,1,";
        	kk += "2,2,5,2,1,1,2,1,1,2,2,1,";
        	kk += "2,2,1,2,2,1,1,2,1,2,1,2,";
        	kk += "1,2,2,1,2,1,5,2,1,2,1,2,";
        	kk += "1,2,1,2,1,2,2,1,2,1,2,1,";
        	kk += "2,1,1,2,2,1,2,1,2,2,1,2,";
        	// 1971
        	kk += "1,2,1,1,5,2,1,2,2,2,1,2,";
        	kk += "1,2,1,1,2,1,2,1,2,2,2,1,";
        	kk += "2,1,2,1,1,2,1,1,2,2,2,1,";
        	kk += "2,2,1,5,1,2,1,1,2,2,1,2,";
        	kk += "2,2,1,2,1,1,2,1,1,2,1,2,";
        	kk += "2,2,1,2,1,2,1,5,2,1,1,2,";
        	kk += "2,1,2,2,1,2,1,2,1,2,1,1,";
        	kk += "2,2,1,2,1,2,2,1,2,1,2,1,";
        	kk += "2,1,1,2,1,6,1,2,2,1,2,1,";
        	kk += "2,1,1,2,1,2,1,2,2,1,2,2,";
        	// 1981
        	kk += "1,2,1,1,2,1,1,2,2,1,2,2,";
        	kk += "2,1,2,3,2,1,1,2,2,1,2,2,";
        	kk += "2,1,2,1,1,2,1,1,2,1,2,2,";
        	kk += "2,1,2,2,1,1,2,1,1,5,2,2,";
        	kk += "1,2,2,1,2,1,2,1,1,2,1,2,";
        	kk += "1,2,2,1,2,2,1,2,1,2,1,1,";
        	kk += "2,1,2,2,1,5,2,2,1,2,1,2,";
        	kk += "1,1,2,1,2,1,2,2,1,2,2,1,";
        	kk += "2,1,1,2,1,2,1,2,2,1,2,2,";
        	kk += "1,2,1,1,5,1,2,1,2,2,2,2,";
        	// 1991
        	kk += "1,2,1,1,2,1,1,2,1,2,2,2,";
        	kk += "1,2,2,1,1,2,1,1,2,1,2,2,";
        	kk += "1,2,5,2,1,2,1,1,2,1,2,1,";
        	kk += "2,2,2,1,2,1,2,1,1,2,1,2,";
        	kk += "1,2,2,1,2,2,1,5,2,1,1,2,";
        	kk += "1,2,1,2,2,1,2,1,2,2,1,2,";
        	kk += "1,1,2,1,2,1,2,2,1,2,2,1,";
        	kk += "2,1,1,2,3,2,2,1,2,2,2,1,";
        	kk += "2,1,1,2,1,1,2,1,2,2,2,1,";
        	kk += "2,2,1,1,2,1,1,2,1,2,2,1,";
        	// 2001
        	kk += "2,2,2,3,2,1,1,2,1,2,1,2,";
        	kk += "2,2,1,2,1,2,1,1,2,1,2,1,";
        	kk += "2,2,1,2,2,1,2,1,1,2,1,2,";
        	kk += "1,5,2,2,1,2,1,2,2,1,1,2,";
        	kk += "1,2,1,2,1,2,2,1,2,2,1,2,";
        	kk += "1,1,2,1,2,1,5,2,2,1,2,2,";
        	kk += "1,1,2,1,1,2,1,2,2,2,1,2,";
        	kk += "2,1,1,2,1,1,2,1,2,2,1,2,";
        	kk += "2,2,1,1,5,1,2,1,2,1,2,2,";
        	kk += "2,1,2,1,2,1,1,2,1,2,1,2,";
        	// 2011
        	kk += "2,1,2,2,1,2,1,1,2,1,2,1,";
        	kk += "2,1,6,2,1,2,1,1,2,1,2,1,";
        	kk += "2,1,2,2,1,2,1,2,1,2,1,2,";
        	kk += "1,2,1,2,1,2,1,2,5,2,1,2,";
        	kk += "1,2,1,1,2,1,2,2,2,1,2,2,";
        	kk += "1,1,2,1,1,2,1,2,2,1,2,2,";
        	kk += "2,1,1,2,3,2,1,2,1,2,2,2,";
        	kk += "1,2,1,2,1,1,2,1,2,1,2,2,";
        	kk += "2,1,2,1,2,1,1,2,1,2,1,2,";
        	kk += "2,1,2,5,2,1,1,2,1,2,1,2,";
        	// 2021
        	kk += "1,2,2,1,2,1,2,1,2,1,2,1,";
        	kk += "2,1,2,1,2,2,1,2,1,2,1,2,";
        	kk += "1,5,2,1,2,1,2,2,1,2,1,2,";
        	kk += "1,2,1,1,2,1,2,2,1,2,2,1,";
        	kk += "2,1,2,1,1,5,2,1,2,2,2,1,";
        	kk += "2,1,2,1,1,2,1,2,1,2,2,2,";
        	kk += "1,2,1,2,1,1,2,1,1,2,2,2,";
        	kk += "1,2,2,1,5,1,2,1,1,2,2,1,";
        	kk += "2,2,1,2,2,1,1,2,1,1,2,2,";
        	kk += "1,2,1,2,2,1,2,1,2,1,2,1,";
        	// 2031
        	kk += "2,1,5,2,1,2,2,1,2,1,2,1,";
        	kk += "2,1,1,2,1,2,2,1,2,2,1,2,";
        	kk += "1,2,1,1,2,1,5,2,2,2,1,2,";
        	kk += "1,2,1,1,2,1,2,1,2,2,2,1,";
        	kk += "2,1,2,1,1,2,1,1,2,2,1,2,";
        	kk += "2,2,1,2,1,4,1,1,2,1,2,2,";
        	kk += "2,2,1,2,1,1,2,1,1,2,1,2,";
        	kk += "2,2,1,2,1,2,1,2,1,1,2,1,";
        	kk += "2,2,1,2,5,2,1,2,1,2,1,1,";
        	kk += "2,1,2,2,1,2,2,1,2,1,2,1,";
        	// 2041
        	kk += "2,1,1,2,1,2,2,1,2,2,1,2,";
        	kk += "1,5,1,2,1,2,1,2,2,2,1,2,";
        	kk += "1,2,1,1,2,1,1,2,2,1,2,2";

        	var arr = new Array();
        	arr = kk.split(",");

        	return arr;
        }

        /*******************************************************************************
         * 기      능   : 월요일의 일자 또는 월요일로부터 argIdx 일의 후의 일자를 argFormat 형태로 반환하는 함수.
         * 설      명   : argIdx : 월요일부터 +되는 일자
         argFormat : 출력하는 날짜의 포멧
         ********************************************************************************/
        this.gfn_getFirstDate = function (argIdx,argFormat)
        {
        	var objDate = new Date();
        	objDate.addDate(-objDate.getDay() + 1);
        	if (argIdx == "") 
        	{
        		//return objDate.toFormatString(argFormat);
        	}
        	else 
        	{
        		objDate.addDate(argIdx);
        		//return objDate.toFormatString(argFormat);
        	}
        	trace("------");
        	return this.gfn_DateFormatString(objDate, argFormat); 
        }

        
        /*******************************************************************************
         * Function명 : gfn_getYearList
         * 설명          : 현재부터 n년 간의 년도를 Dataset으로 넘겨준다
         * parameter  : argN : 반복되는 횟수
         * return        : string
         ******************************************************************************/
        this.gfn_getYearList = function (argN)
        {
        	var strToday = "";
        	var objDate = new Date();
        	var ds_Year = new Dataset;
        	var nRow, i;
        	
        	ds_Year.addColumn("year", "string", 4);

        	var yyyy = objDate.getFullYear();
        	var nYear = nexacro.toNumber(yyyy);
        	
        	for(i = 0; i < argN; i++)
        	{
        		nRow = ds_Year.addRow();

        		nYear = nexacro.toNumber(yyyy) - i;
        		
        		ds_Year.setColumn(nRow, "year", nYear);
        	}
        	
        	objDate = null;

        	return ds_Year;
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

        //================================================================================
        // Date Common Stript
        //================================================================================
        /*------------------------------------------------------------------
        /기능 : 현재일자, 주 코드, 주 명칭(한글), 주 명칭(한자), 주 명칭(영문)
        /인수 : rMonth-- 반환할 오브젝트, fMonth ~부터, tMonth~까지
        /리턴 : 총개월수
        		ymd 	-> yyyymmdd 일자
        		ymdtm 	-> yyyymmddhh24miss 일자(8)+hhmmss(6)
        		tm 		-> hhmmss(6) [ 시분초 중 시는 24시간으로 표현됨 ]
        		w_cd 	-> Week Code (일 ∼ 토 : 1 ∼ 7)
        		w_kor 	-> Week Name (한글) 
        		w_cha 	-> Week Name (한자)
        		w_eng 	-> Week Name (영문)
        		
        ------------------------------------------------------------------*/
        var v_rtn_cd;
        this.fn_CurrDateWeek = function (rtn_cd)
        {
        	var	v_result;
        	// 초기화(디데이)
        	//application.gds_currdate.clearData();
        	
        	this.fsp_clear();
        	this.fsp_addSearch("sc/scz:SCZ_CURR_DATE", false);
        	// connect the server 
        	this.fsp_callService(this, "", "", "", "gds_currdate=gds_currdate", "", "fn_searchCode", false, false, true);	
        	
        	switch(rtn_cd)
        	{
        		case "ymd" : 
        			v_result = application.gds_currdate.getColumn(0, "YMD"); 
        			break;
        		case "ymdtm" : 
        			v_result = application.gds_currdate.getColumn(0, "YMD_TM"); 
        			break;
        		case "tm" : 
        			v_result = this.gfn_subStr(application.gds_currdate.getColumn(0, "YMD_TM"),8,6); 
        			break;
        		case "w_cd" : 
        			v_result = application.gds_currdate.getColumn(0, "WEEK_CD"); 
        			break;
        		case "w_kor" : 
        			v_result = application.gds_currdate.getColumn(0, "WEEK_KOR"); 
        			break;
        		case "w_cha" : 
        			v_result = application.gds_currdate.getColumn(0, "WEEK_CHA"); 
        			break;
        		case "w_eng" : 
        			v_result = application.gds_currdate.getColumn(0, "WEEK_ENG"); 
        			break;
        		default:
        			v_result = application.gds_currdate.getColumn(0, "YMD"); 
        	} 
        	
        	return	v_result;
        }

        
        this.fn_searchCode = function (errCode,errMsg) {	
        	
        }

        /**********************************************************************************
         * 함수명      : dateTime
         * 설명        : MiPlatform에서 사용하던 Datetime형식으로 변환
         *               Date Type을 String으로 변환
         * argument    : nYear (년도)
         *               nMonth (월)
         *               nDate (일)
         * return Type : String
         * return 내용 : 조합한 날짜를 리턴
        **********************************************************************************/
        this.dateTime = function (nYear,nMonth,nDate){
        	 
        	var args = this.dateTime.arguments;
        	var dateObj;
        	var nLen;
        	
        	switch(args.length) {
        		case 1:
        			dateObj = new Date(this.getMaskFormat(args[0], "@@@@-@@-@@ @@:@@:@@"));
        			if(this.gfn_isNull(dateObj)) {
        				dateObj = new Date(args[0]);
        			}
        			nLen = args[0].length;
        			break;
        		case 3:
        			dateObj = new Date(args[0], args[1]-1, args[2]);
        			nLen = 8;
        			break;
        		default:
        			dateObj = new Date(args[0], args[1]-1, args[2], nvl(args[3], 0), nvl(args[4],0), nvl(args[5], 0));
        			nLen = 12;
        			break;
        	}
        	
        	var formatString;
        	switch(nLen) {
        		case 4:
        		case 6:
        		case 8:
        			formatString = "%Y%m%d";
        			break;
        		default:
        			formatString = "%Y%m%d%H%M%S";
        			break;
        	}
        	return dateObj.toFormatString(formatString);
        }

        /**********************************************************************************
         * 함수명     : G_fn_GapTime
         * 설명        : 두시간간의 시간차 
         * argument    : day : 일자 
         *               ftime :시작시간)
         *               ttime : 끝시간
         *				 tp : 시간 인자 형식
         * return Type : String
         * return 내용 : 시간차 반환
        **********************************************************************************/
        this.G_fn_GapTime = function (day,ftime,ttime,tp)
        {	
        	var v_time1;
        	var v_time2;	
        	var v_ret_hh;
        	var v_ret_mm;	
        	var v_day_time;
        	
        	v_day_time	= nexacro.toNumber(day) * 24;
        	
        	if(tp==":"){
        		v_time1	=this.gfn_split(ftime, ":");
        		v_time2	=this.gfn_split(ttime, ":");
        	}else{
        		v_time1 	=new Array(2);
        		v_time2 	=new Array(2);
        		v_time1[0]	=ftime.substr(0,2);
        		//v_time1[0]	=Left(ftime,2); //오동작
        		
        		v_time1[1]	= ftime.substr(2,2);
        		//v_time1[1]	=gfn_mid(ftime,2,2); //오동작
        		
        		v_time2[0]	= this.gfn_Trim(ttime).substr(0,2);
        		//v_time2[0]	= Left(ttime,2); //오동작
        		v_time2[1]	= this.gfn_Trim(ttime).substr(2,2);
        		//v_time2[1]	=gfn_mid(ttime,2,2); //오동작
        	}	
        		
        	v_ret_hh	= nexacro.toNumber(v_time2[0]) - nexacro.toNumber(v_time1[0]);	
        	v_ret_hh	= nexacro.toNumber(v_day_time) + nexacro.toNumber(v_ret_hh);	
        	v_ret_mm	= nexacro.toNumber(v_time2[1]) - nexacro.toNumber(v_time1[1]);	
        	
        	if(v_ret_mm<0){
        		v_ret_hh	= v_ret_hh-1;
        		v_ret_mm	= 60 + v_ret_mm;
        	}
        	
        	v_ret_hh	= this.gfn_Right("0" + v_ret_hh, 2);
        	v_ret_mm	= this.gfn_Right("0" + v_ret_mm, 2);
        	
        	if(tp==":"){
        		return v_ret_hh +":" + v_ret_mm;
        	}else{
        		return v_ret_hh + v_ret_mm;
        	}
        }

        /**********************************************************************************
         * 함수명     : G_fn_CalcDay
         * 설명        : 입력받은 from월로부터 입력to월까지 개월수반환하기
         * argument    : rMonth-- 반환할 오브젝트, fMonth ~부터, tMonth~까지
         * return Type : String
         * return 내용 : 총일수 반환
        **********************************************************************************/
        this.G_fn_CalcDay = function (fdate,tdate)
        {
        	//return /* ParseDateTime은 지원되지 않는 메서드입니다. ParseDateTime은 지원되지 않는 메서드입니다.*/ gfn_strToDate(tdate) - gfn_strToDate(fdate); 
        	var iMonth    = 0; //계산된 개월수
        	var iYear     = 0; //계산된 년도
        	var iday      = 0; //계산된 일수
        	var iMonthday = 0; //계산된 월의 일수
        	var rDay    = 0; 	//반환할 개월수

        	if(parseInt(fdate) <= parseInt(tdate)){

        	iYear  = parseInt(tdate.substr(0,4)) - parseInt(fdate.substr(0,4)) ;
        	iMonth = parseInt(nexacro.toNumber(tdate.substr(4,2))) - parseInt(nexacro.toNumber(fdate.substr(4,2)));  	 

        		if ( iMonth > 1 )
        		{
        			for( i=1 ;i < iMonth; i++)
        			{
        		
        			iMonthday += this.G_fn_MonthLastDay( nexacro.toNumber(fdate.substr(4,2)) + i );
        		
        			}
        		}

        		if( iMonth == 0 )
        		{
        			iday  =  parseInt(nexacro.toNumber(tdate.substr(6,2))) - parseInt(nexacro.toNumber(fdate.substr(6,2)));
        		} else
        		{
        			iday  = this.G_fn_MonthLastDay(nexacro.toNumber(fdate.substr(4,2))) - parseInt(nexacro.toNumber(fdate.substr(6,2)));
        			iday  = iday + parseInt(nexacro.toNumber(tdate.substr(6,2)));
        		}

        		rDay = (365 * iYear) + iMonthday + iday;

        		return rDay;

        	}else {
        		return 0;
        	}
          
        }

        /**********************************************************************************
         * 함수명     : G_fn_MonthLastDay
         * 설명        : 월에 마지막 날을 가져온다
         * argument    : 월
         * return Type : String
         * return 내용 : 마지막날
        **********************************************************************************/
        this.G_fn_MonthLastDay = function (fmonth)
        {
        	if ( fmonth == 1 )
        		return 31;  
        	if ( fmonth == 2 )
        		return 29;  
        	if ( fmonth == 3 )
        		return 31;  
        	if ( fmonth == 4 )
        		return 30;  
        	if ( fmonth == 5 )
        		return 31;  
        	if ( fmonth == 6 )
        		return 30;  
        	if ( fmonth == 7 )
        		return 31;  
        	if ( fmonth == 8 )
        		return 31;  
        	if ( fmonth == 9 )
        		return 30;  
        	if ( fmonth == 10 )
        		return 31;  
        	if ( fmonth == 11 )
        		return 30;  
        	if ( fmonth == 12 )
        		return 31;
        }

        /**********************************************************************************
         * 함수명     : fn_DayToWeek
         * 설명        : 해당 날짜에 대한 요일반환
         * argument    :  일자
         * return Type : String
         * return 내용 : 요일
        **********************************************************************************/
        this.fn_DayToWeek = function (day,tp)
        {
            var aWeeksA = new Array(7);		
            var aWeeksB = new Array(7);		
            var aWeeksC = new Array(7);		
            var aWeeksD = new Array(7);		
            var ls_WeeksA = "일;월;화;수;목;금;토";
            var ls_WeeksB = "SUN;MON;TUE;WED;THU;FRI;SAT";
            var ls_WeeksC = "Sun;Mon;Tue;Wed;Thu;Fri;Sat";
            var ls_WeeksD = "日;月;火;水;木;金;土";

        	aWeeksA = this.gfn_split(ls_WeeksA,";");	
        	aWeeksB = this.gfn_split(ls_WeeksB,";");	
        	aWeeksC = this.gfn_split(ls_WeeksC,";");	
        	aWeeksD = this.gfn_split(ls_WeeksD,";");	

        	switch(tp)
        	{
        		case "0":
        			return aWeeksA[this.gfn_GetDay(day)];
        		case "1":
        			return aWeeksB[this.gfn_GetDay(day)];
        		case "2":
        			return aWeeksC[this.gfn_GetDay(day)];
        		case "3":
        			return aWeeksD[this.gfn_GetDay(day)];
        		default:
        			return aWeeksA[this.gfn_GetDay(day)];
        	}
        }

        /**********************************************************************************
         * 함수명      : this.gfn_IsTime
         * 설명        : 시간 정합성 체크
         * argument     :  시간
         * return Type  : Boolean 
         * return 내용 : 형식의 정합성 체크
        **********************************************************************************/
        this.gfn_IsTime = function (val) 
        {
            if (this.gfn_IsDigit(val) != true) {
                return false;
            }
            
            if (val.trim().toString().length != 6) {
                return false;
            }
            
            var nHH = nexacro.toNumber(val.toString().substr(0, 2));
            var nMM = nexacro.toNumber(val.toString().substr(2, 2));
            var nSS = nexacro.toNumber(val.toString().substr(4, 2));
            
            if(this.gfn_isNull(nHH) || this.gfn_isNull(nMM) || this.gfn_isNull(nMM)) {
                return false;
            }
            
            if(nHH > 23 || nHH < 0) {
                return false;
            }
            
            if(nMM > 59 || nMM < 0) {
                return false;
            }
            
            if(nSS > 59 || nSS < 0) {
                return false;
            }
            
            return true;
        }

        /**********************************************************************************
         * 함수명      : this.gfn_IsDigit
         * 설명        : 숫자 정합성 체크
         * argument     : 입력문자열
         * return Type  : Boolean 
         * return 내용 : 형식의 정합성 체크
        **********************************************************************************/
        this.gfn_IsDigit = function (val) {
            var lvNum;
            var lvFlag   = "No";
            var lvRetVal = false;
            var lvLength;
            var i;
            
            if (this.gfn_isNull(val) == true) {
                lvFlag      = "Yes";
                lvRetVal = false;
                return lvRetVal;
            }
            
            lvLength = val.length;
            
            if ((val.toString().split(".").length > 2) && lvFlag == "No") {
                lvFlag   = "Yes";
                lvRetVal = false;
            }
            
            if (lvFlag == "No") {
                for (i = 0; i < lvLength ; i++) {
                    lvNum = val.substr(i,1);
                    if (i == 0) {
                        if(this.gfn_isNum(lvNum) || (lvNum == "-" && val.substr(1, 1) != ".")
                            || (lvNum == "+"  && val.substr(1, 1) != ".")){
                            lvRetVal = true;
                        } else {
                            lvRetVal = false;
                            break;
                        }
                    } else {
                        if(this.gfn_isNum(lvNum) || (lvNum == "." && val.substr(i+1, 1).length != 0)) {
                            lvRetVal = true;
                        } else {
                            lvRetVal = false;
                            break;
                        }
                    }
                }
            }

            return lvRetVal;
        }

        /**********************************************************************************
         * 함수명      : this.gfn_IsDigit
         * 설명        : 문자열이 숫자형식에 맞는지 여부 체크
         * argument     : 체크할 문자열숫자 ( 예 : "-1234.56" ) (단, ","가 들어있으면 안 됨)
         * return Type  : Boolean 
         * return 내용 : 형식의 정합성 체크
        **********************************************************************************/  
        this.gfn_isNum = function (sNum)
        {
        	var c;
        	var point_cnt = 0;
        	var ret = true;

        	if (this.gfn_isNull(sNum)) 
        	{
        		return false;
        	}

        	for (var i = 0; i < sNum.length; i++) 
        	{
        		c = sNum.charAt(i);
        		if (i == 0 && (c == "+" || c == "-")) 
        		{
        		}
        		else if (c >= "0" && c <= "9") 
        		{
        		}
        		else if (c == ".") 
        		{
        			point_cnt++;
        			if (point_cnt > 1) 
        			{
        				ret = false;
        				break;
        			}
        		}
        		else 
        		{
        			ret = false;
        			break;
        		}
        	}

        	return ret;
        }

        
        });


    
        this.loadIncludeScript(path, true);
        
        obj = null;
    };
}
)();
