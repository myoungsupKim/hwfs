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
                this.set_titletext("이미지전송");
                this._setFormPosition(0,0,540,760);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_gubunCd", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"256\"/><Column id=\"cdNm\" type=\"STRING\" size=\"256\"/><Column id=\"set1\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_fileList", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"refSeq\" type=\"STRING\" size=\"256\"/><Column id=\"upjang\" type=\"STRING\" size=\"256\"/><Column id=\"rgstDate\" type=\"STRING\" size=\"256\"/><Column id=\"gubun\" type=\"STRING\" size=\"256\"/><Column id=\"subDir\" type=\"STRING\" size=\"256\"/><Column id=\"orgnlFileNm\" type=\"STRING\" size=\"256\"/><Column id=\"saveFileNm\" type=\"STRING\" size=\"256\"/><Column id=\"relPath\" type=\"STRING\" size=\"256\"/><Column id=\"fileSize\" type=\"STRING\" size=\"256\"/><Column id=\"bigo\" type=\"STRING\" size=\"256\"/><Column id=\"cuser\" type=\"STRING\" size=\"256\"/><Column id=\"cdate\" type=\"STRING\" size=\"256\"/><Column id=\"uuser\" type=\"STRING\" size=\"256\"/><Column id=\"udate\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_cameraList", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"refSeq\" type=\"STRING\" size=\"256\"/><Column id=\"upjang\" type=\"STRING\" size=\"256\"/><Column id=\"rgstDate\" type=\"STRING\" size=\"256\"/><Column id=\"gubun\" type=\"STRING\" size=\"256\"/><Column id=\"orgnlFileNm\" type=\"STRING\" size=\"256\"/><Column id=\"saveFileNm\" type=\"STRING\" size=\"256\"/><Column id=\"relPath\" type=\"STRING\" size=\"256\"/><Column id=\"fileSize\" type=\"STRING\" size=\"256\"/><Column id=\"bigo\" type=\"STRING\" size=\"256\"/><Column id=\"cuser\" type=\"STRING\" size=\"256\"/><Column id=\"cdate\" type=\"STRING\" size=\"256\"/><Column id=\"uuser\" type=\"STRING\" size=\"256\"/><Column id=\"udate\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_galleryList", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"refSeq\" type=\"STRING\" size=\"256\"/><Column id=\"upjang\" type=\"STRING\" size=\"256\"/><Column id=\"rgstDate\" type=\"STRING\" size=\"256\"/><Column id=\"gubun\" type=\"STRING\" size=\"256\"/><Column id=\"orgnlFileNm\" type=\"STRING\" size=\"256\"/><Column id=\"saveFileNm\" type=\"STRING\" size=\"256\"/><Column id=\"relPath\" type=\"STRING\" size=\"256\"/><Column id=\"fileSize\" type=\"STRING\" size=\"256\"/><Column id=\"bigo\" type=\"STRING\" size=\"256\"/><Column id=\"cuser\" type=\"STRING\" size=\"256\"/><Column id=\"cdate\" type=\"STRING\" size=\"256\"/><Column id=\"uuser\" type=\"STRING\" size=\"256\"/><Column id=\"udate\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("Static04", "absolute", "0", "0", null, "2", "0", null, this);
            obj.set_taborder("0");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "177", "540", "10", null, null, this);
            obj.set_taborder("1");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static14", "absolute", "0", "2", null, "59", "0", null, this);
            obj.set_taborder("2");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "60", null, "59", "0", null, this);
            obj.set_taborder("3");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static25", "absolute", "0", "60", "135", "59", null, null, this);
            obj.set_taborder("4");
            obj.set_text("사업장");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "0", "118", null, "59", "0", null, this);
            obj.set_taborder("6");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_dtFrom", "absolute", "139", "8", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("8");
            obj.set_dateformat("yyyy-MM-dd");
            obj.set_value("null");

            obj = new Static("Static01", "absolute", "0", "2", "135", "59", null, null, this);
            obj.set_taborder("10");
            obj.set_text("업무일자");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "119", "23", "20", "69", null, null, this);
            obj.set_taborder("11");
            obj.set_text("글자사이간격w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_upjang", "absolute", "139", "66", null, "47", "10", null, this);
            obj.set_taborder("12");
            obj.set_displaynulltext("거래처명을 입력");
            obj.set_enable("false");
            this.addChild(obj.name, obj);

            obj = new Button("btn_upjang", "absolute", null, "66", "47", "47", "10", null, this);
            obj.set_taborder("13");
            obj.set_cssclass("btn_WF_EdtSearch");
            obj.set_enable("false");
            this.addChild(obj.name, obj);

            obj = new Button("btn_camera", "absolute", null, "187", "117", "47", "361", null, this);
            obj.set_taborder("14");
            obj.set_text("사진찍기");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Button("btn_imageUpLoad", "absolute", null, "187", "169", "47", "10", null, this);
            obj.set_taborder("15");
            obj.set_text("이미지업로드");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new ImageViewer("img_camera00", "absolute", "9", "243", null, null, "361", "328", this);
            obj.set_taborder("16");
            obj.style.set_background("#ffffffff URL('theme://Image/img_WF_NoImage.png') center middle");
            obj.style.set_font("bold antialias 10 Droid Sans");
            obj.set_stretch("fixaspectratio");
            obj.set_image("URL('../../../../../Users/PC1/Pictures/icon_120.png')");
            obj.set_text("iOS thumnail 미지원");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Combo("cbo_rgstGubun", "absolute", "10", "124", null, "47", "10", null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("17");
            obj.set_text("등록구분을 선택하세요");
            obj.set_displaynulltext("등록구분을 선택하세요");
            obj.set_innerdataset("@ds_gubunCd");
            obj.set_codecolumn("cd");
            obj.set_datacolumn("cdNm");

            obj = new Static("Static03", "absolute", "184", "234", "356", "10", null, null, this);
            obj.set_taborder("18");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "356", "201", "5", "19", null, null, this);
            obj.set_taborder("19");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "244", "10", "343", null, null, this);
            obj.set_taborder("20");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "530", "187", "10", "400", null, null, this);
            obj.set_taborder("21");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "179", "186", "10", "400", null, null, this);
            obj.set_taborder("23");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new ImageViewer("ivFPhoto00", "absolute", "189", "497", null, null, "240", "139", this);
            obj.set_taborder("25");
            obj.style.set_background("#ffffffff URL('theme://Image/img_WF_NoImage.png') center middle");
            obj.style.set_font("bold antialias 7 Droid Sans");
            obj.set_visible("false");
            obj.set_stretch("fixaspectratio");
            obj.set_text("iOS thumnail 미지원");
            this.addChild(obj.name, obj);

            obj = new ImageViewer("ivFPhoto01", "absolute", "304", "497", null, null, "125", "139", this);
            obj.set_taborder("26");
            obj.style.set_background("#ffffffff URL('theme://Image/img_WF_NoImage.png') center middle");
            obj.style.set_font("bold antialias 7 Droid Sans");
            obj.set_visible("false");
            obj.set_stretch("fixaspectratio");
            obj.set_text("iOS thumnail 미지원");
            this.addChild(obj.name, obj);

            obj = new ImageViewer("ivFPhoto02", "absolute", "419", "497", null, null, "10", "139", this);
            obj.set_taborder("27");
            obj.style.set_background("#ffffffff URL('theme://Image/img_WF_NoImage.png') center middle");
            obj.style.set_font("bold antialias 7 Droid Sans");
            obj.set_visible("false");
            obj.set_stretch("fixaspectratio");
            obj.set_text("iOS thumnail 미지원");
            this.addChild(obj.name, obj);

            obj = new ImageViewer("ivFPhoto03", "absolute", "189", "627", null, null, "240", "9", this);
            obj.set_taborder("28");
            obj.style.set_background("#ffffffff URL('theme://Image/img_WF_NoImage.png') center middle");
            obj.style.set_font("bold antialias 7 Droid Sans");
            obj.set_stretch("fixaspectratio");
            obj.set_visible("false");
            obj.set_text("iOS thumnail 미지원");
            this.addChild(obj.name, obj);

            obj = new ImageViewer("ivFPhoto04", "absolute", "304", "627", null, null, "125", "9", this);
            obj.set_taborder("29");
            obj.style.set_background("#ffffffff URL('theme://Image/img_WF_NoImage.png') center middle");
            obj.style.set_font("bold antialias 7 Droid Sans");
            obj.set_stretch("fixaspectratio");
            obj.set_visible("false");
            obj.set_text("iOS thumnail 미지원");
            this.addChild(obj.name, obj);

            obj = new ImageViewer("ivFPhoto05", "absolute", "419", "627", null, null, "10", "9", this);
            obj.set_taborder("30");
            obj.style.set_background("#ffffffff URL('theme://Image/img_WF_NoImage.png') center middle");
            obj.style.set_font("bold antialias 7 Droid Sans");
            obj.set_visible("false");
            obj.set_stretch("fixaspectratio");
            obj.set_text("iOS thumnail 미지원");
            this.addChild(obj.name, obj);

            obj = new Button("btn_allNew", "absolute", null, "187", "117", "47", "184", null, this);
            obj.set_taborder("34");
            obj.set_text("전체신규");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Static("Static61", "absolute", "9", "427", "172", "127", null, null, this);
            obj.set_taborder("35");
            obj.set_text("※ 이미지 업로드시 데이터 요금이 과다 발생할 수 있으니 전용 요금제나 무선랜(WI-FI)을 권장합니다.");
            obj.set_cssclass("sta_GUIDE_RedText");
            obj.set_visible("true");
            obj.style.set_linespace("3");
            obj.style.set_align("left middle");
            obj.style.set_font("bold 12 arial");
            obj.set_wordwrap("char");
            this.addChild(obj.name, obj);

            obj = new Static("Static10", "absolute", "9", "555", "165", "83", null, null, this);
            obj.set_taborder("36");
            obj.set_text("※ 사진은 4장, 앨범은 최대 6장까지 등록 할 수 있습니다.(최대5MB = 5242880B)");
            obj.set_cssclass("sta_GUIDE_RedText");
            obj.set_visible("true");
            obj.style.set_linespace("3");
            obj.style.set_font("bold 12 arial");
            obj.set_wordwrap("char");
            this.addChild(obj.name, obj);

            obj = new Static("Static11", "absolute", "9", "627", "172", "103", null, null, this);
            obj.set_taborder("37");
            obj.set_text("※ 사진찍기시 카메랑 앱은 전용 앱으로 설정해 주기시 바랍니다.");
            obj.set_cssclass("sta_GUIDE_RedText");
            obj.set_visible("true");
            obj.style.set_linespace("3");
            obj.style.set_align("left middle");
            obj.style.set_font("bold 12 arial");
            obj.set_wordwrap("char");
            this.addChild(obj.name, obj);

            obj = new ImageViewer("img_camera01", "absolute", "189", "308", null, null, "240", "328", this);
            obj.set_taborder("38");
            obj.set_stretch("fixaspectratio");
            obj.set_visible("false");
            obj.style.set_background("#ffffffff URL('theme://Image/img_WF_NoImage.png') center middle");
            obj.style.set_font("bold antialias 7 Droid Sans");
            obj.set_text("iOS thumnail 미지원");
            this.addChild(obj.name, obj);

            obj = new ImageViewer("img_camera02", "absolute", "304", "308", null, null, "125", "328", this);
            obj.set_taborder("39");
            obj.set_stretch("fixaspectratio");
            obj.set_visible("false");
            obj.style.set_background("#ffffffff URL('theme://Image/img_WF_NoImage.png') center middle");
            obj.style.set_font("bold antialias 7 Droid Sans");
            obj.set_text("iOS thumnail 미지원");
            this.addChild(obj.name, obj);

            obj = new ImageViewer("img_camera03", "absolute", "419", "308", null, null, "10", "328", this);
            obj.set_taborder("40");
            obj.set_stretch("fixaspectratio");
            obj.set_visible("false");
            obj.style.set_background("#ffffffff URL('theme://Image/img_WF_NoImage.png') center middle");
            obj.style.set_font("bold antialias 7 Droid Sans");
            obj.set_text("iOS thumnail 미지원");
            this.addChild(obj.name, obj);

            obj = new Static("Static16", "absolute", "189", "244", null, "59", "11", null, this);
            obj.set_taborder("43");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static12", "absolute", "189", "244", "226", "59", null, null, this);
            obj.set_taborder("44");
            obj.set_text("사진찍은 사진");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "190", "435", null, "59", "10", null, this);
            obj.set_taborder("45");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static17", "absolute", "189", "436", "226", "58", null, null, this);
            obj.set_taborder("46");
            obj.set_text("앨범 사진");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Button("btn_gallery", "absolute", null, "441", "65", "47", "10", null, this);
            obj.set_taborder("47");
            obj.set_text("앨범");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Button("btn_cameraNew", "absolute", null, "250", "117", "47", "10", null, this);
            obj.set_taborder("48");
            obj.set_text("사진신규");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Button("btn_galleryNew", "absolute", null, "441", "117", "47", "81", null, this);
            obj.set_taborder("49");
            obj.set_text("앨범신규");
            obj.set_cssclass("btn_WF_Function");
            this.addChild(obj.name, obj);

            obj = new Static("sta_dtFrom", "absolute", "139", "8", "195", "47", null, null, this);
            obj.set_taborder("50");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_totalFileSize", "absolute", "11", "714", "172", "37", null, null, this);
            obj.set_taborder("51");
            obj.set_enable("false");
            obj.style.setStyleValue("align", "disabled", "right middle");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("이미지전송");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("PhotoImageReqt.xfdl", "lib::lib_Com.xjs");
        this.registerScript("PhotoImageReqt.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		이미지 전송
        // [부시스템명]	이미지 전송 - 이미지 업로드
        // [설명]
        // 		이미지 전송 - 이미지 업로드
        // [작성자명] 		강대성
        // [작성일자]		2015.02.04
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.04 : 강대성 : 수정이 필요하여 수정함.
        // 2015.09.26 : 강대성 : 최종 수정.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"
        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/
        this.F_sLocalFileName;				// 파일url
        this.F_iFileLimitSize = 5242880;	// 업로드 파일 용량 제한 (5MB)
        this.F_totalFileSize = 0;     		// 총 파일 사이즈
        this.F_cameraFileSize = 0;    		// 카메라앱 연동 사진찍을시 파일 사이즈
        this.F_galleryFileSize = 0;   		// 앨범 연동 사진가져올경우 파일 사이즈
        this.F_cameraGubun = "N";    		// 카메라앱 호출 시 구분값
        this.F_galleryGubun = "N";    		// 앨범 연동 호출 시 구분값
        this.preDate = undefined;     		// 현재 날짜 
        this.upjang = undefined;      		// 업장
        this.sabun = undefined;       		// 사번
        this.gubun = undefined;       		// 저장시 등록구분
        this.upjangGubun = undefined; 		// 거래처(협력업체)업장 구분시

        // 모바일런타임deviceAPI용
        this.fspmob;
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
        	this.fn_comboMenuAuth();
        	
        	// 필수(모바일런타임 DeviceAPI사용
        	this.fspmob = new nexacro.FSPMobile();
        	this.fspmob.addEventHandler("onsuccess", this.on_success, this);
        	this.fspmob.addEventHandler("onerror", this.on_error, this);

        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정(이미지업로드)
        	this.fn_SetBtnControl("","this.btn_imageUpLoad");	
        	
        	// 권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetAuth("this.edt_upjang", "this.btn_upjang");	
        	
        	this.edt_upjang.set_value(application.g_UpjangNm);	
        	this.upjang = application.g_Upjang;
        	this.sabun = application.g_EmpNo;
        	
        	this.preDate = this.gfn_Today();
        	this.cal_dtFrom.set_value(this.preDate);	
        	
        	//이미지등록 업무구분
        	this.fn_common_code("MS001", "", "", "IMAGE");	
        	this.ds_gubunCd.copyData(application.gds_common_code);
        	
        	if(this.edt_upjang.value == ""){
        		this.btn_upjang_onclick();
        	}
        	
        	//this.edt_upjang.set_enable(false);			
        	//this.btn_upjang.set_enable(false);
        	
        	//필수
        	this.fn_init();
        }

        // 데이터 초기화(신규버튼 클릭시)
        this.fn_init = function ()
        {
        	this.F_totalFileSize = 0;
        	this.F_cameraFileSize = 0;
        	this.F_galleryFileSize = 0;
        	this.edt_totalFileSize.set_value(this.F_totalFileSize); 
        	this.ds_fileList.clearData();
        	this.ds_cameraList.clearData();
        	this.ds_galleryList.clearData();
        	
        	this.img_camera00.set_image("");
        	this.img_camera01.set_image("");
        	this.img_camera02.set_image("");
        	this.img_camera03.set_image("");
        	this.ivFPhoto00.set_image("");
        	this.ivFPhoto01.set_image("");
        	this.ivFPhoto02.set_image("");
        	this.ivFPhoto03.set_image("");
        	this.ivFPhoto04.set_image("");
        	this.ivFPhoto05.set_image("");	
        	
        	this.img_camera01.set_visible(false);
        	this.img_camera02.set_visible(false);
        	this.img_camera03.set_visible(false);
        	this.ivFPhoto00.set_visible(false);
        	this.ivFPhoto01.set_visible(false);
        	this.ivFPhoto02.set_visible(false);
        	this.ivFPhoto03.set_visible(false);
        	this.ivFPhoto04.set_visible(false);
        	this.ivFPhoto05.set_visible(false);
        	
        }

        //사진신규클릭시
        this.fn_cameraInit = function ()
        {	
        	if(this.ds_cameraList.getRowCount() > 0)
        	{
        		this.F_totalFileSize = nexacro.toNumber(this.F_totalFileSize) - nexacro.toNumber(this.F_cameraFileSize)
        		this.edt_totalFileSize.set_value(this.F_totalFileSize); 
        	}
        	this.F_cameraFileSize = 0;
        	this.F_cameraGubun = "N";
        	this.ds_cameraList.clearData();
        	
        	this.img_camera00.set_image("");
        	this.img_camera01.set_image("");
        	this.img_camera02.set_image("");
        	this.img_camera03.set_image("");
        	
        	this.img_camera01.set_visible(false);
        	this.img_camera02.set_visible(false);
        	this.img_camera03.set_visible(false);	
        	
        }

        //앨범 버튼 클릭시 기존 호출된 앨범 정보 초기화
        this.fn_galleryInit = function ()
        {		
        	if(this.ds_galleryList.getRowCount() > 0)
        	{
        		this.F_totalFileSize = nexacro.toNumber(this.F_totalFileSize) - nexacro.toNumber(this.F_galleryFileSize)
        		this.edt_totalFileSize.set_value(this.F_totalFileSize); 
        	}
        	this.F_galleryFileSize = 0;
        	this.F_galleryGubun = "N";
        	this.ds_galleryList.clearData();
        	
        	this.ivFPhoto00.set_image("");
        	this.ivFPhoto01.set_image("");
        	this.ivFPhoto02.set_image("");
        	this.ivFPhoto03.set_image("");
        	this.ivFPhoto04.set_image("");
        	this.ivFPhoto05.set_image("");
        	
        	this.ivFPhoto00.set_visible(false);
        	this.ivFPhoto01.set_visible(false);
        	this.ivFPhoto02.set_visible(false);
        	this.ivFPhoto03.set_visible(false);
        	this.ivFPhoto04.set_visible(false);
        	this.ivFPhoto05.set_visible(false);	
        }

        /** 
         * 신규 버튼튼클릭
         * @param  
        	obj, e
         * @return : 없음
         */
        this.btnImgClose_onclick = function(obj,e)
        {
        	switch(obj.name)
        	{
        		case "btn_allNew":
        			this.fn_init();	
        			break;
        		case "btn_cameraNew":
        			this.fn_cameraInit();	
        			break;
        		case "btn_galleryNew":
        			this.fn_galleryInit();	
        			break;
        		default:
        			break;
        	}	
        }

        // 달력 클릭 시(From)
        this.sta_dtFrom_onclick = function(obj,e)
        {
        	var objCalArg = this.cal_dtFrom.value;
        	
        	application.goMain.gfn_POP_create("PopCalFrom", "cmmn::CmmnCalendarPop.xfdl", "fn_callbackPOP", this, objCalArg, "POP", application.goMain.divBase);
        	return false;
        }

        /** 
         * 사업장 검색 팝업 호출
         */
        this.btn_upjang_onclick = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.edt_upjang.value;
        	if(this.upjangGubun == "CUST")
        	{
        		arg[2] = this.upjangGubun;
        	}
        	else if(application.g_Mu_Cd == "2004")
        	{
        		arg[2] = "FMS";
        	}
        	else
        	{
        		var arg = new Array();
        		
        		if(this.fn_masterRole())
        		{
        			arg[4] = application.g_RoleSetId1;
        			arg[9] = "exception";
        			arg[10] = "AND A.MU_CD NOT IN ('2004')";
        			arg[11] = application.g_UpjangFlag1;
        			arg[12] = application.g_UpjangFlag2;
        		}
        		else
        		{
        			arg[4] = application.g_RoleSetId2;
        			arg[5] = application.g_AuthLevel;
        			arg[6] = application.g_EmpNo;
        			if(application.g_useTmCd == "Y")
        			{
        				arg[7] = application.g_Tm_Cd;
        			}
        			arg[8] = application.g_Mu_Cd;
        			arg[9] = application.g_UpjangGubun;
        			arg[11] = application.g_UpjangFlag1;
        			arg[12] = application.g_UpjangFlag2;
        		}	
        	}
        	
        	application.goMain.gfn_POP_create("upjangNm", "M_MLM::WorkplaceSearchPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        //조회조건 콤보 팝업창 호출
        this.cbo_rgstGubun_ondropdown = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_gubunCd;
        	arg[1] = "조회조건(등록구분)";
        	arg[2] = "";
        	arg[3] = "cdNm";
        	application.goMain.gfn_POP_create("rgstGubun", "cmmn::CmmnComboList.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        /*================================================================================
         * 3. camera관련
         *===============================================================================*/
        /** 
         * 카메라버튼클릭
         * @param  
        	obj, e
         * @return : 없음
         */
        this.btnCamera_onclick = function(obj,e)
        {
        	// 이미지 정보를 읽어온다. 
        	// 자세한 내용은 https://softzam.atlassian.net/wiki/pages/viewpage.action?pageId=2162885 사이트 참고 
        	var options = {
        		returnType : "F"	// 파일 리턴 유형 F- 파일 / D - byte[]에 대한 문자열 
        		, targetWidth : 700		// 리턴받을 넓이
        		, targetHeight : 0	// 리턴받을 높이  
        //		, fileName : "test.jpg"	// 파일명
        		, quality : 70 	// 이미지 품질 ( 0 ~ 100 )
        		, deleteFile : "N" 	// 실제 찍힌 사진 ( 카메라 폴더 )에  저장된 파일 삭제 여부 -> 파일명 지정시 "Y"로 설정 
        	};

        	// 모바일런타임 작업 - 20150708 김광호
        	// this.fspmob_getPicture(this, options, "fsp_callbackCamera");
        	this.fspmob.getPicture(options);
        }

        /**
        *	현재 로컬 파일의 사이즈를 가져온다. 
        **/
        this.fn_getFileSize = function(sFileName)
        {
        	// 모바일런타임 전환작업 - 20150708 김광호
        	this.fspmob.getFileSize(sFileName);
        }

        /**
        *	현재 앨범의 사이즈를 가져온다. 
        **/
        this.fn_getGallerySize = function(sFileName)
        {
        	// 모바일런타임 전환작업 - 20150708 김광호
        	this.fspmob.getFileSize(sFileName);
        }

        /** 
         * 앨범(+)버튼클릭
         * @param  
        	obj, e
         * @return : 없음
         */
        this.btnPicture_onclick = function(obj,e)
        {
        	// 이미지 정보를 읽어온다. 
        	// 자세한 내용은 https://softzam.atlassian.net/wiki/pages/viewpage.action?pageId=2162885 사이트 참고 
        	var options = {
        		returnType : "F"	// 파일 리턴 유형 F- 파일 / D - byte[]에 대한 문자열 
        		, targetWidth : 700		// 리턴받을 넓이
        		, targetHeight : 0	// 리턴받을 높이  
        		, quality : 50 	// 이미지 품질 ( 0 ~ 100 )
        		, crop : "YES"
        		, cropWidth : 360
        		, cropHeight : 458
        		, resizeFile : "Y"
        	};

        	// 모바일런타임 전환작업 - 20150708 김광호
        	//this.fspmob_getPictureFromAlbum(this, options, "fsp_callbackAlbum");	
        	this.fspmob.getPictureFromAlbum(options);	
        }

        /*******************************************************************************
        * 기      능   :  이미지 업로드 버튼 클릭시
        * 설      명   :  이미지 업로드
        ********************************************************************************/
        this.btn_imageUpLoad_onclick = function(obj,e)
        {
        	application.goMain.gfn_Msg("fileUpload", "업로드", "사진을 업로드 하시겠습니까?", "YN", true, this);	
        }

        this.fn_FileUpload = function()
        {	
        	// v_ds_check 미사용시 변경사항 체크
          	if (this.gfn_getUpdate(this.ds_cameraList) == false && this.gfn_getUpdate(this.ds_galleryList) == false) 
          	{
          		application.goMain.gfn_Msg("ALERT_0", "알림", "업로드 할 이미지가 없습니다.", "OK", true, this);
          		return;
          	}

        	//저장 체크
         	if (this.fn_SaveCheck()) return;
        	
        	// 파일을 업로드할 주소 
        	var svcUrl = application.services["svc"].url + "FileUploaderMobile?mode=upload";
        	
        	var gubun = this.ds_gubunCd.getColumn(this.gubun, "cd");
        	
        	/* 01:CS진단관리(개선), 02:CS진단관리(점검), 03:위생점검관리(개선), 04:위생점검관리(점검), 05:협력업체위생관리(점검)
        	   06:이벤트, 07:클레임, 08:LIMS, 09:안전점검관리(개선), 10:안전점검관리(점검) */
        	if(!this.gfn_isNull(gubun))
        	{
        		gubun = this.ds_gubunCd.getColumn(this.gubun, "set1");
        	}
        	else
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "등록구분을 선택하세요.", "OK", true, this);
        		return;
        	}
        	
        	if(this.gfn_isNull(this.edt_upjang.value))
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "업장을 입력하세요.", "OK", true, this);
        		return;
        	}
        	
          	var jsonArgs = {
          		subDir : ""
          	};

        
        	
        	var localFileName = "";
        	var saveFileName = "";
        	var nRow;
        	
        	for(var i=0;i<this.ds_cameraList.getRowCount();i++){
        	
        		nRow = this.ds_fileList.addRow();
        			
        		this.ds_fileList.setColumn(nRow, "orgnlFileNm", this.ds_cameraList.getColumn(i, "orgnlFileNm"));
        		this.ds_fileList.setColumn(nRow, "bigo", "CAMERA");
        	}

        	for(var j=0;j<this.ds_galleryList.getRowCount();j++){
        	
        		nRow = this.ds_fileList.addRow();
        			
        		this.ds_fileList.setColumn(nRow, "orgnlFileNm", this.ds_galleryList.getColumn(j, "orgnlFileNm"));
        		this.ds_fileList.setColumn(nRow, "bigo", "GALLERY");
        		
        	}	
        	
        	//alert(this.ds_fileList.saveXML("ds_fileList", "V"));
        	
        	for(var k=0;k<this.ds_fileList.getRowCount();k++){
        		if(k>0) {
        			localFileName += ",";
        			saveFileName += ",";
        		}
        		localFileName += this.ds_fileList.getColumn(k,"orgnlFileNm");
        		saveFileName += gubun+"_"+this.sabun+"_"+k+".jpg";
        	}	
        	
        	// 파일 업로드를 호출하여 처리한다. 
        	// 모바일런타임 전환작업 - 20150708 김광호
        	this.fspmob.fileUpload(svcUrl, localFileName, saveFileName, jsonArgs, "", false);	//svcUrl, localFileName, saveFileName, jsonArgs, mimeType, trustAllHost
        	

        }

        /*******************************************************************************
        * 기      능   :  등록정보 DB에 저장
        * 설      명   :  등록정보 DB에 저장
        ********************************************************************************/
        this.fn_save = function()
        {
        	//alert(this.ds_fileList.saveXML("ds_fileList", "V"));
        	
        	var strSvcID   		 = "save";
        	var strUrl     		 = "ms/mpm/photoImageReqt/saveList.xdo";
        	var strInDataset     = "ds_list=ds_fileList:U";
        	var strOutDataset    = "ds_fileList=ds_list";
        	var strArguments	 = "";
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
          	// connect the server 
        }

        /*******************************************************************************
        * 기      능   :  이미지 업로드 전 체크
        * 설      명   :  이미지 업로드 전 체크
        ********************************************************************************/
        this.fn_SaveCheck = function ()
        {
        	if ( this.gfn_isNull(this.gubun))
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "등록구분을 선택해주세요", "OK", true, this);
        		return true;
        	}			
        		
        	//총 파일사이즈값이 10485760값 초과시 메세지 띄움
        	if(this.F_totalFileSize > this.F_iFileLimitSize)
        	{
        		application.goMain.gfn_Msg("ALERT_0", "메세지", "파일용량이 5MB를 초과하였습니다.", "OK", true, this);	
        		return true;
        	}		
        	
        	return false;
        }

        /*================================================================================
         * 5. UserFunction관련 Script
         *===============================================================================*/
        /*----------------------------------------------------------------------------------------------
         * 설명      : 트랜잭션 콜백 함수 (필수)
         *---------------------------------------------------------------------------------------------*/
        this.fn_callBack = function (strSvcID,nErrorCode,strErrorMsg)
        {	
        	
        	// 에러시 gfn_callBack에서 메시지 제공, 화면별 특정 에러 발생시에만 사용하세요.
        	if (nErrorCode < 0) 
        	{
        		return;
        	}
        	
            switch(strSvcID)
            {		
        		// 정상적으로 이미지 전송후 전송내역 등록 처리시.	
          		case "save" :
        			application.goMain.gfn_Msg("ALERT_0", "알림", "이미지 업로드 성공하였습니다.", "OK", true, this);
        			this.ds_fileList.clearData();
        			break;	
            }   
            
        }

        /** 
         * 팝업 callBack
         * @param  : popname - 팝업을 구분짓는 id
         rtn : 팝업이 닫히면서 전달된 값
         * @return : 없음
         */
        this.fn_callbackPOP = function (popname,rtn)
        {
        	switch (popname)
        	{
        		case "PopCalFrom":
        			this.cal_dtFrom.set_value(rtn);
        			break;
        		case "upjangNm":
        			this.edt_upjang.set_value(rtn[1]);
        			this.upjang = rtn[0];
        			break;	
        		case "rgstGubun":
        			this.cbo_rgstGubun.set_index(rtn);
        			this.gubun = rtn;
        			
        			if(this.ds_gubunCd.getColumn(this.gubun, "cd") == "05") //협력업체위생관리(점검)
        			{
        				this.upjangGubun = "CUST";
        				
        				this.edt_upjang.set_value(application.g_UpjangNm);
        				this.upjang = application.g_Upjang;
        			}
        			else
        			{
        				this.upjangGubun = "";
        			}
        			
        			break;	
        	}
        }

        /** Message callback 함수
         * @param
        	id : id
        	rtn : type이 "OK" 일 때는 none
        	type이 "YN" 일 때는 "Y" or "N"
         * @return : 없음
         * @note : Alert 이나 Confirm 메시지의 콜백 함수
         *         gfn_Msg(...) 함수를 사용하여 띄운 창을 닫을 때 호출된다.
         */
        this.msg_callback = function (id,rtn)
        {
        	if (id == "ALERT_0") // 조회 시 오류
        	{
        		// 아무 일도 안함.
        	}
        	
        	if (id == "fileUpload") // 이미지 업로드 버튼 선택시
        	{
        		if(rtn == "Y"){
        			this.fn_FileUpload();
        		}else if(rtn == "N"){
        			return;
        		}
        	}		
        }

        
        // 모바일런타임 전환으로 추가   20150707  김광호
        /** fsp callback 함수 (fsp_callbackCamera)
         * @param
        	errorCode : errorCode
        	message : message
         * @return : 없음
         * @note : fsb 서비스 호출 후 콜백 함수
         * errorCode < 0 경우 해당 message 팝업 처리함
         */
        this.on_success = function(obj,e)
        {
        	if (e.reason == 42)	// getPicture
        	{
        		// 카메라 앱 연동시 카메라앱호출구분 Y, 앨범호출구분 N으로 값 변경
        		this.F_cameraGubun = "Y";
        		this.F_galleryGubun = "N";
        		// 파일명 저장
        		this.F_sLocalFileName = e.returnvalue;	// message;
        		
        		this.fn_getFileSize(this.F_sLocalFileName);
        		
        		var nRow = this.ds_cameraList.addRow();
        		    
        		this.ds_cameraList.setColumn(nRow, "orgnlFileNm", e.returnvalue);	// message);		
        	}
        	else if (e.reason == 35)	// fileUpload
        	{
        			var data = e.returnvalue.data;
        			var max = this.ds_fileList.rowcount;
        			
        			for (var i = 0; i < max; i++) 
        			{	
        				this.ds_fileList.setColumn(i, "upjang", this.upjang);
        				this.ds_fileList.setColumn(i, "rgstDate", this.cal_dtFrom.value);
        				this.ds_fileList.setColumn(i, "gubun", this.ds_gubunCd.getColumn(this.gubun, "cd"));
        				this.ds_fileList.setColumn(i, "subDir", this.ds_gubunCd.getColumn(this.gubun, "set1"));
        				this.ds_fileList.setColumn(i, "saveFileNm", data.ds_file[i].FILE_NAME);
        				this.ds_fileList.setColumn(i, "fileSize", data.ds_file[i].FILE_SIZE);		
        			}
        			
        			//이미지 정보를 DB에 저장 처리한다.
        			this.fn_save();	
        			return;
        	}
        	else if (e.reason == 37)	// getFileSize
        	{
        		
        		var filesize = nexacro.toNumber(e.returnvalue);
        		
        		//앨범호출시 사이즈값 저장
        		if(this.F_galleryGubun == "Y")
        		{
        			this.F_galleryFileSize =  nexacro.toNumber(this.F_galleryFileSize) + nexacro.toNumber(filesize);
        		}
        		
        		//카메라앱호출구분 Y일 경우 
        		if(this.F_cameraGubun == "Y")
        		{
        			var ivImageComp;
        		
        			var maxCnt = this.ds_cameraList.rowcount;
        			
        			var i = 0;
        			
        			if(this.ds_cameraList.getRowCount() > 4)
        			{
        				application.goMain.gfn_Msg("ALERT_0", "알림", "사진찍기는 4장까지 가능합니다.", "OK", true, this);
        				this.ds_cameraList.deleteRow(4);
        				return;
        			}			
        			
        			var pathTemp = "";
        			
        			for (i; i < this.ds_cameraList.getRowCount(); i++)
        			{		
        				var k = nexacro.toNumber(maxCnt) - nexacro.toNumber(1) - nexacro.toNumber(i);
        				ivImageComp = this.components["img_camera0"+k ];
        				ivImageComp.set_visible(true);
        				
        				pathTemp = this.ds_cameraList.getColumn(i, "orgnlFileNm");

        				ivImageComp.set_image("");
        				ivImageComp.set_image( pathTemp );
        				
        				//카메라호출시 사이즈값 저장
        				if(this.F_cameraGubun == "Y")
        				{
        					this.F_cameraFileSize =  nexacro.toNumber(this.F_cameraFileSize) + nexacro.toNumber(filesize);
        					this.F_cameraGubun = "N";
        				}
        				
        			}
        		}
        		
        		//사진찍기 파일사이즈를 담는다
        		this.F_totalFileSize = nexacro.toNumber(this.F_cameraFileSize) + nexacro.toNumber(this.F_galleryFileSize);
        		
        		//총 파일사이즈값을 화면에 표시
        		this.edt_totalFileSize.set_value(this.F_totalFileSize);	
        		this.img_camera00.set_visible(true);	
        		//총 파일사이즈값이 5242880값 초과시 메세지 띄움
        		if(this.F_totalFileSize > this.F_iFileLimitSize)
        		{
        			application.goMain.gfn_Msg("ALERT_0", "메세지", "파일용량이 5MB를 초과하였습니다.", "OK", true, this);	
        			return false;
        		}		

        	}
        	else if (e.reason == 43)   //getPictureFromAlbum
        	{
        		// 이미지 뿌려주기
        		var ivImageComp;
        				
        		var i = this.ds_galleryList.getRowCount();
        		var k = this.ds_galleryList.getRowCount();
        		
        		var res = e.returnvalue;
        		var totalLengthI = i + res.length;
        		var totalLengthK = k + res.length;
        		
        		for (i; i < totalLengthI; i++)
        		{			
        			if (i > 5)
        			{
        				application.goMain.gfn_Msg("ALERT_0", "알림", "이미지는 6장까지만 선택가능합니다.", "OK", true, this);
        				return;
        			}		 
        		}
        		
        		var j = 0;
        		var pathTemp = "";
        		
        		
        		for (k; k < totalLengthK; k++)
        		{
        			this.F_cameraGubun = "N";
        			this.F_galleryGubun = "Y";
        			this.fn_getGallerySize(res[j]);			
         			
         			ivImageComp = this.components["ivFPhoto0"+k];
         			ivImageComp.set_visible(true);
         			ivImageComp.set_image("");
         			pathTemp = res[j];

         			ivImageComp.set_image(pathTemp);
         			
        			var nRow = this.ds_galleryList.addRow();
        		    
        		    this.ds_galleryList.setColumn(nRow, "orgnlFileNm", res[j]);
        		    j += 1;
        		 
        		}	
        		
        		this.resetScroll();
        	}
        	
        }

        // 모바일런타임 전환으로 추가   20150707  김광호
        this.on_error = function(obj,e)
        {
        	if (e.reason == 42) //getPicture
        	{
        		if(e.errorcode == 7) //"cancelled."
        		{
        			return false;
        		}
        		
        		application.goMain.gfn_Msg("ALERT_0", "메세지", e.errormsg, "OK", true, this);		
        		return false;
        	}
        	else if (e.reason == 37)	// getFileSize
        	{
        		application.goMain.gfn_Msg("ALERT_0", "메세지", "파일용량 확인에 실패하였습니다.", "OK", true, this);		
         		return false;
        	}
        	else if (e.reason == 43)	// getPictureFromAlbum
        	{
        		if(e.errorcode == 7) //"cancelled."
        		{
        			return false;
        		}
        		
        		application.goMain.gfn_Msg("ALERT_0", "메세지", e.errormsg, "OK", true, this);		
        		return false;
        	}
        	else if (e.reason == 35)
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "파일용량이 5MB를 초과하였습니다.", "OK", true, this);
        		this.ds_fileList.clearData();
        		return false;	
        	}
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.cal_dtFrom.addEventHandler("ontouchstart", this.div_additionOrder_cal_dtTo_ontouchstart, this);
            this.btn_upjang.addEventHandler("onclick", this.btn_upjang_onclick, this);
            this.btn_camera.addEventHandler("onclick", this.btnCamera_onclick, this);
            this.btn_imageUpLoad.addEventHandler("onclick", this.btn_imageUpLoad_onclick, this);
            this.img_camera00.addEventHandler("onclick", this.img_camera00_onclick, this);
            this.cbo_rgstGubun.addEventHandler("ondropdown", this.cbo_rgstGubun_ondropdown, this);
            this.btn_allNew.addEventHandler("onclick", this.btnImgClose_onclick, this);
            this.btn_gallery.addEventHandler("onclick", this.btnPicture_onclick, this);
            this.btn_cameraNew.addEventHandler("onclick", this.btnImgClose_onclick, this);
            this.btn_galleryNew.addEventHandler("onclick", this.btnImgClose_onclick, this);
            this.sta_dtFrom.addEventHandler("onclick", this.sta_dtFrom_onclick, this);

        };

        this.loadIncludeScript("PhotoImageReqt.xfdl", true);

       
    };
}
)();
