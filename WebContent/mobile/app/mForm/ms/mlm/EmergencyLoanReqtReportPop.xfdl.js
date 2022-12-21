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
                this.set_name("EmergencyLoanReqtReportPop");
                this.set_titletext("여신신청내역");
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
            obj._setContents("<ColumnInfo><Column id=\"upjang\" type=\"STRING\" size=\"256\"/><Column id=\"upjangnm\" type=\"STRING\" size=\"256\"/><Column id=\"mainUpjang\" type=\"STRING\" size=\"256\"/><Column id=\"upjangDisp\" type=\"STRING\" size=\"256\"/><Column id=\"reqDate\" type=\"STRING\" size=\"256\"/><Column id=\"reqUser\" type=\"STRING\" size=\"256\"/><Column id=\"creditOverEnd\" type=\"STRING\" size=\"256\"/><Column id=\"creditBefEnd\" type=\"STRING\" size=\"256\"/><Column id=\"creditOverAmount\" type=\"STRING\" size=\"256\"/><Column id=\"creditBefAmount\" type=\"STRING\" size=\"256\"/><Column id=\"creditAddAmount\" type=\"STRING\" size=\"256\"/><Column id=\"apprYn\" type=\"STRING\" size=\"256\"/><Column id=\"apprUser\" type=\"STRING\" size=\"256\"/><Column id=\"remark\" type=\"STRING\" size=\"256\"/><Column id=\"headCreditYn\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_apprCd", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"256\"/><Column id=\"cdNm\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"cd\">Y</Col><Col id=\"cdNm\">승인</Col></Row><Row><Col id=\"cd\">N</Col><Col id=\"cdNm\">미승인</Col></Row><Row><Col id=\"cd\">C</Col><Col id=\"cdNm\">반려</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "520", "670", null, null, this);
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "0", "520", "70", null, null, this);
            obj.set_taborder("7");
            obj.set_cssclass("sta_POP_TitleBg");
            obj.set_text("여신신청내역");
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

            obj = new Static("Static07", "absolute", "568", "72", null, "59", "-568", null, this);
            obj.set_taborder("14");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "568", "72", "135", "59", null, null, this);
            obj.set_taborder("15");
            obj.set_text("요청일자");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Calendar("cal_dtFrom", "absolute", "707", "78", "209", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("16");
            obj.set_dateformat("yyyy-MM-dd");
            obj.set_value("null");

            obj = new Button("btn_search", "absolute", null, "78", "100", "47", "-558", null, this);
            obj.set_taborder("17");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "568", "131", "540", "10", null, null, this);
            obj.set_taborder("18");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
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
            obj.set_extendsizetype("none");
            obj.set_nodataimage("URL('theme://Image/grd_WF_NoDataImg.png')");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"184\"/><Column size=\"94\"/><Column size=\"72\"/><Column size=\"34\"/><Column size=\"58\"/><Column size=\"62\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"GrayLabel\"/><Cell col=\"1\" text=\"WhiteLabel\"/><Cell col=\"2\" text=\"WhiteLabel\"/><Cell col=\"3\"/><Cell col=\"4\"/><Cell col=\"5\"/></Band><Band id=\"body\"><Cell celltype=\"none\" displaytype=\"normal\" edittype=\"none\" style=\"align:left middle;padding:0 5 0 5;background:#74748aff;background2:#74748aff;color:white;color2:white;selectbackground:#74748aff;selectcolor:white;\" text=\"요청일자\" autosizerow=\"limitmin\"/><Cell col=\"1\" colspan=\"5\" celltype=\"none\" displaytype=\"date\" edittype=\"none\" style=\"align:right middle;padding:0 5 0 10;background:#74748aff;background2:#74748aff;color:white;color2:white;selectbackground:#74748aff;selectcolor:white;\" text=\"bind:reqDate\" autosizerow=\"limitmin\"/><Cell row=\"1\" style=\"align:left middle;padding:0 5 0 5;background:whitesmoke;background2:whitesmoke;selectbackground:whitesmoke;\" text=\"사업장\" autosizerow=\"limitmin\"/><Cell row=\"1\" col=\"1\" colspan=\"5\" style=\"align:right middle;padding:0 10 0 10;background:white;background2:white;selectbackground:white;\" text=\"bind:upjangnm\" autosizerow=\"limitmin\"/><Cell row=\"2\" style=\"align:left middle;padding:0 5 0 5;background:whitesmoke;background2:whitesmoke;selectbackground:whitesmoke;\" text=\"통합관리여부\" autosizerow=\"limitmin\"/><Cell row=\"2\" col=\"1\" style=\"align:center middle;background:white;background2:white;selectbackground:white;\" text=\"bind:headCreditYn\" autosizerow=\"limitmin\"/><Cell row=\"2\" col=\"2\" colspan=\"2\" style=\"background:whitesmoke;background2:whitesmoke;selectbackground:whitesmoke;\" text=\"요청자\" autosizerow=\"limitmin\"/><Cell row=\"2\" col=\"4\" colspan=\"2\" style=\"align:right middle;padding:0 10 0 10;background:white;background2:white;selectbackground:white;\" text=\"bind:reqUser\" autosizerow=\"limitmin\"/><Cell row=\"3\" celltype=\"none\" style=\"align:left middle;padding:0 5 0 5;background:whitesmoke;background2:whitesmoke;selectbackground:whitesmoke;\" text=\"종료일(이전)\" autosizerow=\"limitmin\"/><Cell row=\"3\" col=\"1\" colspan=\"5\" displaytype=\"date\" style=\"align:right middle;padding:0 10 0 10;background:white;background2:white;selectbackground:white;selectcolor: ;\" text=\"bind:creditBefEnd\" maskchar=\"-\" calendardisplay=\"edit\" calendardisplaynulltype=\"none\" autosizerow=\"limitmin\"/><Cell row=\"4\" style=\"align:left middle;padding:0 5 0 5;background:whitesmoke;background2:whitesmoke;selectbackground:whitesmoke;\" text=\"요청금액(이전)\" autosizerow=\"limitmin\"/><Cell row=\"4\" col=\"1\" colspan=\"5\" displaytype=\"number\" style=\"align:right middle;padding:0 10 0 10;background:white;background2:white;selectbackground:white;selectcolor: ;\" text=\"bind:creditBefAmount\" mask=\"###,###,###.##\" autosizerow=\"limitmin\"/><Cell row=\"5\" style=\"align:left middle;padding:0 5 0 5;background:whitesmoke;background2:whitesmoke;selectbackground:whitesmoke;\" text=\"종료일(이후)\" autosizerow=\"limitmin\"/><Cell row=\"5\" col=\"1\" colspan=\"5\" displaytype=\"date\" style=\"align:right middle;padding:0 10 0 10;background:white;background2:white;color:EXPR(apprYn== &quot;Y&quot;?&quot;blue&quot;:(apprYn == &quot;C&quot;?&quot;red&quot;:&quot;&quot;));color2:EXPR(apprYn== &quot;Y&quot;?&quot;blue&quot;:(apprYn == &quot;C&quot;?&quot;red&quot;:&quot;&quot;));selectbackground:white;selectcolor:EXPR(apprYn== &quot;Y&quot;?&quot;blue&quot;:(apprYn == &quot;C&quot;?&quot;red&quot;:&quot;&quot;));\" text=\"bind:creditOverEnd\" calendardisplaynulltype=\"none\" autosizerow=\"limitmin\"/><Cell row=\"6\" style=\"align:left middle;padding:0 5 0 5;background:whitesmoke;background2:whitesmoke;selectbackground:whitesmoke;\" text=\"추가금액(이후)\" autosizerow=\"limitmin\"/><Cell row=\"6\" col=\"1\" colspan=\"5\" displaytype=\"number\" style=\"align:right middle;padding:0 10 0 10;background:white;background2:white;color:EXPR(apprYn== &quot;Y&quot;?&quot;blue&quot;:(apprYn == &quot;C&quot;?&quot;red&quot;:&quot;&quot;));color2:EXPR(apprYn== &quot;Y&quot;?&quot;blue&quot;:(apprYn == &quot;C&quot;?&quot;red&quot;:&quot;&quot;));selectbackground:white;selectcolor:EXPR(apprYn== &quot;Y&quot;?&quot;blue&quot;:(apprYn == &quot;C&quot;?&quot;red&quot;:&quot;&quot;));\" text=\"bind:creditAddAmount\" mask=\"###,###,###.##\" autosizerow=\"limitmin\"/><Cell row=\"7\" style=\"align:left middle;padding:0 5 0 5;background:whitesmoke;background2:whitesmoke;selectbackground:whitesmoke;\" text=\"승인여부\" autosizerow=\"limitmin\"/><Cell row=\"7\" col=\"1\" displaytype=\"combo\" style=\"align:center middle;padding:0 10 0 10;background:white;background2:white;color:EXPR(apprYn== &quot;Y&quot;?&quot;blue&quot;:(apprYn == &quot;C&quot;?&quot;red&quot;:&quot;&quot;));color2:EXPR(apprYn== &quot;Y&quot;?&quot;blue&quot;:(apprYn == &quot;C&quot;?&quot;red&quot;:&quot;&quot;));selectbackground:white;selectcolor:EXPR(apprYn== &quot;Y&quot;?&quot;blue&quot;:(apprYn == &quot;C&quot;?&quot;red&quot;:&quot;&quot;));\" text=\"bind:apprYn\" combodataset=\"ds_apprCd\" combocodecol=\"cd\" combodatacol=\"cdNm\" autosizerow=\"limitmin\"/><Cell row=\"7\" col=\"2\" colspan=\"2\" displaytype=\"number\" style=\"align:left middle;padding:0 5 0 10;background:whitesmoke;background2:whitesmoke;selectbackground:whitesmoke;\" text=\"승인자\" autosizerow=\"limitmin\"/><Cell row=\"7\" col=\"4\" colspan=\"2\" displaytype=\"number\" style=\"align:right middle;padding:0 10 0 10;background:white;background2:white;selectbackground:white;\" text=\"bind:apprUser\" autosizerow=\"limitmin\"/><Cell row=\"8\" colspan=\"6\" style=\"align:left middle;padding:0 5 0 5;background:white;background2:white;selectbackground:white;\" text=\"bind:remark\" autosizerow=\"limitmin\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 520, 670, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frmCalendar");
            		p.getSetter("inheritanceid").set("");
            		p.set_titletext("여신신청내역");
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
        this.addIncludeScript("EmergencyLoanReqtReportPop.xfdl", "lib::lib_Com.xjs");
        this.registerScript("EmergencyLoanReqtReportPop.xfdl", function(exports) {
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
        this.creditId = undefined;
        this.sabun = undefined;
        this.mainUpjang = undefined;
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
        	
        	this.creditId = this.arg[0];
        	this.sabun = application.g_EmpNo;
        		
        	if ( !this.gfn_isNull(this.creditId) )
        	{
        		this.sabun = "";
        	}
        	
        	this.ds_grd.clearData();	
        	
        	application.goMain.gfn_POP_resize(this);
        }

        this.div_additionOrder_cal_dtTo_ondropdown = function(obj,e)
        {
        	var objCalArg = obj.value;
        	
        	application.goMain.gfn_POP_create("PopCalFrom", application.goMain.divBase.div_calendar, "fn_callbackPOP", this, objCalArg, "POPDivx", application.goMain.divBase);
        	return false;
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
        	this.fn_init();    
        	
        	var strSvcID   		 = "search";
        	var strUrl     		 = "ms/mlm/emergencyLoanReqt/selectHistList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "ds_grd=ds_list";
        	var strArguments	 = "sabun=" + nexacro.wrapQuote(this.gfn_transNullToEmpty(this.sabun));
        		strArguments     += " creditId=" + nexacro.wrapQuote(this.gfn_transNullToEmpty(this.creditId));
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
        		case "PopCalFrom":
        			this.cal_dtFrom.set_value(rtn);
        			break;
        	}
        }

        this.grd_list_onkeyup = function(obj,e)
        {
        	if(e.keycode == 13)
        	{		
        		this.grd_list.updateToDataset();
        	}
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);
            this.Static05.addEventHandler("onclick", this.Static05_onclick, this);
            this.cal_dtFrom.addEventHandler("ondropdown", this.div_additionOrder_cal_dtTo_ondropdown, this);
            this.grd_list.addEventHandler("onkeyup", this.grd_list_onkeyup, this);

        };

        this.loadIncludeScript("EmergencyLoanReqtReportPop.xfdl", true);

       
    };
}
)();
