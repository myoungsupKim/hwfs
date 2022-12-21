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
                this.set_name("ClaimProcessReport");
                this.set_titletext("클레임처리현황");
                this._setFormPosition(0,0,540,760);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_grd", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"needDate\" type=\"STRING\" size=\"256\"/><Column id=\"upjang\" type=\"STRING\" size=\"256\"/><Column id=\"upjangnm\" type=\"STRING\" size=\"256\"/><Column id=\"custcd\" type=\"STRING\" size=\"256\"/><Column id=\"vdNm\" type=\"STRING\" size=\"256\"/><Column id=\"itemCode\" type=\"STRING\" size=\"256\"/><Column id=\"itemName\" type=\"STRING\" size=\"256\"/><Column id=\"itemSize\" type=\"STRING\" size=\"256\"/><Column id=\"poUom\" type=\"STRING\" size=\"256\"/><Column id=\"poQty\" type=\"STRING\" size=\"256\"/><Column id=\"reqQty\" type=\"STRING\" size=\"256\"/><Column id=\"procQty\" type=\"STRING\" size=\"256\"/><Column id=\"cdClaimKind\" type=\"STRING\" size=\"256\"/><Column id=\"reqKind\" type=\"STRING\" size=\"256\"/><Column id=\"ctKind\" type=\"STRING\" size=\"256\"/><Column id=\"partTmCd\" type=\"STRING\" size=\"256\"/><Column id=\"partTmNm\" type=\"STRING\" size=\"256\"/><Column id=\"mngSabun\" type=\"STRING\" size=\"256\"/><Column id=\"mngName\" type=\"STRING\" size=\"256\"/><Column id=\"prcsStatus\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
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

            obj = new Dataset("ds_grdSever", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"needDate\" type=\"STRING\" size=\"256\"/><Column id=\"upjang\" type=\"STRING\" size=\"256\"/><Column id=\"upjangnm\" type=\"STRING\" size=\"256\"/><Column id=\"custcd\" type=\"STRING\" size=\"256\"/><Column id=\"vdNm\" type=\"STRING\" size=\"256\"/><Column id=\"itemCode\" type=\"STRING\" size=\"256\"/><Column id=\"itemName\" type=\"STRING\" size=\"256\"/><Column id=\"itemSize\" type=\"STRING\" size=\"256\"/><Column id=\"poUom\" type=\"STRING\" size=\"256\"/><Column id=\"poQty\" type=\"STRING\" size=\"256\"/><Column id=\"procQty\" type=\"STRING\" size=\"256\"/><Column id=\"cdClaimKind\" type=\"STRING\" size=\"256\"/><Column id=\"reqKind\" type=\"STRING\" size=\"256\"/><Column id=\"ctKind\" type=\"STRING\" size=\"256\"/><Column id=\"partTmCd\" type=\"STRING\" size=\"256\"/><Column id=\"partTmNm\" type=\"STRING\" size=\"256\"/><Column id=\"mngSabun\" type=\"STRING\" size=\"256\"/><Column id=\"mngName\" type=\"STRING\" size=\"256\"/><Column id=\"prcsStatus\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_prcsStatus", this);
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
            obj.set_taborder("0");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);

            obj = new Static("Static32", "absolute", "0", "2", null, "59", "0", null, this);
            obj.set_taborder("1");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_upjang", "absolute", "139", "8", null, "47", "10", null, this);
            obj.set_taborder("4");
            obj.set_displaynulltext("사업장을 선택");
            obj.set_readonly("true");
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

            obj = new Static("Static02", "absolute", "0", "118", null, "59", "0", null, this);
            obj.set_taborder("25");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Button("btn_search", "absolute", null, "124", "100", "47", "10", null, this);
            obj.set_taborder("26");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "420", "135", "10", "19", null, null, this);
            obj.set_taborder("32");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "0", "60", null, "59", "0", null, this);
            obj.set_taborder("35");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Combo("cbo_storage", "absolute", "10", "66", null, "47", "10", null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("36");
            obj.set_displaynulltext("창고명 선택");
            obj.set_innerdataset("ds_storageCd");
            obj.set_codecolumn("cd");
            obj.set_datacolumn("cdNm");

            obj = new Grid("grd_list", "absolute", "0", "176", null, null, "0", "0", this);
            obj.set_cssclass("grd_WF_Default2");
            obj.set_taborder("38");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_extendsizetype("row");
            obj.set_autosizingtype("row");
            obj.set_nodataimage("URL('theme://Image/grd_WF_NoDataImg.png')");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"9\"/><Column size=\"231\"/><Column size=\"61\"/><Column size=\"83\"/><Column size=\"8\"/><Column size=\"33\"/><Column size=\"106\"/><Column size=\"9\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"38\"/><Row size=\"38\"/><Row size=\"38\"/><Row size=\"2\"/></Rows><Band id=\"head\"><Cell/><Cell col=\"1\" text=\"GrayLabel\"/><Cell col=\"2\"/><Cell col=\"3\"/><Cell col=\"4\"/><Cell col=\"5\" text=\"WhiteLabel\"/><Cell col=\"6\" text=\"GrayLabel\"/><Cell col=\"7\"/></Band><Band id=\"body\"><Cell style=\"line:0 solid #808080 ;\" autosizerow=\"limitmin\"/><Cell col=\"1\" colspan=\"6\" style=\"align:left bottom;padding:0 10 0 10;line:0 solid #808080ff ;\" text=\"expr: itemCode + &quot; &quot; + itemName\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell col=\"7\" style=\"line:0 solid #808080 ;\" autosizerow=\"limitmin\"/><Cell row=\"1\" style=\"line:0 none;\" autosizerow=\"limitmin\"/><Cell row=\"1\" col=\"1\" colspan=\"6\" celltype=\"none\" displaytype=\"normal\" edittype=\"none\" style=\"padding:0 10 0 10;line:0 none #808080ff ;\" text=\"bind:vdNm\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"1\" col=\"7\" style=\"line:0 none;\" autosizerow=\"limitmin\"/><Cell row=\"2\" style=\"line:0 none;\" autosizerow=\"limitmin\"/><Cell row=\"2\" col=\"1\" colspan=\"3\" displaytype=\"normal\" style=\"align:left top;padding:0 10 0 10;line:0 none #808080ff ;\" text=\"bind:itemSize\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"2\" col=\"4\" colspan=\"3\" displaytype=\"combo\" style=\"align:right top;padding:0 10 0 10;line:0 none #808080ff ;color:red;color2:red;selectcolor:red;\" text=\"bind:prcsStatus\" wordwrap=\"char\" combodataset=\"ds_prcsStatus\" combocodecol=\"cd\" combodatacol=\"cdNm\" autosizerow=\"limitmin\"/><Cell row=\"2\" col=\"7\" style=\"line:0 none;\" autosizerow=\"limitmin\"/><Cell row=\"3\" colspan=\"8\" autosizerow=\"limitmax\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_dtFrom", "absolute", "10", "124", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("39");
            obj.set_dateformat("yyyy-MM-dd");

            obj = new Static("Static34", "absolute", "210", "124", "15", "47", null, null, this);
            obj.set_taborder("40");
            obj.set_text("~");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_dtTo", "absolute", "225", "124", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("41");
            obj.set_dateformat("yyyy-MM-dd");

            obj = new Static("sta_dtFrom", "absolute", "10", "132", "195", "47", null, null, this);
            obj.set_taborder("42");
            this.addChild(obj.name, obj);

            obj = new Static("sta_dtTo", "absolute", "225", "132", "195", "47", null, null, this);
            obj.set_taborder("43");
            this.addChild(obj.name, obj);

            obj = new Button("btn_moreView", "absolute", "128", null, null, "42", "136", "0", this);
            obj.set_taborder("44");
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
            		p.set_titletext("클레임처리현황");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("ClaimProcessReport.xfdl", "lib::lib_Com.xjs");
        this.registerScript("ClaimProcessReport.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		클레임처리현황
        // [부시스템명]	클레임처리현황 - 조회
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
        this.firstDate = undefined;
        this.fv_totalpageRow;	// 전체건수
        this.upjang = undefined;
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
        	
        	// 권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetAuth("this.edt_upjang", "this.btn_upjang");
        	
        	//처리현황 공통코드 호출
        	this.fn_common_code("C00", "", "");	
        	this.ds_prcsStatus.copyData(application.gds_common_code);
        	
        	this.preDate = this.gfn_Today();
        	this.firstDate = this.gfn_subStr(this.preDate,0,6) + "01";
        	
        	this.cal_dtFrom.set_value(this.firstDate);
        	this.cal_dtTo.set_value(this.preDate);
        	
        	//사업장 세팅
        	this.edt_upjang.set_value(application.g_UpjangNm);	
        	this.upjang = application.g_Upjang;	
        	
        	//창고 콤보 데이터 호출
        	this.subInventorySearch();
        }

        /** 
         * 사업장 검색 팝업 호출
         */
        this.btn_upjang_onclick = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.edt_upjang.value;
        	if(application.g_Mu_Cd == "2004")
        	{
        		arg[2] = "FMS";
        	}
        	else
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
        	}
        	
        	application.goMain.gfn_POP_create("upjangNm", "M_MLM::WorkplaceSearchPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        //창고 콤보 팝업창 호출
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
        	this.ds_grd.clearData();
        	this.btn_moreView.set_visible(false);
        	
        	//필수항목 
        	if (this.fn_searchChk()) return;
        	
        	var subinvCd = this.ds_storageCd.getColumn(this.vRtn, "cd");
        	
        	//검색
        	var strSvcID   		 = "search";
        	var strUrl     		 = "ms/mcm/claimProcessReport/selectList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "ds_grd=ds_list";
        	var strArguments	 = "upjang=" + nexacro.wrapQuote(this.upjang);
        	    strArguments     += " subinvCd=" + nexacro.wrapQuote(subinvCd);
        	    strArguments     += " calDtFrom=" + nexacro.wrapQuote(this.cal_dtFrom.value);
        	    strArguments     += " calDtTo=" + nexacro.wrapQuote(this.cal_dtTo.value);
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);	
        	
        }

        /*******************************************************************************
        * 기      능   :  사업장 창고 호출
        * 설      명   :  사업장 창고 호출
        ********************************************************************************/
        this.subInventorySearch = function()
        {
        	var strSvcID   		 = "subInventory";
        	var strUrl     		 = "/ms/mom/subInventory/selectVoSubinList.xdo";
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
        		application.goMain.gfn_Msg("ALERT_0", "알림", "신청일(From)을 정확하게 입력하세요.", "OK");
        		return true;
        	}
        	
        	if ( this.gfn_isNull(this.cal_dtTo.value) || (this.gfn_Length(this.cal_dtTo.value)< 8) )
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "신청일(To)을 정확하게 입력하세요.", "OK");
        		return true;
        	}
        	
        	if ( this.cal_dtFrom.value > this.cal_dtTo.value )
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "시작일보다 종료일이 늦습니다.", "OK");
        		return true;		
        	}
        	
        	/*
        	if ( this.gfn_subStr(this.cal_dtFrom.value,0,6)!= this.gfn_subStr(this.cal_dtTo.value,0,6))
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "기간은 동일월에 한하여 조회가능합니다.", "OK", true, this);
        		return true;		
        	}
        	*/
        	
        	return false;
        }

        /*******************************************************************************
        * 기      능   :  그리드 클릭시 상세내역팝업창 호출
        * 설      명   :  그리드 클릭시 상세내역팝업창 호출
        ********************************************************************************/
        this.grd_list_oncellclick = function(obj,e)
        {
        	var arg = new Array();
        		arg[0] = this.ds_grd.getColumn(this.ds_grd.rowposition, "itemName");      //자재명
        		arg[1] = this.ds_grd.getColumn(this.ds_grd.rowposition, "itemCode");      //자재코드
        		arg[2] = this.ds_grd.getColumn(this.ds_grd.rowposition, "vdNm");          //고객업체
        		arg[3] = this.ds_grd.getColumn(this.ds_grd.rowposition, "poQty");         //발주량
        		arg[4] = this.ds_grd.getColumn(this.ds_grd.rowposition, "reqQty");        //요청량
        		arg[5] = this.ds_grd.getColumn(this.ds_grd.rowposition, "ctClaimKind");   //클레임유형
        		arg[6] = this.ds_grd.getColumn(this.ds_grd.rowposition, "reqKind");       //요청사항
        		//arg[7] = this.ds_grd.getColumn(this.ds_grd.rowposition, "claimMemo");     //클레임상세내역
        		//arg[8] = this.ds_grd.getColumn(this.ds_grd.rowposition, "reqDate");       //입고요청일자
        		//arg[9] = this.ds_grd.getColumn(this.ds_grd.rowposition, "reqTime");       //입고요청시간
        		//arg[10] = this.ds_grd.getColumn(this.ds_grd.rowposition, "ctMemo");	      //기타사항
        		arg[11] = this.ds_grd.getColumn(this.ds_grd.rowposition, "prcsStatus");   //처리상황
        		arg[12] = this.ds_grd.getColumn(this.ds_grd.rowposition, "needDate");     //입고예정일
        		arg[13] = this.ds_grd.getColumn(this.ds_grd.rowposition, "partTmNm");     //처리부서
        		arg[14] = this.ds_grd.getColumn(this.ds_grd.rowposition, "mngName");      //처리담당자
        		arg[15] = "01";      //구분
        		
        		application.goMain.gfn_POP_create("claimProcessDetailReportPop", "M_MCM::ClaimProcessDetailReportPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	
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
                case "search" :
        			// TODO parameter로 전체건수를 받는다.
        			this.fv_totalpageRow = this.ds_grd.getRowCount();
        			
                    // 조회 건수 확인  
                    if (this.ds_grd.getRowCount() == 0) 
                    {
                        application.goMain.gfn_Msg("alertTest", "Information", "조회되는 내용이 없습니다.", "OK");	//조회되는 내용이 없습니다.
                        return;
                    }
                    else	// 조회건수가 1페이지 이상일때
                    {
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
        		this.btn_moreView.set_visible(true);
        	}
        	else if (e.yaccvalue < 0)
        	{
        		if (this.ds_grd.getRowCount() > 0)
        		{
        			this.parent.parent.divBottom.set_visible(false);
        			this.parent.parent.divMain.set_height(923);
        			this.btn_moreView.set_visible(false);
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
            this.addEventHandler("onload", this.form_onload, this);
            this.btn_upjang.addEventHandler("onclick", this.btn_upjang_onclick, this);
            this.btn_search.addEventHandler("onclick", this.btnSearch_onclick, this);
            this.cbo_storage.addEventHandler("ondropdown", this.cbo_Storage_ondropdown, this);
            this.grd_list.addEventHandler("onvscroll", this.grd_list_onvscroll, this);
            this.grd_list.addEventHandler("oncellclick", this.grd_list_oncellclick, this);
            this.grd_list.addEventHandler("onslide", this.grd_list_onslide, this);
            this.sta_dtFrom.addEventHandler("onclick", this.sta_dtFrom_onclick, this);
            this.sta_dtTo.addEventHandler("onclick", this.sta_dtTo_onclick, this);

        };

        this.loadIncludeScript("ClaimProcessReport.xfdl", true);

       
    };
}
)();
