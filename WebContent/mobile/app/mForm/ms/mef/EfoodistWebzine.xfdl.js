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
                this.set_name("EfoodistWebzine");
                this.set_titletext("Webzine");
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
            obj._setContents("<ColumnInfo><Column id=\"rgstSeq\" type=\"STRING\" size=\"256\"/><Column id=\"reqSeq\" type=\"STRING\" size=\"256\"/><Column id=\"title\" type=\"STRING\" size=\"256\"/><Column id=\"fileNm\" type=\"STRING\" size=\"256\"/><Column id=\"filePath\" type=\"STRING\" size=\"256\"/><Column id=\"fileGubun\" type=\"STRING\" size=\"256\"/><Column id=\"imgFileNm\" type=\"STRING\" size=\"256\"/><Column id=\"imgFile\" type=\"BLOB\" size=\"256\"/><Column id=\"imgFilePath\" type=\"STRING\" size=\"256\"/><Column id=\"refSeq\" type=\"STRING\" size=\"256\"/><Column id=\"appendSeq\" type=\"STRING\" size=\"256\"/><Column id=\"orgnlFileNm\" type=\"STRING\" size=\"256\"/><Column id=\"saveFileNm\" type=\"STRING\" size=\"256\"/><Column id=\"relPath\" type=\"STRING\" size=\"256\"/><Column id=\"useYn\" type=\"STRING\" size=\"256\"/><Column id=\"bigo\" type=\"STRING\" size=\"256\"/><Column id=\"realDtmRgst\" type=\"STRING\" size=\"256\"/><Column id=\"cdate\" type=\"STRING\" size=\"256\"/><Column id=\"cuser\" type=\"STRING\" size=\"256\"/><Column id=\"udate\" type=\"STRING\" size=\"256\"/><Column id=\"uuser\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
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
            obj._setContents("<ColumnInfo><Column id=\"rgstSeq\" type=\"STRING\" size=\"256\"/><Column id=\"appendSeq\" type=\"STRING\" size=\"256\"/><Column id=\"title\" type=\"STRING\" size=\"256\"/><Column id=\"fileNm\" type=\"STRING\" size=\"256\"/><Column id=\"filePath\" type=\"STRING\" size=\"256\"/><Column id=\"fileGubun\" type=\"STRING\" size=\"256\"/><Column id=\"imgFileNm\" type=\"STRING\" size=\"256\"/><Column id=\"imgFile\" type=\"BLOB\" size=\"256\"/><Column id=\"imgFilePath\" type=\"STRING\" size=\"256\"/><Column id=\"refSeq\" type=\"STRING\" size=\"256\"/><Column id=\"appendFilenm\" type=\"STRING\" size=\"256\"/><Column id=\"orgnlFileNm\" type=\"STRING\" size=\"256\"/><Column id=\"saveFileNm\" type=\"STRING\" size=\"256\"/><Column id=\"relPath\" type=\"STRING\" size=\"256\"/><Column id=\"useYn\" type=\"STRING\" size=\"256\"/><Column id=\"bigo\" type=\"STRING\" size=\"256\"/><Column id=\"realDtmRgst\" type=\"STRING\" size=\"256\"/><Column id=\"cdate\" type=\"STRING\" size=\"256\"/><Column id=\"cuser\" type=\"STRING\" size=\"256\"/><Column id=\"udate\" type=\"STRING\" size=\"256\"/><Column id=\"uuser\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("Static00", "absolute", "0", "0", null, "224", "0", null, this);
            obj.set_taborder("0");
            obj.set_cssclass("sta_WF_WebzineBg");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list", "absolute", "10", "232", null, null, "10", "0", this);
            obj.set_taborder("1");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"140\"/><Column size=\"380\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell/><Cell col=\"1\" text=\"GrayLabel\"/></Band><Band id=\"body\"><Cell rowspan=\"3\" displaytype=\"normal\" style=\"padding:5 0 5 0;background:stretch;background2:stretch;selectbackground:stretch;backgroundimage:BIND(imgFilePath);\"/><Cell col=\"1\" displaytype=\"normal\" style=\"align:left;padding:0 10 0 10;line:0 solid #808080 ;\" text=\"bind:itemName\" expandshow=\"hide\" tooltiptext=\"bind:itemName\" autosizerow=\"default\" autosizecol=\"default\"/><Cell row=\"1\" col=\"1\" style=\"align:left;padding:0 10 0 10;line:0 solid #808080 ;\" text=\"bind:title\"/><Cell row=\"2\" col=\"1\" celltype=\"none\" style=\"align:center middle;padding:0 10 0 10;\" text=\"bind:itemCode\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Button("btn_moreView", "absolute", "128", null, null, "42", "136", "0", this);
            obj.set_taborder("4");
            obj.set_visible("false");
            obj.style.set_background("darkgray");
            obj.style.set_color("white");
            obj.style.set_opacity("75");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("Webzine");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("EfoodistWebzine.xfdl", "lib::lib_Com.xjs");
        this.registerScript("EfoodistWebzine.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		EfoodistWebzine
        // [부시스템명]	EfoodistWebzine - 조회
        // [설명]
        // 		부서 검색하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.02.24
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.24 : 강대성 : 수정이 필요하여 수정함.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*======================================================
         전역변수
         ======================================================*/
        this.preDate = undefined;
        this.fv_pageRow = 6;	// 페이지당 건수
        this.fv_totalpageRow;	// 전체건수
        this.fv_curPageNum = 1;	// 페이지 번호

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

        this.fn_init = function ()
        {
        	this.fn_search();
        }

        /*******************************************************************************
        * 기      능   :  검색
        * 설      명   :  등록
        ********************************************************************************/
        this.fn_search = function(){

        	//내부:01, 외부:02
        	var gubun  = "01";
        	
        	if(application.g_UserType == "내부"){
        		gubun  = "01";
        	}else{
        		gubun  = "02"; 
        	}
        	
        	//검색
        	var strSvcID   		 = "efoodistWebzine";
        	var strUrl     		 = "ms/mef/efoodistWebzine/selectList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "ds_grdServer=ds_list";
        	var strArguments	 = "cboGubun=" + nexacro.wrapQuote(gubun);
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
          	// connect the server 
        	
        }

        // 달력 클릭 시(From)
        this.div_additionOrder_cal_dtFrom_ondropdown = function(obj,e)
        {
        	var objCalArg = obj.value;
        	
        	application.goMain.gfn_POP_create("PopCalFrom", application.goMain.divBase.div_calendar, "fn_callbackPOP", this, objCalArg, "POPDivx", application.goMain.divBase);
        	return false;
        }

        // 달력 클릭 시(To)
        this.div_additionOrder_cal_dtTo_ondropdown = function(obj,e)
        {
        	var objCalArg = obj.value;
        	
        	application.goMain.gfn_POP_create("PopCalTo", application.goMain.divBase.div_calendar, "fn_callbackPOP", this, objCalArg, "POPDivx", application.goMain.divBase);
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
        		//상품발주현황조회
                case "efoodistWebzine" :
        			// TODO parameter로 전체건수를 받는다.
        			this.fv_totalpageRow = this.ds_grdServer.getRowCount();			
        			
        			var i;
        			for (i = 0; i < this.fv_totalpageRow; i++)
        			{
        				var imgFilePath = this.ds_grdServer.getColumn(i, "imgFilePath");
        				this.ds_grdServer.setColumn(i, "imgFilePath", "URL(" + nexacro.wrapQuote("svc::"+imgFilePath) +")");
        			
        			}
        			
        			// 조회 건수 확인  
                    if (this.ds_grdServer.getRowCount() == 0) 
                    {
                        application.goMain.gfn_Msg("alertTest", "Information", "조회되는 내용이 없습니다.", "OK");	//조회되는 내용이 없습니다.
                        return;
                    }
                    else if (this.fv_totalpageRow > this.fv_pageRow)	// 조회건수가 1페이지 이상일때
                    {
        				// 더보기 버튼 보이기
        				this.btn_moreView.set_visible(true);
        				this.btn_moreView.bringToFront();
        				
        				// 1페이지 째 row 셋팅
        				this.fv_curPageNum = 0;
        				this.fn_nextPage();
                    }
                    else if (this.fv_totalpageRow <= this.fv_pageRow)
                    {
        				// 더보기 버튼 안보이기
        				this.btn_moreView.set_visible(false);
                    
        				this.ds_grd.copyData(this.ds_grdServer);
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
        }

        // 더보기 버튼 onclick event
        this.btn_moreView_onclick = function(obj,e)
        {
        	this.fn_nextPage();
        }

        // 더보기 버튼 동작
        this.fn_nextPage = function()
        {
        	// 페이지 건수 만큼 더하기
        	var nRow;
        	var i;
        	for (i = 0; i < this.fv_pageRow; i++)
        	{
        		nRow = this.ds_grd.addRow();
        		
        		var nRowCur = nRow+1;
        		this.btn_moreView.set_text("더보기("+nRowCur+"/"+this.fv_totalpageRow+")");
        		
        		// 총건수에 도달하면 return;
        		if (nRow == this.fv_totalpageRow)
        		{
        			this.ds_grd.deleteRow(nRow);
        			// TODO 필요하면 msg를 띄운다.(ex.. 마지막 페이지 입니다.)
        			application.goMain.gfn_Msg("alertTest", "Information", "마지막 페이지 입니다.", "OK");
        			this.btn_moreView.set_visible(false);
        			return;
        		}
        		trace((this.fv_curPageNum * this.fv_pageRow)+1+i);
        		this.ds_grd.copyRow(nRow, this.ds_grdServer, (this.fv_curPageNum * this.fv_pageRow)+i);
        	}
        	// row 시점 고정
        	this.ds_grd.set_rowposition(this.ds_grd.rowposition - this.fv_pageRow);
        	
        	// 페이지 번호 올리기
        	this.fv_curPageNum = this.fv_curPageNum+1;
        }

        this.grd_list_oncellclick = function(obj,e)
        {
        	
        	if(e.cell == "0")
        	{
        		application.goMain.gfn_Msg("pdf", "PDF파일보기", "PDF파일을 보시겠습니까?", "YN", true, this);

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
        	if (id == "pdf")
        	{
        		if (rtn == "Y") 
        		{
        			this.fn_pdfDownload();
        		}
        		else
        		{
        			return;
        		}
        	}
        }

        this.fn_pdfDownload = function()
        {
        	var strSaveFileName = this.ds_grd.getColumn(this.ds_grd.rowposition,"saveFileNm");
         	
         	// 모바일런타임 전환작업 - 20150708 김광호
         	//this.fspmob.browser(application.services["svc"].url + "upload/ms/mef/" + strSaveFileName);
         	if(nexacro.OS == "Android")
         	{
        		system.execBrowser(application.services["svc"].url + "upload/ms/mef/" + strSaveFileName);
         	}
         	else if(nexacro.OS == "iOS")
         	{	
        		var arg = new Array();
        		arg[0] = strSaveFileName;    //상세내용(html 경로)
         	
        		application.goMain.gfn_POP_create("pop", "M_MEF::EfoodistWebzinePdfPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        		return;
         	}
         	else
         	{
        		var arg = new Array();
        		arg[0] = strSaveFileName;    //상세내용(html 경로)
         	
        		application.goMain.gfn_POP_create("pop", "M_MEF::EfoodistWebzinePdfPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        		return;
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
        		case "pdfViewPop":
        			break;
        		case "pop":
        			break;	
        		
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
        		if (this.ds_grd.getRowCount() > 0)
        		{
        			this.parent.parent.divBottom.set_visible(false);
        			this.parent.parent.divMain.set_height(923);
        		}
        	}
        }

        this.grd_list_onvscroll = function(obj,e)
        {
        	// div안의 스크롤 컨트롤일 경우 btnGoTop 대신 btnGoTopDiv 사용
        	if (e.pos == 0)
        	{
        		this.parent.btnGoTopDiv.set_visible(false);
        	}
        	else
        	{
        		this.parent.btnGoTopDiv.set_visible(true);
        	}
        }

        // div안의 스크롤바 조정일 경우 아래 함수 추가
        this.fn_setDivScrollbar = function()
        {
        	// 해당 div로 바꿔준다.
        	this.grd_list.vscrollbar.set_pos(0);
        }

        
        // 모바일런타임 전환으로 추가   20150707  김광호
        this.on_success = function(obj,e)
        {
        	//this.alert("on_success진입 e.reason = "+e.reason+" e.returnvalue : "+e.returnvalue);
        	if (e.reason == "6")	// overrideback
        	{
        		trace("성공");
        	}
        }

        // 모바일런타임 전환으로 추가   20150707  김광호
        this.on_error = function(obj,e)
        {
        //	this.alert("on_error :: obj :: "+obj.name+" :: e = "+e.reason);
        	//alert(e.reason);
        	if (e.reason == "6")
        	{
        		application.goMain.gfn_Msg("ALERT_0", "메세지", e.errormsg, "OK", true, this);		
        		return false;
        	}
        	
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.grd_list.addEventHandler("onvscroll", this.grd_list_onvscroll, this);
            this.grd_list.addEventHandler("onslide", this.grd_list_onslide, this);
            this.grd_list.addEventHandler("oncellclick", this.grd_list_oncellclick, this);
            this.btn_moreView.addEventHandler("onclick", this.btn_moreView_onclick, this);

        };

        this.loadIncludeScript("EfoodistWebzine.xfdl", true);

       
    };
}
)();
