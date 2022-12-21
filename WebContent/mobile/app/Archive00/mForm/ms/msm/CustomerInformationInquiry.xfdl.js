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
                this.set_name("CustomerInformationInquiry");
                this.set_titletext("거래처정보조회");
                this._setFormPosition(0,0,540,760);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_grdCust", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"custId\" type=\"STRING\" size=\"256\"/><Column id=\"custnm\" type=\"STRING\" size=\"256\"/><Column id=\"ccNm\" type=\"STRING\" size=\"256\"/><Column id=\"mgmtSabun\" type=\"STRING\" size=\"256\"/><Column id=\"mgmtSabunnm\" type=\"STRING\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/><Column id=\"hpTel\" type=\"STRING\" size=\"256\"/><Column id=\"addr\" type=\"STRING\" size=\"256\"/><Column id=\"jobCdnm\" type=\"STRING\" size=\"256\"/><Column id=\"locCdnm\" type=\"STRING\" size=\"256\"/><Column id=\"totCnt\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_grdUpjang", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"upjang\" type=\"STRING\" size=\"256\"/><Column id=\"mainUpjang\" type=\"STRING\" size=\"256\"/><Column id=\"upjangnmDisp\" type=\"STRING\" size=\"256\"/><Column id=\"fstRegDate\" type=\"STRING\" size=\"256\"/><Column id=\"ccNm\" type=\"STRING\" size=\"256\"/><Column id=\"partSalesSabun\" type=\"STRING\" size=\"256\"/><Column id=\"partSalesSabunNm\" type=\"STRING\" size=\"256\"/><Column id=\"csSabunNm\" type=\"STRING\" size=\"256\"/><Column id=\"csTelNo\" type=\"STRING\" size=\"256\"/><Column id=\"drname2\" type=\"STRING\" size=\"256\"/><Column id=\"addr\" type=\"STRING\" size=\"256\"/><Column id=\"custTelNo\" type=\"STRING\" size=\"256\"/><Column id=\"custHpNo\" type=\"STRING\" size=\"256\"/><Column id=\"acntcd\" type=\"STRING\" size=\"256\"/><Column id=\"bizGroup\" type=\"STRING\" size=\"256\"/><Column id=\"local1\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("Static04", "absolute", "0", "0", null, "2", "0", null, this);
            obj.set_taborder("46");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "122", "540", "10", null, null, this);
            obj.set_taborder("47");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "129", "10", "361", null, null, this);
            obj.set_taborder("50");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "0", "63", null, "59", "0", null, this);
            obj.set_taborder("82");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Button("btn_search", "absolute", null, "69", "100", "47", "9", null, this);
            obj.set_taborder("86");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            obj.set_visible("true");
            this.addChild(obj.name, obj);

            obj = new Static("sta_upjang", "absolute", "560", "63", "135", "59", null, null, this);
            obj.set_taborder("87");
            obj.set_text("거래처");
            obj.set_cssclass("sta_WF_Label02");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "530", "129", "10", "361", null, null, this);
            obj.set_taborder("92");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list00", "absolute", "10", "132", "520", "421", null, null, this);
            obj.set_taborder("104");
            obj.set_binddataset("ds_grdCust");
            obj.set_scrollbars("none");
            obj.set_autosizingtype("row");
            obj.set_extendsizetype("row");
            obj.set_visible("false");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"182\"/><Column size=\"283\"/><Column size=\"55\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"60\"/><Row size=\"60\"/><Row size=\"60\"/><Row size=\"60\"/><Row size=\"60\"/><Row size=\"60\"/><Row size=\"60\"/></Rows><Band id=\"head\"><Cell text=\"Column0\"/><Cell col=\"1\" text=\"Column1\"/><Cell col=\"2\"/></Band><Band id=\"body\"><Cell style=\"align:left;padding:0 5 0 10;background:#74748aff;background2:#74748aff;color:#ffffffff;color2:#ffffffff;selectbackground:#74748aff;selectcolor:#ffffffff;\" cssclass=\"CellGrd_WF_LabelIndigo\" text=\"담당부서\"/><Cell col=\"1\" colspan=\"2\" displaytype=\"normal\" style=\"align:left middle;padding:0 5 0 10;background:#edededff;background2:#edededff;selectbackground:#edededff;selectcolor:#555555ff;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:ccNm\" wordwrap=\"char\" autosizerow=\"limitmin\" autosizecol=\"default\"/><Cell row=\"1\" style=\"align:left;padding:0 5 0 10;background:#74748aff;background2:#74748aff;color:#ffffffff;color2:#ffffffff;selectbackground:#74748aff;selectcolor:#ffffffff;\" cssclass=\"CellGrd_WF_LabelIndigo\" text=\"영업담당자\"/><Cell row=\"1\" col=\"1\" colspan=\"2\" style=\"align:left middle;padding:0 5 0 10;background:#edededff;background2:#edededff;selectbackground:#edededff;selectcolor:#555555ff;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:mgmtSabunnm\" wordwrap=\"char\" autosizerow=\"limitmin\" autosizecol=\"default\"/><Cell row=\"2\" style=\"align:left;padding:0 5 0 10;background:#74748aff;background2:#74748aff;color:#ffffffff;color2:#ffffffff;selectbackground:#74748aff;selectcolor:#ffffffff;\" cssclass=\"CellGrd_WF_LabelIndigo\" text=\"(고객사)담당자\"/><Cell row=\"2\" col=\"1\" colspan=\"2\" style=\"align:left middle;padding:0 5 0 10;background:#edededff;background2:#edededff;selectbackground:#edededff;selectcolor:#555555ff;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:name\" wordwrap=\"char\" autosizerow=\"limitmin\" autosizecol=\"default\"/><Cell row=\"3\" style=\"align:left;padding:0 5 0 10;background:#74748aff;background2:#74748aff;color:#ffffffff;color2:#ffffffff;selectbackground:#74748aff;selectcolor:#ffffffff;\" cssclass=\"CellGrd_WF_LabelIndigo\" text=\"연락처\"/><Cell row=\"3\" col=\"1\" style=\"align:left middle;padding:0 5 0 10;line:0 solid #808080ff,0 solid #808080ff,1 solid #808080ff,0 solid #808080ff;background:#edededff;background2:#edededff;selectbackground:#edededff;selectcolor:#555555ff;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:hpTel\" wordwrap=\"char\" autosizerow=\"limitmin\" autosizecol=\"default\"/><Cell row=\"3\" col=\"2\" displaytype=\"expr:hpTel == &quot;&quot;?&quot;normal&quot;:(hpTel == &quot;--&quot;?&quot;normal&quot;:&quot;button&quot;)\" edittype=\"button\" style=\"padding:5 5 5 0;background:#edededff;background2:#edededff;selectbackground:#edededff;controlbackground:black URL('HWImage::btn_WF_Phone.png');\"/><Cell row=\"4\" style=\"align:left;padding:0 5 0 10;background:#74748aff;background2:#74748aff;color:#ffffffff;color2:#ffffffff;selectbackground:#74748aff;selectcolor:#ffffffff;\" cssclass=\"CellGrd_WF_LabelIndigo\" text=\"주소\"/><Cell row=\"4\" col=\"1\" colspan=\"2\" style=\"align:left middle;padding:0 5 0 10;background:#edededff;background2:#edededff;selectbackground:#edededff;selectcolor:#555555ff;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:addr\" wordwrap=\"char\" autosizerow=\"limitmin\" autosizecol=\"default\"/><Cell row=\"5\" style=\"align:left;padding:0 5 0 10;background:#74748aff;background2:#74748aff;color:#ffffffff;color2:#ffffffff;selectbackground:#74748aff;selectcolor:#ffffffff;\" cssclass=\"CellGrd_WF_LabelIndigo\" text=\"직군1\"/><Cell row=\"5\" col=\"1\" colspan=\"2\" style=\"align:left middle;padding:0 5 0 10;background:#edededff;background2:#edededff;selectbackground:#edededff;selectcolor:#555555ff;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:jobCdnm\" wordwrap=\"char\" autosizerow=\"limitmin\" autosizecol=\"default\"/><Cell row=\"6\" cssclass=\"CellGrd_WF_LabelIndigo\" text=\"지역1\"/><Cell row=\"6\" col=\"1\" colspan=\"2\" style=\"align:left middle;padding:0 5 0 10;background:#edededff;background2:#edededff;selectbackground:#edededff;selectcolor:#555555ff;\" text=\"bind:locCdnm\" wordwrap=\"char\" autosizerow=\"limitmin\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "523", "325", "7", "29", null, null, this);
            obj.set_taborder("107");
            obj.set_text("w07");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_upjang", "absolute", "673", "69", "312", "47", null, null, this);
            obj.set_taborder("108");
            obj.set_visible("false");
            obj.set_readonly("true");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "93", "78", "20", "29", null, null, this);
            obj.set_taborder("109");
            obj.set_text("글자사이간격w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Button("btn_upjang", "absolute", null, "69", "47", "47", "-444", null, this);
            obj.set_taborder("111");
            obj.set_cssclass("btn_WF_EdtSearch");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Button("btn_cust00", "absolute", "0", "0", "270", "63", null, null, this);
            obj.set_taborder("112");
            obj.set_text("가망고객");
            obj.set_cssclass("btn_WF_TabMFOn");
            obj.set_visible("true");
            this.addChild(obj.name, obj);

            obj = new Button("btn_cust01", "absolute", "270", "0", "270", "63", null, null, this);
            obj.set_taborder("113");
            obj.set_text("거래고객");
            obj.set_cssclass("btn_WF_TabMFOff");
            obj.set_visible("true");
            this.addChild(obj.name, obj);

            obj = new Static("sta_sabun", "absolute", "0", "63", "135", "59", null, null, this);
            obj.set_taborder("114");
            obj.set_text("고객명");
            obj.set_cssclass("sta_WF_Label02");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_sabun", "absolute", "113", "69", "312", "47", null, null, this);
            obj.set_taborder("115");
            obj.set_visible("false");
            obj.set_readonly("true");
            this.addChild(obj.name, obj);

            obj = new Button("btn_sabun", "absolute", null, "69", "47", "47", "116", null, this);
            obj.set_taborder("116");
            obj.set_cssclass("btn_WF_EdtSearch");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list01", "absolute", "546", "132", "520", "601", null, null, this);
            obj.set_taborder("117");
            obj.set_binddataset("ds_grdUpjang");
            obj.set_scrollbars("none");
            obj.set_extendsizetype("none");
            obj.set_autosizingtype("row");
            obj.set_visible("false");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"183\"/><Column size=\"282\"/><Column size=\"55\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"60\"/><Row size=\"60\"/><Row size=\"60\"/><Row size=\"60\"/><Row size=\"60\"/><Row size=\"60\"/><Row size=\"60\"/><Row size=\"60\"/><Row size=\"60\"/><Row size=\"60\"/></Rows><Band id=\"head\"><Cell text=\"Column0\"/><Cell col=\"1\" text=\"Column1\"/><Cell col=\"2\"/></Band><Band id=\"body\"><Cell style=\"align:left;padding:0 5 0 10;background:#74748aff;background2:#74748aff;color:#ffffffff;color2:#ffffffff;selectbackground:#74748aff;selectcolor:#ffffffff;\" cssclass=\"CellGrd_WF_LabelIndigo\" text=\"담당부서\" autosizerow=\"limitmin\"/><Cell col=\"1\" colspan=\"2\" displaytype=\"normal\" style=\"align:left middle;padding:0 5 0 10;background:#edededff;background2:#edededff;selectbackground:#edededff;selectcolor:#555555ff;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:ccNm\" wordwrap=\"char\" autosizerow=\"limitmin\" autosizecol=\"default\"/><Cell row=\"1\" style=\"align:left;padding:0 5 0 10;background:#74748aff;background2:#74748aff;color:#ffffffff;color2:#ffffffff;selectbackground:#74748aff;selectcolor:#ffffffff;\" cssclass=\"CellGrd_WF_LabelIndigo\" text=\"영업담당자\" autosizerow=\"limitmin\"/><Cell row=\"1\" col=\"1\" colspan=\"2\" style=\"align:left middle;padding:0 5 0 10;background:#edededff;background2:#edededff;selectbackground:#edededff;selectcolor:#555555ff;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:partSalesSabunNm\" wordwrap=\"char\" autosizerow=\"limitmin\" autosizecol=\"default\"/><Cell row=\"2\" style=\"align:left;padding:0 5 0 10;background:#74748aff;background2:#74748aff;color:#ffffffff;color2:#ffffffff;selectbackground:#74748aff;selectcolor:#ffffffff;\" cssclass=\"CellGrd_WF_LabelIndigo\" text=\"CS담당자\" autosizerow=\"limitmin\"/><Cell row=\"2\" col=\"1\" style=\"align:left middle;padding:0 5 0 10;line:0 solid #808080ff,0 solid #808080ff,1 solid #808080ff,0 solid #808080ff;background:#edededff;background2:#edededff;selectbackground:#edededff;selectcolor:#555555ff;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:csSabunNm\" wordwrap=\"char\" autosizerow=\"limitmin\" autosizecol=\"default\"/><Cell row=\"2\" col=\"2\" displaytype=\"expr:csTelNo == &quot;&quot;?&quot;normal&quot;:(csTelNo == &quot;--&quot;?&quot;normal&quot;:&quot;button&quot;)\" edittype=\"button\" style=\"padding:5 5 5 0;background:#edededff;background2:#edededff;selectbackground:#edededff;controlbackground:black URL('HWImage::btn_WF_Phone.png');\"/><Cell row=\"3\" style=\"align:left;padding:0 5 0 10;background:#74748aff;background2:#74748aff;color:#ffffffff;color2:#ffffffff;selectbackground:#74748aff;selectcolor:#ffffffff;\" cssclass=\"CellGrd_WF_LabelIndigo\" text=\"(고객사)담당자\" autosizerow=\"limitmin\"/><Cell row=\"3\" col=\"1\" colspan=\"2\" style=\"align:left middle;padding:0 5 0 10;background:#edededff;background2:#edededff;selectbackground:#edededff;selectcolor:#555555ff;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:drname2\" wordwrap=\"char\" autosizerow=\"limitmin\" autosizecol=\"default\"/><Cell row=\"4\" style=\"align:left;padding:0 5 0 10;background:#74748aff;background2:#74748aff;color:#ffffffff;color2:#ffffffff;selectbackground:#74748aff;selectcolor:#ffffffff;\" cssclass=\"CellGrd_WF_LabelIndigo\" text=\"(고객)연락처\" autosizerow=\"limitmin\"/><Cell row=\"4\" col=\"1\" style=\"align:left middle;padding:0 5 0 10;line:0 solid #808080ff,0 solid #808080ff,1 solid #808080ff,0 solid #808080ff;background:#edededff;background2:#edededff;selectbackground:#edededff;selectcolor:#555555ff;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:custTelNo\" wordwrap=\"char\" autosizerow=\"limitmin\" autosizecol=\"default\"/><Cell row=\"4\" col=\"2\" displaytype=\"expr:custTelNo == &quot;&quot;?&quot;normal&quot;:(custTelNo  == &quot;--&quot;?&quot;normal&quot;:&quot;button&quot;)\" edittype=\"button\" style=\"padding:5 5 5 0;background:#edededff;background2:#edededff;selectbackground:#edededff;controlbackground:black URL('HWImage::btn_WF_Phone.png');\" cssclass=\"CellGrd_WF_LabelGray\" wordwrap=\"none\" autosizerow=\"limitmin\" autosizecol=\"default\"/><Cell row=\"5\" cssclass=\"CellGrd_WF_LabelIndigo\" text=\"(고객)휴대폰\"/><Cell row=\"5\" col=\"1\" style=\"align:left middle;padding:0 5 0 10;line:0 solid #808080ff,0 solid #808080ff,1 solid #808080ff,0 solid #808080ff;background:#edededff;background2:#edededff;selectbackground:#edededff;selectcolor:#555555ff;\" text=\"bind:custHpNo\" autosizerow=\"limitmin\"/><Cell row=\"5\" col=\"2\" displaytype=\"expr:custHpNo == &quot;&quot;?&quot;normal&quot;:(custHpNo  == &quot;--&quot;?&quot;normal&quot;:&quot;button&quot;)\" edittype=\"button\" style=\"padding:5 5 5 0;background:#edededff;background2:#edededff;selectbackground:#edededff;controlbackground:black URL('HWImage::btn_WF_Phone.png');\" autosizerow=\"limitmin\"/><Cell row=\"6\" style=\"align:left;padding:0 5 0 10;background:#74748aff;background2:#74748aff;color:#ffffffff;color2:#ffffffff;selectbackground:#74748aff;selectcolor:#ffffffff;\" cssclass=\"CellGrd_WF_LabelIndigo\" text=\"계좌정보\" autosizerow=\"limitmin\"/><Cell row=\"6\" col=\"1\" colspan=\"2\" style=\"align:left middle;padding:0 5 0 10;background:#edededff;background2:#edededff;selectbackground:#edededff;selectcolor:#555555ff;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:acntcd\" wordwrap=\"char\" autosizerow=\"limitmin\" autosizecol=\"default\"/><Cell row=\"7\" cssclass=\"CellGrd_WF_LabelIndigo\" text=\"주소\" autosizerow=\"limitmin\"/><Cell row=\"7\" col=\"1\" colspan=\"2\" style=\"align:left middle;padding:0 5 0 10;background:#edededff;background2:#edededff;selectbackground:#edededff;selectcolor:#555555ff;\" text=\"bind:addr\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"8\" cssclass=\"CellGrd_WF_LabelIndigo\" text=\"직군1\" autosizerow=\"limitmin\"/><Cell row=\"8\" col=\"1\" colspan=\"2\" style=\"align:left middle;padding:0 5 0 10;background:#edededff;background2:#edededff;selectbackground:#edededff;selectcolor:#555555ff;\" text=\"bind:bizGroup\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"9\" cssclass=\"CellGrd_WF_LabelIndigo\" text=\"지역1\" autosizerow=\"limitmin\"/><Cell row=\"9\" col=\"1\" colspan=\"2\" style=\"align:left middle;padding:0 5 0 10;background:#edededff;background2:#edededff;selectbackground:#edededff;selectcolor:#555555ff;\" text=\"bind:local1\" wordwrap=\"char\" autosizerow=\"limitmin\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("거래처정보조회");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("CustomerInformationInquiry.xfdl", "lib::lib_Com.xjs");
        this.registerScript("CustomerInformationInquiry.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		거래처정보조회
        // [부시스템명]	거래처정보조회 - 조회
        // [설명]
        // 		부서 검색하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.02.04
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.04 : 강대성 : 화면 신규.
        // 2015.05.20 : 강대성 : 프로그램 수정(가망고객 및 거래고객)
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*======================================================
         전역변수
         ======================================================*/
        this.upjang = undefined;
        this.gubun = undefined;
        this.phonNumber = undefined;
        this.mgmtSabun = undefined;
        this.auth = 1;

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
        	//필수
        	this.fn_init();
        	
        	// 필수(모바일런타임 DeviceAPI사용
        	this.fspmob = new nexacro.FSPMobile();
        	this.fspmob.addEventHandler("onsuccess", this.on_success, this);
        	this.fspmob.addEventHandler("onerror", this.on_error, this);
        }

        //초기값
        this.fn_init = function ()
        {
        	this.gubun = "00";
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.auth = this.fn_SetBtnControl("this.btn_search","");	
        	
        	// 권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetAuth("this.edt_sabun", "this.btn_sabun");
        	
        	//초기값 가망고객 layer보여줌
        	this.sta_sabun.set_visible(true);
        	this.edt_sabun.set_visible(true);
        	this.btn_sabun.set_visible(true);
        	this.grd_list00.set_visible(true);	
        	
        	this.upjang = application.g_Upjang;	
        	
        	if(this.ds_grdCust.getRowCount() == 0){
        		var nRow = this.ds_grdCust.addRow();		
        		this.ds_grdCust.setColumn(nRow,"hpTel", "");
        	}	
        	
        	this.edt_sabun.set_enable(true);
        	this.btn_sabun.set_enable(true);
        }

        //상단 버튼에 따라 cssclass변경
        this.btn_cust00_onclick = function(obj,e)
        {
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.auth = this.fn_SetBtnControl("this.btn_search","");	
        	
        	// 권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetAuth("this.edt_upjang", "this.btn_upjang");
        	
        	this.btn_cust00.set_cssclass("btn_WF_TabMFOn");
        	this.btn_cust01.set_cssclass("btn_WF_TabMFOff");
        	this.gubun = "00";
        	
        	//초기값 가망고객 layer보여줌
        	this.sta_sabun.set_visible(true);
        	this.edt_sabun.set_visible(true);
        	this.btn_sabun.set_visible(true);
        	this.grd_list00.set_visible(true);	
        		
        	//초기값 거래고객 layer숨김
        	this.sta_upjang.set_visible(false);
        	this.edt_upjang.set_visible(false);
        	this.btn_upjang.set_visible(false);
        	this.grd_list01.set_visible(false);
        	
        	if(this.ds_grdCust.getRowCount() == 0){
        		var nRow = this.ds_grdCust.addRow();		
        		this.ds_grdCust.setColumn(nRow,"hpTel", "");
        	}	
        	
        	this.edt_sabun.set_enable(true);
        	this.btn_sabun.set_enable(true);
        	
        }

        //상단 버튼에 따라 cssclass변경
        this.btn_cust01_onclick = function(obj,e)
        {
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.auth = this.fn_SetBtnControl("this.btn_search","");	
        	
        	// 권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetAuth("this.edt_upjang", "this.btn_upjang");
        	
        	this.btn_cust00.set_cssclass("btn_WF_TabMFOff");
        	this.btn_cust01.set_cssclass("btn_WF_TabMFOn");
        	this.gubun = "01";
        	
        	//초기값 가망고객 layer보여줌
        	this.sta_sabun.set_visible(false);
        	this.edt_sabun.set_visible(false);
        	this.btn_sabun.set_visible(false);
        	this.grd_list00.set_visible(false);	
        		
        	//초기값 거래고객 layer숨김
        	this.sta_upjang.set_visible(true);
        	this.edt_upjang.set_visible(true);
        	this.btn_upjang.set_visible(true);
        	this.grd_list01.set_visible(true);
        		
        	//위치값 조정
        	this.sta_upjang.set_left(0);
        	this.edt_upjang.set_left(113);
        	this.btn_upjang.set_right(116);
        	this.grd_list01.set_left(10);
        	
        	if(this.ds_grdUpjang.getRowCount() == 0){
        		var nRow = this.ds_grdUpjang.addRow();		
        		this.ds_grdUpjang.setColumn(nRow,"csTelNo", "");
        		this.ds_grdUpjang.setColumn(nRow,"custTelNo", "");
        		this.ds_grdUpjang.setColumn(nRow,"custHpNo", "");
        	}	
        	
        	this.edt_upjang.set_enable(true);
        	this.btn_upjang.set_enable(true);	
        }

        /** 
         * 가망고객 및 업장 팝업 호출
         */
        this.btn_upjang_onclick = function(obj,e)
        {	
        	//가망고객 선택시(가망고객 검색 팝업 창 호출)
        	if(this.gubun == "00"){
        		var arg = new Array();
        		arg[0] = this.auth;
        	
        		application.goMain.gfn_POP_create("searchSabun", "M_MSM::CustMgmtSearchPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        		return false;
        		
        	//거래고객 선택시(사업장 검색 팝업 창 호출)
        	}else if(this.gubun = "01"){
        		var arg = new Array();
        		//arg[0] = this.edt_upjang.value;
        		arg[1] = this.upjang;
        		arg[2] = "FMS";
        		/*
        		if(application.g_AuthLevel == "999" || application.g_AuthLevel == "99" || application.g_AuthLevel == "80" )
        		{
        			arg[2] = "FMS";		
        		}
        		else
        		{
        			arg[2] = "FMS2";
        		}
        		*/
        		application.goMain.gfn_POP_create("upjangNm", "M_MLM::WorkplaceSearchPop2.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        		return false;	
        	}
        	
        }

        /*******************************************************************************
        * 기      능   :  검색
        * 설      명   :  등록
        ********************************************************************************/
        this.btnSearch_onclick = function(obj,e)
        {
        	this.fn_search();	
        }

        this.fn_search = function()
        {
        	if(this.gubun == "01"){
        	
        		this.ds_grdUpjang.clearData();
        		
        		if ( this.gfn_isNull(this.edt_upjang.value) )
        		{
        			application.goMain.gfn_Msg("ALERT_0", "알림", "거래처명을 입력하십시요", "OK");
        			return;
        		}
        		
        		//검색
        		var strSvcID   		 = "searchUpjang";
        		var strUrl     		 = "ms/msm/customerInformationInquiry/selectUpjangList.xdo";
        		var strInDataset     = "";
        		var strOutDataset    = "ds_grdUpjang=ds_list";
        		var strArguments	 = "upjang=" + nexacro.wrapQuote(this.upjang);
        		    strArguments     += " maskAuth=" + nexacro.wrapQuote(this.auth); //입력권한에 따른 마스크 여부를 위해 maskAuth전달함
        		var strCallbackFunc	 = "fn_callBack";
        		var bAsync			 = true;

        		this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
        		// connect the server 
        	
        	}	
        }

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
        		//가망고객 조회시
                case "searchSabun" :
        			// 조회 건수 확인  
                    if (this.ds_grdCust.getRowCount() == 0) 
                    {
                        application.goMain.gfn_Msg("alertTest", "Information", "조회되는 내용이 없습니다.", "OK");	//조회되는 내용이 없습니다..
                        return;
                    }else{
        						
                    }			
          			break;
        		//거래고객 조회시
                case "searchUpjang" :
        			// 조회 건수 확인  
                    if (this.ds_grdUpjang.getRowCount() == 0) 
                    {
                        application.goMain.gfn_Msg("alertTest", "Information", "조회되는 내용이 없습니다.", "OK");	//조회되는 내용이 없습니다..
                        return;
                    }else{
        				
        				this.partSalesSabun = this.ds_grdUpjang.getColumn(this.ds_grdUpjang.rowposition, "partSalesSabun");	//cs담당자 사번	
        				
        				//해당 영업사원이 아니면 cs담당자, (고객사)담당자, (고객)연락처, 계좌정보 및 주소는 숨긴다.
        				if ( (this.partSalesSabun != application.g_EmpNo && application.g_AuthLevel != "99") ) {
        					this.grd_list01.set_autosizingtype("none");
        					this.grd_list01.setFormatRowProperty(3, "size", 0); 
        					this.grd_list01.setFormatRowProperty(4, "size", 0);
        					this.grd_list01.setFormatRowProperty(5, "size", 0);
        					this.grd_list01.setFormatRowProperty(6, "size", 0);
        					this.grd_list01.setFormatRowProperty(7, "size", 0);
        					this.grd_list01.setFormatRowProperty(8, "size", 0);	
        					this.grd_list01.set_height(241);
        							
        				}else{
        					this.grd_list01.set_autosizingtype("row");
        					this.grd_list01.setFormatRowProperty(3, "size", 60); 
        					this.grd_list01.setFormatRowProperty(4, "size", 60);
        					this.grd_list01.setFormatRowProperty(5, "size", 60);
        					this.grd_list01.setFormatRowProperty(6, "size", 60);
        					this.grd_list01.setFormatRowProperty(7, "size", 60);
        					this.grd_list01.setFormatRowProperty(8, "size", 60);
        					this.grd_list01.set_height(601);
        				}				
                    }			
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
        		case "searchSabun":
        			this.edt_sabun.set_value(rtn[0]);
        			
        			this.ds_grdCust.setColumn(0, "ccNm", rtn[1])        //부서명
        			this.ds_grdCust.setColumn(0, "mgmtSabunnm", rtn[3]) //담당자명
        			this.ds_grdCust.setColumn(0, "name", rtn[4])        //고객명
        			this.ds_grdCust.setColumn(0, "hpTel", rtn[5])       //고객연락처
        			this.ds_grdCust.setColumn(0, "addr", rtn[6])        //고객주소
        			this.ds_grdCust.setColumn(0, "jobCdnm", rtn[7])     //직군1
        			this.ds_grdCust.setColumn(0, "locCdnm", rtn[8])     //지역1
        			
        			this.mgmtSabun = rtn[2];	//담당자 사번
        			
        			if(!(this.mgmtSabun == application.g_EmpNo || application.g_AuthLevel == "999")){
        				
        				this.grd_list00.set_autosizingtype("none");
        				this.grd_list00.setFormatRowProperty(3, "size", 0); 
        				this.grd_list00.setFormatRowProperty(4, "size", 0);
        				this.grd_list00.setFormatRowProperty(5, "size", 0);
        				this.grd_list00.set_height(241);
        				
        			}else{
        				
        				this.grd_list00.set_autosizingtype("none");
        				this.grd_list00.setFormatRowProperty(3, "size", 60); 
        				this.grd_list00.setFormatRowProperty(4, "size", 60);
        				this.grd_list00.setFormatRowProperty(5, "size", 60);
        				this.grd_list00.set_height(421);
        			}
        			
        			break;
        		case "upjangNm":
        			this.edt_upjang.set_value(rtn[1]);
        			this.upjang = rtn[0];
        			this.fn_search();
        			break;
        	}
        }

        /************************************************************************************************
         * 각 COMPONENT 별 EVENT 영역 (필수)
        ************************************************************************************************/

        // 바로걸기
        this.btn_directPhone_onclick = function(obj,e)
        {
        	// 모바일런타임전환으로 fspmob 함수 변경	20150708  김광호
        	// this.fspmob_call(this, this.phonNumber, "call_callback");
        	this.fspmob.call(nexacro.parseInt(this.phonNumber));
        }

        // 전화 앱 연결(가망고객)
        this.grd_list00_oncellclick = function(obj,e)
        {
        	if(e.cell == "8"){
        		this.phonNumber = this.ds_grdCust.getColumn(this.ds_grdCust.rowposition, "hpTel");
        		
        		if (!(this.gfn_isNull(this.phonNumber) || this.phonNumber == "--"))
        		{
        			// 모바일런타임전환으로 fspmob 함수 변경	20150707  김광호
        			// this.fspmob_dial(this, this.phonNumber, "call_callback");
        			this.fspmob.dial(this.phonNumber);
        		}
        	}
        }

        // 전화 앱 연결(거래고객)
        this.grd_list01_oncellclick = function(obj,e)
        {
        	if(e.cell == "6"){
        		this.phonNumber = this.ds_grdUpjang.getColumn(this.ds_grdUpjang.rowposition, "csTelNo");
        		
        		if (!(this.gfn_isNull(this.phonNumber) || this.phonNumber == "--"))
        		{
        			// 모바일런타임전환으로 fspmob 함수 변경	20150707  김광호
        			// this.fspmob_dial(this, this.phonNumber, "call_callback");
        			this.fspmob.dial(this.phonNumber);
        		}
        	}else if(e.cell == "11"){
        		this.phonNumber = this.ds_grdUpjang.getColumn(this.ds_grdUpjang.rowposition, "custTelNo");
        		
        		if (!(this.gfn_isNull(this.phonNumber) || this.phonNumber == "--"))
        		{
        			// 모바일런타임전환으로 fspmob 함수 변경	20150707  김광호
        			// this.fspmob_dial(this, this.phonNumber, "call_callback");
        			this.fspmob.dial(this.phonNumber);
        		}
        	}else if(e.cell == "14"){
        		this.phonNumber = this.ds_grdUpjang.getColumn(this.ds_grdUpjang.rowposition, "custHpNo");
        		
        		if (!(this.gfn_isNull(this.phonNumber) || this.phonNumber == "--"))
        		{
        			// 모바일런타임전환으로 fspmob 함수 변경	20150707  김광호
        			// this.fspmob_dial(this, this.phonNumber, "call_callback");
        			this.fspmob.dial(this.phonNumber);
        		}
        	}
        }

        // 모바일런타임 전환으로 추가   20150707  김광호
        this.on_success = function(obj,e)
        {
        	if (e.reason == "10")
        	{
        	//	this.alert("on_success :: obj :: "+obj.name+" :: e = "+e.reason);
        // 		var obj = this.ta0;
        // 		
        // 		obj.set_value(e.reason + " : " + JSON.stringify(e.returnvalue) );
        		this.trace(e.errormsg);
        	}
        	else if (e.reason == "9")
        	{
        		application.goMain.gfn_Msg("ALERT_0", "메세지", e.errormsg, "OK", true, this);
        		return false;
        	}
        }

        // 모바일런타임 전환으로 추가   20150707  김광호
        this.on_error = function(obj,e)
        {
        //	this.alert("on_error :: obj :: "+obj.name+" :: e = "+e.reason);
        	//alert(e.reason);
        	if (e.reason == "10")
        	{
        // 		var obj = this.ta0;
        // 		obj.set_value(e.reason + " : " + e.errormsg );
        	
        		application.goMain.gfn_Msg("ALERT_0", "메세지", e.errormsg, "OK", true, this);
        		return false;
        	}
        	else if (e.reason == "9")
        	{
        		trace(e.errormsg);
        		return false;
        	}
        }

        

        this.sta_sabun_onclick = function(obj,e)
        {
        	if ( application.g_userId == "Z1855902" ) {
        		if( !this.btn_cust00.cssclass || this.btn_cust00.cssclass == null ) {
        			this.btn_cust00.set_cssclass("btn_WF_TabTFOn");
        		} else {
        			this.btn_cust00.set_cssclass("");
        		}
        	}
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.btn_search.addEventHandler("onclick", this.btnSearch_onclick, this);
            this.grd_list00.addEventHandler("oncellclick", this.grd_list00_oncellclick, this);
            this.btn_upjang.addEventHandler("onclick", this.btn_upjang_onclick, this);
            this.btn_cust00.addEventHandler("onclick", this.btn_cust00_onclick, this);
            this.btn_cust01.addEventHandler("onclick", this.btn_cust01_onclick, this);
            this.sta_sabun.addEventHandler("onclick", this.sta_sabun_onclick, this);
            this.btn_sabun.addEventHandler("onclick", this.btn_upjang_onclick, this);
            this.grd_list01.addEventHandler("oncellclick", this.grd_list01_oncellclick, this);

        };

        this.loadIncludeScript("CustomerInformationInquiry.xfdl", true);

       
    };
}
)();
