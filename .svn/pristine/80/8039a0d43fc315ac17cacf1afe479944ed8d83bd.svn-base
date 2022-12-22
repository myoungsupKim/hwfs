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
                this.set_name("EmergencyLoanApp");
                this.set_titletext("임시여신승인");
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
            obj._setContents("<ColumnInfo><Column id=\"upjang\" type=\"STRING\" size=\"256\"/><Column id=\"mainUpjang\" type=\"STRING\" size=\"256\"/><Column id=\"upjangnmDisp\" type=\"STRING\" size=\"256\"/><Column id=\"creditReqGubun\" type=\"STRING\" size=\"256\"/><Column id=\"creditAmount\" type=\"STRING\" size=\"256\"/><Column id=\"creditOverAmount\" type=\"STRING\" size=\"256\"/><Column id=\"creditBefAmount\" type=\"STRING\" size=\"256\"/><Column id=\"creditAddAmount\" type=\"STRING\" size=\"256\"/><Column id=\"creditTurnDays\" type=\"STRING\" size=\"256\"/><Column id=\"creditOverEnd\" type=\"STRING\" size=\"256\"/><Column id=\"creditBefEnd\" type=\"STRING\" size=\"256\"/><Column id=\"creditAddEnd\" type=\"STRING\" size=\"256\"/><Column id=\"bigo\" type=\"STRING\" size=\"256\"/><Column id=\"remark\" type=\"STRING\" size=\"256\"/><Column id=\"apprYn\" type=\"STRING\" size=\"256\"/><Column id=\"headCreditYn\" type=\"STRING\" size=\"256\"/><Column id=\"reqUser\" type=\"STRING\" size=\"256\"/><Column id=\"reqDate\" type=\"STRING\" size=\"256\"/><Column id=\"hpNo\" type=\"STRING\" size=\"256\"/><Column id=\"udate\" type=\"STRING\" size=\"256\"/><Column id=\"uuser\" type=\"STRING\" size=\"256\"/><Column id=\"chkGubun\" type=\"STRING\" size=\"256\"/><Column id=\"creditId\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_apprCd", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"256\"/><Column id=\"cdNm\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"cdNm\">전체</Col></Row><Row><Col id=\"cd\">Y</Col><Col id=\"cdNm\">승인</Col></Row><Row><Col id=\"cd\">N</Col><Col id=\"cdNm\">미승인</Col></Row><Row><Col id=\"cd\">C</Col><Col id=\"cdNm\">반려</Col></Row></Rows>");
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
            obj._setContents("<ColumnInfo><Column id=\"upjang\" type=\"STRING\" size=\"256\"/><Column id=\"mainUpjang\" type=\"STRING\" size=\"256\"/><Column id=\"upjangnmDisp\" type=\"STRING\" size=\"256\"/><Column id=\"creditReqGubun\" type=\"STRING\" size=\"256\"/><Column id=\"creditAmount\" type=\"STRING\" size=\"256\"/><Column id=\"creditOverAmount\" type=\"STRING\" size=\"256\"/><Column id=\"creditBefAmount\" type=\"STRING\" size=\"256\"/><Column id=\"creditAddAmount\" type=\"STRING\" size=\"256\"/><Column id=\"creditTurnDays\" type=\"STRING\" size=\"256\"/><Column id=\"creditOverEnd\" type=\"STRING\" size=\"256\"/><Column id=\"creditBefEnd\" type=\"STRING\" size=\"256\"/><Column id=\"creditAddEnd\" type=\"STRING\" size=\"256\"/><Column id=\"remark\" type=\"STRING\" size=\"256\"/><Column id=\"apprYn\" type=\"STRING\" size=\"256\"/><Column id=\"headCreditYn\" type=\"STRING\" size=\"256\"/><Column id=\"reqUser\" type=\"STRING\" size=\"256\"/><Column id=\"reqDate\" type=\"STRING\" size=\"256\"/><Column id=\"udate\" type=\"STRING\" size=\"256\"/><Column id=\"uuser\" type=\"STRING\" size=\"256\"/><Column id=\"chkGubun\" type=\"STRING\" size=\"256\"/><Column id=\"creditId\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"upjang\">116893</Col><Col id=\"mainUpjang\">116893</Col><Col id=\"upjangnmDisp\">고려반월병원</Col><Col id=\"creditReqGubun\">02</Col><Col id=\"creditAmount\">710000</Col><Col id=\"creditOverAmount\">710000</Col><Col id=\"apprYn\">N</Col><Col id=\"reqUser\">홍길동</Col><Col id=\"reqDate\">20140330</Col><Col id=\"creditOverEnd\">20140401</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("Static04", "absolute", "0", "0", null, "2", "0", null, this);
            obj.set_taborder("0");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "0", "2", null, "59", "0", null, this);
            obj.set_taborder("1");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list", "absolute", "0", "118", null, null, "0", "0", this);
            obj.set_taborder("8");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("autovert");
            obj.set_autofittype("none");
            obj.set_cssclass("grd_WF_Default2");
            obj.set_scrollpixel("all");
            obj.set_nodataimage("URL('theme://Image/grd_WF_NoDataImg.png')");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"9\"/><Column size=\"187\"/><Column size=\"104\"/><Column size=\"120\"/><Column size=\"8\"/><Column size=\"33\"/><Column size=\"69\"/><Column size=\"9\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"5\"/><Row size=\"38\"/><Row size=\"38\"/><Row size=\"2\"/><Row size=\"39\"/><Row size=\"5\"/></Rows><Band id=\"head\"><Cell/><Cell col=\"1\" text=\"GrayLabel\"/><Cell col=\"2\"/><Cell col=\"3\"/><Cell col=\"4\"/><Cell col=\"5\" text=\"WhiteLabel\"/><Cell col=\"6\" text=\"GrayLabel\"/><Cell col=\"7\"/></Band><Band id=\"body\"><Cell style=\"line:0 none;\"/><Cell col=\"1\" style=\"line:0 none;\"/><Cell col=\"2\" style=\"line:0 solid #808080 ;\"/><Cell col=\"3\" style=\"line:0 none;\"/><Cell col=\"4\" style=\"line:0 none;\"/><Cell col=\"5\" style=\"line:0 none;\"/><Cell col=\"6\" style=\"line:0 none;\"/><Cell col=\"7\" style=\"line:0 none;\"/><Cell row=\"1\" style=\"line:0 solid #808080 ;\"/><Cell row=\"1\" col=\"1\" colspan=\"6\" style=\"padding:0 10 0 10;line:0 solid #808080ff ;\" text=\"bind:upjangnmDisp\"/><Cell row=\"1\" col=\"7\" style=\"line:0 solid #808080 ;\"/><Cell row=\"2\" style=\"line:0 none;\"/><Cell row=\"2\" col=\"1\" celltype=\"none\" displaytype=\"date\" style=\"padding:0 10 0 10;line:0 none #808080ff ;\" text=\"bind:reqDate\"/><Cell row=\"2\" col=\"2\" displaytype=\"combo\" style=\"line:0 solid #808080 ;\" text=\"bind:apprYn\" combodataset=\"ds_apprCd\" combocodecol=\"cd\" combodatacol=\"cdNm\"/><Cell row=\"2\" col=\"3\" colspan=\"3\" style=\"align:right middle;padding:0 10 0 10;line:0 none #808080ff ;\" text=\"bind:reqUser\"/><Cell row=\"2\" col=\"6\" displaytype=\"button\" edittype=\"button\" style=\"align:center middle;line:0 none #808080ff ;\" text=\"승인\"/><Cell row=\"2\" col=\"7\" style=\"line:0 none;\"/><Cell row=\"3\" style=\"line:0 none;\"/><Cell row=\"3\" col=\"1\" style=\"align: ;line:0 none #808080 ;\"/><Cell row=\"3\" col=\"2\" style=\"line:0 solid #808080 ;\"/><Cell row=\"3\" col=\"3\" style=\"align: ;line:0 none #808080 ;\"/><Cell row=\"3\" col=\"4\" style=\"align: ;line:0 none #808080 ;\"/><Cell row=\"3\" col=\"5\" style=\"align: ;line:0 none #808080 ;\"/><Cell row=\"3\" col=\"6\" style=\"align:center middle;line:0 none #808080ff ;\"/><Cell row=\"3\" col=\"7\" style=\"line:0 none;\"/><Cell row=\"4\" style=\"line:0 none;\"/><Cell row=\"4\" col=\"1\" celltype=\"none\" displaytype=\"date\" style=\"padding:0 10 0 10;line:0 none #808080ff ;color:blue;color2:blue;selectcolor:blue;\" text=\"bind:creditOverEnd\"/><Cell row=\"4\" col=\"2\" displaytype=\"normal\" style=\"line:0 solid #808080 ;\" text=\"신청금액\"/><Cell row=\"4\" col=\"3\" colspan=\"3\" displaytype=\"number\" style=\"align:right middle;padding:0 10 0 10;line:0 none #808080ff ;color:red;color2:red;selectcolor:red;\" text=\"bind:creditAddAmount\"/><Cell row=\"4\" col=\"6\" celltype=\"none\" displaytype=\"button\" edittype=\"button\" style=\"align:center middle;line:0 none #808080ff ;\" text=\"반려\"/><Cell row=\"4\" col=\"7\" style=\"line:0 none;\"/><Cell row=\"5\" colspan=\"8\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "60", null, "59", "0", null, this);
            obj.set_taborder("13");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Combo("cbo_apprGubun", "absolute", "128", "66", "296", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("14");
            obj.set_value("N");
            obj.set_text("미승인");
            obj.set_displaynulltext("전체");
            obj.set_innerdataset("@ds_apprCd");
            obj.set_codecolumn("cd");
            obj.set_datacolumn("cdNm");
            obj.set_index("2");

            obj = new Button("btn_search", "absolute", null, "66", "100", "47", "10", null, this);
            obj.set_taborder("15");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_dtFrom", "absolute", "128", "7", "187", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("16");
            obj.set_dateformat("yyyy-MM-dd");

            obj = new Static("Static34", "absolute", "321", "7", "15", "47", null, null, this);
            obj.set_taborder("17");
            obj.set_text("~");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_dtTo", "absolute", "343", "7", "187", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("18");
            obj.set_dateformat("yyyy-MM-dd");

            obj = new Static("Static18", "absolute", "0", "1", "135", "59", null, null, this);
            obj.set_taborder("19");
            obj.set_text("신청일");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "0", "60", "135", "59", null, null, this);
            obj.set_taborder("20");
            obj.set_text("승인구분");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("sta_dtFrom", "absolute", "128", "7", "187", "47", null, null, this);
            obj.set_taborder("21");
            this.addChild(obj.name, obj);

            obj = new Static("sta_dtTo", "absolute", "343", "7", "187", "47", null, null, this);
            obj.set_taborder("22");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("임시여신승인");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("EmergencyLoanApp.xfdl", "lib::lib_Com.xjs");
        this.registerScript("EmergencyLoanApp.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		임시여신승인
        // [부시스템명]	임시여신승인
        // [설명]		    임시여신승인하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.02.02
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.02 : 강대성 : 수정이 필요하여 수정함.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"
        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/
        this.preDate = undefined;
        this.firstDate = undefined;
        this.savYn = undefined;
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
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정(검색)
        	this.fn_SetBtnControl("this.btn_search","");
        	
        	this.savYn = application.gds_cmnAuth.getColumn(0, "savYn")
        	
        	this.preDate = this.gfn_Today();
        	this.firstDate = this.gfn_subStr(this.preDate,0,4) + "0101";
        	this.cal_dtFrom.set_value(this.firstDate);
        	this.cal_dtTo.set_value(this.preDate);
        	//필수
        	this.fn_init();
        }

        // 데이터 초기화
        this.fn_init = function ()
        {
        	this.ds_grd.clearData();
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

        /** 
         *정렬조건 콤보 팝업 호출
         */
        this.cbo_sortList_ondropdown = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_apprCd;
        	arg[1] = "정렬조건";
        	arg[2] = "";
        	arg[3] = "cdNm";
        	application.goMain.gfn_POP_create("apprGubun", "cmmn::CmmnComboList.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
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
        	this.fn_init();    
        	
        	//필수항목 
        	if (this.fn_searchChk()) return;
        	
        	var apprGubun = this.gfn_transNullToEmpty(this.cbo_apprGubun.value);
        	
        	var strSvcID   		 = "search";
        	var strUrl     		 = "ms/mlm/emergencyLoanApp/selectList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "ds_grd=ds_list";
        	var strArguments	 = "dtFrom=" + nexacro.wrapQuote(this.cal_dtFrom.value)
        		strArguments     += " dtTo=" + nexacro.wrapQuote(this.cal_dtTo.value);
        		strArguments     += " apprGubun=" + nexacro.wrapQuote(apprGubun);
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
        	// v_ds_check 미사용시 변경사항 체크
        	if (this.gfn_getUpdate(this.ds_grd) == false) 
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "변경된 데이터가 없습니다.", "OK", true, this);
        		return;
        	}	
        	
        	this.ds_grd.setColumn(this.ds_grd.rowposition, "chkGubun", "01");  //01일경우 update를 하도록 함
        		
        	//trace("ds_grd :: " +this.ds_grd.saveXML("ds_grd", "V"));
         	
        	var strSvcID   		 = "save";
        	var strUrl     		 = "ms/mlm/emergencyLoanApp/saveList.xdo";
        	var strInDataset     = "ds_list=ds_grd:U";
        	var strOutDataset    = "ds_grd=ds_list";
        	var strArguments	 = "";
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
          	// connect the server 
        }

        /*******************************************************************************
        * 기      능   :  반려등록
        * 설      명   :  임시여신신청건 반려처리
        ********************************************************************************/
        this.fn_saveReturn = function()
        {
        	// v_ds_check 미사용시 변경사항 체크
        	if (this.gfn_getUpdate(this.ds_grd) == false) 
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "변경된 데이터가 없습니다.", "OK", true, this);
        		return;
        	}	
        	
        	var amountBef = this.ds_grd.getColumn(this.ds_grd.rowposition, "creditOverAmount");
        	var amountAft = this.ds_grd.getColumn(this.ds_grd.rowposition, "creditAddAmount");
        	var endBef = this.ds_grd.getColumn(this.ds_grd.rowposition, "creditOverEnd");
        	var endAft = this.ds_grd.getColumn(this.ds_grd.rowposition, "creditAddEnd");
        	
        	//승인시 금액이 변경됬을시(한도일도 마찬가지임) FMS_UPJANG테이블 여신 데이터를 업데이트 해주도록 함
        	//if(amountBef != amountAft || endBef != endAft)
        	//{
        	this.ds_grd.setColumn(this.ds_grd.rowposition, "chkGubun", "01");  //01일경우 update를 하도록 함
        	//}
        	
        	trace("ds_grd :: " +this.ds_grd.saveXML("ds_grd", "V"));
         	
        	var strSvcID   		 = "save";
        	var strUrl     		 = "ms/mlm/emergencyLoanApp/saveReturnList.xdo";
        	var strInDataset     = "ds_list=ds_grd:U";
        	var strOutDataset    = "ds_grd=ds_list";
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
        	var apprYn = this.ds_grd.getColumn(this.ds_grd.rowposition, "apprYn")
        	//alert(e.cell);
        	
        	if(this.savYn == "Y")
        	{
        		if(e.cell == "15")
        		{
        			if(apprYn == 'Y')
        			{
        				application.goMain.gfn_Msg("ALERT_0", "알림", "승인된건입니다.", "OK", true, this);
        				return;
        			}else if(apprYn == 'C')
        			{
        				application.goMain.gfn_Msg("ALERT_0", "알림", "반려된건입니다.", "OK", true, this);
        				return;		
        			}else{
        				
        				var arg = new Array();
        				arg[0] = this.ds_grd.getColumn(this.ds_grd.rowposition, "creditBefAmount");
        				arg[1] = this.ds_grd.getColumn(this.ds_grd.rowposition, "creditBefEnd");
        				arg[2] = this.ds_grd.getColumn(this.ds_grd.rowposition, "creditAddAmount");
        				arg[3] = this.ds_grd.getColumn(this.ds_grd.rowposition, "creditOverEnd");
        				
        				application.goMain.gfn_POP_create("appDetailReqtPop", "M_MLM::AppDetailReqtPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        			}
        			
        		}	
        		
        		if(e.cell == "29")
        		{
        			if(apprYn == 'C')
        			{
        				application.goMain.gfn_Msg("ALERT_0", "알림", "반려된건입니다.", "OK", true, this);
        				return;			
        			}else if(apprYn == 'Y')
        			{
        				application.goMain.gfn_Msg("ALERT_0", "알림", "승인된건입니다.", "OK", true, this);
        				return;		
        			}else{			
        				
        				application.goMain.gfn_POP_create("returnComment", "M_MLM::ReturnReasonReqtPop.xfdl", "fn_callbackPOP", this, "", "POP", application.goMain.divBase);
        			}
        			
        		}
        	}
        	else
        	{
        		application.goMain.gfn_Msg("", "알림", "승인 및 반려 권한이 없습니다.", "OK");
        	}
        }

        /*******************************************************************************
        * 기      능   :  그리드 길게 터치시
        * 설      명   :  그리드 길게 터치시 해당업장에 대한 승인내역을 보여준다.
        ********************************************************************************/ 
        this.grd_list_onlongpress = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_grd.getColumn(this.ds_grd.rowposition, "upjang");

        	application.goMain.gfn_POP_create("upjangHist", "M_MLM::EmergencyLoanReqtReportPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        
        this.grd_list_oncelldblclick = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_grd.getColumn(this.ds_grd.rowposition, "creditId");

        	application.goMain.gfn_POP_create("upjangHist", "M_MLM::EmergencyLoanReqtReportPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        /*******************************************************************************
        * 기      능   :  검색필수체크
        * 설      명   :  검색필수체크
        ********************************************************************************/
        this.fn_searchChk = function ()
        {
        	if ( this.gfn_isNull(this.cal_dtFrom.value) || (this.gfn_Length(this.cal_dtFrom.value)< 8) )
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "신청일(From)을 정확하게 입력하세요.", "OK", true, this);
        		return true;
        	}
        	
        	if ( this.gfn_isNull(this.cal_dtTo.value) || (this.gfn_Length(this.cal_dtTo.value)< 8) )
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "신청일(To)을 정확하게 입력하세요.", "OK", true, this);
        		return true;
        	}
        	
        	if ( this.cal_dtFrom.value > this.cal_dtTo.value )
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "시작일보다 종료일이 늦습니다.", "OK", true, this);
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
        			
        			// 조회 건수 확인  
                    if (this.ds_grd.getRowCount() == 0) 
                    {
                        application.goMain.gfn_Msg("alertTest", "Information", "조회되는 내용이 없습니다.", "OK");	//조회되는 내용이 없습니다.
                        return;
                    }
                    else // 조회건수가 1페이지 이상일때
                    {
        				this.grd_list.set_nodataimage("");	
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
        		case "PopCalFrom":
        			this.cal_dtFrom.set_value(rtn);
        			break;
        		case "PopCalTo":
        			this.cal_dtTo.set_value(rtn);
        			break;		
        		case "apprGubun":
        			this.cbo_apprGubun.set_index(rtn);
        			break;	
        		case "appDetailReqtPop":
        			//(기존현황)임시여신종료일이 없을경우 기존 임시여신(0) + 신청내역 임시여신금액을 신청금액으로 한다.	
        // 			if(application.gfn_IsNull(this.ds_grd.getColumn(this.ds_grd.rowposition, "creditBefEnd"))){
        // 				this.ds_grd.setColumn(this.ds_grd.rowposition, "creditOverAmount", nexacro.toNumber(this.ds_grd.getColumn(this.ds_grd.rowposition, "creditBefAmount")) + nexacro.toNumber(rtn[0]));	
        // 			
        // 			}else{
        				//(기존현황)임시여신종료일이 지난경우(신청일 기준) 신청내역 임시여신금액만 신청금액으로 한다.
        				//if(this.ds_grd.getColumn(this.ds_grd.rowposition, "creditBefEnd") < this.ds_grd.getColumn(this.ds_grd.rowposition, "reqDate")){
        					this.ds_grd.setColumn(this.ds_grd.rowposition, "creditOverAmount", nexacro.toNumber(rtn[0]));
        				//(기존현황)임시여신종료일이 지나지 않았을 경우(현재일 기준) 기존 임시여신 + 신청내역 임시여신금액을 신청금액으로 한다.	
        // 				}else{
        // 					this.ds_grd.setColumn(this.ds_grd.rowposition, "creditOverAmount", nexacro.toNumber(this.ds_grd.getColumn(this.ds_grd.rowposition, "creditBefAmount")) + nexacro.toNumber(rtn[0]));
        // 				}	
        // 			}
        			
        			this.ds_grd.setColumn(this.ds_grd.rowposition, "creditAddAmount", rtn[0]);
        			this.ds_grd.setColumn(this.ds_grd.rowposition, "creditAddEnd", rtn[1]);
        			this.ds_grd.setColumn(this.ds_grd.rowposition, "bigo", rtn[2]);
        			
        			this.fn_save();
        			break;
        		case "returnComment":			
        			this.ds_grd.setColumn(this.ds_grd.rowposition, "remark", rtn[0]);
        			
        			this.fn_saveReturn();
        			break;
        		case "upjangHist":
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

        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.grd_list.addEventHandler("oncellclick", this.grd_list_oncellclick, this);
            this.grd_list.addEventHandler("onslide", this.grd_list_onslide, this);
            this.grd_list.addEventHandler("onvscroll", this.grd_list_onvscroll, this);
            this.grd_list.addEventHandler("onlongpress", this.grd_list_onlongpress, this);
            this.grd_list.addEventHandler("oncelldblclick", this.grd_list_oncelldblclick, this);
            this.cbo_apprGubun.addEventHandler("ondropdown", this.cbo_sortList_ondropdown, this);
            this.btn_search.addEventHandler("onclick", this.btnSearch_onclick, this);
            this.cal_dtFrom.addEventHandler("ontouchstart", this.div_additionOrder_cal_dtTo_ontouchstart, this);
            this.cal_dtTo.addEventHandler("ontouchstart", this.div_additionOrder_cal_dtTo_ontouchstart, this);
            this.sta_dtFrom.addEventHandler("onclick", this.sta_dtFrom_onclick, this);
            this.sta_dtTo.addEventHandler("onclick", this.sta_dtTo_onclick, this);

        };

        this.loadIncludeScript("EmergencyLoanApp.xfdl", true);

       
    };
}
)();
