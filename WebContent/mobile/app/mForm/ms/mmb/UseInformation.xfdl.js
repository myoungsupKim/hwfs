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
                this.set_name("frmExam_001");
                this.set_titletext("이용안내");
                this._setFormPosition(0,0,562,1130);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new Static("staTitleT03", "absolute", "10", "469", "520", "173", null, null, this);
            obj.set_taborder("0");
            obj.set_cssclass("sta_WF_SearchBg");
            this.addChild(obj.name, obj);

            obj = new Static("staTitleT00", "absolute", "10", "5", "520", "70", null, null, this);
            obj.set_taborder("1");
            obj.set_cssclass("sta_WF_SearchBg");
            this.addChild(obj.name, obj);

            obj = new Static("staTitleT04", "absolute", "10", "640", "520", "70", null, null, this);
            obj.set_taborder("2");
            obj.set_cssclass("sta_WF_SearchBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "0", "0", null, "2", "0", null, this);
            obj.set_taborder("3");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);

            obj = new Static("sta_img00", "absolute", "8", "11", "158", "240", null, null, this);
            obj.set_taborder("4");
            obj.set_cssclass("sta_WF_WebzineImg");
            obj.style.set_background("#ebebebff URL('theme://Image/useinform_intro.png') stretch");
            this.addChild(obj.name, obj);

            obj = new Static("sta_img01", "absolute", "190", "11", "158", "240", null, null, this);
            obj.set_taborder("5");
            obj.set_cssclass("sta_WF_WebzineImg");
            obj.style.set_background("#ebebebff URL('theme://Image/useinform_login.png') stretch");
            this.addChild(obj.name, obj);

            obj = new Static("sta_img02", "absolute", "372", "10", "158", "240", null, null, this);
            obj.set_taborder("6");
            obj.set_cssclass("sta_WF_WebzineImg");
            obj.style.set_background("#ebebebff URL('theme://Image/useinform_loginAfter.png') stretch");
            this.addChild(obj.name, obj);

            obj = new Static("sta_box00", "absolute", "9", "260", "521", "172", null, null, this);
            obj.set_taborder("7");
            obj.style.set_border("1 solid #808080ff");
            obj.style.set_padding("10 5 10 5");
            obj.style.set_align("left top");
            obj.style.set_font("bold antialias 17 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "2", "10", "752", null, null, this);
            obj.set_taborder("8");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "2", "535", "10", null, null, this);
            obj.set_taborder("9");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "530", "2", "10", "752", null, null, this);
            obj.set_taborder("10");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "5", "250", "535", "10", null, null, this);
            obj.set_taborder("11");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("sta_img03", "absolute", "8", "440", "158", "240", null, null, this);
            obj.set_taborder("12");
            obj.set_cssclass("sta_WF_WebzineImg");
            obj.style.set_background("#ebebebff URL('theme://Image/useinform_mainMenu.png') stretch");
            this.addChild(obj.name, obj);

            obj = new Static("sta_img04", "absolute", "190", "440", "158", "240", null, null, this);
            obj.set_taborder("13");
            obj.set_cssclass("sta_WF_WebzineImg");
            obj.style.set_background("#ebebebff URL('theme://Image/useinform_submenu.png') stretch");
            this.addChild(obj.name, obj);

            obj = new Static("sta_img05", "absolute", "372", "439", "158", "240", null, null, this);
            obj.set_taborder("14");
            obj.set_cssclass("sta_WF_WebzineImg");
            obj.style.set_background("#ebebebff URL('theme://Image/useinform_quickMenu.png') stretch");
            this.addChild(obj.name, obj);

            obj = new Static("sta_box01", "absolute", "9", "688", "521", "172", null, null, this);
            obj.set_taborder("15");
            obj.style.set_border("1 solid #808080ff");
            obj.style.set_padding("10 5 10 5");
            obj.style.set_align("left top");
            this.addChild(obj.name, obj);

            obj = new Static("sta_info00", "absolute", "8", "255", "521", "59", null, null, this);
            obj.set_taborder("16");
            obj.set_text("APP를 실행하면 처음 로딩화면이 나옵니다");
            obj.set_cssclass("sta_WF_Label02");
            obj.style.set_font("bold antialias 14 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new Static("sta_info01", "absolute", "9", "293", "521", "59", null, null, this);
            obj.set_taborder("17");
            obj.set_text("로그인 창에서 아이디와 비밀번호를 입력합니다.");
            obj.set_cssclass("sta_WF_Label02");
            obj.style.set_font("bold antialias 14 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new Static("sta_info02", "absolute", "9", "337", "521", "59", null, null, this);
            obj.set_taborder("18");
            obj.set_text("자동로그인 체크시 바로 메인메뉴로 이동합니다(아이디 저장도 가능합니다.)");
            obj.set_cssclass("sta_WF_Label02");
            obj.style.set_font("bold antialias 14 Droid Sans");
            obj.set_wordwrap("char");
            this.addChild(obj.name, obj);

            obj = new Static("sta_info03", "absolute", "9", "385", "521", "59", null, null, this);
            obj.set_taborder("19");
            obj.set_text("로그인 저장시 로그인 정보 팝업창을 띄워줍니다.");
            obj.set_cssclass("sta_WF_Label02");
            obj.style.set_font("bold antialias 14 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new Static("sta_info04", "absolute", "9", "708", "521", "59", null, null, this);
            obj.set_taborder("20");
            obj.set_text("메인메뉴를 클릭하면 아래로 슬라이드 형식으로 서브 메뉴가 나타납니다.");
            obj.set_cssclass("sta_WF_Label02");
            obj.style.set_font("bold antialias 14 Droid Sans");
            obj.set_wordwrap("char");
            this.addChild(obj.name, obj);

            obj = new Static("sta_info05", "absolute", "9", "780", "521", "59", null, null, this);
            obj.set_taborder("21");
            obj.set_text("우측 상단 아이콘을 클릭하면 우측에서 퀵메뉴가 나타납니다.");
            obj.set_cssclass("sta_WF_Label02");
            obj.style.set_font("bold antialias 14 Droid Sans");
            obj.set_wordwrap("char");
            this.addChild(obj.name, obj);

            obj = new Static("sta_img06", "absolute", "8", "867", "158", "240", null, null, this);
            obj.set_taborder("23");
            obj.set_cssclass("sta_WF_WebzineImg");
            obj.style.set_background("#ebebebff URL('theme://Image/useinform_etcMenu.png') stretch");
            this.addChild(obj.name, obj);

            obj = new Static("sta_img07", "absolute", "190", "867", "158", "240", null, null, this);
            obj.set_taborder("24");
            obj.set_cssclass("sta_WF_WebzineImg");
            obj.style.set_background("#ebebebff URL('theme://Image/useinform_setting.png') stretch");
            this.addChild(obj.name, obj);

            obj = new Static("sta_img08", "absolute", "372", "866", "158", "240", null, null, this);
            obj.set_taborder("25");
            obj.set_cssclass("sta_WF_WebzineImg");
            obj.style.set_background("#ebebebff URL('theme://Image/useinform_gpsMap.png') stretch");
            this.addChild(obj.name, obj);

            obj = new Static("sta_box02", "absolute", "9", "1115", "521", "172", null, null, this);
            obj.set_taborder("26");
            obj.style.set_border("1 solid #808080ff");
            obj.style.set_padding("10 5 10 5");
            obj.style.set_align("left top");
            this.addChild(obj.name, obj);

            obj = new Static("sta_img09", "absolute", "80", "1295", "158", "240", null, null, this);
            obj.set_taborder("30");
            obj.set_cssclass("sta_WF_WebzineImg");
            obj.style.set_background("#ebebebff URL('theme://Image/useinform_phoneCall.png') stretch");
            this.addChild(obj.name, obj);

            obj = new Static("sta_img10", "absolute", "302", "1295", "158", "240", null, null, this);
            obj.set_taborder("31");
            obj.set_cssclass("sta_WF_WebzineImg");
            obj.style.set_background("#ebebebff URL('theme://Image/useinform_phoneCallAfter.png') stretch");
            this.addChild(obj.name, obj);

            obj = new Static("sta_box03", "absolute", "10", "1543", "521", "172", null, null, this);
            obj.set_taborder("33");
            obj.style.set_border("1 solid #808080ff");
            obj.style.set_padding("10 5 10 5");
            obj.style.set_align("left top");
            obj.set_wordwrap("char");
            this.addChild(obj.name, obj);

            obj = new Static("sta_img11", "absolute", "80", "1723", "158", "240", null, null, this);
            obj.set_taborder("34");
            obj.set_cssclass("sta_WF_WebzineImg");
            obj.style.set_background("#ebebebff URL('theme://Image/useinform_pdf.png') stretch");
            this.addChild(obj.name, obj);

            obj = new Static("sta_img12", "absolute", "302", "1723", "158", "240", null, null, this);
            obj.set_taborder("35");
            obj.set_cssclass("sta_WF_WebzineImg");
            obj.style.set_background("#ebebebff URL('theme://Image/useinform_pdfPop.png') stretch");
            this.addChild(obj.name, obj);

            obj = new Static("sta_box04", "absolute", "11", "1971", "521", "172", null, null, this);
            obj.set_taborder("37");
            obj.style.set_border("1 solid #808080ff");
            obj.style.set_padding("10 5 10 5");
            obj.style.set_align("left top");
            this.addChild(obj.name, obj);

            obj = new Static("sta_img13", "absolute", "11", "2151", "158", "240", null, null, this);
            obj.set_taborder("38");
            obj.set_cssclass("sta_WF_WebzineImg");
            obj.style.set_background("#ebebebff URL('theme://Image/useinform_photoGallery.png') stretch");
            this.addChild(obj.name, obj);

            obj = new Static("sta_img14", "absolute", "193", "2151", "158", "240", null, null, this);
            obj.set_taborder("39");
            obj.set_cssclass("sta_WF_WebzineImg");
            obj.style.set_background("#ebebebff URL('theme://Image/useinform_photoImage.png') stretch");
            this.addChild(obj.name, obj);

            obj = new Static("sta_img15", "absolute", "375", "2150", "158", "240", null, null, this);
            obj.set_taborder("40");
            obj.set_cssclass("sta_WF_WebzineImg");
            obj.style.set_background("#ebebebff URL('theme://Image/useinform_logout.png') stretch");
            this.addChild(obj.name, obj);

            obj = new Static("sta_box05", "absolute", "12", "2399", "521", "172", null, null, this);
            obj.set_taborder("41");
            obj.style.set_border("1 solid #808080ff");
            obj.style.set_padding("10 5 10 5");
            obj.style.set_align("left top");
            this.addChild(obj.name, obj);

            obj = new Static("sta_info07", "absolute", "9", "1172", "521", "59", null, null, this);
            obj.set_taborder("42");
            obj.set_text("환경설정 화면입니다(자동로그인, 아이디저장, PUSH 설정가능)");
            obj.set_cssclass("sta_WF_Label02");
            obj.style.set_font("bold antialias 14 Droid Sans");
            obj.set_wordwrap("char");
            this.addChild(obj.name, obj);

            obj = new Static("sta_info06", "absolute", "9", "1116", "521", "59", null, null, this);
            obj.set_taborder("43");
            obj.set_text("하단 두번째 버튼을 클릭하면 기타메뉴화면으로 이동합니다.");
            obj.set_cssclass("sta_WF_Label02");
            obj.style.set_font("bold antialias 14 Droid Sans");
            obj.set_wordwrap("char");
            this.addChild(obj.name, obj);

            obj = new Static("sta_info08", "absolute", "9", "1228", "521", "59", null, null, this);
            obj.set_taborder("44");
            obj.set_text("주변사업장보기화면입니다(현재위치 반경 1.5km내 주변사업장을 표시해줍니다.)");
            obj.set_cssclass("sta_WF_Label02");
            obj.style.set_font("bold antialias 14 Droid Sans");
            obj.set_wordwrap("char");
            this.addChild(obj.name, obj);

            obj = new Static("sta_info09", "absolute", "11", "1556", "521", "59", null, null, this);
            obj.set_taborder("45");
            obj.set_text("거래처정보화면입니다(해당 거래처 전화번호가 있을경우 전화 버튼이 나타납니다.)");
            obj.set_cssclass("sta_WF_Label02");
            obj.style.set_font("bold antialias 14 Droid Sans");
            obj.set_wordwrap("char");
            this.addChild(obj.name, obj);

            obj = new Static("sta_info10", "absolute", "11", "1630", "521", "59", null, null, this);
            obj.set_taborder("46");
            obj.set_text("전화 버튼을 클릭하면 전화앱으로 연동이 됩니다.");
            obj.set_cssclass("sta_WF_Label02");
            obj.style.set_font("bold antialias 14 Droid Sans");
            obj.set_wordwrap("char");
            this.addChild(obj.name, obj);

            obj = new Static("sta_info11", "absolute", "12", "1982", "521", "59", null, null, this);
            obj.set_taborder("47");
            obj.set_cssclass("sta_WF_Label02");
            obj.style.set_font("bold antialias 14 Droid Sans");
            obj.set_text("E-FOODIST화면입니다(표지 이미지를 클릭합니다.)");
            this.addChild(obj.name, obj);

            obj = new Static("sta_info12", "absolute", "12", "2054", "521", "59", null, null, this);
            obj.set_taborder("48");
            obj.set_text("E-FOODIST화면입니다(웹 매거진 PDF파일목록 확인 파일 다운로드를 할 수 있습니다.)");
            obj.set_cssclass("sta_WF_Label02");
            obj.style.set_font("bold antialias 14 Droid Sans");
            obj.set_wordwrap("char");
            this.addChild(obj.name, obj);

            obj = new Static("sta_info13", "absolute", "13", "2402", "521", "59", null, null, this);
            obj.set_taborder("49");
            obj.set_text("이미지 전송화면입니다(갤러리 연동 복수선택 가능합니다)");
            obj.set_cssclass("sta_WF_Label02");
            obj.style.set_font("bold antialias 14 Droid Sans");
            obj.set_wordwrap("char");
            this.addChild(obj.name, obj);

            obj = new Static("sta_info14", "absolute", "13", "2460", "521", "59", null, null, this);
            obj.set_taborder("50");
            obj.set_text("갤러리에서 선택된 이미지를 이미지전송화면에 미리보기로 보여줍니다.");
            obj.set_cssclass("sta_WF_Label02");
            obj.style.set_font("bold antialias 14 Droid Sans");
            obj.set_wordwrap("char");
            this.addChild(obj.name, obj);

            obj = new Static("sta_info15", "absolute", "13", "2515", "521", "59", null, null, this);
            obj.set_taborder("51");
            obj.set_text("하단 다섯번째 버튼을 클릭하면 화면 로그아웃이 됩니다.");
            obj.set_cssclass("sta_WF_Label02");
            obj.style.set_font("bold antialias 14 Droid Sans");
            obj.set_wordwrap("char");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "ScreenPhone", 562, 1130, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frmExam_001");
            		p.set_titletext("이용안내");

            	}
            );
            obj.set_stepcount("");
            this.addLayout(obj.name, obj);


            
            // BindItem Information
            obj = new BindItem("item0","sta_box00","text","ds_list","massage");
            this.addChild(obj.name, obj);
            obj.bind();
            obj = new BindItem("item1","sta_box01","text","ds_list","massage");
            this.addChild(obj.name, obj);
            obj.bind();
            obj = new BindItem("item2","sta_box02","text","ds_list","massage");
            this.addChild(obj.name, obj);
            obj.bind();
            obj = new BindItem("item3","sta_box03","text","ds_list","massage");
            this.addChild(obj.name, obj);
            obj.bind();
            obj = new BindItem("item4","sta_box04","text","ds_list","massage");
            this.addChild(obj.name, obj);
            obj.bind();
            obj = new BindItem("item5","sta_box05","text","ds_list","massage");
            this.addChild(obj.name, obj);
            obj.bind();

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("UseInformation.xfdl", "lib::lib_Com.xjs");
        this.registerScript("UseInformation.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		추가발주
        // [부시스템명]	추가발주 - 조회
        // [설명]
        // 		부서 검색하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.02.04
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.04 : 강대성 : 수정이 필요하여 수정함.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/
        this.preDate = undefined;

        /*================================================================================
         * 2. Form관련 Script
         *===============================================================================*/
        /** 
         * Form의 모든 컴포넌트가 생성되고, 모든 Object가 Load 되었을 때에 발생하는 Event
         * @param
        	obj : Event가 발생한 Object
        	e : Event Object
         * @return : 없음
         */ 
        this.form_onload = function(obj,e)
        {
        	//필수
        	this.fn_init();
        }

        // 데이터 초기화
        this.fn_init = function ()
        {	
        	// 주변사업장보기 메뉴ID
        	application.gds_menu.filter("menuId == '2685'");
        		
        	// 주변사업장보기 메뉴 권한이 있는경우 해당 메뉴얼을 보여줌
        	if (application.gds_menu.getRowCount() == 1) {
        		this.sta_img08.set_visible(true);  //주변사업장보기화면 이미지
        		this.sta_info08.set_visible(true); //주변사업장보기화면 설명
        	}
        	else
        	{
        		this.sta_img08.set_visible(false);  //주변사업장보기화면 이미지
        		this.sta_info08.set_visible(false); //주변사업장보기화면 설명	
        	}
        	
        	application.gds_menu.filter("");
        	
        	// 이미지전송 메뉴ID
        	application.gds_menu.filter("menuId == '1818'");
        		
        	// 이미지전송 메뉴 권한이 있는경우 해당 메뉴얼을 보여줌
        	if (application.gds_menu.getRowCount() == 1) {
        		this.sta_img13.set_visible(true);  //이미지전송화면 이미지
        		this.sta_info13.set_visible(true); //이미지전송화면 설명
        		this.sta_img14.set_visible(true);  //이미지전송화면 이미지
        		this.sta_info14.set_visible(true); //이미지전송화면 설명
        	}
        	else
        	{
        		this.sta_img13.set_visible(false);  //이미지전송화면 이미지
        		this.sta_info13.set_visible(false); //이미지전송화면 설명	
        		this.sta_img14.set_visible(false);  //이미지전송화면 이미지
        		this.sta_info14.set_visible(false); //이미지전송화면 설명
        		
        		this.sta_img15.set_left(193);   //로그아웃화면 이미지 중간으로 이동
        		this.sta_info15.set_top(2402);  //로그아웃화면 설명 맨위로 이동
        		
        	}
        	
        	application.gds_menu.filter("");
        	
        	// 거래처정보 메뉴ID
        	application.gds_menu.filter("menuId == '1807'");
        		
        	// 거래처정보 메뉴 권한이 있는경우 해당 메뉴얼을 보여줌
        	if (application.gds_menu.getRowCount() == 1) {
        		this.sta_img09.set_visible(true);  //거래처정보화면 이미지
        		this.sta_info09.set_visible(true); //거래처정보화면 설명
        		this.sta_img10.set_visible(true);  //거래처정보화면 이미지
        		this.sta_info10.set_visible(true); //거래처정보화면 설명
        	}
        	else
        	{
        		this.sta_img09.set_visible(false);  //거래처정보화면 이미지
        		this.sta_info09.set_visible(false); //거래처정보화면 설명
        		this.sta_img10.set_visible(false);  //거래처정보화면 이미지
        		this.sta_info10.set_visible(false); //거래처정보화면 설명
        		
        		this.sta_img11.set_top(1295);   //거래처정보화면이 없을경우 아래 화면 위치조정
        		this.sta_info11.set_top(1556);  //거래처정보화면이 없을경우 아래 화면 위치조정
        		this.sta_img12.set_top(1295);   //거래처정보화면이 없을경우 아래 화면 위치조정
        		this.sta_info12.set_top(1630);  //거래처정보화면이 없을경우 아래 화면 위치조정
        		
        		this.sta_img13.set_top(1723);   //거래처정보화면이 없을경우 아래 화면 위치조정
        		this.sta_info13.set_top(1971);  //거래처정보화면이 없을경우 아래 화면 위치조정
        		this.sta_img14.set_top(1723);   //거래처정보화면이 없을경우 아래 화면 위치조정
        		this.sta_info14.set_top(2028);  //거래처정보화면이 없을경우 아래 화면 위치조정
        		this.sta_img15.set_top(1723);   //거래처정보화면이 없을경우 아래 화면 위치조정
        		this.sta_info15.set_top(2083);  //거래처정보화면이 없을경우 아래 화면 위치조정
        		
        		this.sta_box05.set_visible(false);
        	}
        	
        	application.gds_menu.filter("");	
        		
        }

        /*******************************************************************************
        * 기      능   : 조회
        * 설      명   : undefined
        ********************************************************************************/

        
        this.frmExam_001_onvscroll = function(obj,e)
        {
        	if (e.pos == 0)
        	{
        		this.parent.btnGoTop.set_visible(false);
        	}
        	else
        	{
        		this.parent.btnGoTop.set_visible(true);
        	}
        }

        this.frmExam_001_onslide = function(obj,e)
        {
        	if (e.yaccvalue > 0)
        	{
        		this.parent.parent.divBottom.set_visible(true);
        		this.parent.parent.divMain.set_height(833);
        		this.parent.parent.divBottom.bringToFront();
        	}
        	else if (e.yaccvalue < 0)
        	{
        		this.parent.parent.divBottom.set_visible(false);
        		this.parent.parent.divMain.set_height(923);
        	}
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.addEventHandler("onvscroll", this.frmExam_001_onvscroll, this);
            this.addEventHandler("onslide", this.frmExam_001_onslide, this);
            this.staTitleT03.addEventHandler("onclick", this.Static03_onclick, this);
            this.staTitleT00.addEventHandler("onclick", this.Static03_onclick, this);
            this.staTitleT04.addEventHandler("onclick", this.Static03_onclick, this);
            this.sta_box00.addEventHandler("onclick", this.Static00_onclick, this);
            this.sta_box01.addEventHandler("onclick", this.Static00_onclick, this);
            this.sta_box02.addEventHandler("onclick", this.Static00_onclick, this);
            this.sta_box03.addEventHandler("onclick", this.Static00_onclick, this);
            this.sta_box04.addEventHandler("onclick", this.Static00_onclick, this);
            this.sta_box05.addEventHandler("onclick", this.Static00_onclick, this);

        };

        this.loadIncludeScript("UseInformation.xfdl", true);

       
    };
}
)();
