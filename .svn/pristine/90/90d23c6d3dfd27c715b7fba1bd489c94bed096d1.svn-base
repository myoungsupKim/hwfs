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
                this.set_name("TeamLeaderAppTicketDetailPop");
                this.set_scrollbars("none");
                this.set_titletext("식권폐기승인상세내용");
                this._setFormPosition(0,0,520,670);
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
            obj = new Static("staFormSize", "absolute", "4", "1", "516", "669", null, null, this);
            obj.set_taborder("25");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("staTitle", "absolute", "0", "0", "520", "70", null, null, this);
            obj.set_taborder("1");
            obj.set_cssclass("sta_POP_TitleBg");
            obj.set_text("상세내용");
            this.addChild(obj.name, obj);

            obj = new Static("staBtnClose", "absolute", "400", "0", null, "67", "0", null, this);
            obj.set_taborder("29");
            this.addChild(obj.name, obj);

            obj = new Button("btnClose", "absolute", "451", "0", "70", "70", null, null, this);
            obj.set_taborder("10");
            obj.set_cssclass("btn_POP_XBtn");
            obj.getSetter("titletext").set("식권폐기승인상세내용");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "70", "521", "10", null, null, this);
            obj.set_taborder("30");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "511", "80", "10", "590", null, null, this);
            obj.set_taborder("31");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "80", "10", "590", null, null, this);
            obj.set_taborder("32");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "0", "661", "516", "10", null, null, this);
            obj.set_taborder("33");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "12", "80", null, "59", "11", null, this);
            obj.set_taborder("34");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "11", "138", null, "59", "12", null, this);
            obj.set_taborder("35");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "12", "196", null, "59", "11", null, this);
            obj.set_taborder("36");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "12", "254", null, "59", "11", null, this);
            obj.set_taborder("37");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "12", "312", null, "59", "11", null, this);
            obj.set_taborder("38");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "12", "370", null, "59", "11", null, this);
            obj.set_taborder("39");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "12", "428", null, "59", "11", null, this);
            obj.set_taborder("40");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new Static("Static10", "absolute", "12", "486", null, "59", "11", null, this);
            obj.set_taborder("41");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new Static("Static11", "absolute", "10", "80", "156", "59", null, null, this);
            obj.set_taborder("42");
            obj.set_text("구분");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static12", "absolute", "10", "138", "156", "59", null, null, this);
            obj.set_taborder("43");
            obj.set_text("식권종류");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static14", "absolute", "10", "196", "156", "59", null, null, this);
            obj.set_taborder("44");
            obj.set_text("자재코드");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "10", "254", "156", "59", null, null, this);
            obj.set_taborder("45");
            obj.set_text("단가");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static16", "absolute", "10", "312", "156", "59", null, null, this);
            obj.set_taborder("46");
            obj.set_text("수량");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static17", "absolute", "10", "370", "156", "59", null, null, this);
            obj.set_taborder("47");
            obj.set_text("금액");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static18", "absolute", "10", "428", "156", "59", null, null, this);
            obj.set_taborder("48");
            obj.set_text("시작번호");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static19", "absolute", "10", "486", "156", "59", null, null, this);
            obj.set_taborder("49");
            obj.set_text("종료번호");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new TextArea("txt_remark", "absolute", "10", "550", "501", "113", null, null, this);
            obj.set_taborder("50");
            this.addChild(obj.name, obj);

            obj = new MaskEdit("msk_uprice", "absolute", "139", "260", null, "47", "8", null, this);
            obj.set_taborder("54");
            obj.set_mask("@@@,@@@,@@@");
            obj.set_enable("false");
            obj.style.set_color("red");
            this.addChild(obj.name, obj);

            obj = new MaskEdit("msk_qty", "absolute", "139", "318", null, "47", "8", null, this);
            obj.set_taborder("55");
            obj.set_enable("false");
            obj.style.set_color("red");
            obj.set_mask("@@@,@@@,@@@");
            this.addChild(obj.name, obj);

            obj = new MaskEdit("msk_amt", "absolute", "139", "376", null, "47", "8", null, this);
            obj.set_taborder("56");
            obj.set_mask("@@@,@@@,@@@");
            obj.set_enable("false");
            obj.style.set_color("red");
            this.addChild(obj.name, obj);

            obj = new MaskEdit("msk_ticketStartnum", "absolute", "139", "434", null, "47", "8", null, this);
            obj.set_taborder("57");
            obj.set_enable("false");
            obj.style.set_color("red");
            obj.style.setStyleValue("color", "disabled", "#555555ff");
            this.addChild(obj.name, obj);

            obj = new MaskEdit("msk_ticketEndnum", "absolute", "139", "492", null, "47", "8", null, this);
            obj.set_taborder("58");
            obj.set_enable("false");
            obj.style.set_color("red");
            obj.style.setStyleValue("color", "disabled", "#555555ff");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_transGubunnm", "absolute", "141", "86", "371", "47", null, null, this);
            obj.set_taborder("59");
            obj.set_enable("false");
            obj.style.setStyleValue("align", "disabled", "right middle");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_itemTypenm", "absolute", "141", "144", "371", "47", null, null, this);
            obj.set_taborder("60");
            obj.set_enable("false");
            obj.style.setStyleValue("align", "disabled", "right middle");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_itemCode", "absolute", "141", "202", "371", "47", null, null, this);
            obj.set_taborder("61");
            obj.set_enable("false");
            obj.style.setStyleValue("align", "disabled", "right middle");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 520, 670, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_COMP_03");
            		p.set_scrollbars("none");
            		p.set_titletext("식권폐기승인상세내용");

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
        this.registerScript("TeamLeaderAppTicketDetailPop.xfdl", function(exports) {
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
        	this.edt_transGubunnm.set_value(this.arg[1]);	  //구분
        	this.edt_itemTypenm.set_value(this.arg[2]);	      //식권종류
        	this.edt_itemCode.set_value(this.arg[3]);         //자재코드
        	this.msk_uprice.set_value(this.arg[4]);           //단가
        	this.msk_qty.set_value(this.arg[5]);              //수량
        	this.msk_amt.set_value(this.arg[6]);              //금액
        	this.msk_ticketStartnum.set_value(this.arg[7]);   //시작번호
        	this.msk_ticketEndnum.set_value(this.arg[8]);     //종료번호
        	this.txt_remark.set_value(this.arg[9]);           //적요   
        	
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

        this.loadIncludeScript("TeamLeaderAppTicketDetailPop.xfdl", true);
        this.loadPreloadList();
       
    };
}
)();
