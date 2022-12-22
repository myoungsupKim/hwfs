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
                this.set_name("WorkplaceSearchPop");
                this.set_titletext("사업장검색");
                this._setFormPosition(0,0,420,458);
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
            obj._setContents("<ColumnInfo><Column id=\"upjangCode\" type=\"STRING\" size=\"256\"/><Column id=\"upjangName\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_search", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"upjangCode\" type=\"STRING\" size=\"256\"/><Column id=\"upjangName\" type=\"STRING\" size=\"256\"/><Column id=\"roleSetId\" type=\"STRING\" size=\"256\"/><Column id=\"authLevel\" type=\"STRING\" size=\"256\"/><Column id=\"sabun\" type=\"STRING\" size=\"256\"/><Column id=\"tmCd\" type=\"STRING\" size=\"256\"/><Column id=\"muCd\" type=\"STRING\" size=\"256\"/><Column id=\"applyAuthKind\" type=\"STRING\" size=\"256\"/><Column id=\"query\" type=\"STRING\" size=\"256\"/><Column id=\"isMainUpjang\" type=\"STRING\" size=\"256\"/><Column id=\"isSubUpjang\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row/></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_custList", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"CUSTCD\" type=\"STRING\" size=\"256\"/><Column id=\"CUSTNM\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_cond", this);
            obj._setContents("<ColumnInfo><Column id=\"CUSTCD\" size=\"255\" type=\"STRING\"/><Column id=\"CUSTNM\" size=\"255\" type=\"STRING\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "420", "458", null, null, this);
            obj.set_taborder("44");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list", "absolute", "10", "137", "400", "301", null, null, this);
            obj.set_taborder("80");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_extendsizetype("row");
            obj.set_autosizingtype("row");
            obj.set_nodataimage("URL('theme://Image/grd_WF_NoDataImg.png')");
            obj.style.set_background("transparent");
            obj.style.set_border("1 solid #c3c3c3ff");
            obj.style.set_color("#555555ff");
            obj.style.set_font("bold antialias 17 Droid Sans");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"131\"/><Column size=\"268\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\" band=\"head\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"Column0\"/><Cell col=\"1\"/><Cell row=\"1\" text=\"업장코드\"/><Cell row=\"1\" col=\"1\" text=\"업장명\"/></Band><Band id=\"body\"><Cell edittype=\"none\" style=\"align:center middle;padding:0 10 0 10;\" text=\"bind:upjangCode\" editlimitbymask=\"decimal\" autosizerow=\"limitmin\"/><Cell col=\"1\" style=\"align:left;\" text=\"bind:upjangName\" wordwrap=\"char\" autosizerow=\"limitmin\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("sta_upjang", "absolute", "0", "0", "420", "70", null, null, this);
            obj.set_taborder("46");
            obj.set_cssclass("sta_POP_TitleBg");
            obj.set_text("사업장검색");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "70", "420", "10", null, null, this);
            obj.set_taborder("47");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "410", "80", "10", "358", null, null, this);
            obj.set_taborder("48");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "80", "10", "358", null, null, this);
            obj.set_taborder("50");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Button("btnClose", "absolute", "350", "0", "70", "70", null, null, this);
            obj.set_taborder("45");
            obj.set_cssclass("btn_POP_XBtn");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "0", "438", "420", "20", null, null, this);
            obj.set_taborder("54");
            obj.set_text("h20");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_upjangNm", "absolute", "132", "80", "173", "47", null, null, this);
            obj.set_taborder("71");
            obj.set_displaynulltext("업장명");
            obj.set_imemode("hangul");
            obj.set_autoselect("true");
            this.addChild(obj.name, obj);

            obj = new Button("btn_search", "absolute", "310", "80", "100", "47", null, null, this);
            obj.set_taborder("72");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "305", "86", "5", "30", null, null, this);
            obj.set_taborder("73");
            obj.set_text("h05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "0", "127", "420", "10", null, null, this);
            obj.set_taborder("74");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_upjangCd", "absolute", "10", "80", "119", "47", null, null, this);
            obj.set_taborder("78");
            obj.set_displaynulltext("업장코드");
            obj.set_autoselect("true");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_listCust", "absolute", "10", "225", "400", "213", null, null, this);
            obj.set_taborder("81");
            obj.set_binddataset("ds_custList");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_extendsizetype("row");
            obj.set_autosizingtype("row");
            obj.set_nodataimage("URL('theme://Image/grd_WF_NoDataImg.png')");
            obj.style.set_background("transparent");
            obj.style.set_border("1 solid #c3c3c3ff");
            obj.style.set_color("#555555ff");
            obj.style.set_font("bold antialias 17 Droid Sans");
            obj.set_visible("false");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"131\"/><Column size=\"268\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\" band=\"head\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"Column0\"/><Cell col=\"1\"/><Cell row=\"1\" text=\"업체코드\"/><Cell row=\"1\" col=\"1\" text=\"업체명\"/></Band><Band id=\"body\"><Cell edittype=\"none\" style=\"align:center middle;padding:0 10 0 10;\" text=\"bind:CUSTCD\" editlimitbymask=\"decimal\" autosizerow=\"limitmin\"/><Cell col=\"1\" style=\"align:left;\" text=\"bind:CUSTNM\" wordwrap=\"char\" autosizerow=\"limitmin\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Button("btn_moreView", "absolute", "128", null, null, "42", "136", "21", this);
            obj.set_taborder("79");
            obj.set_visible("false");
            obj.style.set_background("darkgray");
            obj.style.set_color("white");
            obj.style.set_opacity("75");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 420, 458, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("사업장검색");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information
            obj = new BindItem("item0","edt_upjangCd","value","ds_search","upjangCode");
            this.addChild(obj.name, obj);
            obj.bind();
            obj = new BindItem("item1","edt_upjangNm","value","ds_search","upjangName");
            this.addChild(obj.name, obj);
            obj.bind();

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("WorkplaceSearchPop2.xfdl", "lib::lib_Com.xjs");
        this.registerScript("WorkplaceSearchPop2.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		사업장 검색
        // [부시스템명]	사업장 검색 - 조회
        // [설명]		    사업장 검색하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.02.02
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.02 : 강대성 : 수정이 필요하여 수정함.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"
        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/
        this.fv_totalpageRow;	// 전체건수
        this.upjangGubun = undefined;
        this.upjang = undefined;
        this.upjangNm = undefined;
        this.mainUpjangCd = undefined;

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
        this.CmmnDeptSearchPop_onload = function(obj,e)
        {
        	this.fsp_init();
        	//필수
        	//this.fsp_init();
        	this.arg = application.goMain.gfn_POP_getArg();
        	
        	if(this.arg[2] == "CUST")
        	{
        		this.grd_listCust.set_visible(true);
        		this.grd_list.set_visible(false);
        		this.grd_listCust.set_top(137)
        		this.grd_listCust.set_height(301)
        		this.sta_upjang.set_text("업체검색");
        		this.edt_upjangCd.set_displaynulltext("업체코드");
        		this.edt_upjangNm.set_displaynulltext("업체명");
        	}
        	else
        	{
        		this.grd_listCust.set_visible(false);
        		this.grd_list.set_visible(true);
        	}
        	
        	//this.edt_upjangNm.set_value(this.arg[0]);
        	this.upjang = this.arg[1];
        	this.upjangGubun = this.arg[2];
        	this.mainUpjangCd = this.arg[3];
        	this.ds_search.setColumn(0,"roleSetId", this.arg[4]);
        	this.ds_search.setColumn(0,"authLevel", this.arg[5]);
        	this.ds_search.setColumn(0,"sabun", this.arg[6]);
        	this.ds_search.setColumn(0,"tmCd", this.arg[7]);
        	this.ds_search.setColumn(0,"muCd", this.arg[8]);
        	this.ds_search.setColumn(0,"applyAuthKind", this.arg[9]);	
        	this.ds_search.setColumn(0,"query", this.arg[10]);
        	this.ds_search.setColumn(0,"isMainUpjang", this.arg[11]);	
        	this.ds_search.setColumn(0,"isSubUpjang", this.arg[12]);	
        	
        	if(this.gfn_isNull(this.arg[0]))
        	{
        		this.upjang = "";
        	}	
        	
        	application.goMain.gfn_POP_resize(this);
        }

        /*==========================================================================
         * 3. DataSet관련 Script
        *========================================================================*/
        /** 
         * 테이터셋셋팅
         * @param  
        	value  : 셋팅값
         * @return : 없음
         */

        /*==========================================================================
         * 4. Component관련 Script
        *========================================================================*/

        /** 
         * 닫기버튼클릭
         * @param  
        	obj, e
         * @return : 없음
         */
        this.btnClose_onclick = function(obj,e)
        {
        	application.goMain.gfn_POP_close(this, "CLOSEONLY");
        }

        this.staBtnClose_onclick = function(obj,e)
        {
        	application.goMain.gfn_POP_close(this, "CLOSEONLY");
        }

        
        /** 
         * 그리드 셀클릭
         * @param  
        	obj, e
         * @return : 없음
         */
        this.grdList_oncellclick = function(obj,e)
        {
        	// Global Value 설정(기존 사용 화면에서 사용으로 기능 유지)
        	var nRow = this.ds_grd.rowposition;
        	var arg = new Array();
        	
        	if(application.gds_upjangList.getRowCount() > 1 && !(this.fn_masterRole()))
        	{	
        		if(application.g_Mu_Cd != "2004")
        		{
        			application.goMain.gfn_Msg("upjangChange", "알림", "업장 변경 하시겠습니까?!", "YN", true, this);			
        		}
        		else
        		{
        			arg[0] = this.ds_grd.getColumn(e.row,"upjangCode"); 	//업장코드
        			arg[1] = this.ds_grd.getColumn(e.row,"upjangName"); 	//업장명
        			application.goMain.gfn_POP_close(this, arg);
        		}
        		
        		
        	}
        	else
        	{		
        		if(this.upjangGubun == "CUST")
        		{
        			arg[0] = this.ds_custList.getColumn(e.row,"CUSTCD"); 	//업체코드
        			arg[1] = this.ds_custList.getColumn(e.row,"CUSTNM"); 	//업체명
        			application.goMain.gfn_POP_close(this, arg);
        		}
        		else
        		{	
        			arg[0] = this.ds_grd.getColumn(e.row,"upjangCode"); 	//업장코드
        			arg[1] = this.ds_grd.getColumn(e.row,"upjangName"); 	//업장명
        			application.goMain.gfn_POP_close(this, arg);
        		}		
        	}	
        	
        }
        /*================================================================================
         * 5. UserFunction관련 Script
         *===============================================================================*/
        /** 
         * 사용자정의 함수
         * @param  : 없음
         * @return : true, false
         */

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
        	if(!this.gfn_isNull(this.edt_upjangCd.value))
        	{
        		this.upjang = this.edt_upjangCd.value;
        	}
        	
        	this.upjangNm = this.edt_upjangNm.value;
        		
        	if(this.upjangGubun == "FMS" || this.upjangGubun == "FMS2"){
        		
        		var strSvcID   		 = "workplaceSearchPop";
        		var strUrl     		 = "ms/mlm/selectList.xdo";
        		var strInDataset     = "";
        		var strOutDataset    = "ds_grd=ds_list";
        		var strArguments	 = "upjangCd=" + nexacro.wrapQuote(this.gfn_transNullToEmpty(this.upjang));
        		   strArguments     += " upjangNm=" + nexacro.wrapQuote(this.gfn_transNullToEmpty(this.upjangNm));
        		   strArguments     += " upjangGubun=" + nexacro.wrapQuote(this.gfn_transNullToEmpty(this.upjangGubun));
        		   strArguments     += " mainUpjang=" + nexacro.wrapQuote(this.gfn_transNullToEmpty(this.mainUpjangCd));
        		   strArguments     += " isSikJaeSales=" + "Y";
        		var strCallbackFunc	 = "fn_callBack";
        		var bAsync			 = true;
        		
        		this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
        	
        		}
        		else if(this.upjangGubun == "CUST")
        		{
        			this.ds_cond.clearData();
        			this.ds_cond.addRow();

        			if( (this.gfn_Length(this.gfn_Trim(this.edt_upjangCd.value))==0 || this.gfn_Trim(this.edt_upjangCd.value)==null) &&
        				(this.gfn_Length(this.gfn_Trim(this.edt_upjangNm.value))==0 || this.gfn_Trim(this.edt_upjangNm.value)==null)	)
        			{
        				this.ds_cond.setColumn(0, "CUSTCD", "");
        				this.ds_cond.setColumn(0, "CUSTNM", "");		
        			}
        			else
        			{
        				this.ds_cond.setColumn(0,"CUSTCD", this.gfn_Trim(this.edt_upjangCd.value));
        				this.ds_cond.setColumn(0,"CUSTNM", this.gfn_Trim(this.edt_upjangNm.value));
        			}

        			this.fsp_clear();
        			this.ds_custList.clearData();
        			this.fsp_addSearch("fs/fsc:FSC00311P_S001", false);
        			this.fsp_callService(this, "", "", "ds_cond=ds_cond", "ds_custList=ds_list", "", "fn_callBackSearch");	
        		}
        		else
        		{
        		
        			var strSvcID   		 = "workplaceSearchPop";
        			var strUrl     		 = "sc/cmn/upjangSearch/selectList.xdo";
        			var strInDataset     = "ds_search=ds_search:A";
        			var strOutDataset    = "ds_grd=ds_list";
        			var strArguments	 = "";
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
        		//업장조회
                case "workplaceSearchPop" :
        						
                    // 조회 건수 확인  
                    if (this.ds_grd.getRowCount() == 0) 
                    {
                        application.goMain.gfn_Msg("alertTest", "Information", "조회되는 내용이 없습니다.", "OK");	//조회되는 내용이 없습니다.
                        return;
                    }else{				
        				
                    }
                    
        			break;
          		//복수업장조회
                case "dualUpjang" :
        						
                    // 조회 건수 확인  
                    if (this.ds_grd.getRowCount() == 0) 
                    {
                        application.goMain.gfn_Msg("alertTest", "Information", "조회되는 내용이 없습니다.", "OK");	//조회되는 내용이 없습니다.
                        return;
                    }else{				
        				
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
        	if (id == "upjangChange") // 조회 시 오류
        	{
        		if (rtn == "Y") 
        		{
        			// Global Value 설정(기존 사용 화면에서 사용으로 기능 유지)
        			var nRow = this.ds_grd.rowposition;
        	
        			application.g_Cc_Cd         = this.ds_grd.getColumn(nRow,"ccCd");
        			application.g_Cc_Nm         = this.ds_grd.getColumn(nRow,"ccNm");
        			application.g_Deptid        = this.ds_grd.getColumn(nRow,"ccCd");
        			application.g_DeptNm        = this.ds_grd.getColumn(nRow,"ccNm");
        			application.g_Main_Upjang   = this.ds_grd.getColumn(nRow,"mainUpjang");
        			application.g_Main_UpjangNm = this.ds_grd.getColumn(nRow,"mainUpjangNm");
        			application.g_Mu_Cd         = this.ds_grd.getColumn(nRow,"muCd");
        			application.g_Mu_Nm         = this.ds_grd.getColumn(nRow,"muNm");
        			application.g_Sc_Cd         = this.ds_grd.getColumn(nRow,"scCd");
        			application.g_Sc_Nm         = this.ds_grd.getColumn(nRow,"scNm");
        			application.g_Tm_Cd         = this.ds_grd.getColumn(nRow,"tmCd");
        			application.g_Tm_Nm         = this.ds_grd.getColumn(nRow,"tmNm");
        			application.g_Upjang        = this.ds_grd.getColumn(nRow,"upjangCode");
        			application.g_UpjangGroup   = this.ds_grd.getColumn(nRow,"upjangGroup");
        			application.g_UpjangNm      = this.ds_grd.getColumn(nRow,"upjangName");	
        			
        			var arg = new Array();
        			
        			arg[0] = this.ds_grd.getColumn(nRow,"upjangCode"); 	//업장코드
        			arg[1] = this.ds_grd.getColumn(nRow,"upjangName"); 	//업장명
        			
        			application.goMain.gfn_POP_close(this, arg);
        		}
        		else
        		{
        			return;
        		}
        	}
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.CmmnDeptSearchPop_onload, this);
            this.grd_list.addEventHandler("oncellclick", this.grdList_oncellclick, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);
            this.btn_search.addEventHandler("onclick", this.btnSearch_onclick, this);
            this.grd_listCust.addEventHandler("oncellclick", this.grdList_oncellclick, this);
            this.btn_moreView.addEventHandler("onclick", this.div_tab01_btn_moreView_onclick, this);

        };

        this.loadIncludeScript("WorkplaceSearchPop2.xfdl", true);

       
    };
}
)();
