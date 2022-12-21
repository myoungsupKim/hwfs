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
                this.set_name("ClaimProcessReqt");
                this.set_titletext("클레임처리신청");
                this._setFormPosition(0,0,540,760);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
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

            obj = new Dataset("ds_grd", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("false");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"itemCode\" type=\"STRING\" size=\"255\"/><Column id=\"itemName\" type=\"STRING\" size=\"255\"/><Column id=\"itemSize\" type=\"STRING\" size=\"255\"/><Column id=\"poUom\" type=\"STRING\" size=\"255\"/><Column id=\"custcd\" type=\"STRING\" size=\"255\"/><Column id=\"custnm\" type=\"STRING\" size=\"255\"/><Column id=\"poQty\" type=\"BIGDECIMAL\" size=\"255\"/><Column id=\"reqQty\" type=\"BIGDECIMAL\" size=\"255\"/><Column id=\"dlvyQty\" type=\"BIGDECIMAL\" size=\"256\"/><Column id=\"ctClaimKind\" type=\"STRING\" size=\"255\"/><Column id=\"reqDate\" type=\"STRING\" size=\"255\"/><Column id=\"reqTime\" type=\"STRING\" size=\"255\"/><Column id=\"reqKind\" type=\"STRING\" size=\"255\"/><Column id=\"claimMemo\" type=\"STRING\" size=\"255\"/><Column id=\"prcsStatus\" type=\"STRING\" size=\"255\"/><Column id=\"dlvyKind\" type=\"STRING\" size=\"255\"/><Column id=\"createBy\" type=\"STRING\" size=\"255\"/><Column id=\"mobileGubun\" type=\"STRING\" size=\"255\"/><Column id=\"photo\" type=\"BIGDECIMAL\" size=\"255\"/><Column id=\"poId\" type=\"BIGDECIMAL\" size=\"255\"/><Column id=\"centerCode\" type=\"STRING\" size=\"255\"/><Column id=\"subinvCode\" type=\"STRING\" size=\"255\"/><Column id=\"upjang\" type=\"STRING\" size=\"255\"/><Column id=\"needDate\" type=\"STRING\" size=\"255\"/><Column id=\"mobileGubunImg\" type=\"STRING\" size=\"256\"/><Column id=\"poNum\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
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
            obj._setContents("<ColumnInfo><Column id=\"schUpjang\" type=\"STRING\" size=\"256\"/><Column id=\"schUpjangNm\" type=\"STRING\" size=\"256\"/><Column id=\"schSubinCode\" type=\"STRING\" size=\"256\"/><Column id=\"schDate1\" type=\"STRING\" size=\"256\"/><Column id=\"schDate2\" type=\"STRING\" size=\"256\"/><Column id=\"schItemNm\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row/></Rows>");
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

            obj = new Dataset("ds_grdChk", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("false");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"itemCode\" type=\"STRING\" size=\"255\"/><Column id=\"itemName\" type=\"STRING\" size=\"255\"/><Column id=\"itemSize\" type=\"STRING\" size=\"255\"/><Column id=\"poUom\" type=\"STRING\" size=\"255\"/><Column id=\"custcd\" type=\"STRING\" size=\"255\"/><Column id=\"custnm\" type=\"STRING\" size=\"255\"/><Column id=\"poQty\" type=\"BIGDECIMAL\" size=\"255\"/><Column id=\"reqQty\" type=\"BIGDECIMAL\" size=\"255\"/><Column id=\"ctClaimKind\" type=\"STRING\" size=\"255\"/><Column id=\"reqDate\" type=\"STRING\" size=\"255\"/><Column id=\"reqTime\" type=\"STRING\" size=\"255\"/><Column id=\"reqKind\" type=\"STRING\" size=\"255\"/><Column id=\"claimMemo\" type=\"STRING\" size=\"255\"/><Column id=\"prcsStatus\" type=\"STRING\" size=\"255\"/><Column id=\"dlvyKind\" type=\"STRING\" size=\"255\"/><Column id=\"createBy\" type=\"STRING\" size=\"255\"/><Column id=\"mobileGubun\" type=\"STRING\" size=\"255\"/><Column id=\"photo\" type=\"BIGDECIMAL\" size=\"255\"/><Column id=\"poId\" type=\"BIGDECIMAL\" size=\"255\"/><Column id=\"centerCode\" type=\"STRING\" size=\"255\"/><Column id=\"subinvCode\" type=\"STRING\" size=\"255\"/><Column id=\"upjang\" type=\"STRING\" size=\"255\"/><Column id=\"needDate\" type=\"STRING\" size=\"255\"/><Column id=\"mobileGubunImg\" type=\"STRING\" size=\"256\"/><Column id=\"poNum\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_commonCd", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"256\"/><Column id=\"cdNm\" type=\"STRING\" size=\"256\"/><Column id=\"set1\" type=\"STRING\" size=\"256\"/><Column id=\"set2\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("Static01", "absolute", "0", "118", null, "59", "0", null, this);
            obj.set_taborder("61");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "0", "0", null, "2", "0", null, this);
            obj.set_taborder("0");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);

            obj = new Static("Static32", "absolute", "0", "2", null, "59", "0", null, this);
            obj.set_taborder("10");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static37", "absolute", "0", "60", null, "59", "0", null, this);
            obj.set_taborder("11");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static38", "absolute", "0", "60", "156", "59", null, null, this);
            obj.set_taborder("12");
            obj.set_text("창고");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static42", "absolute", "0", "2", "156", "59", null, null, this);
            obj.set_taborder("14");
            obj.set_text("사업장");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Combo("cbo_storage", "absolute", "100", "66", null, "47", "10", null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("48");
            obj.set_innerdataset("@ds_storageCd");
            obj.set_codecolumn("cd");
            obj.set_datacolumn("cdNm");
            obj.set_displaynulltext("창고명 선택");
            obj.set_index("-1");

            obj = new Calendar("cal_dtFrom", "absolute", "100", "124", "196", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("49");
            obj.set_dateformat("yyyy-MM-dd");
            obj.set_value("20150601");
            obj.set_readonly("false");

            obj = new Static("Static05", "absolute", "0", "118", "156", "59", null, null, this);
            obj.set_taborder("50");
            obj.set_text("입고일");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_upjang", "absolute", "100", "8", null, "47", "10", null, this);
            obj.set_taborder("62");
            obj.set_displaynulltext("사업장 선택");
            obj.set_autoselect("true");
            obj.set_readonly("true");
            this.addChild(obj.name, obj);

            obj = new Button("btn_upjang", "absolute", null, "8", "47", "47", "10", null, this);
            obj.set_taborder("63");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list", "absolute", "0", "176", null, null, "0", "0", this);
            obj.set_cssclass("grd_WF_Default2");
            obj.set_taborder("64");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_nodataimage("URL('theme://Image/grd_WF_NoDataImg.png')");
            obj.set_autosizingtype("row");
            obj.set_extendsizetype("row");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"50\"/><Column size=\"281\"/><Column size=\"136\"/><Column size=\"70\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"3\"/><Row size=\"50\"/><Row size=\"3\"/><Row size=\"50\"/><Row size=\"3\"/></Rows><Band id=\"head\"><Cell/><Cell col=\"1\" text=\"GrayLabel\"/><Cell col=\"2\"/><Cell col=\"3\" text=\"GrayLabel\"/></Band><Band id=\"body\"><Cell style=\"line:0 solid #808080 ;\" autosizerow=\"limitmax\"/><Cell col=\"1\" colspan=\"3\" style=\"line:0 solid #808080 ;\" autosizerow=\"limitmax\"/><Cell row=\"1\" displaytype=\"button\" style=\"padding:5 5 5 5;line:0 solid transparent ;controlbackground:BIND(mobileGubunImg);controlborder:0 solid #808080ff ;\" autosizerow=\"limitmin\"/><Cell row=\"1\" col=\"1\" colspan=\"2\" celltype=\"none\" displaytype=\"normal\" edittype=\"none\" style=\"align:left bottom;padding:0 10 0 10;line:0 none #808080ff ;\" text=\"expr: itemCode + &quot; &quot; + itemName\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"1\" col=\"3\" displaytype=\"button\" style=\"align:center middle;padding:3 3 3 3;line:0 none #808080ff ;controlbackground:EXPR(lineStatus == &quot;PD&quot;?&quot;silver&quot;:(prcsStatus == &quot;&quot;?&quot;&quot;:&quot;silver&quot;));\" text=\"신청\" autosizerow=\"limitmin\"/><Cell row=\"2\" style=\"line:0 solid #808080 ;\" autosizerow=\"limitmax\"/><Cell row=\"2\" col=\"1\" colspan=\"3\" style=\"line:0 solid #808080ff ;\" autosizerow=\"limitmax\"/><Cell row=\"3\" colspan=\"2\" style=\"align:left top;line:0 solid #808080ff ;\" text=\"expr:itemSize + &quot; &quot; + poUom\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"3\" col=\"2\" displaytype=\"normal\" style=\"align:left top;padding:0 10 0 10;line:0 none #808080ff ;color:red;color2:red;selectcolor:red;\" text=\"bind:lineStatusNm\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"3\" col=\"3\" celltype=\"none\" displaytype=\"button\" style=\"align:center middle;padding:3 3 3 3;line:0 none #808080ff ;controlbackground:EXPR(lineStatus == &quot;PD&quot;?&quot;silver&quot;:(prcsStatus == &quot;01&quot;?&quot;&quot;:&quot;silver&quot;));\" text=\"취소\" wordwrap=\"none\" autosizerow=\"limitmin\"/><Cell row=\"4\" autosizerow=\"limitmax\"/><Cell row=\"4\" col=\"1\" colspan=\"3\" autosizerow=\"limitmax\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Button("btn_search", "absolute", null, "124", "100", "47", "10", null, this);
            obj.set_taborder("65");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_itemNm", "absolute", "300", "124", null, "47", "114", null, this);
            obj.set_taborder("66");
            obj.set_imemode("hangul");
            obj.set_displaynulltext("자재명");
            obj.set_autoselect("true");
            this.addChild(obj.name, obj);

            obj = new Static("sta_dtFrom", "absolute", "100", "124", "196", "47", null, null, this);
            obj.set_taborder("67");
            this.addChild(obj.name, obj);

            obj = new Button("btn_moreView", "absolute", "128", null, null, "42", "136", "0", this);
            obj.set_taborder("68");
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
            		p.set_titletext("클레임처리신청");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("ClaimProcessReqt.xfdl", "lib::lib_Com.xjs");
        this.registerScript("ClaimProcessReqt.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		클레임처리신청
        // [부시스템명]	클레임처리신청 - 조회
        // [설명]
        // 		부서 검색하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.02.09
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.09 : 강대성 : 수정이 필요하여 수정함.
        // 2015.10.20 : 강대성 : 최종 수정
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*======================================================
         전역변수
         ======================================================*/
        this.preDate = undefined;
        this.fv_totalpageRow;	// 전체건수
        this.upjang = undefined;
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
        	//메세지 공통 코드 호출
        	this.fn_common_code("SYS_CLS_PRD", "PO","","","AND TO_CHAR(SYSDATE, 'YYYYMMDDHH24MI') BETWEEN REPLACE(REPLACE(REPLACE(SET1,'/',''),' ',''),':','') AND REPLACE(REPLACE(REPLACE(SET2,'/',''),' ',''),':','')");
        	this.ds_commonCd.copyData(application.gds_common_code);
        	
        	if(this.ds_commonCd.getRowCount() > 0 )
        	{
        		this.commonMsg(this.ds_commonCd.getColumn(0, "set1"), this.ds_commonCd.getColumn(0, "set2"));		
        	}
        	else
        	{
        		//필수
        		this.fn_init();
        	}
        }

        this.fn_init = function ()
        {
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetBtnControl("this.btn_search","");	
        	
        	this.savYn = application.gds_cmnAuth.getColumn(0, "savYn")
        	
        	// 권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetAuth("this.edt_upjang", "this.btn_upjang");
        	
        	//처리현황
        	this.fn_common_code("C00", "", "");	
        	this.ds_prcsStatus.copyData(application.gds_common_code);
        	
        	this.preDate = this.gfn_Today();
        	this.cal_dtFrom.set_value(this.preDate);
        	
        	//사업장 세팅
        	this.edt_upjang.set_value(application.g_UpjangNm);	
        	this.upjang = application.g_Upjang;	
        	
        	//창고 콤보 데이터 호출
        	this.subInventorySearch();
        	
        	var nRow = this.ds_search.rowposition;
        	this.ds_search.setColumn(nRow, "schUpjangNm", application.g_UpjangNm);
        	
        }

        /*==========================================================================
         * 사업장 검색 팝업 호출
        *========================================================================*/
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
        this.btnSearch_onclick = function(obj,e)
        {
        	this.fn_search();
        }

        this.fn_search = function()
        {
        	var subinvCd = this.ds_storageCd.getColumn(this.vRtn, "cd");
        	
        	this.ds_grd.clearData();
        	this.btn_moreView.set_visible(false);
        	
        	var nRow = this.ds_search.rowposition;
        	this.ds_search.setColumn(nRow, "schUpjang", this.upjang);
        	this.ds_search.setColumn(nRow, "schUpjangNm",this.edt_upjang.value);
        	this.ds_search.setColumn(nRow, "schSubinCode", subinvCd);
        	this.ds_search.setColumn(nRow, "schDate1", this.cal_dtFrom.value);
        	this.ds_search.setColumn(nRow, "schDate2", this.cal_dtFrom.value);
        	this.ds_search.setColumn(nRow, "schItemNm", this.gfn_transNullToEmpty(this.edt_itemNm.value));
        	
        	
        	//필수항목 
        	if (this.fn_searchChk()) return;
        	
        	//검색
        	var strSvcID   		 = "search";
        	var strUrl     		 = "fm/fmc/claimReg/selectList.xdo";
        	var strInDataset     = "ds_search=ds_search:A";
        	var strOutDataset    = "ds_grd=ds_list";
        	var strArguments	 = "";
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
          	// connect the server 
        	
        }

        /*******************************************************************************
        * 기      능   :  등록
        * 설      명   :  클레임요청
        ********************************************************************************/
        this.fn_save = function(str)
        {
        	if(str == "cancel")
        	{
        		this.ds_grd.setRowType(this.ds_grd.rowposition, "U");
        		this.ds_grd.setColumn(this.ds_grd.rowposition, "checked", "1");        //체크건(모바일은 체크된값으로 넘김)
        		this.ds_grd.setColumn(this.ds_grd.rowposition, "prcsStatus", "08");
        	}
        	else
        	{
        		if(this.ds_grd.getColumn(this.ds_grd.rowposition, "prcsStatus") == "")
        		{
        			this.ds_grd.setRowType(this.ds_grd.rowposition, "I");
        			this.ds_grd.setColumn(this.ds_grd.rowposition, "prcsStatus", "01");
        			this.ds_grd.setColumn(this.ds_grd.rowposition, "mobileGubun", "M");     //모바일신청 구분(M)
        		}	
        		else
        		{	
        			this.ds_grd.setRowType(this.ds_grd.rowposition, "U");
        			this.ds_grd.setColumn(this.ds_grd.rowposition, "prcsStatus", "01");
        		}	
        	}
        	
        		
        	var strSvcID   		 = "save";
        	var strUrl     		 = "fm/fmc/claimReg/saveList.xdo";
        	var strInDataset     = "ds_list=ds_grd:U";
        	var strOutDataset    = "";
        	var strArguments	 = "";
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
        	if ( this.gfn_isNull(this.edt_upjang.value) )
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "사업장을 선택하세요.", "OK", true, this);
        		return true;
        	}
        	
        	if ( this.gfn_isNull(this.cbo_storage.value) )
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "창고를 선택하세요.", "OK", true, this);
        		return true;
        	}
        	
        	if ( this.gfn_isNull(this.cal_dtFrom.value) )
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "입고일을 입력하세요.", "OK", true, this);
        		return true;
        	}
        	
        	return false;
        }

        /*******************************************************************************
        * 기      능   :  저장체크
        * 설      명   :  저장체크
        ********************************************************************************/
        this.fn_saveChk = function (value)
        {
        	var subinvCd = this.ds_storageCd.getColumn(this.vRtn, "cd");
        	
        	var nRow = this.ds_search.rowposition;
        	this.ds_search.setColumn(nRow, "schUpjang", this.upjang);
        	this.ds_search.setColumn(nRow, "schUpjangNm",this.edt_upjang.value);
        	this.ds_search.setColumn(nRow, "schSubinCode", subinvCd);
        	this.ds_search.setColumn(nRow, "schDate1", this.cal_dtFrom.value);
        	this.ds_search.setColumn(nRow, "schDate2", this.cal_dtFrom.value);
        	this.ds_search.setColumn(nRow, "schItemNm", this.gfn_transNullToEmpty(this.edt_itemNm.value));
        	
        	//검색
        	if(value == "cancel")
        	{
        		var strSvcID   		 = "cancelChk";
        	}
        	else
        	{
        		var strSvcID   		 = "saveChk";
        	}
        	var strUrl     		 = "fm/fmc/claimReg/selectList.xdo";
        	var strInDataset     = "ds_search=ds_search:A";
        	var strOutDataset    = "ds_grdChk=ds_list";
        	var strArguments	 = "";
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
          	// connect the server 
        }

        /*******************************************************************************
        * 기      능   :  그리드 cell클릭시
        * 설      명   :  승인 또는 반려 버튼 클릭시 해당 팝업창을 호출한다.
        ********************************************************************************/ 
        this.grd_list_oncellclick = function(obj,e)
        {	
        	var arg = new Array();
        	arg[0] = this.ds_grd.getColumn(this.ds_grd.rowposition, "reqQty");        //요청량
        	arg[1] = this.ds_grd.getColumn(this.ds_grd.rowposition, "ctClaimKind");   //클레임유형
        	arg[2] = this.ds_grd.getColumn(this.ds_grd.rowposition, "reqKind");       //요청사항
        	arg[3] = this.ds_grd.getColumn(this.ds_grd.rowposition, "claimMemo");     //클레임상세내용
        	arg[4] = this.ds_grd.getColumn(this.ds_grd.rowposition, "reqDate");       //입고요청일자
        	arg[5] = this.ds_grd.getColumn(this.ds_grd.rowposition, "reqTime");       //입고요청시간
        	arg[6] = this.ds_grd.getColumn(this.ds_grd.rowposition, "etcMemo");       //기타사항
        	arg[7] = this.ds_grd.getColumn(this.ds_grd.rowposition, "dlvyQty");       //입고수량
        	arg[8] = this.ds_grd.getColumn(this.ds_grd.rowposition, "poId");          //클레임아이디
        	arg[9] = this.ds_grd.getColumn(this.ds_grd.rowposition, "poNum");         //클레임주문번호
        			
        	var argSelect = new Array();
        	argSelect[0] = this.ds_grd.getColumn(this.ds_grd.rowposition, "itemName");      //자재명
        	argSelect[1] = this.ds_grd.getColumn(this.ds_grd.rowposition, "itemCode");      //자재코드
        	argSelect[2] = this.ds_grd.getColumn(this.ds_grd.rowposition, "custnm");        //고객업체
        	argSelect[3] = this.ds_grd.getColumn(this.ds_grd.rowposition, "dlvyQty");       //입고수량
        	argSelect[4] = this.ds_grd.getColumn(this.ds_grd.rowposition, "reqQty");        //요청량
        	argSelect[5] = this.ds_grd.getColumn(this.ds_grd.rowposition, "ctClaimKind");   //클레임유형
        	argSelect[6] = this.ds_grd.getColumn(this.ds_grd.rowposition, "reqKind");       //요청사항
        	argSelect[7] = this.ds_grd.getColumn(this.ds_grd.rowposition, "claimMemo");     //클레임상세내역
        	argSelect[8] = this.ds_grd.getColumn(this.ds_grd.rowposition, "reqDate");       //입고요청일자
        	argSelect[9] = this.ds_grd.getColumn(this.ds_grd.rowposition, "reqTime");       //입고요청시간
        	argSelect[10] = this.ds_grd.getColumn(this.ds_grd.rowposition, "etcMemo");	    //기타사항
        	argSelect[11] = this.ds_grd.getColumn(this.ds_grd.rowposition, "dlvyKind");     //처리상황
        	argSelect[12] = this.ds_grd.getColumn(this.ds_grd.rowposition, "needDate");     //입고예정일
        	
        	if(this.savYn == "Y")
        	{	
        		if(e.cell == "4")
        		{
        			if(this.ds_grd.getColumn(this.ds_grd.rowposition, "lineStatus") != "PD" && this.ds_grd.getColumn(this.ds_grd.rowposition, "prcsStatus") == "")
        			{
        				application.goMain.gfn_POP_create("claimProcessDetailReqtPop", "M_MCM::ClaimProcessDetailReqtPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        			}
        			
        		}
        		else if(e.cell == "9")
        		{
        			if(this.ds_grd.getColumn(this.ds_grd.rowposition, "lineStatus") != "PD" && this.ds_grd.getColumn(this.ds_grd.rowposition, "prcsStatus") == "01")
        			{
        				application.goMain.gfn_Msg("cancel", "취소", "클레임취소 처리 하시겠습니까?", "YN", true, this);	
        			}		
        		}
        		else{
        			application.goMain.gfn_POP_create("claimProcessDetailReportPop", "M_MCM::ClaimProcessDetailReportPop.xfdl", "fn_callbackPOP", this, argSelect, "POP", application.goMain.divBase);	
        		}
        	}
        	else
        	{
        		application.goMain.gfn_Msg("", "알림", "신청 및 취소 권한이 없습니다.", "OK");
        	}
        	
        }

        this.edt_itemNm_onchanged = function(obj,e)
        {
        	this.edt_itemNm.set_autoselect(false);
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
        		//클레임처리대상조회
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
        				
        				//상품 정상조회 후 컬럼 항목 추가 및 이미지 경로 데이터셋에 세팅 
        				this.ds_grd.addColumn("mobileGubunImg", "String", 255);
        				
        				for(var i=0; i < this.ds_grd.rowcount; i++)
        				{			
        					if(this.ds_grd.getColumn(i, "mobileGubun") == "M")
        					{
        						this.ds_grd.setColumn(i, "mobileGubunImg", "URL('HWImage::grd_WF_M.png') stretch");
        					}
        					else
        					{
        						this.ds_grd.setColumn(i, "mobileGubunImg", "URL('HWImage::grd_WF_P.png') stretch");
        					}					
        				}	
        			}
        			
        			//식권 일경우 전량 미입고 처리.
                    for(var i=0; i<this.ds_grd.rowcount; i++){
        				if(this.ds_grd.getColumn(i,"ticketYn") == "Y" && this.gfn_isNull(this.ds_grd.getColumn(i,"prcsStatus"))){
        					this.ds_grd.setColumn(i, "ctClaimKind" , "C0508");//미입고
        					this.ds_grd.setColumn(i, "reqQty", ds_list.getColumn(i, "dlvyQty"));
        					this.ds_grd.setColumn(i, "checked", 0);
        				}
                    }
                    
          			break;
          		//저장시체크
          		case "saveChk" :			
        			
        			if(this.ds_grd.getColumn(this.ds_grd.rowposition,"prcsStatus") != this.ds_grdChk.getColumn(this.ds_grd.rowposition,"prcsStatus"))
        			{
        				application.goMain.gfn_Msg("ALERT_0", "Information", "요청상태가 변경되었습니다.재조회 바랍니다.", "OK");
        				return;
        			}							
        			
        			this.fn_save();			
        			break;
        		//취소시체크
          		case "cancelChk" :
          		
        			if(this.ds_grd.getColumn(this.ds_grd.rowposition,"prcsStatus") != this.ds_grdChk.getColumn(this.ds_grd.rowposition,"prcsStatus"))
        			{
        				application.goMain.gfn_Msg("ALERT_0", "Information", "요청상태가 변경되었습니다.재조회 바랍니다.", "OK");
        				return;
        			}							
        			
        			this.fn_save("cancel");		
        			break;
          		//저장시
          		case "save" :
        			application.goMain.gfn_Msg("ALERT_0", "Information", "저장되었습니다.", "OK");	//저장되었습니다
        			this.fn_search();			
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
        		case "claimProcessDetailReqtPop":
        			this.ds_grd.setColumn(this.ds_grd.rowposition, "checked", "1");        //체크건(모바일은 체크된값으로 넘김)
        			this.ds_grd.setColumn(this.ds_grd.rowposition, "reqQty", rtn[0]);      //요청량
        			this.ds_grd.setColumn(this.ds_grd.rowposition, "ctClaimKind", rtn[1]); //클레임유형
        			this.ds_grd.setColumn(this.ds_grd.rowposition, "reqKind", rtn[2]);     //요청사항
        			this.ds_grd.setColumn(this.ds_grd.rowposition, "claimMemo", rtn[3]);   //클레임상세내용
        			this.ds_grd.setColumn(this.ds_grd.rowposition, "reqDate", rtn[4]);     //입고요청일자
        			this.ds_grd.setColumn(this.ds_grd.rowposition, "reqTime", rtn[5]);     //입고요청시간
        			this.ds_grd.setColumn(this.ds_grd.rowposition, "etcMemo", rtn[6]);     //기타사항			
        			
        			this.fn_saveChk();
        			
        			//this.fn_save();
        			break;	
        		case "claimProcessDetailReportPop":
        			
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
        	//공지사항 콜백
        	if (id == "NOTICE")
        	{
        		//앱종료
        		application.goMain.fn_action("EXIT");		
        	}
        	
        	if (id == "ALERT_0") // 조회 시 오류
        	{
        		// 아무 일도 안함.
        	}
        	
        	if (id == "cancel")
        	{
        		if (rtn == "Y") 
        		{	
        			this.fn_saveChk("cancel");
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
        		this.parent.btnGoTopDiv.set_left(420);
        		this.parent.btnGoTopDiv.set_right(65);
        		this.parent.btnGoTop.set_right(65);
        		this.parent.btnGoTopDiv.set_bottom(10);
        		this.parent.btnGoTop.set_bottom(10);
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
            this.cbo_storage.addEventHandler("ondropdown", this.cbo_storage_ondropdown, this);
            this.edt_upjang.addEventHandler("onchanged", this.edt_upjang_onchanged, this);
            this.btn_upjang.addEventHandler("onclick", this.btn_upjang_onclick, this);
            this.grd_list.addEventHandler("onvscroll", this.grd_list_onvscroll, this);
            this.grd_list.addEventHandler("oncellclick", this.grd_list_oncellclick, this);
            this.grd_list.addEventHandler("onslide", this.grd_list_onslide, this);
            this.btn_search.addEventHandler("onclick", this.btnSearch_onclick, this);
            this.edt_itemNm.addEventHandler("onchanged", this.edt_itemNm_onchanged, this);
            this.sta_dtFrom.addEventHandler("onclick", this.sta_dtFrom_onclick, this);

        };

        this.loadIncludeScript("ClaimProcessReqt.xfdl", true);

       
    };
}
)();
