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
                this.set_name("CmmnLoginPop");
                this.set_scrollbars("none");
                this.set_titletext("로그인 팝업창");
                this._setFormPosition(0,0,420,432);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_list", this);
            obj.set_preload("true");
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj._setContents("<ColumnInfo><Column id=\"DCSN_CD\" size=\"6\" type=\"STRING\"/><Column id=\"KOR_DEPT_NM\" size=\"4000\" type=\"STRING\"/><Column id=\"APPR_YN\" size=\"5\" type=\"STRING\"/><Column id=\"APPR_DT\" size=\"8\" type=\"STRING\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_cond", this);
            obj.set_preload("true");
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj._setContents("<ColumnInfo><Column id=\"ACNT_UNIT\" size=\"20\" type=\"STRING\"/><Column id=\"ACNT_FG\" size=\"20\" type=\"STRING\"/><Column id=\"DCSN_NO\" size=\"20\" type=\"STRING\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "420", "432", null, null, this);
            obj.set_taborder("0");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("staBtnClose", "absolute", "400", "0", null, "67", "0", null, this);
            obj.set_taborder("6");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "0", "0", null, null, "0", "0", this);
            obj.set_taborder("34");
            obj.set_cssclass("sta_LOGIN_Bg02");
            this.addChild(obj.name, obj);

            obj = new Button("btnLogin", "absolute", "28", "213", null, "80", "32", null, this);
            obj.set_taborder("3");
            obj.set_cssclass("btn_LOGIN_Login");
            this.addChild(obj.name, obj);

            obj = new Edit("edtPwd", "absolute", "28", "149", null, "55", "32", null, this);
            obj.set_taborder("2");
            obj.set_imemode("alpha");
            obj.set_password("true");
            obj.set_displaynulltext("패스워드를 입력하세요");
            obj.set_cssclass("edt_LOGIN_Login");
            this.addChild(obj.name, obj);

            obj = new Edit("edtId", "absolute", "28", "88", null, "55", "32", null, this);
            obj.set_taborder("1");
            obj.set_displaynulltext("ID를 입력하세요");
            obj.set_cssclass("edt_LOGIN_Login");
            obj.set_readonly("true");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "28", "33", "100", "42", null, null, this);
            obj.set_taborder("5");
            obj.set_cssclass("sta_LOGIN_Login");
            this.addChild(obj.name, obj);

            obj = new Static("sta_inform", "absolute", "29", "307", "359", "109", null, null, this);
            obj.set_taborder("4");
            obj.set_text("일정 시간 동안 사용을 하지 않거나, 서버 어플리케이션이 재기동 된 경우 다시 로그인 하셔야 합니다.");
            obj.style.set_color("#ffffffff");
            obj.style.set_align("left middle");
            obj.style.set_font("bold antialias 12 arial");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 420, 432, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_COMP_03");
            		p.set_scrollbars("none");
            		p.set_titletext("로그인 팝업창");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        
        this.loadPreloadList = function()
        {
            this._addPreloadList("data", "", "ds_list");
            this._addPreloadList("data", "", "ds_cond");
        };
        
        // User Script
        this.addIncludeScript("CmmnLoginPop.xfdl", "lib::lib_Com.xjs");
        this.registerScript("CmmnLoginPop.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		로그인팝업
        // [부시스템명]	로그인팝업 - 조회
        // [설명]
        // 		부서 검색하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.05.22
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.05.22 : 강대성 : 로그인팝업 처리.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*======================================================
         전역변수
         ======================================================*/
        var fv_isLogin = false;		//로그인 여부

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
        	this.edtId.set_value(application.gds_userInfo.getColumn(application.gds_userInfo.rowposition, "userid")); 
        	
        	application.goMain.gfn_POP_resize(this);
        }

        /*******************************************************************************
        * 기      능   :  로그인처리
        * 설      명   :  로그인처리
        ********************************************************************************/
        this.btnLogin_onclick = function(obj,e)
        {
        	if(application.gfn_IsNull(this.edtPwd.text)) 
            {
                application.goMain.gfn_Msg("alertTest", "Information", "패스워드를 입력하여 주십시요.", "OK");
                this.edtPwd.setFocus();
                return;
            }
            	
        	// 서비스 연결 됐을때 아래 로직으로..
        	var strSvcID   	     = "loginPop";
            var strUrl     	     = "sc/cmn/login.xdo";
            var strInDataset     = "";
            var strOutDataset    = "";
            var strArguments	 = "id=" + nexacro.wrapQuote(this.edtId.text);
        	   strArguments     += " pwd=" + nexacro.wrapQuote(this.edtPwd.value);
        	var strCallbackFunc  = "fn_callBack";
            var bAsync			 = false;
         
            this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);

        }

        /*==========================================================================
         * 4. Component관련 Script
        *========================================================================*/
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
        		//로그인후
                case "loginPop" :
                
        			fv_isLogin = true;
        			
        			// 조회 건수 확인  
                    if (application.gds_userInfo.getRowCount() == 0) 
                    {
                        application.goMain.gfn_Msg("ALERT_0", "Information", "해당하는 사용자 정보가 없습니다.", "OK");	//해당하는 사용자 정보가 없습니다.
                        return;
                    }
                    else // 조회건수가 1페이지 이상일때
                    {
        				application.goMain.gfn_POP_close(this, "");				
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

        

        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.staBtnClose.addEventHandler("onclick", this.staBtnClose_onclick, this);
            this.btnLogin.addEventHandler("onclick", this.btnLogin_onclick, this);
            this.edtPwd.addEventHandler("onkeydown", this.edtPwd_onkeydown, this);
            this.edtId.addEventHandler("onkeydown", this.edtId_onkeydown, this);

        };

        this.loadIncludeScript("CmmnLoginPop.xfdl", true);
        this.loadPreloadList();
       
    };
}
)();
