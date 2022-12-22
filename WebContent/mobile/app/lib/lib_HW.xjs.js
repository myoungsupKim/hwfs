﻿//XJS=lib_HW.xjs
(function()
{
    return function(path)
    {
        var obj;
    
        // User Script
        this.registerScript(path, function(exports) {
        /*********************************************************************************************
         * @type   : function
         * @access : public
         * @desc   : Tab의 CSS를 변경해준다. (탭 클릭 처리)
         * @param  : objNow : 클릭된 탭, objPrev : 이전 탭
         * @return :
         *********************************************************************************************/
        this.gfn_goTop = function (objNow,objPrev)
        {
        	
        }

        /*********************************************************************************************
        ** function name        : gf_SetGridCheckAll()
        ** function description : 그리드 헤더에 All 클릭시 체크/해제
        ** argument             : obj				Grid Object
        **                        e					GridClickEventInfo;
        ** return Type          : 
        ** return description   : 
        *********************************************************************************************/
        application.gv_IsGridCheckAll = 0;
        this.gf_SetGridCheckAll = function (obj,colName)
        {
        	var dsObj = eval("this."+obj.binddataset);
        	// var v_Colid = obj.getCellProperty("body", e.cell, "text").replace("bind:", "");
        	var v_Colid = colName;
        	
        	trace(v_Colid);
        	
        	application.gv_IsGridCheckAll = (application.gv_IsGridCheckAll ? 0 : 1);
        	
        	dsObj.enableevent = false;
        	for (var i=0; i<dsObj.getRowCount(); i++) {
        		dsObj.setColumn(i, v_Colid, application.gv_IsGridCheckAll);
        	}
        	obj.setCellProperty( "Head", 0, "expr", application.gv_IsGridCheckAll);
        	dsObj.enableevent = true;
        }

        /*********************************************************************************************
        ** function name        : gf_calcDistance()
        ** function description : 위동 경도값에 따른 거리계산
        ** argument             : lat1				위도1
        **                        lon1				경도1
        **                        lat2				위도2
        **                        lon2				경도2
        **                        gubun				구분값(Y:거리단위 미표시)
        ** return Type          : 
        ** return description   : rtn(거리)
        *********************************************************************************************/
        this.gf_calcDistance = function (lat1,lon1,lat2,lon2,gubun){

        	var EARTH_R, Rad, radLat1, radLat2, radDist; 
        	var distance, ret;

        	EARTH_R = 6371000.0;
        	Rad 		= Math.PI/180;

        	radLat1 = Rad * lat1;
        	radLat2 = Rad * lat2;
        	radDist = Rad * (lon1 - lon2);            

        	distance = Math.sin(radLat1) * Math.sin(radLat2);
        	distance = distance + Math.cos(radLat1) * Math.cos(radLat2) * Math.cos(radDist);

        	ret 		= EARTH_R * Math.acos(distance);						

        	var rtn = Math.round(Math.round(ret) / 1000);            
        	
        	if(gubun == "Y"){
        		rtn = Math.round(ret);
        	}else if(rtn <= 0){
        		rtn = Math.round(ret) + " m";
        	}else{
        		rtn = rtn + " km";
        	}           

        	return  rtn;
        }

        /*********************************************************************************************
        ** function name        : FindRowNF()
        ** function description : 데이터셋의 지정한 열(column)에서 입력된 값과 일치하는 데이터를 갖는 첫번째 행(row)의 위치를 찾음
        ** argument             : dataset
        ** return Type          : var
        ** return description   : 
        *********************************************************************************************/
        this.FindRowNF = function (XDataObject,strColID,strVal,nStart,nEnd){

        	var rtnVal;
        	var strOrgFilter = XDataObject.filterstr.valueOf();
        	
        	XDataObject.enableevent = false;
        		XDataObject.filter("");
        		if(application.gfn_IsNull(nStart)) nStart = 0;
        		if(application.gfn_IsNull(nEnd)) 
        			nEnd = -1;
        		else
        			nEnd = nEnd + 1;
        		rtnVal = XDataObject.findRow(strColID,strVal,nStart,nEnd);
        		XDataObject.filter(strOrgFilter);
        	XDataObject.enableevent = true;
        	
        	return rtnVal;
        }

        /*********************************************************************************************
        ** function name        : fn_common_code
        ** function description : 공통코드호출(이미지전송시 콤보권한 컨트롤, 팀장승인시 콤보권한 컨트롤)
        ** argument             : groupCode      공통그룹코드
        ** 						  code           공통코드
        **                        gubun          구분값(이미지전송관련)
        **                        comboGubun     콤보구분값
        ** return Type          : gds_common_code
        ** return description   : gds_common_code
        *********************************************************************************************/
        this.fn_common_code = function (groupCode,code,gubun,comboGubun,StrQuery){

        	var query = "";
        	application.gds_common_code.clearData();
        	
        	//이미지전송시 PC RUNTIME화면 권한에 따라 등록구분콤보 권한 제어
        	if(comboGubun == "IMAGE")
        	{
        		//CS진단관리(개선)
        		application.gds_comboMenuAuthList.filter("menuId == '1836'");
        		
        		// COMBO 에 첫번째 Row에 기본값을 SET
        		if (application.gds_comboMenuAuthList.getRowCount() == 1) {
        		
        			query = query + "CODE = '01'";
        		}
        		else
        		{
        			query = query + "CODE = ''";
        		}
        		
        		application.gds_comboMenuAuthList.filter("");
        		//CS진단관리(점검)
        		application.gds_comboMenuAuthList.filter("menuId == '1835'");
        		
        		if (application.gds_comboMenuAuthList.getRowCount() == 1) {
        		
        			query = query + "OR CODE = '02'";
        		}	
        		
        		application.gds_comboMenuAuthList.filter("");
        		//위생점검관리(개선)
        		application.gds_comboMenuAuthList.filter("menuId == '1826'");
        		
        		if (application.gds_comboMenuAuthList.getRowCount() == 1) {
        		
        			query = query + "OR CODE = '03'";
        		}	
        		
        		application.gds_comboMenuAuthList.filter("");
        		//위생점검관리(점검)
        		application.gds_comboMenuAuthList.filter("menuId == '1825'");
        		
        		if (application.gds_comboMenuAuthList.getRowCount() == 1) {
        		
        			query = query + "OR CODE = '04'";
        		}	
        		
        		application.gds_comboMenuAuthList.filter("");
        		//협력업체위생관리(점검)
        		application.gds_comboMenuAuthList.filter("menuId == '1842'");
        		
        		if (application.gds_comboMenuAuthList.getRowCount() == 1) {
        		
        			query = query + "OR CODE = '05'";
        		}	
        		
        		application.gds_comboMenuAuthList.filter("");
        		//이벤트(개선)
        		application.gds_comboMenuAuthList.filter("menuId == '2185'");
        		
        		if (application.gds_comboMenuAuthList.getRowCount() == 1) {
        		
        			query = query + "OR CODE = '06'";
        		}	
        		
        		application.gds_comboMenuAuthList.filter("");
        		//클레임(개선)
        		application.gds_comboMenuAuthList.filter("menuId == '2965'");
        		
        		if (application.gds_comboMenuAuthList.getRowCount() == 1) {
        		
        			query = query + "OR CODE = '07'";
        		}
        		
        		application.gds_comboMenuAuthList.filter("");
        		//클레임(개선)
        		application.gds_comboMenuAuthList.filter("menuId == '2272'");
        		
        		if (application.gds_comboMenuAuthList.getRowCount() == 1) {
        		
        			query = query + "OR CODE = '07'";
        		}
        		
        		application.gds_comboMenuAuthList.filter("");
        		//LIMS
        		application.gds_comboMenuAuthList.filter("menuId == '1768'");
        		
        		if (application.gds_comboMenuAuthList.getRowCount() == 1) {
        		
        			query = query + "OR CODE = '08'";
        		}
        		
        		application.gds_comboMenuAuthList.filter("");
        		//안전점검관리(개선)
        		application.gds_comboMenuAuthList.filter("menuId == '3056'");
        		
        		if (application.gds_comboMenuAuthList.getRowCount() == 1) {
        		
        			query = query + "OR CODE = '09'";
        		}
        		
        		application.gds_comboMenuAuthList.filter("");
        		//안전점검관리(점검)
        		application.gds_comboMenuAuthList.filter("menuId == '3055'");
        		
        		if (application.gds_comboMenuAuthList.getRowCount() == 1) {
        		
        			query = query + "OR CODE = '10'";
        		}
        		
        		if(application.g_AuthLevel == "999")
        		{
        			query = "";
        		}
        		else
        		{
        			query = "AND (" + query + ")";
        		}	
        		
        	}
        	//팀장승인시 PC RUNTIME화면 권한에 따라 등록구분콤보 권한 제어
        	else if(comboGubun == "TEAMAPP")
        	{
        		//추가발주
        		application.gds_comboMenuAuthList.filter("menuId == '2190'");
        		
        		// COMBO 에 첫번째 Row에 기본값을 SET
        		if (application.gds_comboMenuAuthList.getRowCount() == 1) {
        		
        			query = query + "CODE = '000'";
        		}
        		else
        		{
        			query = query + "CODE = ''";
        		}
        		
        		application.gds_comboMenuAuthList.filter("");
        		//취소신청팀장승인(급식)
        		//ALL:마감취소승인(전체), 001:매출마감(급식)-모바일제외, 004:재고마감, 005:급식운영일지마감, 006:매출마감(장례식장), 008:매출마감(폐식용유), 009:매출마감(특판), 010:P/L열람신청, 011:건별취소(급식)
        		application.gds_comboMenuAuthList.filter("menuId == '2192'");
        		
        		// COMBO 에 첫번째 Row에 기본값을 SET
        		if (application.gds_comboMenuAuthList.getRowCount() == 1) {
        			
        			query = query + "OR CODE = 'ALL' OR CODE = '001' OR CODE = '004' OR CODE = '005' OR CODE = '006' OR CODE = '008' OR CODE = '009' OR CODE = '010' OR CODE = '011'";
        				
        		}	
        			
        		application.gds_comboMenuAuthList.filter("");
        		//취소신청팀장승인(외식)
        		//004:재고마감, 008:매출마감(폐식용유), 009:매출마감(특판), 012:매출마감(외식)
        		application.gds_comboMenuAuthList.filter("menuId == '3111'");
        		
        		// COMBO 에 첫번째 Row에 기본값을 SET
        		if (application.gds_comboMenuAuthList.getRowCount() == 1) {
        		
        			query = query + "OR CODE = '004' OR CODE = '008' OR CODE = '009' OR CODE = '012'";
        		}	
        		
        		application.gds_comboMenuAuthList.filter("");
        		//케터링(기기/기물)
        		application.gds_comboMenuAuthList.filter("menuId == '2221'");
        		
        		// COMBO 에 첫번째 Row에 기본값을 SET
        		if (application.gds_comboMenuAuthList.getRowCount() == 1) {
        		
        			query = query + "OR CODE = '013'";
        		}
        		
        		application.gds_comboMenuAuthList.filter("");
        		//이벤트(기기/기물)
        		application.gds_comboMenuAuthList.filter("menuId == '2183'");
        		
        		// COMBO 에 첫번째 Row에 기본값을 SET
        		if (application.gds_comboMenuAuthList.getRowCount() == 1) {
        		
        			query = query + "OR CODE = '014'";
        		}
        		
        		application.gds_comboMenuAuthList.filter("");
        		//식권폐기관리(팀장)
        		application.gds_comboMenuAuthList.filter("menuId == '2178'");
        		
        		// COMBO 에 첫번째 Row에 기본값을 SET
        		if (application.gds_comboMenuAuthList.getRowCount() == 1) {
        		
        			query = query + "OR CODE = '015'";
        		}		
        		
        		application.gds_comboMenuAuthList.filter("");
        		//시험접수승인
        		application.gds_comboMenuAuthList.filter("menuId == '1765'");
        		
        		// COMBO 에 첫번째 Row에 기본값을 SET
        		if (application.gds_comboMenuAuthList.getRowCount() == 1) {
        		
        			query = query + "OR CODE = '016'";
        		}
        		
        		if(application.g_AuthLevel == "999")
        		{
        			query = "";
        		}
        		else
        		{
        			query = "AND (" + query + ")";
        		}	
        	}
        	//기획승인시 PC RUNTIME화면 권한에 따라 등록구분콤보 권한 제어
        	else if(comboGubun == "MASTERAPP")
        	{
        		//취소신청기획승인
        		//001:매출마감(급식)-모바일 제외, 006:매출마감(장례식장), 008:매출마감(폐식용유), 009:매출마감(특판), 011:건별취소(급식)
        		application.gds_comboMenuAuthList.filter("menuId == '2193'");
        		
        		// COMBO 에 첫번째 Row에 기본값을 SET
        		if (application.gds_comboMenuAuthList.getRowCount() == 1) {
        		
        			query = query + "CODE = 'ALL' OR CODE = '006' OR CODE = '008' OR CODE = '009' OR CODE = '011'";
        			
        		}	
        		else
        		{
        			query = query + "CODE = ''";
        		}
        			
        		//취소신청기획승인(외식)
        		//008:매출마감(폐식용유), 009:매출마감(특판), 012:매출마감(외식)
        		application.gds_comboMenuAuthList.filter("menuId == '3112'");
        		
        		// COMBO 에 첫번째 Row에 기본값을 SET
        		if (application.gds_comboMenuAuthList.getRowCount() == 1) {
        		
        			query = query + "OR CODE = '008' OR CODE = '009' OR CODE = '012'";
        			
        		}
        		
        		application.gds_comboMenuAuthList.filter("");
        		//식권폐기관리(기획)
        		application.gds_comboMenuAuthList.filter("menuId == '2179'");
        		
        		// COMBO 에 첫번째 Row에 기본값을 SET
        		if (application.gds_comboMenuAuthList.getRowCount() == 1) {
        		
        			query = query + "OR CODE = '015'";
        		}		
        		
        		if(application.g_AuthLevel == "999")
        		{
        			query = "";
        		}
        		else
        		{
        			query = "AND (" + query + ")";
        		}	
        	}
        	else
        	{
        		query = StrQuery;
        	}
        	
        	
        	var encFlag = ((this.gfn_transNullToEmpty(query).replace(/(\s*)/g, "")).length) + this.generateKeyNum("sum", this.gfn_Today());
        	/*
        	trace("step1="+(query.replace(/(\s*)/g, "")));
        	trace("step2="+(query.replace(/(\s*)/g, "")).length);
        	trace("step3="+this.generateKeyNum("sum", this.gfn_Today()));
        	trace("step4="+encFlag);
        	*/
        	var strSvcID   		 = "cmmnCode";
        	var strUrl     		 = "/ms/cmn/mobileCommon/selectList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "gds_common_code=ds_list";
        	var strArguments	 = "groupCode=" + nexacro.wrapQuote(this.gfn_transNullToEmpty(groupCode));
        		strArguments     += " code=" + nexacro.wrapQuote(this.gfn_transNullToEmpty(code));
        		strArguments     += " gubun=" + nexacro.wrapQuote(this.gfn_transNullToEmpty(gubun));	
        		strArguments     += " query=" + nexacro.wrapQuote(this.gfn_transNullToEmpty(query));
        		strArguments     += " flag=" + nexacro.wrapQuote(this.gfn_transNullToEmpty(encFlag));	
        	var strCallbackFunc	 = "common_callBack";
        	var bAsync			 = false;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
        }

        /*********************************************************************************************
        ** function name        : common_callBack()
        ** function description : 공통 Callback 서비스
        ** return Type          : 
        ** return description   : 
        *********************************************************************************************/
        this.common_callBack = function (strTranId,nErrorCode,strErrorMsg) 
        {    
        	if ( nErrorCode != 0 ) {
        		application.goMain.gfn_Msg("NOTICE", "알림", strErrorMsg, "OK", true, this);	
        	}
        	return;
        }

        /*********************************************************************************************
        ** function name        : fn_comboMenuAuth
        ** function description : 공통코드호출(PC RUNTIME 권한 메뉴 호출)
        ** argument             : 
        ** return Type          : gds_comboMenuAuthList
        ** return description   : gds_comboMenuAuthList
        *********************************************************************************************/
        this.fn_comboMenuAuth = function (){
        	
        	var strSvcID   		 = "cmmnCode";
        	var strUrl     		 = "/ms/cmn/mobileCommon/selectComboAuthMenuList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "gds_comboMenuAuthList=ds_list";
        	var strArguments	 = "";
        	var strCallbackFunc	 = "comboMenuAuth_callBack";
        	var bAsync			 = false;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
        }

        /*********************************************************************************************
        ** function name        : comboMenuAuth_callBack()
        ** function description : 공통 Callback 서비스
        ** return Type          : 
        ** return description   : 
        *********************************************************************************************/
        this.comboMenuAuth_callBack = function (strTranId,nErrorCode,strErrorMsg) 
        {    
        	trace(application.gds_comboMenuAuthList.saveXML("application.gds_comboMenuAuthList", "V"));
        	return;
        }

        /*********************************************************************************************
        ** function name        : fn_limsAuthLevels
        ** function description : 팀장승인(LIMS승인 권한-버튼 컨트롤시 필요)
        ** argument             : 
        ** return Type          : gds_comboMenuAuthList
        ** return description   : gds_comboMenuAuthList
        *********************************************************************************************/
        this.fn_limsAuthLevels = function (){
        	
        	var strSvcID   		 = "limsAuthLevels";
        	var strUrl     		 = "/ms/cmn/mobileCommon/selectLimsAuthLevels.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "gds_limsAuthLevels=ds_list";
        	var strArguments	 = "loginSabun=" + nexacro.wrapQuote(application.g_EmpNo);
        	var strCallbackFunc	 = "limsAuthLevels_callBack";
        	var bAsync			 = false;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
        }

        /*********************************************************************************************
        ** function name        : limsAuthLevels_callBack()
        ** function description : 공통 Callback 서비스
        ** return Type          : 
        ** return description   : 
        *********************************************************************************************/
        this.limsAuthLevels_callBack = function (strTranId,nErrorCode,strErrorMsg) 
        {    
        	trace(application.gds_limsAuthLevels.saveXML("application.gds_limsAuthLevels", "V"));
        	return;
        }

        /*********************************************************************************************
        ** function name        : this.gfn_saveCloseProc
        ** function description : 마감처리/취소, SP_SLA_SALS_POS_MAGAM_PROC() 호출
        ** 선행조건            : occrDate : 발생일자
        **	                    : sysClass : 시스템구분
        **                      : sysClass : 업장코드
        **                      : closeYn  : 마감여부(처리:Y, 취소:N) 
        ** argument             : thisForm - 현재 Form Object
        **	                    : qid - 조회하고자 하는 대상의 고유 KEY
        **                      : dDsId - 입력데이터셋
        ** return description   : qid
        *********************************************************************************************/
        this.gfn_saveCloseProc = function (thisForm,qid,dDsId){	//occrDate, sysClass, upjangCd, closeYn){
        	this.gfn_transaction(thisForm
        					,qid
        					,"sm/cmn/closeCommon/setPosCloseProc.xdo"
        					,dDsId+"=ds_close:U"
        					,""
        					,""//,"closeYn="+closeYn+" occrDate="+wrapQuote(occrDate)+" sysClass="+wrapQuote(sysClass)+" upjangCd="+wrapQuote(upjangCd)
        					,"fn_callBack"
        					,true);
        }

        
        /*********************************************************************************************
        ** function name        : CopyF()
        ** function description : 필터링된 내용만을 지정한 Dataset에서 복사
        ** argument             : XDataObject
        **                        strDataset
        ** return Type          : 
        ** return description   : 
        *********************************************************************************************/
        this.CopyF = function (XDataObject,strDataset){
        	//Dataset의 내용중 필터링된 내용만을 지정한 Dataset에서 복사하는 Method
        	var sType = strDataset.toString().valueOf().substr(1,6);
        	if( sType.toLowerCase() == "object" )
        	{
        		XDataObject.copyData(strDataset, true);
        	}
        	else
        	{
        		XDataObject.copyData(eval(strDataset), true);
        	}	
        }

        /*********************************************************************************************
        ** function name        : makeEprocImageUrl()
        ** function description : 전사구매 이미지 링크 Url을 생성한다.
        ** argument             : strImgPath
        ** return Type          : 
        ** return description   : 
        *********************************************************************************************/
        this.makeEprocImageUrl = function (strImgPath){
        	
        	// 윈도우 타입으로 변환
        	strImgPath = strImgPath.replace("\\", "/");

        	//공유 디렉토리에 접근할 수 있는 Url로 변경한다.
        	var strEprocImageUrl = application.services["svc"].url + "upload/hwpo/" + strImgPath;
        	
        	return strEprocImageUrl;
        }

        /*********************************************************************************************
        ** function name        : commonMsg()
        ** function description : 공통 메세지 관리
        ** argument             : strImgPath
        ** return Type          : 
        ** return description   : 
        *********************************************************************************************/
        this.commonMsg = function (set1,set2){
        	
        	var strMsg;
        	strMsg = "시스템 작업 중입니다. \n"
        		   + "(사용불가시간 => " + set1 + " ~ " + set2 + ")\n"
        		   + "시스템 개선사항 반영을 위해 시스템 종료하오니 상기 작업 시간 이후 재접속을 부탁드립니다.";

        	application.goMain.gfn_Msg("NOTICE", "알림", strMsg, "OK", true, this);			
        }

        this.generateKeyNum = function (strMode,strValue ) {

        	var rtn = "";
        	var num = 0;
        	switch (strMode ) {
        		case "sum" :
        			rtn = 0;
        			num = nexacro.toNumber(strValue);      
        			while ( num > 0 ) {
        				rtn += num % 10;
        				num = parseInt( num/10);
        			}
        			break;
        	}
        	return rtn;
        }
        
        });


    
        this.loadIncludeScript(path, true);
        
        obj = null;
    };
}
)();