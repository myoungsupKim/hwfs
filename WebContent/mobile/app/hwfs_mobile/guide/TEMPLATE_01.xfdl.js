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
                this.set_titletext("가계약등록");
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
            obj._setContents("<ColumnInfo><Column id=\"시간\" type=\"STRING\" size=\"256\"/><Column id=\"예약상태\" type=\"STRING\" size=\"256\"/><Column id=\"신청\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"시간\">9시</Col><Col id=\"예약상태\">가계약</Col><Col id=\"신청\">신청</Col></Row><Row><Col id=\"시간\">10시</Col><Col id=\"예약상태\">확정예약</Col><Col id=\"신청\">신청</Col></Row><Row><Col id=\"시간\">11시</Col><Col id=\"예약상태\">가계약</Col><Col id=\"신청\">신청</Col></Row><Row><Col id=\"시간\">12시</Col><Col id=\"예약상태\">확정예약</Col><Col id=\"신청\">신청</Col></Row><Row><Col id=\"시간\">13시</Col><Col id=\"예약상태\">확정예약</Col><Col id=\"신청\">신청</Col></Row><Row><Col id=\"시간\">14시</Col><Col id=\"예약상태\">가계약</Col><Col id=\"신청\">신청</Col></Row><Row><Col id=\"시간\">15시</Col><Col id=\"예약상태\">가계약</Col><Col id=\"신청\">신청</Col></Row><Row><Col id=\"시간\">16시</Col><Col id=\"예약상태\">가계약</Col><Col id=\"신청\">신청</Col></Row><Row><Col id=\"시간\">17시</Col><Col id=\"예약상태\">가계약</Col><Col id=\"신청\">신청</Col></Row><Row><Col id=\"시간\">18시</Col><Col id=\"예약상태\">가계약</Col><Col id=\"신청\">신청</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
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

            obj = new Static("Static15", "absolute", "0", "187", "10", "456", null, null, this);
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

            obj = new Static("Static00", "absolute", "0", "60", null, "59", "0", null, this);
            obj.set_taborder("67");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static25", "absolute", "0", "60", "135", "59", null, null, this);
            obj.set_taborder("73");
            obj.set_text("연회장명");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit00", "absolute", "139", "8", null, "47", "10", null, this);
            obj.set_taborder("80");
            obj.set_value("연세플라자점");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "0", "118", null, "59", "0", null, this);
            obj.set_taborder("82");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "0", "118", "135", "59", null, null, this);
            obj.set_taborder("83");
            obj.set_text("예약일자");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Calendar("Calendar01", "absolute", "139", "124", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("85");
            obj.set_displaynulltext("2015-12-29");

            obj = new Button("Button00", "absolute", null, "124", "100", "47", "10", null, this);
            obj.set_taborder("86");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "0", "2", "135", "59", null, null, this);
            obj.set_taborder("87");
            obj.set_text("사업장");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "119", "23", "20", "129", null, null, this);
            obj.set_taborder("88");
            obj.set_text("글자사이간격w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit01", "absolute", "139", "66", null, "47", "10", null, this);
            obj.set_taborder("89");
            obj.set_value("연회장을 입력");
            this.addChild(obj.name, obj);

            obj = new Button("Button01", "absolute", null, "66", "47", "47", "10", null, this);
            obj.set_taborder("90");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid00", "absolute", "10", "187", null, "456", "10", null, this);
            obj.set_taborder("91");
            obj.set_scrollbars("none");
            obj.set_binddataset("ds_grd");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"140\"/><Column size=\"380\"/></Columns><Rows><Row size=\"55\" band=\"head\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"시간\"/><Cell col=\"1\" text=\"예약상태\"/></Band><Band id=\"body\"><Cell style=\"align:right middle;padding:0 10 0 10;\" text=\"bind:시간\"/><Cell col=\"1\" style=\"align:right middle;padding:0 10 0 10;\" text=\"bind:예약상태\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "530", "187", "10", "456", null, null, this);
            obj.set_taborder("92");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static18", "absolute", "108", "672", "110", "2", null, null, this);
            obj.set_taborder("93");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "223", "658", "349", "30", null, null, this);
            obj.set_taborder("94");
            obj.set_text("Align : right middle / padding : 0 10 0 10");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static10", "absolute", "108", "620", "2", "52", null, null, this);
            obj.set_taborder("96");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static11", "absolute", "186", "620", "2", "52", null, null, this);
            obj.set_taborder("97");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid01", "absolute", "630", "187", "520", "456", null, null, this);
            obj.set_taborder("98");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("none");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"140\"/><Column size=\"380\"/></Columns><Rows><Row size=\"55\" band=\"head\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"시간\"/><Cell col=\"1\" text=\"예약상태\"/></Band><Band id=\"body\"><Cell style=\"align:right middle;padding:0 10 0 10;\" text=\"bind:시간\"/><Cell col=\"1\" displaytype=\"button\" edittype=\"button\" style=\"align: ;padding:1 10 1 304;\" text=\"bind:신청\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static12", "absolute", "1046", "672", "10", "2", null, null, this);
            obj.set_taborder("99");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "601", "658", "429", "30", null, null, this);
            obj.set_taborder("100");
            obj.set_text("DisplayType : button / EditType : button / padding : 1 10 1 304");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            obj.style.set_align("right");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static16", "absolute", "1054", "620", "2", "52", null, null, this);
            obj.set_taborder("101");
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
            		p.set_titletext("가계약등록");

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

        this.loadIncludeScript("TEMPLATE_01.xfdl", true);

       
    };
}
)();
