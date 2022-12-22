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
                this.set_name("TeamLeaderAppDetailPop");
                this.set_scrollbars("none");
                this.set_titletext("상세내용");
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
            obj.set_text("상세내용");
            this.addChild(obj.name, obj);

            obj = new TextArea("tax_remark", "absolute", "10", "80", null, null, "10", "10", this);
            obj.set_taborder("26");
            obj.set_readonly("true");
            obj.set_wordwrap("char");
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
            		p.set_titletext("상세내용");

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
        this.addIncludeScript("TeamLeaderAppDetailPop.xfdl", "lib::lib_Com.xjs");
        this.registerScript("TeamLeaderAppDetailPop.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		팀장승인
        // [부시스템명]	팀장승인 상세내용
        // [프로그램]		CmmnRejectRsnPop.xfdl
        // [설명]
        // 		팀장승인 상세내용
        // [작성자명] 		강대성
        // [작성일자]		2015.04.13
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.04.13 : 강대성 : 수정이 필요하여 수정함.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

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
        	this.arg = application.goMain.gfn_POP_getArg();
        	
        	var gubun = this.arg[0];	
        	
        	//팀장승인화면에서 넘어온 파라미터값 세팅
        	var reasonNm1 = this.arg[2];
        	var reasonNm2 = this.arg[1];
        	
        	if(this.gfn_isNull(reasonNm1))
        	{
        		this.tax_remark.set_value(reasonNm2);		
        	}
        	else
        	{
        		this.tax_remark.set_value(reasonNm1 + "\n" +reasonNm2);		
        	}	
        	
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
            this.addEventHandler("onload", this.form_onload, this);
            this.staBtnClose.addEventHandler("onclick", this.staBtnClose_onclick, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);

        };

        this.loadIncludeScript("TeamLeaderAppDetailPop.xfdl", true);
        this.loadPreloadList();
       
    };
}
)();
