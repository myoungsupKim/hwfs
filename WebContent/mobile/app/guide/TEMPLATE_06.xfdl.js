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
                this.set_titletext("긴급여신신청");
                this._setFormPosition(0,0,540,760);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new Static("Static04", "absolute", "0", "0", null, "2", "0", null, this);
            obj.set_taborder("0");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "467", "540", "10", null, null, this);
            obj.set_taborder("5");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static32", "absolute", "0", "2", null, "59", "0", null, this);
            obj.set_taborder("10");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static37", "absolute", "0", "60", null, "59", "0", null, this);
            obj.set_taborder("11");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static38", "absolute", "0", "60", "135", "59", null, null, this);
            obj.set_taborder("12");
            obj.set_text("요청자");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit02", "absolute", "139", "8", null, "47", "10", null, this);
            obj.set_taborder("13");
            obj.set_value("운영1팀");
            obj.set_displaynulltext("운영1팀");
            this.addChild(obj.name, obj);

            obj = new Static("Static42", "absolute", "0", "2", "135", "59", null, null, this);
            obj.set_taborder("14");
            obj.set_text("요청부서");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static43", "absolute", "119", "20", "20", "79", null, null, this);
            obj.set_taborder("15");
            obj.set_text("글자사이간격w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit03", "absolute", "139", "66", null, "47", "10", null, this);
            obj.set_taborder("16");
            obj.set_value("홍길동");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "176", null, "59", "0", null, this);
            obj.set_taborder("18");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "0", "118", null, "59", "0", null, this);
            obj.set_taborder("19");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit00", "absolute", "10", "124", null, "47", "10", null, this);
            obj.set_taborder("20");
            obj.set_value("본사를 입력하세요");
            this.addChild(obj.name, obj);

            obj = new Button("Button02", "absolute", null, "124", "47", "47", "10", null, this);
            obj.set_taborder("17");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit01", "absolute", "10", "182", null, "47", "10", null, this);
            obj.set_taborder("22");
            obj.set_value("사업장을 입력하세요");
            this.addChild(obj.name, obj);

            obj = new Button("Button00", "absolute", null, "182", "47", "47", "10", null, this);
            obj.set_taborder("21");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "0", "234", null, "59", "0", null, this);
            obj.set_taborder("24");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "0", "234", "540", "59", null, null, this);
            obj.set_taborder("23");
            obj.set_text("임시여신 요청금액");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "0", "292", null, "59", "0", null, this);
            obj.set_taborder("25");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new MaskEdit("MaskEdit00", "absolute", "10", "298", null, "47", "10", null, this);
            obj.set_taborder("26");
            obj.set_mask("@@@,@@@,@@@");
            obj.set_value("2500000");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "0", "350", null, "59", "0", null, this);
            obj.set_taborder("27");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static10", "absolute", "0", "350", "540", "59", null, null, this);
            obj.set_taborder("28");
            obj.set_text("요청자");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static11", "absolute", "0", "408", null, "59", "0", null, this);
            obj.set_taborder("29");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new TextArea("TextArea00", "absolute", "10", "477", null, null, "10", "67", this);
            obj.set_taborder("33");
            obj.set_displaynulltext("요청사유를 입력하세요");
            this.addChild(obj.name, obj);

            obj = new Button("Button09", "absolute", null, null, "117", "47", "150", "10", this);
            obj.set_taborder("34");
            obj.set_text("내역보기");
            obj.set_cssclass("btn_WF_Function");
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

            obj = new Static("Static03", "absolute", "390", "714", "5", "19", null, null, this);
            obj.set_taborder("38");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
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

            obj = new Calendar("Calendar01", "absolute", "10", "414", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("41");
            obj.set_displaynulltext("2015-12-29");

            obj = new Calendar("Calendar02", "absolute", "234", "414", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("42");
            obj.set_displaynulltext("2015-12-29");

            obj = new Static("Static34", "absolute", "213", "414", "21", "47", null, null, this);
            obj.set_taborder("43");
            obj.set_text("~");
            this.addChild(obj.name, obj);

            obj = new Static("Static35", "absolute", "205", "427", "8", "17", null, null, this);
            obj.set_taborder("44");
            obj.set_text("컴포넌트 사이 간격 h08");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static36", "absolute", "205", "451", "29", "17", null, null, this);
            obj.set_taborder("45");
            obj.set_text("w21");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "477", "10", "216", null, null, this);
            obj.set_taborder("46");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static14", "absolute", "530", "477", "10", "273", null, null, this);
            obj.set_taborder("47");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("긴급여신신청");

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

        this.loadIncludeScript("TEMPLATE_06.xfdl", true);

       
    };
}
)();
