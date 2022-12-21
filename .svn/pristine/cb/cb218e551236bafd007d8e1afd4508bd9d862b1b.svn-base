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
                this.set_name("FoodReservesReport");
                this.set_titletext("식재료비현황");
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
            obj._setContents("<ColumnInfo><Column id=\"baseDd\" type=\"STRING\" size=\"256\"/><Column id=\"weekName\" type=\"STRING\" size=\"256\"/><Column id=\"spAmt\" type=\"STRING\" size=\"256\"/><Column id=\"srAmt\" type=\"STRING\" size=\"256\"/><Column id=\"ssAmt\" type=\"STRING\" size=\"256\"/><Column id=\"mpAmt\" type=\"STRING\" size=\"256\"/><Column id=\"mrAmt\" type=\"STRING\" size=\"256\"/><Column id=\"msAmt\" type=\"STRING\" size=\"256\"/><Column id=\"pRate\" type=\"STRING\" size=\"256\"/><Column id=\"rRate\" type=\"STRING\" size=\"256\"/><Column id=\"sRate\" type=\"STRING\" size=\"256\"/><Column id=\"sdpVal\" type=\"STRING\" size=\"256\"/><Column id=\"sdpRate\" type=\"STRING\" size=\"256\"/><Column id=\"sdrVal\" type=\"STRING\" size=\"256\"/><Column id=\"sdrRate\" type=\"STRING\" size=\"256\"/><Column id=\"mdpVal\" type=\"STRING\" size=\"256\"/><Column id=\"mdpRate\" type=\"STRING\" size=\"256\"/><Column id=\"mdrVal\" type=\"STRING\" size=\"256\"/><Column id=\"mdrRate\" type=\"STRING\" size=\"256\"/><Column id=\"rdpRate\" type=\"STRING\" size=\"256\"/><Column id=\"rdrRate\" type=\"STRING\" size=\"256\"/><Column id=\"ipRate\" type=\"STRING\" size=\"256\"/><Column id=\"isRate\" type=\"STRING\" size=\"256\"/><Column id=\"idpRate\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
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
            obj._setContents("<ColumnInfo><Column id=\"sumPRate\" type=\"STRING\" size=\"256\"/><Column id=\"sumSRate\" type=\"STRING\" size=\"256\"/><Column id=\"sumMdpRate\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
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

            obj = new Grid("grd_list01", "absolute", "10", "244", null, null, "10", "0", this);
            obj.set_taborder("23");
            obj.set_scrollbars("autovert");
            obj.set_binddataset("ds_grd01");
            obj.set_autofittype("col");
            obj.set_scrollpixel("all");
            obj.set_nodataimage("URL('theme://Image/grd_WF_NoDataImg.png')");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"163\"/><Column size=\"121\"/><Column size=\"120\"/><Column size=\"118\"/></Columns><Rows><Row size=\"55\" band=\"head\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"일자\"/><Cell col=\"1\" text=\"계획(%)\"/><Cell col=\"2\" text=\"실적(%)\"/><Cell col=\"3\" text=\"비(%)\"/></Band><Band id=\"body\"><Cell displaytype=\"date\" style=\"align:center middle;padding:0 10 0 10;color:EXPR(weekName=='토'?'blue':weekName=='일'?'red':'');color2:EXPR(weekName=='토'?'blue':weekName=='일'?'red':'');selectcolor:EXPR(weekName=='토'?'blue':weekName=='일'?'red':'');\" text=\"bind:baseDd\"/><Cell col=\"1\" displaytype=\"number\" style=\"align:right;padding:0 5 0 5;color:EXPR(pRate &lt; 0 ?&quot;red&quot;:&quot;&quot;);color2:EXPR(pRate &lt; 0 ?&quot;red&quot;:&quot;&quot;);selectcolor:EXPR(pRate &lt; 0 ?&quot;red&quot;:&quot;&quot;);\" text=\"bind:pRate\" mask=\"#,##0.0\"/><Cell col=\"2\" displaytype=\"number\" style=\"align:right;padding:0 5 0 5;color:EXPR(sRate &lt; 0 ?&quot;red&quot;:&quot;&quot;);color2:EXPR(sRate &lt; 0 ?&quot;red&quot;:&quot;&quot;);selectcolor:EXPR(sRate &lt; 0 ?&quot;red&quot;:&quot;&quot;);\" text=\"bind:sRate\" mask=\"#,##0.0\"/><Cell col=\"3\" displaytype=\"number\" style=\"align:right;padding:0 5 0 5;\" text=\"bind:rdpRate\" mask=\"#,##0.0\"/></Band></Format></Formats>");
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
            obj.set_value("null");
            obj.set_dateformat("yyyy-MM-dd");

            obj = new Calendar("cal_dtTo", "absolute", "225", "66", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("28");
            obj.set_value("null");
            obj.set_dateformat("yyyy-MM-dd");

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

            obj = new Static("Static01", "absolute", "0", "234", "540", "10", null, null, this);
            obj.set_taborder("33");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list00", "absolute", "10", "128", null, "106", "10", null, this);
            obj.set_taborder("34");
            obj.set_binddataset("ds_grd00");
            obj.set_scrollbars("none");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"173\"/><Column size=\"164\"/><Column size=\"182\"/></Columns><Rows><Row size=\"55\" band=\"head\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"계획 합계\"/><Cell col=\"1\" text=\"실적 합계\"/><Cell col=\"2\" text=\"비 합계\"/></Band><Band id=\"body\"><Cell displaytype=\"number\" style=\"align:right middle;padding:0 10 0 10;color:EXPR(sumPRate &lt; 0 ?&quot;red&quot;:&quot;&quot;);color2:EXPR(sumPRate &lt; 0 ?&quot;red&quot;:&quot;&quot;);selectcolor:EXPR(sumPRate &lt; 0 ?&quot;red&quot;:&quot;&quot;);\" text=\"bind:sumPRate\" mask=\"#,##0.0\"/><Cell col=\"1\" displaytype=\"number\" style=\"align:right middle;padding:0 10 0 10;color:EXPR(sumSRate &lt; 0 ?&quot;red&quot;:&quot;&quot;);color2:EXPR(sumSRate &lt; 0 ?&quot;red&quot;:&quot;&quot;);selectcolor:EXPR(sumSRate &lt; 0 ?&quot;red&quot;:&quot;&quot;);\" text=\"bind:sumSRate\" mask=\"#,##0.0\"/><Cell col=\"2\" displaytype=\"number\" style=\"align:right middle;padding:0 10 0 10;selectcolor: ;\" text=\"bind:sumMdpRate\" mask=\"#,##0.0\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("sta_dtFrom", "absolute", "10", "66", "196", "47", null, null, this);
            obj.set_taborder("35");
            this.addChild(obj.name, obj);

            obj = new Static("sta_dtTo", "absolute", "225", "66", "196", "47", null, null, this);
            obj.set_taborder("36");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("식재료비현황");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("FoodReservesReport.xfdl", "lib::lib_Com.xjs");
        this.registerScript("FoodReservesReport.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		식재료비현황
        // [부시스템명]	식재료비현황 - 조회
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
        this.firstDate = undefined;
        this.fv_totalpageRow;	// 전체건수
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
        	this.fn_SetAuth("this.edt_upjang", "this.btn_upjang");
        	
        	//현재월의 1日 ~ 현재일 
        	this.preDate = this.gfn_Today();
        	this.firstDate = this.gfn_subStr(this.preDate,0,6) + "01";
        	
        	this.cal_dtFrom.set_value(this.firstDate);
        	this.cal_dtTo.set_value(this.preDate);
        	
        	//업장 세팅
        	this.edt_upjang.set_value(application.g_UpjangNm);	
        	this.upjang = application.g_Upjang;	
        	
        }

        /** 
         * 사업장 검색 팝업 호출
         */
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
        	this.ds_grd00.clearData();
        	this.ds_grd01.clearData();
        	
        	//필수항목 
        	if (this.fn_searchChk()) return;
        	
        	// 서비스 연결 됐을때 아래 로직으로..
        	var strSvcID   		 = "foodReservesReport";
        	var strUrl     		 = "ms/mim/foodReservesReport/selectList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "ds_grd01=ds_list";
        	var strArguments	 = "upjang=" + nexacro.wrapQuote(this.upjang);
        	   strArguments     += " startDate=" + nexacro.wrapQuote(this.cal_dtFrom.value);	
        	   strArguments     += " endDate=" + nexacro.wrapQuote(this.cal_dtTo.value);   
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
        		//식재료비현황조회
                case "foodReservesReport" :
        			// TODO parameter로 전체건수를 받는다.
        			this.fv_totalpageRow = this.ds_grd01.getRowCount();
        			
                    // 조회 건수 확인  
                    if (this.ds_grd01.getRowCount() == 0) 
                    {
                        application.goMain.gfn_Msg("alertTest", "Information", "조회되는 내용이 없습니다.", "OK");	//조회되는 내용이 없습니다.
                        return;
                    }
                    else // 조회건수가 1페이지 이상일때
                    {
        				
        				var sumPRate = this.fn_clearNaN(nexacro.round(this.ds_grd01.getSum("mpAmt")/this.ds_grd01.getSum("spAmt")*100,1));
        				var sumSRate = this.fn_clearNaN(nexacro.round(this.ds_grd01.getSum("msAmt")/this.ds_grd01.getSum("ssAmt")*100,1));
        				
        				var sumMdpRate = nexacro.toNumber(sumPRate) - nexacro.toNumber(sumSRate);
        				
        				var sumMdpRateFormat = "";
        				
        				//계획비/전년비: 비교값 표기 시는 무조건 검은색, 양수는 (+)부호, 음수는(△)표시				
        				if(sumMdpRate > 0)
        				{
        					sumMdpRateFormat = "+" + sumMdpRate; 
        				}
        				else if(sumMdpRate < 0)
        				{
        					var sumMdpRateString = new String(sumMdpRate);

        					sumMdpRateFormat = "△" + sumMdpRateString.replace("-","");
        				}				
        				
        				var nRow = this.ds_grd00.addRow()
        				this.ds_grd00.setColumn(nRow, "sumPRate", sumPRate);   //계획합계
        			    this.ds_grd00.setColumn(nRow, "sumSRate", sumSRate);   //실적합계
        				this.ds_grd00.setColumn(nRow, "sumMdpRate", sumMdpRateFormat); //비합계
        				
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
        			this.upjang = rtn[0];			
        			//this.fn_search();
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
        		if (this.ds_grd01.getRowCount() > 0)
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
        	this.grd_list01.vscrollbar.set_pos(0);
        }
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.btn_upjang.addEventHandler("onclick", this.btn_upjang_onclick, this);
            this.grd_list01.addEventHandler("onslide", this.grd_list_onslide, this);
            this.grd_list01.addEventHandler("onvscroll", this.grd_list_onvscroll, this);
            this.btn_search.addEventHandler("onclick", this.btnSearch_onclick, this);
            this.cal_dtFrom.addEventHandler("ondropdown", this.cal_dtFrom_ondropdown, this);
            this.cal_dtFrom.addEventHandler("ontouchstart", this.div_additionOrder_cal_dtTo_ontouchstart, this);
            this.cal_dtTo.addEventHandler("ontouchstart", this.div_additionOrder_cal_dtTo_ontouchstart, this);
            this.cal_dtTo.addEventHandler("ondropdown", this.cal_dtTo_ondropdown, this);
            this.sta_dtFrom.addEventHandler("onclick", this.sta_dtFrom_onclick, this);
            this.sta_dtTo.addEventHandler("onclick", this.sta_dtTo_onclick, this);

        };

        this.loadIncludeScript("FoodReservesReport.xfdl", true);

       
    };
}
)();
