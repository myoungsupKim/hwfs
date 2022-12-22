﻿(function()
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
                this.set_name("Popup_Default");
                this.set_titletext("검색");
                this._setFormPosition(0,0,420,458);
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
            obj._setContents("<ColumnInfo><Column id=\"deptCd\" type=\"STRING\" size=\"256\"/><Column id=\"deptNm\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"deptCd\">0101</Col><Col id=\"deptNm\">운영1팀</Col></Row><Row><Col id=\"deptCd\">0102</Col><Col id=\"deptNm\">운영2팀</Col></Row><Row><Col id=\"deptCd\">0103</Col><Col id=\"deptNm\">운영3팀</Col></Row><Row><Col id=\"deptCd\">0104</Col><Col id=\"deptNm\">운영4팀</Col></Row><Row><Col id=\"deptCd\">0105</Col><Col id=\"deptNm\">운영5팀</Col></Row><Row><Col id=\"deptCd\">0106</Col><Col id=\"deptNm\">기획팀</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "420", "458", null, null, this);
            obj.set_taborder("44");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "0", "0", "420", "70", null, null, this);
            obj.set_taborder("46");
            obj.set_cssclass("sta_POP_TitleBg");
            obj.set_text("부서검색");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "70", "420", "10", null, null, this);
            obj.set_taborder("47");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "410", "80", "10", "358", null, null, this);
            obj.set_taborder("48");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "80", "10", "358", null, null, this);
            obj.set_taborder("50");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Button("btnClose", "absolute", "350", "0", "70", "70", null, null, this);
            obj.set_taborder("45");
            obj.set_cssclass("btn_POP_XBtn");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "0", "438", "420", "20", null, null, this);
            obj.set_taborder("54");
            obj.set_text("h20");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_deptNm", "absolute", "132", "80", "173", "47", null, null, this);
            obj.set_taborder("71");
            obj.set_displaynulltext("부서명");
            this.addChild(obj.name, obj);

            obj = new Button("btn_search", "absolute", "310", "80", "100", "47", null, null, this);
            obj.set_taborder("72");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "305", "86", "5", "30", null, null, this);
            obj.set_taborder("73");
            obj.set_text("h05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "0", "127", "420", "10", null, null, this);
            obj.set_taborder("74");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list", "absolute", "10", "137", "400", "301", null, null, this);
            obj.set_taborder("75");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"131\"/><Column size=\"268\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\" band=\"head\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"Column0\"/><Cell col=\"1\"/><Cell row=\"1\" text=\"부서코드\"/><Cell row=\"1\" col=\"1\" text=\"부서명\"/></Band><Band id=\"body\"><Cell style=\"align:left middle;padding:0 10 0 10;\" text=\"bind:deptCd\"/><Cell col=\"1\" style=\"align:left;\" text=\"bind:deptNm\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static18", "absolute", "398", "272", "110", "2", null, null, this);
            obj.set_taborder("76");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static19", "absolute", "513", "258", "349", "30", null, null, this);
            obj.set_taborder("77");
            obj.set_text("Align : left middle / padding : 0 10 0 10");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_deptCd", "absolute", "10", "80", "119", "47", null, null, this);
            obj.set_taborder("78");
            obj.set_displaynulltext("부서코드");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 420, 458, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("검색");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("teamSearchPop.xfdl", "lib::sz_fsp_xp.xjs");
        this.registerScript("teamSearchPop.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		부서 검색
        // [부시스템명]	부서 검색 - 조회
        // [설명]
        // 		부서 검색하기.
        // [작성자명] 		강대성
        // [작성일자]		2014.08.12
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2014.04.01 : 강대성 : 수정이 필요하여 수정함.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::sz_fsp_xp.xjs", null, exports); }	//include "lib::sz_fsp_xp.xjs"
        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/

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
        this.CmmnDeptSearchPop_onload = function(obj,e)
        {
        	//필수
        	//this.fsp_init();
        	this.arg = application.goMain.gfn_POP_getArg();
        	
        	this.edt_deptNm.set_value(this.arg[0]);
        	
        	application.goMain.gfn_POP_resize(this);
        }

        /*==========================================================================
         * 3. DataSet관련 Script
        *========================================================================*/
        /** 
         * 테이터셋셋팅
         * @param  
        	value  : 셋팅값
         * @return : 없음
         */

        /*==========================================================================
         * 4. Component관련 Script
        *========================================================================*/

        this.btnSearch_onclick = function(obj,e)
        {
        	this.fn_search();
        }
        /** 
         * 취소버튼클릭
         * @param  
        	obj, e
         * @return : 없음
         */
        this.btnClose_onclick = function(obj,e)
        {
        	application.goMain.gfn_POP_close(this, "CLOSEONLY");
        }

        this.staBtnClose_onclick = function(obj,e)
        {
        	application.goMain.gfn_POP_close(this, "CLOSEONLY");
        }

        
        /** 
         * 그리드 셀클릭
         * @param  
        	obj, e
         * @return : 없음
         */
        this.grdList_oncellclick = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_grd.getColumn(e.row,"deptCd"); 	//부서코드
        	arg[1] = this.ds_grd.getColumn(e.row,"deptNm"); 	//부서명
        	application.goMain.gfn_POP_close(this, arg);
        }
        /*================================================================================
         * 5. UserFunction관련 Script
         *===============================================================================*/
        /** 
         * 사용자정의 함수
         * @param  : 없음
         * @return : true, false
         */

        /*******************************************************************************
        * 기      능   :  검색
        * 설      명   :  등록
        ********************************************************************************/
        this.fn_search = function()
        {
        	//this.ds_cond.setColumn(0,"KOR_NM",this.edtKorNm.value);//부서명
        	application.goMain.gfn_Msg("alertTest", "Information", "테스트중", "OK");
        	this.edtId.setFocus();
        	return;
                
        	// 서비스 연결 됐을때 아래 로직으로..
        	var strSvcID   		 = "teamSearchPop";
        	var strUrl     		 = "sc/cmn/selectCodeList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "ds_grd=ds_list";
        	var strArguments	 = "deptCd=" + nexacro.wrapQuote(this.edt_deptCd.text);
        	   strArguments     += " deptNm=" + nexacro.wrapQuote(this.edt_deptNm.text);
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);

        	// connect the server 
        	
        }
        /*******************************************************************************
        * 기      능   : 부서명 조회 callback
        ********************************************************************************/
        this.fn_afterSearch = function(ErrorCode,ErrorMsg)
        {
        	if(ErrorCode != "0") 
        	{
        		application.goMain.gfn_Msg("ALERT_0", "오류", "["+ErrorCode+"] "+ErrorMsg, "OK", true, this);
        		return;
        	}
        	else
        	{
        	}
        }

        /** Message callback 함수
         * @param
        	id : id
        	rtn : type이 "OK" 일 때는 none
        	type이 "YN" 일 때는 "Y" or "N"
         * @return : 없음
         * @note : Alert 이나 Confirm 메시지의 콜백 함수
         *         gfn_Msg(...) 함수를 사용하여 띄운 창을 닫을 때 호출된다.
         */
        this.msg_callback = function (id,rtn)
        {
        	if (id == "ALERT_0") // 조회 시 오류
        	{
        		// 아무 일도 안함.
        	}
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.CmmnDeptSearchPop_onload, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);
            this.btn_search.addEventHandler("onclick", this.btnSearch_onclick, this);
            this.grd_list.addEventHandler("oncellclick", this.grdList_oncellclick, this);

        };

        this.loadIncludeScript("teamSearchPop.xfdl", true);

       
    };
}
)();