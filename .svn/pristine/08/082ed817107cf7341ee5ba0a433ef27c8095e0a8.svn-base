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
                this.set_name("CmmnPushList");
                this.set_titletext("PUSH알림수신리스트");
                this._setFormPosition(0,0,540,760);
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
            obj._setContents("<ColumnInfo><Column id=\"msgId\" type=\"STRING\" size=\"256\"/><Column id=\"userId\" type=\"STRING\" size=\"256\"/><Column id=\"dvicId\" type=\"STRING\" size=\"256\"/><Column id=\"title\" type=\"STRING\" size=\"256\"/><Column id=\"body\" type=\"STRING\" size=\"256\"/><Column id=\"msg\" type=\"STRING\" size=\"256\"/><Column id=\"createTime\" type=\"STRING\" size=\"256\"/><Column id=\"totCnt\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_grdServer", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"msgId\" type=\"STRING\" size=\"256\"/><Column id=\"userId\" type=\"STRING\" size=\"256\"/><Column id=\"dvicId\" type=\"STRING\" size=\"256\"/><Column id=\"title\" type=\"STRING\" size=\"256\"/><Column id=\"body\" type=\"STRING\" size=\"256\"/><Column id=\"msg\" type=\"STRING\" size=\"256\"/><Column id=\"createTime\" type=\"STRING\" size=\"256\"/><Column id=\"totCnt\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Grid("grd_list", "absolute", "0", "60", null, null, "0", "0", this);
            obj.set_cssclass("grd_WF_Default2");
            obj.set_taborder("122");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_autofittype("col");
            obj.set_autosizingtype("row");
            obj.set_extendsizetype("row");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"88\"/><Column size=\"451\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell/><Cell col=\"1\" text=\"Column0\"/></Band><Band id=\"body\"><Cell cssclass=\"CellGrd_WF_LabelIndigo\" text=\"시간\"/><Cell col=\"1\" style=\"align:left middle;padding:0 10 0 10;\" cssclass=\"CellGrd_WF_LabelIndigo\" text=\"bind:createTime\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"1\" style=\"align:left middle;padding:0 5 0 10;background:#edededff;background2:#edededff;selectbackground:#edededff;\" text=\"제목\"/><Cell row=\"1\" col=\"1\" style=\"align:left middle;padding:0 10 0 10;\" text=\"bind:title\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"2\" style=\"align:left middle;padding:0 5 0 10;background:#edededff;background2:#edededff;selectbackground:#edededff;\" text=\"내용\"/><Cell row=\"2\" col=\"1\" style=\"align:left middle;padding:0 10 0 10;\" text=\"bind:body\" wordwrap=\"char\" autosizerow=\"limitmin\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "0", "0", null, "2", "0", null, this);
            obj.set_taborder("123");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);

            obj = new Static("Static32", "absolute", "0", "2", null, "59", "0", null, this);
            obj.set_taborder("124");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_title", "absolute", "10", "8", null, "47", "115", null, this);
            obj.set_taborder("125");
            obj.set_imemode("hangul");
            obj.set_displaynulltext("검색어 검색");
            obj.set_autoselect("true");
            this.addChild(obj.name, obj);

            obj = new Button("btn_search", "absolute", null, "8", "100", "47", "10", null, this);
            obj.set_taborder("126");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Button("btn_moreView", "absolute", "128", null, null, "42", "136", "0", this);
            obj.set_taborder("118");
            obj.set_visible("false");
            obj.style.set_background("darkgray");
            obj.style.set_color("white");
            obj.style.set_opacity("75");
            obj.set_enable("true");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("PUSH알림수신리스트");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("CmmnPushList.xfdl", "lib::lib_Com.xjs");
        this.registerScript("CmmnPushList.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		PUSH알림수신리스트
        // [부시스템명]	PUSH알림수신리스트 - 조회
        // [설명]
        // 		부서 검색하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.05.21
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.05.21 : 강대성 : 수정이 필요하여 수정함.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*======================================================
         전역변수
         ======================================================*/
        this.bbsId = undefined;
        this.fv_pageRow = 15;	// 페이지당 건수
        this.fv_totalpageRow;	// 전체건수
        this.fv_curPageNum = 1;	// 페이지 번호
        this.fv_curPageNumAft = 1 // 조회건수
        this.fv_count = 1; //초기값
        this.userId = undefined;

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

        this.fn_init = function ()
        {
        	this.userId = application.g_userId;	
        }

        
        //게시판 레코드 클릭시 게시판 상세 내용 팝업 창 호출
        this.grd_list_oncellclick = function(obj,e)
        {
        	
        	var arg = new Array();
        	arg[0] = this.ds_grd.getColumn(this.ds_grd.rowposition,"contents");   //상세내용
        	arg[1] = this.ds_grd.getColumn(this.ds_grd.rowposition,"title");      //제목
        	arg[2] = this.ds_grd.getColumn(this.ds_grd.rowposition,"tmNm");       //부서명
        	arg[3] = this.ds_grd.getColumn(this.ds_grd.rowposition,"writeSabun"); //작성자
        	arg[4] = this.ds_grd.getColumn(this.ds_grd.rowposition,"writeTime");  //공지일
        	arg[5] = this.ds_grd.getColumn(this.ds_grd.rowposition,"upjangNm");   //업장명
        	
        	application.goMain.gfn_POP_create("board", "M_MMB::MessageDetailBoardPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        
        /*******************************************************************************
        * 기      능   :  검색
        * 설      명   :  등록
        ********************************************************************************/
        this.btnSearch_onclick = function(obj,e)
        {
        	this.ds_grd.clearData();
        	this.ds_grdServer.clearData();
        	this.fv_curPageNum = 1;	// 페이지 번호
        	this.fv_curPageNumAft = 1 // 조회건수
        	this.fv_count = 1; //초기값
        	
        	this.fn_search();
        }

        this.fn_search = function()
        {
        	//필수항목 
        	//if (this.fn_searchChk()) return;
        	
        	//검색
        	var strSvcID   		 = "search";
        	var strUrl     		 = "ms/cmn/mobileCommon/selectPushList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "ds_grdServer=ds_list";
        	var strArguments	 = "userId=" + nexacro.wrapQuote(this.userId);
        		strArguments	+= " title=" + nexacro.wrapQuote(this.edt_title.text);	// TODO 검색어 검색
        	    strArguments	+= " curPageNum=" + nexacro.wrapQuote(this.fv_curPageNum);	// TODO 현재 페이지번호 추가
        	    strArguments	+= " pageRow=" + nexacro.wrapQuote(this.fv_pageRow);	// TODO 페이지당 건수
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
          	// connect the server 
        	
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
        		//공지사항
                case "search" :
        			// TODO parameter로 전체건수를 받는다.
        			this.fv_totalpageRow = this.ds_grdServer.getColumn(0, "totCnt");
        			
        			 // 조회 건수 확인  
                    if (this.ds_grdServer.getRowCount() == 0) 
                    {
                        application.goMain.gfn_Msg("alertTest", "Information", "조회되는 내용이 없습니다.", "OK");	//조회되는 내용이 없습니다.
                        return;
                    }
                    else if (this.fv_totalpageRow > this.fv_pageRow && this.fv_count == 1)	// 조회건수가 1페이지 이상일때
                    {
        				this.ds_grd.copyData(this.ds_grdServer);
        				
        				// 더보기 버튼 보이기
        				this.btn_moreView.set_visible(true);
        				this.btn_moreView.bringToFront();
        				this.btn_moreView.set_text("더보기("+this.fv_totalpageRow+"/"+this.fv_pageRow+")");
        							
        				this.fv_count = this.fv_count+1;
        				
                    }
                    else if (this.fv_totalpageRow <= this.fv_pageRow)
                    {
        				this.btn_moreView.set_visible(false);
        				this.ds_grd.copyData(this.ds_grdServer);				
                    }
                    
                    // 페이지 번호 2 이상일때 기존 dataset에 건수 추가
                    if (this.fv_curPageNum > this.fv_pageRow)
                    {
        				this.ds_grd.appendData(this.ds_grdServer);
        				this.fv_curPageNumAft = this.ds_grd.getRowCount();
        				this.btn_moreView.set_text("더보기("+this.fv_totalpageRow+"/"+this.fv_curPageNumAft+")");
        				this.ds_grd.set_rowposition(this.fv_curPageNum-this.fv_pageRow+1);
        				this.ds_grd.set_rowposition(this.fv_curPageNum-this.fv_pageRow);
                    }
          			break;
            
            }    
            
        }

        
        // 더보기 버튼 onclick event
        this.btn_moreView_onclick = function(obj,e)
        {
        	if (this.fv_totalpageRow != this.fv_curPageNumAft) {
        		this.fv_curPageNum = this.fv_curPageNum+this.fv_pageRow;
        		this.fn_search();
        	}else{
        		application.goMain.gfn_Msg("alertTest", "Information", "마지막 페이지입니다.", "OK");	//조회되는 내용이 없습니다.
                return;
        	}
        	
        }

        this.grd_list_onslide = function(obj,e)
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

        this.grd_list_onvscroll = function(obj,e)
        {
        	// div안의 스크롤 컨트롤일 경우 btnGoTop 대신 btnGoTopDiv 사용
        	if (e.pos == 0)
        	{
        		this.parent.btnGoTopDiv.set_visible(false);
        		
        		if (this.fv_totalpageRow == this.fv_curPageNumAft) {
        			this.btn_moreView.set_visible(true);
        		}
        	}
        	else
        	{
        		this.parent.btnGoTopDiv.set_visible(true);
        		
        		if (this.fv_totalpageRow == this.fv_curPageNumAft) {
        			this.btn_moreView.set_visible(false);
        		}
        	}
        }

        // div안의 스크롤바 조정일 경우 아래 함수 추가
        this.fn_setDivScrollbar = function()
        {
        	// 해당 div로 바꿔준다.
        	this.grd_list.vscrollbar.set_pos(0);
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.grd_list.addEventHandler("onvscroll", this.grd_list_onvscroll, this);
            this.grd_list.addEventHandler("onslide", this.grd_list_onslide, this);
            this.btn_search.addEventHandler("onclick", this.btnSearch_onclick, this);
            this.btn_moreView.addEventHandler("onclick", this.btn_moreView_onclick, this);

        };

        this.loadIncludeScript("CmmnPushList.xfdl", true);

       
    };
}
)();
