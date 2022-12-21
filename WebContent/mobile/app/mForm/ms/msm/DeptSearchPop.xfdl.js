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
                this.set_name("DeptSearchPop");
                this.set_titletext("부서검색");
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
            obj._setContents("<ColumnInfo><Column id=\"tmCd\" type=\"STRING\" size=\"256\"/><Column id=\"tmNm\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "420", "458", null, null, this);
            obj.set_taborder("44");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "0", "0", "420", "70", null, null, this);
            obj.set_taborder("46");
            obj.set_cssclass("sta_POP_TitleBg");
            obj.set_text("팀검색");
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

            obj = new Edit("edt_deptNm", "absolute", "132", "80", "173", "47", null, null, this);
            obj.set_taborder("71");
            obj.set_displaynulltext("팀명");
            obj.set_autoselect("true");
            obj.set_imemode("hangul");
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

            obj = new Grid("grd_list", "absolute", "10", "137", "400", "301", null, null, this);
            obj.set_taborder("75");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"131\"/><Column size=\"268\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\" band=\"head\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"Column0\"/><Cell col=\"1\"/><Cell row=\"1\" text=\"팀코드\"/><Cell row=\"1\" col=\"1\" text=\"팀명\"/></Band><Band id=\"body\"><Cell style=\"align:left middle;padding:0 10 0 10;\" text=\"bind:tmCd\"/><Cell col=\"1\" style=\"align:left;padding:0 10 0 10;\" text=\"bind:tmNm\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static18", "absolute", "398", "272", "110", "2", null, null, this);
            obj.set_taborder("76");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static19", "absolute", "513", "258", "349", "30", null, null, this);
            obj.set_taborder("77");
            obj.set_text("Align : left middle / padding : 0 10 0 10");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_deptCd", "absolute", "10", "80", "119", "47", null, null, this);
            obj.set_taborder("78");
            obj.set_displaynulltext("팀코드");
            obj.set_autoselect("true");
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
            		p.set_titletext("부서검색");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("DeptSearchPop.xfdl", "lib::lib_Com.xjs");
        this.registerScript("DeptSearchPop.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		부서 검색
        // [부시스템명]	부서 검색 - 조회
        // [설명]
        // 		부서 검색하기.
        // [작성자명] 		강대성
        // [작성일자]		2014.08.12
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2014.04.01 : 강대성 : 수정이 필요하여 수정함.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"
        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/

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
        	//필수
        	//this.fsp_init();
        	this.arg = application.goMain.gfn_POP_getArg();
        	
        	//this.edt_deptNm.set_value(this.arg[0]);
        	
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
         * 취소버튼클릭
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
        	var arg = new Array();
        	arg[0] = this.ds_grd.getColumn(e.row,"tmCd"); 	//팀코드
        	arg[1] = this.ds_grd.getColumn(e.row,"tmNm"); 	//팀명
        	application.goMain.gfn_POP_close(this, arg);
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
        	var tmCd = this.gfn_transNullToEmpty(this.edt_deptCd.text);
        	var tmNm = this.gfn_transNullToEmpty(this.edt_deptNm.text);
        	var muCd = "";
        	var role = "";
        	
        	if(application.g_AuthLevel == "999" || application.g_AuthLevel == "99")
        	{
        		muCd = "";
        		role = "exception";
        	}
        	else
        	{
        		muCd = application.g_Mu_Cd;
        	}
        	
        	var strSvcID   		 = "deptSearchPop";
        	var strUrl     		 = "ms/msm/deptSearchPop/selectList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "ds_grd=ds_list";
        	var strArguments	 = "deptCd=" + nexacro.wrapQuote(tmCd);
        	   strArguments     += " deptNm=" + nexacro.wrapQuote(tmNm);
        	   strArguments     += " muCd=" + nexacro.wrapQuote(muCd);
        	   strArguments     += " role=" + nexacro.wrapQuote(role);
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);

        	// connect the server 
        	
        }
        /*******************************************************************************
        * 기      능   : 부서명 조회 callback
        ********************************************************************************/
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
        		//상품발주현황조회
                case "deptSearchPop" :
        						
                    // 조회 건수 확인  
                    if (this.ds_grd.getRowCount() == 0) 
                    {
                        application.goMain.gfn_Msg("alertTest", "Information", "조회되는 내용이 없습니다.", "OK");	
                        return;
                    }else{
        				
        				this.fv_totalpageRow = this.ds_grd.getRowCount();	
        				//this.btn_moreView.set_visible(true);
        				//this.btn_moreView.set_text("총건수:"+this.fv_totalpageRow);
        				
                    }
                    
          		break;
            }  
            
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.CmmnDeptSearchPop_onload, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);
            this.btn_search.addEventHandler("onclick", this.btnSearch_onclick, this);
            this.grd_list.addEventHandler("oncellclick", this.grdList_oncellclick, this);
            this.btn_moreView.addEventHandler("onclick", this.div_tab01_btn_moreView_onclick, this);

        };

        this.loadIncludeScript("DeptSearchPop.xfdl", true);

       
    };
}
)();
