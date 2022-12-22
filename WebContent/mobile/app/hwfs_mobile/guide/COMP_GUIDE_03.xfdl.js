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
                this.set_titletext("Calendar,Radio,CheckBox");
                this._setFormPosition(0,0,540,1253);
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
            obj._setContents("<ColumnInfo><Column id=\"lev\" type=\"STRING\" size=\"256\"/><Column id=\"Column1\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"lev\">0</Col><Col id=\"Column1\">남</Col></Row><Row><Col id=\"lev\">1</Col><Col id=\"Column1\">여</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("Static00", "absolute", "-1", "0", null, "50", "0", null, this);
            obj.set_taborder("0");
            obj.set_text("Calendar");
            obj.style.set_background("#edeee6ff");
            obj.style.set_border("1 solid #c6c6c5ff");
            obj.style.set_align("center middle");
            obj.style.set_font("antialias 15 Tahoma");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "25", "79", "100", "20", null, null, this);
            obj.set_taborder("2");
            obj.set_text("enabled");
            obj.style.set_color("#999999ff");
            obj.style.set_font("antialias 9 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "274", "79", "100", "20", null, null, this);
            obj.set_taborder("4");
            obj.set_text("disabled");
            obj.style.set_color("#999999ff");
            obj.style.set_font("antialias 9 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new Calendar("Calendar00", "absolute", "25", "106", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("5");
            obj.set_dateformat("yyyy-MM-dd ddd");
            obj.set_value("null");
            obj.set_displaynulltext("2015-12-29");

            obj = new Calendar("Calendar01", "absolute", "274", "106", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("6");
            obj.set_displaynulltext("2015-12-29");
            obj.set_enable("false");
            obj.set_value("null");
            obj.set_dateformat("yyyy-MM-dd ddd");

            obj = new Static("Static01", "absolute", "25", "207", "100", "20", null, null, this);
            obj.set_taborder("7");
            obj.set_text("MonthOnly");
            obj.style.set_color("#999999ff");
            obj.style.set_font("antialias 9 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new Calendar("calCalendar", "absolute", "25", "242", "500", "580", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("9");
            obj.set_type("monthonly");
            obj.style.set_bordertype("normal 0 0");
            obj.set_value("null");
            obj.set_dateformat("yyyy-MM-dd ddd");

            obj = new Static("Static21", "absolute", "13", "106", "21", "47", null, null, this);
            obj.set_taborder("10");
            obj.set_text("h47");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "25", "144", "195", "21", null, null, this);
            obj.set_taborder("11");
            obj.set_text("w195 권장");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "25", "812", "500", "21", null, null, this);
            obj.set_taborder("12");
            obj.set_text("w500");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "516", "242", "21", "580", null, null, this);
            obj.set_taborder("13");
            obj.set_text("h580");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "-1", "868", null, "50", "0", null, this);
            obj.set_taborder("14");
            obj.set_text("Radio");
            obj.style.set_background("#edeee6ff");
            obj.style.set_border("1 solid #c6c6c5ff");
            obj.style.set_align("center middle");
            obj.style.set_font("antialias 15 Tahoma");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "25", "947", "100", "20", null, null, this);
            obj.set_taborder("15");
            obj.set_text("enabled");
            obj.style.set_color("#999999ff");
            obj.style.set_font("antialias 9 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "274", "947", "100", "20", null, null, this);
            obj.set_taborder("16");
            obj.set_text("disabled");
            obj.style.set_color("#999999ff");
            obj.style.set_font("antialias 9 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new Static("Static10", "absolute", "-1", "1066", null, "50", "0", null, this);
            obj.set_taborder("19");
            obj.set_text("CheckBox");
            obj.style.set_background("#edeee6ff");
            obj.style.set_border("1 solid #c6c6c5ff");
            obj.style.set_align("center middle");
            obj.style.set_font("antialias 15 Tahoma");
            this.addChild(obj.name, obj);

            obj = new Static("Static11", "absolute", "25", "1145", "100", "20", null, null, this);
            obj.set_taborder("20");
            obj.set_text("enabled");
            obj.style.set_color("#999999ff");
            obj.style.set_font("antialias 9 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new Static("Static12", "absolute", "274", "1145", "100", "20", null, null, this);
            obj.set_taborder("21");
            obj.set_text("disabled");
            obj.style.set_color("#999999ff");
            obj.style.set_font("antialias 9 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new CheckBox("CheckBox02", "absolute", "27", "1177", "200", "47", null, null, this);
            obj.set_taborder("22");
            obj.set_text("가나다라마바");
            obj.set_value("true");
            this.addChild(obj.name, obj);

            obj = new CheckBox("CheckBox03", "absolute", "274", "1177", "200", "47", null, null, this);
            obj.set_taborder("23");
            obj.set_text("가나다라마바");
            this.addChild(obj.name, obj);

            obj = new Radio("Radio00", "absolute", "30", "982", "170", "45", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("24");
            obj.set_innerdataset("@ds_rdo");
            obj.set_codecolumn("lev");
            obj.set_datacolumn("Column1");
            obj.set_rowcount("1");
            obj.set_value("0");
            obj.set_index("0");

            obj = new Radio("Radio01", "absolute", "274", "982", "170", "45", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("25");
            obj.set_rowcount("1");
            obj.set_innerdataset("@ds_rdo");
            obj.set_codecolumn("lev");
            obj.set_datacolumn("Column1");
            obj.set_enable("false");
            obj.set_index("-1");


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 1253, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("Calendar,Radio,CheckBox");

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
            this.calCalendar.addEventHandler("onchanged", this.calCalendar_onchanged, this);
            this.calCalendar.addEventHandler("ondayclick", this.calCalendar_ondayclick, this);

        };

        this.loadIncludeScript("COMP_GUIDE_03.xfdl", true);

       
    };
}
)();
