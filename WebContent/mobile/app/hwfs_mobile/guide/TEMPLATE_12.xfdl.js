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
                this.set_titletext("재고등록");
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
            obj._setContents("<ColumnInfo><Column id=\"Column0\" type=\"STRING\" size=\"256\"/><Column id=\"Column1\" type=\"STRING\" size=\"256\"/><Column id=\"Column2\" type=\"STRING\" size=\"256\"/><Column id=\"Column3\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column0\">통감자(20kg/EA)</Col><Col id=\"Column1\">실/재고</Col><Col id=\"Column2\">150/</Col><Col id=\"Column3\">1000</Col></Row><Row><Col id=\"Column0\">통감자(20kg/EA)</Col><Col id=\"Column1\">실/재고</Col><Col id=\"Column2\">150/</Col><Col id=\"Column3\">1000</Col></Row><Row><Col id=\"Column0\">통감자(20kg/EA)</Col><Col id=\"Column1\">실/재고</Col><Col id=\"Column2\">150/</Col><Col id=\"Column3\">1000</Col></Row><Row><Col id=\"Column0\">통감자(20kg/EA)</Col><Col id=\"Column1\">실/재고</Col><Col id=\"Column2\">150/</Col><Col id=\"Column3\">1000</Col></Row><Row><Col id=\"Column0\">통감자(20kg/EA)</Col><Col id=\"Column1\">실/재고</Col><Col id=\"Column2\">150/</Col><Col id=\"Column3\">1000</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("Static01", "absolute", "0", "2", "540", "57", null, null, this);
            obj.set_taborder("3");
            obj.set_text("한촌강남점");
            obj.set_cssclass("sta_WF_Label01");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "0", "0", null, "2", "0", null, this);
            obj.set_taborder("4");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "59", null, "59", "0", null, this);
            obj.set_taborder("9");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Calendar("Calendar00", "absolute", "10", "65", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("10");
            obj.set_displaynulltext("2015-12-29");

            obj = new Combo("Combo00", "absolute", "210", "65", null, "47", "115", null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("11");
            obj.set_text("보관방법선택");
            obj.set_displaynulltext("보관방법선택");
            obj.set_value("null");

            obj = new Button("Button14", "absolute", "430", "65", "100", "47", null, null, this);
            obj.set_taborder("12");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "118", "540", "15", null, null, this);
            obj.set_taborder("13");
            obj.set_text("h15");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Button("Button00", "absolute", null, "133", "117", "47", "10", null, this);
            obj.set_taborder("14");
            obj.set_text("임시저장");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Button("Button07", "absolute", null, "133", "65", "47", "132", null, this);
            obj.set_taborder("15");
            obj.set_text("반영");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "0", "180", "540", "10", null, null, this);
            obj.set_taborder("16");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Button("Button36", "absolute", "0", null, null, "35", "0", "0", this);
            obj.set_taborder("17");
            obj.set_text("더보기");
            obj.set_cssclass("btn_WF_More");
            this.addChild(obj.name, obj);

            obj = new Static("Static22", "absolute", "408", "144", "5", "19", null, null, this);
            obj.set_taborder("18");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "530", "133", "10", "47", null, null, this);
            obj.set_taborder("19");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static33", "absolute", "205", "72", "5", "29", null, null, this);
            obj.set_taborder("21");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid00", "absolute", "0", "190", null, "511", "0", null, this);
            obj.set_taborder("22");
            obj.set_cssclass("grd_WF_Default2");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("none");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"166\"/><Column size=\"60\"/><Column size=\"100\"/><Column size=\"8\"/><Column size=\"197\"/><Column size=\"9\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"51\"/><Row size=\"51\"/></Rows><Band id=\"head\"><Cell text=\"Column0\"/><Cell col=\"1\" text=\"Column1\"/><Cell col=\"2\" text=\"Column2\"/><Cell col=\"3\"/><Cell col=\"4\" text=\"Column3\"/><Cell col=\"5\"/></Band><Band id=\"body\"><Cell colspan=\"6\" style=\"padding:0 10 0 10;line:0 none;\" text=\"bind:Column0\"/><Cell row=\"1\" style=\"padding:0 10 0 10;\" text=\"bind:Column1\"/><Cell row=\"1\" col=\"1\" text=\"bind:Column2\"/><Cell row=\"1\" col=\"2\" displaytype=\"number\" edittype=\"none\" style=\"align:right middle;\" text=\"bind:Column3\" editdisplay=\"display\"/><Cell row=\"1\" col=\"3\"/><Cell row=\"1\" col=\"4\" displaytype=\"date\" edittype=\"date\" text=\"2015-12-29\" calendardisplay=\"display\"/><Cell row=\"1\" col=\"5\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "561", "283", "334", "35", null, null, this);
            obj.set_taborder("23");
            obj.set_text("Padding : 0 10 0 10");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "45", "298", "507", "2", null, null, this);
            obj.set_taborder("24");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "45", "276", "2", "22", null, null, this);
            obj.set_taborder("25");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static18", "absolute", "561", "172", "195", "35", null, null, this);
            obj.set_taborder("26");
            obj.set_text("Class : grd_WF_Default2");
            obj.set_cssclass("sta_GUIDE_RedText");
            obj.set_visible("false");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "113", "226", "2", "72", null, null, this);
            obj.set_taborder("27");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static10", "absolute", "435", "236", "117", "2", null, null, this);
            obj.set_taborder("28");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static11", "absolute", "561", "221", "524", "35", null, null, this);
            obj.set_taborder("29");
            obj.set_text("Displaytype : date / Edittype : date /calendardisplay : display");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static12", "absolute", "433", "237", "2", "12", null, null, this);
            obj.set_taborder("30");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "561", "199", "524", "35", null, null, this);
            obj.set_taborder("31");
            obj.set_text("Displaytype : number / Editdisplay : display / Align : right middle");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static14", "absolute", "303", "215", "2", "32", null, null, this);
            obj.set_taborder("32");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "305", "214", "247", "2", null, null, this);
            obj.set_taborder("33");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static16", "absolute", "458", "772", "110", "2", null, null, this);
            obj.set_taborder("34");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static17", "absolute", "573", "758", "349", "30", null, null, this);
            obj.set_taborder("35");
            obj.set_text("Style : COMP_GUIDE_06_4의 List01  참조 ");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static19", "absolute", "458", "690", "2", "82", null, null, this);
            obj.set_taborder("36");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("재고등록");

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

        this.loadIncludeScript("TEMPLATE_12.xfdl", true);

       
    };
}
)();
