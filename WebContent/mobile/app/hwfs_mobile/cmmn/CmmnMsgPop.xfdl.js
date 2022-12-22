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
                this.set_name("CmmnMsgPop");
                this.set_titletext("공통메시지");
                this.set_cssclass("frm_POP_bg");
                this.set_scrollbars("autovert");
                this._setFormPosition(0,0,420,358);
            }
            this.getSetter("inheritanceid").set("");

            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "420", "358", null, null, this);
            obj.set_taborder("3");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new TextArea("txtMsg", "absolute", "10", "80", "400", "201", null, null, this);
            obj.set_taborder("5");
            obj.set_readonly("true");
            obj.set_wordwrap("true");
            obj.style.set_padding("10 10 10 10");
            obj.style.set_border("0 none #808080ff");
            obj.style.set_bordertype("normal 0 0");
            obj.style.set_align("center middle");
            obj.set_cssclass("txt_POP_AltCfm");
            obj.set_displaynulltext("Confirm 메세지 입니다.");
            this.addChild(obj.name, obj);

            obj = new Static("staTitle", "absolute", "0", "0", "420", "70", null, null, this);
            obj.set_text("Title");
            obj.set_cssclass("sta_POP_AltCfmTitleBg");
            obj.set_taborder("0");
            this.addChild(obj.name, obj);

            obj = new Static("staFront", "absolute", "0", "70", "420", "288", null, null, this);
            obj.set_taborder("14");
            this.addChild(obj.name, obj);

            obj = new Button("btnOK", "absolute", "164", "291", "91", "47", null, null, this);
            obj.set_taborder("15");
            obj.set_text("확인");
            obj.set_visible("true");
            this.addChild(obj.name, obj);

            obj = new Button("btnYes", "absolute", "68", "291", "91", "47", null, null, this);
            obj.set_taborder("4");
            obj.set_text("예");
            obj.set_visible("true");
            this.addChild(obj.name, obj);

            obj = new Button("btnNo", "absolute", "260", "291", "91", "47", null, null, this);
            obj.set_taborder("2");
            obj.set_text("아니오");
            obj.set_visible("true");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 420, 358, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frmMsg");
            		p.getSetter("inheritanceid").set("");
            		p.set_titletext("공통메시지");
            		p.set_cssclass("frm_POP_bg");
            		p.set_scrollbars("autovert");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.registerScript("CmmnMsgPop.xfdl", function(exports) {
        /*  Message Template
         Alert, Confirm 형태의 메세지 창
         gfn_Msg를 사용해서 띄워야함
         
         gfn_Msg 사용법 : gfn_Msg(id, title, desc, type, bCallback, callObj)
         - id : Msg ID
         - title : title에 표시할 내용 (OFFSIDE에서는 사용안함)
         - desc : 메세지 내용
         - type : 메세지 타입
         OK : Alert형
         YN : Confirm형
         - bCallback : 메세지 창을 닫을 때 콜백함수를 호출할지 여부 (true/false)
         - callObj : 콜백함수가 불려지는 form
         
         ex) gfn_Msg("ALERT", "타이틀", "메세지내용", "OK");
         gfn_Msg("ALERT", "타이틀", "메세지내용", "OK", true, this);
         */

        this.arg = undefined;
        this.gab = 5;
        this.max = 400;

        /**
         * @desc   : Form의 모든 컴포넌트가 생성되고, 모든 Object가 Load 되었을 때에 발생하는 Event
         메세지 길이에 따른 컴포넌트 크기 조절 등 초기 설정
         * @param  : obj : Event가 발생한 Object
         e : Event Object (LoadEventInfo)
         * @return : 없음
         */
        this.CmmnMsgPop_onload = function (obj,e)
        {
        	// gfn_Msg 사용 시 onload에서 필수로 호출해야 하는 함수
        	application.goMain.gfn_POP_resize(this);

        	// 인자를 받아옴
        	this.arg = application.goMain.gfn_POP_getArg();

        	// Title SET
        	this.staTitle.set_text(this.arg[0]);

        	// 메세지 SET
        	this.txtMsg.set_value(this.arg[1]);

        	// TYPE에 따른 버튼 설정
        	if (this.arg[2] == "YN") 
        	{
        		this.btnOK.set_visible(false);
        		this.btnYes.bringToFront();
        		this.btnNo.bringToFront();
        	}
        	else if (this.arg[2] == "OK") 
        	{
        		this.btnYes.set_visible(false);
        		this.btnNo.set_visible(false);
        		this.btnOK.bringToFront();
        	}

        	// value set 후 vscrollbar.visible를 바로 찍으면 스크롤바가 있어도 false로 나온다.
        	// 하지만, 크기를 변경한 다음 찍으면 true로 나온다.
        	// 런타임, pc 브라우저는 확인. 모바일은 확인 필요
        	this.txtMsg.set_height(this.txtMsg.getPixelHeight() + 1);

        // 	// 메세지 길이에 따른 컴포넌트 크기 조절
        // 	while (1) 
        // 	{
        // 		if (!this.txtMsg.vscrollbar.visible) 
        // 		{
        // 			break;
        // 		}
        // 
        // 		if (this.getOffsetHeight() >= this.max) 
        // 		{
        // 			break;
        // 		}
        // 
        // 		this.txtMsg.set_height(this.txtMsg.getOffsetHeight() + this.gab);
        // 
        // 		this.btnYes.set_top(this.btnYes.getOffsetTop() + this.gab);
        // 		this.btnNo.set_top(this.btnNo.getOffsetTop() + this.gab);
        // 		this.btnOK.set_top(this.btnOK.getOffsetTop() + this.gab);
        // 
        // 		this.set_height(this.getOffsetHeight() + this.gab);
        // 		this.staFormSize.set_height(this.staFormSize.getOffsetHeight() + this.gab);
        // 		this.set_top(this.getOffsetTop() - this.gab / 2);
        // 	}
        // 
        // 	this.resetScroll();
        }

        /**
         * @desc   : Button click Event
         * @param  : obj : Event가 발생한 Object
         e : Event Object (ClickEventInfo)
         * @return : 없음
         */
        this.common_onclick = function (obj,e)
        {
        	switch (obj.name) 
        	{
        		case "btnOK":
        			application.goMain.gfn_POP_close(this);
        			break;
        		case "btnYes":
        			application.goMain.gfn_POP_close(this, "Y");
        			break;
        		case "btnNo":
        			application.goMain.gfn_POP_close(this, "N");
        			break;
        	}
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.CmmnMsgPop_onload, this);
            this.staFront.addEventHandler("onclick", this.staFront_onclick, this);
            this.btnOK.addEventHandler("onclick", this.common_onclick, this);
            this.btnYes.addEventHandler("onclick", this.common_onclick, this);
            this.btnNo.addEventHandler("onclick", this.common_onclick, this);

        };

        this.loadIncludeScript("CmmnMsgPop.xfdl", true);

       
    };
}
)();
