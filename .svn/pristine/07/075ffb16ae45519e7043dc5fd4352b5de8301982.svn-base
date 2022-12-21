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
                this.set_name("PrNumSearchPop");
                this.set_titletext("신청번호검색");
                this._setFormPosition(0,0,420,458);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_master", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"PR_NUM\" type=\"STRING\" size=\"256\"/><Column id=\"CUSTCD\" type=\"STRING\" size=\"256\"/><Column id=\"CUSTNM\" type=\"STRING\" size=\"256\"/><Column id=\"PR_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"CC_NM\" type=\"STRING\" size=\"256\"/><Column id=\"SUBINV_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"SUBINV_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_TITLE\" type=\"STRING\" size=\"256\"/><Column id=\"TYPE_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"AMT\" type=\"STRING\" size=\"256\"/><Column id=\"VAT\" type=\"STRING\" size=\"256\"/><Column id=\"TOT\" type=\"STRING\" size=\"256\"/><Column id=\"CODE_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"LINE_STATUS\" type=\"STRING\" size=\"256\"/><Column id=\"PR_SABUN\" type=\"STRING\" size=\"256\"/><Column id=\"PR_APPROVE_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"PO_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"NEED_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"PR_DEPT_ID\" type=\"STRING\" size=\"256\"/><Column id=\"RC_UPJANG\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"PR_NUM\">20150317-57939</Col><Col id=\"NEED_DATE\">20150319</Col><Col id=\"PR_DATE\">20150317</Col></Row></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_condi", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"MU_CD\" type=\"STRING\" size=\"256\"/><Column id=\"TM_CD\" type=\"STRING\" size=\"256\"/><Column id=\"DATE_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"DT_FR\" type=\"STRING\" size=\"256\"/><Column id=\"DT_TO\" type=\"STRING\" size=\"256\"/><Column id=\"PO_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"PR_UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"RC_UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"PR_SABUN\" type=\"STRING\" size=\"256\"/><Column id=\"GROUP_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"CHK_CUST\" type=\"STRING\" size=\"256\"/><Column id=\"CHK_DEPT\" type=\"STRING\" size=\"256\"/><Column id=\"CHK_STATUS\" type=\"STRING\" size=\"256\"/><Column id=\"LINE_STATUS\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "420", "458", null, null, this);
            obj.set_taborder("44");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "0", "0", "420", "70", null, null, this);
            obj.set_taborder("46");
            obj.set_cssclass("sta_POP_TitleBg");
            obj.set_text("신청번호");
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

            obj = new Grid("grd_list", "absolute", "10", "78", "400", "360", null, null, this);
            obj.set_taborder("75");
            obj.set_binddataset("ds_master");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"131\"/><Column size=\"268\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\" band=\"head\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"Column0\"/><Cell col=\"1\"/><Cell row=\"1\" text=\"신청일자\"/><Cell row=\"1\" col=\"1\" text=\"신청번호\"/></Band><Band id=\"body\"><Cell style=\"align:left middle;padding:0 10 0 10;\" text=\"bind:PR_DATE\"/><Cell col=\"1\" style=\"align:left;padding:0 10 0 10;\" text=\"bind:PR_NUM\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 420, 458, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("신청번호검색");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("PrNumSearchPop.xfdl", "lib::lib_Com.xjs");
        this.registerScript("PrNumSearchPop.xfdl", function(exports) {
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
        	this.fsp_init();
        	
        	this.arg = application.goMain.gfn_POP_getArg();
        	
        	// 입력 데이터셋 셋팅
        	var nRow = this.ds_condi.addRow();
        	this.ds_condi.setColumn(nRow, "RC_UPJANG"	  , this.arg[0]);
        	this.ds_condi.setColumn(nRow, "PR_UPJANG"     , this.arg[1]);
        	this.ds_condi.setColumn(nRow, "PR_SABUN"	  , this.arg[2]);
        	this.ds_condi.setColumn(nRow, "GROUP_CODE"	  , this.arg[3]);
        	this.ds_condi.setColumn(nRow, "DT_FR"		  , this.arg[4]);
        	this.ds_condi.setColumn(nRow, "DT_TO"     	  , this.arg[4]);
        	this.ds_condi.setColumn(nRow, "PO_TYPE"  	  , this.arg[5]);
        	this.ds_condi.setColumn(nRow, "MU_CD"    	  , this.arg[6]);
        	
        	this.ds_condi.setColumn(nRow, "DATE_TYPE"     , "1");
        	this.ds_condi.setColumn(nRow, "CHK_CUST"      , "N");
        	this.ds_condi.setColumn(nRow, "CHK_DEPT"      , "N");
        	this.ds_condi.setColumn(nRow, "CHK_STATUS"    , "N");

        	//this.fn_search();
        	
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
        	arg[0] = this.ds_master.getColumn(e.row,"PR_DATE");   //신청일자
        	arg[1] = this.ds_master.getColumn(e.row,"PR_NUM"); 	  //신청번호
        	arg[2] = this.ds_master.getColumn(e.row,"NEED_DATE"); //입고일자
        	
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
        	var sSvcID;			// 서비스 ID
        	var sUrl;			// jsp 경로
        	var sInDs;			// 입력 데이터셋
        	var sOutDs;			// 출력 데이터셋
        	var sArg;			// 추가 파라미터
        	var sCallFunc;		// 콜백함수명
        	
        	this.fsp_clear();	// Action 호출 정보 초기화하기	
        	
        	sSvcID		= "SEARCH";
        	sUrl		= "U_svc::" + "fs/fsp/FSP00030E_T001.jsp";
        	sInDs		= "ds_condi=ds_condi";
        	sOutDs		= "ds_master=ds_master";
        	sCallFunc 	= "fn_transation_callback";
        	
        	// 데이터셋 초기화
        	this.ds_master.clearData();
        		
        	// 트랜잭션
        	this.jsp_transaction(this, sSvcID, sUrl, sInDs, sOutDs, sArg, sCallFunc, true, false, false);
        }
        /*******************************************************************************
        * 기      능   : 부서명 조회 callback
        ********************************************************************************/
        /*----------------------------------------------------------------------------------------------
         * 설명      : 트랜잭션 콜백 함수 (필수)
         *---------------------------------------------------------------------------------------------*/
        this.fn_transation_callback = function (sSvcID,nErrorCode,sErrorMag)
        {	
        	// 에러시 gfn_callBack에서 메시지 제공, 화면별 특정 에러 발생시에만 사용하세요.
        	if (nErrorCode < 0) 
        	{
        		return;
        	}
        	
            switch(sSvcID)
            {		
        		//신청번호조회
                case "SEARCH" :
        						
                    // 조회 건수 확인  
                    if (this.ds_master.getRowCount() == 0) 
                    {
                        application.goMain.gfn_Msg("alertTest", "Information", "조회되는 내용이 없습니다.", "OK");	//조회되는 내용이 없습니다.
                        return;
                    }else{
        				
        				
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
            this.grd_list.addEventHandler("oncellclick", this.grdList_oncellclick, this);

        };

        this.loadIncludeScript("PrNumSearchPop.xfdl", true);

       
    };
}
)();
