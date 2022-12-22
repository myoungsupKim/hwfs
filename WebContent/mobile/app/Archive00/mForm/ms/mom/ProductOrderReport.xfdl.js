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
                this.set_name("ProductOrderReport");
                this.set_titletext("상품발주현황");
                this._setFormPosition(0,0,540,760);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_grdSummary", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"itemVatSum\" type=\"STRING\" size=\"256\"/><Column id=\"itemAmountSum\" type=\"STRING\" size=\"256\"/><Column id=\"itemTotSum\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"itemVatSum\"/><Col id=\"itemAmountSum\"/></Row></Rows>");
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
            obj._setContents("<ColumnInfo><Column id=\"gb\" type=\"STRING\" size=\"256\"/><Column id=\"itemCode\" type=\"STRING\" size=\"256\"/><Column id=\"itemName\" type=\"STRING\" size=\"256\"/><Column id=\"itemSize\" type=\"STRING\" size=\"256\"/><Column id=\"poUom\" type=\"STRING\" size=\"256\"/><Column id=\"prQty\" type=\"STRING\" size=\"256\"/><Column id=\"salePrice\" type=\"STRING\" size=\"256\"/><Column id=\"opPrice\" type=\"STRING\" size=\"256\"/><Column id=\"opAmount\" type=\"STRING\" size=\"256\"/><Column id=\"opVat\" type=\"STRING\" size=\"256\"/><Column id=\"opTot\" type=\"STRING\" size=\"256\"/><Column id=\"prRemark\" type=\"STRING\" size=\"256\"/><Column id=\"prId\" type=\"STRING\" size=\"256\"/><Column id=\"needDate\" type=\"STRING\" size=\"256\"/><Column id=\"ptype\" type=\"STRING\" size=\"256\"/><Column id=\"originType\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_storageCd", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"256\"/><Column id=\"cdNm\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"cd\">01</Col><Col id=\"cdNm\">창고1</Col></Row><Row><Col id=\"cd\">02</Col><Col id=\"cdNm\">창고2</Col></Row><Row><Col id=\"cd\">03</Col><Col id=\"cdNm\">창고3</Col></Row><Row><Col id=\"cd\">04</Col><Col id=\"cdNm\">창고4</Col></Row></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_grdServer", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"gb\" type=\"STRING\" size=\"256\"/><Column id=\"itemCode\" type=\"STRING\" size=\"256\"/><Column id=\"itemName\" type=\"STRING\" size=\"256\"/><Column id=\"itemSize\" type=\"STRING\" size=\"256\"/><Column id=\"poUom\" type=\"STRING\" size=\"256\"/><Column id=\"prQty\" type=\"STRING\" size=\"256\"/><Column id=\"salePrice\" type=\"STRING\" size=\"256\"/><Column id=\"opPrice\" type=\"STRING\" size=\"256\"/><Column id=\"opAmount\" type=\"STRING\" size=\"256\"/><Column id=\"opVat\" type=\"STRING\" size=\"256\"/><Column id=\"opTot\" type=\"STRING\" size=\"256\"/><Column id=\"prRemark\" type=\"STRING\" size=\"256\"/><Column id=\"prId\" type=\"STRING\" size=\"256\"/><Column id=\"needDate\" type=\"STRING\" size=\"256\"/><Column id=\"ptype\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Button("btn_mobile", "absolute", "270", "0", "270", "63", null, null, this);
            obj.set_taborder("14");
            obj.set_text("모바일");
            obj.set_cssclass("btn_WF_TabMFOff");
            this.addChild(obj.name, obj);

            obj = new Button("btn_all", "absolute", "0", "0", "270", "63", null, null, this);
            obj.set_taborder("15");
            obj.set_text("전체발주");
            obj.set_cssclass("btn_WF_TabMFOn");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "121", null, "59", "0", null, this);
            obj.set_taborder("17");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Combo("cbo_storage", "absolute", "10", "127", null, "47", "10", null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("18");
            obj.set_displaynulltext("창고명 선택");
            obj.set_innerdataset("@ds_storageCd");
            obj.set_codecolumn("cd");
            obj.set_datacolumn("cdNm");
            obj.set_index("-1");

            obj = new Static("Static02", "absolute", "0", "179", null, "59", "0", null, this);
            obj.set_taborder("19");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_dtFrom", "absolute", "10", "185", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("20");
            obj.set_dateformat("yyyy-MM-dd");

            obj = new Static("Static34", "absolute", "210", "185", "15", "47", null, null, this);
            obj.set_taborder("21");
            obj.set_text("~");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_dtTo", "absolute", "225", "185", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("22");
            obj.set_dateformat("yyyy-MM-dd");

            obj = new Button("btn_search", "absolute", null, "185", "100", "47", "10", null, this);
            obj.set_taborder("23");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "238", "540", "10", null, null, this);
            obj.set_taborder("24");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "239", "10", "478", null, null, this);
            obj.set_taborder("25");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "530", "239", "10", "478", null, null, this);
            obj.set_taborder("27");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "0", "369", "540", "10", null, null, this);
            obj.set_taborder("28");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list01", "absolute", "10", "379", null, null, "10", "0", this);
            obj.set_taborder("29");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"88\"/><Column size=\"137\"/><Column size=\"123\"/><Column size=\"173\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"GrayLabel\"/><Cell col=\"1\" text=\"WhiteLabel\"/><Cell col=\"2\" text=\"GrayLabel\"/><Cell col=\"3\" text=\"WhiteLabel\"/></Band><Band id=\"body\"><Cell colspan=\"4\" celltype=\"none\" style=\"align:left middle;padding:0 5 0 10;background:gainsboro;background2:gainsboro;color:black;color2:black;selectbackground:gainsboro;selectcolor:black;\" cssclass=\"CellGrd_WF_LabelIndigo\" text=\"expr:itemCode + &quot; &quot; + itemName\"/><Cell row=\"1\" celltype=\"none\" style=\"align:left middle;padding:0 5 0 10;background:#edededff;background2:#edededff;selectbackground:#edededff;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"규격\"/><Cell row=\"1\" col=\"1\" colspan=\"3\" displaytype=\"normal\" edittype=\"none\" style=\"align:left middle;padding:0 10 0 10;selectbackground:#ffffffff;selectcolor:#555555ff;\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:itemSize\"/><Cell row=\"2\" celltype=\"none\" style=\"align:left middle;padding:0 5 0 10;background:#edededff;background2:#edededff;selectbackground:#edededff;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"원산지\"/><Cell row=\"2\" col=\"1\" edittype=\"none\" style=\"align:right middle;padding:0 10 0 10;selectbackground:#ffffffff;selectcolor:#555555ff;\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:originType\"/><Cell row=\"2\" col=\"2\" celltype=\"none\" style=\"align:left middle;padding:0 5 0 10;background:#edededff;background2:#edededff;selectbackground:#edededff;selectcolor:#555555ff;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"수량/단위\"/><Cell row=\"2\" col=\"3\" displaytype=\"normal\" edittype=\"none\" style=\"align:right middle;padding:0 10 0 10;selectbackground:#ffffffff;\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"expr:prQty + &quot;/&quot; + poUom\"/><Cell row=\"3\" style=\"align:left middle;padding:0 5 0 10;background:#edededff;background2:#edededff;selectbackground:#edededff;selectcolor:#555555ff;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"단가\"/><Cell row=\"3\" col=\"1\" displaytype=\"number\" style=\"align:right middle;padding:0 10 0 5;color:#1f5bc9ff;color2:#1f5bc9ff;selectcolor:#1f5bc9ff;\" cssclass=\"CellGrd_WF_ColorBlue\" text=\"bind:opPrice\" mask=\"###,###,###.##\"/><Cell row=\"3\" col=\"2\" style=\"align:left middle;padding:0 5 0 10;background:#edededff;background2:#edededff;selectbackground:#edededff;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"금액\"/><Cell row=\"3\" col=\"3\" displaytype=\"number\" style=\"align:right middle;padding:0 10 0 10;background:transparent;color:red;color2:red;selectcolor:red;\" cssclass=\"CellGrd_WF_ColorRed\" text=\"bind:opAmount\" mask=\"###,###,###.##\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Button("btn_moreView", "absolute", "128", null, null, "42", "136", "0", this);
            obj.set_taborder("30");
            obj.set_visible("false");
            obj.style.set_background("darkgray");
            obj.style.set_color("white");
            obj.style.set_opacity("90");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "0", "63", null, "59", "0", null, this);
            obj.set_taborder("31");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_upjang", "absolute", "10", "69", null, "47", "10", null, this);
            obj.set_taborder("32");
            obj.set_displaynulltext("사업장을 입력하세요");
            obj.set_readonly("true");
            obj.set_autoselect("true");
            this.addChild(obj.name, obj);

            obj = new Button("btn_upjang", "absolute", null, "69", "47", "47", "11", null, this);
            obj.set_taborder("33");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list00", "absolute", "10", "247", null, "122", "10", null, this);
            obj.set_cssclass("grd_WF_SumType");
            obj.set_taborder("34");
            obj.set_binddataset("ds_grdSummary");
            obj.set_scrollbars("none");
            obj.set_selecttype("cell");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"140\"/><Column size=\"380\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"5\"/><Row size=\"38\"/><Row size=\"38\"/><Row size=\"38\"/><Row size=\"5\"/></Rows><Band id=\"head\"><Cell text=\"GrayLabel\"/><Cell col=\"1\"/></Band><Band id=\"body\"><Cell/><Cell col=\"1\"/><Cell row=\"1\" celltype=\"none\" style=\"align:left;padding:0 10 0 10;line:0 solid #808080ff ;\" text=\"공급가\"/><Cell row=\"1\" col=\"1\" displaytype=\"number\" style=\"align:right middle;padding:0 10 0 10;line:0 solid #808080ff ;\" text=\"bind:itemAmountSum\" mask=\"###,###,###.##\"/><Cell row=\"2\" celltype=\"none\" style=\"align:left;padding:0 10 0 10;line:0 solid #808080ff ;\" text=\"부가세\"/><Cell row=\"2\" col=\"1\" displaytype=\"number\" style=\"align:right middle;padding:0 10 0 10;line:0 solid #808080ff ;\" text=\"bind:itemVatSum\" mask=\"###,###,###.##\"/><Cell row=\"3\" celltype=\"none\" style=\"align:left;padding:0 10 0 10;line:0 solid #808080ff ;\" text=\"총발주금액\"/><Cell row=\"3\" col=\"1\" displaytype=\"number\" style=\"align:right middle;padding:0 10 0 10;line:0 solid #808080ff ;color:red;color2:red;selectcolor:red;\" text=\"bind:itemTotSum\" mask=\"###,###,###.##\"/><Cell row=\"4\"/><Cell row=\"4\" col=\"1\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("sta_dtFrom", "absolute", "10", "185", "195", "47", null, null, this);
            obj.set_taborder("35");
            this.addChild(obj.name, obj);

            obj = new Static("sta_dtTo", "absolute", "225", "185", "195", "47", null, null, this);
            obj.set_taborder("36");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("상품발주현황");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("ProductOrderReport.xfdl", "lib::lib_Com.xjs");
        this.registerScript("ProductOrderReport.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		상품발주현황
        // [부시스템명]	상품발주현황 - 조회
        // [설명]
        // 		부서 검색하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.02.03
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.03 : 강대성 : 수정이 필요하여 수정함.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*======================================================
         전역변수
         ======================================================*/
        this.preDate = undefined;
        this.fv_pageRow = 10;	// 페이지당 건수
        this.fv_totalpageRow;	// 전체건수
        this.fv_curPageNum = 1;	// 페이지 번호
        this.upjang = undefined;
        this.mobileGubun = undefined;
        var vRtn = 0;

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
        	
        	this.preDate = this.gfn_Today();
        	this.cal_dtFrom.set_value(this.gfn_AddDate(this.preDate, 1));
        	this.cal_dtTo.set_value(this.gfn_AddDate(this.preDate, 1));
        	this.edt_upjang.set_value(application.g_UpjangNm);
        	this.upjang = application.g_Upjang;	
        	this.mobileGubun = "";
        	
        	//창고 콤보 데이터 호출
        	this.subInventorySearch();
        }

        //상단 버튼에 따라 cssclass변경
        this.btn_all_onclick = function(obj,e)
        {
        	this.btn_all.set_cssclass("btn_WF_TabMFOn");
        	this.btn_mobile.set_cssclass("btn_WF_TabMFOff");
        	this.mobileGubun = "";
        	this.fn_search();
        }

        this.btn_mobile_onclick = function(obj,e)
        {
        	this.btn_all.set_cssclass("btn_WF_TabMFOff");
        	this.btn_mobile.set_cssclass("btn_WF_TabMFOn");
        	this.mobileGubun = "M";
        	this.fn_search();
        }

        /*==========================================================================
         * 사업장 검색 팝업 호출
        *========================================================================*/
        this.btn_upjang_onclick = function(obj,e)
        {
        	var arg = new Array();
        	arg[1] = this.upjang;
        	arg[2] = "FMS";	
        	
        	application.goMain.gfn_POP_create("upjangNm", "M_MLM::WorkplaceSearchPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;	
        }

        /*==========================================================================
         * 창고 콤보 팝업
        *========================================================================*/
        this.cbo_Storage_ondropdown = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_storageCd;
        	arg[1] = "조회조건(창고)";
        	arg[2] = "";
        	arg[3] = "cdNm";
        	application.goMain.gfn_POP_create("Storage", "cmmn::CmmnComboList.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
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
        	
        	var subinvCd = this.ds_storageCd.getColumn(vRtn, "cd");
        	
        	// 초기화
        	this.grd_list00.set_visible(true);
        	this.grd_list01.set_top(379);
        	this.btn_moreView.set_visible(false);
        	this.ds_grdSummary.clearData();
        	this.ds_grd.clearData();	
        	
        	//필수항목 
        	if (this.fn_searchChk()) return;
        	
        	var strSvcID   		 = "productOrderReport";
        	var strUrl     		 = "ms/mom/selectList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "ds_grd=ds_output";
        	var strArguments	 = "upjang=" + nexacro.wrapQuote(this.upjang);
        	   strArguments     += " subinvCd=" + nexacro.wrapQuote(subinvCd);
        	   strArguments     += " calDtFrom=" + nexacro.wrapQuote(this.cal_dtFrom.value);
        	   strArguments     += " calDtTo=" + nexacro.wrapQuote(this.cal_dtTo.value);
        	   strArguments     += " mobileGubun=" + nexacro.wrapQuote(this.mobileGubun);
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
          	// connect the server 
        	
        }

        /*******************************************************************************
        * 기      능   :  사업장 창고 호출
        * 설      명   :  사업장 창고 호출
        ********************************************************************************/
        this.subInventorySearch = function()
        {
        	var strSvcID   		 = "subInventory";
        	var strUrl     		 = "/ms/mom/subInventory/selectList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "ds_storageCd=ds_list";
        	var strArguments	 = "upjang=" + nexacro.wrapQuote(this.upjang);
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
        		application.goMain.gfn_Msg("ALERT_0", "알림", "입고일(From)을 정확하게 입력하세요.", "OK");
        		return true;
        	}
        	
        	if ( this.gfn_isNull(this.cal_dtTo.value) || (this.gfn_Length(this.cal_dtTo.value)< 8) )
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "입고일(To)을 정확하게 입력하세요.", "OK");
        		return true;
        	}
        	
        	if ( this.cal_dtFrom.value > this.cal_dtTo.value )
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "시작일보다 종료일이 늦습니다.", "OK");
        		return true;		
        	}
        	
        	if ( this.gfn_subStr(this.cal_dtFrom.value,0,6)!= this.gfn_subStr(this.cal_dtTo.value,0,6))
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "기간은 동일월에 한하여 조회가능합니다.", "OK");
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
        		//상품발주현황조회
                case "productOrderReport" :
        			// TODO parameter로 전체건수를 받는다.
        			this.fv_totalpageRow = this.ds_grd.getRowCount();			
        			
        			// 조회 건수 확인  
                    if (this.ds_grd.getRowCount() == 0) 
                    {
                        application.goMain.gfn_Msg("alertTest", "Information", "조회되는 내용이 없습니다.", "OK");	//조회되는 내용이 없습니다.
                        return;
                    }
                    else// 조회건수가 1페이지 이상일때
                    {
        				var itemTotSum = this.ds_grd.getSum("opVat") + this.ds_grd.getSum("opAmount")
        				
        				var nRow = this.ds_grdSummary.addRow();
        				this.ds_grdSummary.setColumn(nRow, "itemVatSum", this.ds_grd.getSum("opVat"));
        				this.ds_grdSummary.setColumn(nRow, "itemAmountSum", this.ds_grd.getSum("opAmount"));
        				this.ds_grdSummary.setColumn(nRow, "itemTotSum", itemTotSum);
        				
        				// 총건수 표시
        				this.btn_moreView.set_visible(true);
        				this.btn_moreView.set_text("총건수:" +this.fv_totalpageRow);		
                    }
          			break;
          		// 창고 콜백 함수
                case "subInventory" :
        			
        			//정상적으로 창고명 호출 시 창고코드 세팅
        			this.cbo_storage.set_text(this.ds_storageCd.getColumn(0, "cdNm"));
          			
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
        			this.upjang = rtn[0];			
        			this.subInventorySearch();
        			break;
        		case "Storage":
        			this.cbo_storage.set_index(rtn);
        		    vRtn = rtn;
        			break;
        		case "PopCalFrom":
        			this.cal_dtFrom.set_value(rtn);
        			//기간시작일 선택시 선택된 해당일을 기간종료일에 세팅해준다
        			this.cal_dtTo.set_value(rtn);
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
        	}
        }

        this.grd_list_onslide = function(obj,e)
        {
        	
        	if (e.yaccvalue > 0)
        	{
        		this.parent.parent.divBottom.set_visible(true);
        		this.parent.parent.divMain.set_height(833);
        		this.parent.parent.divBottom.bringToFront();
        		this.grd_list00.set_visible(true);
        		this.btn_moreView.set_visible(true);
        		this.grd_list01.set_top(379);
        	}
        	else if (e.yaccvalue < 0)
        	{
        		if (this.ds_grd.getRowCount() > 0)
        		{
        			this.parent.parent.divBottom.set_visible(false);
        			this.parent.parent.divMain.set_height(923);
        			this.grd_list00.set_visible(false);
        			this.btn_moreView.set_visible(false);
        			this.grd_list01.set_top(247);
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
            this.btn_mobile.addEventHandler("onclick", this.btn_mobile_onclick, this);
            this.btn_all.addEventHandler("onclick", this.btn_all_onclick, this);
            this.cbo_storage.addEventHandler("ondropdown", this.cbo_Storage_ondropdown, this);
            this.btn_search.addEventHandler("onclick", this.btnSearch_onclick, this);
            this.grd_list01.addEventHandler("onvscroll", this.grd_list_onvscroll, this);
            this.grd_list01.addEventHandler("onslide", this.grd_list_onslide, this);
            this.btn_moreView.addEventHandler("onclick", this.div_tab01_btn_moreView_onclick, this);
            this.btn_upjang.addEventHandler("onclick", this.btn_upjang_onclick, this);
            this.sta_dtFrom.addEventHandler("onclick", this.sta_dtFrom_onclick, this);
            this.sta_dtTo.addEventHandler("onclick", this.sta_dtTo_onclick, this);

        };

        this.loadIncludeScript("ProductOrderReport.xfdl", true);

       
    };
}
)();
