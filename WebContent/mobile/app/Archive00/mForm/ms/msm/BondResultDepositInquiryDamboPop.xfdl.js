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
                this.set_name("BondResultDepositInquiryDamboPop");
                this.set_titletext("담보현황");
                this.set_scrollbars("none");
                this.set_enable("true");
                this._setFormPosition(0,0,520,539);
            }
            this.getSetter("inheritanceid").set("");

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_main", this);
            obj._setContents("");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_input", this);
            obj._setContents("<ColumnInfo><Column id=\"UPJANG\" size=\"256\" type=\"STRING\"/></ColumnInfo><Rows><Row><Col id=\"UPJANG\"/></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "520", "538", null, null, this);
            obj.set_taborder("20");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "0", "520", "70", null, null, this);
            obj.set_taborder("7");
            obj.set_cssclass("sta_POP_TitleBg");
            obj.set_text("담보현황");
            this.addChild(obj.name, obj);

            obj = new Button("btnClose", "absolute", null, "0", "70", "70", "0", null, this);
            obj.set_taborder("6");
            obj.set_cssclass("btn_POP_XBtn");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "442", "528", "102", "10", null, null, this);
            obj.set_taborder("9");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("right middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "0", "428", "10", "100", null, null, this);
            obj.set_taborder("10");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("left bottom");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "510", "436", "10", "100", null, null, this);
            obj.set_taborder("11");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("left bottom");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "29.23%", "80", null, "84", "26.92%", null, this);
            obj.set_taborder("12");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "70", null, "2", "0", null, this);
            obj.set_taborder("13");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list", "absolute", "10", "81", null, null, "10", "11", this);
            obj.set_taborder("21");
            obj.set_binddataset("ds_main");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_autofittype("col");
            obj.set_nodataimage("URL('theme://Image/grd_WF_NoDataImg.png')");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"115\"/><Column size=\"130\"/><Column size=\"130\"/><Column size=\"125\"/></Columns><Rows><Row size=\"55\" band=\"head\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"담보구분\"/><Cell col=\"1\" text=\"설정일자\"/><Cell col=\"2\" text=\"만기일자\"/><Cell col=\"3\" text=\"담보금액\"/></Band><Band id=\"body\"><Cell displaytype=\"normal\" style=\"align:center middle;padding:0 10 0 10;\" text=\"bind:GUBUN\"/><Cell col=\"1\" displaytype=\"normal\" style=\"align:center middle;padding:0 5 0 5;\" text=\"bind:SETUP_DATE\"/><Cell col=\"2\" displaytype=\"normal\" style=\"align:center middle;padding:0 5 0 5;\" text=\"bind:EXPIRE_DATE\"/><Cell col=\"3\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 5;\" text=\"bind:SECURE_AMT\" wordwrap=\"char\" mask=\"#,##0\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 520, 539, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frmCalendar");
            		p.getSetter("inheritanceid").set("");
            		p.set_titletext("담보현황");
            		p.set_scrollbars("none");
            		p.set_enable("true");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("BondResultDepositInquiryDamboPop.xfdl", "lib::lib_Com.xjs");
        this.registerScript("BondResultDepositInquiryDamboPop.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		담보현황팝업
        // [부시스템명]	담보현황팝업
        // [설명]		    담보현황팝업.
        // [작성자명] 		강대성
        // [작성일자]		2015.07.31
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.05.26 : 강대성 : 담보현황팝업 신규
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"
        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/
        this.preDate = undefined;
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

        // 데이터 초기화
        this.fn_init = function ()
        {
        	this.fsp_init();
        	
        	this.arg = application.goMain.gfn_POP_getArg();
        	
        	this.upjang = this.arg[0];	
        	
        	this.fn_search();
        	
        	application.goMain.gfn_POP_resize(this);
        }

        /*******************************************************************************
        * 기      능   :  검색
        * 설      명   :  등록
        ********************************************************************************/
        this.fn_search = function()
        {
        	// 초기화
        	this.ds_main.clearData();
        	this.ds_input.clearData();
        	var nRow = this.ds_input.addRow();
        	this.ds_input.setColumn(nRow, "UPJANG", this.upjang);
        	
        	// 조회
        	var actionName, cmdName, inData, outData, otherArg, callBackFnc;
        	
        	inData			= "ds_input=ds_input";
        	outData			= "ds_main=ds_main";
        	callBackFnc		= "fn_afterSearch";

        	this.fsp_clear(); 
        	this.fsp_addSearch("fm/fms:FMS00510V_S001", false);	
        	
            this.fsp_callService(this, actionName, cmdName, inData, outData, otherArg, callBackFnc);		// 서비스 호출 
        	
        }

        /*----------------------------------------------------------------------------------------------
         * 설명      : 트랜잭션 콜백 함수 (필수)
         *---------------------------------------------------------------------------------------------*/
        this.fn_afterSearch = function (errCode,errMsg)
        {
        	if(errCode!=0)
        	{
        		application.goMain.gfn_Msg("alertTest", "서비스 오류:시스템 관리자에게 문의하십시오.\n"+errMsg, "OK");
        		return;
        	}
        	else
        	{
        		if (this.ds_main.rowcount <= 0) application.goMain.gfn_Msg("ALERT_0", "Information", "조회되는 내용이 없습니다.", "OK", true, this);	//조회되는 내용이 없습니다.
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
        		application.goMain.gfn_POP_close(this, "CLOSEONLY");
        	}
        }

        
        //상단 x 버튼 클릭 시
        this.btnClose_onclick = function(obj,e)
        {
        	application.goMain.gfn_POP_close(this , this.preDate);
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);
            this.Static05.addEventHandler("onclick", this.Static05_onclick, this);
            this.grd_list.addEventHandler("onvscroll", this.grd_list_onvscroll, this);
            this.grd_list.addEventHandler("onslide", this.grd_list_onslide, this);

        };

        this.loadIncludeScript("BondResultDepositInquiryDamboPop.xfdl", true);

       
    };
}
)();
