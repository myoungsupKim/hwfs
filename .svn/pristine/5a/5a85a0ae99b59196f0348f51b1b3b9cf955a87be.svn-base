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
                this.set_name("CmmnFrameJoin");
                this.set_titletext("회원가입");
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
            obj._setContents("<ColumnInfo><Column id=\"ID\" size=\"255\" type=\"STRING\"/><Column id=\"PWD\" size=\"255\" type=\"STRING\"/><Column id=\"NAME\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row/></Rows>");
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

            obj = new Button("btnJoin", "absolute", "30", "661", null, "80", "30", null, this);
            obj.set_taborder("2");
            obj.set_cssclass("btn_LOGIN_Login");
            obj.set_text("회원가입");
            obj.style.set_background("#47475aff center middle");
            obj.style.set_color("#ffffffff");
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

            obj = new Edit("edtName", "absolute", "30", "578", null, "55", "30", null, this);
            obj.set_taborder("28");
            obj.set_imemode("none");
            obj.set_displaynulltext("성명을 입력하세요");
            obj.set_cssclass("edt_LOGIN_Login");
            this.addChild(obj.name, obj);

            obj = new Button("btnClose", "absolute", "30", "749", null, "80", "30", null, this);
            obj.set_taborder("29");
            obj.set_text("닫기");
            obj.set_cssclass("btn_LOGIN_Login");
            obj.style.set_background("#47475aff center middle");
            obj.style.set_color("#ffffffff");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 923, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frameLogin");
            		p.set_titletext("회원가입");
            		p.set_scrollbars("autovert");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information
            obj = new BindItem("item0","edtId","value","ds_cond","ID");
            this.addChild(obj.name, obj);
            obj.bind();
            obj = new BindItem("item1","edtPwd","value","ds_cond","PWD");
            this.addChild(obj.name, obj);
            obj.bind();
            obj = new BindItem("item2","edtName","value","ds_cond","NAME");
            this.addChild(obj.name, obj);
            obj.bind();

            
            // Remove Reference
            obj = null;
        };
        
        this.loadPreloadList = function()
        {
            this._addPreloadList("data", "", "ds_cond");
        };
        
        // User Script
        this.addIncludeScript("CmmnFrameJoin.xfdl", "lib::lib_Com.xjs");
        this.registerScript("CmmnFrameJoin.xfdl", function(exports) {
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        this.CmmnFrameLogin_onload = function(obj,e) {
        	this.fn_init();
        }

        this.fn_init = function () { 
        	application.goMain.gfn_POP_resize(this);
        }

        //버튼 클릭시(공통)
        this.Common_Btn_common_OnClick = function (obj,e) {
        	switch ( obj.name )	{
        		case "btn_clearId":
        			this.edtId.set_value("");
        			this.btn_clearId.set_visible(false);
        			this.edtId.setFocus()
        			break;
        		case "btn_clearPw":
        			this.edtPwd.set_value("");
        			this.btn_clearPw.set_visible(false);
        			this.edtPwd.setFocus()
        			break;		
        	}
        }

        this.fn_join = function () {
        	if( application.gfn_IsNull(this.edtId.text) ) {
                application.goMain.gfn_Msg("errorId", "Information", "사용자ID를 입력하여 주십시요.", "OK", true, this);
                return;
            }
             
            if( application.gfn_IsNull(this.edtPwd.text) ) {
                application.goMain.gfn_Msg("errorPw", "Information", "패스워드를 입력하여 주십시요.", "OK", true, this);
                return;
            }
            
            if( application.gfn_IsNull(this.edtName.text) ) {
                application.goMain.gfn_Msg("errorNm", "Information", "패스워드를 입력하여 주십시요.", "OK", true, this);
                return;
            }
            
            var strSvcID   	  = "join";
            var strUrl     	  = "hwfs_svc/fm/fmp/FMP99999E_T001.jsp";
            var strInDataset     = "ds_cond=ds_cond";
            var strOutDataset    = "";
            var strArguments	 = "";
            var strCallbackFunc  = "fn_callBack";
            var bAsync			 = false;
             
            this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
        }

        	
        this.fn_callBack = function (strSvcID,nErrorCode,strErrorMsg) {	
        	
        	if ( nErrorCode < 0 ) {
        		application.goMain.gfn_Msg("OK", "알림", strErrorMsg.split(":")[1], "OK", "OK");
        		return;
        	}
        	
        	switch ( strSvcID ) {
        		case "join" :
        		    application.goMain.gfn_Msg("success", "Information", "가입이 완료됐습니다.", "OK", true, this);
        		break;
            }
        } 

        this.msg_callback = function (id,rtn)
        { 
        	if (id == "errorId") {
        		this.edtId.setFocus();
        	}
        	
        	if (id == "errorPw") {
        		this.edtPwd.setFocus();
        	}
        	
        	if (id == "errorNm") {
        		this.edtName.setFocus();
        	}
        	
        	if (id == "success") {
        		var arg = new Array();
        		application.goMain.gfn_POP_close(this, arg);
        	}
        	
        	if (id == "exit") {	
        		application.exit();
        	}
        	
        }

        this.btnJoin_onclick = function(obj,e) {
        	this.fn_join();
        }

        this.btnClose_onclick = function(obj,e) {
        	var arg = new Array();
        		application.goMain.gfn_POP_close(this, arg);
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
            this.btnJoin.addEventHandler("onclick", this.btnJoin_onclick, this);
            this.edtPwd.addEventHandler("onkeydown", this.edtPwd_onkeydown, this);
            this.edtPwd.addEventHandler("ontextchanged", this.edtPwd_ontextchanged, this);
            this.cbo_test.addEventHandler("ondropdown", this.cbo_test_ondropdown, this);
            this.cbo_test.addEventHandler("onitemchanged", this.cbo_test_onitemchanged, this);
            this.btn_clearId.addEventHandler("onclick", this.Common_Btn_common_OnClick, this);
            this.btn_clearPw.addEventHandler("onclick", this.Common_Btn_common_OnClick, this);
            this.edtName.addEventHandler("onkeydown", this.edtPwd_onkeydown, this);
            this.edtName.addEventHandler("ontextchanged", this.edtPwd_ontextchanged, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);

        };

        this.loadIncludeScript("CmmnFrameJoin.xfdl", true);
        this.loadPreloadList();
       
    };
}
)();
