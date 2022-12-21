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
                this.set_name("ProductInformation");
                this.set_titletext("상품조회");
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
            obj._setContents("<ColumnInfo><Column id=\"itemCode\" type=\"STRING\" size=\"256\"/><Column id=\"itemName\" type=\"STRING\" size=\"256\"/><Column id=\"itemSize\" type=\"STRING\" size=\"256\"/><Column id=\"poUom\" type=\"STRING\" size=\"256\"/><Column id=\"itemPrice\" type=\"STRING\" size=\"256\"/><Column id=\"kgConvertRate\" type=\"STRING\" size=\"256\"/><Column id=\"taxName\" type=\"STRING\" size=\"256\"/><Column id=\"poCenterYn\" type=\"STRING\" size=\"256\"/><Column id=\"gItemPrice\" type=\"STRING\" size=\"256\"/><Column id=\"itemVat\" type=\"STRING\" size=\"256\"/><Column id=\"imgPath\" type=\"STRING\" size=\"256\"/><Column id=\"custnm\" type=\"STRING\" size=\"256\"/><Column id=\"featureName\" type=\"STRING\" size=\"256\"/><Column id=\"dutyPeriod\" type=\"STRING\" size=\"256\"/><Column id=\"featureType\" type=\"STRING\" size=\"256\"/><Column id=\"restrictPeriod\" type=\"STRING\" size=\"256\"/><Column id=\"restrictReason\" type=\"STRING\" size=\"256\"/><Column id=\"scheduleYn\" type=\"STRING\" size=\"256\"/><Column id=\"dDays\" type=\"STRING\" size=\"256\"/><Column id=\"totCnt\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
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
            obj._setContents("<ColumnInfo><Column id=\"itemCode\" type=\"STRING\" size=\"256\"/><Column id=\"itemName\" type=\"STRING\" size=\"256\"/><Column id=\"itemSize\" type=\"STRING\" size=\"256\"/><Column id=\"poUom\" type=\"STRING\" size=\"256\"/><Column id=\"itemPrice\" type=\"STRING\" size=\"256\"/><Column id=\"kgConvertRate\" type=\"STRING\" size=\"256\"/><Column id=\"taxName\" type=\"STRING\" size=\"256\"/><Column id=\"poCenterYn\" type=\"STRING\" size=\"256\"/><Column id=\"gItemPrice\" type=\"STRING\" size=\"256\"/><Column id=\"itemVat\" type=\"STRING\" size=\"256\"/><Column id=\"imgPath\" type=\"STRING\" size=\"256\"/><Column id=\"custnm\" type=\"STRING\" size=\"256\"/><Column id=\"featureName\" type=\"STRING\" size=\"256\"/><Column id=\"dutyPeriod\" type=\"STRING\" size=\"256\"/><Column id=\"featureType\" type=\"STRING\" size=\"256\"/><Column id=\"restrictPeriod\" type=\"STRING\" size=\"256\"/><Column id=\"restrictReason\" type=\"STRING\" size=\"256\"/><Column id=\"scheduleYn\" type=\"STRING\" size=\"256\"/><Column id=\"dDays\" type=\"STRING\" size=\"256\"/><Column id=\"totCnt\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_itemType", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"256\"/><Column id=\"cdNm\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Button("btn_gubun01", "absolute", "360", "0", "180", "63", null, null, this);
            obj.set_taborder("0");
            obj.set_text("모두");
            obj.set_cssclass("btn_WF_TabMFOff");
            this.addChild(obj.name, obj);

            obj = new Button("btn_gubun00", "absolute", "180", "0", "180", "63", null, null, this);
            obj.set_taborder("1");
            obj.set_text("PB상품");
            obj.set_cssclass("btn_WF_TabMFOff");
            this.addChild(obj.name, obj);

            obj = new Button("btn_all", "absolute", "0", "0", "180", "63", null, null, this);
            obj.set_taborder("2");
            obj.set_text("기획");
            obj.set_cssclass("btn_WF_TabMFOn");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "120", null, "59", "0", null, this);
            obj.set_taborder("4");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_itemNm", "absolute", "10", "126", null, "47", "283", null, this);
            obj.set_taborder("6");
            obj.set_displaynulltext("품목명 검색");
            obj.set_imemode("hangul");
            obj.set_autoselect("true");
            this.addChild(obj.name, obj);

            obj = new Button("btn_search", "absolute", null, "126", "100", "47", "10", null, this);
            obj.set_taborder("8");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "0", "179", "540", "59", null, null, this);
            obj.set_taborder("9");
            obj.set_text("현재 사업장 품목");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

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

            obj = new Button("btn_moreView", "absolute", "128", null, null, "42", "136", "0", this);
            obj.set_taborder("14");
            obj.set_visible("false");
            obj.style.set_background("darkgray");
            obj.style.set_color("white");
            obj.style.set_opacity("75");
            this.addChild(obj.name, obj);

            obj = new Static("Static32", "absolute", "0", "62", null, "59", "0", null, this);
            obj.set_taborder("16");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static42", "absolute", "0", "62", "156", "59", null, null, this);
            obj.set_taborder("17");
            obj.set_text("사업장");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_upjang", "absolute", "156", "68", null, "47", "10", null, this);
            obj.set_taborder("18");
            obj.set_displaynulltext("사업장 선택");
            obj.set_autoselect("true");
            obj.set_readonly("true");
            this.addChild(obj.name, obj);

            obj = new Button("btn_upjang", "absolute", null, "68", "47", "47", "10", null, this);
            obj.set_taborder("19");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);

            obj = new Combo("cbo_itemType", "absolute", "262", "126", null, "47", "115", null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("20");
            obj.set_innerdataset("@ds_itemType");
            obj.set_codecolumn("cd");
            obj.set_datacolumn("cdNm");
            obj.set_visible("false");
            obj.set_index("-1");

            obj = new Grid("grd_list", "absolute", "10", "238", null, null, "10", "0", this);
            obj.set_taborder("21");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_extendsizetype("row");
            obj.set_autofittype("col");
            obj.set_autosizingtype("row");
            obj.set_nodataimage("URL('theme://Image/grd_WF_NoDataImg.png')");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"140\"/><Column size=\"167\"/><Column size=\"213\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"5\"/></Rows><Band id=\"head\"><Cell/><Cell col=\"1\" text=\"GrayLabel\"/><Cell col=\"2\" text=\"WhiteLabel\"/></Band><Band id=\"body\"><Cell rowspan=\"3\" style=\"background:URL('HWImage::img_WF_NoImage.png') stretch center middle;background2:URL('HWImage::img_WF_NoImage.png') stretch center middle;selectbackground:URL('HWImage::img_WF_NoImage.png') stretch center middle;backgroundimage:BIND(imgPath);\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell col=\"1\" colspan=\"2\" displaytype=\"normal\" style=\"align:left;padding:0 10 0 10;\" text=\"bind:itemName\" wordwrap=\"char\" expandshow=\"hide\" tooltiptext=\"bind:itemName\" autosizerow=\"limitmin\" autosizecol=\"default\"/><Cell row=\"1\" col=\"1\" colspan=\"2\" style=\"align:left;padding:0 10 0 10;\" text=\"expr:itemSize + &quot; &quot; + poUom + &quot;/&quot; + taxName\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"2\" col=\"1\" celltype=\"none\" style=\"align:center middle;padding:0 10 0 10;\" text=\"bind:itemCode\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"2\" col=\"2\" celltype=\"none\" displaytype=\"number\" style=\"align:right;padding:0 10 0 10;\" text=\"bind:itemPrice\" wordwrap=\"char\" mask=\"###,###,###.##\" autosizerow=\"limitmin\"/><Cell row=\"3\" autosizerow=\"limitmax\"/><Cell row=\"3\" col=\"1\" autosizerow=\"limitmax\"/><Cell row=\"3\" col=\"2\" autosizerow=\"limitmax\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("상품조회");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("ProductInformation.xfdl", "lib::lib_Com.xjs");
        this.registerScript("ProductInformation.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		상품정보조회
        // [부시스템명]	상품정보 - 조회
        // [설명]
        // 		부서 검색하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.02.23
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.23 : 강대성 : 수정이 필요하여 수정함.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*======================================================
         전역변수
         ======================================================*/
        this.fv_pageRow = 5;	// 페이지당 건수
        this.fv_totalpageRow;	// 전체건수
        this.fv_curPageNum = 1;	// 페이지 번호
        this.fv_curPageNumAft = 1 // 조회건수
        this.fv_count = 1; //초기값
        this.upjang = undefined;
        this.tabGubun = undefined;
        this.gubun = undefined;
        this.preDate = undefined;
        this.itemType = "";

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

        // 데이터 초기화
        this.fn_init = function ()
        {	
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetBtnControl("this.btn_search","");
        	
        	// 권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetAuth("this.edt_upjang", "this.btn_upjang");
        	
        	//내부:01, 외부:02
        	//if(application.g_UserType == "내부"){
        	if(application.g_Mu_Cd != "2004" && application.g_UserType == "내부"){
        		this.gubun  = "01";
        		
        		this.fn_common_code("FS0132", "", "", "");
        			
        		var nRow = this.ds_itemType.addRow();
        		this.ds_itemType.setColumn(nRow, "cd", "");
        		this.ds_itemType.setColumn(nRow, "cdNm", "**전체**");
        		
        		//공통코드를 데이터 셋에 세팅한다
        		for(var i=0; i < application.gds_common_code.rowcount; i++)
        		{			
        			var nRow = this.ds_itemType.addRow();
        			this.ds_itemType.copyRow(nRow, application.gds_common_code, i);
        		}
        		
        		trace(this.ds_itemType.saveXML("this.ds_itemType >>>>", "V"));
        		
        		//내부 자재단가조회시 아이템 유형 콤보박스 visible값 true.
        		this.cbo_itemType.set_visible(true);
        	
        	}else{
        		this.gubun  = "02"; 
        		
        		//외부 상품조회시 아이템 유형 콤보박스 visible값 false이기 때문에 상품명 조회 박스 right값을 늘려준다.
        		this.edt_itemNm.set_right(115);
        	}
        	
        	this.tabGubun = "005";  //기획
        	
        	this.preDate = this.gfn_Today();
        	//사업장 세팅
        	this.edt_upjang.set_value(application.g_UpjangNm);	
        	this.upjang = application.g_Upjang;	
        	
        	var i;
        	for (i = 0; i < this.ds_grd.getRowCount(); i++)
        	{
        		var imgFilePath = this.ds_grd.getColumn(i, "imgPath");
        		this.ds_grd.setColumn(i, "imgPath", "URL(" + nexacro.wrapQuote("svc::"+imgFilePath) +")");			
        	}
        	
        }

        /*==========================================================================
         * 사업장 검색 팝업 호출
        *========================================================================*/
        this.btn_upjang_onclick = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.edt_upjang.value;
        	if(application.g_Mu_Cd == "2004")
        	{
        		arg[2] = "FMS";
        	}
        	else
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
        	}
        	
        	application.goMain.gfn_POP_create("upjangNm", "M_MLM::WorkplaceSearchPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        /*==========================================================================
         * 아이템 유형 콤보 팝업 창 호출
        *========================================================================*/
        this.cbo_itemType_ondropdown = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_itemType;
        	arg[1] = "조회조건(상품유형)";
        	arg[2] = "";
        	arg[3] = "cdNm";
        	application.goMain.gfn_POP_create("itemType", "cmmn::CmmnComboList.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        //상단 버튼에 따라 cssclass변경
        this.btn_all_onclick = function(obj,e)
        {
        	this.btn_all.set_cssclass("btn_WF_TabMFOn");
        	this.btn_gubun00.set_cssclass("btn_WF_TabMFOff");
        	this.btn_gubun01.set_cssclass("btn_WF_TabMFOff");
        	this.tabGubun = "005";  //기획
        	
        	this.btn_search_onclick();
        	
        }

        //상단 버튼에 따라 cssclass변경
        this.btn_gubun00_onclick = function(obj,e)
        {
        	this.btn_all.set_cssclass("btn_WF_TabMFOff");
        	this.btn_gubun00.set_cssclass("btn_WF_TabMFOn");
        	this.btn_gubun01.set_cssclass("btn_WF_TabMFOff");
        	this.tabGubun = "001"; //PB상품
        	
        	this.btn_search_onclick();
        }

        //상단 버튼에 따라 cssclass변경
        this.btn_gubun01_onclick = function(obj,e)
        {
        	this.btn_all.set_cssclass("btn_WF_TabMFOff");
        	this.btn_gubun00.set_cssclass("btn_WF_TabMFOff");
        	this.btn_gubun01.set_cssclass("btn_WF_TabMFOn");
        	this.tabGubun = "";
        	
        	this.btn_search_onclick();
        }

        this.grd_list_oncellclick = function(obj,e)
        {
        	var arg = new Array();
        	var nRow = e.row;
        	arg[0] = this.ds_grd.getColumn(nRow, "imgPath");
        	
        	application.goMain.gfn_POP_create("itemImage", "M_MPI::ProductInformaionImgPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;

        }

        
        /*******************************************************************************
        * 기      능   :  검색
        * 설      명   :  등록
        ********************************************************************************/
        this.btn_search_onclick = function(obj,e)
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
        	if ( this.gfn_isNull(this.tabGubun) && this.gfn_isNull(this.edt_itemNm.value) ) {
        		application.goMain.gfn_Msg("ALERT_0", "알림", "품목명을 입력하세요.", "OK");
        		return false;
        	}
        	var itemName = this.edt_itemNm.text;
        	
        	var itemType = "";
        	
        	if(!this.gfn_isNull(this.itemType))
        	{
        		itemType = this.ds_itemType.getColumn(this.itemType, "cd");
        	}	
        	   
        	var strSvcID   		 = "search";
        	var strUrl     		 = "ms/mpi/selectList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "ds_grdServer=ds_output";
        	var strArguments	 = "upjang=" + nexacro.wrapQuote(this.upjang);
        	    strArguments     += " itemCdNm=" + nexacro.wrapQuote(this.gfn_transNullToEmpty(itemName));
        	    strArguments	 += " today=" + nexacro.wrapQuote(this.preDate);	
        	    strArguments	 += " gubun=" + nexacro.wrapQuote(this.gubun);	
        	    strArguments	 += " itemType=" + nexacro.wrapQuote(itemType);	        //ITEM 유형
        	    strArguments	 += " itemGubun=" + nexacro.wrapQuote(this.tabGubun);	//005:기획자재, 001:PB상품
        	    strArguments	 += " curPageNum=" + nexacro.wrapQuote(this.fv_curPageNum);	// TODO 현재 페이지번호 추가
        	    strArguments	 += " pageRow=" + nexacro.wrapQuote(this.fv_pageRow);	// TODO 페이지당 건수
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
          	// connect the server 
        	
        }

        this.edt_itemNm_onchanged = function(obj,e)
        {
        	this.edt_itemNm.set_autoselect(false);
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
        		//상품조회
                case "search" :
        			// TODO parameter로 전체건수를 받는다.
        			this.fv_totalpageRow = this.ds_grdServer.getColumn(0, "totCnt");	
        						
        			for(var i=0; i < this.ds_grdServer.rowcount; i++)
        			{		
        				var imgPath = this.makeEprocImageUrl(this.gfn_transNullToEmpty(this.ds_grdServer.getColumn(i, "imgPath")));
        				
        				if(imgPath.indexOf('100') >= 0)
        				{
        					this.ds_grdServer.setColumn(i, "imgPath", imgPath);
        				}
        				else
        				{
        					this.ds_grdServer.setColumn(i, "imgPath", "URL('HWImage::img_WF_NoImage.png')");
        				}
        						    
        			}				
        			
        			this.btn_moreView.set_enable(true);
        			
        			 // 조회 건수 확인  
                    if (this.ds_grdServer.getRowCount() == 0) 
                    {
                        application.goMain.gfn_Msg("alertTest", "Information", "조회되는 내용이 없습니다.", "OK");	//조회되는 내용이 없습니다.
                        this.btn_moreView.set_visible(false);
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
        				
        				if(this.fv_totalpageRow == this.fv_curPageNumAft)
        				{
        					this.btn_moreView.set_enable(false);
        				}
                    }
          			break;
            
            }    
            
        }

        // 더보기 버튼 onclick event
        this.btn_moreView_onclick = function(obj,e)
        {
        	this.fv_curPageNum = this.fv_curPageNum+this.fv_pageRow;
        	this.fn_search();
        }

        /*******************************************************************************
        * 기      능   :  팝업 callBack
        * 설      명   :  팝업이 닫히면서 전달된 값
        ********************************************************************************/ 
        this.fn_callbackPOP = function (popname,rtn)
        {
        	switch (popname)
        	{
        		case "upjangNm":
        			this.edt_upjang.set_value(rtn[1]);
        			this.upjang = rtn[0];			
        			break;
        		case "itemNm":
        			this.edt_itemNm.set_value(rtn[1]);
        			break;
        		case "itemType":
        			this.cbo_itemType.set_index(rtn);
        			this.itemType = rtn;
        			break;	
        		case "itemImage":
        			break;		
        	}
        }

        /*================================================================================
         * 6. 공통 기능(하단 메뉴 사라짐_top버튼 보임)
         *===============================================================================*/
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
        		
        		if (this.fv_totalpageRow == this.fv_curPageNumAft) {
        			this.btn_moreView.set_visible(true);
        		}
        	}
        	else
        	{
        		this.parent.btnGoTopDiv.set_visible(true);
        		
        		this.parent.btnGoTopDiv.set_bottom(50);
        		
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
            this.btn_gubun01.addEventHandler("onclick", this.btn_gubun01_onclick, this);
            this.btn_gubun00.addEventHandler("onclick", this.btn_gubun00_onclick, this);
            this.btn_all.addEventHandler("onclick", this.btn_all_onclick, this);
            this.edt_itemNm.addEventHandler("onchanged", this.edt_itemNm_onchanged, this);
            this.btn_search.addEventHandler("onclick", this.btn_search_onclick, this);
            this.btn_moreView.addEventHandler("onclick", this.btn_moreView_onclick, this);
            this.edt_upjang.addEventHandler("onchanged", this.edt_upjang_onchanged, this);
            this.btn_upjang.addEventHandler("onclick", this.btn_upjang_onclick, this);
            this.cbo_itemType.addEventHandler("ondropdown", this.cbo_itemType_ondropdown, this);
            this.grd_list.addEventHandler("onvscroll", this.grd_list_onvscroll, this);
            this.grd_list.addEventHandler("oncellclick", this.grd_list_oncellclick, this);
            this.grd_list.addEventHandler("onslide", this.grd_list_onslide, this);

        };

        this.loadIncludeScript("ProductInformation.xfdl", true);

       
    };
}
)();
