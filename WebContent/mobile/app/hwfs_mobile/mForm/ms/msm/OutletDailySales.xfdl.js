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
                this.set_name("OutletDailySales");
                this.set_titletext("외식매출속보");
                this._setFormPosition(0,0,540,760);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_list", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"outletBgn\" type=\"STRING\" size=\"50\"/><Column id=\"outletBgnNm\" type=\"STRING\" size=\"50\"/><Column id=\"outletGrp\" type=\"STRING\" size=\"50\"/><Column id=\"outletGrpNm\" type=\"STRING\" size=\"50\"/><Column id=\"outletSum\" type=\"STRING\" size=\"50\"/><Column id=\"outletHapNm\" type=\"STRING\" size=\"50\"/><Column id=\"outletCd\" type=\"STRING\" size=\"50\"/><Column id=\"outletNm\" type=\"STRING\" size=\"50\"/><Column id=\"picPlace\" type=\"BIGDECIMAL\" size=\"22\"/><Column id=\"todayGoal\" type=\"BIGDECIMAL\" size=\"22\"/><Column id=\"todayNet\" type=\"BIGDECIMAL\" size=\"22\"/><Column id=\"todayPer\" type=\"BIGDECIMAL\" size=\"22\"/><Column id=\"todayWeekNet\" type=\"BIGDECIMAL\" size=\"22\"/><Column id=\"todayWeekPer\" type=\"BIGDECIMAL\" size=\"22\"/><Column id=\"todayYearNet\" type=\"BIGDECIMAL\" size=\"22\"/><Column id=\"todayYearPer\" type=\"BIGDECIMAL\" size=\"22\"/><Column id=\"mtdGoalMoon\" type=\"BIGDECIMAL\" size=\"22\"/><Column id=\"mtdGoal\" type=\"BIGDECIMAL\" size=\"22\"/><Column id=\"mtdNet\" type=\"BIGDECIMAL\" size=\"22\"/><Column id=\"mtdPer\" type=\"BIGDECIMAL\" size=\"22\"/><Column id=\"mtdYearNet\" type=\"BIGDECIMAL\" size=\"22\"/><Column id=\"mtdYearPer\" type=\"BIGDECIMAL\" size=\"22\"/><Column id=\"ytdGoalYear\" type=\"BIGDECIMAL\" size=\"22\"/><Column id=\"ytdGoal\" type=\"BIGDECIMAL\" size=\"22\"/><Column id=\"ytdNet\" type=\"BIGDECIMAL\" size=\"22\"/><Column id=\"ytdPer\" type=\"BIGDECIMAL\" size=\"22\"/><Column id=\"ytdOldNet\" type=\"BIGDECIMAL\" size=\"22\"/><Column id=\"ytdOldPer\" type=\"BIGDECIMAL\" size=\"22\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_paramInfo", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"searchDt\" type=\"STRING\" size=\"256\"/><Column id=\"muCd\" type=\"STRING\" size=\"256\"/><Column id=\"tmCd\" type=\"STRING\" size=\"256\"/><Column id=\"upjangCd\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
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

            obj = new Button("btn_search", "absolute", null, "8", "100", "47", "10", null, this);
            obj.set_taborder("7");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
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
            obj.set_scrollbars("autoboth");
            obj.set_binddataset("ds_list");
            obj.set_autofittype("none");
            obj.set_scrollpixel("all");
            obj.set_autosizingtype("row");
            obj.set_extendsizetype("row");
            obj.set_nodataimage("URL('theme://Image/grd_WF_NoDataImg.png')");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"0\" band=\"left\"/><Column size=\"0\" band=\"left\"/><Column size=\"220\" band=\"left\"/><Column size=\"200\"/><Column size=\"200\"/><Column size=\"81\"/><Column size=\"200\"/><Column size=\"200\"/><Column size=\"81\"/><Column size=\"200\"/><Column size=\"200\"/><Column size=\"81\"/></Columns><Rows><Row size=\"40\" band=\"head\"/><Row size=\"39\" band=\"head\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell rowspan=\"2\" text=\"사업구분\"/><Cell col=\"1\" rowspan=\"2\" text=\"분류\"/><Cell col=\"2\" rowspan=\"2\" text=\"영업장\"/><Cell col=\"3\" colspan=\"3\" text=\"TODAY\"/><Cell col=\"6\" colspan=\"3\" text=\"MTD\"/><Cell col=\"9\" colspan=\"3\" text=\"YTD\"/><Cell row=\"1\" col=\"3\" text=\"목표\"/><Cell row=\"1\" col=\"4\" text=\"실적\"/><Cell row=\"1\" col=\"5\" text=\"%\"/><Cell row=\"1\" col=\"6\" text=\"목표\"/><Cell row=\"1\" col=\"7\" text=\"실적\"/><Cell row=\"1\" col=\"8\" text=\"%\"/><Cell row=\"1\" col=\"9\" text=\"목표\"/><Cell row=\"1\" col=\"10\" text=\"실적\"/><Cell row=\"1\" col=\"11\" text=\"%\"/></Band><Band id=\"body\"><Cell celltype=\"expr:outletCd ==&quot;ZZ&quot; ?&quot;'summary&quot;:&quot;none&quot;\" style=\"align:left middle;padding:0 5 0 5;\" text=\"bind:outletBgnNm\" wordwrap=\"none\" suppress=\"1\" autosizerow=\"limitmin\"/><Cell col=\"1\" celltype=\"expr:outletCd ==&quot;ZZ&quot; ?&quot;'summary&quot;:&quot;none&quot;\" displaytype=\"normal\" style=\"align:left middle;padding:0 5 0 5;color:EXPR(spAmt &lt; 0 ?&quot;red&quot;:&quot;&quot;);color2:EXPR(spAmt &lt; 0 ?&quot;red&quot;:&quot;&quot;);selectcolor:EXPR(spAmt &lt; 0 ?&quot;red&quot;:&quot;&quot;);\" text=\"bind:outletGrpNm\" wordwrap=\"none\" suppress=\"1\" autosizerow=\"limitmin\"/><Cell col=\"2\" celltype=\"expr:outletCd ==&quot;ZZ&quot; ?&quot;summary&quot;:&quot;none&quot;\" displaytype=\"normal\" style=\"align:left middle;padding:0 5 0 5;background:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);background2:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);color:EXPR(ssAmt &lt; 0 ?&quot;red&quot;:&quot;&quot;);color2:EXPR(ssAmt &lt; 0 ?&quot;red&quot;:&quot;&quot;);selectbackground:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);selectcolor:EXPR(ssAmt &lt; 0 ?&quot;red&quot;:&quot;&quot;);\" text=\"bind:outletNm\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell col=\"3\" celltype=\"expr:outletCd ==&quot;ZZ&quot; ?&quot;summary&quot;:&quot;none&quot;\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 5;background:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);background2:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);selectbackground:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);\" text=\"bind:todayGoal\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell col=\"4\" celltype=\"expr:outletCd ==&quot;ZZ&quot; ?&quot;summary&quot;:&quot;none&quot;\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 5;background:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);background2:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);selectbackground:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);\" text=\"bind:todayNet\" autosizerow=\"limitmin\"/><Cell col=\"5\" celltype=\"expr:outletCd ==&quot;ZZ&quot; ?&quot;summary&quot;:&quot;none&quot;\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 5;background:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);background2:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);selectbackground:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);\" text=\"bind:todayPer\" autosizerow=\"limitmin\"/><Cell col=\"6\" celltype=\"expr:outletCd ==&quot;ZZ&quot; ?&quot;summary&quot;:&quot;none&quot;\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 5;background:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);background2:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);selectbackground:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);\" text=\"bind:mtdGoal\" autosizerow=\"limitmin\"/><Cell col=\"7\" celltype=\"expr:outletCd ==&quot;ZZ&quot; ?&quot;summary&quot;:&quot;none&quot;\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 5;background:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);background2:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);selectbackground:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);\" text=\"bind:mtdNet\" autosizerow=\"limitmin\"/><Cell col=\"8\" celltype=\"expr:outletCd ==&quot;ZZ&quot; ?&quot;summary&quot;:&quot;none&quot;\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 5;background:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);background2:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);selectbackground:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);\" text=\"bind:mtdPer\" autosizerow=\"limitmin\"/><Cell col=\"9\" celltype=\"expr:outletCd ==&quot;ZZ&quot; ?&quot;summary&quot;:&quot;none&quot;\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 5;background:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);background2:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);selectbackground:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);\" text=\"bind:ytdGoal\"/><Cell col=\"10\" celltype=\"expr:outletCd ==&quot;ZZ&quot; ?&quot;summary&quot;:&quot;none&quot;\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 5;background:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);background2:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);selectbackground:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);\" text=\"bind:ytdNet\"/><Cell col=\"11\" celltype=\"expr:outletCd ==&quot;ZZ&quot; ?&quot;summary&quot;:&quot;none&quot;\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 5;background:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);background2:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);selectbackground:EXPR(outletCd ==&quot;ZZ&quot; ?&quot;lemonchiffon&quot;:&quot;&quot;);\" text=\"bind:ytdPer\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_dtFrom", "absolute", "227", "8", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("32");
            obj.set_dateformat("yyyy-MM-dd");

            obj = new Static("sta_dtFrom", "absolute", "226", "8", "195", "47", null, null, this);
            obj.set_taborder("31");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "0", "2", "135", "59", null, null, this);
            obj.set_taborder("33");
            obj.set_text("영업일자");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "60", null, "59", "0", null, this);
            obj.set_taborder("34");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static42", "absolute", "0", "60", "135", "59", null, null, this);
            obj.set_taborder("35");
            obj.set_text("팀명");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_tm", "absolute", "139", "66", null, "47", "10", null, this);
            obj.set_taborder("36");
            obj.set_readonly("true");
            this.addChild(obj.name, obj);

            obj = new Button("btn_tm", "absolute", null, "66", "47", "47", "10", null, this);
            obj.set_taborder("37");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "0", "118", null, "59", "0", null, this);
            obj.set_taborder("38");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "0", "118", "135", "59", null, null, this);
            obj.set_taborder("39");
            obj.set_text("사업장");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_upjang", "absolute", "139", "124", null, "47", "10", null, this);
            obj.set_taborder("40");
            obj.set_readonly("true");
            this.addChild(obj.name, obj);

            obj = new Button("btn_upjang", "absolute", null, "124", "47", "47", "10", null, this);
            obj.set_taborder("41");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("외식매출속보");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("OutletDailySales.xfdl", "lib::lib_Com.xjs");
        this.registerScript("OutletDailySales.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		외식사업부 영업속보
        // [부시스템명]	외식사업부 영업속보 - 조회
        // [설명]
        // 		외식사업부 영업속보 검색.
        // [작성자명] 		강대성
        // [작성일자]		2015.11.17
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.11.17 : 강대성 : 수정이 필요하여 수정함.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*======================================================
         전역변수
         ======================================================*/
        this.preDate = undefined;
        this.fv_totalpageRow = undefined;
        this.tmCd = undefined;
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
        	this.fn_SetAuth("this.edt_upjang", "this.btn_upjang");	
        	
        	//날짜 세팅(해당월의 1일 ~ 현재일) 
        	this.preDate = this.gfn_Today();
        	this.cal_dtFrom.set_value(this.preDate);
        			
        	//팀 및 업장 세팅
        	this.edt_tm.set_value(application.g_Tm_Nm);
        	this.edt_upjang.set_value(application.g_UpjangNm);
        	this.tmCd = application.g_Tm_Cd;
        	this.upjang = application.g_Upjang;	
        	
        }

        // 달력 클릭 시(From)
        this.sta_dtFrom_onclick = function(obj,e)
        {
        	var objCalArg = this.cal_dtFrom.value;
        	
        	application.goMain.gfn_POP_create("PopCalFrom", "cmmn::CmmnCalendarPop.xfdl", "fn_callbackPOP", this, objCalArg, "POP", application.goMain.divBase);
        	return false;
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
         * 사업장 검색 팝업 호출
         */
        this.btn_upjang_onclick = function(obj,e)
        {
        	var arg = new Array();
        	if(application.g_AuthLevel == "999" || application.g_AuthLevel == "99")
        	{
        		arg[4] = "OutletUpjang";
        		arg[9] = "exception";
        		arg[10] = "AND A.MU_CD IN ('2003') AND A.TM_CD LIKE '%' || '" + this.gfn_Nvl(this.tmCd ,"") + "' || '%'";		
        	}
        	else
        	{
        		arg[4] = "OutletUpjang";
        		arg[5] = application.g_AuthLevel;
        		arg[6] = application.g_EmpNo;
        		arg[7] = application.g_Tm_Cd;
        		arg[8] = application.g_Mu_Cd;
        		arg[9] = "default";
        	}	
        	
        	application.goMain.gfn_POP_create("upjangNm", "M_MLM::WorkplaceSearchPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
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
        	//필수항목 
        	if (this.fn_searchChk()) return;	
        	
        	// Grid sort 표시 초기화(필수)
            this.ds_list.clearData();
        	
        	this.ds_paramInfo.clearData();
        	var nIdx = this.ds_paramInfo.addRow();
        	this.ds_paramInfo.setColumn(nIdx, "searchDt", this.gfn_Nvl(this.cal_dtFrom.value,""));
        	this.ds_paramInfo.setColumn(nIdx, "muCd", this.gfn_Nvl("2003",""));
        	this.ds_paramInfo.setColumn(nIdx, "tmCd", this.gfn_Nvl(this.tmCd ,""));
        	this.ds_paramInfo.setColumn(nIdx, "upjangCd", this.gfn_Nvl(this.upjang ,""));
        	
        	var strSvcID   		 = "search";
        	var strUrl     		 = "rc/sle/outletDailySales/selectList.xdo";
        	var strInDataset     = "ds_paramInfo=ds_paramInfo";
        	var strOutDataset    = "ds_list=ds_list";
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
        	if ( this.gfn_isNull(this.cal_dtFrom.value))
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "입고일(From)을 정확하게 입력하세요.", "OK", true, this);
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
        		case "PopCalFrom":
        			this.cal_dtFrom.set_value(rtn);
        			break;	
        		case "tmNm":
        			this.edt_tm.set_value(rtn[1]);
        			this.tmCd = rtn[0];
        			break;
        		case "upjangNm":
        			this.edt_upjang.set_value(rtn[1]);
        			this.upjang = rtn[0];			
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

        this.edt_tm_ontouchend = function(obj,e)
        {
        	this.edt_tm.set_value("");
        	this.tmCd = "";
        }

        this.edt_upjang_ontouchend = function(obj,e)
        {
        	this.edt_upjang.set_value("");
        	this.upjang = "";
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.btn_search.addEventHandler("onclick", this.btnSearch_onclick, this);
            this.grd_list.addEventHandler("onvscroll", this.grd_list_onvscroll, this);
            this.grd_list.addEventHandler("onslide", this.grd_list_onslide, this);
            this.grd_list.addEventHandler("ondropdown", this.grd_list_ondropdown, this);
            this.cal_dtFrom.addEventHandler("ontouchstart", this.div_additionOrder_cal_dtTo_ontouchstart, this);
            this.sta_dtFrom.addEventHandler("onclick", this.sta_dtFrom_onclick, this);
            this.edt_tm.addEventHandler("ontouchend", this.edt_tm_ontouchend, this);
            this.btn_tm.addEventHandler("onclick", this.edt_dept_onclick, this);
            this.edt_upjang.addEventHandler("ontouchend", this.edt_upjang_ontouchend, this);
            this.btn_upjang.addEventHandler("onclick", this.btn_upjang_onclick, this);

        };

        this.loadIncludeScript("OutletDailySales.xfdl", true);

       
    };
}
)();
