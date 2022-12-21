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
                this.set_name("CmmnMakePushMsg");
                this.set_scrollbars("none");
                this.set_titletext("알림 메시지");
                this._setFormPosition(0,0,420,478);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "420", "478", null, null, this);
            obj.set_taborder("34");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("staTitle", "absolute", "0", "0", "420", "70", null, null, this);
            obj.set_taborder("1");
            obj.set_cssclass("sta_POP_TitleBg");
            obj.set_text("알림메시지");
            this.addChild(obj.name, obj);

            obj = new TextArea("taContents", "absolute", "10", "201", "400", "200", null, null, this);
            obj.set_taborder("26");
            obj.set_displaynulltext("내용을 입력하세요");
            this.addChild(obj.name, obj);

            obj = new Button("btnComplete", "absolute", "275", "411", "65", "47", null, null, this);
            obj.set_taborder("27");
            obj.set_text("전송");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Button("btnCancel", "absolute", "345", "411", "65", "47", null, null, this);
            obj.set_taborder("28");
            obj.set_text("취소");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Button("btnClose", "absolute", null, "0", "70", "70", "0", null, this);
            obj.set_taborder("10");
            obj.set_cssclass("btn_POP_XBtn");
            obj.getSetter("titletext").set("수리(토너)신청 상세");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "10", "138", "150", "59", null, null, this);
            obj.set_taborder("30");
            obj.set_text("알림 제목");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Edit("edTitle", "absolute", "156", "144", "254", "47", null, null, this);
            obj.set_taborder("31");
            obj.set_displaynulltext("제목을 입력하세요");
            this.addChild(obj.name, obj);

            obj = new Static("staText", "absolute", "10", "80", "400", "59", null, null, this);
            obj.set_taborder("33");
            obj.set_text("※ 입력불가 문자는 { } \" \" 입니다.");
            obj.style.set_linespace("5");
            obj.style.set_border("0 none #808080ff");
            obj.style.set_color("#f26c38ff");
            this.addChild(obj.name, obj);

            obj = new Static("Static12", "absolute", "340", "428", "5", "19", null, null, this);
            obj.set_taborder("41");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 420, 478, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_COMP_03");
            		p.set_scrollbars("none");
            		p.set_titletext("알림 메시지");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.registerScript("CmmnMakePushMsg.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		공통
        // [부시스템명]	공통 - 알림 메시지 작성
        // [프로그램]		CmmnMakePushMsg.xfdl
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
        this.CmmnMakePushMsg_onload = function(obj,e)
        {
        	application.goMain.gfn_POP_resize(this);
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
        	var sTitle = this.edTitle.text.trim();
        	var sCont = this.taContents.text.trim();

        	if(application.gfn_IsNull(sTitle))
        	{
        		application.goMain.gfn_Msg("ALERT_0", "메시지", "알림 제목을 입력해 주세요.", "OK", true, this);
        		return false;
        	}

        	if(application.gfn_IsNull(sCont))
        	{
        		application.goMain.gfn_Msg("ALERT_0", "메시지", "알림 내용을 입력해 주세요.", "OK", true, this);
        		return false;
        	}
        	
        	if( !application.gfn_IsNull(sTitle) || !application.gfn_IsNull(sCont) )
        	{
        		var bracket1_sTitle = sTitle.indexOf( '{' );
        		var bracket2_sTitle = sTitle.indexOf( '}' );
        		var dqoutation_sTitle = sTitle.indexOf( '"' );
        		
        		var bracket1_sCont = sCont.indexOf( '{' );
        		var bracket2_sCont = sCont.indexOf( '}' );
        		var dqoutation_sCont = sCont.indexOf( '"' );

        		if( bracket1_sTitle == -1 && bracket2_sTitle == -1 && dqoutation_sTitle == -1 
        			&& bracket1_sCont == -1 && bracket2_sCont == -1 && dqoutation_sCont == -1 )
        		{
        			;
        		}
        		else
        		{
        			application.goMain.gfn_Msg("ALERT_0", "메시지", "입력불가 문자가 포함되어 있습니다.", "OK", true, this);
        			return;
        		}
        	}

        	application.goMain.gfn_Msg("CONFIRM_0", "메시지", "전송 하시겠습니까?", "YN", true, this);
        	return false;
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
        	
        	var sRtn;
        	if (id == "CONFIRM_0") //반려버튼 클릭
        	{
        		if(rtn == "Y")
        		{
        			sRtn = this.fn_makePushStmt();
        			application.goMain.gfn_POP_close(this, sRtn);
        		}
        	}
        }

        /** 알림 메시지를 조합하여 만드는 함수
         * @param  : 없음
         * @return : 알림메시지 문장
         */
        this.fn_makePushStmt = function ()
        {
        	var sProfName = application.gds_loginInfo.getColumn(0, "KOR_NM") + "님";
        	var sBody = "\"Body\":";
        	var sTitle = "\"Title\":";

        	sContents  = "{" + sTitle + "\"" + "[" + sProfName + "] " + this.edTitle.text.trim() + "\",";
        	sContents += sBody + "\"" + this.taContents.text.trim() + "\"}";
        	
        	return sContents;
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.CmmnMakePushMsg_onload, this);
            this.btnComplete.addEventHandler("onclick", this.btnComplete_onclick, this);
            this.btnCancel.addEventHandler("onclick", this.btnCancel_onclick, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);

        };

        this.loadIncludeScript("CmmnMakePushMsg.xfdl", true);

       
    };
}
)();
