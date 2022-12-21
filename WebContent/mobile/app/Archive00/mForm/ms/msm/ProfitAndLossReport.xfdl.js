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
                this.set_name("SalesReport");
                this.set_titletext("손익현황");
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
            obj._setContents("<ColumnInfo><Column id=\"upjang\" type=\"STRING\" size=\"256\"/><Column id=\"upjangnm\" type=\"STRING\" size=\"256\"/><Column id=\"ssAmt\" type=\"STRING\" size=\"256\"/><Column id=\"msAmt\" type=\"STRING\" size=\"256\"/><Column id=\"ssAmtFormat\" type=\"STRING\" size=\"256\"/><Column id=\"msAmtFormat\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_sortListCd", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"256\"/><Column id=\"cdNm\" type=\"STRING\" size=\"256\"/><Column id=\"sortCol\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"cd\">01</Col><Col id=\"cdNm\">업장명</Col><Col id=\"sortCol\">upjangnm</Col></Row><Row><Col id=\"cd\">02</Col><Col id=\"cdNm\">매출액</Col><Col id=\"sortCol\">ssAmt</Col></Row><Row><Col id=\"cd\">03</Col><Col id=\"cdNm\">재료비</Col><Col id=\"sortCol\">msAmt</Col></Row></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_unitCd", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"256\"/><Column id=\"cdNm\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"cd\">1</Col><Col id=\"cdNm\">원</Col></Row><Row><Col id=\"cd\">1000</Col><Col id=\"cdNm\">천원</Col></Row></Rows>");
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

            obj = new Static("Static37", "absolute", "0", "60", null, "59", "0", null, this);
            obj.set_taborder("2");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_tm", "absolute", "139", "8", null, "47", "10", null, this);
            obj.set_taborder("4");
            obj.set_readonly("true");
            this.addChild(obj.name, obj);

            obj = new Static("Static39", "absolute", "0", "118", null, "59", "0", null, this);
            obj.set_taborder("5");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Button("btn_search", "absolute", null, "66", "100", "47", "10", null, this);
            obj.set_taborder("7");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Static("Static42", "absolute", "0", "2", "135", "59", null, null, this);
            obj.set_taborder("8");
            obj.set_text("팀명");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static43", "absolute", "119", "15", "20", "89", null, null, this);
            obj.set_taborder("9");
            obj.set_text("글자사이간격w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Button("btn_tm", "absolute", null, "8", "47", "47", "10", null, this);
            obj.set_taborder("10");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);

            obj = new Combo("cbo_sortList", "absolute", "10", "124", "180", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("11");
            obj.set_displaynulltext("정렬조건");
            obj.set_innerdataset("@ds_sortListCd");
            obj.set_codecolumn("cd");
            obj.set_datacolumn("cdNm");

            obj = new Button("btn_upSort", "absolute", "257", "124", "47", "47", null, null, this);
            obj.set_taborder("12");
            obj.set_cssclass("btn_WF_UpMove");
            this.addChild(obj.name, obj);

            obj = new Button("btn_downSort", "absolute", "205", "124", "47", "47", null, null, this);
            obj.set_taborder("13");
            obj.set_cssclass("btn_WF_DownMove");
            this.addChild(obj.name, obj);

            obj = new CheckBox("chk_team", "absolute", null, "124", "73", "47", "154", null, this);
            obj.set_taborder("14");
            obj.set_text("팀");
            obj.set_value("true");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "190", "133", "15", "29", null, null, this);
            obj.set_taborder("16");
            obj.set_text("w15");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "252", "133", "5", "29", null, null, this);
            obj.set_taborder("17");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "177", "540", "10", null, null, this);
            obj.set_taborder("19");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "187", "10", "538", null, null, this);
            obj.set_taborder("20");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "530", "187", "10", "538", null, null, this);
            obj.set_taborder("21");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list", "absolute", "10", "187", null, null, "10", "0", this);
            obj.set_taborder("23");
            obj.set_scrollbars("autovert");
            obj.set_binddataset("ds_grd");
            obj.set_autofittype("col");
            obj.set_scrollpixel("all");
            obj.set_nodataimage("URL('theme://Image/grd_WF_NoDataImg.png')");
            obj.set_autosizingtype("row");
            obj.set_extendsizetype("row");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"144\"/><Column size=\"180\"/><Column size=\"196\"/></Columns><Rows><Row size=\"55\" band=\"head\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"업장명\"/><Cell col=\"1\" text=\"매출액(계획비)\"/><Cell col=\"2\" text=\"식재료율(계획비)\"/></Band><Band id=\"body\"><Cell style=\"align:left middle;padding:0 5 0 5;\" text=\"bind:upjangnm\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell col=\"1\" style=\"align:right middle;padding:0 5 0 5;color:EXPR(ssAmt &lt; 0 ?&quot;red&quot;:&quot;&quot;);color2:EXPR(ssAmt &lt; 0 ?&quot;red&quot;:&quot;&quot;);selectcolor:EXPR(ssAmt &lt; 0 ?&quot;red&quot;:&quot;&quot;);\" text=\"bind:ssAmtFormat\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell col=\"2\" style=\"align:right middle;padding:0 5 0 5;color:EXPR(msAmt &lt; 0 ?&quot;red&quot;:&quot;&quot;);color2:EXPR(msAmt &lt; 0 ?&quot;red&quot;:&quot;&quot;);selectcolor:EXPR(msAmt &lt; 0 ?&quot;red&quot;:&quot;&quot;);\" text=\"bind:msAmtFormat\" wordwrap=\"char\" autosizerow=\"limitmin\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_dtFrom", "absolute", "10", "66", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("24");
            obj.set_dateformat("yyyy-MM-dd");

            obj = new Static("Static34", "absolute", "210", "66", "15", "47", null, null, this);
            obj.set_taborder("25");
            obj.set_text("~");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_dtTo", "absolute", "225", "66", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("26");
            obj.set_dateformat("yyyy-MM-dd");

            obj = new Static("Static03", "absolute", null, "133", "18", "29", "144", null, this);
            obj.set_taborder("27");
            obj.set_text("w18");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Combo("cbo_unit", "absolute", "389", "124", "140", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("28");
            obj.set_displaynulltext("단위");
            obj.set_innerdataset("@ds_unitCd");
            obj.set_codecolumn("cd");
            obj.set_datacolumn("cdNm");
            obj.set_index("-1");

            obj = new Static("sta_dtFrom", "absolute", "10", "66", "195", "47", null, null, this);
            obj.set_taborder("29");
            this.addChild(obj.name, obj);

            obj = new Static("sta_dtTo", "absolute", "225", "66", "195", "47", null, null, this);
            obj.set_taborder("30");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("손익현황");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("ProfitAndLossReport.xfdl", "lib::lib_Com.xjs");
        this.registerScript("ProfitAndLossReport.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		매출현황
        // [부시스템명]	매출현황 - 조회
        // [설명]
        // 		부서 검색하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.02.04
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.04 : 강대성 : 수정이 필요하여 수정함.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*======================================================
         전역변수
         ======================================================*/
        this.preDate = undefined;
        this.fv_totalpageRow = undefined;
        this.tmCd = undefined;
        this.unitIndex = 0;
        this.unitCd = undefined;
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
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetBtnControl("this.btn_search","");	
        	
        	// 권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetAuth("this.edt_tm", "this.btn_tm");
        	
        	//날짜 세팅(해당월의 1일 ~ 현재일) 
        	this.preDate = this.gfn_Today();
        	this.firstDate = this.gfn_subStr(this.preDate,0,6) + "01";
        	
        	this.cal_dtFrom.set_value(this.firstDate);
        	this.cal_dtTo.set_value(this.preDate);
        	
        	this.edt_tm.set_value(application.g_Tm_Nm);
        	this.tmCd = application.g_Tm_Cd;
        	this.upjang = application.g_Upjang;	
        	
        	//첫번쨰 index로 세팅
        	this.unitCd = this.ds_unitCd.getColumn(this.unitIndex, "cd");
        	this.cbo_unit.set_text(this.ds_unitCd.getColumn(this.unitIndex, "cdNm"));	
        }

        /** 
         * 팀 검색 팝업 호출
         */
        this.edt_dept_onclick = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.edt_tm.value;
        	
        	application.goMain.gfn_POP_create("tmNm", "M_MSM::DeptSearchPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        /** 
         * 팀검색 박스 터치시 팀코드, 명 초기화
         */
        this.edt_tm_ontouchend = function(obj,e)
        {
        	this.tmCd = this.fn_SetAuth2("", "this.edt_tm");	
        }

        /** 
         *정렬조건 콤보 팝업 호출
         */
        this.cbo_sortList_ondropdown = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_sortListCd;
        	arg[1] = "정렬조건";
        	arg[2] = "";
        	arg[3] = "cdNm";
        	application.goMain.gfn_POP_create("sortList", "cmmn::CmmnComboList.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        // 내림차순 정렬
        this.btn_downSort_onclick = function(obj,e)
        {
        	this.ds_grd.set_keystring("");
        	var sSortCOl = this.ds_sortListCd.getColumn(this.cbo_sortList.index, "sortCol");
        	this.ds_grd.set_keystring("S:+"+sSortCOl);
        }

        // 오름차순 정렬
        this.btn_upSort_onclick = function(obj,e)
        {
        	this.ds_grd.set_keystring("");
        	var sSortCOl = this.ds_sortListCd.getColumn(this.cbo_sortList.index, "sortCol");
        	this.ds_grd.set_keystring("S:-"+sSortCOl);
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
         * 단위 콤보 팝업 호출
         */
        this.cbo_unit_ondropdown = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_unitCd;
        	arg[1] = "단위";
        	arg[2] = "";
        	arg[3] = "cdNm";
        	application.goMain.gfn_POP_create("unit", "cmmn::CmmnComboList.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
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
        	this.ds_grd.set_keystring("");
        	
        	//필수항목 
        	if (this.fn_searchChk()) return;
        	
        	// 권한에 따른 버튼 활성화 및 디폴트값 설정	
        	this.upjang = this.fn_SetAuth2("this.upjang", "")
        	
        	this.unitCd = this.ds_unitCd.getColumn(this.unitIndex, "cd");
        	
        	var muCd = "";
        	
        	if(application.g_AuthLevel == "999" || application.g_AuthLevel == "99")
        	{
        		muCd = "";
        	}
        	else
        	{
        		muCd = application.g_Mu_Cd;
        	}
        	
        	var strSvcID   		 = "search";
        	var strUrl     		 = "ms/msm/profitAndLossReport/selectList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "ds_grd=ds_list";
        	var strArguments	 = "tmCd=" + nexacro.wrapQuote(this.tmCd);
        	   strArguments     += " startDate=" + nexacro.wrapQuote(this.cal_dtFrom.value);	
        	   strArguments     += " endDate=" + nexacro.wrapQuote(this.cal_dtTo.value);   
        	   strArguments     += " muCd=" + nexacro.wrapQuote(muCd);	
        	   strArguments     += " unit=" + nexacro.wrapQuote(this.unitCd);
        	   strArguments     += " upjang=" + nexacro.wrapQuote(this.upjang);
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
        	
        	if ( this.gfn_subStr(this.cal_dtFrom.value,0,6)!= this.gfn_subStr(this.cal_dtTo.value,0,6))
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "기간은 동일월에 한하여 조회가능합니다.", "OK", true, this);
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
        		//매출현황조회
                case "search" :
        			// TODO parameter로 전체건수를 받는다.
        			this.fv_totalpageRow = this.ds_grd.getRowCount();
        			
                    // 조회 건수 확인  
                    if (this.ds_grd.getRowCount() == 0) 
                    {
                        application.goMain.gfn_Msg("alertTest", "Information", "조회되는 내용이 없습니다.", "OK");	//조회되는 내용이 없습니다.
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
        		case "tmNm":
        			this.edt_tm.set_value(rtn[1]);
        			this.tmCd = rtn[0];
        			break;
        		case "sortList":
        			this.cbo_sortList.set_index(rtn);
        			break;
        		case "PopCalFrom":
        			this.cal_dtFrom.set_value(rtn);
        			break;
        		case "PopCalTo":
        			this.cal_dtTo.set_value(rtn);
        			break;	
        		case "unit":
        			this.cbo_unit.set_index(rtn);
        			this.unitIndex = rtn;
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
            this.edt_tm.addEventHandler("ontouchend", this.edt_tm_ontouchend, this);
            this.btn_search.addEventHandler("onclick", this.btnSearch_onclick, this);
            this.btn_tm.addEventHandler("onclick", this.edt_dept_onclick, this);
            this.cbo_sortList.addEventHandler("ondropdown", this.cbo_sortList_ondropdown, this);
            this.btn_upSort.addEventHandler("onclick", this.btn_upSort_onclick, this);
            this.btn_downSort.addEventHandler("onclick", this.btn_downSort_onclick, this);
            this.grd_list.addEventHandler("onslide", this.grd_list_onslide, this);
            this.grd_list.addEventHandler("onvscroll", this.grd_list_onvscroll, this);
            this.cal_dtFrom.addEventHandler("ontouchstart", this.div_additionOrder_cal_dtTo_ontouchstart, this);
            this.cal_dtTo.addEventHandler("ontouchstart", this.div_additionOrder_cal_dtTo_ontouchstart, this);
            this.cbo_unit.addEventHandler("ondropdown", this.cbo_unit_ondropdown, this);
            this.sta_dtFrom.addEventHandler("onclick", this.sta_dtFrom_onclick, this);
            this.sta_dtTo.addEventHandler("onclick", this.sta_dtTo_onclick, this);

        };

        this.loadIncludeScript("ProfitAndLossReport.xfdl", true);

       
    };
}
)();
