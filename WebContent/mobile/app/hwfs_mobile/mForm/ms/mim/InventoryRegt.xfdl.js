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
                this.set_name("InventoryRegt");
                this.set_titletext("재고등록");
                this._setFormPosition(0,0,540,760);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_keepMethodCd", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"256\"/><Column id=\"cdNm\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"cd\">01</Col><Col id=\"cdNm\">실온</Col></Row><Row><Col id=\"cd\">02</Col><Col id=\"cdNm\">냉소</Col></Row><Row><Col id=\"cd\">03</Col><Col id=\"cdNm\">냉동</Col></Row><Row><Col id=\"cd\">04</Col><Col id=\"cdNm\">상온</Col></Row><Row><Col id=\"cd\">05</Col><Col id=\"cdNm\">냉장</Col></Row><Row><Col id=\"cd\">06</Col><Col id=\"cdNm\">기타</Col></Row><Row><Col id=\"cd\">07</Col><Col id=\"cdNm\">확인요</Col></Row></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_grd", this);
            obj._setContents("<ColumnInfo><Column id=\"ADV_PHYSIC_QTY\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"BARCODE\" size=\"13\" type=\"STRING\"/><Column id=\"ITEM_CODE\" size=\"12\" type=\"STRING\"/><Column id=\"ITEM_NAME\" size=\"200\" type=\"STRING\"/><Column id=\"ITEM_SIZE\" size=\"100\" type=\"STRING\"/><Column id=\"L_CLASS_NAME\" size=\"50\" type=\"STRING\"/><Column id=\"M_CLASS_NAME\" size=\"50\" type=\"STRING\"/><Column id=\"M_REAL_AMT\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"M_REAL_QTY\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"M_REAL_QTY_SUM\" type=\"STRING\" size=\"256\"/><Column id=\"M_STK_AMT\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"M_STK_PRICE\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"M_STK_QTY\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"M_USE_AMT\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"M_USE_QTY\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"MENU_KG_QTY\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"MENU_QTY\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"PO_UOM\" size=\"10\" type=\"STRING\"/><Column id=\"TAX_CODE\" size=\"3\" type=\"STRING\"/><Column id=\"U_REAL_AMT\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"U_STK_AMT\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"U_STK_PRICE\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"U_USE_AMT\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"UOM_CODE\" size=\"10\" type=\"STRING\"/><Column id=\"UOM_CONVERT_RATE\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"VALUE_DATE_INFO\" size=\"100\" type=\"STRING\"/><Column id=\"VALUE_DATE\" size=\"256\" type=\"STRING\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_po", this);
            obj._setContents("<ColumnInfo><Column id=\"DELIVERED_QTY\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"ITEM_NAME\" size=\"213\" type=\"STRING\"/><Column id=\"NEED_DATE\" size=\"10\" type=\"STRING\"/><Column id=\"NONE_QTY\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"ORDER_QTY\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"UNDELIVERED_QTY\" size=\"22\" type=\"BIGDECIMAL\"/></ColumnInfo>");
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
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"256\"/><Column id=\"cdNm\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("Static04", "absolute", "0", "0", null, "2", "0", null, this);
            obj.set_taborder("4");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "59", null, "59", "0", null, this);
            obj.set_taborder("9");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_dtFrom", "absolute", "238", "65", "187", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("10");
            obj.set_dateformat("yyyy-MM-dd");
            obj.set_editformat("yyyy-MM-dd");
            obj.set_value("null");

            obj = new Combo("cbo_keepMethod", "absolute", "605", "71", null, "47", "-280", null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("11");
            obj.set_text("보관방법선택");
            obj.set_displaynulltext("보관방법선택");
            obj.set_value("null");
            obj.set_innerdataset("@ds_keepMethodCd");
            obj.set_codecolumn("cd");
            obj.set_datacolumn("cdNm");

            obj = new Button("btn_search", "absolute", "430", "65", "100", "47", null, null, this);
            obj.set_taborder("12");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Static("Static22", "absolute", "460", "144", "5", "19", null, null, this);
            obj.set_taborder("18");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static33", "absolute", "233", "72", "5", "29", null, null, this);
            obj.set_taborder("21");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list", "absolute", "0", "175", null, null, "0", "0", this);
            obj.set_taborder("22");
            obj.set_cssclass("grd_WF_Default2");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_readonly("true");
            obj.set_nodataimage("URL('theme://Image/grd_WF_NoDataImg.png')");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"95\"/><Column size=\"76\"/><Column size=\"79\"/><Column size=\"118\"/><Column size=\"171\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"51\"/><Row size=\"51\"/><Row size=\"3\"/></Rows><Band id=\"head\"><Cell text=\"Column0\"/><Cell col=\"1\" text=\"Column1\"/><Cell col=\"2\"/><Cell col=\"3\" text=\"Column2\"/><Cell col=\"4\" text=\"Column3\"/></Band><Band id=\"body\"><Cell colspan=\"5\" style=\"padding:0 10 0 10;line:0 none #808080ff ;background:EXPR(BG_YN==&quot;Y&quot;?&quot;red&quot;:&quot;white&quot;);background2:EXPR(BG_YN==&quot;Y&quot;?&quot;red&quot;:&quot;white&quot;);selectbackground:EXPR(BG_YN==&quot;Y&quot;?&quot;red&quot;:&quot;ghostwhite&quot;);\" text=\"expr:ITEM_CODE + &quot; &quot; + ITEM_NAME\"/><Cell row=\"1\" style=\"padding:0 5 0 10;line:0 solid #808080ff ;background:EXPR(BG_YN==&quot;Y&quot;?&quot;red&quot;:&quot;white&quot;);background2:EXPR(BG_YN==&quot;Y&quot;?&quot;red&quot;:&quot;white&quot;);selectbackground:EXPR(BG_YN==&quot;Y&quot;?&quot;red&quot;:&quot;ghostwhite&quot;);\" text=\"재고량\"/><Cell row=\"1\" col=\"1\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 5;line:0 solid #808080ff ;background:EXPR(BG_YN==&quot;Y&quot;?&quot;red&quot;:&quot;white&quot;);background2:EXPR(BG_YN==&quot;Y&quot;?&quot;red&quot;:&quot;white&quot;);selectbackground:EXPR(BG_YN==&quot;Y&quot;?&quot;red&quot;:&quot;ghostwhite&quot;);\" text=\"bind:M_STK_QTY\" mask=\"#,##0.#0\"/><Cell row=\"1\" col=\"2\" style=\"padding:0 5 0 5;line:0 solid #808080ff ;background:EXPR(BG_YN==&quot;Y&quot;?&quot;red&quot;:&quot;white&quot;);background2:EXPR(BG_YN==&quot;Y&quot;?&quot;red&quot;:&quot;white&quot;);selectbackground:EXPR(BG_YN==&quot;Y&quot;?&quot;red&quot;:&quot;ghostwhite&quot;);\" text=\"실사량\"/><Cell row=\"1\" col=\"3\" displaytype=\"number\" edittype=\"none\" style=\"align:right middle;padding:5 5 5 5;line:0 solid #808080ff ;background:EXPR(BG_YN==&quot;Y&quot;?&quot;red&quot;:&quot;white&quot;);background2:EXPR(BG_YN==&quot;Y&quot;?&quot;red&quot;:&quot;white&quot;);selectbackground:EXPR(BG_YN==&quot;Y&quot;?&quot;red&quot;:&quot;ghostwhite&quot;);\" text=\"bind:M_REAL_QTY\" mask=\"#,##0.#0\" editlimit=\"-1\" editdisplay=\"display\"/><Cell row=\"1\" col=\"4\" displaytype=\"normal\" edittype=\"none\" style=\"padding:5 10 5 5;line:0 solid #808080ff ;background:EXPR(BG_YN==&quot;Y&quot;?&quot;red&quot;:&quot;white&quot;);background2:EXPR(BG_YN==&quot;Y&quot;?&quot;red&quot;:&quot;white&quot;);selectbackground:EXPR(BG_YN==&quot;Y&quot;?&quot;red&quot;:&quot;ghostwhite&quot;);\" text=\"expr:VALUE_DATE == undefined?&quot;유통기한&quot;:VALUE_DATE\" mask=\"expr:VALUE_DATE == undefined?&quot;&quot;:&quot;####-##-##&quot;\" maskchar=\" \" editdisplay=\"display\"/><Cell row=\"2\"/><Cell row=\"2\" col=\"1\"/><Cell row=\"2\" col=\"2\"/><Cell row=\"2\" col=\"3\"/><Cell row=\"2\" col=\"4\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static32", "absolute", "0", "2", null, "59", "0", null, this);
            obj.set_taborder("23");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static42", "absolute", "0", "2", "135", "59", null, null, this);
            obj.set_taborder("24");
            obj.set_text("사업장");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_upjang", "absolute", "139", "8", null, "47", "10", null, this);
            obj.set_taborder("25");
            this.addChild(obj.name, obj);

            obj = new Button("btn_upjang", "absolute", null, "8", "47", "47", "10", null, this);
            obj.set_taborder("26");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);

            obj = new Combo("cbo_storage", "absolute", "10", "65", null, "47", "307", null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("27");
            obj.set_displaynulltext("창고명 선택");
            obj.set_innerdataset("ds_storageCd");
            obj.set_codecolumn("cd");
            obj.set_datacolumn("cdNm");
            obj.set_index("-1");

            obj = new Static("sta_dtFrom", "absolute", "239", "65", "186", "47", null, null, this);
            obj.set_taborder("28");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "0", "117", null, "59", "0", null, this);
            obj.set_taborder("30");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "4", "122", "355", "23", null, null, this);
            obj.set_taborder("31");
            obj.set_text(" ※ 재고등록시 유통기한 확인 후 수정하여 관리하세요");
            obj.style.set_color("red");
            obj.style.set_font("bold antialias 10 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new Button("btn_tmpSave", "absolute", null, "123", "117", "47", "81", null, this);
            obj.set_taborder("32");
            obj.set_text("임시저장");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Button("btn_save", "absolute", null, "123", "65", "47", "10", null, this);
            obj.set_taborder("33");
            obj.set_text("반영");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "4", "149", "331", "23", null, null, this);
            obj.set_taborder("34");
            obj.set_text(" ※ 빨간색 표시는 유통기한 임박제품(D-7)");
            obj.style.set_color("red");
            obj.style.set_font("bold antialias 10 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new Button("btn_moreView", "absolute", "128", null, null, "42", "136", "0", this);
            obj.set_taborder("35");
            obj.set_visible("false");
            obj.style.set_background("darkgray");
            obj.style.set_color("white");
            obj.style.set_opacity("90");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("재고등록");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("InventoryRegt.xfdl", "lib::lib_Com.xjs");
        this.registerScript("InventoryRegt.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		재고등록
        // [부시스템명]	재고등록 - 조회
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
        this.v_PreStock = undefined;
        this.v_SubulClose = undefined;
        this.v_StockClose = undefined;
        this.v_NoStockConfirm = undefined; 
        this.v_StockConfirm = undefined; 
        this.v_NoSubulClose = undefined; 
        this.v_ChkDate = undefined;
        this.v_Claim = undefined;
        this.v_PO_PHYSICUPD_PRO = undefined; 
        this.v_PO_PHYSICAPT_PRO = undefined;
        this.preDate = undefined;
        this.fv_totalpageRow;	// 전체건수
        this.upjang = undefined;
        this.subinvCd = undefined;
        this.vRtn = 0;
        var t_timeout;
        var strDataGroup = "U_svc";

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
        	
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정(임시저장)
        	this.fn_SetBtnControl("","this.btn_tmpSave");	
        	
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정(반영)
        	this.fn_SetBtnControl("","this.btn_save");
        	
        	// 권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetAuth("this.edt_upjang", "this.btn_upjang");
        	
        	application.goMenu = this;	
        	
        	//날짜 세팅
        	this.preDate = this.gfn_Today();
        	
        	this.cal_dtFrom.set_value(this.preDate);
        	
        	//업장 세팅
        	this.edt_upjang.set_value(application.g_UpjangNm);	
        	this.upjang = application.g_Upjang;	
        		
        	this.fn_PoCommon();	
        	
        	//창고 콤보 데이터 호출
        	this.subInventorySearch();
        }

        this.fn_initDataset = function ()
        {
        	this.ds_grd.clearData();
        	this.ds_po.clearData();
        	this.btn_moreView.set_visible(false);
        }

        /*==========================================================================
         * 사업장 검색 팝업 호출
        *========================================================================*/
        this.btn_upjang_onclick = function(obj,e)
        {
        	var arg = new Array();
        	if(this.fn_masterRole())
        	{
        		arg[4] = application.g_RoleSetId1;
        		arg[9] = "exception";
        		arg[10] = "AND A.MU_CD IN ('2002','2003')";
        		arg[11] = application.g_UpjangFlag1;
        		arg[12] = application.g_UpjangFlag2;
        	}
        	else
        	{
        		arg[4] = application.g_RoleSetId2;
        		arg[5] = application.g_AuthLevel;
        		arg[6] = application.g_EmpNo;
        		if(application.g_useTmCd == "Y")
        		{
        			arg[7] = application.g_Tm_Cd;
        		}
        		arg[8] = application.g_Mu_Cd;
        		arg[9] = application.g_UpjangGubun;
        		arg[11] = application.g_UpjangFlag1;
        		arg[12] = application.g_UpjangFlag2;
        	}	
        	
        	application.goMain.gfn_POP_create("upjangNm", "M_MLM::WorkplaceSearchPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        //창고 콤보 팝업창 호출
        this.cbo_storage_ondropdown = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_storageCd;
        	arg[1] = "조회조건(창고)";
        	arg[2] = "";
        	arg[3] = "cdNm";
        	application.goMain.gfn_POP_create("Storage", "cmmn::CmmnComboList.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        //보관방법 콤보 팝업창 호출
        this.cbo_keepMethod_ondropdown = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_keepMethodCd;
        	arg[1] = "조회조건(보관방법)";
        	arg[2] = "";
        	arg[3] = "cdNm";
        	application.goMain.gfn_POP_create("keepMethod", "cmmn::CmmnComboList.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        // 달력 클릭 시(From)
        this.sta_dtFrom_onclick = function(obj,e)
        {
        	var objCalArg = this.cal_dtFrom.value;
        	
        	application.goMain.gfn_POP_create("PopCalFrom", "cmmn::CmmnCalendarPop.xfdl", "fn_callbackPOP", this, objCalArg, "POP", application.goMain.divBase);
        	return false;
        }

        // 그리드 유통기한 cell클릭시
        this.grd_list_oncellclick = function(obj,e)
        {
        	//alert(e.cell);
        	var nRow = e.row;
        	
        	if(e.cell == "4" || e.cell == "5")
        	{
        		var arg = new Array();
        	
        		arg[0] = this.ds_grd.getColumn(nRow, "M_REAL_QTY");
        		arg[1] = this.ds_grd.getColumn(nRow, "VALUE_DATE");
        	
        		application.goMain.gfn_POP_create("itemCount", "M_MIM::InventoryRegtPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        		return false;
        	}
        	
        }

        /*******************************************************************************
        * 기      능   :  검색
        * 설      명   :  등록
        ********************************************************************************/
        //버튼 클릭시(공통)
        this.Common_Btn_common_OnClick = function (obj,e)
        {
        	switch(obj.name)
        	{
        		case "btn_search":
        			this.fn_GetUpdate();
        			break;
        		case "btn_tmpSave":
        			//필수항목 
        			if (this.fn_saveChk()) return;	
        			
        			application.goMain.gfn_Msg("tmpSave", "임시저장", "등록된 재고를 임시 저장하시겠습니까?!\n향후 반영하지 않으면 실제 재고 등록이 처리 되지않으니 참고하시기 바랍니다.", "YN", true, this);
        			break;
        		case "btn_save":
        			//필수항목 
        			if (this.fn_saveChk()) return;	
        			
        			application.goMain.gfn_Msg("save", "반영", "등록자료를 반영하시겠습니까?!", "YN", true, this);
        			break;
        		default:
        			break;
        	}
        }

        this.fn_GetUpdate = function ()
        {
        	if(this.gfn_dsIsUpdated(this.ds_grd)==true)
        	{	
        		application.goMain.gfn_Msg("confirm01", "확인", "미저장 데이터가 있습니다.\n계속하시겠습니까?", "YN", true, this);	
        	}
        	else
        	{
        		this.fn_search();
        	}
        }

        this.fn_search = function ()
        {
        	var phsc_flag ="Y";
        	
        	this.ds_grd.clearData();
        	this.ds_po.clearData();
        	this.btn_moreView.set_visible(false);
        	
        	//필수항목 
        	if (this.fn_searchChk()) return;
        	
        	this.subinvCd = this.ds_storageCd.getColumn(this.vRtn, "cd");
        	
        	this.v_StockClose = "";
        	this.v_NoStockConfirm = "";
        	this.v_PreStock = "";
        	this.v_SubulClose = "";
        	this.v_StockConfirm = "";
        	this.v_NoSubulClose = "";	
        	this.v_ChkDate = "";
        	this.v_Claim = "";
        	
        	var strSvcID,strURL,strInDatasets,strOutDatasets,strArgument,strCallbackFunc;
        	
        	// 경로 설정
        	strSvcID = "FSP00230E_S002";
        	strURL   = application.services[strDataGroup].url + "fs/fsp/FSP00230E_S002.jsp";
        	
        	// 데이터셋 설정
        	strInDatasets = "dsPoLineStatus=gds_dsPoLineStatus";
        	strOutDatasets = "ds_grd=ds_stock ds_po=ds_po";
        	
        	// 파라메터 설정
        	strArgument  = "v_SubinvCode=" + nexacro.wrapQuote(this.subinvCd);
        	if( phsc_flag == "Y" )
        	{
        		strArgument += " v_Date=" + nexacro.wrapQuote(this.cal_dtFrom.value);
        	}
        	else
        	{
        		strArgument += " v_Date=" + nexacro.wrapQuote(this.gfn_subStr(this.cal_dtFrom.value,0,6));
        	}
        	strArgument += " v_PhysicalFlag=" + nexacro.wrapQuote(phsc_flag);
        	strArgument += " v_chkPoUom=" + "Y";
        	strArgument += " v_chkPhysicQty=" + "N";
        	strArgument += " v_chkAmt=" + "N";	
        	strArgument += " v_Upjang=" + nexacro.wrapQuote(this.upjang);
        	
        	// 콜백함수 지정
        	strCallbackFunc = "fn_CallbackSearch";

        	this.jsp_transaction(this,strSvcID,strURL,strInDatasets,strOutDatasets,strArgument,strCallbackFunc,false,false,false);
        }

        /*******************************************************************************
        * 기      능   :  저장
        * 설      명   :  등록
        ********************************************************************************/
        this.fn_save = function(sType)
        {
        	//trace(this.ds_grd.saveXML("this.ds_grd >>>>>>", "V"));	
        	
        	// v_ds_check 미사용시 변경사항 체크
        // 	if (this.gfn_getUpdate(this.ds_grd) == false) 
        // 	{
        // 		application.goMain.gfn_Msg("ALERT_0", "알림", "변경된 데이터가 없습니다.", "OK", true, this);
        // 		return;
        // 	}	
        	
        	this.v_PO_PHYSICUPD_PRO = "";
        	this.v_ChkDate = "";
        	
        	var strSvcID,strURL,strInDatasets,strOutDatasets,strArgument,strCallbackFunc;
        	
        	// 경로 설정
        	strSvcID = "FSP00230E_T003";
        	strURL   = application.services[strDataGroup].url + "fs/fsp/FSP00230E_T003.jsp";
        	
        	// 데이터셋 설정
        	strInDatasets = "ds_stock=ds_grd";
        	strOutDatasets = "";
        	
        	// 파라메터 설정
        	strArgument  = "v_SubinvCode=" + nexacro.wrapQuote(this.subinvCd);
        	strArgument += " v_Date=" + nexacro.wrapQuote(this.cal_dtFrom.value);
        	strArgument += " v_PhysicalFlag=" + "Y";
        	strArgument += " v_chkPoUom=" + "Y";
        	//임시저장
        	if(sType == "01")
        	{
        		strArgument += " v_status='N'";
        		strArgument += " v_trType='T'";
        	}
        	//반영
        	else
        	{
        		strArgument += " v_status=''";
        		strArgument += " v_trType='I'";
        	}	

        	// 콜백함수 지정
        	strCallbackFunc = "fn_CallbackSave";

        	//Timeout 설정처리###########################################
        	
        	//Timeout 설정처리###########################################
        	
        	this.jsp_transaction(this,strSvcID,strURL,strInDatasets,strOutDatasets,strArgument,strCallbackFunc,false,false,false);	
        				
        }

        /*******************************************************************************
        * 기      능   :  검색필수체크
        * 설      명   :  검색필수체크
        ********************************************************************************/
        this.fn_searchChk = function ()
        {
        	if(this.gfn_isNull(this.cbo_storage.value))
        	{
        		application.goMain.gfn_Msg("OK", "알림", "창고를 선택하세요.", "OK", "OK");
        		return true;
        	}	
        	
        	if(this.gfn_isNull(this.gfn_subStr(this.cal_dtFrom.value,0,6)))
        	{
        		application.goMain.gfn_Msg("OK", "알림", "조사일을 선택하세요", "OK", "OK");
        		return true;
        	}		
        	
        	if( this.gfn_subStr(this.cal_dtFrom.value,0,6) < "200807" )
        	{
        		application.goMain.gfn_Msg("OK", "알림", "2008년7월1일 이전 데이터는 IFIS에서 재고작업할 수 없습니다.", "OK", "OK");
        		return true;
        	}
        	
        	return false;
        }

        /*******************************************************************************
        * 기      능   :  저장필수체크
        * 설      명   :  저장필수체크
        ********************************************************************************/
        this.fn_saveChk = function ()
        {
        	if(this.gfn_isNull(this.cbo_storage.value))
        	{
        		application.goMain.gfn_Msg("OK", "알림", "창고를 선택하세요.", "OK", "OK");
        		return true;
        	}
        	
        	if(this.gfn_isNull(this.gfn_subStr(this.cal_dtFrom.value,0,6)))
        	{
        		application.goMain.gfn_Msg("OK", "알림", "조사일을 선택하세요", "OK", "OK");
        		return true;
        	}	

        	if(this.ds_grd.getCountNF() <= 0)
        	{
        		application.goMain.gfn_Msg("OK", "알림", "저장할 자료가 없습니다!", "OK", "OK");
        		return true;				
        	}	
        	
        	if(this.gfn_subStr(this.cbo_storage.value,0,1)== "A")
        	{
        		var nIdx3 = this.ds_grd.findRowExpr("M_STK_QTY<0&&M_REAL_QTY>0");
        		if(nIdx3 >= 0)
        		{
        			application.goMain.gfn_Msg("OK", "알림", "재고량이 '-'일 경우 실사량은 '0'만 가능합니다.", "OK", "OK");
        			this.ds_grd.set_rowposition(nIdx3);
        			return true;				
        		}			
        	}
        	else
        	{
        		var nIdx1 = this.ds_grd.findRowExpr("M_USE_QTY<0");
        		var nIdx2 = this.ds_grd.findRowExpr("M_REAL_QTY>M_STK_QTY");
        	
        		if(nIdx1 >= 0 || nIdx2 >= 0)
        		{
        			application.goMain.gfn_Msg("OK", "알림", "실사량은 재고량보다 클 수 없습니다.", "OK", "OK");
        			this.ds_grd.set_rowposition(nIdx2);
        			return true;				
        		}
        	}
        	
        	return false;
        }

        /*******************************************************************************
        * 기      능   :  사업장 창고 호출
        * 설      명   :  사업장 창고 호출
        ********************************************************************************/
        this.subInventorySearch = function()
        {
        	var strSvcID   		 = "subInventory";
        	var strUrl     		 = "/ms/mom/subInventory/selectStockSubinList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "ds_storageCd=ds_list";
        	var strArguments	 = "upjang=" + nexacro.wrapQuote(this.upjang);
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
          	// connect the server 	
        	
        }

        /*----------------------------------------------------------------------------------------------
         * 설명      : 데이터셋 변경시 체크
         *---------------------------------------------------------------------------------------------*/
        this.ds_grd_oncolumnchanged = function(obj,e)
        {
        	var strMsg;
        	
        	if(e.columnid != "M_REAL_QTY") return;
        	
        	// (-)등록 여부 점검
        	if(nexacro.toNumber(this.ds_grd.getColumn(e.row,"M_REAL_QTY")) < 0 )
        	{
        		strMsg = " ※ (-) 재고등록 불가!!\n";
        		application.goMain.gfn_Msg("OK", "알림", strMsg, "OK", "OK");
        		this.ds_grd.setColumn(e.row,"M_REAL_QTY",e.oldvalue);
        		return;
        	}	
        	
        	if(nexacro.toNumber(this.ds_grd.getColumn(e.row, "M_REAL_QTY")) > nexacro.toNumber(this.ds_grd.getColumn(e.row, "M_STK_QTY")) )
        	{
        		strMsg = " ※ 실사량은 재고량 보다 클 수 없습니다.!!";
        		application.goMain.gfn_Msg("OK", "알림", strMsg, "OK", "OK");
        		this.ds_grd.setColumn(e.row, "M_REAL_QTY", e.oldvalue);
        		this.ds_grd.setColumn(e.row, "M_REAL_QTY_SUM", e.oldvalue);
        		return;
        	}

        	var StkQty  = nexacro.toNumber(this.ds_grd.getColumn(e.row, "M_STK_QTY"));
        	var RealQty = nexacro.toNumber(this.ds_grd.getColumn(e.row, "M_REAL_QTY"));
        	var UseQty  = StkQty - RealQty;
        	
        	this.ds_grd.setColumn(e.row, "M_REAL_QTY_SUM", e.newvalue);
        	this.ds_grd.setColumn(e.row, "M_USE_QTY",UseQty);
        	
        	// 실사량이 0 인경우 현 재고량은 곧 사용량이 된다.
        	if(RealQty == 0)
        	{
        		this.ds_grd.setColumn(e.row,"M_REAL_AMT",0);                                        // 실사금액(출하)
        		this.ds_grd.setColumn(e.row,"U_REAL_AMT",0);										// 실사금액(매입)
        		this.ds_grd.setColumn(e.row,"M_USE_AMT",this.ds_grd.getColumn(e.row,"M_STK_AMT"));  // 사용금액(출하)
        		this.ds_grd.setColumn(e.row,"U_USE_AMT",this.ds_grd.getColumn(e.row,"U_STK_AMT"));  // 사용금액(매입)
        	}
        	else
        	{
        		var mUseAmt = Math.round(UseQty * nexacro.toNumber(this.ds_grd.getColumn(e.row,"M_STK_PRICE")));
        		var uUseAmt = Math.round(UseQty * nexacro.toNumber(this.ds_grd.getColumn(e.row,"U_STK_PRICE")));
        		var mRealAmt = nexacro.toNumber(this.ds_grd.getColumn(e.row,"M_STK_AMT")) - mUseAmt;
        		var uRealAmt = nexacro.toNumber(this.ds_grd.getColumn(e.row,"U_STK_AMT")) - uUseAmt;
        		
        		
        		this.ds_grd.setColumn(e.row,"M_USE_AMT", mUseAmt);
        		this.ds_grd.setColumn(e.row,"U_USE_AMT", uUseAmt);
        		this.ds_grd.setColumn(e.row,"M_REAL_AMT", mRealAmt);
        		this.ds_grd.setColumn(e.row,"U_REAL_AMT", uRealAmt);
        	}
        	
        	if( e.columnid == "VALUE_DATE" )
        	{
        		if( !this.gfn_isNull(e.newvalue) )
        		{
        			var strDate = this.cal_dtFrom.value;
        			var strToDate = this.gfn_AddDate(strDate, "7");	// 현재일자 + 7

        			if( e.newvalue <= strToDate )
        				this.ds_grd.setColumn(e.row, "BG_YN", "Y");
        			else
        				this.ds_grd.setColumn(e.row, "BG_YN", "N");
        		}
        		else
        		{
        			this.ds_grd.setColumn(e.row, "BG_YN", "N");
        		}
        	}
        }

        /*================================================================================
         * 5. UserFunction관련 Script
         *===============================================================================*/
        /*----------------------------------------------------------------------------------------------
         * 설명      : JSP트랜잭션 콜백 함수 (필수)
         *---------------------------------------------------------------------------------------------*/
        this.fn_CallbackSearch = function (errCode,errMsg)
        {
        	if(errCode!=0)
        	{
        		application.goMain.gfn_Msg("OK", "알림", "시스템오류 ! 전산 담당자에게 문의 하세요.\n" + errMsg, "OK", "OK");
        		this.ds_grd.clearData();
        		return;
        	}
        	
        	// 재고마감되어 등록할 수 없습니다.\n재고마감관리자에게 연락하세요.
        	if(this.gfn_Length(this.gfn_Trim(this.v_StockClose))!= 0)
        	{
        		application.goMain.gfn_Msg("OK", "알림", this.v_StockClose, "OK", "OK");
        		this.ds_grd.clearData();
        		return;		
        	}	
        	
        	// 현창고는 수불마감(" + rs.getString("CLS_YYYYMM") + ")이 \n완료되어 본작업이 불가합니다!
        	if(this.gfn_Length(this.gfn_Trim(this.v_SubulClose))!= 0)
        	{
        		application.goMain.gfn_Msg("OK", "알림", this.v_SubulClose, "OK", "OK");
        		this.ds_grd.clearData();
        		return;		
        	}
        	
        	/*if(this.gfn_Length(this.gfn_Trim(this.v_NoStockConfirm))!= 0)
        	{
        		application.goMain.gfn_Msg("OK", "알림", this.v_NoStockConfirm, "OK", "OK");
        		this.ds_grd.clearData();
        		return;		
        	}
        	*/
        	
        	// 현창고는 재고조사(" + rs.getString("PHYSIC_DATE") + ")가\n 반영되어 본작업이 불가합니다!
        	if(this.gfn_Length(this.gfn_Trim(this.v_StockConfirm))!= 0)
        	{
        		application.goMain.gfn_Msg("OK", "알림", this.v_StockConfirm, "OK", "OK");
        		this.ds_grd.clearData();
        		return;		
        	}
        	
        	// 재고 조사일은 현재일보다 작거나 같아야 합니다.
        	if(this.gfn_Length(this.gfn_Trim(this.v_ChkDate))!= 0)
        	{
        		application.goMain.gfn_Msg("OK", "알림", this.v_ChkDate, "OK", "OK");
        		this.ds_grd.clearData();
        		return;		
        	}	
        	
        	/*
        	if(this.gfn_Length(this.gfn_Trim(this.v_NoSubulClose))!= 0)
        	{
        		application.goMain.gfn_Msg("OK", "알림", this.v_NoSubulClose, "OK", "OK");
        		this.ds_grd.clearData();
        		return;		
        	}
        	*/
        	
        	// 클레임 처리 중인 건이 존재합니다.\n처리 후 재고조사를 하시기 바랍니다	
        	if(this.gfn_Length(this.gfn_Trim(this.v_Claim))!= 0)
        	{
        		application.goMain.gfn_Msg("OK", "알림", this.v_Claim, "OK", "OK");
        		this.ds_grd.clearData();
        		return;		
        	}	
        	
        	//미입고내역이 있을 경우 팝업창을 띄워준다.
        	if(this.ds_po.getCountNF() > 0)
        	{
        		var v_msg, v_ret
        		
        		v_msg = "전일 발주자료에 대한 입고완료가 이루어지지\n않아 재고조사 등록이 불가합니다! ";
        		v_msg += "\n\n미입고내역을 확인하시겠습니까?";
        		
        		application.goMain.gfn_Msg("confirm", "확인", v_msg, "YN", true, this);
        		this.ds_grd.clearData();
        		
        		return;
        	}		
        	
        	if(this.ds_grd.rowcount == 0)
        	{
        		application.goMain.gfn_Msg("OK", "알림", "재고내역이 존재하지 않습니다!", "OK", "OK");
        		return;				
        	}
        	
        	// 월마감 체크
        	var dateFr = this.cal_dtFrom.value;
        			
        	this.fn_common_code("MA0044", this.gfn_subStr(dateFr,0,6),"","","AND CODE_NAME = 'Y' AND USE_YN = 'Y'");
        	
        	if(application.gds_common_code.rowcount > 0){
        		application.goMain.gfn_Msg("ALERT_0", "알림", this.gfn_subStr(dateFr,0,4) + "년 " + this.gfn_subStr(dateFr,4,2) + "월 마감이 완료되어 본작업이 불가합니다!", "OK", true, this);
        		this.ds_grd.clearData();
        		return;
        	}
        	
        	if(this.gfn_Length(this.gfn_Trim(this.v_PreStock))!= 0)
        	{
        		application.goMain.gfn_Msg("OK", "알림", this.v_PreStock, "OK", "OK");
        		//return;		
        	}		

        	//실사량 != 재고량일 경우 기존 재고조사 내역이 있을 경우 기존 재고조사 내역을 계산한다. 
        	this.ds_grd.updatecontrol = false;
        		
        	for(var i = 0; i < this.ds_grd.getCountNF(); i++)
        	{
        		if( this.fn_clearNaN(nexacro.toNumber(this.ds_grd.getColumn(i,"ADV_PHYSIC_QTY"))) != 0)
        		{
        			this.ds_grd.setColumn(i,"M_REAL_QTY",this.ds_grd.getColumn(i,"ADV_PHYSIC_QTY"));
        			this.ds_grd.setColumn(i,"M_REAL_QTY_SUM",this.ds_grd.getColumn(i,"ADV_PHYSIC_QTY"));
        		}
        		else
        		{
        			this.ds_grd.setColumn(i,"M_REAL_QTY", 0);
        			this.ds_grd.setColumn(i,"M_REAL_QTY_SUM", this.ds_grd.getColumn(i,"ADV_PHYSIC_QTY"));
        		}		
        	}	
        	
        	// 총건수 표시
        	this.btn_moreView.set_visible(true);
        	this.btn_moreView.set_text("총건수:" +this.ds_grd.rowcount);	
        	
        }

        /*----------------------------------------------------------------------------------------------
         * 설명      : JSP트랜잭션 콜백 함수 (필수)
         *---------------------------------------------------------------------------------------------*/
        this.fn_CallbackSave = function (errCode,errMsg)
        {
        	//Timeout 설정처리###########################################
        	
        	//Timeout 설정처리###########################################

        	if(errCode!=0)
        	{
        		application.goMain.gfn_Msg("OK", "알림", "시스템오류 ! 전산 담당자에게 문의 하세요.\n" + errMsg, "OK", "OK");
        		return;
        	}
        	else
        	{
        		// 현창고는 재고 조사가 반영되어 본작업이 불가합니다!
        		if( this.gfn_Length(this.gfn_Trim(this.v_StockConfirm)) != 0 )
        		{
        			application.goMain.gfn_Msg("OK", "알림", this.v_StockConfirm, "OK", "OK");
        			return;
        		}
        		
        		// 현창고는 수불마감(" + nullToBlank(rs.getString("CLS_YYYYMM")) + ")이 \n완료되어 본작업이 불가합니다!
        		if( this.gfn_Length(this.gfn_Trim(this.v_SubulClose)) != 0 )
        		{
        			application.goMain.gfn_Msg("OK", "알림", this.v_SubulClose, "OK", "OK");
        			return;
        		}
        		
        		// 구매 SP 호출 후 리턴 메세지 처리
        		if(this.gfn_Length(this.gfn_Trim(this.v_PO_PHYSICUPD_PRO))!= 0)
        		{
        			application.goMain.gfn_Msg("OK", "알림", this.v_PO_PHYSICUPD_PRO, "OK", "OK");
        			return;		
        		}			
        		else
        		{
        			application.goMain.gfn_Msg("OK", "알림", "정상적으로 저장되었습니다.", "OK", "OK");
        			this.ds_grd.clearData();
        			this.ds_po.clearData();				
        		}
        	}
        }

        /*----------------------------------------------------------------------------------------------
         * 설명      : 유통기한기준 -7 ~ +7까지 Red로 라인표시
         *---------------------------------------------------------------------------------------------*/
        this.fn_setBgColor = function (sDate)
        {
        	var strToday	= this.preDate;			       	    // 현재일자
        	var strFromDate	= this.gfn_AddDate(strToday, "-7");	// 현재일자 - 7
        	var strToDate	= this.gfn_AddDate(strToday, "7");	// 현재일자 + 7

        	if( sDate != "" )
        	{
        		if( strFromDate <= sDate && sDate <= strToDate )
        			return 'orangered';
        		else
        			return 'white';
        	}
        }

        /*----------------------------------------------------------------------------------------------
         * 설명      : 유통기한기준 -7 ~ +7까지 Red로 라인표시(실사량, 유통기한, 비고는 따로 설정한다.)
         *---------------------------------------------------------------------------------------------*/
        this.fn_setBgColor2 = function (sDate)
        {
        	var strToday	= this.preDate;			       	    // 현재일자
        	var strFromDate	= this.gfn_AddDate(strToday, "-7");	// 현재일자 - 7
        	var strToDate	= this.gfn_AddDate(strToday, "7");	// 현재일자 + 7

        	if( sDate != "" )
        	{
        		if( strFromDate <= sDate && sDate <= strToDate )
        			return 'orangered';
        		else
        			return 'cornsilk';
        	}
        }
         
        /*----------------------------------------------------------------------------------------------
         * 설명      : 창고 트랜잭션 콜백 함수 (필수)
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
        			
        			//초기화
        			this.fn_initDataset();
        			//창고 콤보 데이터 호출
        			this.subInventorySearch();
        	
        			break;
        		case "Storage":
        			this.cbo_storage.set_index(rtn);
        			this.vRtn = rtn;
        			
        			//초기화
        			this.fn_initDataset();
        			break;		
        		case "keepMethod":
        			this.cbo_keepMethod.set_index(rtn);
        			break;
        		case "itemCount":
        		    this.ds_grd.setColumn(this.ds_grd.rowposition, "M_REAL_QTY", rtn[0]);
        		    this.ds_grd.setColumn(this.ds_grd.rowposition, "VALUE_DATE", rtn[1]);
        		    break;				
        		case "PopCalFrom":
        			this.cal_dtFrom.set_value(rtn);
        			
        			//초기화
        			this.fn_initDataset();
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
        	
        	if (id == "confirm") // 검색 후 미입고리스트가 있을경우
        	{
        		if (rtn == "Y")
        		{
        			var arg = new Array();
        			
        			application.goMain.gfn_POP_create("warehouseList", "M_MIM::InventoryNoWarehousePop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        			return false;
        		}
        		else
        		{
        			
        		}
        	}
        	
        	if (id == "confirm01") // 검색전 미저장 데이터 체크후 검색
        	{
        		if(rtn == "Y"){
        			this.fn_search();
        		}else if(rtn == "N"){
        			
        		}
        	}	
        		
        	// 임시저장일경우
        	else if (id == "tmpSave")
        	{
        		if (rtn == "Y") 
        		{
        			this.fn_save("01");
        		}
        		else
        		{
        			return;
        		}
        	}	
        	// 반영일경우
        	else if (id == "save")
        	{
        		if (rtn == "Y") 
        		{
        			this.fn_save("02");
        		}
        		else
        		{
        			return;
        		}
        	}	
        }

        this.grd_list_onslide = function(obj,e)
        {
        	
        	if (e.yaccvalue > 0)
        	{
        		this.parent.parent.divBottom.set_visible(true);
        		this.parent.parent.divMain.set_height(833);
        		this.parent.parent.divBottom.bringToFront();
        		this.btn_moreView.set_visible(false);
        	}
        	else if (e.yaccvalue < 0)
        	{	
        		if (this.ds_grd.getRowCount() > 0)
        		{
        			this.parent.parent.divBottom.set_visible(false);
        			this.parent.parent.divMain.set_height(923);
        			this.btn_moreView.set_visible(true);
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
        		this.parent.btnGoTopDiv.set_left(460);
        		this.parent.btnGoTopDiv.set_right(25);
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
            this.ds_grd.addEventHandler("oncolumnchanged", this.ds_grd_oncolumnchanged, this);
            this.addEventHandler("onload", this.form_onload, this);
            this.cal_dtFrom.addEventHandler("ontouchstart", this.div_additionOrder_cal_dtTo_ontouchstart, this);
            this.cbo_keepMethod.addEventHandler("ondropdown", this.cbo_keepMethod_ondropdown, this);
            this.btn_search.addEventHandler("onclick", this.Common_Btn_common_OnClick, this);
            this.grd_list.addEventHandler("oncellclick", this.grd_list_oncellclick, this);
            this.grd_list.addEventHandler("onvscroll", this.grd_list_onvscroll, this);
            this.grd_list.addEventHandler("onslide", this.grd_list_onslide, this);
            this.btn_upjang.addEventHandler("onclick", this.btn_upjang_onclick, this);
            this.cbo_storage.addEventHandler("ondropdown", this.cbo_storage_ondropdown, this);
            this.sta_dtFrom.addEventHandler("onclick", this.sta_dtFrom_onclick, this);
            this.btn_tmpSave.addEventHandler("onclick", this.Common_Btn_common_OnClick, this);
            this.btn_save.addEventHandler("onclick", this.Common_Btn_common_OnClick, this);

        };

        this.loadIncludeScript("InventoryRegt.xfdl", true);

       
    };
}
)();
