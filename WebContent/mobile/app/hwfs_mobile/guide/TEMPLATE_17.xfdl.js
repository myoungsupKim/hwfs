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
                this.set_titletext("Webzine");
                this._setFormPosition(0,0,540,760);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new Static("Static00", "absolute", "0", "0", null, "224", "0", null, this);
            obj.set_taborder("0");
            obj.set_cssclass("sta_WF_WebzineBg");
            this.addChild(obj.name, obj);

            obj = new Button("Button21", "absolute", "126", null, "37", "37", null, "20", this);
            obj.set_taborder("1");
            obj.set_cssclass("btn_WF_PrevMove");
            this.addChild(obj.name, obj);

            obj = new Button("Button24", "absolute", "183", null, "37", "37", null, "20", this);
            obj.set_taborder("2");
            obj.set_text("1");
            obj.set_cssclass("btn_WF_PageNum");
            this.addChild(obj.name, obj);

            obj = new Button("Button25", "absolute", "228", null, "37", "37", null, "20", this);
            obj.set_taborder("3");
            obj.set_text("2");
            obj.set_cssclass("btn_WF_PageNum");
            this.addChild(obj.name, obj);

            obj = new Button("Button26", "absolute", "273", null, "37", "37", null, "20", this);
            obj.set_taborder("4");
            obj.set_text("3");
            obj.set_cssclass("btn_WF_PageNum");
            this.addChild(obj.name, obj);

            obj = new Button("Button27", "absolute", "318", null, "37", "37", null, "20", this);
            obj.set_taborder("5");
            obj.set_text("4");
            obj.set_cssclass("btn_WF_PageNum");
            this.addChild(obj.name, obj);

            obj = new Button("Button28", "absolute", "375", null, "37", "37", null, "20", this);
            obj.set_taborder("6");
            obj.set_cssclass("btn_WF_NextMove");
            this.addChild(obj.name, obj);

            obj = new Static("Static56", "absolute", "163", "712", "20", "20", null, null, this);
            obj.set_taborder("7");
            obj.set_text("w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static57", "absolute", "355", "712", "20", "20", null, null, this);
            obj.set_taborder("8");
            obj.set_text("w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static58", "absolute", "220", "712", "8", "20", null, null, this);
            obj.set_taborder("9");
            obj.set_text("w08");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static59", "absolute", "265", "712", "8", "20", null, null, this);
            obj.set_taborder("10");
            obj.set_text("w08");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static60", "absolute", "310", "712", "8", "20", null, null, this);
            obj.set_taborder("11");
            obj.set_text("w08");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static51", "absolute", "0", "703", "126", "37", null, null, this);
            obj.set_taborder("12");
            obj.set_text("w126");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Div("Div00", "absolute", "0", "224", null, "479", "0", null, this);
            obj.set_taborder("13");
            obj.set_text("Div00");
            this.addChild(obj.name, obj);
            obj = new Div("Div00", "absolute", "20", "20", "134", "212", null, null, this.Div00);
            obj.set_taborder("0");
            obj.set_text("Div00");
            this.Div00.addChild(obj.name, obj);
            obj = new Static("Static00", "absolute", "0", "0", "134", "182", null, null, this.Div00.Div00);
            obj.set_taborder("0");
            obj.set_cssclass("sta_WF_WebzineImgBg");
            this.Div00.Div00.addChild(obj.name, obj);
            obj = new Static("Static01", "absolute", "0", "187", "134", "25", null, null, this.Div00.Div00);
            obj.set_taborder("1");
            obj.set_text("1월 eFoodist");
            obj.set_cssclass("sta_WF_WebzineText");
            this.Div00.Div00.addChild(obj.name, obj);
            obj = new Static("Static02", "absolute", "6", "6", "122", "170", null, null, this.Div00.Div00);
            obj.set_taborder("2");
            obj.set_cssclass("sta_WF_WebzineImg");
            obj.style.set_background("#ebebebff URL('theme://Image/sta_WF_WebzineBg.png')");
            this.Div00.Div00.addChild(obj.name, obj);
            obj = new Static("Static04", "absolute", "0", "182", "29", "5", null, null, this.Div00.Div00);
            obj.set_taborder("3");
            obj.set_text("h05");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.Div00.Div00.addChild(obj.name, obj);
            obj = new Static("Static01", "absolute", "0", "120", "20", "190", null, null, this.Div00);
            obj.set_taborder("1");
            obj.set_text("w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("middle");
            this.Div00.addChild(obj.name, obj);
            obj = new Static("Static00", "absolute", "520", "120", "20", "190", null, null, this.Div00);
            obj.set_taborder("2");
            obj.set_text("w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("middle");
            this.Div00.addChild(obj.name, obj);
            obj = new Static("Static02", "absolute", "68", "0", "402", "20", null, null, this.Div00);
            obj.set_taborder("3");
            obj.set_text("h20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("middle");
            this.Div00.addChild(obj.name, obj);
            obj = new Static("Static03", "absolute", "68", "461", "402", "18", null, null, this.Div00);
            obj.set_taborder("4");
            obj.set_text("h18");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("middle");
            this.Div00.addChild(obj.name, obj);
            obj = new Static("Static04", "absolute", "154", "96", "49", "37", null, null, this.Div00);
            obj.set_taborder("5");
            obj.set_text("w49");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.Div00.addChild(obj.name, obj);
            obj = new Static("Static05", "absolute", "337", "96", "49", "37", null, null, this.Div00);
            obj.set_taborder("7");
            obj.set_text("w49");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.Div00.addChild(obj.name, obj);
            obj = new Static("Static06", "absolute", "64", "232", "385", "17", null, null, this.Div00);
            obj.set_taborder("9");
            obj.set_text("h17");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.Div00.addChild(obj.name, obj);
            obj = new Static("Static07", "absolute", "154", "324", "49", "37", null, null, this.Div00);
            obj.set_taborder("13");
            obj.set_text("w49");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.Div00.addChild(obj.name, obj);
            obj = new Static("Static08", "absolute", "337", "324", "49", "37", null, null, this.Div00);
            obj.set_taborder("14");
            obj.set_text("w49");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.Div00.addChild(obj.name, obj);
            obj = new Div("Div01", "absolute", "203", "20", "134", "212", null, null, this.Div00);
            obj.set_taborder("15");
            obj.set_text("Div00");
            this.Div00.addChild(obj.name, obj);
            obj = new Static("Static00", "absolute", "0", "0", "134", "182", null, null, this.Div00.Div01);
            obj.set_taborder("3");
            obj.set_cssclass("sta_WF_WebzineImgBg");
            this.Div00.Div01.addChild(obj.name, obj);
            obj = new Static("Static01", "absolute", "0", "187", "134", "25", null, null, this.Div00.Div01);
            obj.set_taborder("4");
            obj.set_text("12월 eFoodist");
            obj.set_cssclass("sta_WF_WebzineText");
            this.Div00.Div01.addChild(obj.name, obj);
            obj = new Static("Static02", "absolute", "6", "6", "122", "170", null, null, this.Div00.Div01);
            obj.set_taborder("5");
            obj.set_cssclass("sta_WF_WebzineImg");
            obj.style.set_background("#ebebebff URL('theme://Image/sta_WF_WebzineBg.png')");
            this.Div00.Div01.addChild(obj.name, obj);
            obj = new Static("Static04", "absolute", "0", "182", "29", "5", null, null, this.Div00.Div01);
            obj.set_taborder("6");
            obj.set_text("h05");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.Div00.Div01.addChild(obj.name, obj);
            obj = new Div("Div02", "absolute", "386", "20", "134", "212", null, null, this.Div00);
            obj.set_taborder("16");
            obj.set_text("Div00");
            this.Div00.addChild(obj.name, obj);
            obj = new Static("Static00", "absolute", "0", "0", "134", "182", null, null, this.Div00.Div02);
            obj.set_taborder("3");
            obj.set_cssclass("sta_WF_WebzineImgBg");
            this.Div00.Div02.addChild(obj.name, obj);
            obj = new Static("Static01", "absolute", "0", "187", "134", "25", null, null, this.Div00.Div02);
            obj.set_taborder("4");
            obj.set_text("11월 eFoodist");
            obj.set_cssclass("sta_WF_WebzineText");
            this.Div00.Div02.addChild(obj.name, obj);
            obj = new Static("Static02", "absolute", "6", "6", "122", "170", null, null, this.Div00.Div02);
            obj.set_taborder("5");
            obj.set_cssclass("sta_WF_WebzineImg");
            obj.style.set_background("#ebebebff URL('theme://Image/sta_WF_WebzineBg.png')");
            this.Div00.Div02.addChild(obj.name, obj);
            obj = new Static("Static04", "absolute", "0", "182", "29", "5", null, null, this.Div00.Div02);
            obj.set_taborder("6");
            obj.set_text("h05");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.Div00.Div02.addChild(obj.name, obj);
            obj = new Div("Div03", "absolute", "386", "249", "134", "212", null, null, this.Div00);
            obj.set_taborder("17");
            obj.set_text("Div00");
            this.Div00.addChild(obj.name, obj);
            obj = new Static("Static00", "absolute", "0", "0", "134", "182", null, null, this.Div00.Div03);
            obj.set_taborder("6");
            obj.set_cssclass("sta_WF_WebzineImgBg");
            this.Div00.Div03.addChild(obj.name, obj);
            obj = new Static("Static01", "absolute", "0", "187", "134", "25", null, null, this.Div00.Div03);
            obj.set_taborder("7");
            obj.set_text("8월 eFoodist");
            obj.set_cssclass("sta_WF_WebzineText");
            this.Div00.Div03.addChild(obj.name, obj);
            obj = new Static("Static02", "absolute", "6", "6", "122", "170", null, null, this.Div00.Div03);
            obj.set_taborder("8");
            obj.set_cssclass("sta_WF_WebzineImg");
            obj.style.set_background("#ebebebff URL('theme://Image/sta_WF_WebzineBg.png')");
            this.Div00.Div03.addChild(obj.name, obj);
            obj = new Static("Static04", "absolute", "0", "182", "29", "5", null, null, this.Div00.Div03);
            obj.set_taborder("9");
            obj.set_text("h05");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.Div00.Div03.addChild(obj.name, obj);
            obj = new Div("Div04", "absolute", "203", "249", "134", "212", null, null, this.Div00);
            obj.set_taborder("18");
            obj.set_text("Div00");
            this.Div00.addChild(obj.name, obj);
            obj = new Static("Static00", "absolute", "0", "0", "134", "182", null, null, this.Div00.Div04);
            obj.set_taborder("6");
            obj.set_cssclass("sta_WF_WebzineImgBg");
            this.Div00.Div04.addChild(obj.name, obj);
            obj = new Static("Static01", "absolute", "0", "187", "134", "25", null, null, this.Div00.Div04);
            obj.set_taborder("7");
            obj.set_text("9월 eFoodist");
            obj.set_cssclass("sta_WF_WebzineText");
            this.Div00.Div04.addChild(obj.name, obj);
            obj = new Static("Static02", "absolute", "6", "6", "122", "170", null, null, this.Div00.Div04);
            obj.set_taborder("8");
            obj.set_cssclass("sta_WF_WebzineImg");
            obj.style.set_background("#ebebebff URL('theme://Image/sta_WF_WebzineBg.png')");
            this.Div00.Div04.addChild(obj.name, obj);
            obj = new Static("Static04", "absolute", "0", "182", "29", "5", null, null, this.Div00.Div04);
            obj.set_taborder("9");
            obj.set_text("h05");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.Div00.Div04.addChild(obj.name, obj);
            obj = new Div("Div05", "absolute", "20", "249", "134", "212", null, null, this.Div00);
            obj.set_taborder("19");
            obj.set_text("Div00");
            this.Div00.addChild(obj.name, obj);
            obj = new Static("Static00", "absolute", "0", "0", "134", "182", null, null, this.Div00.Div05);
            obj.set_taborder("3");
            obj.set_cssclass("sta_WF_WebzineImgBg");
            this.Div00.Div05.addChild(obj.name, obj);
            obj = new Static("Static01", "absolute", "0", "187", "134", "25", null, null, this.Div00.Div05);
            obj.set_taborder("4");
            obj.set_text("10월 eFoodist");
            obj.set_cssclass("sta_WF_WebzineText");
            this.Div00.Div05.addChild(obj.name, obj);
            obj = new Static("Static02", "absolute", "6", "6", "122", "170", null, null, this.Div00.Div05);
            obj.set_taborder("5");
            obj.set_cssclass("sta_WF_WebzineImg");
            obj.style.set_background("#ebebebff URL('theme://Image/sta_WF_WebzineBg.png')");
            this.Div00.Div05.addChild(obj.name, obj);
            obj = new Static("Static04", "absolute", "0", "182", "29", "5", null, null, this.Div00.Div05);
            obj.set_taborder("6");
            obj.set_text("h05");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.Div00.Div05.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "0", "740", "540", "20", null, null, this);
            obj.set_taborder("14");
            obj.set_text("h20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("middle");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 134, 212, this.Div00.Div00,
            	//-- Layout function
            	function(p) {
            		p.set_taborder("0");
            		p.set_text("Div00");

            	}
            );
            this.Div00.Div00.addLayout(obj.name, obj);

            //-- Default Layout
            obj = new Layout("default", "", 134, 212, this.Div00.Div01,
            	//-- Layout function
            	function(p) {
            		p.set_taborder("15");
            		p.set_text("Div00");

            	}
            );
            this.Div00.Div01.addLayout(obj.name, obj);

            //-- Default Layout
            obj = new Layout("default", "", 134, 212, this.Div00.Div02,
            	//-- Layout function
            	function(p) {
            		p.set_taborder("16");
            		p.set_text("Div00");

            	}
            );
            this.Div00.Div02.addLayout(obj.name, obj);

            //-- Default Layout
            obj = new Layout("default", "", 134, 212, this.Div00.Div03,
            	//-- Layout function
            	function(p) {
            		p.set_taborder("17");
            		p.set_text("Div00");

            	}
            );
            this.Div00.Div03.addLayout(obj.name, obj);

            //-- Default Layout
            obj = new Layout("default", "", 134, 212, this.Div00.Div04,
            	//-- Layout function
            	function(p) {
            		p.set_taborder("18");
            		p.set_text("Div00");

            	}
            );
            this.Div00.Div04.addLayout(obj.name, obj);

            //-- Default Layout
            obj = new Layout("default", "", 134, 212, this.Div00.Div05,
            	//-- Layout function
            	function(p) {
            		p.set_taborder("19");
            		p.set_text("Div00");

            	}
            );
            this.Div00.Div05.addLayout(obj.name, obj);

            //-- Default Layout
            obj = new Layout("default", "", 0, 479, this.Div00,
            	//-- Layout function
            	function(p) {
            		p.set_taborder("13");
            		p.set_text("Div00");

            	}
            );
            this.Div00.addLayout(obj.name, obj);

            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("Webzine");

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

        this.loadIncludeScript("TEMPLATE_17.xfdl", true);

       
    };
}
)();
