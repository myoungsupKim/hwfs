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
                this.set_titletext("Grid_Default");
                this._setFormPosition(0,0,540,664);
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
            obj._setContents("<ColumnInfo><Column id=\"업장명\" type=\"STRING\" size=\"256\"/><Column id=\"계획\" type=\"STRING\" size=\"256\"/><Column id=\"실적\" type=\"STRING\" size=\"256\"/><Column id=\"달성률\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"업장명\">한촌-본사</Col><Col id=\"계획\">일일계획</Col><Col id=\"실적\">실적</Col><Col id=\"달성률\">100%</Col></Row><Row><Col id=\"업장명\">한화건설</Col><Col id=\"계획\">일일계획</Col><Col id=\"실적\">실적</Col><Col id=\"달성률\">100%</Col></Row><Row><Col id=\"업장명\">한화빌딩점</Col><Col id=\"계획\">일일계획</Col><Col id=\"실적\">실적</Col><Col id=\"달성률\">100%</Col></Row><Row><Col id=\"업장명\">한촌-역삼</Col><Col id=\"계획\">일일계획</Col><Col id=\"실적\">실적</Col><Col id=\"달성률\">100%</Col></Row><Row><Col id=\"업장명\">한화건설</Col><Col id=\"계획\">일일계획</Col><Col id=\"실적\">실적</Col><Col id=\"달성률\">100%</Col></Row><Row><Col id=\"업장명\">한화빌딩점</Col><Col id=\"계획\">일일계획</Col><Col id=\"실적\">실적</Col><Col id=\"달성률\">100%</Col></Row><Row><Col id=\"업장명\">안촉역삼</Col><Col id=\"계획\">일일계획</Col><Col id=\"실적\">실적</Col><Col id=\"달성률\">100%</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("Static00", "absolute", "-1", "0", null, "50", "0", null, this);
            obj.set_taborder("0");
            obj.set_text("Grid_Default");
            obj.style.set_background("#edeee6ff");
            obj.style.set_border("1 solid #c6c6c5ff");
            obj.style.set_align("center middle");
            obj.style.set_font("antialias 15 Tahoma");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid00", "absolute", "10", "216", "520", "406", null, null, this);
            obj.set_taborder("15");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("none");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"200\"/><Column size=\"150\"/><Column size=\"70\"/><Column size=\"100\"/></Columns><Rows><Row size=\"55\" band=\"head\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"업장명\"/><Cell col=\"1\" text=\"계획\"/><Cell col=\"2\" text=\"실적\"/><Cell col=\"3\" text=\"달성률\"/></Band><Band id=\"body\"><Cell style=\"align:left middle;padding:0 0 0 10;\" text=\"bind:업장명\"/><Cell col=\"1\" text=\"bind:계획\"/><Cell col=\"2\" text=\"bind:실적\"/><Cell col=\"3\" style=\"align:right middle;padding:0 10 0 0;\" text=\"bind:달성률\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static24", "absolute", "25", "64", "510", "50", null, null, this);
            obj.set_taborder("16");
            obj.set_text("※ 모든 그리드는 ScrollBar 사용을 지양한다.\r\n※ align은 center정렬이 기본이며 left/right 정렬이 필요 시 \r\n    해당 Cell의 Properties에 align값과 padding값을 직접 입력한다.");
            obj.set_cssclass("sta_GUIDE_RedText");
            obj.set_visible("false");
            obj.style.set_linespace("3");
            obj.style.set_align("left top");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "542", "216", "21", "55", null, null, this);
            obj.set_taborder("26");
            obj.set_text("h55");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.set_positionstep("0");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "542", "271", "21", "50", null, null, this);
            obj.set_taborder("27");
            obj.set_text("h50");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "37", "143", "110", "85", null, null, this);
            obj.set_taborder("28");
            obj.set_text("* 왼쪽 정렬 일 때 :\r\n\r\nAlign\t: left middle;\r\nPadding\t: 0 0 0 10;\r\n");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "22", "161", "2", "123", null, null, this);
            obj.set_taborder("29");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "23", "159", "9", "2", null, null, this);
            obj.set_taborder("30");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "510", "160", "2", "123", null, null, this);
            obj.set_taborder("31");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "503", "159", "9", "2", null, null, this);
            obj.set_taborder("32");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "375", "143", "120", "85", null, null, this);
            obj.set_taborder("33");
            obj.set_text("* 오른쪽 정렬 일 때 :\r\n\r\nAlign\t: right middle;\r\nPadding\t: 0 10 0 0;\r\n");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            obj.style.set_align("right middle");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 664, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("Grid_Default");

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

        this.loadIncludeScript("COMP_GUIDE_06_1.xfdl", true);

       
    };
}
)();
