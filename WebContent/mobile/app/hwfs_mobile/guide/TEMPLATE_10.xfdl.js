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
                this.set_titletext("일일발주현황");
                this._setFormPosition(0,0,540,760);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_grdSummary", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"Column0\" type=\"STRING\" size=\"256\"/><Column id=\"Column1\" type=\"STRING\" size=\"256\"/><Column id=\"Column2\" type=\"STRING\" size=\"256\"/><Column id=\"Column3\" type=\"STRING\" size=\"256\"/><Column id=\"Column4\" type=\"STRING\" size=\"256\"/><Column id=\"Column5\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column0\">공급가</Col><Col id=\"Column1\">부가세</Col><Col id=\"Column2\">총발주금액</Col><Col id=\"Column3\">100000</Col><Col id=\"Column4\">5000</Col><Col id=\"Column5\">105000</Col></Row></Rows>");
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
            obj._setContents("<ColumnInfo><Column id=\"Column1\" type=\"STRING\" size=\"256\"/><Column id=\"Column2\" type=\"STRING\" size=\"256\"/><Column id=\"Column3\" type=\"STRING\" size=\"256\"/><Column id=\"Column4\" type=\"STRING\" size=\"256\"/><Column id=\"Column5\" type=\"STRING\" size=\"256\"/><Column id=\"Column6\" type=\"STRING\" size=\"256\"/><Column id=\"Column7\" type=\"STRING\" size=\"256\"/><Column id=\"Column8\" type=\"STRING\" size=\"256\"/><Column id=\"Column9\" type=\"STRING\" size=\"256\"/><Column id=\"Column10\" type=\"STRING\" size=\"256\"/><Column id=\"Column11\" type=\"STRING\" size=\"256\"/><Column id=\"Column12\" type=\"STRING\" size=\"256\"/><Column id=\"Column13\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column1\">소고기 한우 ++A 특수부위</Col><Col id=\"Column2\">규격</Col><Col id=\"Column3\">3523 X 1213</Col><Col id=\"Column4\">수량</Col><Col id=\"Column5\">100</Col><Col id=\"Column6\">코드</Col><Col id=\"Column7\">100700</Col><Col id=\"Column8\">단위</Col><Col id=\"Column9\">200Kg</Col><Col id=\"Column10\">단가</Col><Col id=\"Column11\">12000</Col><Col id=\"Column12\">금액</Col><Col id=\"Column13\">71000</Col></Row><Row><Col id=\"Column1\">소고기 한우 ++A 특수부위</Col><Col id=\"Column2\">규격</Col><Col id=\"Column3\">3523 X 1213</Col><Col id=\"Column4\">수량</Col><Col id=\"Column5\">100</Col><Col id=\"Column6\">코드</Col><Col id=\"Column7\">100700</Col><Col id=\"Column8\">단위</Col><Col id=\"Column9\">200Kg</Col><Col id=\"Column10\">단가</Col><Col id=\"Column11\">12000</Col><Col id=\"Column12\">금액</Col><Col id=\"Column13\">71000</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("Static01", "absolute", "0", "63", "540", "57", null, null, this);
            obj.set_taborder("3");
            obj.set_text("한촌강남점");
            obj.set_cssclass("sta_WF_Label01");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "120", null, "59", "0", null, this);
            obj.set_taborder("4");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Button("Button36", "absolute", "0", null, null, "35", "0", "0", this);
            obj.set_taborder("11");
            obj.set_text("더보기");
            obj.set_cssclass("btn_WF_More");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "530", "247", "10", "478", null, null, this);
            obj.set_taborder("12");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "247", "10", "478", null, null, this);
            obj.set_taborder("13");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Button("Button02", "absolute", "270", "0", "270", "63", null, null, this);
            obj.set_taborder("14");
            obj.set_text("모바일");
            obj.set_cssclass("btn_WF_TabTFOff");
            this.addChild(obj.name, obj);

            obj = new Button("Button03", "absolute", "0", "0", "270", "63", null, null, this);
            obj.set_taborder("15");
            obj.set_text("전체발주");
            obj.set_cssclass("btn_WF_TabTFOn");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "0", "178", null, "59", "0", null, this);
            obj.set_taborder("16");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Button("Button05", "absolute", null, "184", "100", "47", "10", null, this);
            obj.set_taborder("19");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Combo("Combo00", "absolute", "10", "126", null, "47", "10", null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("20");
            obj.set_text("창고명 선택");

            obj = new Calendar("Calendar01", "absolute", "10", "184", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("21");
            obj.set_displaynulltext("2015-12-29");

            obj = new Calendar("Calendar02", "absolute", "225", "184", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("22");
            obj.set_displaynulltext("2015-12-29");

            obj = new Static("Static34", "absolute", "210", "184", "15", "47", null, null, this);
            obj.set_taborder("23");
            obj.set_text("~");
            this.addChild(obj.name, obj);

            obj = new Static("Static35", "absolute", "205", "197", "5", "17", null, null, this);
            obj.set_taborder("24");
            obj.set_text("컴포넌트 사이 간격 h08");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static36", "absolute", "205", "221", "20", "17", null, null, this);
            obj.set_taborder("25");
            obj.set_text("w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid00", "absolute", "10", "247", null, "122", "10", null, this);
            obj.set_cssclass("grd_WF_SumType");
            obj.set_taborder("26");
            obj.set_binddataset("ds_grdSummary");
            obj.set_scrollbars("none");
            obj.set_selecttype("cell");
            obj.set_autosizingtype("row");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"140\"/><Column size=\"380\" band=\"right\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"10\"/><Row size=\"34\"/><Row size=\"34\"/><Row size=\"34\"/><Row size=\"10\"/></Rows><Band id=\"head\"><Cell text=\"GrayLabel\"/><Cell col=\"1\" text=\"WhiteLabel\"/></Band><Band id=\"body\"><Cell/><Cell col=\"1\"/><Cell row=\"1\" celltype=\"none\" text=\"bind:Column0\"/><Cell row=\"1\" col=\"1\" displaytype=\"number\" edittype=\"none\" style=\"align:right middle;\" text=\"bind:Column3\"/><Cell row=\"2\" celltype=\"none\" text=\"bind:Column1\"/><Cell row=\"2\" col=\"1\" displaytype=\"number\" edittype=\"none\" style=\"align:right middle;\" text=\"bind:Column4\"/><Cell row=\"3\" celltype=\"none\" text=\"bind:Column2\"/><Cell row=\"3\" col=\"1\" displaytype=\"number\" edittype=\"none\" cssclass=\"CellGrd_WF_ColorRed\" text=\"bind:Column5\"/><Cell row=\"4\"/><Cell row=\"4\" col=\"1\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "237", "540", "10", null, null, this);
            obj.set_taborder("27");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "0", "369", "540", "10", null, null, this);
            obj.set_taborder("28");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid01", "absolute", "10", "379", null, "346", "10", null, this);
            obj.set_taborder("29");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("none");
            obj.set_selecttype("cell");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"110\"/><Column size=\"150\"/><Column size=\"110\"/><Column size=\"150\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"GrayLabel\"/><Cell col=\"1\" text=\"WhiteLabel\"/><Cell col=\"2\" text=\"GrayLabel\"/><Cell col=\"3\" text=\"WhiteLabel\"/></Band><Band id=\"body\"><Cell colspan=\"4\" celltype=\"none\" cssclass=\"CellGrd_WF_LabelIndigo\" text=\"bind:Column1\"/><Cell row=\"1\" celltype=\"none\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:Column2\"/><Cell row=\"1\" col=\"1\" displaytype=\"number\" edittype=\"none\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:Column3\"/><Cell row=\"1\" col=\"2\" celltype=\"none\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:Column4\"/><Cell row=\"1\" col=\"3\" displaytype=\"number\" edittype=\"none\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:Column5\"/><Cell row=\"2\" celltype=\"none\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:Column6\"/><Cell row=\"2\" col=\"1\" edittype=\"none\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:Column7\"/><Cell row=\"2\" col=\"2\" celltype=\"none\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:Column8\"/><Cell row=\"2\" col=\"3\" displaytype=\"number\" edittype=\"none\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:Column9\"/><Cell row=\"3\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:Column10\"/><Cell row=\"3\" col=\"1\" displaytype=\"number\" cssclass=\"CellGrd_WF_ColorBlue\" text=\"bind:Column11\"/><Cell row=\"3\" col=\"2\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:Column12\"/><Cell row=\"3\" col=\"3\" displaytype=\"number\" cssclass=\"CellGrd_WF_ColorRed\" text=\"bind:Column13\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static18", "absolute", "561", "305", "195", "35", null, null, this);
            obj.set_taborder("30");
            obj.set_text("Position Band : right");
            obj.set_cssclass("sta_GUIDE_RedText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static19", "absolute", "515", "320", "37", "2", null, null, this);
            obj.set_taborder("31");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "420", "195", "10", "19", null, null, this);
            obj.set_taborder("32");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "458", "762", "110", "2", null, null, this);
            obj.set_taborder("33");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "573", "748", "349", "30", null, null, this);
            obj.set_taborder("34");
            obj.set_text("Style : COMP_GUIDE_06_3의 Detail01  참조 ");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static10", "absolute", "458", "710", "2", "52", null, null, this);
            obj.set_taborder("35");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "498", "260", "50", "2", null, null, this);
            obj.set_taborder("36");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static11", "absolute", "563", "246", "349", "30", null, null, this);
            obj.set_taborder("37");
            obj.set_text("Style : COMP_GUIDE_06_2의 Summary  참조 ");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("일일발주현황");

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

        this.loadIncludeScript("TEMPLATE_10.xfdl", true);

       
    };
}
)();
