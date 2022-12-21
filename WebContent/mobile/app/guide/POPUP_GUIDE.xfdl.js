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
                this.set_name("Popup_Guide");
                this._setFormPosition(0,0,540,641);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new Static("Static00", "absolute", "0", "0", "540", "50", null, null, this);
            obj.set_taborder("0");
            obj.set_text("Popup_Guide");
            obj.style.set_background("#edeee6ff");
            obj.style.set_border("1 solid #c6c6c5ff");
            obj.style.set_align("center middle");
            obj.style.set_font("antialias 15 Tahoma");
            this.addChild(obj.name, obj);

            obj = new Static("staFormSize", "absolute", "60", "80", "420", "487", null, null, this);
            obj.set_taborder("44");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "60", "80", "420", "70", null, null, this);
            obj.set_taborder("46");
            obj.set_text("PopupTitle");
            obj.set_cssclass("sta_POP_TitleBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "60", "150", "420", "10", null, null, this);
            obj.set_taborder("47");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "470", "160", "10", "387", null, null, this);
            obj.set_taborder("48");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static14", "absolute", "60", "547", "420", "20", null, null, this);
            obj.set_taborder("49");
            obj.set_text("h20");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "60", "160", "10", "387", null, null, this);
            obj.set_taborder("50");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Button("btnClose", "absolute", "410", "80", "70", "70", null, null, this);
            obj.set_taborder("45");
            obj.set_cssclass("btn_POP_XBtn");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "70", "160", "400", "330", null, null, this);
            obj.set_taborder("51");
            obj.set_text("WorkArea");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.style.set_align("center");
            obj.style.set_font("9 bold9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "60", "595", "420", "20", null, null, this);
            obj.set_taborder("52");
            obj.set_text("w420 권장");
            obj.set_cssclass("sta_GUIDE_RedText");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Button("Button07", "absolute", "405", "500", "65", "47", null, null, this);
            obj.set_taborder("53");
            obj.set_text("버튼");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "60", "490", "420", "10", null, null, this);
            obj.set_taborder("54");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "60", "575", "2", "30", null, null, this);
            obj.set_taborder("55");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "478", "575", "2", "30", null, null, this);
            obj.set_taborder("56");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "60", "588", "420", "2", null, null, this);
            obj.set_taborder("57");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "458", "521", "110", "2", null, null, this);
            obj.set_taborder("58");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static37", "absolute", "573", "507", "180", "30", null, null, this);
            obj.set_taborder("59");
            obj.set_text("Class : btn_WF_Function");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static10", "absolute", "458", "116", "110", "2", null, null, this);
            obj.set_taborder("60");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static11", "absolute", "573", "102", "180", "30", null, null, this);
            obj.set_taborder("61");
            obj.set_text("Class : btn_POP_XBtn");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static12", "absolute", "388", "64", "170", "2", null, null, this);
            obj.set_taborder("62");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static16", "absolute", "573", "50", "180", "30", null, null, this);
            obj.set_taborder("63");
            obj.set_text("Class : sta_POP_TitleBg");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static17", "absolute", "386", "65", "2", "30", null, null, this);
            obj.set_taborder("64");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static18", "absolute", "458", "322", "110", "2", null, null, this);
            obj.set_taborder("65");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static19", "absolute", "573", "308", "349", "30", null, null, this);
            obj.set_taborder("66");
            obj.set_text("Class : sta_POP_Bg / Id : staFormSize");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 641, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");

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
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);

        };

        this.loadIncludeScript("POPUP_GUIDE.xfdl", true);

       
    };
}
)();
