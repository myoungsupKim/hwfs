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
                this.set_titletext("사진등록");
                this._setFormPosition(0,0,540,760);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new Static("Static04", "absolute", "0", "0", null, "2", "0", null, this);
            obj.set_taborder("0");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "177", "540", "10", null, null, this);
            obj.set_taborder("1");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static14", "absolute", "0", "2", null, "59", "0", null, this);
            obj.set_taborder("2");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "60", null, "59", "0", null, this);
            obj.set_taborder("3");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static25", "absolute", "0", "60", "135", "59", null, null, this);
            obj.set_taborder("4");
            obj.set_text("사업장");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "0", "118", null, "59", "0", null, this);
            obj.set_taborder("6");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Calendar("Calendar01", "absolute", "139", "8", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("8");
            obj.set_displaynulltext("2015-12-29");

            obj = new Static("Static01", "absolute", "0", "2", "135", "59", null, null, this);
            obj.set_taborder("10");
            obj.set_text("점검일자");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "119", "23", "20", "69", null, null, this);
            obj.set_taborder("11");
            obj.set_text("글자사이간격w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit01", "absolute", "139", "66", null, "47", "10", null, this);
            obj.set_taborder("12");
            obj.set_value("거래처명을 입력");
            obj.set_displaynulltext("거래처명을 입력");
            this.addChild(obj.name, obj);

            obj = new Button("Button01", "absolute", null, "66", "47", "47", "10", null, this);
            obj.set_taborder("13");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);

            obj = new Button("Button09", "absolute", null, "187", "117", "47", "184", null, this);
            obj.set_taborder("14");
            obj.set_text("사진찍기");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Button("Button11", "absolute", null, "187", "169", "47", "10", null, this);
            obj.set_taborder("15");
            obj.set_text("이미지업로드");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new ImageViewer("ImageViewer00", "absolute", "10", "244", null, null, "10", "173", this);
            obj.set_taborder("16");
            obj.style.set_background("#ffffffff URL('theme://Image/img_WF_NoImage.png') center middle");
            this.addChild(obj.name, obj);

            obj = new Combo("Combo00", "absolute", "10", "124", null, "47", "10", null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("17");
            obj.set_text("등록구분을 선택하세요");
            obj.set_displaynulltext("등록구분을 선택하세요");

            obj = new Static("Static03", "absolute", "0", "234", "540", "10", null, null, this);
            obj.set_taborder("18");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "356", "201", "5", "19", null, null, this);
            obj.set_taborder("19");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "244", "10", "343", null, null, this);
            obj.set_taborder("20");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "530", "187", "10", "400", null, null, this);
            obj.set_taborder("21");
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
            		p.set_titletext("사진등록");

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

        this.loadIncludeScript("TEMPLATE_08.xfdl", true);

       
    };
}
)();
