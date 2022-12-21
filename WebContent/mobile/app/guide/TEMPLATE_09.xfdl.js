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
                this.set_titletext("상품조회");
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
            obj._setContents("<ColumnInfo><Column id=\"Column0\" type=\"STRING\" size=\"256\"/><Column id=\"Column1\" type=\"STRING\" size=\"256\"/><Column id=\"Column2\" type=\"STRING\" size=\"256\"/><Column id=\"Column3\" type=\"STRING\" size=\"256\"/><Column id=\"Column4\" type=\"STRING\" size=\"256\"/><Column id=\"Column5\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column0\">수량</Col><Col id=\"Column1\">단위</Col><Col id=\"Column2\">10070000</Col><Col id=\"Column3\">상추</Col><Col id=\"Column4\">2.4Kg 수입</Col><Col id=\"Column5\">4,500원</Col></Row><Row><Col id=\"Column0\">수량</Col><Col id=\"Column1\">단위</Col><Col id=\"Column2\">10070000</Col><Col id=\"Column3\">상추</Col><Col id=\"Column4\">2.4Kg 수입</Col><Col id=\"Column5\">4,500원</Col></Row><Row><Col id=\"Column0\">수량</Col><Col id=\"Column1\">단위</Col><Col id=\"Column2\">10070000</Col><Col id=\"Column3\">상추</Col><Col id=\"Column4\">2.4Kg 수입</Col><Col id=\"Column5\">4,500원</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Button("Button06", "absolute", "360", "0", "180", "63", null, null, this);
            obj.set_taborder("0");
            obj.set_text("신규자재");
            obj.set_cssclass("btn_WF_TabTFOff");
            this.addChild(obj.name, obj);

            obj = new Button("Button05", "absolute", "180", "0", "180", "63", null, null, this);
            obj.set_taborder("1");
            obj.set_text("전략자재");
            obj.set_cssclass("btn_WF_TabTFOff");
            this.addChild(obj.name, obj);

            obj = new Button("Button04", "absolute", "0", "0", "180", "63", null, null, this);
            obj.set_taborder("2");
            obj.set_text("모두");
            obj.set_cssclass("btn_WF_TabTFOn");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "0", "63", "540", "57", null, null, this);
            obj.set_taborder("3");
            obj.set_text("한촌강남점");
            obj.set_cssclass("sta_WF_Label01");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "120", null, "59", "0", null, this);
            obj.set_taborder("4");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit01", "absolute", "10", "126", null, "47", "115", null, this);
            obj.set_taborder("6");
            obj.set_value("품목명 검색");
            obj.set_displaynulltext("품목명 검색");
            this.addChild(obj.name, obj);

            obj = new Button("Button01", "absolute", null, "126", "47", "47", "115", null, this);
            obj.set_taborder("7");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);

            obj = new Button("Button00", "absolute", null, "126", "100", "47", "10", null, this);
            obj.set_taborder("8");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "0", "179", "540", "59", null, null, this);
            obj.set_taborder("9");
            obj.set_text("현재 사업장 품목");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid01", "absolute", "10", "238", null, "451", "10", null, this);
            obj.set_taborder("10");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("none");
            obj.set_autofittype("col");
            obj.set_selecttype("cell");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"140\"/><Column size=\"130\"/><Column size=\"250\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell/><Cell col=\"1\" text=\"GrayLabel\"/><Cell col=\"2\" text=\"WhiteLabel\"/></Band><Band id=\"body\"><Cell rowspan=\"3\" style=\"background:URL('theme://Image/img_WF_NoImage.png') center middle;background2:URL('theme://Image/img_WF_NoImage.png') center middle;selectbackground:URL('theme://Image/img_WF_NoImage.png') center middle;\"/><Cell col=\"1\" celltype=\"none\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:Column0\"/><Cell col=\"2\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:Column3\"/><Cell row=\"1\" col=\"1\" celltype=\"none\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:Column1\"/><Cell row=\"1\" col=\"2\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:Column4\"/><Cell row=\"2\" col=\"1\" celltype=\"none\" style=\"align:left middle;\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:Column2\"/><Cell row=\"2\" col=\"2\" cssclass=\"CellGrd_WF_ColorRed\" text=\"bind:Column5\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Button("Button36", "absolute", "0", null, null, "35", "0", "0", this);
            obj.set_taborder("11");
            obj.set_text("더보기");
            obj.set_cssclass("btn_WF_More");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "530", "238", "10", "451", null, null, this);
            obj.set_taborder("12");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "238", "10", "451", null, null, this);
            obj.set_taborder("13");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static18", "absolute", "438", "709", "110", "2", null, null, this);
            obj.set_taborder("14");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "553", "695", "349", "30", null, null, this);
            obj.set_taborder("15");
            obj.set_text("Style : COMP_GUIDE_06_2의 Image 참조 ");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static10", "absolute", "438", "657", "2", "52", null, null, this);
            obj.set_taborder("16");
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
            		p.set_titletext("상품조회");

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

        this.loadIncludeScript("TEMPLATE_09.xfdl", true);

       
    };
}
)();
