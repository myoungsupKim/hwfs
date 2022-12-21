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
                this.set_titletext("장바구니");
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
            obj._setContents("<ColumnInfo><Column id=\"Column2\" type=\"STRING\" size=\"256\"/><Column id=\"Column4\" type=\"STRING\" size=\"256\"/><Column id=\"Column5\" type=\"STRING\" size=\"256\"/><Column id=\"Column6\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_ColorChipGuide", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"Column5\" type=\"STRING\" size=\"256\"/><Column id=\"Column6\" type=\"STRING\" size=\"256\"/><Column id=\"Column7\" type=\"STRING\" size=\"256\"/><Column id=\"Column8\" type=\"STRING\" size=\"256\"/><Column id=\"Column9\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column5\">grd_WF_ColorchipPlanning.png</Col><Col id=\"Column6\">grd_WF_ColorchipNew.png</Col><Col id=\"Column7\">grd_WF_ColorchipSpecial.png</Col><Col id=\"Column8\">grd_WF_ColorchipRecommend.png</Col><Col id=\"Column9\">grd_WF_ColorchipLimit.png</Col></Row></Rows>");
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

            obj = new Grid("Grid00", "absolute", "0", "59", null, "625", "0", null, this);
            obj.set_taborder("5");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("none");
            obj.set_cssclass("grd_WF_Default2");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"56\"/><Column size=\"229\"/><Column size=\"120\" band=\"right\"/><Column size=\"72\" band=\"right\"/><Column size=\"53\" band=\"right\"/><Column size=\"10\" band=\"right\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"17\"/><Row size=\"10\"/><Row size=\"25\"/><Row size=\"25\"/><Row size=\"10\"/><Row size=\"17\"/></Rows><Band id=\"head\"><Cell text=\"Column1\"/><Cell col=\"1\" text=\"Column0\"/><Cell col=\"2\" text=\"Column2\"/><Cell col=\"3\" text=\"Column3\"/><Cell col=\"4\" text=\"Column7\"/><Cell col=\"5\"/></Band><Band id=\"body\"><Cell style=\"line:0 none;\"/><Cell col=\"1\" style=\"line:0 none;\"/><Cell col=\"2\" style=\"line:0 none;\"/><Cell col=\"3\" style=\"line:0 none;\"/><Cell col=\"4\" style=\"line:0 none;\" text=\"bind:Column7\"/><Cell col=\"5\" style=\"line:0 none;\"/><Cell row=\"1\" rowspan=\"2\" displaytype=\"image\" style=\"line:0 none #808080ff ;backgroundimage:URL('theme://Image/grd_WF_ColorchipPlanning.png');\"/><Cell row=\"1\" col=\"1\" rowspan=\"2\" style=\"align:left middle;padding:0 10 0 10;line:0 none;\" text=\"bind:Column2\"/><Cell row=\"1\" col=\"2\" style=\"line:0 none;\"/><Cell row=\"1\" col=\"3\" style=\"line:0 none;\"/><Cell row=\"1\" col=\"4\" style=\"line:0 none;\"/><Cell row=\"1\" col=\"5\" style=\"line:0 none;\"/><Cell row=\"2\" col=\"2\" style=\"line:0 none;\"/><Cell row=\"2\" col=\"3\" rowspan=\"2\" style=\"align:right middle;line:0 none;\" text=\"bind:Column6\" editdisplay=\"display\"/><Cell row=\"2\" col=\"4\" rowspan=\"2\" displaytype=\"image\" edittype=\"button\" style=\"line:0 none #808080ff ;backgroundimage:URL('theme://Image/CellGrd_WF_Xbtn.png');\"/><Cell row=\"2\" col=\"5\" style=\"line:0 none;\"/><Cell row=\"3\" rowspan=\"2\" displaytype=\"image\" style=\"line:0 none #808080ff ;backgroundimage:URL('theme://Image/grd_WF_ColorchipNew.png');\"/><Cell row=\"3\" col=\"1\" rowspan=\"2\" style=\"align:left middle;padding:0 10 0 10;line:0 none;\" text=\"bind:Column4\"/><Cell row=\"3\" col=\"2\" rowspan=\"2\" style=\"line:0 none;\" cssclass=\"CellGrd_WF_ColorBlue\" text=\"bind:Column5\"/><Cell row=\"3\" col=\"5\" style=\"line:0 none;\"/><Cell row=\"4\" col=\"3\" style=\"line:0 none;\"/><Cell row=\"4\" col=\"4\" style=\"line:0 none;\"/><Cell row=\"4\" col=\"5\" style=\"line:0 none;\"/><Cell row=\"5\" style=\"line: ;\"/><Cell row=\"5\" col=\"1\" style=\"line: ;\"/><Cell row=\"5\" col=\"2\" style=\"line: ;\"/><Cell row=\"5\" col=\"3\" style=\"line: ;\"/><Cell row=\"5\" col=\"4\" style=\"line: ;\"/><Cell row=\"5\" col=\"5\" style=\"line: ;\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static18", "absolute", "571", "25", "195", "35", null, null, this);
            obj.set_taborder("7");
            obj.set_text("Class : grd_WF_Default2");
            obj.set_cssclass("sta_GUIDE_RedText");
            obj.set_visible("false");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Button("Button09", "absolute", null, null, "117", "47", "10", "10", this);
            obj.set_taborder("8");
            obj.set_text("발주확정");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Button("Button00", "absolute", null, null, "117", "47", "132", "10", this);
            obj.set_taborder("9");
            obj.set_text("중간저장");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Button("Button01", "absolute", null, null, "117", "47", "254", "10", this);
            obj.set_taborder("10");
            obj.set_text("전체삭제");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "525", "111", "37", "2", null, null, this);
            obj.set_taborder("11");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "571", "96", "584", "35", null, null, this);
            obj.set_taborder("12");
            obj.set_text("Backgroundimage : theme://Image/CellGrd_WF_Xbtn.png / Displaytype : image / Edittype : button");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "465", "79", "97", "2", null, null, this);
            obj.set_taborder("13");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "571", "64", "417", "35", null, null, this);
            obj.set_taborder("14");
            obj.set_text("Editdisplay : display / Align : right middle");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "465", "79", "2", "12", null, null, this);
            obj.set_taborder("15");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "571", "134", "417", "35", null, null, this);
            obj.set_taborder("16");
            obj.set_text("CellClass : CellGrd_WF_ColorBlue");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "375", "149", "187", "2", null, null, this);
            obj.set_taborder("17");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "376", "136", "2", "13", null, null, this);
            obj.set_taborder("18");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static10", "absolute", "205", "178", "357", "2", null, null, this);
            obj.set_taborder("19");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static11", "absolute", "205", "178", "2", "12", null, null, this);
            obj.set_taborder("20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static12", "absolute", "571", "163", "417", "35", null, null, this);
            obj.set_taborder("21");
            obj.set_text("Align : left middle / Padding : 0 10 0 10");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "571", "240", "417", "35", null, null, this);
            obj.set_taborder("22");
            obj.set_text("Colorchip Imgae Guide");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static14", "absolute", "29", "255", "527", "2", null, null, this);
            obj.set_taborder("23");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "29", "242", "2", "13", null, null, this);
            obj.set_taborder("24");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid01", "absolute", "566", "279", "377", "226", null, null, this);
            obj.set_taborder("25");
            obj.set_binddataset("ds_ColorChipGuide");
            obj.set_cssclass("grd_WF_Default2");
            obj.set_scrollbars("none");
            obj.set_visible("false");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"56\"/><Column size=\"320\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\" band=\"head\"/><Row size=\"35\"/><Row size=\"35\"/><Row size=\"35\"/><Row size=\"35\"/><Row size=\"35\"/></Rows><Band id=\"head\"><Cell text=\"Column1\"/><Cell col=\"1\" text=\"Column2\"/><Cell row=\"1\"/><Cell row=\"1\" col=\"1\" text=\"ImageName\"/></Band><Band id=\"body\"><Cell displaytype=\"image\" style=\"backgroundimage:URL('theme://Image/grd_WF_ColorchipPlanning.png');\" text=\"bind:Column0\"/><Cell col=\"1\" style=\"padding:0 10 0 10;font:9 Dotum;selectfont:9 Dotum;\" text=\"bind:Column5\"/><Cell row=\"1\" displaytype=\"image\" style=\"backgroundimage:URL('theme://Image/grd_WF_ColorchipNew.png');\" text=\"bind:Column1\"/><Cell row=\"1\" col=\"1\" style=\"padding:0 10 0 10;font:9 Dotum;selectfont:9 Dotum;\" text=\"bind:Column6\"/><Cell row=\"2\" displaytype=\"image\" style=\"backgroundimage:URL('theme://Image/grd_WF_ColorchipSpecial.png');\" text=\"bind:Column2\"/><Cell row=\"2\" col=\"1\" style=\"padding:0 10 0 10;font:9 Dotum;selectfont:9 Dotum;\" text=\"bind:Column7\"/><Cell row=\"3\" displaytype=\"image\" style=\"backgroundimage:URL('theme://Image/grd_WF_ColorchipRecommend.png');\" text=\"bind:Column3\"/><Cell row=\"3\" col=\"1\" style=\"padding:0 10 0 10;font:9 Dotum;selectfont:9 Dotum;\" text=\"bind:Column8\"/><Cell row=\"4\" displaytype=\"image\" style=\"backgroundimage:URL('theme://Image/grd_WF_ColorchipLimit.png');\" text=\"bind:Column4\"/><Cell row=\"4\" col=\"1\" style=\"padding:0 10 0 10;font:9 Dotum;selectfont:9 Dotum;\" text=\"bind:Column9\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static68", "absolute", "-3", "284", "21", "35", null, null, this);
            obj.set_taborder("26");
            obj.set_text("Fix h35 (10+25)");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static69", "absolute", "0", "271", "56", "23", null, null, this);
            obj.set_taborder("27");
            obj.set_text("Fix w56");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static16", "absolute", "-3", "319", "21", "35", null, null, this);
            obj.set_taborder("28");
            obj.set_text("Fix h35 (10+25)");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static17", "absolute", "476", "281", "53", "23", null, null, this);
            obj.set_taborder("29");
            obj.set_text("Fix w53");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static19", "absolute", "469", "295", "21", "50", null, null, this);
            obj.set_taborder("30");
            obj.set_text("Fix h50 (25+25)");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static20", "absolute", "565", "315", "56", "23", null, null, this);
            obj.set_taborder("31");
            obj.set_text("Fix w56");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static21", "absolute", "562", "330", "21", "35", null, null, this);
            obj.set_taborder("32");
            obj.set_text("Fix h35 (10+25)");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static22", "absolute", "286", "717", "5", "19", null, null, this);
            obj.set_taborder("33");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static23", "absolute", "408", "717", "5", "19", null, null, this);
            obj.set_taborder("34");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static24", "absolute", "530", "684", "10", "76", null, null, this);
            obj.set_taborder("35");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static25", "absolute", "0", "750", "540", "10", null, null, this);
            obj.set_taborder("36");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static27", "absolute", "1135", "87", "53", "50", null, null, this);
            obj.set_taborder("37");
            obj.style.set_background("URL('theme://Image/CellGrd_WF_Cartbtn.png')");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static28", "absolute", "1176", "108", "37", "2", null, null, this);
            obj.set_taborder("38");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static29", "absolute", "1219", "93", "276", "35", null, null, this);
            obj.set_taborder("39");
            obj.set_text("ImageName : CellGrd_WF_Cartbtn.png");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static31", "absolute", "1135", "69", "53", "23", null, null, this);
            obj.set_taborder("40");
            obj.set_text("Fix w53");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static32", "absolute", "1124", "87", "21", "50", null, null, this);
            obj.set_taborder("41");
            obj.set_text("Fix h50 (25+25)");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("장바구니");

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
            this.Static68.addEventHandler("onclick", this.Static68_onclick, this);
            this.Static21.addEventHandler("onclick", this.Static68_onclick, this);

        };

        this.loadIncludeScript("TEMPLATE_11.xfdl", true);

       
    };
}
)();
