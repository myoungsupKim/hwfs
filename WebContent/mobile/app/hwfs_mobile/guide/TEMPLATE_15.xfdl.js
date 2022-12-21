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
                this.set_titletext("팀장승인");
                this._setFormPosition(0,0,540,760);
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
            obj._setContents("<ColumnInfo><Column id=\"Column0\" type=\"STRING\" size=\"256\"/><Column id=\"Column1\" type=\"STRING\" size=\"256\"/><Column id=\"Column2\" type=\"STRING\" size=\"256\"/><Column id=\"Column3\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column0\">1</Col><Col id=\"Column1\">한화빌딩점</Col><Col id=\"Column2\">2015/11/16 ~ 2015/12/29</Col><Col id=\"Column3\">재고마감</Col></Row><Row><Col id=\"Column0\">1</Col><Col id=\"Column1\">한화빌딩점</Col><Col id=\"Column2\">2015/11/16 ~ 2015/12/29</Col><Col id=\"Column3\">재고마감</Col></Row><Row><Col id=\"Column0\">1</Col><Col id=\"Column1\">한화빌딩점</Col><Col id=\"Column2\">2015/11/16 ~ 2015/12/29</Col><Col id=\"Column3\">재고마감</Col></Row><Row><Col id=\"Column0\">1</Col><Col id=\"Column1\">한화빌딩점</Col><Col id=\"Column2\">2015/11/16 ~ 2015/12/29</Col><Col id=\"Column3\">재고마감</Col></Row><Row><Col id=\"Column0\">1</Col><Col id=\"Column1\">한화빌딩점</Col><Col id=\"Column2\">2015/11/16 ~ 2015/12/29</Col><Col id=\"Column3\">재고마감</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
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

            obj = new Static("Static42", "absolute", "0", "2", "113", "59", null, null, this);
            obj.set_taborder("14");
            obj.set_text("신청월");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static43", "absolute", "93", "17", "20", "29", null, null, this);
            obj.set_taborder("15");
            obj.set_text("글자사이간격w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Combo("Combo00", "absolute", "10", "66", null, "47", "394", null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("48");
            obj.set_text("구분");

            obj = new Calendar("Calendar00", "absolute", "113", "8", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("49");
            obj.set_displaynulltext("2015-12-29");

            obj = new Button("Button14", "absolute", null, "8", "100", "47", "10", null, this);
            obj.set_taborder("50");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Button("Button02", "absolute", null, "66", "117", "47", "150", null, this);
            obj.set_taborder("51");
            obj.set_text("전체삭제");
            this.addChild(obj.name, obj);

            obj = new Button("Button07", "absolute", null, "66", "65", "47", "10", null, this);
            obj.set_taborder("52");
            obj.set_text("반려");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Button("Button00", "absolute", null, "66", "65", "47", "80", null, this);
            obj.set_taborder("53");
            obj.set_text("승인");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Button("Button01", "absolute", null, "66", "117", "47", "272", null, this);
            obj.set_taborder("54");
            obj.set_text("전체선택");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid00", "absolute", "0", "118", null, "501", "0", null, this);
            obj.set_taborder("55");
            obj.set_binddataset("ds_grd");
            obj.set_cssclass("grd_WF_Default2");
            obj.set_scrollbars("none");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"10\"/><Column size=\"40\"/><Column size=\"370\"/><Column size=\"120\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"12\"/><Row size=\"38\"/><Row size=\"38\"/><Row size=\"12\"/></Rows><Band id=\"head\"><Cell/><Cell col=\"1\" text=\"Column0\"/><Cell col=\"2\" text=\"Column1\"/><Cell col=\"3\" text=\"Column2\"/></Band><Band id=\"body\"><Cell style=\"line:0 none;\"/><Cell col=\"1\" style=\"line:0 none;\"/><Cell col=\"2\" style=\"line:0 none;\"/><Cell col=\"3\" style=\"line:0 none;\"/><Cell row=\"1\" style=\"line:0 none;\"/><Cell row=\"1\" col=\"1\" displaytype=\"checkbox\" edittype=\"checkbox\" style=\"line:0 none;\" text=\"bind:Column0\"/><Cell row=\"1\" col=\"2\" style=\"line:0 none;\" text=\"bind:Column1\"/><Cell row=\"1\" col=\"3\" style=\"line:0 none;\"/><Cell row=\"2\" style=\"line:0 none;\"/><Cell row=\"2\" col=\"1\" style=\"line:0 none;\"/><Cell row=\"2\" col=\"2\" style=\"line:0 none;\" text=\"bind:Column2\"/><Cell row=\"2\" col=\"3\" style=\"line:0 none;\" cssclass=\"CellGrd_WF_ColorBlue\" text=\"bind:Column3\"/><Cell row=\"3\"/><Cell row=\"3\" col=\"1\"/><Cell row=\"3\" col=\"2\"/><Cell row=\"3\" col=\"3\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Button("Button36", "absolute", "0%", null, null, "35", "0%", "0", this);
            obj.set_taborder("56");
            obj.set_text("더보기");
            obj.set_cssclass("btn_WF_More");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "146", "72", "5", "29", null, null, this);
            obj.set_taborder("57");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "268", "72", "5", "29", null, null, this);
            obj.set_taborder("58");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "390", "72", "5", "29", null, null, this);
            obj.set_taborder("59");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "460", "72", "5", "29", null, null, this);
            obj.set_taborder("60");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "561", "122", "195", "35", null, null, this);
            obj.set_taborder("64");
            obj.set_text("Class : grd_WF_Default2");
            obj.set_cssclass("sta_GUIDE_RedText");
            obj.set_visible("false");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static10", "absolute", "515", "186", "37", "2", null, null, this);
            obj.set_taborder("66");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static11", "absolute", "561", "171", "524", "35", null, null, this);
            obj.set_taborder("67");
            obj.set_text("CellClass : CellGrd_WF_ColorBlue");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static16", "absolute", "25", "226", "527", "2", null, null, this);
            obj.set_taborder("72");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static17", "absolute", "25", "164", "2", "62", null, null, this);
            obj.set_taborder("73");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static18", "absolute", "561", "211", "334", "35", null, null, this);
            obj.set_taborder("74");
            obj.set_text("Displaytype : checkbox / Editdisplay : checkbox");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("팀장승인");

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
            this.Static16.addEventHandler("onclick", this.Static16_onclick, this);

        };

        this.loadIncludeScript("TEMPLATE_15.xfdl", true);

       
    };
}
)();
