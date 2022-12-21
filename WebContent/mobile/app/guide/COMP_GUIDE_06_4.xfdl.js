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
                this.set_titletext("Grid_List");
                this._setFormPosition(0,0,540,810);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_grdList02", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"Column0\" type=\"STRING\" size=\"256\"/><Column id=\"Column1\" type=\"STRING\" size=\"256\"/><Column id=\"Column2\" type=\"STRING\" size=\"256\"/><Column id=\"Column3\" type=\"STRING\" size=\"256\"/><Column id=\"Column4\" type=\"STRING\" size=\"256\"/><Column id=\"Column5\" type=\"STRING\" size=\"256\"/><Column id=\"Column6\" type=\"STRING\" size=\"256\"/><Column id=\"Column7\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column0\">2015-12-29</Col><Col id=\"Column1\">홍길동</Col><Col id=\"Column2\">승인</Col><Col id=\"Column3\">FS개발팀</Col><Col id=\"Column4\">개발1팀</Col><Col id=\"Column5\">반려</Col><Col id=\"Column6\">2015-01-01~2015-12-29</Col><Col id=\"Column7\">750000</Col></Row></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_grdList01", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"Column0\" type=\"STRING\" size=\"256\"/><Column id=\"Column1\" type=\"STRING\" size=\"256\"/><Column id=\"Column2\" type=\"STRING\" size=\"256\"/><Column id=\"Column3\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column0\">통감자(20kg/EA)</Col><Col id=\"Column1\">실/재고</Col><Col id=\"Column2\">150/</Col><Col id=\"Column3\">1000</Col></Row><Row><Col id=\"Column0\">통감자(20kg/EA)</Col><Col id=\"Column1\">실/재고</Col><Col id=\"Column2\">150/</Col><Col id=\"Column3\">1000</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Grid("Grid01", "absolute", "0", "551", null, "148", "0", null, this);
            obj.set_cssclass("grd_WF_Default2");
            obj.set_taborder("111");
            obj.set_binddataset("ds_grdList02");
            obj.set_scrollbars("none");
            obj.set_selecttype("row");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"9\"/><Column size=\"261\"/><Column size=\"120\"/><Column size=\"8\"/><Column size=\"64\"/><Column size=\"69\"/><Column size=\"9\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"5\"/><Row size=\"39\"/><Row size=\"2\"/><Row size=\"39\"/><Row size=\"7\"/><Row size=\"50\"/><Row size=\"5\"/></Rows><Band id=\"head\"><Cell/><Cell col=\"1\" text=\"GrayLabel\"/><Cell col=\"2\"/><Cell col=\"3\"/><Cell col=\"4\" text=\"WhiteLabel\"/><Cell col=\"5\" text=\"GrayLabel\"/><Cell col=\"6\"/></Band><Band id=\"body\"><Cell style=\"line:0 none;\"/><Cell col=\"1\" style=\"line:0 none;\"/><Cell col=\"2\" style=\"line:0 none;\"/><Cell col=\"3\" style=\"line:0 none;\"/><Cell col=\"4\" style=\"line:0 none;\"/><Cell col=\"5\" style=\"line:0 none;\"/><Cell col=\"6\" style=\"line:0 none;\"/><Cell row=\"1\" style=\"line:0 none;\"/><Cell row=\"1\" col=\"1\" celltype=\"none\" style=\"align: ;line:0 none #808080 ;\" text=\"bind:Column0\"/><Cell row=\"1\" col=\"2\" colspan=\"3\" style=\"align: ;line:0 none #808080 ;\" text=\"bind:Column1\"/><Cell row=\"1\" col=\"5\" displaytype=\"button\" edittype=\"button\" style=\"align:center middle;line:0 none #808080ff ;\" text=\"bind:Column2\"/><Cell row=\"1\" col=\"6\" style=\"line:0 none;\"/><Cell row=\"2\" style=\"line:0 none;\"/><Cell row=\"2\" col=\"1\" style=\"align: ;line:0 none #808080 ;\"/><Cell row=\"2\" col=\"2\" style=\"align: ;line:0 none #808080 ;\"/><Cell row=\"2\" col=\"3\" style=\"align: ;line:0 none #808080 ;\"/><Cell row=\"2\" col=\"4\" style=\"align: ;line:0 none #808080 ;\"/><Cell row=\"2\" col=\"5\" style=\"align:center middle;line:0 none #808080ff ;\"/><Cell row=\"2\" col=\"6\" style=\"line:0 none;\"/><Cell row=\"3\" style=\"line:0 none;\"/><Cell row=\"3\" col=\"1\" celltype=\"none\" style=\"align: ;line:0 none #808080 ;\" text=\"bind:Column3\"/><Cell row=\"3\" col=\"2\" colspan=\"3\" style=\"align: ;line:0 none #808080 ;\" text=\"bind:Column4\"/><Cell row=\"3\" col=\"5\" celltype=\"none\" displaytype=\"button\" edittype=\"button\" style=\"align:center middle;line:0 none #808080ff ;\" text=\"bind:Column5\"/><Cell row=\"3\" col=\"6\" style=\"line:0 none;\"/><Cell row=\"4\" style=\"line:0 none;\"/><Cell row=\"4\" col=\"1\" style=\"line:0 none;\"/><Cell row=\"4\" col=\"2\" style=\"line:0 none;\"/><Cell row=\"4\" col=\"3\" style=\"line:0 none;\"/><Cell row=\"4\" col=\"4\" style=\"line:0 none;\"/><Cell row=\"4\" col=\"5\" style=\"line:0 none;\"/><Cell row=\"4\" col=\"6\" style=\"line:0 none;\"/><Cell row=\"5\" style=\"line:0 none;\"/><Cell row=\"5\" col=\"1\" colspan=\"2\" edittype=\"text\" style=\"align: ;line:0 none #808080 ;\" text=\"bind:Column6\" editdisplay=\"display\"/><Cell row=\"5\" col=\"3\" style=\"line:0 none;\"/><Cell row=\"5\" col=\"4\" colspan=\"2\" celltype=\"none\" displaytype=\"number\" style=\"align:right middle;line:0 none;\" text=\"bind:Column7\" editdisplay=\"display\"/><Cell row=\"5\" col=\"6\" style=\"line:0 none;\"/><Cell row=\"6\" colspan=\"7\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "-1", "0", null, "50", "0", null, this);
            obj.set_taborder("0");
            obj.set_text("Grid_List01");
            obj.style.set_background("#edeee6ff");
            obj.style.set_border("1 solid #c6c6c5ff");
            obj.style.set_align("center middle");
            obj.style.set_font("antialias 15 Tahoma");
            this.addChild(obj.name, obj);

            obj = new Static("Static24", "absolute", "25", "64", "510", "60", null, null, this);
            obj.set_taborder("16");
            obj.set_text("※ Listl형 그리드는 Head 높이값이 0으로 사용하지 않는다.\r\n※ 특이 Cell Style에 대해 Cell Class를 사용한다.\r\n※ align은 center정렬이 기본이며 left/right 정렬이 필요 시 해당 Cell의 Properties에 \r\n   align값과 padding값을 직접 입력한다.");
            obj.set_cssclass("sta_GUIDE_RedText");
            obj.set_visible("false");
            obj.style.set_linespace("3");
            obj.style.set_align("left top");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "-1", "408", null, "50", "0", null, this);
            obj.set_taborder("78");
            obj.set_text("Grid_List02");
            obj.style.set_background("#edeee6ff");
            obj.style.set_border("1 solid #c6c6c5ff");
            obj.style.set_align("center middle");
            obj.style.set_font("antialias 15 Tahoma");
            this.addChild(obj.name, obj);

            obj = new Static("Static10", "absolute", "25", "472", "510", "60", null, null, this);
            obj.set_taborder("80");
            obj.set_text("※ Listl형 그리드는 Head 높이값이 0으로 사용하지 않는다.\r\n※ 특이 Cell Style에 대해 Cell Class를 사용한다.\r\n※ align은 center정렬이 기본이며 left/right 정렬이 필요 시 해당 Cell의 Properties에 \r\n   align값과 padding값을 직접 입력한다.");
            obj.set_cssclass("sta_GUIDE_RedText");
            obj.set_visible("false");
            obj.style.set_linespace("3");
            obj.style.set_align("left top");
            this.addChild(obj.name, obj);

            obj = new Static("Static18", "absolute", "575", "562", "395", "35", null, null, this);
            obj.set_taborder("82");
            obj.set_text("Displaytype : button / edittype : button / Align : center middle");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static19", "absolute", "519", "577", "47", "2", null, null, this);
            obj.set_taborder("83");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static28", "absolute", "299", "735", "267", "2", null, null, this);
            obj.set_taborder("89");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static30", "absolute", "299", "687", null, "49", "239", null, this);
            obj.set_taborder("91");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static32", "absolute", "437", "675", "127", "2", null, null, this);
            obj.set_taborder("93");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static33", "absolute", "575", "659", "475", "35", null, null, this);
            obj.set_taborder("94");
            obj.set_text("Displaytype : number / Edittype : text / Editdisplay : Display / Align : right middle");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static29", "absolute", "575", "717", "475", "35", null, null, this);
            obj.set_taborder("98");
            obj.set_text("Edittype : text / Editdisplay : Display");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid00", "absolute", "0", "140", null, "205", "0", null, this);
            obj.set_cssclass("grd_WF_Default2");
            obj.set_taborder("99");
            obj.set_binddataset("ds_grdList01");
            obj.set_scrollbars("none");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"166\"/><Column size=\"60\"/><Column size=\"100\"/><Column size=\"8\"/><Column size=\"197\"/><Column size=\"9\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"51\"/><Row size=\"51\"/></Rows><Band id=\"head\"><Cell text=\"Column0\"/><Cell col=\"1\" text=\"Column1\"/><Cell col=\"2\" text=\"Column2\"/><Cell col=\"3\"/><Cell col=\"4\" text=\"Column3\"/><Cell col=\"5\"/></Band><Band id=\"body\"><Cell colspan=\"6\" style=\"padding:0 10 0 10;line:0 none;\" text=\"bind:Column0\"/><Cell row=\"1\" style=\"padding:0 10 0 10;\" text=\"bind:Column1\"/><Cell row=\"1\" col=\"1\" text=\"bind:Column2\"/><Cell row=\"1\" col=\"2\" displaytype=\"number\" edittype=\"none\" style=\"align:right middle;\" text=\"bind:Column3\" editdisplay=\"display\"/><Cell row=\"1\" col=\"3\"/><Cell row=\"1\" col=\"4\" displaytype=\"date\" edittype=\"date\" text=\"2015-12-29\" calendardisplay=\"display\"/><Cell row=\"1\" col=\"5\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "561", "233", "334", "35", null, null, this);
            obj.set_taborder("100");
            obj.set_text("Padding : 0 10 0 10");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "45", "248", "507", "2", null, null, this);
            obj.set_taborder("101");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "45", "226", "2", "22", null, null, this);
            obj.set_taborder("102");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "561", "122", "195", "35", null, null, this);
            obj.set_taborder("103");
            obj.set_text("Class : grd_WF_Default2");
            obj.set_cssclass("sta_GUIDE_RedText");
            obj.set_visible("false");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "113", "176", "2", "72", null, null, this);
            obj.set_taborder("104");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "435", "186", "117", "2", null, null, this);
            obj.set_taborder("105");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "561", "171", "524", "35", null, null, this);
            obj.set_taborder("106");
            obj.set_text("Displaytype : date / Edittype : date /calendardisplay : display");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static12", "absolute", "433", "187", "2", "12", null, null, this);
            obj.set_taborder("107");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "561", "149", "524", "35", null, null, this);
            obj.set_taborder("108");
            obj.set_text("Displaytype : number / Editdisplay : display / Align : right middle");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static14", "absolute", "303", "165", "2", "32", null, null, this);
            obj.set_taborder("109");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "305", "164", "247", "2", null, null, this);
            obj.set_taborder("110");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "561", "490", "195", "35", null, null, this);
            obj.set_taborder("112");
            obj.set_text("Class : grd_WF_Default2");
            obj.set_cssclass("sta_GUIDE_RedText");
            obj.set_visible("false");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 810, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("Grid_List");

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

        this.loadIncludeScript("COMP_GUIDE_06_4.xfdl", true);

       
    };
}
)();
