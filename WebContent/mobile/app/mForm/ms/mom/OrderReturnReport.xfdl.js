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
                this.set_name("OrderReturnReport");
                this.set_titletext("구매취소현황");
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
            obj._setContents("<ColumnInfo><Column id=\"upjangSubinv\" type=\"STRING\" size=\"256\"/><Column id=\"returnDatetime\" type=\"STRING\" size=\"256\"/><Column id=\"needDate\" type=\"STRING\" size=\"256\"/><Column id=\"typeName\" type=\"STRING\" size=\"256\"/><Column id=\"itemCode\" type=\"STRING\" size=\"256\"/><Column id=\"itemName\" type=\"STRING\" size=\"256\"/><Column id=\"itemSize\" type=\"STRING\" size=\"256\"/><Column id=\"poUom\" type=\"STRING\" size=\"256\"/><Column id=\"prQty\" type=\"STRING\" size=\"256\"/><Column id=\"custnm\" type=\"STRING\" size=\"256\"/><Column id=\"prRemark\" type=\"STRING\" size=\"256\"/><Column id=\"rcUpjang\" type=\"STRING\" size=\"256\"/><Column id=\"muNm\" type=\"STRING\" size=\"256\"/><Column id=\"tmNm\" type=\"STRING\" size=\"256\"/><Column id=\"upjangnm\" type=\"STRING\" size=\"256\"/><Column id=\"lineStatus\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
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
            obj._setContents("<ColumnInfo><Column id=\"upjangSubinv\" type=\"STRING\" size=\"256\"/><Column id=\"returnDatetime\" type=\"STRING\" size=\"256\"/><Column id=\"needDate\" type=\"STRING\" size=\"256\"/><Column id=\"typeName\" type=\"STRING\" size=\"256\"/><Column id=\"itemCode\" type=\"STRING\" size=\"256\"/><Column id=\"itemName\" type=\"STRING\" size=\"256\"/><Column id=\"itemSize\" type=\"STRING\" size=\"256\"/><Column id=\"poUom\" type=\"STRING\" size=\"256\"/><Column id=\"prQty\" type=\"STRING\" size=\"256\"/><Column id=\"custnm\" type=\"STRING\" size=\"256\"/><Column id=\"prRemark\" type=\"STRING\" size=\"256\"/><Column id=\"rcUpjang\" type=\"STRING\" size=\"256\"/><Column id=\"muNm\" type=\"STRING\" size=\"256\"/><Column id=\"tmNm\" type=\"STRING\" size=\"256\"/><Column id=\"upjangnm\" type=\"STRING\" size=\"256\"/><Column id=\"lineStatus\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("Static07", "absolute", "530", "238", "10", "451", null, null, this);
            obj.set_taborder("12");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "238", "10", "451", null, null, this);
            obj.set_taborder("13");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static22", "absolute", "0", "59", null, "59", "0", null, this);
            obj.set_taborder("17");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Button("btn_search", "absolute", null, "65", "100", "47", "10", null, this);
            obj.set_taborder("18");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "1", null, "59", "0", null, this);
            obj.set_taborder("25");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_upjang", "absolute", "10", "7", null, "47", "10", null, this);
            obj.set_taborder("26");
            obj.set_displaynulltext("사업장을 입력하세요");
            obj.set_autoselect("true");
            this.addChild(obj.name, obj);

            obj = new Button("btn_upjang", "absolute", null, "7", "47", "47", "11", null, this);
            obj.set_taborder("27");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_dtFrom", "absolute", "10", "66", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("28");
            obj.set_dateformat("yyyy-MM-dd");

            obj = new Static("Static34", "absolute", "210", "66", "15", "47", null, null, this);
            obj.set_taborder("29");
            obj.set_text("~");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_dtTo", "absolute", "225", "66", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("30");
            obj.set_dateformat("yyyy-MM-dd");

            obj = new Grid("grd_list", "absolute", "0", "117", null, null, "0", "0", this);
            obj.set_cssclass("grd_WF_Default2");
            obj.set_taborder("31");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_extendsizetype("none");
            obj.set_autosizingtype("none");
            obj.set_nodataimage("URL('theme://Image/grd_WF_NoDataImg.png')");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"148\"/><Column size=\"62\"/><Column size=\"213\"/><Column size=\"117\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"4\"/></Rows><Band id=\"head\"><Cell/><Cell col=\"1\" text=\"GrayLabel\"/><Cell col=\"2\"/><Cell col=\"3\"/></Band><Band id=\"body\"><Cell colspan=\"4\" style=\"align:left bottom;padding:5 5 5 10;line:0 solid #808080ff ;\" text=\"expr: itemCode + &quot; &quot; + itemName\" autosizerow=\"default\"/><Cell row=\"1\" displaytype=\"date\" style=\"align:left top;padding:5 5 5 10;line:0 none #808080ff ;\" text=\"bind:needDate\" autosizerow=\"default\"/><Cell row=\"1\" col=\"1\" displaytype=\"normal\" style=\"align:left top;padding:5 5 5 5;line:0 none #808080ff ;\" text=\"bind:poUom\" wordwrap=\"char\" autosizerow=\"default\"/><Cell row=\"1\" col=\"2\" displaytype=\"normal\" style=\"align:left top;padding:5 5 5 5;line:0 none #808080ff ;color:blue;color2:blue;selectcolor:blue;\" text=\"bind:typeName\" wordwrap=\"char\" autosizerow=\"default\"/><Cell row=\"1\" col=\"3\" displaytype=\"normal\" style=\"align:left top;padding:5 5 5 5;line:0 none #808080ff ;color:red;color2:red;selectcolor:red;\" text=\"bind:lineStatus\" wordwrap=\"char\" autosizerow=\"default\"/><Cell row=\"2\" autosizerow=\"limitmax\"/><Cell row=\"2\" col=\"1\" colspan=\"3\" autosizerow=\"limitmax\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Button("btn_moreView", "absolute", "128", null, null, "42", "136", "0", this);
            obj.set_taborder("24");
            obj.set_visible("false");
            obj.style.set_background("darkgray");
            obj.style.set_color("white");
            obj.style.set_opacity("90");
            this.addChild(obj.name, obj);

            obj = new Static("sta_dtFrom", "absolute", "10", "66", "196", "47", null, null, this);
            obj.set_taborder("32");
            this.addChild(obj.name, obj);

            obj = new Static("sta_dtTo", "absolute", "225", "66", "196", "47", null, null, this);
            obj.set_taborder("33");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("구매취소현황");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("OrderReturnReport.xfdl", "lib::lib_Com.xjs");
        this.registerScript("OrderReturnReport.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		발주반려현황
        // [부시스템명]	발주반려현황 - 조회
        // [설명]
        // 		부서 검색하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.02.03
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.03 : 강대성 : 수정이 필요하여 수정함.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*======================================================
         전역변수
         ======================================================*/
        this.preDate = undefined;
        this.fv_pageRow = 10;	// 페이지당 건수
        this.fv_totalpageRow;	// 전체건수
        this.fv_curPageNum = 1;	// 페이지 번호
        this.upjang = undefined;
        this.muCd = undefined;

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
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetBtnControl("this.btn_search","");	
        	// 권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetAuth("this.edt_upjang", "this.btn_upjang");
        	
        	this.preDate = this.gfn_Today();
        	this.cal_dtFrom.set_value(this.gfn_AddDate(this.preDate, 1));
        	this.cal_dtTo.set_value(this.gfn_AddDate(this.preDate, 1));
        	
        	//사업장 세팅
        	this.edt_upjang.set_value(application.g_UpjangNm);	
        	this.upjang = application.g_Upjang;	
        	this.muCd = application.g_Mu_Cd;	
        	
        	//필수
        	this.fn_init();
        }

        this.fn_init = function ()
        {
        	this.ds_grd.clearData();
        	this.ds_grdServer.clearData();
        }

        /** 
         * 사업장 검색 팝업 호출
         */
        this.btn_upjang_onclick = function(obj,e)
        {
        	var arg = new Array();
        	if(this.fn_masterRole())
        	{
        		arg[4] = application.g_RoleSetId1;
        		arg[9] = "exception";
        		arg[10] = "AND A.MU_CD IN ('2002','2003')";
        		arg[11] = application.g_UpjangFlag1;
        		arg[12] = application.g_UpjangFlag2;
        	}
        	else
        	{
        		arg[4] = application.g_RoleSetId2;
        		arg[5] = application.g_AuthLevel;
        		arg[6] = application.g_EmpNo;
        		if(application.g_useTmCd == "Y")
        		{
        			arg[7] = application.g_Tm_Cd;
        		}
        		arg[8] = application.g_Mu_Cd;
        		arg[9] = application.g_UpjangGubun;
        		arg[11] = application.g_UpjangFlag1;
        		arg[12] = application.g_UpjangFlag2;
        	}	
        	
        	application.goMain.gfn_POP_create("upjangNm", "M_MLM::WorkplaceSearchPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        // 달력 클릭 시(From)
        this.cal_dtFrom_ondropdown = function(obj,e)
        {
        	var objCalArg = obj.value;
        	
        	application.goMain.gfn_POP_create("PopCalFrom", "cmmn::CmmnCalendarPop.xfdl", "fn_callbackPOP", this, objCalArg, "POP", application.goMain.divBase);
        	return false;
        }

        
        // 달력 클릭 시(From)
        this.sta_dtFrom_onclick = function(obj,e)
        {
        	var objCalArg = this.cal_dtFrom.value;
        	
        	application.goMain.gfn_POP_create("PopCalFrom", "cmmn::CmmnCalendarPop.xfdl", "fn_callbackPOP", this, objCalArg, "POP", application.goMain.divBase);
        	return false;
        }

        // 달력 클릭 시(To)
        this.sta_dtTo_onclick = function(obj,e)
        {
        	var objCalArg = this.cal_dtTo.value;
        	
        	application.goMain.gfn_POP_create("PopCalTo", "cmmn::CmmnCalendarPop.xfdl", "fn_callbackPOP", this, objCalArg, "POP", application.goMain.divBase);
        	return false;
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
        	this.fn_init();
        	
        	var strSvcID   		 = "orderReturnReport";
        	var strUrl     		 = "ms/mom/orderReturnReport/selectList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "ds_grd=ds_list";
        	var strArguments	 = "upjang=" + nexacro.wrapQuote(this.upjang);
        	   strArguments     += " calDtFrom=" + nexacro.wrapQuote(this.cal_dtFrom.value);	
        	   strArguments     += " calDtTo=" + nexacro.wrapQuote(this.cal_dtTo.value);
        	   strArguments     += " muCd=" + nexacro.wrapQuote(this.muCd);
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
          	// connect the server 
        	
        }

        /*******************************************************************************
        * 기      능   :  그리드 클릭시 상세내역팝업창 호출
        * 설      명   :  그리드 클릭시 상세내역팝업창 호출
        ********************************************************************************/
        this.grd_list_oncellclick = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_grd.getColumn(this.ds_grd.rowposition, "prQty");           //발주량, 취소수량
        	arg[1] = this.ds_grd.getColumn(this.ds_grd.rowposition, "returnDatetime");  //취소일자/시간
        	arg[2] = this.ds_grd.getColumn(this.ds_grd.rowposition, "needDate");        //입고예정일
        	arg[3] = this.ds_grd.getColumn(this.ds_grd.rowposition, "custnm");          //업체명
        	arg[4] = this.ds_grd.getColumn(this.ds_grd.rowposition, "prRemark");        //사유
        	arg[5] = this.ds_grd.getColumn(this.ds_grd.rowposition, "itemSize");        //규격
        	
        	application.goMain.gfn_POP_create("OrderReturnReportPop", "M_MOM::OrderReturnReportPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
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
                case "orderReturnReport" :
        			// TODO parameter로 전체건수를 받는다.
        			this.fv_totalpageRow = this.ds_grd.getRowCount();
        			
                    // 조회 건수 확인  
                    if (this.ds_grd.getRowCount() == 0) 
                    {
                        application.goMain.gfn_Msg("alertTest", "Information", "조회되는 내용이 없습니다.", "OK");	//해당하는 사용자 정보가 없습니다.
                        return;
                    }
                    else
                    {
        				// 총건수 표시
        				this.btn_moreView.set_visible(true);
        				this.btn_moreView.set_text("총건수:" +this.fv_totalpageRow);		
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
        		case "upjangNm":
        			this.edt_upjang.set_value(rtn[1]);
        			this.upjang = rtn[0];			
        			this.fn_search();
        			break;
        		case "PopCalFrom":
        			this.cal_dtFrom.set_value(rtn);
        			break;	
        		case "PopCalTo":
        			this.cal_dtTo.set_value(rtn);
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
        		this.btn_moreView.set_visible(true);
        	}
        	else if (e.yaccvalue < 0)
        	{
        		if (this.ds_grd.getRowCount() > 0)
        		{
        			this.parent.parent.divBottom.set_visible(false);
        			this.parent.parent.divMain.set_height(923);
        			this.btn_moreView.set_visible(false);
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

        

        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.btn_search.addEventHandler("onclick", this.btnSearch_onclick, this);
            this.btn_upjang.addEventHandler("onclick", this.btn_upjang_onclick, this);
            this.grd_list.addEventHandler("onvscroll", this.grd_list_onvscroll, this);
            this.grd_list.addEventHandler("oncellclick", this.grd_list_oncellclick, this);
            this.grd_list.addEventHandler("onslide", this.grd_list_onslide, this);
            this.btn_moreView.addEventHandler("onclick", this.btn_moreView_onclick, this);
            this.sta_dtFrom.addEventHandler("onclick", this.sta_dtFrom_onclick, this);
            this.sta_dtTo.addEventHandler("onclick", this.sta_dtTo_onclick, this);

        };

        this.loadIncludeScript("OrderReturnReport.xfdl", true);

       
    };
}
)();
