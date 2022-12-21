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
                this.set_name("CmmnZipSearchPop");
                this.set_titletext("주소검색");
                this._setFormPosition(0,0,500,791);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_address", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"SEQ\" size=\"22\" type=\"STRING\"/><Column id=\"ZIP\" size=\"6\" type=\"STRING\"/><Column id=\"ADDR_NM1\" size=\"20\" type=\"STRING\"/><Column id=\"ADDR_NM2\" size=\"24\" type=\"STRING\"/><Column id=\"ADDR_NM4\" size=\"40\" type=\"STRING\"/><Column id=\"ADDR\" size=\"40\" type=\"STRING\"/><Column id=\"ZIP_FORM\" size=\"7\" type=\"STRING\"/><Column id=\"FULL_ADDR\" size=\"127\" type=\"STRING\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_cond", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"ADDR_NM4\" size=\"255\" type=\"STRING\"/><Column id=\"ADDR\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "500", "791", null, null, this);
            obj.set_taborder("15");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("staShregNm", "absolute", "10", "80", null, "59", "10", null, this);
            obj.set_taborder("5");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("staShregNm00", "absolute", "10", "138", null, "59", "10", null, this);
            obj.set_taborder("12");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("staTitle", "absolute", "0", "0", null, "70", "0", null, this);
            obj.set_taborder("0");
            obj.set_text("주소 찾기");
            obj.set_cssclass("sta_POP_TitleBg");
            this.addChild(obj.name, obj);

            obj = new Grid("grdAddress", "absolute", "10", "207", null, "507", "10", null, this);
            obj.set_taborder("3");
            obj.set_binddataset("ds_address");
            obj.set_scrollbars("autovert");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"150\"/><Column size=\"330\"/></Columns><Rows><Row size=\"55\" band=\"head\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"우편번호\"/><Cell col=\"1\" text=\"주소\"/></Band><Band id=\"body\"><Cell text=\"bind:ZIP_FORM\"/><Cell col=\"1\" text=\"bind:FULL_ADDR\" wordwrap=\"true\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("staShregNmT", "absolute", "10", "80", "124", "59", null, null, this);
            obj.set_taborder("4");
            obj.set_text("도로명");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Edit("edtRoad", "absolute", "149", "86", null, "47", "10", null, this);
            obj.set_taborder("6");
            obj.set_displaynulltext("도로명 입력");
            this.addChild(obj.name, obj);

            obj = new Button("btnComplete", "absolute", null, "724", "65", "47", "80", null, this);
            obj.set_taborder("8");
            obj.set_text("확인");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Button("btnCancel", "absolute", null, "724", "65", "47", "10", null, this);
            obj.set_taborder("9");
            obj.set_text("취소");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Static("staBtnClose", "absolute", null, "0", "70", "70", "0", null, this);
            obj.set_taborder("10");
            this.addChild(obj.name, obj);

            obj = new Button("btnClose", "absolute", null, "0", "70", "70", "0", null, this);
            obj.set_taborder("1");
            obj.set_cssclass("btn_POP_XBtn");
            this.addChild(obj.name, obj);

            obj = new Static("staShregNmT00", "absolute", "10", "138", "124", "59", null, null, this);
            obj.set_taborder("11");
            obj.set_text("건물번호");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Edit("edtRoad00", "absolute", "149", "144", null, "47", "10", null, this);
            obj.set_taborder("13");
            obj.set_displaynulltext("건물번호 입력");
            this.addChild(obj.name, obj);

            obj = new Button("btnSearch", "absolute", null, "144", "47", "47", "10", null, this);
            obj.set_taborder("14");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 500, 791, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("address");
            		p.set_titletext("주소검색");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information
            obj = new BindItem("item3","edtRoad","value","dsOrderReg","USR_TYPE");
            this.addChild(obj.name, obj);
            obj.bind();
            obj = new BindItem("item0","edtRoad00","value","dsOrderReg","USR_TYPE");
            this.addChild(obj.name, obj);
            obj.bind();

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("CmmnZipSearchPop.xfdl", "lib::sz_fsp_xp.xjs");
        this.registerScript("CmmnZipSearchPop.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		주소검색 폼
        // [부시스템명]	주소검색- 조회
        // [설명]
        // 		주소검색을 조회하기
        // [작성자명] 		투비소프트
        // [작성일자]		2014.08.27
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2014.04.01 : 홍길동 : 수정이 필요하여 수정함.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::sz_fsp_xp.xjs", null, exports); }	//include "lib::sz_fsp_xp.xjs";
        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/
        this.f_arrZipAdd = new Array();		// 선택된 주소 저장
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
        this.CmmnZipSearchPop_onload = function(obj,e)
        {
        //	application.goMain.gfn_POP_resize(this);	
        	this.fsp_init();	
        	this.fn_init();
        }
        /** 
         * 화면셋팅
         * @param  : 없음
         * @return : 없음
         */
        this.fn_init = function ()
        {
        	//안드로이드4.3TODO
        	this.setTimer(100,100);
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
        /** 
         * 검색버튼클릭 - 신청부서 검색 버튼
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

        this.btnSearch_onclick = function(obj,e)
        {
        	this.ds_cond.clearData();	
        	this.ds_cond.addRow();
        	
        	if( !application.gfn_IsNull(this.edtRoad.value) )
        	{
        		this.ds_cond.setColumn( 0, "ADDR_NM4", this.edtRoad.value );
        		this.ds_cond.setColumn( 0, "ADDR", this.edtRoad00.value );
        	
        		this.fn_addresssearch();
        	}
        	else
        	{
        		var msg;		
        		msg = "도로명을 입력하세요.";
        		this.messageBox(msg);
        		return;
        	}
        }
        this.grdAddress_oncellclick = function(obj,e)
        {
        	this.f_arrZipAdd[0] = this.ds_address.getColumn(e.row, "ZIP_FORM");
        	this.f_arrZipAdd[1] = this.ds_address.getColumn(e.row, "FULL_ADDR");
        }
        this.btnComplete_onclick = function(obj,e)
        {
        	application.goMain.gfn_POP_close(this, this.f_arrZipAdd);
        }

        /*================================================================================
         * 5. UserFunction관련 Script
         *===============================================================================*/
        /** 
         * 사용자정의 함수
         * @param  : 없음
         * @return : true, false
         */
        this.messageBox = function(msg)
        {
        	application.goMain.gfn_Msg("FAILE", "메시지", msg, "OK", true, this);
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

        }
        /*================================================================================
         * 6. FSP 함수 관련 Script
         *===============================================================================*/
         /*******************************************************************************
        * 기      능   :  주소검색 조회
        * 설      명   :  
        ********************************************************************************/
        this.fn_addresssearch = function()
        {
        	this.fsp_clear();
        	this.fsp_addSearch("cmmn:CmmnZipSearchPop_S1", false);
        	// connect the server 
        	this.fsp_callService
        	(
        		""
        		,""
        		,"ds_cond=ds_cond"	// inDs
        		,"ds_address=ds_list"	// outDs
        		,""	// args 
        		,"fn_aftersAddressSearch"
        		,true
        	);
        }

        /*******************************************************************************
        * 기      능   : 주소검색 조회 callback
        ********************************************************************************/
        this.fn_aftersAddressSearch = function(ErrorCode,ErrorMsg)
        {
        	if(ErrorCode != "0") // 실패
        	{
        		application.goMain.gfn_Msg("ALERT_0", "오류", "["+ErrorCode+"] "+ErrorMsg, "OK", true, this);
        		return;
        	}
        	
        	this.f_arrZipAdd[0] = this.ds_address.getColumn(0, "ZIP_FORM");
        	this.f_arrZipAdd[1] = this.ds_address.getColumn(0, "FULL_ADDR");
        }

        this.CmmnZipSearchPop_ontimer = function(obj,e)
        {
        	this.killTimer(e.timerid);
        	application.goMain.gfn_POP_resize(this);
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.CmmnZipSearchPop_onload, this);
            this.addEventHandler("ontimer", this.CmmnZipSearchPop_ontimer, this);
            this.grdAddress.addEventHandler("oncellclick", this.grdAddress_oncellclick, this);
            this.btnComplete.addEventHandler("onclick", this.btnComplete_onclick, this);
            this.btnCancel.addEventHandler("onclick", this.btnClose_onclick, this);
            this.staBtnClose.addEventHandler("onclick", this.staBtnClose_onclick, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);
            this.btnSearch.addEventHandler("onclick", this.btnSearch_onclick, this);

        };

        this.loadIncludeScript("CmmnZipSearchPop.xfdl", true);

       
    };
}
)();
