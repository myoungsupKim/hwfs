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
                this.set_name("AppDetailReqtPop");
                this.set_titletext("승인상세등록");
                this._setFormPosition(0,0,469,520);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "468", "519", null, null, this);
            obj.set_taborder("44");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "0", "0", "459", "70", null, null, this);
            obj.set_taborder("46");
            obj.set_text("승인상세등록");
            obj.set_cssclass("sta_POP_TitleBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "70", "468", "10", null, null, this);
            obj.set_taborder("47");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "458", "80", "10", "440", null, null, this);
            obj.set_taborder("48");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "80", "10", "352", null, null, this);
            obj.set_taborder("50");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Button("btnClose", "absolute", "399", "0", "70", "70", null, null, this);
            obj.set_taborder("45");
            obj.set_cssclass("btn_POP_XBtn");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "0", "499", "468", "20", null, null, this);
            obj.set_taborder("54");
            obj.set_text("h20");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "313", "420", "10", null, null, this);
            obj.set_taborder("68");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Button("btn_approve", "absolute", "393", "451", "65", "47", null, null, this);
            obj.set_taborder("70");
            obj.set_text("승인");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "12", "80", null, "59", "11", null, this);
            obj.set_taborder("71");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new Static("Static10", "absolute", "10", "80", "252", "59", null, null, this);
            obj.set_taborder("72");
            obj.set_text("요청금액(이전)");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "12", "138", null, "59", "11", null, this);
            obj.set_taborder("73");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "12", "196", null, "59", "11", null, this);
            obj.set_taborder("75");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "10", "138", "380", "59", null, null, this);
            obj.set_taborder("76");
            obj.set_text("종료일(이전)");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "12", "254", null, "59", "10", null, this);
            obj.set_taborder("77");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new MaskEdit("msk_price", "absolute", "208", "86", "250", "47", null, null, this);
            obj.set_taborder("79");
            obj.set_mask("@@@,@@@,@@@");
            obj.set_readonly("false");
            obj.style.set_color("red");
            obj.style.setStyleValue("color", "disabled", "#555555ff");
            obj.set_enable("false");
            this.addChild(obj.name, obj);

            obj = new MaskEdit("msk_price00", "absolute", "209", "202", "250", "47", null, null, this);
            obj.set_taborder("80");
            obj.set_value("0");
            obj.set_mask("@@@,@@@,@@@");
            obj.set_autoselect("true");
            obj.set_displaynulltext("0");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_toDay", "absolute", "209", "144", "250", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("82");
            obj.set_value("null");
            obj.set_dateformat("yyyy-MM-dd");
            obj.set_enable("false");

            obj = new Static("Static14", "absolute", "10", "254", "341", "59", null, null, this);
            obj.set_taborder("87");
            obj.set_text("종료일(이후)");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_toDay00", "absolute", "209", "260", "250", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("90");
            obj.set_value("null");
            obj.set_dateformat("yyyy-MM-dd");

            obj = new TextArea("txt_bigo", "absolute", "10", "323", "448", null, null, "77", this);
            obj.set_taborder("91");
            obj.set_imemode("hangul");
            obj.set_displaynulltext("비고를 입력하세요");
            obj.set_autoselect("true");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "10", "196", "252", "59", null, null, this);
            obj.set_taborder("92");
            obj.set_text("요청금액(이후)");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("sta_toDay00", "absolute", "209", "260", "250", "47", null, null, this);
            obj.set_taborder("93");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 469, 520, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("승인상세등록");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information
            obj = new BindItem("item6","txt_bigo","value","ds_grd00","remark");
            this.addChild(obj.name, obj);
            obj.bind();

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("AppDetailReqtPop.xfdl", "lib::lib_Com.xjs");
        this.registerScript("AppDetailReqtPop.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		임시여신승인
        // [부시스템명]	임시여신승인 상세등록
        // [설명]		    임시여신승인하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.02.02
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.02 : 강대성 : 화면설계.
        // 2015.04.01 : 강대성 : 화면수정.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"
        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/
        this.fv_pageRow = 10;	// 페이지당 건수
        this.fv_totalpageRow;	// 전체건수
        this.fv_curPageNum = 1;	// 페이지 번호

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
        	
        	application.goMain.gfn_POP_resize(this);
        }

        // 데이터 초기화
        this.fn_init = function ()
        {
        	this.arg = application.goMain.gfn_POP_getArg();
        	
        	//신청시 입력받았던 임시요청금액 및 요청한도일을 세팅해준다
        	this.msk_price.set_value(this.arg[0]);	
        	this.cal_toDay.set_value(this.arg[1]);	
        	
        	this.msk_price00.set_value(this.arg[2]);	
        	this.cal_toDay00.set_value(this.arg[3]);	
        	
        } 

        // 달력 클릭 시(From)
        this.sta_toDay00_onclick = function(obj,e)
        {
        	var objCalArg = this.cal_toDay00.value;
        	
        	application.goMain.gfn_POP_create("PopCalFrom", "cmmn::CmmnCalendarPop.xfdl", "fn_callbackPOP", this, objCalArg, "POP", application.goMain.divBase);
        	return false;
        }

        
        /*******************************************************************************
        * 기      능   :  승인버튼클릭시
        * 설      명   :  승인버튼클릭시 해당 데이터를 부모창에 넘겨준다.
        ********************************************************************************/ 
        this.btn_approve_onclick = function(obj,e)
        {
        	var arg = new Array();
        	
        	arg[0] = this.msk_price00.value; //(신청내역)임시여신
        	arg[1] = this.cal_toDay00.value; //(신청내역)임시여신종료일
        	arg[2] = this.txt_bigo.text;     //비고
        	application.goMain.gfn_POP_close(this, arg);
        }

        this.btnClose_onclick = function (obj,e)
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
        	
        }

        
        /** 
         * 팝업 callBack
         * @param  : popname - 팝업을 구분짓는 id
         rtn : 팝업이 닫히면서 전달된 값
         * @return : 없음
         */
        this.fn_callbackPOP = function (popname,rtn)
        {
        	switch (popname)
        	{
        		case "PopCalFrom":
        			this.cal_toDay00.set_value(rtn);
        			break;		
        	}
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.Static04.addEventHandler("onclick", this.Static04_onclick, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);
            this.btn_approve.addEventHandler("onclick", this.btn_approve_onclick, this);
            this.sta_toDay00.addEventHandler("onclick", this.sta_toDay00_onclick, this);

        };

        this.loadIncludeScript("AppDetailReqtPop.xfdl", true);

       
    };
}
)();
