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
                this.set_name("TeamLeaderAppTestAcceptDetailPop");
                this.set_titletext("시험접수승인 상세내용");
                this.set_scrollbars("none");
                this.set_enable("true");
                this._setFormPosition(0,0,520,670);
            }
            this.getSetter("inheritanceid").set("");

            
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
            obj._setContents("<ColumnInfo><Column id=\"reqNum\" type=\"STRING\" size=\"256\"/><Column id=\"gubunNm\" type=\"STRING\" size=\"256\"/><Column id=\"acceptNum\" type=\"STRING\" size=\"256\"/><Column id=\"specmNm\" type=\"STRING\" size=\"256\"/><Column id=\"insptPurp1Nm\" type=\"STRING\" size=\"256\"/><Column id=\"insptPurp2Nm\" type=\"STRING\" size=\"256\"/><Column id=\"specmType1Nm\" type=\"STRING\" size=\"256\"/><Column id=\"specmType2Nm\" type=\"STRING\" size=\"256\"/><Column id=\"insptObj\" type=\"STRING\" size=\"256\"/><Column id=\"acceptdd\" type=\"STRING\" size=\"256\"/><Column id=\"testScheDd\" type=\"STRING\" size=\"256\"/><Column id=\"legalBasis\" type=\"STRING\" size=\"256\"/><Column id=\"insideBasis\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"reqNum\"/></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "520", "670", null, null, this);
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "0", "520", "70", null, null, this);
            obj.set_taborder("7");
            obj.set_cssclass("sta_POP_TitleBg");
            obj.set_text("상세내용");
            this.addChild(obj.name, obj);

            obj = new Button("btnClose", "absolute", null, "0", "70", "70", "0", null, this);
            obj.set_taborder("6");
            obj.set_cssclass("btn_POP_XBtn");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "442", "660", "102", "10", null, null, this);
            obj.set_taborder("9");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("right middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "0", "588", "10", "100", null, null, this);
            obj.set_taborder("10");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("left bottom");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "510", "588", "10", "100", null, null, this);
            obj.set_taborder("11");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("left bottom");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "29.23%", "80", null, "84", "26.92%", null, this);
            obj.set_taborder("12");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "70", null, "2", "0", null, this);
            obj.set_taborder("13");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);

            obj = new Static("Static43", "absolute", "119", "89", "20", "29", null, null, this);
            obj.set_taborder("19");
            obj.set_text("글자사이간격w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list", "absolute", "8", "72", "505", "588", null, null, this);
            obj.set_taborder("20");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_selecttype("row");
            obj.set_autosizingtype("row");
            obj.set_extendsizetype("row");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"131\"/><Column size=\"74\"/><Column size=\"59\"/><Column size=\"34\"/><Column size=\"39\"/><Column size=\"167\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\"/><Row size=\"45\"/><Row size=\"45\"/><Row size=\"45\"/><Row size=\"45\"/><Row size=\"45\"/><Row size=\"45\"/><Row size=\"45\"/><Row size=\"45\"/><Row size=\"45\"/><Row size=\"45\"/><Row size=\"45\"/></Rows><Band id=\"head\"><Cell text=\"GrayLabel\"/><Cell col=\"1\" text=\"WhiteLabel\"/><Cell col=\"2\" text=\"WhiteLabel\"/><Cell col=\"3\"/><Cell col=\"4\"/><Cell col=\"5\"/></Band><Band id=\"body\"><Cell celltype=\"none\" displaytype=\"normal\" edittype=\"none\" style=\"align:left middle;padding:0 5 0 5;background:#74748aff;background2:#74748aff;color:white;color2:white;selectbackground:#74748aff;selectcolor:white;\" expr=\"currow+1\" autosizerow=\"limitmin\"/><Cell col=\"1\" colspan=\"5\" celltype=\"none\" displaytype=\"normal\" edittype=\"none\" style=\"align:left middle;padding:0 5 0 5;background:#74748aff;background2:#74748aff;color:white;color2:white;selectbackground:#74748aff;selectcolor:white;\" text=\"bind:specmNm\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"1\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"검사용도\" autosizerow=\"limitmin\"/><Cell row=\"1\" col=\"1\" colspan=\"5\" style=\"align:left middle;padding:0 5 0 5;background:white;background2:white;selectbackground:white;\" text=\"bind:insptPurp1Nm\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"2\" celltype=\"none\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"실험방법\" autosizerow=\"limitmin\"/><Cell row=\"2\" col=\"1\" colspan=\"5\" displaytype=\"number\" style=\"align:left middle;padding:0 5 0 5;background:white;background2:white;selectbackground:white;selectcolor: ;\" text=\"bind:insptPurp2Nm\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"3\" rowspan=\"2\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"검체유형\" autosizerow=\"limitmin\"/><Cell row=\"3\" col=\"1\" colspan=\"5\" displaytype=\"normal\" style=\"align:left middle;padding:0 5 0 5;background:white;background2:white;selectbackground:white;\" text=\"bind:specmType1Nm\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"4\" col=\"1\" colspan=\"5\" style=\"align:left middle;padding:0 5 0 5;background:white;background2:white;selectbackground:white;\" text=\"bind:specmType2Nm\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"5\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"검사대상\" autosizerow=\"limitmin\"/><Cell row=\"5\" col=\"1\" colspan=\"5\" displaytype=\"normal\" style=\"align:left middle;padding:0 5 0 5;background:white;background2:white;selectbackground:white;\" text=\"bind:insptObj\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"6\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"접수일\" autosizerow=\"limitmin\"/><Cell row=\"6\" col=\"1\" colspan=\"5\" displaytype=\"date\" style=\"align:left middle;padding:0 5 0 5;background:white;background2:white;selectbackground:white;\" text=\"bind:acceptdd\" autosizerow=\"limitmin\"/><Cell row=\"7\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"완료예정일\" autosizerow=\"limitmin\"/><Cell row=\"7\" col=\"1\" colspan=\"5\" displaytype=\"date\" style=\"align:left middle;padding:0 5 0 5;background:white;background2:white;selectbackground:white;\" text=\"bind:testScheDd\" autosizerow=\"limitmin\"/><Cell row=\"8\" colspan=\"6\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"검사항목(세팅)_법적기준\" autosizerow=\"limitmin\"/><Cell row=\"9\" colspan=\"6\" style=\"align:left middle;padding:0 5 0 5;background:white;background2:white;selectbackground:white;\" text=\"bind:legalBasis\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"10\" colspan=\"6\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"검사항목(세팅)_내부기준\" autosizerow=\"limitmin\"/><Cell row=\"11\" colspan=\"6\" style=\"align:left middle;padding:0 5 0 5;background:white;background2:white;selectbackground:white;\" text=\"bind:insideBasis\" wordwrap=\"char\" autosizerow=\"limitmin\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Button("btn_moreView", "absolute", "128", null, null, "42", "136", "0", this);
            obj.set_taborder("21");
            obj.set_visible("false");
            obj.style.set_background("darkgray");
            obj.style.set_color("white");
            obj.style.set_opacity("75");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 520, 670, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frmCalendar");
            		p.getSetter("inheritanceid").set("");
            		p.set_titletext("시험접수승인 상세내용");
            		p.set_scrollbars("none");
            		p.set_enable("true");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("TeamLeaderAppTestAcceptDetailPop.xfdl", "lib::lib_Com.xjs");
        this.registerScript("TeamLeaderAppTestAcceptDetailPop.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		임시여신신청
        // [부시스템명]	임시여신신청
        // [설명]		    임시여신신청하기.
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
        this.preDate = undefined;
        this.fv_totalpageRow;	// 전체건수
        this.reqNum = undefined;
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
        	this.fn_search();
        }

        // 데이터 초기화
        this.fn_init = function ()
        {
        	//this.fsp_init();
        	this.arg = application.goMain.gfn_POP_getArg();
        	
        	this.reqNum = this.arg[1];
        	this.ds_grd.clearData();	
        	
        	//this.cal_dtFrom.set_dateformat("yyyyMMdd");
        	application.goMain.gfn_POP_resize(this);
        }

        //상단 x 버튼 클릭 시
        this.btnClose_onclick = function(obj,e)
        {
        	application.goMain.gfn_POP_close(this , this.preDate);
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
        	this.ds_grd.clearData();
        	
        	var strSvcID   		 = "search";
        	var strUrl     		 = "ms/mtm/teamLeaderApp/selectDetailList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "ds_grd=ds_list";
        	var strArguments	 = "reqNum=" + nexacro.wrapQuote(this.reqNum);
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
        		//상품발주현황조회
                case "search" :
        			// TODO parameter로 전체건수를 받는다.
        			this.fv_totalpageRow = this.ds_grd.getRowCount();			
        			
        			
                    // 조회 건수 확인  
                    if (this.ds_grd.getRowCount() == 0) 
                    {
                        application.goMain.gfn_Msg("alertTest", "Information", "조회되는 내용이 없습니다.", "OK");	//조회되는 내용이 없습니다.
                        return;
                    }
                    else
                    {
        				// 추가발주승인 및 마감취소승인 조회
        				this.btn_moreView.set_visible(true);
        				this.btn_moreView.set_text("총건수:" +this.fv_totalpageRow);
        			}	
          			break;  		
            }     
            
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);
            this.Static05.addEventHandler("onclick", this.Static05_onclick, this);
            this.btn_moreView.addEventHandler("onclick", this.div_tab01_btn_moreView_onclick, this);

        };

        this.loadIncludeScript("TeamLeaderAppTestAcceptDetailPop.xfdl", true);

       
    };
}
)();
