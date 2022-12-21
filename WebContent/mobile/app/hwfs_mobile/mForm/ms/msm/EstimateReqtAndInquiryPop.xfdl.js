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
                this.set_name("EstimateReqtAndInquiryPop");
                this.set_titletext("대분류별 이익율 적용");
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
            obj._setContents("<ColumnInfo><Column id=\"gubun\" type=\"STRING\" size=\"256\"/><Column id=\"rate\" type=\"STRING\" size=\"256\"/><Column id=\"chk\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"gubun\">양곡</Col><Col id=\"rate\">0</Col><Col id=\"chk\">0</Col></Row><Row><Col id=\"gubun\">야채</Col><Col id=\"rate\">0</Col><Col id=\"chk\">0</Col></Row><Row><Col id=\"gubun\">수산</Col><Col id=\"rate\">0</Col><Col id=\"chk\">0</Col></Row><Row><Col id=\"gubun\">축산</Col><Col id=\"rate\">0</Col><Col id=\"chk\">0</Col></Row><Row><Col id=\"gubun\">김치</Col><Col id=\"rate\">0</Col><Col id=\"chk\">0</Col></Row><Row><Col id=\"gubun\">일배식품</Col><Col id=\"rate\">0</Col><Col id=\"chk\">0</Col></Row><Row><Col id=\"gubun\">가공식품</Col><Col id=\"rate\">0</Col><Col id=\"chk\">0</Col></Row><Row><Col id=\"gubun\">영업용 소모품</Col><Col id=\"rate\">0</Col><Col id=\"chk\">0</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "420", "458", null, null, this);
            obj.set_taborder("44");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "0", "0", "420", "70", null, null, this);
            obj.set_taborder("46");
            obj.set_cssclass("sta_POP_TitleBg");
            obj.set_text("이익율 적용");
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
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"174\"/><Column size=\"166\"/><Column size=\"60\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\" band=\"head\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"Column0\"/><Cell col=\"1\"/><Cell col=\"2\"/><Cell row=\"1\" text=\"대분류\"/><Cell row=\"1\" col=\"1\" text=\"이익율\"/><Cell row=\"1\" col=\"2\" text=\"선택\"/></Band><Band id=\"body\"><Cell style=\"align:left middle;padding:0 10 0 10;\" text=\"bind:gubun\"/><Cell col=\"1\" displaytype=\"text\" edittype=\"normal\" style=\"align:right;padding:0 10 0 10;\" text=\"bind:rate\" editdisplay=\"display\" calendardisplay=\"display\"/><Cell col=\"2\" displaytype=\"checkbox\" edittype=\"checkbox\" text=\"bind:chk\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Button("btn_gubunRate", "absolute", "10", "80", "400", "47", null, null, this);
            obj.set_taborder("76");
            obj.set_text("대분류별 이익율 적용");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 420, 458, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("대분류별 이익율 적용");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("EstimateReqtAndInquiryPop.xfdl", "lib::sz_fsp_xp.xjs");
        this.registerScript("EstimateReqtAndInquiryPop.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		사원 검색
        // [부시스템명]	사원 검색 - 조회
        // [설명]		    사원 검색하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.02.06
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.06 : 강대성 : 수정이 필요하여 수정함.
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
         * 버튼 클릭시
         * @param  
        	obj, e
         * @return : 없음
         */
        this.btn_gubunRate_onclick = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_grd.getColumn(e.row,"gubun"); 	//대분류
        	arg[1] = this.ds_grd.getColumn(e.row,"rate"); 	//이익율
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
        	var strArguments	 = "upjangCd=" + nexacro.wrapQuote(this.edt_upjangCd.text);
        	   strArguments     += " upjangNm=" + nexacro.wrapQuote(this.edt_upjangNm.text);
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_Transaction(strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);

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
            this.grd_list.addEventHandler("oncellclick", this.grdList_oncellclick, this);
            this.btn_gubunRate.addEventHandler("onclick", this.btn_gubunRate_onclick, this);

        };

        this.loadIncludeScript("EstimateReqtAndInquiryPop.xfdl", true);

       
    };
}
)();
