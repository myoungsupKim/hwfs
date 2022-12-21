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
                this.set_name("Popup_Default");
                this.set_titletext("클레임처리신청");
                this._setFormPosition(0,0,540,760);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new Static("Static09", "absolute", "0", "350", null, "59", "0", null, this);
            obj.set_taborder("53");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "0", "292", null, "59", "0", null, this);
            obj.set_taborder("54");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "176", null, "59", "0", null, this);
            obj.set_taborder("58");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "0", "234", null, "59", "0", null, this);
            obj.set_taborder("60");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "0", "118", null, "59", "0", null, this);
            obj.set_taborder("61");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "0", "0", null, "2", "0", null, this);
            obj.set_taborder("0");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);

            obj = new Static("Static32", "absolute", "0", "2", null, "59", "0", null, this);
            obj.set_taborder("10");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static37", "absolute", "0", "60", null, "59", "0", null, this);
            obj.set_taborder("11");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static38", "absolute", "0", "60", "156", "59", null, null, this);
            obj.set_taborder("12");
            obj.set_text("식당(창고)");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit02", "absolute", "156", "8", null, "47", "10", null, this);
            obj.set_taborder("13");
            obj.set_value("한화빌딩점");
            obj.set_displaynulltext("한화빌딩점");
            this.addChild(obj.name, obj);

            obj = new Static("Static42", "absolute", "0", "2", "156", "59", null, null, this);
            obj.set_taborder("14");
            obj.set_text("사업장");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static43", "absolute", "136", "20", "20", "139", null, null, this);
            obj.set_taborder("15");
            obj.set_text("글자사이간격w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new TextArea("TextArea00", "absolute", "10", "419", null, null, "10", "67", this);
            obj.set_taborder("33");
            obj.set_displaynulltext("상세내용을 입력하세요");
            this.addChild(obj.name, obj);

            obj = new Button("Button07", "absolute", null, null, "65", "47", "80", "10", this);
            obj.set_taborder("35");
            obj.set_text("등록");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "0", "750", "540", "10", null, null, this);
            obj.set_taborder("36");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Button("Button01", "absolute", null, null, "65", "47", "10", "10", this);
            obj.set_taborder("37");
            obj.set_text("취소");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Static("Static12", "absolute", "460", "714", "5", "19", null, null, this);
            obj.set_taborder("39");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "0", "693", "540", "10", null, null, this);
            obj.set_taborder("40");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "419", "10", "274", null, null, this);
            obj.set_taborder("46");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static14", "absolute", "530", "419", "10", "331", null, null, this);
            obj.set_taborder("47");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Combo("Combo00", "absolute", "156", "66", null, "47", "10", null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("48");
            obj.set_text("창고명 선택");

            obj = new Calendar("Calendar00", "absolute", "156", "124", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("49");
            obj.set_displaynulltext("2015-12-29");

            obj = new Static("Static05", "absolute", "0", "118", "156", "59", null, null, this);
            obj.set_taborder("50");
            obj.set_text("입고일자");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Combo("Combo02", "absolute", "10", "356", null, "47", "10", null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("51");
            obj.set_text("처리요청내역을 선택");

            obj = new Combo("Combo01", "absolute", "10", "298", null, "47", "10", null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("52");
            obj.set_text("클레임유형을 선택");

            obj = new Edit("Edit01", "absolute", "10", "240", null, "47", "10", null, this);
            obj.set_taborder("55");
            obj.set_value("수량을 입력하세요");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit00", "absolute", "10", "182", null, "47", "10", null, this);
            obj.set_taborder("57");
            obj.set_value("품목명을 선택");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "409", "540", "10", null, null, this);
            obj.set_taborder("59");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Button("Button02", "absolute", null, "182", "47", "47", "10", null, this);
            obj.set_taborder("56");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("클레임처리신청");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script

        
        // Regist UI Components Event
        this.on_initEvent = function()
        {

        };

        this.loadIncludeScript("TEMPLATE_14.xfdl", true);

       
    };
}
)();
