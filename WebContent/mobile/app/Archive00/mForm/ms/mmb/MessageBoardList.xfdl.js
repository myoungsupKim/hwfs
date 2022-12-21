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
                this.set_name("MessageBoardList");
                this.set_titletext("공지사항목록");
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
            obj._setContents("<ColumnInfo><Column id=\"conId\" type=\"STRING\" size=\"256\"/><Column id=\"bbsId\" type=\"STRING\" size=\"256\"/><Column id=\"title\" type=\"STRING\" size=\"256\"/><Column id=\"upjang\" type=\"STRING\" size=\"256\"/><Column id=\"upjangNm\" type=\"STRING\" size=\"256\"/><Column id=\"tmNm\" type=\"STRING\" size=\"256\"/><Column id=\"writeSabun\" type=\"STRING\" size=\"256\"/><Column id=\"writeTime\" type=\"STRING\" size=\"256\"/><Column id=\"contents\" type=\"STRING\" size=\"256\"/><Column id=\"attr10\" type=\"STRING\" size=\"256\"/><Column id=\"noticeYn\" type=\"STRING\" size=\"256\"/><Column id=\"userReadYn\" type=\"STRING\" size=\"256\"/><Column id=\"totCnt\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row/></Rows>");
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
            obj._setContents("<ColumnInfo><Column id=\"conId\" type=\"STRING\" size=\"256\"/><Column id=\"bbsId\" type=\"STRING\" size=\"256\"/><Column id=\"title\" type=\"STRING\" size=\"256\"/><Column id=\"upjang\" type=\"STRING\" size=\"256\"/><Column id=\"upjangNm\" type=\"STRING\" size=\"256\"/><Column id=\"tmNm\" type=\"STRING\" size=\"256\"/><Column id=\"writeSabun\" type=\"STRING\" size=\"256\"/><Column id=\"writeTime\" type=\"STRING\" size=\"256\"/><Column id=\"contents\" type=\"STRING\" size=\"256\"/><Column id=\"attr10\" type=\"STRING\" size=\"256\"/><Column id=\"noticeYn\" type=\"STRING\" size=\"256\"/><Column id=\"totCnt\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row/></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Button("btn_moreView", "absolute", "128", null, null, "42", "136", "0", this);
            obj.set_taborder("118");
            obj.set_visible("false");
            obj.style.set_background("darkgray");
            obj.style.set_color("white");
            obj.style.set_opacity("75");
            this.addChild(obj.name, obj);

            obj = new Static("sta_div", "absolute", "0", "0", null, "59", "0", null, this);
            obj.set_taborder("119");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_value", "absolute", "10", "6", null, "47", "115", null, this);
            obj.set_taborder("120");
            obj.set_imemode("hangul");
            obj.set_displaynulltext("검색어 검색");
            obj.set_autoselect("true");
            this.addChild(obj.name, obj);

            obj = new Button("btn_search", "absolute", null, "6", "100", "47", "10", null, this);
            obj.set_taborder("121");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list", "absolute", "0", "55", null, null, "0", "0", this);
            obj.set_cssclass("grd_WF_Default2");
            obj.set_taborder("122");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_autofittype("col");
            obj.set_autosizingtype("row");
            obj.set_extendsizetype("row");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"60\"/><Column size=\"480\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell/><Cell col=\"1\" text=\"Column0\"/></Band><Band id=\"body\"><Cell displaytype=\"expr:noticeYn == &quot;Y&quot;?&quot;button&quot;:&quot;normal&quot;\" style=\"padding:5 10 5 10;controlbackground:URL('HWImage::notice.png') stretch center middle;controlborder:0 solid white ;\"/><Cell col=\"1\" displaytype=\"normal\" style=\"padding:0 10 0 10;color:EXPR(userReadYn == &quot;Y&quot;?&quot;gray&quot;:&quot;&quot;);color2:EXPR(userReadYn == &quot;Y&quot;?&quot;gray&quot;:&quot;&quot;);font:EXPR(userReadYn == &quot;Y&quot;?&quot;14 arial&quot;:&quot;&quot;);selectcolor:EXPR(userReadYn == &quot;Y&quot;?&quot;gray&quot;:&quot;&quot;);selectfont:EXPR(userReadYn == &quot;Y&quot;?&quot;14 arial&quot;:&quot;&quot;);\" text=\"bind:title\" wordwrap=\"char\" autosizerow=\"limitmin\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("공지사항목록");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("MessageBoardList.xfdl", "lib::lib_Com.xjs");
        this.registerScript("MessageBoardList.xfdl", function(exports) {

        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        this.bbsId = undefined;
        this.fv_pageRow = 15;	// 페이지당 건수
        this.fv_totalpageRow;	// 전체건수
        this.fv_curPageNum = 1;	// 페이지 번호
        this.fv_curPageNumAft = 1 // 조회건수
        this.fv_count = 1; //초기값
        this.rowposition = 0;

         
        this.form_onload = function(obj,e) {
        	//필수
        	this.fn_init();
        }

        this.fn_init = function () {
        	if ( !this.gfn_isNull(this.parent.pArgument) ) {
        		this.bbsId = this.parent.pArgument;
        	}
        	this.fn_search();
        }

        this.grd_list_oncellclick = function(obj,e) {
        	//팝업띄우기전 선택된 rowposition으로 변수에 담음
        	this.rowposition = this.ds_grd.rowposition;
        	
        	var arg = new Array();
        	arg[0] = this.ds_grd.getColumn(this.ds_grd.rowposition,"attr10");     //상세내용(html 경로)
        	arg[1] = this.ds_grd.getColumn(this.ds_grd.rowposition,"title");      //제목
        	arg[2] = this.ds_grd.getColumn(this.ds_grd.rowposition,"tmNm");       //부서명
        	arg[3] = this.ds_grd.getColumn(this.ds_grd.rowposition,"writeSabun"); //작성자
        	arg[4] = this.ds_grd.getColumn(this.ds_grd.rowposition,"writeTime");  //공지일
        	arg[5] = this.ds_grd.getColumn(this.ds_grd.rowposition,"upjangNm");   //업장명
        	arg[6] = this.ds_grd.getColumn(this.ds_grd.rowposition,"conId");      //게시키값
        	
        	application.goMain.gfn_POP_create("board", "M_MMB::MessageDetailBoardPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        this.btnSearch_onclick = function(obj,e) {
        	this.ds_grd.clearData();
        	this.ds_grdServer.clearData();
        	this.fv_curPageNum = 1;	// 페이지 번호
        	this.fv_curPageNumAft = 1 // 조회건수
        	this.fv_count = 1; //초기값
        	
        	this.fn_search();
        }

        this.fn_search = function() {

        	//검색
        	var strSvcID   		 = "search";
        	var strUrl     		 = "ms/mmb/messageBoard/selectList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "ds_grdServer=ds_list";
        	var strArguments	 = "bbsId=" + nexacro.wrapQuote(this.bbsId);
        		strArguments	+= " searchId=" + nexacro.wrapQuote(this.edt_value.text);	// TODO 검색어 검색
        	    strArguments	+= " curPageNum=" + nexacro.wrapQuote(this.fv_curPageNum);	// TODO 현재 페이지번호 추가
        	    strArguments	+= " pageRow=" + nexacro.wrapQuote(this.fv_pageRow);	// TODO 페이지당 건수
        		strArguments	+= " userId=" + nexacro.wrapQuote(application.g_userId);
        		strArguments	+= " upjangCd=" + nexacro.wrapQuote(application.g_Upjang);
        		strArguments	+= " gubun=" + nexacro.wrapQuote("02");
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
          	
        }

        /*----------------------------------------------------------------------------------------------
         * 설명      : 트랜잭션 콜백 함수 (필수)
         *---------------------------------------------------------------------------------------------*/
        this.fn_callBack = function (strSvcID,nErrorCode,strErrorMsg) {	
        	
        	if ( nErrorCode < 0 ) {
        		return;
        	}
        	
            switch( strSvcID ) {		
        		//공지사항
                case "search" :
        			// TODO parameter로 전체건수를 받는다.
        			this.fv_totalpageRow = this.ds_grdServer.getColumn(0, "totCnt");			

                    if (this.ds_grdServer.getRowCount() == 0) {
                        application.goMain.gfn_Msg("alertTest", "Information", "조회되는 내용이 없습니다.", "OK");	//조회되는 내용이 없습니다.
                        return;
                    } else if ( this.fv_totalpageRow > this.fv_pageRow && this.fv_count == 1 ) {	// 조회건수가 1페이지 이상일때
                    	this.ds_grd.copyData(this.ds_grdServer);				
        							
        				// 더보기 버튼 보이기
        				this.btn_moreView.set_visible(true);
        				this.btn_moreView.bringToFront();
        				this.btn_moreView.set_text("더보기("+this.fv_totalpageRow+"/"+this.fv_pageRow+")");
        							
        				this.fv_count = this.fv_count+1;
        				
                    } else if (this.fv_totalpageRow <= this.fv_pageRow) {
        				this.btn_moreView.set_visible(false);
        				this.ds_grd.copyData(this.ds_grdServer);				
                    }
                    
                    // 페이지 번호 2 이상일때 기존 dataset에 건수 추가
                    if (this.fv_curPageNum > this.fv_pageRow) {
        				this.ds_grd.appendData(this.ds_grdServer);
        				this.fv_curPageNumAft = this.ds_grd.getRowCount();
        				this.btn_moreView.set_text("더보기("+this.fv_totalpageRow+"/"+this.fv_curPageNumAft+")");
        				
        				this.ds_grd.set_rowposition(this.fv_curPageNum-this.fv_pageRow+1);
        				this.ds_grd.set_rowposition(this.fv_curPageNum-this.fv_pageRow-1);
        				this.ds_grd.set_rowposition(this.fv_curPageNum-this.fv_pageRow);
                    }
                    
                    //팝업띄우기전 선택된 rowposition으로 이동
                    this.ds_grd.set_rowposition(this.rowposition);
                    
          			break;
            }    
        }

        this.fn_callbackPOP = function (popname,rtn) {
        	switch ( popname )	{
        		case "board":
        			this.fn_search();
        			break;			
        	}
        }

        // 더보기 버튼 onclick event
        this.btn_moreView_onclick = function(obj,e) {
        	this.fv_curPageNum = this.fv_curPageNum+this.fv_pageRow;
        	this.fn_search();
        }

        this.grd_list_onslide = function(obj,e) {
        	
        	if ( e.yaccvalue > 0 ) {
        		this.parent.parent.divBottom.set_visible(true);
        		this.parent.parent.divMain.set_height(833);
        		this.parent.parent.divBottom.bringToFront();
        	} else if ( e.yaccvalue < 0 ) {
        		if ( this.ds_grd.getRowCount() > 0 ) {
        			this.parent.parent.divBottom.set_visible(false);
        			this.parent.parent.divMain.set_height(923);
        		}
        	}
        }

        this.grd_list_onvscroll = function(obj,e) {
        	// div안의 스크롤 컨트롤일 경우 btnGoTop 대신 btnGoTopDiv 사용
        	if ( e.pos == 0 ) {
        		this.parent.btnGoTopDiv.set_visible(false);
        	} else {
        		this.parent.btnGoTopDiv.set_visible(true);
        	}
        }

        // div안의 스크롤바 조정일 경우 아래 함수 추가
        this.fn_setDivScrollbar = function() {
        	// 해당 div로 바꿔준다.
        	this.grd_list.vscrollbar.set_pos(0);
        }
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.btn_moreView.addEventHandler("onclick", this.btn_moreView_onclick, this);
            this.btn_search.addEventHandler("onclick", this.btnSearch_onclick, this);
            this.grd_list.addEventHandler("onvscroll", this.grd_list_onvscroll, this);
            this.grd_list.addEventHandler("oncellclick", this.grd_list_oncellclick, this);
            this.grd_list.addEventHandler("onslide", this.grd_list_onslide, this);

        };

        this.loadIncludeScript("MessageBoardList.xfdl", true);

       
    };
}
)();
