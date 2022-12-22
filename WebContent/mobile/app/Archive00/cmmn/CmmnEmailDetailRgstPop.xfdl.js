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
                this.set_name("CmmnEmailDetailRgstPop");
                this.set_titletext("이메일발송상세등록");
                this._setFormPosition(0,0,420,273);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "420", "272", null, null, this);
            obj.set_taborder("44");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "0", "0", "420", "70", null, null, this);
            obj.set_taborder("46");
            obj.set_text("상세등록");
            obj.set_cssclass("sta_POP_TitleBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "70", "420", "10", null, null, this);
            obj.set_taborder("47");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "410", "80", "10", "192", null, null, this);
            obj.set_taborder("48");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "80", "10", "192", null, null, this);
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

            obj = new Static("Static03", "absolute", "0", "252", "420", "20", null, null, this);
            obj.set_taborder("54");
            obj.set_text("h20");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "195", "420", "10", null, null, this);
            obj.set_taborder("68");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Button("btn_sendEmail", "absolute", "345", "205", "65", "47", null, null, this);
            obj.set_taborder("70");
            obj.set_text("발송");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "12", "138", null, "59", "11", null, this);
            obj.set_taborder("71");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "12", "80", null, "59", "11", null, this);
            obj.set_taborder("72");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_emailAddress", "absolute", "9", "86", "401", "47", null, null, this);
            obj.set_taborder("73");
            obj.set_displaynulltext("이메일 주소를 입력하세요");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_name", "absolute", "9", "144", "401", "47", null, null, this);
            obj.set_taborder("74");
            obj.set_displaynulltext("고객사명을 입력하세요");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 420, 273, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("이메일발송상세등록");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("CmmnEmailDetailRgstPop.xfdl", "lib::lib_Com.xjs");
        this.registerScript("CmmnEmailDetailRgstPop.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		이메일발송상세등록
        // [부시스템명]	견적서작성 이메일발송상세등록
        // [설명]		    견적서작성 이메일발송상세등록
        // [작성자명] 		강대성
        // [작성일자]		2015.02.02
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.02 : 강대성 : 화면설계.
        // 2015.05.15 : 강대성 : 견적서작성 이메일발송상세등록
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"
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
        this.form_onload = function(obj,e)
        {
        	application.goMain.gfn_POP_resize(this);
        }

        // 데이터 초기화
        this.fn_init = function ()
        {
        	this.arg = application.goMain.gfn_POP_getArg();
        	
        } 

        /*******************************************************************************
        * 기      능   :  반려버튼클릭시
        * 설      명   :  반려버튼클릭시 해당 데이터를 부모창에 넘겨준다.
        ********************************************************************************/ 

        this.btn_sendEmail_onclick = function(obj,e)
        {
        	if (this.gfn_isNull(this.edt_emailAddress.value)){
        		application.goMain.gfn_Msg("ALERT_0", "알림", "이메일주소를 입력하세요.", "OK", true, this);
                return;		
        	}
        	
        	if (!this.gfn_isEmail(this.edt_emailAddress.value))
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "이메일 형식에 맞지 않습니다.", "OK", true, this);
                return;	
        	}
        	
        	if (this.gfn_isNull(this.edt_name.value)){
        		application.goMain.gfn_Msg("ALERT_0", "알림", "고객사명을 입력하세요.", "OK", true, this);
                return;		
        	}
        	
        	var arg = new Array();
        	
        	arg[0] = this.edt_emailAddress.value;  //메일주소
        	arg[1] = this.edt_name.value; 	       //고객사명
        	
        	application.goMain.gfn_POP_close(this, arg);
        }

        this.btnClose_onclick = function (obj,e)
        {
        	application.goMain.gfn_POP_close(this, "CLOSEONLY");
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
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);
            this.btn_sendEmail.addEventHandler("onclick", this.btn_sendEmail_onclick, this);
            this.edt_name.addEventHandler("oneditclick", this.edt_name_oneditclick, this);

        };

        this.loadIncludeScript("CmmnEmailDetailRgstPop.xfdl", true);

       
    };
}
)();
