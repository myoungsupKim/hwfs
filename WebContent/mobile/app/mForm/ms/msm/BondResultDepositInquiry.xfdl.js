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
                this.set_name("BondResultDepositInquiry");
                this.set_titletext("거래처별 채권");
                this._setFormPosition(0,0,540,760);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_rdo", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"lev\" type=\"STRING\" size=\"256\"/><Column id=\"Column1\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"lev\">0</Col><Col id=\"Column1\">본사</Col></Row><Row><Col id=\"lev\">1</Col><Col id=\"Column1\">사업장</Col></Row></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_grd", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"mainUpjang\" type=\"STRING\" size=\"256\"/><Column id=\"mainUpjangnm\" type=\"STRING\" size=\"256\"/><Column id=\"upjang\" type=\"STRING\" size=\"256\"/><Column id=\"upjangnm\" type=\"STRING\" size=\"256\"/><Column id=\"partSalesSabun\" type=\"STRING\" size=\"256\"/><Column id=\"partSalesSabunnm\" type=\"STRING\" size=\"256\"/><Column id=\"creditAmount\" type=\"STRING\" size=\"256\"/><Column id=\"gichoAmt01\" type=\"STRING\" size=\"256\"/><Column id=\"machuAmt01\" type=\"STRING\" size=\"256\"/><Column id=\"rcpAmt01\" type=\"STRING\" size=\"256\"/><Column id=\"gimalAmt01\" type=\"STRING\" size=\"256\"/><Column id=\"gichoAmt02\" type=\"STRING\" size=\"256\"/><Column id=\"machuAmt02\" type=\"STRING\" size=\"256\"/><Column id=\"rcpAmt02\" type=\"STRING\" size=\"256\"/><Column id=\"gimalAmt02\" type=\"STRING\" size=\"256\"/><Column id=\"gichoAmt03\" type=\"STRING\" size=\"256\"/><Column id=\"machuAmt03\" type=\"STRING\" size=\"256\"/><Column id=\"rcpAmt03\" type=\"STRING\" size=\"256\"/><Column id=\"gimalAmt03\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("Static00", "absolute", "0", "60", null, "59", "0", null, this);
            obj.set_taborder("108");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

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

            obj = new Static("Static15", "absolute", "0", "187", "10", "501", null, null, this);
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

            obj = new Edit("edt_salesPersonNm", "absolute", "139", "8", null, "47", "10", null, this);
            obj.set_taborder("80");
            obj.set_displaynulltext("영업사원명을 입력하세요");
            obj.set_autoselect("true");
            obj.set_readonly("true");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "0", "118", null, "59", "0", null, this);
            obj.set_taborder("82");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "119", "17", "20", "29", null, null, this);
            obj.set_taborder("84");
            obj.set_text("글자사이간격w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Button("Button00", "absolute", null, "124", "100", "47", "10", null, this);
            obj.set_taborder("86");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "0", "2", "135", "59", null, null, this);
            obj.set_taborder("87");
            obj.set_text("영업사원");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Button("btn_salesPerson", "absolute", null, "8", "47", "47", "10", null, this);
            obj.set_taborder("90");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "530", "187", "10", "501", null, null, this);
            obj.set_taborder("92");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list", "absolute", "10", "215", "520", null, null, "0", this);
            obj.set_taborder("100");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("autovert");
            obj.set_selecttype("row");
            obj.set_scrollpixel("all");
            obj.set_nodataimage("URL('theme://Image/grd_WF_NoDataImg.png')");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"110\"/><Column size=\"136\"/><Column size=\"136\"/><Column size=\"136\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"GrayLabel\"/><Cell col=\"1\"/><Cell col=\"2\"/><Cell col=\"3\" text=\"WhiteLabel\"/></Band><Band id=\"body\"><Cell colspan=\"4\" celltype=\"none\" displaytype=\"normal\" edittype=\"none\" style=\"align:left middle;padding:0 5 0 10;background:#74748aff;background2:#74748aff;color:#ffffffff;color2:#ffffffff;selectbackground:#74748aff;selectcolor:#ffffffff;\" cssclass=\"CellGrd_WF_LabelIndigo\" text=\"bind:upjangnm\"/><Cell row=\"1\" celltype=\"none\" style=\"align:left middle;padding:0 5 0 5;background:#edededff;background2:#edededff;selectcolor:#555555ff;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"총여신\"/><Cell row=\"1\" col=\"1\" colspan=\"3\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 5;\" text=\"bind:creditAmount\" mask=\"###,###,###.##\"/><Cell row=\"2\" celltype=\"none\" style=\"align:left middle;padding:0 5 0 5;background:#edededff;background2:#edededff;selectcolor:#555555ff;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"기초잔고\"/><Cell row=\"2\" col=\"1\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 5;\" text=\"bind:gichoAmt01\" mask=\"###,###,###.##\"/><Cell row=\"2\" col=\"2\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 5;\" text=\"bind:gichoAmt02\" mask=\"###,###,###.##\"/><Cell row=\"2\" col=\"3\" displaytype=\"number\" edittype=\"none\" style=\"align:right middle;padding:0 5 0 5;selectcolor: ;\" text=\"bind:gichoAmt03\" mask=\"###,###,###.##\"/><Cell row=\"3\" style=\"align:left middle;padding:0 5 0 5;background:#edededff;background2:#edededff;selectcolor:#555555ff;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"당월매출\"/><Cell row=\"3\" col=\"1\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 5;\" text=\"bind:machuAmt01\" mask=\"###,###,###.##\"/><Cell row=\"3\" col=\"2\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 5;\" text=\"bind:machuAmt02\" mask=\"###,###,###.##\"/><Cell row=\"3\" col=\"3\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 5;selectcolor: ;\" text=\"bind:machuAmt03\" mask=\"###,###,###.##\"/><Cell row=\"4\" style=\"align:left middle;padding:0 5 0 5;background:#edededff;background2:#edededff;selectcolor:#555555ff;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"당월입금\"/><Cell row=\"4\" col=\"1\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 5;\" text=\"bind:rcpAmt01\" mask=\"###,###,###.##\"/><Cell row=\"4\" col=\"2\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 5;\" text=\"bind:rcpAmt02\" mask=\"###,###,###.##\"/><Cell row=\"4\" col=\"3\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 5;selectcolor: ;\" text=\"bind:rcpAmt03\" mask=\"###,###,###.##\"/><Cell row=\"5\" style=\"align:left middle;padding:0 5 0 5;background:#edededff;background2:#edededff;selectcolor:#555555ff;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"기말잔고\"/><Cell row=\"5\" col=\"1\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 5;\" text=\"bind:gimalAmt01\" mask=\"###,###,###.##\"/><Cell row=\"5\" col=\"2\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 5;\" text=\"bind:gimalAmt02\" mask=\"###,###,###.##\"/><Cell row=\"5\" col=\"3\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 5;selectcolor: ;\" text=\"bind:gimalAmt03\" mask=\"###,###,###.##\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "119", "73", "20", "29", null, null, this);
            obj.set_taborder("105");
            obj.set_text("글자사이간격w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static25", "absolute", "0", "118", "135", "59", null, null, this);
            obj.set_taborder("107");
            obj.set_text("조회일자");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_mainOffice", "absolute", "139", "66", null, "47", "10", null, this);
            obj.set_taborder("109");
            obj.set_displaynulltext("본사를 입력하세요");
            obj.set_readonly("true");
            obj.set_autoselect("true");
            this.addChild(obj.name, obj);

            obj = new Static("Static18", "absolute", "0", "60", "135", "59", null, null, this);
            obj.set_taborder("110");
            obj.set_text("본사");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Button("btn_mainOffice", "absolute", null, "66", "47", "47", "10", null, this);
            obj.set_taborder("111");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);

            obj = new Button("btn_moreView", "absolute", "128", null, null, "42", "136", "0", this);
            obj.set_taborder("112");
            obj.set_visible("false");
            obj.style.set_background("darkgray");
            obj.style.set_color("white");
            obj.style.set_opacity("75");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_dtFrom", "absolute", "140", "124", "284", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("113");
            obj.set_dateformat("yyyy-MM");
            obj.set_editformat("yyyy-MM");

            obj = new Static("sta_dtFrom", "absolute", "140", "124", "284", "47", null, null, this);
            obj.set_taborder("114");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "16", "182", "507", "28", null, null, this);
            obj.set_taborder("115");
            obj.set_text("※ 현재월 포함 3개월의 내역을 보여줍니다.(내역클릭시 담보현황 확인가능)");
            obj.style.set_color("red");
            obj.style.set_font("bold antialias 10 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", null, "173", "120", "47", "-21", null, this);
            obj.set_taborder("116");
            obj.set_text("[단위:원]");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("거래처별 채권");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("BondResultDepositInquiry.xfdl", "lib::lib_Com.xjs");
        this.registerScript("BondResultDepositInquiry.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		거래처별 채권/실적/입금조회
        // [부시스템명]	거래처별 채권/실적/입금조회 - 조회
        // [설명]
        // 		부서 검색하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.02.06
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.06 : 강대성 : 신규화면.
        // 2015.06.01 : 강대성 : 조회로직추가.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*======================================================
         전역변수
         ======================================================*/
        this.fv_totalpageRow;
        this.preDate = undefined;
        this.sabun = undefined;
        this.mainUpjang = undefined;

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
        	//this.fn_SetAuth("this.edt_salesPersonNm", "this.btn_salesPerson");
        	
        	// 권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetAuth("this.edt_mainOffice", "this.btn_mainOffice");
        	
        	//현재월 
        	this.preDate = this.gfn_Today();
        	this.cal_dtFrom.set_value(this.preDate);
        	
        	this.sabun = application.g_EmpNo;
        	this.edt_salesPersonNm.set_value(application.g_Name);
        	
        }

        /** 
         * 영업사원 검색 팝업 호출
         */
        this.btn_salesPerson_onclick = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.edt_salesPersonNm.value;
        	
        	application.goMain.gfn_POP_create("salesPersonNm", "M_MSM::SalesPersonSearchPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        /** 
         * 본사 검색 팝업 호출
         */
        this.btn_mainoffice_onclick = function(obj,e)
        {
        	var arg = new Array();
        	//arg[0] = this.edt_mainOffice.value;
        	
        	application.goMain.gfn_POP_create("mainOfficeNm", "M_MLM::MainofficeSearchPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        // 달력 클릭 시(From)
        this.sta_dtFrom_onclick = function(obj,e)
        {
        	var objCalArg = this.cal_dtFrom.value;
        	
        	application.goMain.gfn_POP_create("PopCalFrom", application.goMain.divBase.div_calendarMonth, "fn_callbackPOP", this, objCalArg, "POPDivx", application.goMain.divBase);
        	return false;
        }

        // 그리드 cell선택시 담보현황팝업 호출
        this.grd_list_oncellclick = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_grd.getColumn(this.ds_grd.rowposition, "upjang");
        	
        	application.goMain.gfn_POP_create("damboList", "M_MSM::BondResultDepositInquiryDamboPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
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
        	this.ds_grd.clearData();
        	this.btn_moreView.set_visible(false);
        	
        	var reqDate = this.gfn_LastDate(this.gfn_subStr(this.cal_dtFrom.value,0,6) + "01");
        	
        	//필수항목 
        	if (this.fn_searchChk()) return;
        	
        	var strSvcID   		 = "search";
        	var strUrl     		 = "ms/msm/bondResultDepositInquiry/selectList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "ds_grd=ds_list";
        	var strArguments	 = "sabun=" + nexacro.wrapQuote(this.gfn_transNullToEmpty(this.sabun));
        	   strArguments     += " reqDate=" + nexacro.wrapQuote(reqDate);
        	   strArguments     += " mainUpjang=" + nexacro.wrapQuote(this.gfn_transNullToEmpty(this.mainUpjang));
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
        // 	if ( this.gfn_isNull(this.edt_salesPersonNm.value) )
        // 	{
        // 		application.goMain.gfn_Msg("ALERT_0", "알림", "영업사원을 입력하세요.", "OK", true, this);
        // 		return true;
        // 	}

        	if ( this.gfn_isNull(this.cal_dtFrom.value) )
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "조회일자를 입력하세요.", "OK", true, this);
        		return true;
        	}	
        	
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
        		//채권/실적/입금조회
                case "search" :
        			this.fv_totalpageRow = this.ds_grd.getRowCount();
                    // 조회 건수 확인  
                    if (this.ds_grd.getRowCount() == 0) 
                    {
                        application.goMain.gfn_Msg("alertTest", "Information", "조회되는 내용이 없습니다.", "OK");	//조회되는 내용이 없습니다.
                        return;
                    }
                    else // 조회건수가 1페이지 이상일때
                    {
        				// 추가발주승인 및 마감취소승인 조회
        				this.btn_moreView.set_visible(true);
        				this.btn_moreView.set_text("총건수:" +this.fv_totalpageRow);				
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
        		case "salesPersonNm":
        			this.edt_salesPersonNm.set_value(rtn[1]);
        			this.sabun = rtn[0]
        			break;
        		case "mainOfficeNm":
        			this.edt_mainOffice.set_value(rtn[1]);
        			this.mainUpjang = rtn[0];
        			break;
        		case "PopCalFrom":
        			this.cal_dtFrom.set_value(rtn);
        			break;	
        		case "damboList":
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
        	}
        }

        // div안의 스크롤바 조정일 경우 아래 함수 추가
        this.fn_setDivScrollbar = function()
        {
        	// 해당 div로 바꿔준다.
        	this.grd_list.vscrollbar.set_pos(0);
        }

        this.edt_salesPersonNm_ontouchend = function(obj,e)
        {
        	this.edt_salesPersonNm.set_value("");
        	this.sabun = "";
        }

        this.edt_mainOffice_ontouchend = function(obj,e)
        {
        	this.edt_mainOffice.set_value("");
        	this.mainUpjang = "";
        }

        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.edt_salesPersonNm.addEventHandler("ontouchend", this.edt_salesPersonNm_ontouchend, this);
            this.Button00.addEventHandler("onclick", this.btnSearch_onclick, this);
            this.btn_salesPerson.addEventHandler("onclick", this.btn_salesPerson_onclick, this);
            this.grd_list.addEventHandler("onvscroll", this.grd_list_onvscroll, this);
            this.grd_list.addEventHandler("onslide", this.grd_list_onslide, this);
            this.grd_list.addEventHandler("oncellclick", this.grd_list_oncellclick, this);
            this.edt_mainOffice.addEventHandler("onchanged", this.edt_mainOffice_onchanged, this);
            this.edt_mainOffice.addEventHandler("ontouchend", this.edt_mainOffice_ontouchend, this);
            this.btn_mainOffice.addEventHandler("onclick", this.btn_mainoffice_onclick, this);
            this.btn_moreView.addEventHandler("onclick", this.div_tab01_btn_moreView_onclick, this);
            this.cal_dtFrom.addEventHandler("ontouchstart", this.div_additionOrder_cal_dtTo_ontouchstart, this);
            this.sta_dtFrom.addEventHandler("onclick", this.sta_dtFrom_onclick, this);

        };

        this.loadIncludeScript("BondResultDepositInquiry.xfdl", true);

       
    };
}
)();
