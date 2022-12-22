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
                this.set_name("CmmnRejectRsnPop");
                this.set_scrollbars("none");
                this.set_titletext("반려사유");
                this._setFormPosition(0,0,420,432);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_list", this);
            obj.set_preload("true");
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj._setContents("<ColumnInfo><Column id=\"DCSN_CD\" size=\"6\" type=\"STRING\"/><Column id=\"KOR_DEPT_NM\" size=\"4000\" type=\"STRING\"/><Column id=\"APPR_YN\" size=\"5\" type=\"STRING\"/><Column id=\"APPR_DT\" size=\"8\" type=\"STRING\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_cond", this);
            obj.set_preload("true");
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj._setContents("<ColumnInfo><Column id=\"ACNT_UNIT\" size=\"20\" type=\"STRING\"/><Column id=\"ACNT_FG\" size=\"20\" type=\"STRING\"/><Column id=\"DCSN_NO\" size=\"20\" type=\"STRING\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "420", "432", null, null, this);
            obj.set_taborder("25");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("staTitle", "absolute", "0", "0", "420", "70", null, null, this);
            obj.set_taborder("1");
            obj.set_cssclass("sta_POP_TitleBg");
            obj.set_text("반려사유등록");
            this.addChild(obj.name, obj);

            obj = new TextArea("taReturn", "absolute", "10", "80", null, null, "10", "77", this);
            obj.set_taborder("26");
            this.addChild(obj.name, obj);

            obj = new Button("btnComplete", "absolute", "275", "365", "65", "47", null, null, this);
            obj.set_taborder("27");
            obj.set_text("반려");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Button("btnCancel", "absolute", "345", "365", "65", "47", null, null, this);
            obj.set_taborder("28");
            obj.set_text("취소");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Static("staBtnClose", "absolute", "400", "0", null, "67", "0", null, this);
            obj.set_taborder("29");
            this.addChild(obj.name, obj);

            obj = new Button("btnClose", "absolute", "350", "0", "70", "70", null, null, this);
            obj.set_taborder("10");
            obj.set_cssclass("btn_POP_XBtn");
            obj.getSetter("titletext").set("수리(토너)신청 상세");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 420, 432, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_COMP_03");
            		p.set_scrollbars("none");
            		p.set_titletext("반려사유");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        
        this.loadPreloadList = function()
        {
            this._addPreloadList("data", "", "ds_list");
            this._addPreloadList("data", "", "ds_cond");
        };
        
        // User Script
        this.registerScript("CmmnRejectRsnPop.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		공통
        // [부시스템명]	공통 - 반려사유
        // [프로그램]		CmmnRejectRsnPop.xfdl
        // [설명]
        // 		공통 - 반려사유 공통파업
        // [작성자명] 		투비소프트
        // [작성일자]		2014.08.28
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2014.04.01 : 홍길동 : 수정이 필요하여 수정함.
        //########################################################
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
        this.CmmnRejectRsnPop_onload = function(obj,e)
        {
        	application.goMain.gfn_POP_resize(this, 100);
        }

        /*==========================================================================
         * 4. Component관련 Script
        *========================================================================*/
        this.btnClose_onclick = function(obj,e)
        {
        	application.goMain.gfn_POP_close(this, "CLOSEONLY");
        }

        this.staBtnClose_onclick = function(obj,e)
        {
        	application.goMain.gfn_POP_close(this, "CLOSEONLY");
        }

        //취소버튼 클릭
        this.btnCancel_onclick = function(obj,e)
        {
        	application.goMain.gfn_POP_close(this, "CLOSEONLY");
        }

        //반려버튼 클릭
        this.btnComplete_onclick = function(obj,e)
        {
        	var sData = this.taReturn.value;
        	if(application.gfn_IsNull(sData))
        	{
        		application.goMain.gfn_Msg("ALERT_0", "메시지", "반려사유를 입력해 주세요.", "OK", true, this);
        		return false;
        	}
        	else if(sData.trim() == "")
        	{
        		application.goMain.gfn_Msg("ALERT_0", "메시지", "반려사유를 입력해 주세요.", "OK", true, this);
        		return false;
        	}
        	else
        	{
        		application.goMain.gfn_Msg("CONFIRM_0", "메시지", "반려 하시겠습니까?", "YN", true, this);
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
        	
        	if (id == "CONFIRM_0") //반려버튼 클릭
        	{
        		if(rtn == "Y")
        		{
        			application.goMain.gfn_POP_close(this, this.taReturn.value);
        		}
        	}
        }

        

        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.CmmnRejectRsnPop_onload, this);
            this.btnComplete.addEventHandler("onclick", this.btnComplete_onclick, this);
            this.btnCancel.addEventHandler("onclick", this.btnCancel_onclick, this);
            this.staBtnClose.addEventHandler("onclick", this.staBtnClose_onclick, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);

        };

        this.loadIncludeScript("CmmnRejectRsnPop.xfdl", true);
        this.loadPreloadList();
       
    };
}
)();
