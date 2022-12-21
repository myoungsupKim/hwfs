(function()
{
    return function()
    {
        if (!this._is_form)
            return;
        
        this.on_create = function()
        {
            // Declare Reference
            var obj = null;
            
            if (Form == this.constructor) {
                this.set_name("ProvisionalContractReqt");
                this.set_titletext("가계약등록");
                this._setFormPosition(0,0,540,760);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_eventGubun", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"256\"/><Column id=\"cdNm\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_grd", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("true");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"reservNum\" type=\"STRING\" size=\"256\"/><Column id=\"kindCd\" type=\"STRING\" size=\"256\"/><Column id=\"outletCd\" type=\"STRING\" size=\"256\"/><Column id=\"acceptDate\" type=\"STRING\" size=\"256\"/><Column id=\"reservStatus\" type=\"STRING\" size=\"256\"/><Column id=\"reservStatusNm\" type=\"STRING\" size=\"256\"/><Column id=\"reservCd\" type=\"STRING\" size=\"256\"/><Column id=\"reservNm\" type=\"STRING\" size=\"256\"/><Column id=\"rsvnNm\" type=\"STRING\" size=\"256\"/><Column id=\"strDate\" type=\"STRING\" size=\"256\"/><Column id=\"endDate\" type=\"STRING\" size=\"256\"/><Column id=\"timeCd\" type=\"STRING\" size=\"256\"/><Column id=\"strTime\" type=\"STRING\" size=\"256\"/><Column id=\"endTime\" type=\"STRING\" size=\"256\"/><Column id=\"psn\" type=\"STRING\" size=\"256\"/><Column id=\"amCd\" type=\"STRING\" size=\"256\"/><Column id=\"handPhone\" type=\"STRING\" size=\"256\"/><Column id=\"remarkFact\" type=\"STRING\" size=\"256\"/><Column id=\"cdate\" type=\"STRING\" size=\"256\"/><Column id=\"cuser\" type=\"STRING\" size=\"256\"/><Column id=\"udate\" type=\"STRING\" size=\"256\"/><Column id=\"savYn\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row/></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_time", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"256\"/><Column id=\"cdNm\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("Static04", "absolute", "0", "0", null, "2", "0", null, this);
            obj.set_taborder("46");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "177", "540", "10", null, null, this);
            obj.set_taborder("47");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "187", "10", "456", null, null, this);
            obj.set_taborder("50");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static14", "absolute", "0", "2", null, "59", "0", null, this);
            obj.set_taborder("66");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "60", null, "59", "0", null, this);
            obj.set_taborder("67");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static25", "absolute", "0", "60", "135", "59", null, null, this);
            obj.set_taborder("73");
            obj.set_text("행사구분");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_upjang", "absolute", "139", "8", null, "47", "10", null, this);
            obj.set_taborder("80");
            obj.set_displaynulltext("업장을 선택하세요");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "0", "118", null, "59", "0", null, this);
            obj.set_taborder("82");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "0", "2", "135", "59", null, null, this);
            obj.set_taborder("87");
            obj.set_text("사업장");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "119", "23", "20", "129", null, null, this);
            obj.set_taborder("88");
            obj.set_text("글자사이간격w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list", "absolute", "10", "187", null, null, "10", "0", this);
            obj.set_taborder("91");
            obj.set_scrollbars("autovert");
            obj.set_binddataset("ds_grd");
            obj.set_autofittype("col");
            obj.set_nodataimage("URL('theme://Image/grd_WF_NoDataImg.png')");
            obj.set_scrollpixel("all");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"95\"/><Column size=\"95\"/><Column size=\"268\"/><Column size=\"62\"/></Columns><Rows><Row size=\"55\" band=\"head\"/><Row size=\"50\"/><Row size=\"2\"/></Rows><Band id=\"head\"><Cell colspan=\"2\" text=\"시간\"/><Cell col=\"2\" colspan=\"2\" text=\"예약상태\"/></Band><Band id=\"body\"><Cell colspan=\"2\" displaytype=\"combo\" style=\"align:center middle;padding:0 10 0 10;line:0 solid #808080ff ;\" text=\"bind:strTime\" combodataset=\"ds_time\" combocodecol=\"cd\" combodatacol=\"cdNm\"/><Cell col=\"2\" displaytype=\"normal\" edittype=\"none\" style=\"align:EXPR(reservStatus == &quot;3&quot;?&quot;center middle&quot;:&quot;right middle&quot;);line:0 solid #808080ff ;\" editdisplay=\"edit\"/><Cell col=\"3\" displaytype=\"expr:reservStatus == &quot;3&quot;?&quot;button&quot;:(reservStatus == &quot;4&quot;?&quot;button&quot;:&quot;normal&quot;)\" style=\"padding:5 5 5 5;line:0 solid #808080ff ;controlbackground: ;\" text=\"expr:reservStatus == &quot;3&quot;?&quot;신청&quot;:(reservStatus == &quot;4&quot;?&quot;신청&quot;:reservStatusNm)\"/><Cell row=\"1\"/><Cell row=\"1\" col=\"1\"/><Cell row=\"1\" col=\"2\"/><Cell row=\"1\" col=\"3\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "530", "187", "10", "456", null, null, this);
            obj.set_taborder("92");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Button("btn_upjang", "absolute", "483", "8", null, "47", "10", null, this);
            obj.set_taborder("93");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);

            obj = new Combo("cbo_event", "absolute", "138", "66", null, "47", "10", null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("94");
            obj.set_displaynulltext("행사명 선택");
            obj.set_innerdataset("@ds_eventGubun");
            obj.set_codecolumn("cd");
            obj.set_datacolumn("cdNm");
            obj.set_index("-1");

            obj = new Button("Button01", "absolute", null, "65", "47", "47", "-416", null, this);
            obj.set_taborder("102");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_place", "absolute", "565", "65", null, "47", "-416", null, this);
            obj.set_taborder("103");
            obj.set_displaynulltext("연회장을 입력");
            this.addChild(obj.name, obj);

            obj = new Button("btn_search", "absolute", null, "124", "100", "47", "10", null, this);
            obj.set_taborder("104");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_dtFrom", "absolute", "139", "124", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("106");
            obj.set_dateformat("yyyy-MM-dd");

            obj = new Static("Static03", "absolute", "0", "118", "135", "59", null, null, this);
            obj.set_taborder("107");
            obj.set_text("예약일자");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("sta_dtFrom", "absolute", "139", "124", "195", "47", null, null, this);
            obj.set_taborder("108");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("가계약등록");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("ProvisionalContractReqt.xfdl", "lib::lib_Com.xjs");
        this.registerScript("ProvisionalContractReqt.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		가계약 등록
        // [부시스템명]	가계약 등록 - 조회
        // [설명]
        // 		부서 검색하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.02.09
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.09 : 강대성 : 수정이 필요하여 수정함.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*======================================================
         전역변수
         ======================================================*/
        this.preDate = undefined;
        this.outletCd = undefined;
        this.amCd = undefined;
        this.eventGubun = undefined;
        this.strTime = undefined;
        this.endTime = undefined;
        this.reservCd = undefined; 	    //행사종류
        this.reservNm = undefined;      //행사명
        this.rsvnNm = undefined;	    //예약자명
        this.handPhone = undefined;	    //핸드폰번호
        this.remarkFact = undefined;	//추가내용
        this.psn = undefined;	   		//인원
        this.savYn = undefined;
        this.vRtn = 0;

        /*================================================================================
         * 2. Form관련 Script
         *===============================================================================*/
        /** 
         * Form의 모든 컴포넌트가 생성되고, 모든 Object가 Load 되었을 때에 발생하는 Event
         * @param
        	obj : Event가 발생한 Object
        	e : Event Object
         * @return : 없음
         */ 
        this.form_onload = function(obj,e)
        {
        	//필수
        	this.fn_init();
        }

        this.fn_init = function ()
        {	
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetBtnControl("this.btn_search","");	
        	
        	this.savYn = application.gds_cmnAuth.getColumn(0, "savYn")
        	
        	// 권한에 따른 버튼 활성화 및 디폴트값 설정
        	//this.fn_SetAuth("this.edt_upjang", "this.btn_upjang");	
        	
        	application.gds_common_code.clearData();
        	this.fn_common_code("BMS_0002", "", "");	
        	this.ds_eventGubun.copyData(application.gds_common_code);	
        	
        	this.fn_common_code("BMS_0015", "", "");	
        	this.ds_time.copyData(application.gds_common_code);	
        	
        	//첫번쨰 index로 세팅
        	this.eventGubun = this.ds_eventGubun.getColumn(this.vRtn, "cd");
        	this.cbo_event.set_text(this.ds_eventGubun.getColumn(this.vRtn, "cdNm"));
        	
        	this.preDate = this.gfn_Today();
        	this.cal_dtFrom.set_value(this.preDate);
        	
        	if (this.gfn_isNull(application.gds_menuAuth.getColumn(0,"cd"))){
        		application.goMain.gfn_Msg("", "알림", "AM코드가 없습니다.", "OK");
                this.btn_search.set_enable(false);
                return;		
        	}
        	else
        	{
        		this.amCd = application.gds_menuAuth.getColumn(0,"cd");
        	}	
        	
        	//사업장 세팅
        	this.edt_upjang.set_value(application.g_UpjangNm);	
        	this.outletCd = application.g_Upjang;		
        }

        /** 
         * (웨딩/연회)업장 검색 팝업 호출
         */
        this.btn_upjang_onclick = function(obj,e)
        {
        // 	var arg = new Array();
        // 	arg[0] = this.edt_upjang.value;
        // 	
        // 	application.goMain.gfn_POP_create("outletNm", "M_MWR::OutletSearchPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        // 	return false;

        	var arg = new Array();
        	if(application.g_AuthLevel == "999" || application.g_AuthLevel == "99")
        	{
        		arg[4] = "OutletUpjang";
        		arg[9] = "exception";
        		arg[10] = "AND A.MU_CD IN ('2003')";
        	}
        	else
        	{
        		arg[4] = "OutletUpjang";
        		arg[5] = application.g_AuthLevel;
        		arg[6] = application.g_EmpNo;
        		arg[7] = application.g_Tm_Cd;
        		arg[8] = application.g_Mu_Cd;
        		arg[9] = "default";
        	}	
        	
        	application.goMain.gfn_POP_create("outletNm", "M_MLM::WorkplaceSearchPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        //행사구분 콤보조회 검색 팝업
        this.cbo_event_ondropdown = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_eventGubun;
        	arg[1] = "조회조건(행사)";
        	arg[2] = "";
        	arg[3] = "cdNm";
        	application.goMain.gfn_POP_create("event", "cmmn::CmmnComboList.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        // 달력 클릭 시(From)
        this.sta_dtFrom_onclick = function(obj,e)
        {
        	var objCalArg = this.cal_dtFrom.value;
        	
        	application.goMain.gfn_POP_create("PopCalFrom", "cmmn::CmmnCalendarPop.xfdl", "fn_callbackPOP", this, objCalArg, "POP", application.goMain.divBase);
        	return false;
        }

        /*******************************************************************************
        * 기      능   :  검색
        * 설      명   :  등록
        ********************************************************************************/
        this.btn_search_onclick = function(obj,e)
        {
        	this.fn_search();
        }

        this.fn_search = function()
        {
        	//필수항목 
        	if (this.fn_searchChk()) return;
        	
        	this.eventGubun = this.ds_eventGubun.getColumn(this.vRtn, "cd");
        	
        	var strSvcID   		 = "search";
        	var strUrl     		 = "ms/mwr/provisionalContractReqt/selectList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "ds_grd=ds_list";
        	var strArguments	 = "outletCd=" + nexacro.wrapQuote(this.outletCd)
        		strArguments     += " kindCd=" + nexacro.wrapQuote(this.eventGubun);
        		strArguments     += " reservDate=" + nexacro.wrapQuote(this.cal_dtFrom.value);
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
          	// connect the server 
        	
        }

        /*******************************************************************************
        * 기      능   :  등록
        * 설      명   :  임시여신등록
        ********************************************************************************/
        this.fn_save = function()
        {		
        	//저장 체크
         	if(!this.fn_SaveCheck())
        	{
        		return;
        	}	
        	
        	var nRow = this.ds_grd.rowposition;
        	this.ds_grd.setColumn(nRow, "reservStatus", "1");       		//예약상태
        	this.ds_grd.setColumn(nRow, "endTime", this.endTime); 	    	//종료시간
        	this.ds_grd.setColumn(nRow, "outletCd", this.outletCd); 		//행사영업장
        	this.ds_grd.setColumn(nRow, "strDate", this.cal_dtFrom.value);  //예약시작일자
        	this.ds_grd.setColumn(nRow, "endDate", this.cal_dtFrom.value);  //예약종료일자
        	this.ds_grd.setColumn(nRow, "amCd", this.amCd);         		//AM코드
        	this.ds_grd.setColumn(nRow, "reservCd", this.reservCd);  	    //행사종류
        	this.ds_grd.setColumn(nRow, "reservNm", this.reservNm);  	    //행사명
        	this.ds_grd.setColumn(nRow, "rsvnNm", this.rsvnNm); 	        //예약자명
        	this.ds_grd.setColumn(nRow, "handPhone", this.handPhone); 	    //핸드폰번호
        	this.ds_grd.setColumn(nRow, "remarkFact", this.remarkFact); 	//추가내용
        	this.ds_grd.setColumn(nRow, "psn", this.psn); 	        		//인원
        	this.ds_grd.setColumn(nRow, "kindCd", this.eventGubun); 		//행사구분(1:연회, 2:웨딩, 3:케이터링)
        	
        	trace("ds_grd :: " +this.ds_grd.saveXML("ds_grd", "V"));
        	
        	// v_ds_check 미사용시 변경사항 체크
        	if (this.gfn_getUpdate(this.ds_grd) == false) 
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "변경된 데이터가 없습니다.", "OK");
        		return;
        	}
         	
        	var strSvcID   		 = "save";
        	var strUrl     		 = "ms/mwr/provisionalContractReqt/saveList.xdo";
        	var strInDataset     = "ds_list=ds_grd:U";
        	var strOutDataset    = "ds_grd=ds_list";
        	var strArguments	 = "";
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
          	// connect the server 
        }

        /*******************************************************************************
        * 기      능   :  검색필수체크
        * 설      명   :  검색필수체크
        ********************************************************************************/
        this.fn_searchChk = function ()
        {
        	if (this.gfn_isNull(this.edt_upjang.value)){
        		application.goMain.gfn_Msg("", "알림", "업장을 입력하세요.", "OK");
                return true;
        	}		
        	
        	return false;
        }

        /*******************************************************************************
        * 기      능   :  저장체크
        * 설      명   :  저장체크
        ********************************************************************************/
        this.fn_SaveCheck = function ()
        {
        	
        	if (this.gfn_isNull(this.edt_upjang.value)){
        		application.goMain.gfn_Msg("", "알림", "업장을 입력하세요.", "OK");
                return false;
        	}		
        	
        	
        	for(var i=this.ds_grd.rowposition;i<this.ds_grd.getRowCount();i++){
        		
        		if ( (this.endTime > this.ds_grd.getColumn(i, "endTime")) && this.ds_grd.getColumn(i, "reservStatus") ==  "1" || this.ds_grd.getColumn(i, "reservStatus") == "2"){
        			application.goMain.gfn_Msg("", "알림", "종료시간조정이 필요합니다.\n(예약건이 있습니다)", "OK");
        			return false;
        		}
        	}	
        	
        	return true;
        }

        /*******************************************************************************
        * 기      능   :  그리드 cell클릭시
        * 설      명   :  승인 또는 반려 버튼 클릭시 해당 팝업창을 호출한다.
        ********************************************************************************/ 
        this.grd_list_oncellclick = function(obj,e)
        {	
        	var stat = this.ds_grd.getColumn(this.ds_grd.rowposition, "reservStatus")
        	
        	if(this.savYn == "Y")
        	{		
        		if(this.cal_dtFrom.value >= this.preDate)
        		{
        			if((stat == "3" || stat == "4") && e.cell == "2")
        			{
        				var arg = new Array();	
        				
        				arg[0] = this.ds_time.getColumn(this.ds_grd.rowposition, "cdNm");
        				arg[1] = this.ds_grd.getColumn(this.ds_grd.rowposition, "endTime");
        				arg[2] = this.ds_eventGubun.getColumn(this.vRtn, "cd"); //행사구분
        				
        				application.goMain.gfn_POP_create("saveDetail", "M_MWR::ReqtDetailPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        			}
        		}
        		else
        		{
        			application.goMain.gfn_Msg("", "알림", "현재일 이전예약일자로 신청 불가합니다.", "OK");
        		}		
        	}
        	else
        	{
        		application.goMain.gfn_Msg("", "알림", "신청권한이 없습니다.", "OK");
        	}
        	
        }

        
        /*----------------------------------------------------------------------------------------------
         * 설명      : 트랜잭션 콜백 함수 (필수)
         *---------------------------------------------------------------------------------------------*/
        this.fn_callBack = function (strSvcID,nErrorCode,strErrorMsg)
        {	
        	
        	// 에러시 gfn_callBack에서 메시지 제공, 화면별 특정 에러 발생시에만 사용하세요.
        	if (nErrorCode < 0) 
        	{
        		return;
        	}
        	
            switch(strSvcID)
            {		
        		//예약현황조회
                case "search" :
        			
        			// 조회 건수 확인  
                    if (this.ds_grd.getRowCount() == 0) 
                    {
                        application.goMain.gfn_Msg("alertTest", "Information", "조회되는 내용이 없습니다.", "OK");	
                        return;
                    }
                    else // 조회건수가 1페이지 이상일때
                    {
        				
        			}
          			break;
          		//저장
          		case "save" :
        			// TODO parameter로 전체건수를 받는다.
        			
        			application.goMain.gfn_Msg("ALERT_0", "Information", "저장되었습니다.", "OK");	//저장되었습니다
        			this.fn_search();
                    break;
            }     
            
        }

        
        /** 
         * 팝업 callBack
         * @param  : popname - 팝업을 구분짓는 id
         rtn : 팝업이 닫히면서 전달된 값
         * @return : 없음
         */
        this.fn_callbackPOP = function (popname,rtn)
        {
        	switch (popname)
        	{
        		case "outletNm":
        			this.edt_upjang.set_value(rtn[1]);
        			this.outletCd = rtn[0]			
        			break;
        		case "event":
        			this.cbo_event.set_index(rtn);
        			this.vRtn = rtn;
        			break;
        		case "PopCalFrom":
        			this.cal_dtFrom.set_value(rtn);
        			break;		
        		case "saveDetail":	
        			this.reservCd = rtn[0];  	    //행사종류
        			this.reservNm = rtn[1];  	    //행사명
        			this.rsvnNm = rtn[2]; 	        //예약자명
        			this.handPhone = rtn[3]; 	    //핸드폰번호
        			this.remarkFact = rtn[6]; 	    //추가내용
        			this.endTime = rtn[5];			//종료시간
        			this.psn = rtn[7]; 	       		//인원
        			
        			//저장처리한다.
        			this.fn_save();
        			break;	
        	}
        }

        this.grd_list_onslide = function(obj,e)
        {
        	
        	if (e.yaccvalue > 0)
        	{
        		this.parent.parent.divBottom.set_visible(true);
        		this.parent.parent.divMain.set_height(833);
        		this.parent.parent.divBottom.bringToFront();
        	}
        	else if (e.yaccvalue < 0)
        	{	
        		if (this.ds_grd.getRowCount() > 0)
        		{
        			this.parent.parent.divBottom.set_visible(false);
        			this.parent.parent.divMain.set_height(923);
        		}
        	}
        }

        this.grd_list_onvscroll = function(obj,e)
        {
        	// div안의 스크롤 컨트롤일 경우 btnGoTop 대신 btnGoTopDiv 사용
        	if (e.pos == 0)
        	{
        		this.parent.btnGoTopDiv.set_visible(false);
        	}
        	else
        	{
        		this.parent.btnGoTopDiv.set_visible(true);
        		this.parent.btnGoTopDiv.set_left(420);
        		this.parent.btnGoTopDiv.set_right(65);
        		this.parent.btnGoTopDiv.set_bottom(10);
        	}
        }

        // div안의 스크롤바 조정일 경우 아래 함수 추가
        this.fn_setDivScrollbar = function()
        {
        	// 해당 div로 바꿔준다.
        	this.grd_list.vscrollbar.set_pos(0);
        }

        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.grd_list.addEventHandler("oncellclick", this.grd_list_oncellclick, this);
            this.grd_list.addEventHandler("onvscroll", this.grd_list_onvscroll, this);
            this.grd_list.addEventHandler("onslide", this.grd_list_onslide, this);
            this.btn_upjang.addEventHandler("onclick", this.btn_upjang_onclick, this);
            this.cbo_event.addEventHandler("ondropdown", this.cbo_event_ondropdown, this);
            this.Button01.addEventHandler("onclick", this.btn_place_onclick, this);
            this.btn_search.addEventHandler("onclick", this.btn_search_onclick, this);
            this.sta_dtFrom.addEventHandler("onclick", this.sta_dtFrom_onclick, this);

        };

        this.loadIncludeScript("ProvisionalContractReqt.xfdl", true);

       
    };
}
)();
