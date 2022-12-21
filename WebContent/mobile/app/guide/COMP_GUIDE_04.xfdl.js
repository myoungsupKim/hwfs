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
                this.set_name("GUIDE_class");
                this.set_titletext("ImageViewer,Div,PopupDiv");
                this._setFormPosition(0,0,540,719);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new Static("Static00", "absolute", "-1", "0", null, "50", "0", null, this);
            obj.set_taborder("0");
            obj.set_text("ImageViewer");
            obj.style.set_background("#edeee6ff");
            obj.style.set_border("1 solid #c6c6c5ff");
            obj.style.set_align("center middle");
            obj.style.set_font("antialias 15 Tahoma");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "25", "79", "100", "20", null, null, this);
            obj.set_taborder("2");
            obj.set_text("enabled");
            obj.style.set_color("#999999ff");
            obj.style.set_font("antialias 9 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "274", "79", "100", "20", null, null, this);
            obj.set_taborder("4");
            obj.set_text("disabled");
            obj.style.set_color("#999999ff");
            obj.style.set_font("antialias 9 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new ImageViewer("ImageViewer00", "absolute", "24", "112", "230", "207", null, null, this);
            obj.set_taborder("5");
            obj.style.set_background("#ffffffff URL('theme://Image/img_WF_NoImage.png') center middle");
            this.addChild(obj.name, obj);

            obj = new ImageViewer("ImageViewer01", "absolute", "280", "112", "230", "207", null, null, this);
            obj.set_taborder("6");
            obj.style.set_background("#ffffffff URL('theme://Image/img_WF_NoImage.png') center middle");
            obj.set_enable("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "-1", "358", null, "50", "0", null, this);
            obj.set_taborder("7");
            obj.set_text("Div / PopupDiv");
            obj.style.set_background("#edeee6ff");
            obj.style.set_border("1 solid #c6c6c5ff");
            obj.style.set_align("center middle");
            obj.style.set_font("antialias 15 Tahoma");
            this.addChild(obj.name, obj);

            obj = new Div("Div00", "absolute", "24", "474", "230", "207", null, null, this);
            obj.set_taborder("10");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "20", "405", "503", "69", null, null, this);
            obj.set_taborder("11");
            obj.set_text("- Div와 PopupDiv의 일반적인 사용은 Form을 로드해서 사용하거나 컴포넌트를 직접 정렬시켜 하는 경우가 대부분이며, 디자인 요소가 필요할 경우 Class로 지정해서 사용");
            obj.set_cssclass("sta_GUIDE_BlackText");
            this.addChild(obj.name, obj);

            obj = new PopupDiv("PopupDiv00", "absolute", "280", "474", "230", "207", null, null, this);
            obj.set_text("PopupDiv00");
            obj.set_visible("false");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 719, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("ImageViewer,Div,PopupDiv");

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

        this.loadIncludeScript("COMP_GUIDE_04.xfdl", true);

       
    };
}
)();
