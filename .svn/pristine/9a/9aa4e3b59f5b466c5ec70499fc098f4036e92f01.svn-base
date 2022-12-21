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
                this.set_titletext("상품상세내역");
                this._setFormPosition(0,0,420,576);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_grd", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"Column0\" type=\"STRING\" size=\"256\"/><Column id=\"Column1\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column0\">상품명</Col><Col id=\"Column1\">오이고추(아삭이)국산</Col></Row><Row><Col id=\"Column0\">규격</Col><Col id=\"Column1\">상/KG</Col></Row><Row><Col id=\"Column0\">단위</Col><Col id=\"Column1\">KG</Col></Row><Row><Col id=\"Column0\">보관방법</Col><Col id=\"Column1\">실온</Col></Row><Row><Col id=\"Column0\">원산지</Col><Col id=\"Column1\">국내산(계절별 산지이동)</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "420", "586", null, null, this);
            obj.set_taborder("44");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "0", "0", "420", "70", null, null, this);
            obj.set_taborder("46");
            obj.set_text("상품상세내역");
            obj.set_cssclass("sta_POP_TitleBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "70", "420", "10", null, null, this);
            obj.set_taborder("47");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "410", "80", "10", "486", null, null, this);
            obj.set_taborder("48");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "80", "10", "486", null, null, this);
            obj.set_taborder("50");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Button("btnClose", "absolute", "350", "0", "70", "70", null, null, this);
            obj.set_taborder("45");
            obj.set_cssclass("btn_POP_XBtn");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "0", "566", "420", "20", null, null, this);
            obj.set_taborder("54");
            obj.set_text("h20");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new ImageViewer("ImageViewer00", "absolute", "10", "80", "400", "225", null, null, this);
            obj.set_taborder("67");
            obj.style.set_background("#ffffffff URL('theme://Image/img_WF_NoImage.png') center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "305", "420", "10", null, null, this);
            obj.set_taborder("68");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid00", "absolute", "10", "315", "400", "251", null, null, this);
            obj.set_taborder("69");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("none");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"110\"/><Column size=\"290\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"Column0\"/><Cell col=\"1\" text=\"Column1\"/></Band><Band id=\"body\"><Cell cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:Column0\"/><Cell col=\"1\" style=\"align:left middle;\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:Column1\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "56", "549", null, "113", "362", null, this);
            obj.set_taborder("70");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "57", "660", null, "2", "354", null, this);
            obj.set_taborder("71");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "70", "645", "255", "35", null, null, this);
            obj.set_taborder("72");
            obj.set_text("CellClass : CellGrd_WF_LabelGray");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "224", "549", null, "73", "194", null, this);
            obj.set_taborder("73");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "225", "620", null, "2", "186", null, this);
            obj.set_taborder("74");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "238", "605", "382", "35", null, null, this);
            obj.set_taborder("75");
            obj.set_text("CellClass : CellGrd_WF_LabelWhite / Align  : left middle");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 420, 576, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("상품상세내역");

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

        this.loadIncludeScript("POPUP_TEMPLATE_01.xfdl", true);

       
    };
}
)();
