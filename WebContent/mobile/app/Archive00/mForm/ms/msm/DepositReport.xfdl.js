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
                this.set_name("DepositReport");
                this.set_titletext("입금현황");
                this._setFormPosition(0,0,540,760);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_grd01", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"amtDate\" type=\"STRING\" size=\"256\"/><Column id=\"occurAmt\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_grd00", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"totalDeposit\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row/></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("Static04", "absolute", "0", "0", null, "2", "0", null, this);
            obj.set_taborder("0");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);

            obj = new Static("Static32", "absolute", "0", "2", null, "59", "0", null, this);
            obj.set_taborder("1");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_upjang", "absolute", "139", "8", null, "47", "10", null, this);
            obj.set_taborder("4");
            obj.set_displaynulltext("한촌-강남점");
            this.addChild(obj.name, obj);

            obj = new Static("Static42", "absolute", "0", "2", "135", "59", null, null, this);
            obj.set_taborder("8");
            obj.set_text("사업장");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static43", "absolute", "119", "15", "20", "89", null, null, this);
            obj.set_taborder("9");
            obj.set_text("글자사이간격w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Button("btn_upjang", "absolute", null, "8", "47", "47", "10", null, this);
            obj.set_taborder("10");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "184", "10", "538", null, null, this);
            obj.set_taborder("20");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "530", "184", "10", "538", null, null, this);
            obj.set_taborder("21");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list01", "absolute", "10", "184", null, null, "10", "0", this);
            obj.set_taborder("23");
            obj.set_scrollbars("autovert");
            obj.set_binddataset("ds_grd01");
            obj.set_autofittype("col");
            obj.set_scrollpixel("all");
            obj.set_nodataimage("URL('theme://Image/grd_WF_NoDataImg.png')");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"211\"/><Column size=\"308\"/></Columns><Rows><Row size=\"55\" band=\"head\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"입금일자\"/><Cell col=\"1\" text=\"입금액\"/></Band><Band id=\"body\"><Cell displaytype=\"normal\" style=\"align:center middle;padding:0 10 0 10;\" text=\"bind:amtDate\"/><Cell col=\"1\" displaytype=\"number\" style=\"align:right middle;padding:0 10 0 10;\" text=\"bind:occurAmt\" mask=\"###,###,###.##\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "119", "540", "10", null, null, this);
            obj.set_taborder("24");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "0", "60", null, "59", "0", null, this);
            obj.set_taborder("25");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Button("btn_search", "absolute", null, "66", "100", "47", "10", null, this);
            obj.set_taborder("26");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_dtFrom", "absolute", "10", "66", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("27");
            obj.set_dateformat("yyyy-MM-dd");
            obj.set_value("null");

            obj = new Calendar("cal_dtTo", "absolute", "225", "66", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("28");
            obj.set_dateformat("yyyy-MM-dd");
            obj.set_value("null");

            obj = new Static("Static34", "absolute", "210", "66", "15", "47", null, null, this);
            obj.set_taborder("29");
            obj.set_text("~");
            this.addChild(obj.name, obj);

            obj = new Static("Static35", "absolute", "205", "79", "5", "17", null, null, this);
            obj.set_taborder("30");
            obj.set_text("컴포넌트 사이 간격 h08");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static36", "absolute", "205", "103", "20", "17", null, null, this);
            obj.set_taborder("31");
            obj.set_text("w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "420", "77", "10", "19", null, null, this);
            obj.set_taborder("32");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "0", "174", "540", "10", null, null, this);
            obj.set_taborder("33");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list00", "absolute", "10", "127", null, "48", "10", null, this);
            obj.set_cssclass("grd_WF_SumType");
            obj.set_taborder("34");
            obj.set_binddataset("ds_grd00");
            obj.set_scrollbars("none");
            obj.set_selecttype("cell");
            obj.set_autosizingtype("row");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"140\"/><Column size=\"379\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"GrayLabel\"/><Cell col=\"1\"/></Band><Band id=\"body\"><Cell celltype=\"none\" style=\"background2: ;\" text=\"총입금액\"/><Cell col=\"1\" displaytype=\"number\" style=\"align:right middle;padding:10 10 10 10;color:red;color2:red;selectcolor:red;\" text=\"bind:totalDeposit\" mask=\"###,###,###.##\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("sta_dtFrom", "absolute", "10", "66", "195", "47", null, null, this);
            obj.set_taborder("35");
            this.addChild(obj.name, obj);

            obj = new Static("sta_dtTo", "absolute", "225", "66", "195", "47", null, null, this);
            obj.set_taborder("36");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("입금현황");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("DepositReport.xfdl", "lib::lib_Com.xjs");
        this.registerScript("DepositReport.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		입금현황
        // [부시스템명]	입금현황 - 조회
        // [설명]
        // 		부서 검색하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.02.05
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.05 : 강대성 : 수정이 필요하여 수정함.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*======================================================
         전역변수
         ======================================================*/
        this.preDate = undefined;
        this.firstDate = undefined;
        this.upjang = undefined;

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
        	// 권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetAuth("this.edt_upjang", "this.btn_upjang");
        	
        	//현재일 세팅
        	this.preDate = this.gfn_Today();
        	this.firstDate = this.gfn_subStr(this.preDate,0,4) + "0101";
        	this.cal_dtFrom.set_value(this.firstDate);
        	this.cal_dtTo.set_value(this.preDate);
        	
        	//사업장 세팅
        	this.edt_upjang.set_value(application.g_UpjangNm);	
        	upjang = application.g_Upjang;	
        	
        }

        /** 
         * 사업장 검색 팝업 호출
         */
        this.btn_upjang_onclick = function(obj,e)
        {
        	var arg = new Array();
        	arg[1] = this.upjang;
        	arg[2] = "FMS";	
        	
        	application.goMain.gfn_POP_create("upjangNm", "M_MLM::WorkplaceSearchPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
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
        this.btnSearch_onclick = function(obj,e)
        {
        	this.fn_search();
        }

        this.fn_search = function()
        {
        	this.ds_grd01.clearData();
        	this.ds_grd00.clearData();
        	
        	//필수항목 
        	if (this.fn_searchChk()) return;
        	
        	// 서비스 연결 됐을때 아래 로직으로..
        	var strSvcID   		 = "depositReport";
        	var strUrl     		 = "ms/msm/depositReport/selectList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "ds_grd01=ds_list";
        	var strArguments	 = "upjang=" + nexacro.wrapQuote(upjang);
        	   strArguments     += " calDtFrom=" + nexacro.wrapQuote(this.cal_dtFrom.value);	
        	   strArguments     += " calDtTo=" + nexacro.wrapQuote(this.cal_dtTo.value);   
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
        	if ( this.gfn_isNull(this.cal_dtFrom.value) || (this.gfn_Length(this.cal_dtFrom.value)< 8) )
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "입고일(From)을 정확하게 입력하세요.", "OK", true, this);
        		return true;
        	}
        	
        	if ( this.gfn_isNull(this.cal_dtTo.value) || (this.gfn_Length(this.cal_dtTo.value)< 8) )
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "입고일(To)을 정확하게 입력하세요.", "OK", true, this);
        		return true;
        	}
        	
        	if ( this.cal_dtFrom.value > this.cal_dtTo.value )
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "시작일보다 종료일이 늦습니다.", "OK", true, this);
        		return true;		
        	}
        	
        	if ( this.gfn_subStr(this.cal_dtFrom.value,0,4)!= this.gfn_subStr(this.cal_dtTo.value,0,4))
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "기간은 동일년에 한하여 조회가능합니다.", "OK", true, this);
        		return true;		
        	}
        	//
        	return false;
        }

        /*================================================================================
         * 5. UserFunction관련 Script
         *===============================================================================*/
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
        		//식재료비현황조회
                case "depositReport" :
        			// TODO parameter로 전체건수를 받는다.
        			
                    // 조회 건수 확인  
                    if (this.ds_grd01.getRowCount() == 0) 
                    {
                        application.goMain.gfn_Msg("alertTest", "Information", "조회되는 내용이 없습니다..", "OK");	//조회되는 내용이 없습니다.
                        return;
                    }
                    else // 조회건수가 1페이지 이상일때
                    {
        				var nRow = this.ds_grd00.addRow();
        				this.ds_grd00.setColumn(nRow, "totalDeposit", this.ds_grd01.getSum("occurAmt"));
        				
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
        		case "upjangNm":
        			this.edt_upjang.set_value(rtn[1]);
        			upjang = rtn[0];			
        			this.fn_search();
        			break;
        		case "PopCalFrom":
        			this.cal_dtFrom.set_value(rtn);
        			break;	
        		case "PopCalTo":
        			this.cal_dtTo.set_value(rtn);
        			break;				
        	}
        }

        /** 
         * 팝업 callBack
         * @param  : popname - 팝업을 구분짓는 id
         rtn : 팝업이 닫히면서 전달된 값
         * @return : 없음
         */
        this.msg_callback = function (id,rtn)
        {
        	if (id == "ALERT_0") // 조회 시 오류
        	{
        		// 아무 일도 안함.
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
        		if (this.ds_grd00.getRowCount() > 0)
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
        	}
        }

        // div안의 스크롤바 조정일 경우 아래 함수 추가
        this.fn_setDivScrollbar = function()
        {
        	// 해당 div로 바꿔준다.
        	this.grd_list01.vscrollbar.set_pos(0);
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.btn_upjang.addEventHandler("onclick", this.btn_upjang_onclick, this);
            this.grd_list01.addEventHandler("onvscroll", this.grd_list_onvscroll, this);
            this.grd_list01.addEventHandler("onslide", this.grd_list_onslide, this);
            this.btn_search.addEventHandler("onclick", this.btnSearch_onclick, this);
            this.sta_dtFrom.addEventHandler("onclick", this.sta_dtFrom_onclick, this);
            this.sta_dtTo.addEventHandler("onclick", this.sta_dtTo_onclick, this);

        };

        this.loadIncludeScript("DepositReport.xfdl", true);

       
    };
}
)();
