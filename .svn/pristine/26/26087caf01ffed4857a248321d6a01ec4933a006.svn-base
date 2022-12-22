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
                this.set_name("CmmnInputNumber");
                this.set_titletext("수량입력");
                this._setFormPosition(0,0,420,217);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "420", "217", null, null, this);
            obj.set_taborder("44");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "70", "420", "10", null, null, this);
            obj.set_taborder("47");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "410", "80", "10", "135", null, null, this);
            obj.set_taborder("48");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "80", "10", "136", null, null, this);
            obj.set_taborder("50");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "0", "196", "420", "20", null, null, this);
            obj.set_taborder("54");
            obj.set_text("h20");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "139", "420", "10", null, null, this);
            obj.set_taborder("68");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Button("btn_insert", "absolute", "345", "149", "65", "47", null, null, this);
            obj.set_taborder("1");
            obj.set_text("입력");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "12", "80", null, "59", "11", null, this);
            obj.set_taborder("72");
            obj.set_cssclass("sta_WFSA_LabelBg");
            obj.style.set_background("#ffffffff");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_count", "absolute", "9", "85", "401", "47", null, null, this);
            obj.set_taborder("0");
            obj.set_displaynulltext("수량을 입력하세요");
            obj.set_inputtype("number,dot");
            obj.set_autoselect("false");
            obj.style.set_align("right middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "0", "0", "420", "70", null, null, this);
            obj.set_taborder("74");
            obj.set_text("수량등록");
            obj.set_cssclass("sta_POP_TitleBg");
            this.addChild(obj.name, obj);

            obj = new Button("btnClose", "absolute", "350", "0", "70", "70", null, null, this);
            obj.set_taborder("2");
            obj.set_cssclass("btn_POP_XBtn");
            this.addChild(obj.name, obj);

            obj = new Static("sta_itemCode", "absolute", "17", "149", "143", "47", null, null, this);
            obj.set_taborder("75");
            obj.set_text("Static01");
            obj.style.set_color("blue");
            this.addChild(obj.name, obj);

            obj = new Static("sta_itemName", "absolute", "137", "149", "215", "47", null, null, this);
            obj.set_taborder("76");
            obj.set_text("Static01");
            obj.style.set_color("red");
            obj.set_wordwrap("char");
            this.addChild(obj.name, obj);

            obj = new MaskEdit("msk_count", "absolute", "464", "94", "400", "45", null, null, this);
            obj.set_taborder("77");
            obj.set_type("number");
            obj.set_mask("9,999.99");
            obj.set_maskchar("_");
            obj.set_limitbymask("decimal");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 420, 217, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("수량입력");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("CmmnInputNumber.xfdl", "lib::lib_Com.xjs");
        this.registerScript("CmmnInputNumber.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		수량등록
        // [부시스템명]	수량등록 팝업 - 조회
        // [설명]
        // 		부서 검색하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.02.04
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.04 : 강대성 : 수정이 필요하여 수정함.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/
        this.preDate = undefined;

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
        this.AppDetailReqtPop_onload = function(obj,e)
        {
        	this.arg = application.goMain.gfn_POP_getArg();
        	
        	this.edt_count.set_value(this.arg[0]);
        	this.sta_itemCode.set_text(this.arg[1]);
        	this.sta_itemName.set_text(this.arg[2]);
        	
        	var itemCount = this.edt_count.value;
        	application.goMain.gfn_POP_resize(this);
        	
        	if(this.edt_count.value == 0)
        	{
        		this.edt_count.set_value("");
        		this.edt_count.setFocus();
        	}
        	else
        	{
        		this.edt_count.setFocus();
        		this.edt_count.setSelect(this.edt_count.text.length, this.edt_count.text.length);
        	}
        }

        //닫기 버튼 클릭시
        this.btnClose_onclick = function (obj,e)
        {
        	application.goMain.gfn_POP_close(this, "CLOSEONLY");
        }

        //입력 버튼 클릭시
        this.btn_insert_onclick = function(obj,e)
        {

        	if (this.gfn_isNull(this.edt_count.value)){
        		application.goMain.gfn_Msg("OK", "알림", "신청수량을 입력하세요.", "OK", "OK");
                return;		
        	}
        	
        	if(this.edt_count.value <= 0)
        	{
        		application.goMain.gfn_Msg("OK", "알림", "신청수량은 '0'보다 커야 합니다.", "OK");
        		this.edt_count.set_value(0);
        		return;			
        	}
        	
        	application.goMain.gfn_POP_close(this, this.gfn_ToFixed(this.edt_count.value, 2));
        }

        this.msk_count_onchar = function(obj,e)
        {
        	var nVal = nexacro.replaceAll(e.posttext, ",", "");
        	var nidx = nVal.indexOf(".");
        	
        	if(nidx > -1)
        	{
        		nVal = nVal.substr(0, nidx);
        	}
        	
        	if(nVal.length > 4)
        	{
        		return false;
        	}
        }

        this.edt_count_onchar = function(obj,e)
        {
        	var nVal = nexacro.replaceAll(e.posttext, ",", "");
        	var nidx = nVal.indexOf(".");
        	
        	if(nidx > -1)
        	{
        		nVal = nVal.substr(0, nidx);
        	}
        	
        	if(nVal.length > 4)
        	{
        		return false;
        	}	
        }

        this.edt_count_onkeydown = function(obj,e)
        {
        	if(e.keycode == 13){this.getNextComponent(this.getFocus()).setFocus(); this.btn_insert_onclick();}
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.AppDetailReqtPop_onload, this);
            this.btn_insert.addEventHandler("onclick", this.btn_insert_onclick, this);
            this.edt_count.addEventHandler("onchar", this.edt_count_onchar, this);
            this.edt_count.addEventHandler("onkeydown", this.edt_count_onkeydown, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);
            this.msk_count.addEventHandler("onchar", this.msk_count_onchar, this);

        };

        this.loadIncludeScript("CmmnInputNumber.xfdl", true);

       
    };
}
)();
