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
                this.set_name("CmmnFrameLogin");
                this.set_titletext("로그인");
                this.set_scrollbars("autovert");
                this._setFormPosition(0,0,540,923);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_cond", this);
            obj.set_preload("true");
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj._setContents("<ColumnInfo><Column id=\"SINGLE_ID\" size=\"255\" type=\"STRING\"/><Column id=\"PWD\" size=\"255\" type=\"STRING\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_roll", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"userid\" type=\"STRING\" size=\"256\"/><Column id=\"pswdChk\" type=\"STRING\" size=\"256\"/><Column id=\"usrNm\" type=\"STRING\" size=\"256\"/><Column id=\"usrEngNm\" type=\"STRING\" size=\"256\"/><Column id=\"rno\" type=\"STRING\" size=\"256\"/><Column id=\"offcCd\" type=\"STRING\" size=\"256\"/><Column id=\"offcNm\" type=\"STRING\" size=\"256\"/><Column id=\"ogCd\" type=\"STRING\" size=\"256\"/><Column id=\"ogNm\" type=\"STRING\" size=\"256\"/><Column id=\"posCd\" type=\"STRING\" size=\"256\"/><Column id=\"posNm\" type=\"STRING\" size=\"256\"/><Column id=\"psitNm\" type=\"STRING\" size=\"256\"/><Column id=\"pno\" type=\"STRING\" size=\"256\"/><Column id=\"faxNo\" type=\"STRING\" size=\"256\"/><Column id=\"mblPno\" type=\"STRING\" size=\"256\"/><Column id=\"zipNo\" type=\"STRING\" size=\"256\"/><Column id=\"addr\" type=\"STRING\" size=\"256\"/><Column id=\"emailAddr\" type=\"STRING\" size=\"256\"/><Column id=\"fnlConnIp\" type=\"STRING\" size=\"256\"/><Column id=\"fnlConnDtm\" type=\"STRING\" size=\"256\"/><Column id=\"bgnDt\" type=\"STRING\" size=\"256\"/><Column id=\"edt\" type=\"STRING\" size=\"256\"/><Column id=\"fnlModrId\" type=\"STRING\" size=\"256\"/><Column id=\"fnlModDtm\" type=\"STRING\" size=\"256\"/><Column id=\"certDn\" type=\"STRING\" size=\"256\"/><Column id=\"popupYn\" type=\"STRING\" size=\"256\"/><Column id=\"sesId\" type=\"STRING\" size=\"256\"/><Column id=\"pupMarkYn\" type=\"STRING\" size=\"256\"/><Column id=\"usrDivCd\" type=\"STRING\" size=\"256\"/><Column id=\"dfnYn\" type=\"STRING\" size=\"256\"/><Column id=\"smsUseYn\" type=\"STRING\" size=\"256\"/><Column id=\"persInfoAgreeYn\" type=\"STRING\" size=\"256\"/><Column id=\"persInfoMask\" type=\"STRING\" size=\"256\"/><Column id=\"persInfoProcLevel\" type=\"STRING\" size=\"256\"/><Column id=\"ctiUseYn\" type=\"STRING\" size=\"256\"/><Column id=\"ctiUserId\" type=\"STRING\" size=\"256\"/><Column id=\"authLevels\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row/></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_test", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"256\"/><Column id=\"cdNm\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"cd\">00</Col><Col id=\"cdNm\">L20141113</Col></Row><Row><Col id=\"cd\">01</Col><Col id=\"cdNm\">200800148</Col></Row><Row><Col id=\"cd\">02</Col><Col id=\"cdNm\">200600986</Col></Row><Row><Col id=\"cdNm\">200801515</Col><Col id=\"cd\">03</Col></Row><Row><Col id=\"cd\">04</Col><Col id=\"cdNm\">테스트아이디</Col></Row><Row><Col id=\"cdNm\">200600698</Col><Col id=\"cd\">05</Col></Row><Row><Col id=\"cdNm\">201403853</Col><Col id=\"cd\">06</Col></Row><Row><Col id=\"cdNm\">200110502</Col><Col id=\"cd\">07</Col></Row><Row><Col id=\"cdNm\">198708243</Col><Col id=\"cd\">08</Col></Row><Row><Col id=\"cdNm\">198213166</Col><Col id=\"cd\">09</Col></Row><Row><Col id=\"cdNm\">급식유통테스트</Col><Col id=\"cd\">10</Col></Row><Row><Col id=\"cdNm\">캐터링테스트</Col><Col id=\"cd\">11</Col></Row><Row><Col id=\"cdNm\">외식테스트</Col><Col id=\"cd\">12</Col></Row><Row><Col id=\"cdNm\">가맹점테스트</Col><Col id=\"cd\">13</Col></Row><Row><Col id=\"cdNm\">201403183</Col><Col id=\"cd\">14</Col></Row><Row><Col id=\"cdNm\">공급업체테스트</Col><Col id=\"cd\">15</Col></Row><Row><Col id=\"cdNm\">199519215</Col><Col id=\"cd\">16</Col></Row><Row><Col id=\"cdNm\">200010566</Col><Col id=\"cd\">17</Col></Row></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_appDivcList", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"appId\" type=\"STRING\" size=\"256\"/><Column id=\"userId\" type=\"STRING\" size=\"256\"/><Column id=\"dvicId\" type=\"STRING\" size=\"256\"/><Column id=\"regTp\" type=\"STRING\" size=\"256\"/><Column id=\"attr1\" type=\"STRING\" size=\"256\"/><Column id=\"attr2\" type=\"STRING\" size=\"256\"/><Column id=\"attr3\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "540", "923", null, null, this);
            obj.set_taborder("24");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0%", "0", null, "346", "0%", null, this);
            obj.set_taborder("11");
            obj.set_cssclass("sta_LOGIN_Bg01");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "0%", "346", null, null, "0%", "0", this);
            obj.set_taborder("10");
            obj.set_cssclass("sta_LOGIN_Bg02");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "0", "0", null, "393", "0", null, this);
            obj.set_taborder("19");
            obj.set_cssclass("sta_LOGIN_BgImg");
            this.addChild(obj.name, obj);

            obj = new CheckBox("chk_saveID", "absolute", "30", "660", "249", "56", null, null, this);
            obj.set_taborder("3");
            obj.set_text("자동로그인");
            obj.set_value("N");
            obj.set_truevalue("Y");
            obj.set_falsevalue("N");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "30", "409", "100", "42", null, null, this);
            obj.set_taborder("6");
            obj.set_cssclass("sta_LOGIN_Login");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "0", null, null, "22", "0", "20", this);
            obj.set_taborder("9");
            obj.set_cssclass("sta_LOGIN_Copyright");
            this.addChild(obj.name, obj);

            obj = new Edit("edtId", "absolute", "30", "456", null, "55", "30", null, this);
            obj.set_taborder("0");
            obj.set_displaynulltext("ID를 입력하세요");
            obj.set_cssclass("edt_LOGIN_Login");
            obj.set_autoselect("false");
            this.addChild(obj.name, obj);

            obj = new Button("btnLogin", "absolute", "30", "581", null, "80", "30", null, this);
            obj.set_taborder("2");
            obj.set_cssclass("btn_LOGIN_Login");
            this.addChild(obj.name, obj);

            obj = new Edit("edtPwd", "absolute", "30", "517", null, "55", "30", null, this);
            obj.set_taborder("1");
            obj.set_displaynulltext("패스워드를 입력하세요");
            obj.set_cssclass("edt_LOGIN_Login");
            obj.set_password("true");
            obj.set_imemode("alpha");
            obj.set_autoselect("false");
            this.addChild(obj.name, obj);

            obj = new Combo("cbo_test", "absolute", "456", "465", "47", "36", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("5");
            obj.set_innerdataset("@ds_test");
            obj.set_codecolumn("cd");
            obj.set_datacolumn("cdNm");
            obj.set_displaynulltext("테스트");
            obj.set_visible("false");
            obj.set_index("-1");

            obj = new CheckBox("chk_saveID00", "absolute", "261", "660", "249", "56", null, null, this);
            obj.set_taborder("4");
            obj.set_text("아이디저장");
            obj.set_value("N");
            obj.set_truevalue("Y");
            obj.set_falsevalue("N");
            obj.set_visible("true");
            obj.set_cssclass("chk_LOGIN_Login");
            this.addChild(obj.name, obj);

            obj = new Static("sta_inform", "absolute", "13", "795", "512", "27", null, null, this);
            obj.set_taborder("7");
            obj.set_text("사용하는 요금제에 따라 데이터 요금이 과다 발생할 수 있으니");
            obj.style.set_color("#ffffffff");
            obj.style.set_align("center middle");
            obj.style.set_font("bold antialias 12 arial");
            this.addChild(obj.name, obj);

            obj = new Static("sta_inform00", "absolute", "12", "832", "514", "27", null, null, this);
            obj.set_taborder("8");
            obj.set_text("전용 요금제나 무선랜(WI-FI)을 권장합니다.");
            obj.style.set_color("#ffffffff");
            obj.style.set_align("center middle");
            obj.style.set_font("bold antialias 12 arial");
            this.addChild(obj.name, obj);

            obj = new Button("btn_clearId", "absolute", null, "470", "29", "29", "37", null, this);
            obj.set_taborder("26");
            obj.set_visible("false");
            obj.style.set_background("gray URL('theme://Image/btn_close.jpg') stretch");
            obj.style.set_border("1 solid #9a9a9aff");
            obj.style.set_color("white");
            obj.style.set_bordertype("round 50 50");
            obj.style.set_font("bold antialias 19 Droid Sans");
            this.addChild(obj.name, obj);

            obj = new Button("btn_clearPw", "absolute", null, "530", "29", "29", "37", null, this);
            obj.set_taborder("27");
            obj.set_visible("false");
            obj.style.set_background("transparent URL('theme://Image/btn_close.jpg') stretch");
            obj.style.set_border("1 solid #9a9a9aff");
            obj.style.set_bordertype("round 50 50");
            this.addChild(obj.name, obj);

            obj = new Static("sta_join", "absolute", "13", "747", "512", "27", null, null, this);
            obj.set_taborder("28");
            obj.set_text("회원가입");
            obj.style.set_color("#ffffffff");
            obj.style.set_align("center middle");
            obj.style.set_font("bold antialias underline 12 arial");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new ImageViewer("img_chk", "absolute", "263", "678", "25", "25", null, null, this);
            obj.set_taborder("30");
            obj.style.set_background("transparent URL('theme://Image/chk_LOGIN_BtnImg.png')");
            obj.style.set_border("0 solid #9a9a9aff");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 923, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frameLogin");
            		p.set_titletext("로그인");
            		p.set_scrollbars("autovert");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        
        this.loadPreloadList = function()
        {
            this._addPreloadList("data", "", "ds_cond");
        };
        
        // User Script
        this.addIncludeScript("CmmnFrameLogin.xfdl", "lib::lib_Com.xjs");
        this.registerScript("CmmnFrameLogin.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		로그인 
        // [부시스템명]	공통 - 로그인
        // [프로그램]		CmmnFrameLogin.xfdl
        // [설명]
        // 		프로젝트 실행 로그인 화면
        // [작성자명] 		투비소프트
        // [작성일자]		2015.01.12
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.01.12 : 김광호 : 로그인 신규생성.
        // 2015.03.09 : 강대성 : 아이디저장 체크 추가.
        // 2015.04.21 : 강대성 : 문구추가(intro화면, 로그인화면에 적용).
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/
        this.preDate = undefined;
        this.fspmob;
        /*================================================================================
         * 2. Form관련 Script
         *===============================================================================*/
        this.CmmnFrameLogin_onload = function(obj,e)
        {
        	this.fn_init();
        }

        /** 
         * 화면셋팅
         * @param  : 없음
         * @return : 없음
         */
        this.fn_init = function ()
        {	
        	//안드로이드4.3TODO
        	this.btnLogin.set_cssclass("");
        	this.btnLogin.set_cssclass("btn_LOGIN_Login");
        	
        	application.goMain.gfn_POP_resize(this);
        	
        	// 필수(모바일런타임 DeviceAPI사용
        	this.fspmob = new nexacro.FSPMobile();
        	this.fspmob.addEventHandler("onsuccess", this.on_success, this);
        	this.fspmob.addEventHandler("onerror", this.on_error, this);
        	
        	this.fspmob.getValueAll();
        }

        
        this.on_success = function(obj,e)
        {
        	if (e.reason == 23) // getValueAll
        	{
        		var rtnObj = e.returnvalue.result;
        		
        		//글로벌 변수 셋팅 ID, PW, SAVEID, PUSHAPP 

        		//자동 로그인
        		if(rtnObj.SAVEAUTO == "Y")
        		{
        			application.gv_autoLogin = rtnObj.SAVEAUTO;
        			
        			if (!application.gfn_IsNull(rtnObj.ID))
        			{
        				application.gv_ID = rtnObj.ID;
        				this.edtId.set_value(application.gv_ID);
        			}
        			if (!application.gfn_IsNull(rtnObj.PW))
        			{
        				application.gv_PW = rtnObj.PW;
        				this.edtPwd.set_value(application.gv_PW);
        				this.chk_saveID.set_value(this.chk_saveID.truevalue);
        			}
        			
        		}
        		
        		if(rtnObj.SAVEID == "Y")
        		{
        			application.gv_saveId= rtnObj.SAVEID;
        			
        			if (!application.gfn_IsNull(rtnObj.ID))
        			{
        				application.gv_ID = rtnObj.ID;
        				this.edtId.set_value(application.gv_ID);
        				this.chk_saveID00.set_value(this.chk_saveID00.truevalue);
        				this.img_chk.set_visible(true);
        			}
        			
        		}
        		
        		if(rtnObj.PUSHAPP == "true" || rtnObj.PUSHAPP == true)
        		{
        			application.gv_pushChk= rtnObj.PUSHAPP;
        		}else{
        			application.gv_pushChk= false;
        		}				
        		
        		if ( ((rtnObj.SAVEAUTO == "N" || rtnObj.SAVEAUTO == false) && (rtnObj.SAVEID == "N" || rtnObj.SAVEID == false)))
        		{
        			application.gv_ID = "";
        			application.gv_PW = "";
        			application.gv_autoLogin = "N";
        			application.gv_saveId = "N";			
        		}
        		
        		
        		// 자동로그인	
        		if(application.gv_autoLogin == "Y")
        		{
        			this.chk_saveID.set_value("Y");
        			
        			this.fn_login();
        		}
        			
        		if(!this.gfn_isNull(this.edtId.value))
        		{
        			this.btn_clearId.set_visible(true);
        		}
        		else
        		{
        			this.btn_clearId.set_visible(false);
        		}	
        		
        		if(!this.gfn_isNull(this.edtPwd.value))
        		{
        			this.btn_clearPw.set_visible(true);
        		}
        		else
        		{
        			this.btn_clearPw.set_visible(false);
        		}	
        	}	
        }

        this.on_error = function(obj,e)
        {
        	this.trace(e.reason + "::" + e.errormsg);
        }

        //버튼 클릭시(공통)
        this.Common_Btn_common_OnClick = function (obj,e)
        {
        	switch(obj.name)
        	{
        		case "btn_clearId":
        			this.edtId.set_value("");
        			this.btn_clearId.set_visible(false);
        			this.edtId.setFocus();
        			break;
        		case "btn_clearPw":
        			this.edtPwd.set_value("");
        			this.btn_clearPw.set_visible(false);
        			this.edtPwd.setFocus();
        			break;		
        	}
        }

        /*==========================================================================
         * 3. DataSet관련 Script
        *========================================================================*/

        /*==========================================================================
         * 4. Component관련 Script
        *========================================================================*/

        /*******************************************************************************
        * 기      능   :  로그인 버튼 클릭
        * 설      명   :  로그인 버튼 클릭
        ********************************************************************************/
        this.btnLogin_onclick = function(obj,e)
        {
        	application.gv_autoLogin = this.chk_saveID.value;
        	application.gv_saveId = this.chk_saveID00.value;
        	
        	this.fn_login();	// 로그인 함수 호출
        }

        /*******************************************************************************
        * 기      능   :  로그인 처리
        * 설      명   :  로그인처리
        ********************************************************************************/
        this.fn_login = function ()
        {
        	if(application.gfn_IsNull(this.edtId.text)) 
            {
                application.goMain.gfn_Msg("errorId", "Information", "사용자ID를 입력하여 주십시요.", "OK", true, this);
                return;
            }
             
            if(application.gfn_IsNull(this.edtPwd.text)) 
            {
                application.goMain.gfn_Msg("errorPw", "Information", "패스워드를 입력하여 주십시요.", "OK", true, this);
                return;
            }
            
        	//서비스 연결 됐을때 아래 로직으로..
             var strSvcID   	  = "login";
             var strUrl     	  = "sc/cmn/login.xdo";
             var strInDataset     = "";
             var strOutDataset    = "gds_userInfo=gdsUserInfo";
             var strArguments	  = "id=" + nexacro.wrapQuote(this.edtId.text);
                 strArguments     += " pwd=" + nexacro.wrapQuote(this.edtPwd.value);
                 strArguments     += " sysType=" + application.g_SystemId;	// "FSMOBILE"
             var strCallbackFunc  = "fn_callBack";
             var bAsync			  = false;
             
             this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);

        }

        // 로그인 후처리
        this.fn_loginAft = function ()
        {

        	// Global Value 설정(기존 사용 화면에서 사용으로 기능 유지)
        	application.g_userId            = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "userid"); 
        	application.g_AuthLevel         = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "authLevel"); // ds_roll.getColumn(ds_roll.rowposition,"g_AuthLevel");
        	application.g_Cc_Cd             = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "ccCd"); // ds_roll.getColumn(ds_roll.rowposition,"g_Cc_Cd");
        	application.g_Cc_Nm             = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "ccNm"); // ds_roll.getColumn(ds_roll.rowposition,"g_Cc_Nm");
        	application.g_CustCd            = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "custCd"); // ds_roll.getColumn(ds_roll.rowposition,"g_CustCd");
        	application.g_CustNm            = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "custNm"); // ds_roll.getColumn(ds_roll.rowposition,"g_CustNm");
        	application.g_Deptid            = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "deptId"); // ds_roll.getColumn(ds_roll.rowposition,"g_Deptid");
        	application.g_DeptNm            = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "deptNm"); // ds_roll.getColumn(ds_roll.rowposition,"g_DeptNm");
        	application.g_EmpNo             = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "sabun"); // ds_roll.getColumn(ds_roll.rowposition,"g_EmpNo");
        	application.g_Main_Upjang       = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "mainUpjang"); // ds_roll.getColumn(ds_roll.rowposition,"g_Main_Upjang");
        	application.g_Main_UpjangNm     = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "mainUpjangNm"); // ds_roll.getColumn(ds_roll.rowposition,"g_Main_UpjangNm");
        	application.g_Mu_Cd             = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "muCd"); // ds_roll.getColumn(ds_roll.rowposition,"g_Mu_Cd");
        	application.g_Mu_Nm             = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "muNm"); // ds_roll.getColumn(ds_roll.rowposition,"g_Mu_Nm");
        	application.g_Name              = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "nmKor"); // ds_roll.getColumn(ds_roll.rowposition,"g_Name");
        	application.g_OtCustCd          = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "otCustCd"); // ds_roll.getColumn(ds_roll.rowposition,"g_OtCustCd");
        	application.g_OtCustNm          = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "otCustNm"); //ds_roll.getColumn(ds_roll.rowposition,"g_OtCustNm");
        	application.g_Sc_Cd             = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "scCd"); // ds_roll.getColumn(ds_roll.rowposition,"g_Sc_Cd");
        	application.g_Sc_Nm             = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "scNm"); // ds_roll.getColumn(ds_roll.rowposition,"g_Sc_Nm");
        	application.g_Tm_Cd             = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "tmCd"); // ds_roll.getColumn(ds_roll.rowposition,"g_Tm_Cd");
        	application.g_Tm_Nm             = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "tmNm"); // ds_roll.getColumn(ds_roll.rowposition,"g_Tm_Nm");
        	application.g_Upjang            = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "upjang"); // ds_roll.getColumn(ds_roll.rowposition,"g_Upjang");
        	application.g_UpjangGroup       = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "upjangGroup"); // ds_roll.getColumn(ds_roll.rowposition,"g_UpjangGroup");
        	application.g_UpjangNm          = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "upjangNm"); // ds_roll.getColumn(ds_roll.rowposition,"g_UpjangNm");
        	application.g_UserGroup         = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "userGroup"); // ds_roll.getColumn(ds_roll.rowposition,"g_UserGroup");
        	application.g_UserKind          = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "userKind"); // ds_roll.getColumn(ds_roll.rowposition,"g_UserKind");
        	application.g_Simple_Po_Yn      = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "simplePoYn");
        	application.g_Board_Mst		    = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "boardMst");
        	application.g_System_Mst		= application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "systemMst");
        	application.g_CtiUseYn          = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "ctiUseYn"); //CTI 사용여부
        	application.g_CtiUserId         = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "ctiUserId"); //CTI 사용자 ID
        	application.g_PersInfoAgreeYn   = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "persInfoAgreeYn"); // 개인정보 동의여부
        	application.g_PersInfoMask      = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "persInfoMask"); // 개인정보 마스킹 여부
        	application.g_PersInfoProcLevel = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "persInfoProcLevel"); // 개인정보 처리 레벨
        	application.g_UserType          = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "userType"); // 내부.외부구분
        	application.gv_AuthLevels       = application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "authLevels"); // 사용자 권한들(콤마(,)로 구분되어짐.)
        	
        	application.gvLoginYN = "Y";
        	application.gv_ID = this.edtId.text;
        	application.gv_PW = this.edtPwd.value;
        	
            // 자동로그인 체크 시 아이디 저장
        	if ( this.chk_saveID.isChecked() ) {
        		application.gv_autoLogin = "Y";
        		application.goMain.fn_localSave();			
        	}
        	
        	// 아이디 저장 체크 시 아이디 저장
        	if ( this.chk_saveID00.isChecked() ) {			
        		application.gv_saveId = "Y";
        		application.goMain.fn_localSave();		
        	}
        	
        	if ( !this.chk_saveID.isChecked() && !this.chk_saveID00.isChecked())
        	{	
        		application.gv_autoLogin = "N";
        		application.gv_saveId = "N";
        		application.goMain.fn_localSave();
        	}
        	
        	application.goMain.gfn_POP_close(this, "login success");
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
        		// 로그인
                case "login" :
        			
        			// 로그인 후처리
        			this.fn_loginAft(); 
        			
        			// 조회 건수 확인  
                    if (application.gds_userInfo.getRowCount() == 0) 
                    {
                        application.goMain.gfn_Msg("alertLogin", "Information", "해당하는 사용자 정보가 없습니다.", "OK");	//해당하는 사용자 정보가 없습니다.
                        return;
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
        	if (id == "errorId") // 비밀번호 미 입력시
        	{
        		this.edtId.setFocus();
        	}
        	
        	if (id == "errorPw") // 패스워드 미 입력시
        	{
        		this.edtPwd.setFocus();
        	}
        	
        	if (id == "exit") // 메세지 팝업창 닫힘과 동시에 앱 종료시킴
        	{	
        		application.exit();
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
        		case "loginTest":
        			this.cbo_test.set_index(rtn);
        			this.edtId.set_value(this.cbo_test.text);		
        			
        			break;		
        	}
        } 

        /*================================================================================
         * 6. FSP 함수 관련 Script
         *===============================================================================*/

        //안드로이드4.3TODO
        this.staImageLogin_onclick = function(obj,e)
        {
        	this.btnLogin.setFocus();
        	this.btnLogin_onclick(this.btnLogin);
        }

        this.btnLogin00_onclick = function(obj,e)
        {
        	application.goMain.gfn_POP_close(this, "login success");
        }

        this.cbo_test_ondropdown = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_test;
        	arg[1] = "로그인 아이디";
        	arg[2] = "";
        	arg[3] = "cdNm";
        	application.goMain.gfn_POP_create("loginTest", "cmmn::CmmnComboList.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        /*******************************************************************************
        * 기      능   :  키패드 이동
        * 설      명   :  키페드 이동시 다음 탭 오더순으로 가도록 해줌
        ********************************************************************************/
        this.edtId_onkeydown = function(obj,e)
        {
        	if(e.keycode == 13){this.getNextComponent(this.getFocus()).setFocus();}
        }

        this.edtPwd_onkeydown = function(obj,e)
        {
        	if(e.keycode == 13){this.getNextComponent(this.getFocus()).setFocus(); this.btnLogin_onclick();}
        	
        }

        this.edtId_ontextchanged = function(obj,e)
        {   
        	if(!this.gfn_isNull(this.edtId.value))
        	{
        		this.btn_clearId.set_visible(true);
        	}
        	else
        	{
        		this.btn_clearId.set_visible(false);
        	}
        }

        this.edtPwd_ontextchanged = function(obj,e)
        {
        	if(!this.gfn_isNull(this.edtPwd.value))
        	{
        		this.btn_clearPw.set_visible(true);
        	}
        	else
        	{
        		this.btn_clearPw.set_visible(false);
        	}
        }

        this.Static04_onclick = function(obj,e) {
        	//this.fn_loginAdmin();
        }

        this.fn_loginAdmin = function() {
        	
        	if ( application.gv_runMode == "Runtime" ) {
        		
        		var strSvcID    = "login";
        		var strURL      = "sc/scu/userChange/login.xdo";
        		var strInDs     = "";
        		var strOutDs    = "gds_userInfo=gdsUserInfo";
        		var strArg      = "id="+nexacro.wrapQuote(this.edtId.value) + " chgReason=" + nexacro.wrapQuote("admin") + " actSabun=Z1855902 beforeSabun=Z1855902 afterSabun=" + nexacro.wrapQuote(this.edtId.value) ; 
        		var strCallback = "fn_callBack";
        		var bAsync      = true;
        			
        		this.gfn_transaction(this, strSvcID, strURL, strInDs, strOutDs, strArg, strCallback, bAsync);
        	}
        }

        this.sta_join_onclick = function(obj,e) {
        	var arg = new Array();
        	application.goMain.gfn_POP_create("join", "frame::CmmnFrameJoin.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        }

        this.chk_saveID00_onchanged = function(obj,e)
        {
        	this.img_chk.set_visible(e.postvalue == "Y");
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.CmmnFrameLogin_onload, this);
            this.Static02.addEventHandler("onclick", this.Static02_onclick, this);
            this.Static04.addEventHandler("onclick", this.Static04_onclick, this);
            this.edtId.addEventHandler("onkeydown", this.edtId_onkeydown, this);
            this.edtId.addEventHandler("ontextchanged", this.edtId_ontextchanged, this);
            this.btnLogin.addEventHandler("onclick", this.btnLogin_onclick, this);
            this.edtPwd.addEventHandler("onkeydown", this.edtPwd_onkeydown, this);
            this.edtPwd.addEventHandler("ontextchanged", this.edtPwd_ontextchanged, this);
            this.cbo_test.addEventHandler("ondropdown", this.cbo_test_ondropdown, this);
            this.cbo_test.addEventHandler("onitemchanged", this.cbo_test_onitemchanged, this);
            this.chk_saveID00.addEventHandler("onchanged", this.chk_saveID00_onchanged, this);
            this.btn_clearId.addEventHandler("onclick", this.Common_Btn_common_OnClick, this);
            this.btn_clearPw.addEventHandler("onclick", this.Common_Btn_common_OnClick, this);
            this.sta_join.addEventHandler("onclick", this.sta_join_onclick, this);

        };

        this.loadIncludeScript("CmmnFrameLogin.xfdl", true);
        this.loadPreloadList();
       
    };
}
)();
