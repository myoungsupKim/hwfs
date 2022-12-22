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
                this.set_name("CmmnFrameMenu");
                this.set_titletext("Menu Frame");
                this.set_scrollbars("alwaysvert");
                this._setFormPosition(0,0,540,833);
            }
            this.style.set_background("#ffffffff");

            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new Div("divTop", "absolute", "0", "0", null, "73", "0", null, this);
            obj.set_taborder("21");
            obj.set_scrollbars("none");
            obj.set_visible("true");
            obj.set_url("frame::CmmnFrameTop.xfdl");
            this.addChild(obj.name, obj);

            obj = new Div("Div00", "absolute", "0%", "73", "540", "760", null, null, this);
            obj.set_taborder("22");
            this.addChild(obj.name, obj);
            obj = new Static("Static00", "absolute", "0%", "0", null, "62", "0", null, this.Div00);
            obj.set_taborder("0");
            obj.set_cssclass("sta_MAIN_WelcomeBg");
            obj.set_text("외식담당자님 로그인 하셨습니다");
            this.Div00.addChild(obj.name, obj);
            obj = new Static("Static01", "absolute", "0%", "62", null, "233", "0%", null, this.Div00);
            obj.set_taborder("2");
            obj.set_cssclass("sta_MAIN_BgImg");
            this.Div00.addChild(obj.name, obj);
            obj = new Div("Div00", "absolute", "0", "295", "540", "155", null, null, this.Div00);
            obj.set_taborder("11");
            this.Div00.addChild(obj.name, obj);
            obj = new Button("Button00", "absolute", "0", "0", "33.4%", "155", null, null, this.Div00.Div00);
            obj.set_taborder("0");
            obj.set_cssclass("btn_MAIN_Menu01");
            this.Div00.Div00.addChild(obj.name, obj);
            obj = new Button("Button01", "absolute", "180", "0", "33.4%", "155", null, null, this.Div00.Div00);
            obj.set_taborder("1");
            obj.set_cssclass("btn_MAIN_Menu02");
            this.Div00.Div00.addChild(obj.name, obj);
            obj = new Button("Button02", "absolute", "360", "0", "33.4%", "155", null, null, this.Div00.Div00);
            obj.set_taborder("2");
            obj.set_cssclass("btn_MAIN_Menu03");
            this.Div00.Div00.addChild(obj.name, obj);
            obj = new Div("Div01", "absolute", "0", "450", "100%", "155", null, null, this.Div00);
            obj.set_taborder("12");
            this.Div00.addChild(obj.name, obj);
            obj = new Button("Button00", "absolute", "0", "0", "33.33%", "155", null, null, this.Div00.Div01);
            obj.set_taborder("3");
            obj.set_cssclass("btn_MAIN_Menu04");
            this.Div00.Div01.addChild(obj.name, obj);
            obj = new Button("Button01", "absolute", "180", "0", "33.33%", "155", null, null, this.Div00.Div01);
            obj.set_taborder("4");
            obj.set_cssclass("btn_MAIN_Menu05");
            this.Div00.Div01.addChild(obj.name, obj);
            obj = new Button("Button02", "absolute", "360", "0", "33.33%", "155", null, null, this.Div00.Div01);
            obj.set_taborder("5");
            obj.set_cssclass("btn_MAIN_Menu06");
            this.Div00.Div01.addChild(obj.name, obj);
            obj = new Div("Div02", "absolute", "0", "605", "100%", "155", null, null, this.Div00);
            obj.set_taborder("13");
            this.Div00.addChild(obj.name, obj);
            obj = new Button("Button00", "absolute", "0", "0", "33.33%", "155", null, null, this.Div00.Div02);
            obj.set_taborder("6");
            obj.set_cssclass("btn_MAIN_Menu07");
            this.Div00.Div02.addChild(obj.name, obj);
            obj = new Button("Button01", "absolute", "180", "0", "33.33%", "155", null, null, this.Div00.Div02);
            obj.set_taborder("7");
            obj.set_cssclass("btn_MAIN_Menu08");
            this.Div00.Div02.addChild(obj.name, obj);
            obj = new Button("Button02", "absolute", "360", "0", "33.33%", "155", null, null, this.Div00.Div02);
            obj.set_taborder("8");
            obj.set_cssclass("btn_MAIN_Menu09");
            this.Div00.Div02.addChild(obj.name, obj);

            obj = new Button("Button02", "absolute", "360", "850", "33.33%", "155", null, null, this);
            obj.set_taborder("23");
            obj.set_cssclass("btn_MAIN_Menu10");
            this.addChild(obj.name, obj);

            obj = new Button("Button00", "absolute", "360", "1018", "33.33%", "155", null, null, this);
            obj.set_taborder("24");
            obj.set_cssclass("btn_MAIN_Menu11");
            this.addChild(obj.name, obj);

            obj = new Button("Button01", "absolute", "580", "368", "33.33%", "155", null, null, this);
            obj.set_taborder("25");
            obj.set_cssclass("btn_MAIN_Menu01S");
            this.addChild(obj.name, obj);

            obj = new Button("Button03", "absolute", "760", "368", "33.33%", "155", null, null, this);
            obj.set_taborder("26");
            obj.set_cssclass("btn_MAIN_Menu02S");
            this.addChild(obj.name, obj);

            obj = new Button("Button04", "absolute", "940", "368", "33.33%", "155", null, null, this);
            obj.set_taborder("27");
            obj.set_cssclass("btn_MAIN_Menu03S");
            this.addChild(obj.name, obj);

            obj = new Button("Button05", "absolute", "940", "523", "33.33%", "155", null, null, this);
            obj.set_taborder("28");
            obj.set_cssclass("btn_MAIN_Menu06S");
            this.addChild(obj.name, obj);

            obj = new Button("Button06", "absolute", "760", "523", "33.33%", "155", null, null, this);
            obj.set_taborder("29");
            obj.set_cssclass("btn_MAIN_Menu05S");
            this.addChild(obj.name, obj);

            obj = new Button("Button07", "absolute", "580", "523", "33.33%", "155", null, null, this);
            obj.set_taborder("30");
            obj.set_cssclass("btn_MAIN_Menu04S");
            this.addChild(obj.name, obj);

            obj = new Button("Button08", "absolute", "940", "678", "33.33%", "155", null, null, this);
            obj.set_taborder("31");
            obj.set_cssclass("btn_MAIN_Menu09S");
            this.addChild(obj.name, obj);

            obj = new Button("Button09", "absolute", "760", "678", "33.33%", "155", null, null, this);
            obj.set_taborder("32");
            obj.set_cssclass("btn_MAIN_Menu08S");
            this.addChild(obj.name, obj);

            obj = new Button("Button10", "absolute", "580", "678", "33.33%", "155", null, null, this);
            obj.set_taborder("33");
            obj.set_cssclass("btn_MAIN_Menu07S");
            this.addChild(obj.name, obj);

            obj = new Button("Button11", "absolute", "938", "850", "180", "155", null, null, this);
            obj.set_taborder("34");
            obj.set_cssclass("btn_MAIN_Menu10S");
            this.addChild(obj.name, obj);

            obj = new Button("Button12", "absolute", "938", "1018", "180", "155", null, null, this);
            obj.set_taborder("35");
            obj.set_cssclass("btn_MAIN_Menu11S");
            this.addChild(obj.name, obj);

            obj = new Div("Div01", "absolute", "1180", "368", "540", "155", null, null, this);
            obj.set_taborder("36");
            obj.set_cssclass("div_MAIN_2DepthMenuBg");
            this.addChild(obj.name, obj);
            obj = new Button("Button00", "absolute", "15", "17", "162", "55", null, null, this.Div01);
            obj.set_taborder("0");
            obj.set_text("추가발주");
            obj.set_cssclass("btn_MAIN_2DepthMenu");
            this.Div01.addChild(obj.name, obj);
            obj = new Button("Button01", "absolute", "189", "17", "162", "55", null, null, this.Div01);
            obj.set_taborder("1");
            obj.set_text("추가발주취소");
            obj.set_cssclass("btn_MAIN_2DepthMenu");
            this.Div01.addChild(obj.name, obj);
            obj = new Button("Button02", "absolute", "363", "17", "162", "55", null, null, this.Div01);
            obj.set_taborder("2");
            obj.set_text("추가발주현황");
            obj.set_cssclass("btn_MAIN_2DepthMenu");
            this.Div01.addChild(obj.name, obj);
            obj = new Button("Button03", "absolute", "363", "83", "162", "55", null, null, this.Div01);
            obj.set_taborder("3");
            obj.set_text("발주반려현황");
            obj.set_cssclass("btn_MAIN_2DepthMenu");
            this.Div01.addChild(obj.name, obj);
            obj = new Button("Button04", "absolute", "189", "83", "162", "55", null, null, this.Div01);
            obj.set_taborder("4");
            obj.set_text("일일발주내역");
            obj.set_cssclass("btn_MAIN_2DepthMenu");
            this.Div01.addChild(obj.name, obj);
            obj = new Button("Button05", "absolute", "15", "83", "162", "55", null, null, this.Div01);
            obj.set_taborder("5");
            obj.set_text("상품발주");
            obj.set_cssclass("btn_MAIN_2DepthMenu");
            this.Div01.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "66", "892", "255", "76", null, null, this);
            obj.set_taborder("37");
            obj.set_text("Class : btn_MAIN_Menu10 ----->");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.style.set_align("right middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "66", "1050", "255", "76", null, null, this);
            obj.set_taborder("38");
            obj.set_text("Class : btn_MAIN_Menu11 ----->");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.style.set_align("right middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "594", "270", "515", "76", null, null, this);
            obj.set_taborder("39");
            obj.set_text("ㅡㅡㅡㅡㅡㅡㅡ각 클래스 네임 끝에 S를 붙였습니다.ㅡㅡㅡㅡㅡㅡㅡ\r\n|                                                                                           |");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "1219", "552", "918", "47", null, null, this);
            obj.set_taborder("40");
            obj.set_text("2 Depth Menu Div 입니다.\r\n (Class : div_MAIN_2DepthMenuBg)  \r\n\r\n\r\nBackground 변경의 경우\r\n1. Theme의 CSS에 클래스 : div_MAIN_2DepthMenuBg 검색\r\n2. Background  속성의 해당 Imagenane을 교체 or #코드값 을 입력\r\n  (예 : Background : URL('HWImage::IMAGENAME.png') stretch 3, 3; / Background : #코드값;) \r\n\r\n주의 : 이미지의 Stretch 속성을 고려하여 작성 해 주세요");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.style.set_align("left top");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "1190", "520", "2", "40", null, null, this);
            obj.set_taborder("41");
            obj.set_cssclass("sta_GUIDE_Area");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "1190", "558", "20", "2", null, null, this);
            obj.set_taborder("42");
            obj.set_cssclass("sta_GUIDE_Area");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "1208", "338", "2", "60", null, null, this);
            obj.set_taborder("43");
            obj.set_cssclass("sta_GUIDE_Area");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "1210", "338", "20", "2", null, null, this);
            obj.set_taborder("44");
            obj.set_cssclass("sta_GUIDE_Area");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "1237", "331", "441", "16", null, null, this);
            obj.set_taborder("45");
            obj.set_text("Class : btn_MAIN_2DepthMenu");
            obj.set_cssclass("sta_GUIDE_BlackText");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "1678", "368", "70", "17", null, null, this);
            obj.set_taborder("46");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.style.set_align("right middle");
            obj.set_text("h17");
            this.addChild(obj.name, obj);

            obj = new Static("Static10", "absolute", "1678", "506", "70", "17", null, null, this);
            obj.set_taborder("47");
            obj.set_text("h17");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.style.set_align("right middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static11", "absolute", "1678", "440", "70", "11", null, null, this);
            obj.set_taborder("48");
            obj.set_text("h11");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.style.set_align("right middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static12", "absolute", "1705", "336", "15", "67", null, null, this);
            obj.set_taborder("49");
            obj.set_text("w15");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.style.set_align("right top");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "1531", "336", "12", "67", null, null, this);
            obj.set_taborder("50");
            obj.set_text("w12");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.style.set_align("right top");
            this.addChild(obj.name, obj);

            obj = new Static("Static14", "absolute", "1357", "336", "12", "67", null, null, this);
            obj.set_taborder("51");
            obj.set_text("w12");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.style.set_align("right top");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "1180", "336", "15", "67", null, null, this);
            obj.set_taborder("52");
            obj.set_text("w15");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.style.set_align("right top");
            this.addChild(obj.name, obj);

            obj = new Static("Static16", "absolute", "1219", "590", "918", "117", null, null, this);
            obj.set_taborder("53");
            obj.set_text("Background 변경 시\r\n1. Theme의 CSS에 클래스 : div_MAIN_2DepthMenuBg 검색\r\n2. Background  속성의 해당 Imagenane을 변경 or #코드값 을 입력\r\n  예) Background : URL('HWImage::IMAGENAME.png') stretch 3, 3; / Background : #코드값; \r\n\r\n주의 : 이미지의 Stretch 속성을 고려하여 작성 해 주세요");
            obj.set_cssclass("sta_GUIDE_RedText");
            obj.style.set_align("left top");
            this.addChild(obj.name, obj);

            obj = new Static("Static17", "absolute", "667", "188", "918", "117", null, null, this);
            obj.set_taborder("54");
            obj.set_text("Background 변경 시\r\n1. Theme의 CSS에 각 버튼들의 클래스 :btn_MAIN_Menu 군 검색\r\n2. Background  속성의 변경하고자하는  #코드값 을 #코드값 자리에 입력\r\n   예) background : #변경하고자하는 코드값 URL('HWImage::btn_MAIN_Menu01S.png') center middle;\r\n\r\n주의 : 이미지의 URL경로를 지우지 마세요");
            obj.set_cssclass("sta_GUIDE_RedText");
            obj.style.set_align("left top");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 155, this.Div00.Div00,
            	//-- Layout function
            	function(p) {
            		p.set_taborder("11");

            	}
            );
            this.Div00.Div00.addLayout(obj.name, obj);

            //-- Default Layout
            obj = new Layout("default", "", 0, 155, this.Div00.Div01,
            	//-- Layout function
            	function(p) {
            		p.set_taborder("12");

            	}
            );
            this.Div00.Div01.addLayout(obj.name, obj);

            //-- Default Layout
            obj = new Layout("default", "", 0, 155, this.Div00.Div02,
            	//-- Layout function
            	function(p) {
            		p.set_taborder("13");

            	}
            );
            this.Div00.Div02.addLayout(obj.name, obj);

            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this.Div00,
            	//-- Layout function
            	function(p) {
            		p.set_taborder("22");

            	}
            );
            this.Div00.addLayout(obj.name, obj);

            //-- Default Layout
            obj = new Layout("default", "", 540, 155, this.Div01,
            	//-- Layout function
            	function(p) {
            		p.set_taborder("36");
            		p.set_cssclass("div_MAIN_2DepthMenuBg");

            	}
            );
            this.Div01.addLayout(obj.name, obj);

            //-- Default Layout
            obj = new Layout("default", "ScreenPad,ScreenPhone", 540, 833, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frameMenu");
            		p.set_titletext("Menu Frame");
            		p.set_scrollbars("alwaysvert");
            		p.style.set_background("#ffffffff");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        
        this.loadPreloadList = function()
        {
            this._addPreloadList("fdl", "frame::CmmnFrameTop.xfdl");
        };
        
        // User Script

        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.CmmnFrameMenu_onload, this);
            this.addEventHandler("ontimer", this.CmmnFrameMenu_ontimer, this);

        };

        this.loadIncludeScript("CmmnFrameMenu_Design.xfdl", true);
        this.loadPreloadList();
       
    };
}
)();
