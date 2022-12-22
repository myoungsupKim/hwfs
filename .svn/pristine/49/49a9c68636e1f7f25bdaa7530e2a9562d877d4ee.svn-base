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
                this.set_titletext("거래처별 채권");
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
            obj._setContents("<ColumnInfo><Column id=\"lev\" type=\"STRING\" size=\"256\"/><Column id=\"Column1\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"lev\">0</Col><Col id=\"Column1\">본사</Col></Row><Row><Col id=\"lev\">1</Col><Col id=\"Column1\">사업장</Col></Row></Rows>");
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
            obj._setContents("<ColumnInfo><Column id=\"Column0\" type=\"STRING\" size=\"256\"/><Column id=\"Column1\" type=\"STRING\" size=\"256\"/><Column id=\"Column2\" type=\"STRING\" size=\"256\"/><Column id=\"Column3\" type=\"STRING\" size=\"256\"/><Column id=\"Column4\" type=\"STRING\" size=\"256\"/><Column id=\"Column5\" type=\"STRING\" size=\"256\"/><Column id=\"Column6\" type=\"STRING\" size=\"256\"/><Column id=\"Column7\" type=\"STRING\" size=\"256\"/><Column id=\"Column8\" type=\"STRING\" size=\"256\"/><Column id=\"Column9\" type=\"STRING\" size=\"256\"/><Column id=\"Column10\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column0\">업체</Col><Col id=\"Column1\">한촌-강남점</Col><Col id=\"Column2\">채권</Col><Col id=\"Column3\">30000</Col><Col id=\"Column4\">100000</Col><Col id=\"Column5\">총여신</Col><Col id=\"Column6\">2500</Col><Col id=\"Column7\">매출</Col><Col id=\"Column8\">50000</Col><Col id=\"Column9\">입금</Col><Col id=\"Column10\">40000</Col></Row><Row><Col id=\"Column0\">업체</Col><Col id=\"Column1\">한촌-강남점</Col><Col id=\"Column2\">채권</Col><Col id=\"Column3\">30000</Col><Col id=\"Column4\">100000</Col><Col id=\"Column5\">총여신</Col><Col id=\"Column6\">2500</Col><Col id=\"Column7\">매출</Col><Col id=\"Column8\">50000</Col><Col id=\"Column9\">입금</Col><Col id=\"Column10\">40000</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("Static00", "absolute", "0", "60", null, "59", "0", null, this);
            obj.set_taborder("108");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "0", "0", null, "2", "0", null, this);
            obj.set_taborder("46");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "177", "540", "10", null, null, this);
            obj.set_taborder("47");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "187", "10", "501", null, null, this);
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

            obj = new Edit("Edit00", "absolute", "139", "8", null, "47", "10", null, this);
            obj.set_taborder("80");
            obj.set_value("영업사원명을 입력하세요");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "0", "118", null, "59", "0", null, this);
            obj.set_taborder("82");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "119", "17", "20", "29", null, null, this);
            obj.set_taborder("84");
            obj.set_text("글자사이간격w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Button("Button00", "absolute", null, "124", "100", "47", "10", null, this);
            obj.set_taborder("86");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "0", "2", "135", "59", null, null, this);
            obj.set_taborder("87");
            obj.set_text("영업사원");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Button("Button01", "absolute", null, "8", "47", "47", "10", null, this);
            obj.set_taborder("90");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "530", "187", "10", "501", null, null, this);
            obj.set_taborder("92");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Radio("Radio00", "absolute", "139", "124", "238", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("99");
            obj.set_innerdataset("@ds_rdo");
            obj.set_codecolumn("lev");
            obj.set_datacolumn("Column1");
            obj.set_value("0");
            obj.set_rowcount("1");
            obj.set_index("0");

            obj = new Grid("Grid01", "absolute", "10", "187", "520", "501", null, null, this);
            obj.set_taborder("100");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("none");
            obj.set_selecttype("cell");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"110\"/><Column size=\"205\"/><Column size=\"205\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"GrayLabel\"/><Cell col=\"1\" text=\"WhiteLabel\"/><Cell col=\"2\" text=\"WhiteLabel\"/></Band><Band id=\"body\"><Cell colspan=\"3\" celltype=\"none\" cssclass=\"CellGrd_WF_LabelIndigo\" text=\"bind:Column1\"/><Cell row=\"1\" celltype=\"none\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:Column2\"/><Cell row=\"1\" col=\"1\" displaytype=\"number\" edittype=\"none\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:Column3\"/><Cell row=\"1\" col=\"2\" displaytype=\"number\" edittype=\"none\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:Column4\"/><Cell row=\"2\" celltype=\"none\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:Column5\"/><Cell row=\"2\" col=\"1\" colspan=\"2\" displaytype=\"number\" edittype=\"none\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:Column6\"/><Cell row=\"3\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:Column7\"/><Cell row=\"3\" col=\"1\" colspan=\"2\" displaytype=\"number\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:Column8\"/><Cell row=\"4\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:Column9\"/><Cell row=\"4\" col=\"1\" colspan=\"2\" displaytype=\"number\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:Column10\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static18", "absolute", "168", "712", "110", "2", null, null, this);
            obj.set_taborder("101");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "283", "698", "349", "30", null, null, this);
            obj.set_taborder("102");
            obj.set_text("Style : COMP_GUIDE_06_3의 Detail02  참조 ");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static10", "absolute", "168", "660", "2", "52", null, null, this);
            obj.set_taborder("103");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Calendar("Calendar00", "absolute", "335", "66", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("104");
            obj.set_displaynulltext("2015-12-29");

            obj = new Static("Static09", "absolute", "119", "73", "20", "29", null, null, this);
            obj.set_taborder("105");
            obj.set_text("글자사이간격w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Calendar("Calendar01", "absolute", "139", "66", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("106");
            obj.set_displaynulltext("2015-12-29");

            obj = new Static("Static25", "absolute", "0", "60", "135", "59", null, null, this);
            obj.set_taborder("107");
            obj.set_text("해당기간");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("거래처별 채권");

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

        this.loadIncludeScript("TEMPLATE_02.xfdl", true);

       
    };
}
)();
