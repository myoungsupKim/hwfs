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
                this.set_name("CmmnFrameSub");
                this.set_titletext("Sub Frame");
                this._setFormPosition(0,0,540,833);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new Div("divTop", "absolute", "0", "0", null, "73", "0", null, this);
            obj.set_taborder("0");
            obj.set_scrollbars("none");
            this.addChild(obj.name, obj);

            obj = new Div("divWork", "absolute", "0", "73", null, null, "0", "0", this);
            obj.set_taborder("1");
            obj.set_async("true");
            obj.set_scrollbars("autovert");
            this.addChild(obj.name, obj);

            obj = new Button("btnGoTopDiv", "absolute", "464", null, null, "55", "21", "33", this);
            obj.set_taborder("3");
            obj.set_cssclass("btn_WF_Top");
            obj.set_visible("false");
            obj.set_escapebutton("false");
            obj.style.set_background("white URL('theme://Image/btn_WF_Top.png') stretch left top");
            obj.style.set_opacity("90");
            this.addChild(obj.name, obj);

            obj = new Button("btnGoTop", "absolute", null, null, "55", "55", "21", "33", this);
            obj.set_taborder("4");
            obj.set_cssclass("btn_WF_Top");
            obj.set_visible("false");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 0, 0, this.divWork,
            	//-- Layout function
            	function(p) {
            		p.set_taborder("1");
            		p.set_async("true");
            		p.set_scrollbars("autovert");

            	}
            );
            this.divWork.addLayout(obj.name, obj);

            //-- Default Layout
            obj = new Layout("default", "", 540, 833, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frameSub");
            		p.set_titletext("Sub Frame");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.registerScript("CmmnFrameSub.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		공통 
        // [부시스템명]	공통 - 서브
        // [프로그램]		CmmnFrameSub.xfdl
        // [설명]
        // 		프로젝트 실행 서브 화면
        // [작성자명] 		투비소프트
        // [작성일자]		2015.01.12
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.01.12 : 김광호 : 신규생성.
        //########################################################
        this.CmmnFrameSub_onload = function(obj,e)
        {
        	this.divTop.set_url("frame::CmmnFrameTop.xfdl");
        	this.divWork.set_url("");
        	application.goTopMain = this;
        	this.divWork.set_url(application.gv_formUrl);
        	//this.Button00.bringToFront();
        }

        
        /** 
         * 뒤로 클릭시
         * @param  : 없음
         * @return : true, false
         */
        this.fn_back = function ()
        {
        	this.sendToBack();
        	this.set_visible(false);
        	
        }

        // 업무영역의 스크롤바 이벤트
        this.divWork_onvscroll = function(obj,e)
        {
        	trace("v스크롤 이벤트 발생");
        	if (e.pos != 0)
        	{
        		this.btnGoTop.set_visible(true);
        	}
        	else
        	{
        		this.btnGoTop.set_visible(false);
        	}
        // 	this.divWork.hscrollbar.set_pos();
        // 	this.divWork.hscrollbar.pos = e.pos;
        }

        // 공통 '맨위로'버튼 동작
        this.btnGoTop_onclick = function(obj,e)
        {
        	this.divWork.vscrollbar.set_pos(0);
        	this.btnGoTop.set_visible(false);
        	// bottom 컨트롤
        	this.parent.divBottom.set_visible(true);
        	this.parent.divMain.set_height(833);
        }

        this.btnGoTopDiv_onclick = function(obj,e)
        {
        	// this.divWork.vscrollbar.set_pos(0);
        	// div이름이 뭔지 모르므로 해당 화면의 함수를 실행
        	this.divWork.fn_setDivScrollbar();
        	this.btnGoTop.set_visible(false);
        	// bottom 컨트롤
        	this.parent.divBottom.set_visible(true);
        	this.parent.divMain.set_height(833);
        }

        this.divWork_ondragmove = function(obj,e)
        {
        	this.btnGoTop.set_left(e.canvasX);
        	this.btnGoTopDiv.set_left(e.canvasX);
        }

        this.divWork_ondrag = function(obj,e)
        {
        	return true;
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.CmmnFrameSub_onload, this);
            this.divWork.addEventHandler("ondragmove", this.divWork_ondragmove, this);
            this.divWork.addEventHandler("ondrag", this.divWork_ondrag, this);
            this.btnGoTopDiv.addEventHandler("onclick", this.btnGoTopDiv_onclick, this);
            this.btnGoTop.addEventHandler("onclick", this.btnGoTop_onclick, this);

        };

        this.loadIncludeScript("CmmnFrameSub.xfdl", true);

       
    };
}
)();
