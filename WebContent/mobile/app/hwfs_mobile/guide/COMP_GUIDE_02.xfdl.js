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
                this.set_name("GUIDE_class");
                this.set_titletext("Static,Edit,MaskEdit,Combo,Spin,TextArea");
                this._setFormPosition(0,0,540,1556);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_cmb", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"Column0\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column0\">리스트목록01</Col></Row><Row><Col id=\"Column0\">리스트목록02</Col></Row><Row><Col id=\"Column0\">리스트목록03</Col></Row><Row><Col id=\"Column0\">리스트목록04</Col></Row><Row><Col id=\"Column0\">리스트목록05</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Button("Button04", "absolute", "146", "1033", "47", "47", null, null, this);
            obj.set_taborder("53");
            obj.set_cssclass("btn_WF_SpinPlus");
            this.addChild(obj.name, obj);

            obj = new MaskEdit("MaskEdit04", "absolute", "71", "1033", "76", "47", null, null, this);
            obj.set_taborder("54");
            obj.set_value("29");
            obj.set_cssclass("msk_WF_Spin");
            this.addChild(obj.name, obj);

            obj = new Button("Button05", "absolute", "25", "1033", "47", "47", null, null, this);
            obj.set_taborder("55");
            obj.set_cssclass("btn_WF_SpinMinus");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "-1", "0", null, "50", "0", null, this);
            obj.set_taborder("0");
            obj.set_text("Static");
            obj.style.set_background("#edeee6ff");
            obj.style.set_border("1 solid #c6c6c5ff");
            obj.style.set_align("center middle");
            obj.style.set_font("antialias 15 Tahoma");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "25", "111", "230", "47", null, null, this);
            obj.set_taborder("1");
            obj.set_text("한화FOODCULTURE");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "25", "79", "100", "20", null, null, this);
            obj.set_taborder("2");
            obj.set_text("enabled");
            obj.style.set_color("#999999ff");
            obj.style.set_font("antialias 9 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "274", "111", "230", "47", null, null, this);
            obj.set_taborder("3");
            obj.set_text("한화FOODCULTURE");
            obj.set_enable("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "274", "79", "100", "20", null, null, this);
            obj.set_taborder("4");
            obj.set_text("disabled");
            obj.style.set_color("#999999ff");
            obj.style.set_font("antialias 9 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "-1", "198", null, "50", "0", null, this);
            obj.set_taborder("5");
            obj.set_text("Edit");
            obj.style.set_background("#edeee6ff");
            obj.style.set_border("1 solid #c6c6c5ff");
            obj.style.set_align("center middle");
            obj.style.set_font("antialias 15 Tahoma");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "25", "277", "100", "20", null, null, this);
            obj.set_taborder("7");
            obj.set_text("enabled");
            obj.style.set_color("#999999ff");
            obj.style.set_font("antialias 9 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "274", "277", "100", "20", null, null, this);
            obj.set_taborder("9");
            obj.set_text("disabled");
            obj.style.set_color("#999999ff");
            obj.style.set_font("antialias 9 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit00", "absolute", "25", "308", "230", "47", null, null, this);
            obj.set_taborder("10");
            obj.set_displaynulltext("가나다라마바");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit01", "absolute", "274", "308", "230", "47", null, null, this);
            obj.set_taborder("11");
            obj.set_displaynulltext("가나다라마바");
            obj.set_enable("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "-1", "396", null, "50", "0", null, this);
            obj.set_taborder("12");
            obj.set_text("MaskEdit");
            obj.style.set_background("#edeee6ff");
            obj.style.set_border("1 solid #c6c6c5ff");
            obj.style.set_align("center middle");
            obj.style.set_font("antialias 15 Tahoma");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "25", "475", "100", "20", null, null, this);
            obj.set_taborder("13");
            obj.set_text("enabled");
            obj.style.set_color("#999999ff");
            obj.style.set_font("antialias 9 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new Static("Static10", "absolute", "274", "475", "100", "20", null, null, this);
            obj.set_taborder("14");
            obj.set_text("disabled");
            obj.style.set_color("#999999ff");
            obj.style.set_font("antialias 9 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new MaskEdit("MaskEdit00", "absolute", "25", "507", "230", "47", null, null, this);
            obj.set_taborder("15");
            obj.set_mask("@@@,@@@");
            obj.set_value("123456789");
            this.addChild(obj.name, obj);

            obj = new MaskEdit("MaskEdit01", "absolute", "274", "507", "230", "47", null, null, this);
            obj.set_taborder("16");
            obj.set_enable("false");
            obj.set_mask("@@@,@@@");
            obj.set_value("123456789");
            this.addChild(obj.name, obj);

            obj = new Static("Static11", "absolute", "327", "396", null, "50", "0", null, this);
            obj.set_taborder("17");
            obj.set_text("※ mask = \"@@@,@@@\"");
            obj.set_cssclass("sta_GUIDE_RedText");
            this.addChild(obj.name, obj);

            obj = new Static("Static12", "absolute", "-1", "594", null, "50", "0", null, this);
            obj.set_taborder("18");
            obj.set_text("Combo");
            obj.style.set_background("#edeee6ff");
            obj.style.set_border("1 solid #c6c6c5ff");
            obj.style.set_align("center middle");
            obj.style.set_font("antialias 15 Tahoma");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "25", "673", "100", "20", null, null, this);
            obj.set_taborder("19");
            obj.set_text("enabled");
            obj.style.set_color("#999999ff");
            obj.style.set_font("antialias 9 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new Static("Static14", "absolute", "274", "673", "100", "20", null, null, this);
            obj.set_taborder("20");
            obj.set_text("disabled");
            obj.style.set_color("#999999ff");
            obj.style.set_font("antialias 9 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new Combo("Combo00", "absolute", "25", "705", "230", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("22");
            obj.set_innerdataset("@ds_cmb");
            obj.set_datacolumn("Column0");
            obj.set_displaynulltext("Combo");
            obj.set_index("-1");

            obj = new Combo("Combo01", "absolute", "274", "705", "230", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("23");
            obj.set_displaynulltext("Combo");
            obj.set_innerdataset("@ds_cmb");
            obj.set_datacolumn("Column0");
            obj.set_enable("false");
            obj.set_index("-1");

            obj = new Static("Static15", "absolute", "-1", "792", null, "50", "0", null, this);
            obj.set_taborder("24");
            obj.set_text("Spin");
            obj.style.set_background("#edeee6ff");
            obj.style.set_border("1 solid #c6c6c5ff");
            obj.style.set_align("center middle");
            obj.style.set_font("antialias 15 Tahoma");
            this.addChild(obj.name, obj);

            obj = new Static("Static16", "absolute", "25", "871", "100", "20", null, null, this);
            obj.set_taborder("25");
            obj.set_text("enabled");
            obj.style.set_color("#999999ff");
            obj.style.set_font("antialias 9 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new Static("Static17", "absolute", "274", "871", "100", "20", null, null, this);
            obj.set_taborder("26");
            obj.set_text("disabled");
            obj.style.set_color("#999999ff");
            obj.style.set_font("antialias 9 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new Button("Button00", "absolute", "25", "905", "47", "47", null, null, this);
            obj.set_taborder("27");
            obj.set_cssclass("btn_WF_SpinMinus");
            this.addChild(obj.name, obj);

            obj = new Button("Button01", "absolute", "146", "905", "47", "47", null, null, this);
            obj.set_taborder("28");
            obj.set_cssclass("btn_WF_SpinPlus");
            this.addChild(obj.name, obj);

            obj = new MaskEdit("MaskEdit02", "absolute", "71", "905", "76", "47", null, null, this);
            obj.set_taborder("29");
            obj.set_cssclass("msk_WF_Spin");
            obj.set_value("29");
            this.addChild(obj.name, obj);

            obj = new Button("Button02", "absolute", "274", "905", "47", "47", null, null, this);
            obj.set_taborder("30");
            obj.set_cssclass("btn_WF_SpinMinus");
            obj.set_enable("false");
            this.addChild(obj.name, obj);

            obj = new Button("Button03", "absolute", "399", "905", "47", "47", null, null, this);
            obj.set_taborder("31");
            obj.set_cssclass("btn_WF_SpinPlus");
            obj.set_enable("false");
            this.addChild(obj.name, obj);

            obj = new MaskEdit("MaskEdit03", "absolute", "320", "905", "80", "47", null, null, this);
            obj.set_taborder("32");
            obj.set_value("29");
            obj.set_cssclass("msk_WF_Spin");
            obj.set_enable("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static18", "absolute", "-1", "1190", null, "50", "0", null, this);
            obj.set_taborder("33");
            obj.set_text("TextArea");
            obj.style.set_background("#edeee6ff");
            obj.style.set_border("1 solid #c6c6c5ff");
            obj.style.set_align("center middle");
            obj.style.set_font("antialias 15 Tahoma");
            this.addChild(obj.name, obj);

            obj = new Static("Static19", "absolute", "25", "1269", "100", "20", null, null, this);
            obj.set_taborder("34");
            obj.set_text("enabled");
            obj.style.set_color("#999999ff");
            obj.style.set_font("antialias 9 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new Static("Static20", "absolute", "274", "1269", "100", "20", null, null, this);
            obj.set_taborder("35");
            obj.set_text("disabled");
            obj.style.set_color("#999999ff");
            obj.style.set_font("antialias 9 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new TextArea("TextArea00", "absolute", "25", "1300", "230", "160", null, null, this);
            obj.set_taborder("36");
            obj.set_value("가나다라마바사\r\n가나다라마바사\r\n가나다라마바사\r\n가나다라마바사\r\n가나다라마바사\r\n가나다라마바사\r\n");
            this.addChild(obj.name, obj);

            obj = new TextArea("TextArea01", "absolute", "274", "1300", "230", "160", null, null, this);
            obj.set_taborder("37");
            obj.set_value("가나다라마바사\r\n가나다라마바사\r\n가나다라마바사\r\n가나다라마바사\r\n가나다라마바사\r\n가나다라마바사\r\n");
            obj.set_enable("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static21", "absolute", "13", "308", "21", "47", null, null, this);
            obj.set_taborder("38");
            obj.set_text("h47");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static22", "absolute", "13", "507", "21", "47", null, null, this);
            obj.set_taborder("39");
            obj.set_text("h47");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static23", "absolute", "13", "705", "21", "47", null, null, this);
            obj.set_taborder("40");
            obj.set_text("h47");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static24", "absolute", "13", "905", "21", "47", null, null, this);
            obj.set_taborder("41");
            obj.set_text("h47");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static25", "absolute", "310", "792", "231", "50", null, null, this);
            obj.set_taborder("42");
            obj.set_text("※ Button + MaskEdit + Button 조합");
            obj.set_cssclass("sta_GUIDE_RedText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static26", "absolute", "25", "956", "47", "17", null, null, this);
            obj.set_taborder("43");
            obj.set_text("w47");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static27", "absolute", "71", "956", "76", "17", null, null, this);
            obj.set_taborder("44");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            obj.set_text("w76(최소)+α");
            this.addChild(obj.name, obj);

            obj = new Static("Static28", "absolute", "146", "956", "47", "17", null, null, this);
            obj.set_taborder("45");
            obj.set_text("w47");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static29", "absolute", "68", "970", "57", "30", null, null, this);
            obj.set_taborder("46");
            obj.set_text("|\r\n1px 겹침");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static30", "absolute", "143", "970", "57", "30", null, null, this);
            obj.set_taborder("47");
            obj.set_text("|\r\n1px 겹침");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static31", "absolute", "47", "1076", "2", "77", null, null, this);
            obj.set_taborder("48");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static32", "absolute", "47", "1151", "132", "2", null, null, this);
            obj.set_taborder("49");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static33", "absolute", "183", "1137", "180", "30", null, null, this);
            obj.set_taborder("50");
            obj.set_text("Class : btn_WF_SpinMinus");
            obj.set_visible("false");
            obj.set_cssclass("sta_GUIDE_BlackText");
            this.addChild(obj.name, obj);

            obj = new Static("Static34", "absolute", "183", "1111", "180", "30", null, null, this);
            obj.set_taborder("51");
            obj.set_text("Class : msk_WF_Spin");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static35", "absolute", "105", "1076", "2", "49", null, null, this);
            obj.set_taborder("52");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static36", "absolute", "105", "1125", "73", "2", null, null, this);
            obj.set_taborder("56");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static37", "absolute", "183", "1085", "180", "30", null, null, this);
            obj.set_taborder("57");
            obj.set_text("Class : btn_WF_SpinPlus");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static38", "absolute", "167", "1076", "2", "23", null, null, this);
            obj.set_taborder("58");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static39", "absolute", "169", "1098", "10", "2", null, null, this);
            obj.set_taborder("59");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 1556, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("Static,Edit,MaskEdit,Combo,Spin,TextArea");

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

        this.loadIncludeScript("COMP_GUIDE_02.xfdl", true);

       
    };
}
)();
