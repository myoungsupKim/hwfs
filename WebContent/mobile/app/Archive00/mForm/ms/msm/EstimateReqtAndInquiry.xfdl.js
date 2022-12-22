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
                this.set_name("EstimateReqtAndInquiry");
                this.set_titletext("견적서작성/조회");
                this._setFormPosition(0,0,540,760);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_center", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"centerCode\" type=\"STRING\" size=\"256\"/><Column id=\"centerName\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_search", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"schCenter\" type=\"STRING\" size=\"256\"/><Column id=\"schSabun\" type=\"STRING\" size=\"256\"/><Column id=\"schManager\" type=\"STRING\" size=\"256\"/><Column id=\"schEstiId\" type=\"STRING\" size=\"256\"/><Column id=\"schUpjang\" type=\"STRING\" size=\"256\"/><Column id=\"schUpjangNm\" type=\"STRING\" size=\"256\"/><Column id=\"schCustom\" type=\"STRING\" size=\"256\"/><Column id=\"schRemark\" type=\"STRING\" size=\"256\"/><Column id=\"schDate1\" type=\"STRING\" size=\"256\"/><Column id=\"schDate2\" type=\"STRING\" size=\"256\"/><Column id=\"schCond\" type=\"STRING\" size=\"256\"/><Column id=\"schConfirmYn\" type=\"STRING\" size=\"256\"/><Column id=\"emailAddress\" type=\"STRING\" size=\"256\"/><Column id=\"emailName\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_esti", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"estiId\" type=\"STRING\" size=\"256\"/><Column id=\"estiNm\" type=\"STRING\" size=\"256\"/><Column id=\"custom\" type=\"STRING\" size=\"256\"/><Column id=\"remark\" type=\"STRING\" size=\"256\"/><Column id=\"confirmYn\" type=\"STRING\" size=\"256\"/><Column id=\"estiStart\" type=\"STRING\" size=\"256\"/><Column id=\"estiEnd\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_list", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"custCd\" type=\"STRING\" size=\"256\"/><Column id=\"custNm\" type=\"STRING\" size=\"256\"/><Column id=\"classCode\" type=\"STRING\" size=\"256\"/><Column id=\"className\" type=\"STRING\" size=\"256\"/><Column id=\"itemCode\" type=\"STRING\" size=\"256\"/><Column id=\"itemName\" type=\"STRING\" size=\"256\"/><Column id=\"itemSize\" type=\"STRING\" size=\"256\"/><Column id=\"itemUnit\" type=\"STRING\" size=\"256\"/><Column id=\"estiQty\" type=\"STRING\" size=\"256\"/><Column id=\"unitPrice\" type=\"STRING\" size=\"256\"/><Column id=\"unitAmt\" type=\"STRING\" size=\"256\"/><Column id=\"estiPrice\" type=\"STRING\" size=\"256\"/><Column id=\"estiAmt\" type=\"STRING\" size=\"256\"/><Column id=\"marginRate\" type=\"STRING\" size=\"256\"/><Column id=\"dDays\" type=\"STRING\" size=\"256\"/><Column id=\"confirmYn\" type=\"STRING\" size=\"256\"/><Column id=\"itemClass2\" type=\"STRING\" size=\"256\"/><Column id=\"simuYn\" type=\"STRING\" size=\"256\"/><Column id=\"simuGubun\" type=\"STRING\" size=\"256\"/><Column id=\"avgQty\" type=\"STRING\" size=\"256\"/><Column id=\"simQty\" type=\"STRING\" size=\"256\"/><Column id=\"estiId\" type=\"STRING\" size=\"256\"/><Column id=\"custom\" type=\"STRING\" size=\"256\"/><Column id=\"manager\" type=\"STRING\" size=\"256\"/><Column id=\"managerNm\" type=\"STRING\" size=\"256\"/><Column id=\"remark\" type=\"STRING\" size=\"256\"/><Column id=\"estiStart\" type=\"STRING\" size=\"256\"/><Column id=\"estiEnd\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
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

            obj = new Static("Static05", "absolute", "530", "187", "10", "538", null, null, this);
            obj.set_taborder("21");
            obj.set_text("w10");
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

            obj = new Static("Static03", "absolute", "0", "118", null, "59", "0", null, this);
            obj.set_taborder("34");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "530", "35", "10", "538", null, null, this);
            obj.set_taborder("45");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "187", "10", "538", null, null, this);
            obj.set_taborder("46");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Combo("cbo_center", "absolute", "11", "8", "269", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("47");
            obj.set_displaynulltext("센터선택");
            obj.set_innerdataset("@ds_center");
            obj.set_codecolumn("centerCode");
            obj.set_datacolumn("centerName");
            obj.set_index("-1");

            obj = new Button("btn_sendEmail", "absolute", "10", "124", "117", "47", null, null, this);
            obj.set_taborder("53");
            obj.set_text("메일발송");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", null, "125", "229", "47", "-7", null, this);
            obj.set_taborder("54");
            obj.set_text("[단위:원, VAT별도]");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "0", "177", "540", "10", null, null, this);
            obj.set_taborder("55");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list", "absolute", "10", "187", "520", null, null, "0", this);
            obj.set_taborder("56");
            obj.set_binddataset("ds_list");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_autosizingtype("row");
            obj.set_extendsizetype("row");
            obj.set_nodataimage("URL('theme://Image/grd_WF_NoDataImg.png')");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"69\"/><Column size=\"146\"/><Column size=\"121\"/><Column size=\"183\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"GrayLabel\"/><Cell col=\"1\" text=\"WhiteLabel\"/><Cell col=\"2\" text=\"WhiteLabel\"/><Cell col=\"3\"/></Band><Band id=\"body\"><Cell celltype=\"none\" displaytype=\"normal\" edittype=\"none\" style=\"align:right middle;padding:0 5 0 10;background:#74748aff;background2:#74748aff;color:#ffffffff;color2:#ffffffff;selectbackground:#74748aff;selectcolor:#ffffffff;\" cssclass=\"CellGrd_WF_LabelIndigo\" expr=\"currow + 1\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell col=\"1\" colspan=\"3\" celltype=\"none\" displaytype=\"normal\" edittype=\"none\" style=\"align:left middle;padding:0 5 0 10;background:#74748aff;background2:#74748aff;color:#ffffffff;color2:#ffffffff;selectbackground:#74748aff;selectcolor:#ffffffff;\" cssclass=\"CellGrd_WF_LabelIndigo\" text=\"bind:itemName\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"1\" celltype=\"none\" style=\"align:left middle;background:linen;background2:linen;selectbackground:linen;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"구분\" autosizerow=\"limitmin\"/><Cell row=\"1\" col=\"1\" displaytype=\"number\" edittype=\"none\" style=\"align:right middle;padding:0 5 0 5;background:#ffffffff;background2:#ffffffff;selectbackground:#ffffffff;\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:className\" autosizerow=\"limitmin\"/><Cell row=\"1\" col=\"2\" displaytype=\"number\" edittype=\"none\" style=\"align:left middle;background:linen;background2:linen;selectbackground:linen;\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"상품코드\" autosizerow=\"limitmin\"/><Cell row=\"1\" col=\"3\" style=\"align:right;padding:0 5 0 5;background:#ffffffff;background2:#ffffffff;selectbackground:#ffffffff;\" text=\"bind:itemCode\" autosizerow=\"limitmin\"/><Cell row=\"2\" celltype=\"none\" style=\"align:left middle;background:linen;background2:linen;selectbackground:linen;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"규격\" autosizerow=\"limitmin\"/><Cell row=\"2\" col=\"1\" colspan=\"3\" displaytype=\"number\" edittype=\"none\" style=\"align:left middle;padding:0 5 0 5;background:#ffffffff;background2:#ffffffff;selectbackground:#ffffffff;\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:itemSize\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"3\" style=\"align:left middle;background:linen;background2:linen;selectbackground:linen;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"단위\" autosizerow=\"limitmin\"/><Cell row=\"3\" col=\"1\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 5;background:#ffffffff;background2:#ffffffff;selectbackground:#ffffffff;\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:itemUnit\" autosizerow=\"limitmin\"/><Cell row=\"3\" col=\"2\" displaytype=\"number\" style=\"align:left middle;background:linen;background2:linen;selectbackground:linen;\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"견적가\" autosizerow=\"limitmin\"/><Cell row=\"3\" col=\"3\" displaytype=\"number\" style=\"align:right;padding:0 5 0 5;background:#ffffffff;background2:#ffffffff;color:red;color2:red;selectbackground:#ffffffff;selectcolor:red;\" text=\"bind:estiAmt\" mask=\"###,###,###.##\" autosizerow=\"limitmin\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Combo("cbo_esti", "absolute", "11", "66", "414", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("58");
            obj.set_displaynulltext("견적번호");
            obj.set_innerdataset("@ds_esti");
            obj.set_codecolumn("estiId");
            obj.set_datacolumn("estiNm");
            obj.set_enable("false");
            obj.set_index("-1");

            obj = new Edit("edt_sabun", "absolute", "285", "8", null, "47", "10", null, this);
            obj.set_taborder("59");
            obj.set_displaynulltext("담당자선택");
            obj.set_autoselect("true");
            obj.set_readonly("true");
            this.addChild(obj.name, obj);

            obj = new Button("btn_sabun", "absolute", null, "8", "47", "47", "10", null, this);
            obj.set_taborder("60");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("견적서작성/조회");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information
            obj = new BindItem("item0","cbo_esti","value","ds_search","schEstiId");
            this.addChild(obj.name, obj);
            obj.bind();
            obj = new BindItem("item1","cbo_center","value","ds_search","schCenter");
            this.addChild(obj.name, obj);
            obj.bind();

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("EstimateReqtAndInquiry.xfdl", "lib::lib_Com.xjs");
        this.registerScript("EstimateReqtAndInquiry.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		월간실적현황
        // [부시스템명]	월간실적현황 - 조회
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
        this.upjang = undefined;
        this.sabun = undefined;
        this.fv_key = "";
        this.vRtn = undefined;

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
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정(검색)
        	this.fn_SetBtnControl("this.btn_search","");
        	
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정(전체삭제)
        	this.fn_SetBtnControl("","this.btn_sendEmail");
        	
        	// 권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetAuth("this.edt_sabun", "this.btn_sabun");
        	
        	//센터콤보 데이터 호출
        	this.searchCenter();
        	
        	//조회조건을 초기화한다.
        	var nRow = this.ds_search.addRow();
        	this.ds_search.setColumn(nRow, "schCenter", "");	//센터
        	
        	//담당자 세팅
        	this.edt_sabun.set_value(application.g_Name);
        	this.ds_search.setColumn(0, "schManager", application.g_EmpNo) //담당자 사번
        	
        	//담당자에 따른 견적번호 호출
        	this.fn_estiId();	
        	
        }

        /*----------------------------------------------------------------------------------------------
         * 설명      : 센터 COMBO 초기화 
         *---------------------------------------------------------------------------------------------*/
        this.fn_center_init = function ()
        {
        	var defVal = "";
        	this.ds_center.filter("centerCode != '*'");
        	// COMBO 에 첫번째 Row에 기본값을 SET
        	if (this.ds_center.getRowCount() > 1) {
        		defVal = this.ds_center.getColumn(0, "centerCode");
        		
        	}
        	this.cbo_center.set_value(defVal);
        }

        /*----------------------------------------------------------------------------------------------
         * 설명      : 센터 COMBO 초기화 
         *---------------------------------------------------------------------------------------------*/
        this.fn_esti_init = function ()
        {
        	var defVal = "";
        	if (this.ds_esti.getRowCount() > 0) {
        		// 저장이후 재조회 여부
        		if (this.fv_key=="") {
        			this.ds_esti.filter("estiId != 'NEW'");
        			defVal = this.ds_esti.getColumn(0, "estiId");
        		} else {
        			defVal = this.fv_key;
        		}
        		this.cbo_esti.set_enable(true);
        	}else{
        		this.cbo_esti.set_enable(false);
        	}
        	this.cbo_esti.set_value(defVal);
        }

        /*==========================================================================
         * 센터 콤보 팝업
        *========================================================================*/
        this.cbo_center_ondropdown = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_center;
        	arg[1] = "조회조건(센터)";
        	arg[2] = "";
        	arg[3] = "centerName";
        	application.goMain.gfn_POP_create("center", "cmmn::CmmnComboList.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        
        /*==========================================================================
         * 담당자 검색 팝업 호출
        *========================================================================*/
        this.btn_sabun_onclick = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = "2004";
        	
        	application.goMain.gfn_POP_create("searchSabun", "M_MSM::FoodMaterialsSabunPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        /*==========================================================================
         * 견적서번호 콤보 팝업
        *========================================================================*/
        this.cbo_esti_ondropdown = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_esti;
        	arg[1] = "조회조건(견적서번호)";
        	arg[2] = "";
        	arg[3] = "estiNm";
        	application.goMain.gfn_POP_create("searchEsti", "cmmn::CmmnComboList.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        /*==========================================================================
         * 이익율 적용 팝업 호출 
        *========================================================================*/ 
        this.cbo_gubunRate_ondropdown = function(obj,e)
        {
        	var arg = new Array();
        	//arg[0] = this.edt_mainOffice.value;
        	
        	application.goMain.gfn_POP_create("gubunRateCheck", "M_MSM::EstimateReqtAndInquiryPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        /*==========================================================================
         * 메일발송(상세등록) 팝업 호출
        *========================================================================*/  
        this.btn_sendEmail_onclick = function(obj,e)
        {
        	if (this.ds_list.getRowCount() == 0) 
            {
        		application.goMain.gfn_Msg("ALERT_0", "Information", "견적서 조회를 먼저 하십시요", "OK");	//조회되는 내용이 없습니다.
        		return;
        	}else{
        		var arg = new Array();
        	
        		application.goMain.gfn_POP_create("sendEmail", "cmmn::CmmnEmailDetailRgstPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        		return false;
        	}
        	
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
        	//데이터 초기화
        	this.ds_list.clearData();
        	
        	//필수항목 
        	if (this.fn_searchChk()) return;
        	
        	this.ds_search.setColumn(0, "schDate1", this.ds_esti.getColumn(this.vRtn, "estiStart"));		// 견적기간_시작일
        	this.ds_search.setColumn(0, "schDate2", this.ds_esti.getColumn(this.vRtn, "estiEnd"));		// 견적기간_종료일
        	
        	//this.ds_search.setColumn(0, "schCenter", this.ds_storageCd.getColumn(this.vRtn, "cd")); //담당자 사번		    
        	
        	// 서비스 연결 됐을때 아래 로직으로..
        	var strSvcID   		 = "search";
        	var strUrl     		 = "fm/fms/estPaperWrite/selectList.xdo";
        	var strInDataset     = "ds_search=ds_search:A";
        	var strOutDataset    = "ds_list=ds_list";
        	var strArguments	 = "";
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
          	// connect the server 
        	
        }

        /*******************************************************************************
        * 기      능   :  이메일 발송
        * 설      명   :  이메일 발송
        ********************************************************************************/
        this.fn_sendEmail = function()
        {
        	
        	// 서비스 연결 됐을때 아래 로직으로..
        	var strSvcID   		 = "sendEmail";
        	var strUrl     		 = "ms/cmn/mobileCommon/sendEmail.xdo";
        	var strInDataset     = "ds_search=ds_search:A";
        	var strOutDataset    = "ds_list=ds_list";
        	var strArguments	 = "";
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
          	// connect the server 
        	
        }

        /*******************************************************************************
        * 기      능   :  센터 호출
        * 설      명   :  센터 호출
        ********************************************************************************/
        this.searchCenter = function()
        {
        	var strSvcID   		 = "searchCenter";
        	var strUrl     		 = "fm/fms/upriceContractUpjangSet/selectCenter.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "ds_center=ds_center";
        	var strArguments	 = "";
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
          	// connect the server 	
        	
        }

        /*******************************************************************************
        * 기      능   :  견적번호 조회
        * 설      명   :  견적번호 조회
        ********************************************************************************/
        this.fn_estiId = function()
        {
        	var strSvcID   		 = "searchEsti";
        	var strUrl     		 = "fm/fms/estPaperWrite/selectEsti.xdo";
        	var strInDataset     = "ds_search=ds_search:A";
        	var strOutDataset    = "ds_esti=ds_esti";
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
        	if ( this.gfn_isNull(this.cbo_center.value) )
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "센터를 선택하세요.", "OK", true, this);
        		return true;
        	}
        	
        	if ( this.gfn_isNull(this.edt_sabun.value) )
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "담당자를 입력하세요.", "OK", true, this);
        		return true;
        	}
        	
        	if ( this.gfn_isNull(this.cbo_esti.value) )
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "견적번호를 선택하세요.", "OK", true, this);
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
        		//월간실적조회
                case "search" :
        			// 조회 건수 확인  
                    if (this.ds_list.getRowCount() == 0) 
                    {
                        application.goMain.gfn_Msg("ALERT_0", "Information", "조회되는 내용이 없습니다.", "OK");	//조회되는 내용이 없습니다.
                        return;
                    }
                    else // 조회건수가 1페이지 이상일때
                    {
        				
        			}            
          			break;
          		// 센터 콜백 함수
                case "searchCenter" :			
        			this.fn_center_init();
          			break;
          		//견적번호 조회
          		case "searchEsti" :			
        			this.fn_esti_init();
          			break;
          		//이메일 발송
          		case "sendEmail" :			
        			application.goMain.gfn_Msg("ALERT_0", "Information", "메일발송하였습니다.", "OK");	//메일발송하였습니다.
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
        		case "center":
        			this.cbo_center.set_index(rtn);
        			this.vRtn = rtn;
        			break;
        		case "searchSabun":
        			this.edt_sabun.set_value(rtn[1]);
        			this.ds_search.setColumn(0, "schManager", rtn[0]) //담당자 사번
        			this.fn_estiId();
        			break;
        		case "searchEsti":
        			this.cbo_esti.set_index(rtn);
        			this.vRtn = rtn;
        			break;
        		case "sendEmail":
        			this.ds_search.setColumn(0, "emailAddress", rtn[0]) //이메일주소
        			this.ds_search.setColumn(0, "emailName", rtn[1]) //고객사명
        			this.fn_sendEmail();
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
        		if (this.ds_list.getRowCount() > 0)
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

        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.ds_search.addEventHandler("oncolumnchanged", this.ds_search_oncolumnchanged, this);
            this.ds_list.addEventHandler("oncolumnchanged", this.ds_list_oncolumnchanged, this);
            this.addEventHandler("onload", this.form_onload, this);
            this.btn_search.addEventHandler("onclick", this.btnSearch_onclick, this);
            this.cbo_center.addEventHandler("ondropdown", this.cbo_center_ondropdown, this);
            this.btn_sendEmail.addEventHandler("onclick", this.btn_sendEmail_onclick, this);
            this.grd_list.addEventHandler("onvscroll", this.grd_list_onvscroll, this);
            this.grd_list.addEventHandler("onslide", this.grd_list_onslide, this);
            this.cbo_esti.addEventHandler("ondropdown", this.cbo_esti_ondropdown, this);
            this.btn_sabun.addEventHandler("onclick", this.btn_sabun_onclick, this);

        };

        this.loadIncludeScript("EstimateReqtAndInquiry.xfdl", true);

       
    };
}
)();
