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
                this.set_titletext("긴급여신승인");
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
            obj._setContents("<ColumnInfo><Column id=\"Column0\" type=\"STRING\" size=\"256\"/><Column id=\"Column1\" type=\"STRING\" size=\"256\"/><Column id=\"Column2\" type=\"STRING\" size=\"256\"/><Column id=\"Column3\" type=\"STRING\" size=\"256\"/><Column id=\"Column4\" type=\"STRING\" size=\"256\"/><Column id=\"Column5\" type=\"STRING\" size=\"256\"/><Column id=\"Column6\" type=\"STRING\" size=\"256\"/><Column id=\"Column7\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column0\">2015-12-29</Col><Col id=\"Column1\">홍길동</Col><Col id=\"Column2\">승인</Col><Col id=\"Column3\">FS개발팀</Col><Col id=\"Column4\">개발1팀</Col><Col id=\"Column5\">반려</Col><Col id=\"Column6\">2015-01-01~2015-12-29</Col><Col id=\"Column7\">750000</Col></Row><Row><Col id=\"Column0\">2015-12-29</Col><Col id=\"Column1\">홍길동</Col><Col id=\"Column2\">승인</Col><Col id=\"Column3\">FS개발팀</Col><Col id=\"Column4\">개발1팀</Col><Col id=\"Column5\">반려</Col><Col id=\"Column6\">2015-01-01~2015-12-29</Col><Col id=\"Column7\">750000</Col></Row><Row><Col id=\"Column0\">2015-12-29</Col><Col id=\"Column1\">홍길동</Col><Col id=\"Column2\">승인</Col><Col id=\"Column3\">FS개발팀</Col><Col id=\"Column4\">개발1팀</Col><Col id=\"Column5\">반려</Col><Col id=\"Column6\">2015-01-01~2015-12-29</Col><Col id=\"Column7\">750000</Col></Row><Row><Col id=\"Column0\">2015-12-29</Col><Col id=\"Column1\">홍길동</Col><Col id=\"Column2\">승인</Col><Col id=\"Column3\">FS개발팀</Col><Col id=\"Column4\">개발1팀</Col><Col id=\"Column5\">반려</Col><Col id=\"Column6\">2015-01-01~2015-12-29</Col><Col id=\"Column7\">750000</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("Static04", "absolute", "0", "0", null, "2", "0", null, this);
            obj.set_taborder("0");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "0", "2", null, "59", "0", null, this);
            obj.set_taborder("1");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "0", "2", "135", "59", null, null, this);
            obj.set_taborder("2");
            obj.set_text("요청일자");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Calendar("Calendar01", "absolute", "139", "8", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("3");
            obj.set_displaynulltext("2015-12-29");

            obj = new Button("Button00", "absolute", null, "8", "100", "47", "10", null, this);
            obj.set_taborder("4");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "61", "540", "10", null, null, this);
            obj.set_taborder("5");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid01", "absolute", "0", "71", null, "589", "0", null, this);
            obj.set_taborder("8");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("none");
            obj.set_autofittype("col");
            obj.set_cssclass("grd_WF_Default2");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"9\"/><Column size=\"261\"/><Column size=\"120\"/><Column size=\"8\"/><Column size=\"64\"/><Column size=\"69\"/><Column size=\"9\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"5\"/><Row size=\"39\"/><Row size=\"2\"/><Row size=\"39\"/><Row size=\"7\"/><Row size=\"50\"/><Row size=\"5\"/></Rows><Band id=\"head\"><Cell/><Cell col=\"1\" text=\"GrayLabel\"/><Cell col=\"2\"/><Cell col=\"3\"/><Cell col=\"4\" text=\"WhiteLabel\"/><Cell col=\"5\" text=\"GrayLabel\"/><Cell col=\"6\"/></Band><Band id=\"body\"><Cell style=\"line:0 none;\"/><Cell col=\"1\" style=\"line:0 none;\"/><Cell col=\"2\" style=\"line:0 none;\"/><Cell col=\"3\" style=\"line:0 none;\"/><Cell col=\"4\" style=\"line:0 none;\"/><Cell col=\"5\" style=\"line:0 none;\"/><Cell col=\"6\" style=\"line:0 none;\"/><Cell row=\"1\" style=\"line:0 none;\"/><Cell row=\"1\" col=\"1\" celltype=\"none\" style=\"align: ;line:0 none #808080 ;\" text=\"bind:Column0\"/><Cell row=\"1\" col=\"2\" colspan=\"3\" style=\"align: ;line:0 none #808080 ;\" text=\"bind:Column1\"/><Cell row=\"1\" col=\"5\" displaytype=\"button\" edittype=\"button\" style=\"align:center middle;line:0 none #808080ff ;\" text=\"bind:Column2\"/><Cell row=\"1\" col=\"6\" style=\"line:0 none;\"/><Cell row=\"2\" style=\"line:0 none;\"/><Cell row=\"2\" col=\"1\" style=\"align: ;line:0 none #808080 ;\"/><Cell row=\"2\" col=\"2\" style=\"align: ;line:0 none #808080 ;\"/><Cell row=\"2\" col=\"3\" style=\"align: ;line:0 none #808080 ;\"/><Cell row=\"2\" col=\"4\" style=\"align: ;line:0 none #808080 ;\"/><Cell row=\"2\" col=\"5\" style=\"align:center middle;line:0 none #808080ff ;\"/><Cell row=\"2\" col=\"6\" style=\"line:0 none;\"/><Cell row=\"3\" style=\"line:0 none;\"/><Cell row=\"3\" col=\"1\" celltype=\"none\" style=\"align: ;line:0 none #808080 ;\" text=\"bind:Column3\"/><Cell row=\"3\" col=\"2\" colspan=\"3\" style=\"align: ;line:0 none #808080 ;\" text=\"bind:Column4\"/><Cell row=\"3\" col=\"5\" celltype=\"none\" displaytype=\"button\" edittype=\"button\" style=\"align:center middle;line:0 none #808080ff ;\" text=\"bind:Column5\"/><Cell row=\"3\" col=\"6\" style=\"line:0 none;\"/><Cell row=\"4\" style=\"line:0 none;\"/><Cell row=\"4\" col=\"1\" style=\"line:0 none;\"/><Cell row=\"4\" col=\"2\" style=\"line:0 none;\"/><Cell row=\"4\" col=\"3\" style=\"line:0 none;\"/><Cell row=\"4\" col=\"4\" style=\"line:0 none;\"/><Cell row=\"4\" col=\"5\" style=\"line:0 none;\"/><Cell row=\"4\" col=\"6\" style=\"line:0 none;\"/><Cell row=\"5\" style=\"line:0 none;\"/><Cell row=\"5\" col=\"1\" colspan=\"2\" edittype=\"text\" style=\"align: ;line:0 none #808080 ;\" text=\"bind:Column6\" editdisplay=\"display\"/><Cell row=\"5\" col=\"3\" style=\"line:0 none;\"/><Cell row=\"5\" col=\"4\" colspan=\"2\" celltype=\"none\" displaytype=\"number\" style=\"align:right middle;line:0 none;\" text=\"bind:Column7\" editdisplay=\"display\"/><Cell row=\"5\" col=\"6\" style=\"line:0 none;\"/><Cell row=\"6\" colspan=\"7\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Button("Button36", "absolute", "0", null, null, "35", "0", "0", this);
            obj.set_taborder("9");
            obj.set_text("더보기");
            obj.set_cssclass("btn_WF_More");
            this.addChild(obj.name, obj);

            obj = new Static("Static43", "absolute", "119", "19", "20", "29", null, null, this);
            obj.set_taborder("10");
            obj.set_text("글자사이간격w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static18", "absolute", "238", "692", "110", "2", null, null, this);
            obj.set_taborder("11");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "353", "678", "349", "30", null, null, this);
            obj.set_taborder("12");
            obj.set_text("Style : COMP_GUIDE_06_4의 List02  참조 ");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static10", "absolute", "238", "640", "2", "52", null, null, this);
            obj.set_taborder("13");
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
            		p.set_titletext("긴급여신승인");

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

        this.loadIncludeScript("TEMPLATE_05.xfdl", true);

       
    };
}
)();
