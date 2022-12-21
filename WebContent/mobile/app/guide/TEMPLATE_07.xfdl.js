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
                this.set_titletext("매출현황");
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
            obj._setContents("<ColumnInfo><Column id=\"업장명\" type=\"STRING\" size=\"256\"/><Column id=\"계획\" type=\"STRING\" size=\"256\"/><Column id=\"실적\" type=\"STRING\" size=\"256\"/><Column id=\"달성률\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"달성률\">100%</Col><Col id=\"계획\">일일계획</Col><Col id=\"실적\">실적</Col><Col id=\"업장명\">한촌_본사</Col></Row><Row><Col id=\"달성률\">100%</Col><Col id=\"계획\">일일계획</Col><Col id=\"실적\">실적</Col><Col id=\"업장명\">한화건설</Col></Row><Row><Col id=\"달성률\">100%</Col><Col id=\"계획\">일일계획</Col><Col id=\"실적\">실적</Col><Col id=\"업장명\">한화빌딩점</Col></Row><Row><Col id=\"달성률\">100%</Col><Col id=\"계획\">일일계획</Col><Col id=\"실적\">실적</Col><Col id=\"업장명\">한촌_역삼</Col></Row><Row><Col id=\"달성률\">100%</Col><Col id=\"계획\">일일계획</Col><Col id=\"실적\">실적</Col><Col id=\"업장명\">한화건설</Col></Row><Row><Col id=\"달성률\">100%</Col><Col id=\"계획\">일일계획</Col><Col id=\"실적\">실적</Col><Col id=\"업장명\">한화빌딩점</Col></Row><Row><Col id=\"달성률\">100%</Col><Col id=\"계획\">일일계획</Col><Col id=\"실적\">실적</Col><Col id=\"업장명\">안촉역삼</Col></Row><Row><Col id=\"달성률\">100%</Col><Col id=\"계획\">일일계획</Col><Col id=\"실적\">실적</Col><Col id=\"업장명\">한화건설</Col></Row><Row><Col id=\"달성률\">100%</Col><Col id=\"계획\">일일계획</Col><Col id=\"실적\">실적</Col><Col id=\"업장명\">한화빌딩점</Col></Row><Row><Col id=\"달성률\">100%</Col><Col id=\"실적\">실적</Col><Col id=\"계획\">일일계획</Col><Col id=\"업장명\">안촉역삼</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("Static04", "absolute", "0", "0", null, "2", "0", null, this);
            obj.set_taborder("0");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);

            obj = new Static("Static32", "absolute", "0", "2", null, "59", "0", null, this);
            obj.set_taborder("1");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static37", "absolute", "0", "60", null, "59", "0", null, this);
            obj.set_taborder("2");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static38", "absolute", "0", "60", "135", "59", null, null, this);
            obj.set_taborder("3");
            obj.set_text("검색일자");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit02", "absolute", "139", "8", null, "47", "10", null, this);
            obj.set_taborder("4");
            obj.set_value("운영1팀");
            this.addChild(obj.name, obj);

            obj = new Static("Static39", "absolute", "0", "118", null, "59", "0", null, this);
            obj.set_taborder("5");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Calendar("Calendar03", "absolute", "139", "66", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("6");
            obj.set_displaynulltext("2015-12-29");

            obj = new Button("Button01", "absolute", null, "66", "100", "47", "10", null, this);
            obj.set_taborder("7");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Static("Static42", "absolute", "0", "2", "135", "59", null, null, this);
            obj.set_taborder("8");
            obj.set_text("팀명");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static43", "absolute", "119", "15", "20", "89", null, null, this);
            obj.set_taborder("9");
            obj.set_text("글자사이간격w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Button("Button02", "absolute", null, "8", "47", "47", "10", null, this);
            obj.set_taborder("10");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);

            obj = new Combo("Combo00", "absolute", "10", "124", "180", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("11");
            obj.set_text("정렬조건");

            obj = new Button("Button17", "absolute", "257", "124", "47", "47", null, null, this);
            obj.set_taborder("12");
            obj.set_cssclass("btn_WF_UpMove");
            this.addChild(obj.name, obj);

            obj = new Button("Button15", "absolute", "205", "124", "47", "47", null, null, this);
            obj.set_taborder("13");
            obj.set_cssclass("btn_WF_DownMove");
            this.addChild(obj.name, obj);

            obj = new CheckBox("CheckBox00", "absolute", null, "124", "73", "47", "122", null, this);
            obj.set_taborder("14");
            obj.set_text("팀");
            obj.set_value("true");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", null, "124", "120", "47", "0", null, this);
            obj.set_taborder("15");
            obj.set_text("[단위천원]");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "190", "133", "15", "29", null, null, this);
            obj.set_taborder("16");
            obj.set_text("w15");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "252", "133", "5", "29", null, null, this);
            obj.set_taborder("17");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", null, "133", "18", "29", "120", null, this);
            obj.set_taborder("18");
            obj.set_text("w18");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "177", "540", "10", null, null, this);
            obj.set_taborder("19");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "187", "10", "538", null, null, this);
            obj.set_taborder("20");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "530", "187", "10", "538", null, null, this);
            obj.set_taborder("21");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid00", "absolute", "10", "187", null, "556", "10", null, this);
            obj.set_taborder("23");
            obj.set_scrollbars("none");
            obj.set_binddataset("ds_grd");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"205\"/><Column size=\"145\"/><Column size=\"70\"/><Column size=\"100\"/></Columns><Rows><Row size=\"55\" band=\"head\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"업장명\"/><Cell col=\"1\" text=\"계획\"/><Cell col=\"2\" text=\"실적\"/><Cell col=\"3\" text=\"달성률\"/></Band><Band id=\"body\"><Cell style=\"align:left middle;padding:0 10 0 10;\" text=\"bind:업장명\"/><Cell col=\"1\" text=\"bind:계획\"/><Cell col=\"2\" text=\"bind:실적\"/><Cell col=\"3\" text=\"bind:달성률\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Button("Button36", "absolute", "0", null, null, "35", "0", "0", this);
            obj.set_taborder("22");
            obj.set_text("더보기");
            obj.set_cssclass("btn_WF_More");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("매출현황");

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

        this.loadIncludeScript("TEMPLATE_07.xfdl", true);

       
    };
}
)();
