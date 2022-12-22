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
                this.set_titletext("거래처정보조회");
                this._setFormPosition(0,0,540,760);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_rdo", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"lev\" type=\"STRING\" size=\"256\"/><Column id=\"Column1\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"lev\">0</Col><Col id=\"Column1\">가망고객</Col></Row><Row><Col id=\"lev\">1</Col><Col id=\"Column1\">거래고객</Col></Row></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_grd", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"Column0\" type=\"STRING\" size=\"256\"/><Column id=\"Column1\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column0\">약정일</Col><Col id=\"Column1\">2015-12-29</Col></Row><Row><Col id=\"Column0\">대표자</Col><Col id=\"Column1\">홍길동</Col></Row><Row><Col id=\"Column0\">대표주소</Col><Col id=\"Column1\">홍길동</Col></Row><Row><Col id=\"Column0\">전화번호</Col><Col id=\"Column1\">010-777-7777</Col></Row><Row><Col id=\"Column0\">고객직군</Col><Col id=\"Column1\">FC</Col></Row><Row><Col id=\"Column0\">고객지역</Col><Col id=\"Column1\">서울</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("Static04", "absolute", "0", "0", null, "2", "0", null, this);
            obj.set_taborder("46");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "119", "540", "10", null, null, this);
            obj.set_taborder("47");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "129", "10", "361", null, null, this);
            obj.set_taborder("50");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static14", "absolute", "0", "2", null, "59", "0", null, this);
            obj.set_taborder("66");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit00", "absolute", "113", "8", null, "47", "10", null, this);
            obj.set_taborder("80");
            obj.set_value("거래처명을 입력하세요");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "0", "60", null, "59", "0", null, this);
            obj.set_taborder("82");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "93", "17", "20", "29", null, null, this);
            obj.set_taborder("84");
            obj.set_text("글자사이간격w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Button("Button00", "absolute", null, "66", "100", "47", "10", null, this);
            obj.set_taborder("86");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "0", "2", "135", "59", null, null, this);
            obj.set_taborder("87");
            obj.set_text("거래처");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Button("Button01", "absolute", null, "8", "47", "47", "10", null, this);
            obj.set_taborder("90");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "530", "129", "10", "361", null, null, this);
            obj.set_taborder("92");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Radio("Radio00", "absolute", "113", "66", "298", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("99");
            obj.set_innerdataset("@ds_rdo");
            obj.set_codecolumn("lev");
            obj.set_datacolumn("Column1");
            obj.set_value("0");
            obj.set_rowcount("1");
            obj.set_index("0");

            obj = new Grid("Grid00", "absolute", "10", "129", "520", "361", null, null, this);
            obj.set_taborder("104");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("none");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"130\"/><Column size=\"390\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"60\"/></Rows><Band id=\"head\"><Cell text=\"Column0\"/><Cell col=\"1\" text=\"Column1\"/></Band><Band id=\"body\"><Cell cssclass=\"CellGrd_WF_LabelIndigo\" text=\"bind:Column0\"/><Cell col=\"1\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:Column1\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Button("Button19", "absolute", "476", "316", "47", "47", null, null, this);
            obj.set_taborder("105");
            obj.set_cssclass("btn_WF_Phone");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "400", "130", "21", "59", null, null, this);
            obj.set_taborder("106");
            obj.set_text("h60");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "523", "325", "7", "29", null, null, this);
            obj.set_taborder("107");
            obj.set_text("w07");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static10", "absolute", "78", "472", "2", "85", null, null, this);
            obj.set_taborder("103");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "250", "503", null, "35", "78", null, this);
            obj.set_taborder("108");
            obj.set_text("CellClass : CellGrd_WF_LabelGray");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static11", "absolute", "233", "518", null, "2", "295", null, this);
            obj.set_taborder("109");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static16", "absolute", "232", "467", null, "53", "306", null, this);
            obj.set_taborder("110");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "250", "541", null, "35", "78", null, this);
            obj.set_taborder("111");
            obj.set_text("CellClass : CellGrd_WF_LabelIndigo");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static12", "absolute", "79", "556", null, "2", "298", null, this);
            obj.set_taborder("112");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "558", "303", null, "35", "-230", null, this);
            obj.set_taborder("113");
            obj.set_text("Class : btn_WF_Phone");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static17", "absolute", "521", "318", null, "2", "-13", null, this);
            obj.set_taborder("114");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("거래처정보조회");

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

        this.loadIncludeScript("TEMPLATE_03.xfdl", true);

       
    };
}
)();
