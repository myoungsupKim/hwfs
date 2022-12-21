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
                this.set_name("ReservationReport");
                this.set_titletext("예약현황");
                this._setFormPosition(0,0,540,760);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_grd", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("true");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"reservNum\" type=\"STRING\" size=\"256\"/><Column id=\"outletCd\" type=\"STRING\" size=\"256\"/><Column id=\"reservDate\" type=\"STRING\" size=\"256\"/><Column id=\"reservNm\" type=\"STRING\" size=\"256\"/><Column id=\"rsvnNm\" type=\"STRING\" size=\"256\"/><Column id=\"amNm\" type=\"STRING\" size=\"256\"/><Column id=\"kindCdNm\" type=\"STRING\" size=\"256\"/><Column id=\"strDate\" type=\"STRING\" size=\"256\"/><Column id=\"husb\" type=\"STRING\" size=\"256\"/><Column id=\"bride\" type=\"STRING\" size=\"256\"/><Column id=\"reservTime\" type=\"STRING\" size=\"256\"/><Column id=\"psn\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

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
            obj.set_displaynulltext("업장명을 입력");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "0", "118", null, "59", "0", null, this);
            obj.set_taborder("82");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Button("btn_search", "absolute", null, "124", "100", "47", "10", null, this);
            obj.set_taborder("86");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "0", "2", "135", "59", null, null, this);
            obj.set_taborder("87");
            obj.set_text("사업장");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "119", "23", "20", "97", null, null, this);
            obj.set_taborder("88");
            obj.set_text("글자사이간격w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list000", "absolute", "564", "114", null, null, "-544", "73", this);
            obj.set_taborder("91");
            obj.set_scrollbars("autovert");
            obj.set_binddataset("ds_grd");
            obj.set_autofittype("col");
            obj.set_autosizingtype("row");
            obj.set_extendsizetype("row");
            obj.set_scrollpixel("all");
            obj.set_nodataimage("URL('theme://Image/grd_WF_NoDataImg.png')");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"97\"/><Column size=\"231\"/><Column size=\"78\"/><Column size=\"113\"/></Columns><Rows><Row size=\"55\" band=\"head\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"시간\"/><Cell col=\"1\" text=\"행사명\"/><Cell col=\"2\" text=\"인원\"/><Cell col=\"3\" text=\"예약상태\"/></Band><Band id=\"body\"><Cell displaytype=\"combo\" style=\"align:center middle;padding:0 10 0 10;\" text=\"bind:strTime\" wordwrap=\"char\" maskchar=\" \" combodataset=\"ds_time\" combocodecol=\"cd\" combodatacol=\"cdNm\" autosizerow=\"limitmin\"/><Cell col=\"1\" style=\"align:left middle;padding:0 10 0 10;\" text=\"bind:reservNm\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell col=\"2\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 0;\" text=\"bind:psn\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell col=\"3\" style=\"align:right middle;padding:0 10 0 10;\" text=\"bind:reservStatusNm\" wordwrap=\"char\" autosizerow=\"limitmin\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Button("btn_place00", "absolute", "483", "8", "47", "47", null, null, this);
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

            obj = new Grid("grd_list", "absolute", "0", "175", null, null, "0", "0", this);
            obj.set_cssclass("grd_WF_Default2");
            obj.set_taborder("96");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_readonly("true");
            obj.set_nodataimage("URL('theme://Image/grd_WF_NoDataImg.png')");
            obj.set_autosizingtype("row");
            obj.set_extendsizetype("row");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"142\"/><Column size=\"100\"/><Column size=\"62\"/><Column size=\"117\"/><Column size=\"55\"/><Column size=\"65\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"51\" band=\"head\"/><Row size=\"51\" band=\"head\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"3\"/></Rows><Band id=\"head\"><Cell text=\"Column0\"/><Cell col=\"1\" text=\"Column1\"/><Cell col=\"2\"/><Cell col=\"3\"/><Cell col=\"4\" text=\"Column2\"/><Cell col=\"5\" text=\"Column3\"/><Cell row=\"1\" colspan=\"3\" text=\"행사기간\"/><Cell row=\"1\" col=\"3\" colspan=\"3\" text=\"행사시간\"/><Cell row=\"2\" text=\"예약자명\"/><Cell row=\"2\" col=\"1\" text=\"인원\"/><Cell row=\"2\" col=\"2\" colspan=\"4\" text=\"행사명\"/></Band><Band id=\"body\"><Cell colspan=\"3\" displaytype=\"normal\" style=\"align:left bottom;padding:5 10 5 10;line:0 none #808080ff ;\" text=\"bind:reservDate\" wordwrap=\"char\" autosizecol=\"limitmax\"/><Cell col=\"3\" colspan=\"3\" style=\"align:left bottom;padding:5 10 5 5;line:0 none #808080ff ;\" text=\"bind:reservTime\" wordwrap=\"char\" calendardisplay=\"edit\" autosizecol=\"limitmax\"/><Cell row=\"1\" displaytype=\"normal\" style=\"align:left top;padding:5 10 5 10;line:0 solid #808080ff ;\" text=\"bind:rsvnNm\" wordwrap=\"char\" autosizecol=\"limitmax\"/><Cell row=\"1\" col=\"1\" displaytype=\"normal\" style=\"align:left top;padding:5 10 5 5;line:0 solid #808080ff ;\" text=\"bind:psn\" wordwrap=\"char\" autosizecol=\"limitmax\"/><Cell row=\"1\" col=\"2\" colspan=\"4\" style=\"align:left top;padding:5 10 5 5;line:0 solid #808080ff ;\" text=\"bind:reservNm\" wordwrap=\"char\" autosizecol=\"limitmax\"/><Cell row=\"2\" autosizerow=\"limitmax\" autosizecol=\"default\"/><Cell row=\"2\" col=\"1\" autosizerow=\"limitmax\" autosizecol=\"default\"/><Cell row=\"2\" col=\"2\" colspan=\"4\" autosizerow=\"limitmax\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_dtFrom", "absolute", "6", "124", "187", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("97");
            obj.set_dateformat("yyyy-MM-dd");

            obj = new Static("Static34", "absolute", "210", "125", "15", "47", null, null, this);
            obj.set_taborder("98");
            obj.set_text("~");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_dtTo", "absolute", "238", "124", "187", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("99");
            obj.set_dateformat("yyyy-MM-dd");

            obj = new Static("sta_dtTo", "absolute", "239", "124", "186", "47", null, null, this);
            obj.set_taborder("100");
            this.addChild(obj.name, obj);

            obj = new Static("sta_dtFrom", "absolute", "7", "124", "186", "47", null, null, this);
            obj.set_taborder("101");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("예약현황");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("ReservationReport.xfdl", "lib::lib_Com.xjs");
        this.registerScript("ReservationReport.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		예약현황
        // [부시스템명]	예약현황 - 조회
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
        	this.cal_dtTo.set_value(this.preDate);
        	
        	//사업장 세팅
        	this.edt_upjang.set_value(application.g_UpjangNm);	
        	this.outletCd = application.g_Upjang;		
        }

        /** 
         * 사업장 검색 팝업 호출
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
        		arg[11] = application.g_UpjangFlag1;
        		arg[12] = application.g_UpjangFlag2;
        	}
        	else
        	{
        		arg[4] = "OutletUpjang";
        		arg[5] = application.g_AuthLevel;
        		arg[6] = application.g_EmpNo;
        		arg[7] = application.g_Tm_Cd;
        		arg[8] = application.g_Mu_Cd;
        		arg[9] = "default";
        		arg[11] = application.g_UpjangFlag1;
        		arg[12] = application.g_UpjangFlag2;
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

        // 달력 클릭 시(To)
        this.sta_dtTo_onclick = function(obj,e)
        {
        	var objCalArg = this.cal_dtTo.value;
        	
        	application.goMain.gfn_POP_create("PopCalTo", "cmmn::CmmnCalendarPop.xfdl", "fn_callbackPOP", this, objCalArg, "POP", application.goMain.divBase);
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
        	
        	this.ds_grd.clearData();
        	
        	this.eventGubun = this.ds_eventGubun.getColumn(this.vRtn, "cd");
        	
        	var strSvcID   		 = "search";
        	var strUrl     		 = "ms/mwr/reservationReport/selectList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "ds_grd=ds_list";
        	var strArguments	 = "outletCd=" + nexacro.wrapQuote(this.outletCd)
        		strArguments     += " kindCd=" + nexacro.wrapQuote(this.eventGubun);
        		strArguments     += " startDate=" + nexacro.wrapQuote(this.cal_dtFrom.value);
        		strArguments     += " endDate=" + nexacro.wrapQuote(this.cal_dtTo.value);
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
        		case "PopCalTo":
        			this.cal_dtTo.set_value(rtn);
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
            this.addEventHandler("ondrag", this.ReservationReport_ondrag, this);
            this.addEventHandler("ondragmove", this.ReservationReport_ondragmove, this);
            this.btn_search.addEventHandler("onclick", this.btn_search_onclick, this);
            this.grd_list000.addEventHandler("onvscroll", this.grd_list_onvscroll, this);
            this.grd_list000.addEventHandler("onslide", this.grd_list_onslide, this);
            this.grd_list000.addEventHandler("ondragmove", this.grd_list_ondragmove, this);
            this.btn_place00.addEventHandler("onclick", this.btn_upjang_onclick, this);
            this.cbo_event.addEventHandler("ondropdown", this.cbo_event_ondropdown, this);
            this.grd_list.addEventHandler("onvscroll", this.grd_list_onvscroll, this);
            this.grd_list.addEventHandler("oncellclick", this.grd_list_oncellclick, this);
            this.grd_list.addEventHandler("onslide", this.grd_list_onslide, this);
            this.cal_dtFrom.addEventHandler("ontouchstart", this.div_additionOrder_cal_dtTo_ontouchstart, this);
            this.cal_dtTo.addEventHandler("ontouchstart", this.div_additionOrder_cal_dtTo_ontouchstart, this);
            this.sta_dtTo.addEventHandler("onclick", this.sta_dtTo_onclick, this);
            this.sta_dtFrom.addEventHandler("onclick", this.sta_dtFrom_onclick, this);

        };

        this.loadIncludeScript("ReservationReport.xfdl", true);

       
    };
}
)();
