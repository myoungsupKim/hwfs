﻿//XJS=po_common.xjs
(function()
{
    return function(path)
    {
        var obj;
    
        // User Script
        this.registerScript(path, function(exports) {

        /*------------------------------------------------------------------------------------------------------------------------------------------------------
        = 프로그램 : PO 공통 처리모듈
        = 화 일 명 : po_common.js
        = 기능설명 : 공통기능을 처리하기 위한 공통처리모듈
        ------------------------------------------------------------------------------------------------------------------------------------------------------
        */
        //진행상황 관리 DataSet ###############################################################################
        this.fn_PoCommon = function ()
        {
        	// Line Status
        	application.gds_dsPoLineStatus = new Dataset;
        	application.gds_dsPoLineStatus.addColumn("GroupCode", "String", 255);
        	application.gds_dsPoLineStatus.addColumn("PRSave", "String", 255);
        	application.gds_dsPoLineStatus.addColumn("PRFix", "String", 255);
        	application.gds_dsPoLineStatus.addColumn("PRCancel", "String", 255);
        	application.gds_dsPoLineStatus.addColumn("PRApprove", "String", 255);
        	application.gds_dsPoLineStatus.addColumn("POCancel", "String", 255);
        	application.gds_dsPoLineStatus.addColumn("POFix", "String", 255);
        	application.gds_dsPoLineStatus.addColumn("POApprove", "String", 255);
        	application.gds_dsPoLineStatus.addColumn("POCancel", "String", 255);
        	application.gds_dsPoLineStatus.addColumn("POFix", "String", 255);
        	application.gds_dsPoLineStatus.addColumn("POApprove", "String", 255);
        	application.gds_dsPoLineStatus.addColumn("POOrder", "String", 255);
        	application.gds_dsPoLineStatus.addColumn("PODelivering", "String", 255);
        	application.gds_dsPoLineStatus.addColumn("INVPartial", "String", 255);
        	application.gds_dsPoLineStatus.addColumn("INVNormal", "String", 255);
        	application.gds_dsPoLineStatus.addColumn("INVReducing", "String", 255);
        	application.gds_dsPoLineStatus.addColumn("INVPoor", "String", 255);
        	application.gds_dsPoLineStatus.addColumn("INVDamaged", "String", 255);
        	application.gds_dsPoLineStatus.addColumn("AUTOReducing", "String", 255);
        	application.gds_dsPoLineStatus.addColumn("POReturn", "String", 255);
        	application.gds_dsPoLineStatus.addColumn("POClosing", "String", 255);
        	application.gds_dsPoLineStatus.addColumn("INVClosing", "String", 255);
        	application.gds_dsPoLineStatus.addRow();
        	application.gds_dsPoLineStatus.setColumn(0,"GroupCode","007");
        	application.gds_dsPoLineStatus.setColumn(0,"PRSave","001");
        	application.gds_dsPoLineStatus.setColumn(0,"PRFix","002");
        	application.gds_dsPoLineStatus.setColumn(0,"PRCancel","003");
        	application.gds_dsPoLineStatus.setColumn(0,"PRApprove","004");
        	application.gds_dsPoLineStatus.setColumn(0,"POCancel","005");
        	application.gds_dsPoLineStatus.setColumn(0,"POFix","006");
        	application.gds_dsPoLineStatus.setColumn(0,"POApprove","007");
        	application.gds_dsPoLineStatus.setColumn(0,"POOrder","008");
        	application.gds_dsPoLineStatus.setColumn(0,"PODelivering","009");
        	application.gds_dsPoLineStatus.setColumn(0,"INVPartial","010");
        	application.gds_dsPoLineStatus.setColumn(0,"INVNormal","011");
        	application.gds_dsPoLineStatus.setColumn(0,"INVReducing","012");
        	application.gds_dsPoLineStatus.setColumn(0,"INVPoor","013");
        	application.gds_dsPoLineStatus.setColumn(0,"INVDamaged","014");
        	application.gds_dsPoLineStatus.setColumn(0,"AUTOReducing","015");
        	application.gds_dsPoLineStatus.setColumn(0,"POReturn","016");
        	application.gds_dsPoLineStatus.setColumn(0,"POClosing","017");
        	application.gds_dsPoLineStatus.setColumn(0,"INVClosing","018");
        	
        	// Auth Type
        	application.gds_dsPoAuthType = new Dataset;
        	application.gds_dsPoAuthType.addColumn("Inf", "String", 255);
        	application.gds_dsPoAuthType.addColumn("Upr", "String", 255);
        	application.gds_dsPoAuthType.addColumn("Pr", "String", 255);
        	application.gds_dsPoAuthType.addColumn("PrSgn", "String", 255);
        	application.gds_dsPoAuthType.addColumn("PO", "String", 255);
        	application.gds_dsPoAuthType.addColumn("POSgn", "String", 255);
        	application.gds_dsPoAuthType.addColumn("Ct", "String", 255);
        	application.gds_dsPoAuthType.addColumn("Inv", "String", 255);
        	application.gds_dsPoAuthType.addColumn("Ap", "String", 255);
        	application.gds_dsPoAuthType.addRow();
        	application.gds_dsPoAuthType.setColumn(0,"Inf","002");
        	application.gds_dsPoAuthType.setColumn(0,"Upr","003");
        	application.gds_dsPoAuthType.setColumn(0,"Pr","004");
        	application.gds_dsPoAuthType.setColumn(0,"PrSgn","005");
        	application.gds_dsPoAuthType.setColumn(0,"PO","006");
        	application.gds_dsPoAuthType.setColumn(0,"POSgn","007");
        	application.gds_dsPoAuthType.setColumn(0,"Ct","008");
        	application.gds_dsPoAuthType.setColumn(0,"Inv","009");
        	application.gds_dsPoAuthType.setColumn(0,"Ap","010");

        						   
        	application.gds_dsPoType = new Dataset;
        	application.gds_dsPoType.addColumn("FoodAutoCondo", "String", 255);
        	application.gds_dsPoType.addColumn("FoodAddCondo", "String", 255);
        	application.gds_dsPoType.addColumn("FoodLocalCondo", "String", 255);
        	application.gds_dsPoType.addColumn("FoodAutoFS", "String", 255);
        	application.gds_dsPoType.addColumn("FoodAddFS", "String", 255);
        	application.gds_dsPoType.addColumn("FoodLocalFs", "String", 255);
        	application.gds_dsPoType.addColumn("FoodSalesFs", "String", 255);
        	application.gds_dsPoType.addColumn("GoodsCondo", "String", 255);
        	application.gds_dsPoType.addColumn("SMGoodsCondo", "String", 255);
        	application.gds_dsPoType.addColumn("SMGoodsEventCondo", "String", 255);
        	application.gds_dsPoType.addColumn("GoodsFS", "String", 255);
        	application.gds_dsPoType.addColumn("GoodsSalesFS", "String", 255);
        	application.gds_dsPoType.addColumn("Material", "String", 255);
        	application.gds_dsPoType.addColumn("Fixture", "String", 255);
        	application.gds_dsPoType.addRow();
        	application.gds_dsPoType.setColumn(0,"FoodAutoCondo","01");
        	application.gds_dsPoType.setColumn(0,"FoodAddCondo","02");
        	application.gds_dsPoType.setColumn(0,"FoodLocalCondo","03");
        	application.gds_dsPoType.setColumn(0,"FoodAutoFS","04");
        	application.gds_dsPoType.setColumn(0,"FoodAddFS","05");
        	application.gds_dsPoType.setColumn(0,"FoodLocalFs","06");
        	application.gds_dsPoType.setColumn(0,"FoodSalesFs","07");
        	application.gds_dsPoType.setColumn(0,"GoodsCondo","08");
        	application.gds_dsPoType.setColumn(0,"SMGoodsCondo","09");
        	application.gds_dsPoType.setColumn(0,"SMGoodsEventCondo","10");
        	application.gds_dsPoType.setColumn(0,"GoodsFS","11");
        	application.gds_dsPoType.setColumn(0,"GoodsSalesFS","12");
        	application.gds_dsPoType.setColumn(0,"Material","13");
        	application.gds_dsPoType.setColumn(0,"Fixture","14");

        	application.gds_dsTransType = new Dataset;
        	application.gds_dsTransType.addColumn("I_IMPORT", "String", 255);
        	application.gds_dsTransType.addColumn("I_PO", "String", 255);
        	application.gds_dsTransType.addColumn("I_TRANS", "String", 255);
        	application.gds_dsTransType.addColumn("I_LOSS", "String", 255);
        	application.gds_dsTransType.addColumn("I_FSBoothCash", "String", 255);
        	application.gds_dsTransType.addColumn("I_SYS", "String", 255);
        	application.gds_dsTransType.addColumn("O_SALE", "String", 255);
        	application.gds_dsTransType.addColumn("O_TRANS", "String", 255);
        	application.gds_dsTransType.addColumn("O_LOSS", "String", 255);
        	application.gds_dsTransType.addColumn("O_SYS", "String", 255);
        	application.gds_dsTransType.addRow();
        	application.gds_dsTransType.setColumn(0,"I_IMPORT","I000");    //기초재고생성
        	application.gds_dsTransType.setColumn(0,"I_PO","I001");      //정상구매입고
        	application.gds_dsTransType.setColumn(0,"I_TRANS","I002");      //이관인수입고
        	application.gds_dsTransType.setColumn(0,"I_LOSS","I003");      //실사후 조정입고(과부족)
        	application.gds_dsTransType.setColumn(0,"I_FSBoothCash","I004");  //FS매점 전도금입고
        	application.gds_dsTransType.setColumn(0,"I_SYS","I004");      //I004까지는 시스템에서 사용(즉, 수정 및 삭제불가)
        	application.gds_dsTransType.setColumn(0,"O_SALE","O001");      //정상매출출고
        	application.gds_dsTransType.setColumn(0,"O_TRANS","O002");      //이관출고
        	application.gds_dsTransType.setColumn(0,"O_LOSS","O003");      //실사후 조정출고(로스)
        	application.gds_dsTransType.setColumn(0,"O_SYS","O003");      //'O003'까지는 시스템에서 사용(즉, 수정 및 삭제불가)
        }

        this.fn_FormatDateTime = function (strDate,strFormat,datesplit,timesplit)
        {
        	var Ds, Ts, strFormatDate = "";
        	
        	Ds = this.iif(this.gfn_Length(datesplit)==0, "-", datesplit);
        	Ts = this.iif(this.gfn_Length(timesplit)==0, ":", timesplit);
        	
        	if(this.gfn_isNull(strDate))
        	{
        		application.goMain.gfn_Msg("OK", "알림", "Error !! 변환할 입력값이 없습니다.", "OK", "OK");
        		return strDate;
        	}

        	if(this.gfn_Length(strDate)< 4 || this.gfn_Length(strDate)> 14)
        	{
        		application.goMain.gfn_Msg("OK", "알림", "Error !! 현재 입력값은 적절한 날짜 형식으로 변환될 수 없습니다.", "OK", "OK");
        		return strDate;
        	}
        	
        	switch(this.gfn_Length(strDate))
        	{
        		case 4:	// MMDD or HHMI or MISS
        			if(strFormat == "" || strFormat == "MMDD") 
        				strFormatDate = this.gfn_subStr(strDate,0,2)+ Ds + this.gfn_subStr(strDate,2,2);
        			else if(strFormat == "HHMI" || strFormat == "MISS")
        				strFormatDate = this.gfn_subStr(strDate,0,2)+ Ts + this.gfn_subStr(strDate,2,2);
        			break;
        		case 6:	//YYMMDD
        			strFormatDate = this.gfn_subStr(strDate,0,2)+ Ds + this.gfn_subStr(strDate,2,2)+ Ds + this.gfn_subStr(strDate,4,2);
        			break;
        		case 8:	//YYYYMMDD
        			strFormatDate = this.gfn_subStr(strDate,0,4)+ Ds + this.gfn_subStr(strDate,4,2)+ Ds + this.gfn_subStr(strDate,6,2);
        			break;
        		case 10:	//YYYYMMDDHH
        			strFormatDate = this.gfn_subStr(strDate,0,4)+ Ds + this.gfn_subStr(strDate,4,2)+ Ds + this.gfn_subStr(strDate,6,2)+ " " + this.gfn_subStr(strDate,8,2);
        			break;
        		case 12:	//YYYYMMDDHHMI
        			strFormatDate = this.gfn_subStr(strDate,0,4)+ Ds + this.gfn_subStr(strDate,4,2)+ Ds + this.gfn_subStr(strDate,6,2)+ " " + this.gfn_subStr(strDate,8,2)+ Ts + this.gfn_subStr(strDate,10,2);
        			break;
        		case 14:	//YYYYMMDDHHMISS
        			strFormatDate = this.gfn_subStr(strDate,0,4)+ Ds + this.gfn_subStr(strDate,4,2)+ Ds + this.gfn_subStr(strDate,6,2)+ " " + this.gfn_subStr(strDate,8,2)+ Ts + this.gfn_subStr(strDate,10,2)+ Ts + this.gfn_subStr(strDate,12,2);
        			break;
        		default:	//오류
        			strFormatDate = strDate;
        			break;
        	}		
        	
        	return strFormatDate;	
        }

        
        /**********************************************************************************
         * 함  수  명   : iif
         * 입      력   : true value
         *                 false value
         * 반      환   : true일 경우 trueVal, false일경우 falseVal
         * 기      능   : 조건식이 true일 경우 trueVal, false일경우 falseVal를 반환한다.
         * 작  성  자   : 강대성
         * 작성  일자   : 2015-07-01
         * ----------------------------------------------------------------------------------------
         * HISTORY    :
         *******************************************************************************************/
        this.iif = function(cond,rtnTrue,rtnFalse)
        {
        	if(cond) 
        	{
        		return rtnTrue;
        	} 
        	else {
        		return rtnFalse;
        	}
        } 

        /*******************************************************************************************
         * 함  수  명   : fn_SetBtnControl
         * 입      력   : strBtnSearch 	= 검색버튼
         *                 strBtnSave  = 저장버튼(확정, 삭제, 승인, 이미지업로드등)
         * 반      환   : 없음
         * 기      능   : 메뉴CRUD권한에 따른 버튼 컨트롤
         * 작  성  자   : 강대성
         * 작성  일자   : 2015-07-01
         * ----------------------------------------------------------------------------------------
         * HISTORY    :
         *******************************************************************************************/
        this.fn_SetBtnControl = function (strBtnSearch,strBtnSave)
        {
        	var searchGubun = application.gds_cmnAuth.getColumn(0, "srcYn");
        	var saveGubun = application.gds_cmnAuth.getColumn(0, "savYn");
        	
        	var bSearch = false;
        	var bSave = false;
        	
        	var objBtnSearch = eval( strBtnSearch );
        	var objBtnSave = eval( strBtnSave );
        	
        	if(!this.gfn_isNull(strBtnSearch))
        	{
        		switch(searchGubun)
        		{
        			case "Y":  //조회권한있음
        				objBtnSearch.set_enable(true);
        				break;
        			case "N":  //조회권한없음
        				objBtnSearch.set_enable(false);
        				break;		
        			default:
        				objBtnSearch.set_enable(false);
        				break;
        		}
        	}
        	
        	if(!this.gfn_isNull(strBtnSave))
        	{
        		switch(saveGubun)
        		{	
        			case "Y":  //저장권한있음
        				objBtnSave.set_enable(true);
        				break;
        			case "N":  //저장권한없음
        				objBtnSave.set_enable(false);
        				break;		
        			default:
        				objBtnSave.set_enable(false);
        				break;
        		}
        	}
        	
        	// 저장권한이 있을경우 마스킹 구분자 0으로 넘김
        	if(saveGubun == "Y")
        	{
        		return 0
        	}
        	
        	return 1
        }

        
        /*******************************************************************************************
         * 함  수  명   : fn_SetAuth
         * 입      력   : ed_Dept 	= 부서 텍스트 박스
         *                btn_Dept  = 부서 팝업 버튼명
         *                ed_Upjang   = 업장 텍스트 박스
         *                btn_Upjang   = 업장 팝업 버튼명
         * 반      환   : 없음
         * 기      능   : 권한에 따른 팝업 활성 설정
         * 작  성  자   : 강대성
         * 작성  일자   : 2015-07-01
         * ----------------------------------------------------------------------------------------
         * HISTORY    :
         *******************************************************************************************/
        this.fn_SetAuth = function (strEdUpjang,strBtnUpjang)
        {
        	
        	var bUpjang = false;
        	
        	var objedUpjang = eval( strEdUpjang );
        	var objbtnUpjang = eval( strBtnUpjang );	
        	
        	switch(application.g_AuthLevel)
        	{
        		case "00":  //일반관리자
        			bUpjang = false;
        			break;
        		case "10":  //영양사
        			bUpjang = false;
        			break;
        		case "12":  //리더영양사
        			bUpjang = false;
        			break;
        		case "14": //소팀장
        			if(strEdUpjang.indexOf('upjang') >= 0 || strEdUpjang.indexOf('main') >= 0)
        			{
        				bUpjang = true;
        			}
        			else
        			{	
        				bUpjang = false;
        			}
        			
        			application.g_RoleSetId2 = "StUpjang";
        			application.g_useTmCd = "Y";
        			
        			break;
        		case "16": //팀장
        			if(strEdUpjang.indexOf('upjang') >= 0 || strEdUpjang.indexOf('main') >= 0)
        			{
        				bUpjang = true;
        			}
        			else
        			{	
        				bUpjang = false;
        			}
        			
        			application.g_RoleSetId2 = "StUpjang";
        			application.g_useTmCd = "Y";
        			
        			break;
        		case "18": //경영자
        			bUpjang = true;
        			break;	
        		case "27": //본부관리자(식재)
        			bUpjang = true;
        			break;	
        		case "70": //MU권한자
        			bUpjang = true;
        			
        			application.g_RoleSetId2 = "StUpjang";
        			application.g_useTmCd = "N";
        			
        			break;	
        		case "80": //BU권한자
        			bUpjang = true;
        			
        			application.g_RoleSetId2 = "StUpjang";
        			application.g_useTmCd = "N";
        			
        			break;	
        		case "99": //전산관리자(현업)
        			bUpjang = true;
        			break;	
        		case "999": //전산관리자(전산)
        			bUpjang = true;
        			break;				
        		default:
        			bUpjang = false;
        			break;
        	}
        	
        	//복수업장이 있을경우 상업장 검색 버튼 활성화 시킴
        	if(application.gds_upjangList.getRowCount() > 1) bUpjang = true;	
        	
        	if(!this.gfn_isNull(objedUpjang))
        	{
        		objedUpjang.set_enable(bUpjang);
        		//리더영양사일 경우 업장Delete를 못하게 막는다.(선택은 가능)
        		if (application.g_AuthLevel == "12") objedUpjang.set_enable(false);
        		
        		if ( (bUpjang == false) || (application.g_AuthLevel == "12") ) 
        		{ 
        			objedUpjang.set_value(application.g_UpjangNm); 
        			//objedUpjang.set_userdata(application.g_Upjang);
        		}		
        	}
        	
        	if(!this.gfn_isNull(objbtnUpjang))
        	{
        		objbtnUpjang.set_enable(bUpjang);
        	}
        }

        /*******************************************************************************************
         * 함  수  명   : fn_SetAuth
         * 입      력   : ed_Dept 	= 부서 텍스트 박스
         *                btn_Dept  = 부서 팝업 버튼명
         *                ed_Upjang   = 업장 텍스트 박스
         *                btn_Upjang   = 업장 팝업 버튼명
         * 반      환   : 없음
         * 기      능   : 권한에 따른 팝업 활성 설정
         * 작  성  자   : 강대성
         * 작성  일자   : 2015-07-01
         * ----------------------------------------------------------------------------------------
         * HISTORY    :
         *******************************************************************************************/
        this.fn_SetAuth2 = function (strUpjang,strTmNm,strTmCd)
        {	
        	var objedUpjang = eval( strUpjang );
        	var objbtnTmNm = eval( strTmNm );
        	var objbtnTmCd = eval( strTmCd );
        	
        	if(!this.gfn_isNull(strUpjang))
        	{
        		switch(application.g_AuthLevel)
        		{
        			case "00":  //일반관리자
        				break;
        			case "10":  //영양사
        				break;
        			case "12":  //리더영양사
        				break;
        			case "14": //소팀장
        				objedUpjang = "";
        				break;
        			case "16": //팀장
        				objedUpjang = "";
        				break;
        			case "18": //경영자
        				objedUpjang = "";
        				break;	
        			case "27": //본부관리자(식재)
        				objedUpjang = "";
        				break;	
        			case "70": //MU권한자
        				objedUpjang = "";
        				break;	
        			case "80": //BU권한자
        				objedUpjang = "";
        				break;	
        			case "99": //관리자(현업)	
        				objedUpjang = "";
        				break;	
        			case "999": //전산관리자(전산)
        				objedUpjang = "";
        				break;				
        			default:
        				break;
        		}
        		
        		return objedUpjang;
        	}
        	
        	if(!this.gfn_isNull(strTmNm))
        	{
        		switch(application.g_AuthLevel)
        		{
        			case "00":  //일반관리자
        				break;
        			case "10":  //영양사
        				break;
        			case "12":  //리더영양사
        				break;
        			case "14": //소팀장
        				break;
        			case "16": //팀장
        				break;
        			case "18": //경영자
        				objbtnTmNm.set_value("");
        				objbtnTmCd = "";
        				break;	
        			case "27": //본부관리자(식재)
        				objbtnTmNm.set_value("");
        				objbtnTmCd = "";
        				break;	
        			case "70": //MU권한자
        				objbtnTmNm.set_value("");
        				objbtnTmCd = "";
        				break;	
        			case "80": //BU권한자
        				objbtnTmNm.set_value("");
        				objbtnTmCd = "";
        				break;	
        			case "99": //관리자(현업)
        				objbtnTmNm.set_value("");
        				objbtnTmCd = "";
        				break;	
        			case "999": //전산관리자(전산)
        				objbtnTmNm.set_value("");
        				objbtnTmCd = "";
        				break;				
        			default:
        				break;
        		}
        		
        		return objbtnTmCd;
        	}
        	
        }

        /*******************************************************************************************
         * 함  수  명   : fn_masterRole
          * 반      환   : false, true
         * 기      능   : 사업장 조회 구분권한
         * 작  성  자   : 강대성
         * 작성  일자   : 2015-07-01
         * ----------------------------------------------------------------------------------------
         * HISTORY    :
         *******************************************************************************************/
        this.fn_masterRole = function ()
        {	
        	switch(application.g_AuthLevel)
        	{
        		case "00":  //일반관리자
        			gubun = false;
        			break;
        		case "10":  //영양사
        			gubun = false;
        			break;
        		case "12":  //리더영양사
        			gubun = false;
        			break;
        		case "14": //소팀장
        			gubun = false;
        			break;
        		case "16": //팀장
        			//gubun = false;
        			gubun = true;
        			break;
        		case "18": //경영자
        			//gubun = false;;
        			gubun = true;
        			break;	
        		case "27": //본부관리자(식재)
        			gubun = false;;
        			break;	
        		case "70": //MU권한자
        			//gubun = false;
        			gubun = true;
        			break;	
        		case "80": //BU권한자
        			//gubun = false;
        			gubun = true;
        			break;	
        		case "99": //관리자(현업)	
        			gubun = true;
        			break;	
        		case "999": //전산관리자(전산)
        			gubun = true;
        			break;				
        		default:
        			gubun = false;
        			break;
        	}
        	
        	return gubun;
        	
        }

        
        });


    
        this.loadIncludeScript(path, true);
        
        obj = null;
    };
}
)();
