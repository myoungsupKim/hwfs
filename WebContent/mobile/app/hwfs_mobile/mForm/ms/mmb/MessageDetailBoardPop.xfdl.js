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
                this.set_name("MessageDetailBoardPop");
                this.set_titletext("공지사항상세내용");
                this._setFormPosition(0,0,540,760);
            }
            this.style.set_padding("5 10 5 10");

            
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
            obj._setContents("<ColumnInfo><Column id=\"conId\" type=\"STRING\" size=\"256\"/><Column id=\"userId\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "540", "760", null, null, this);
            obj.set_taborder("44");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("sta_title", "absolute", "0", "0", "496", "70", null, null, this);
            obj.set_taborder("46");
            obj.set_text("제목");
            obj.set_cssclass("sta_POP_TitleBg");
            this.addChild(obj.name, obj);

            obj = new Button("btnClose", "absolute", "471", "0", "70", "70", null, null, this);
            obj.set_taborder("45");
            obj.set_cssclass("btn_POP_XBtn");
            this.addChild(obj.name, obj);

            obj = new Static("Static37", "absolute", "9", "70", null, "59", "8", null, this);
            obj.set_taborder("52");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "70", "10", "689", null, null, this);
            obj.set_taborder("50");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "531", "70", "10", "688", null, null, this);
            obj.set_taborder("48");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static38", "absolute", "0", "70", "135", "59", null, null, this);
            obj.set_taborder("53");
            obj.set_text("부서");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_dept", "absolute", "139", "76", null, "47", "10", null, this);
            obj.set_taborder("54");
            obj.set_enable("true");
            obj.set_readonly("true");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "10", "128", null, "59", "9", null, this);
            obj.set_taborder("55");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_writer", "absolute", "139", "134", null, "47", "297", null, this);
            obj.set_taborder("56");
            obj.set_enable("true");
            obj.set_readonly("true");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "0", "128", "135", "59", null, null, this);
            obj.set_taborder("57");
            obj.set_text("작성자");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_noticeDate", "absolute", "370", "134", null, "47", "10", null, this);
            obj.set_taborder("58");
            obj.set_enable("true");
            obj.set_readonly("true");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "248", "128", "135", "59", null, null, this);
            obj.set_taborder("59");
            obj.set_text("공지일");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new WebBrowser("webInfo", "absolute", "10", "238", null, null, "8", "1", this);
            obj.set_taborder("60");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "10", "193", "520", "39", null, null, this);
            obj.set_taborder("61");
            obj.set_text(" ※ 모바일 공지사항은 첨부파일 다운로드를 지원하지 않습니다. 첨부파일 있는경우 PC에서 다운받아 보시기 바랍니다.");
            obj.style.set_color("red");
            obj.style.set_font("bold antialias 10 Droid Sans");
            obj.set_wordwrap("char");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("공지사항상세내용");
            		p.style.set_padding("5 10 5 10");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information
            obj = new BindItem("item1","sta_title","text","ds_list","title");
            this.addChild(obj.name, obj);
            obj.bind();

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("MessageDetailBoardPop.xfdl", "lib::lib_Com.xjs");
        this.registerScript("MessageDetailBoardPop.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		가계약상세등록
        // [부시스템명]	가계약상세등록 - 조회
        // [설명]
        // 		부서 검색하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.02.09
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.09 : 강대성 : 수정이 필요하여 수정함.
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
        this.form_onload = function(obj,e)
        {
        	application.goMenu = this;	
        	
        	this.arg = application.goMain.gfn_POP_getArg();

        	this.webInfo.set_url(this.gfn_subStrB(application.services["svc"].url) + this.arg[0]); //상세내용	
        	
        	if(this.gfn_isNull(this.arg[2]))
         	{
        		this.edt_dept.set_value(this.arg[5]);       //부서명이 없을경우 업장명을 보여준다
         	}else{
        		this.edt_dept.set_value(this.arg[2]);       //부서
         	}
        	this.edt_writer.set_value(this.arg[3]);     //작성자
        	this.edt_noticeDate.set_value(this.arg[4]); //공지일
        	
        	var nRow = this.ds_grd.addRow();
        	this.ds_grd.setColumn(nRow, "conId", this.arg[6]); //게시키값
        	this.ds_grd.setColumn(nRow, "userId", application.g_userId); //userId
        	
        	this.sta_title.set_text("상세내용");
        	
        	//조회건수갱신 function호출
        	this.saveReadCnt();
        	
        	application.goMain.gfn_POP_resize(this);	
        	
        }

        /*******************************************************************************
        * 기      능   :  조회건수갱신
        * 설      명   :  조회건수갱신
        ********************************************************************************/
        this.saveReadCnt = function(obj,e)
        {
        	var strSvcID   		 = "saveReadCnt";
        	var strUrl     		 = "ms/mmb/messageBoard/saveList.xdo";
        	var strInDataset     = "ds_list=ds_grd:U";
        	var strOutDataset    = "";
        	var strArguments	 = "";
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
          	
        }

        //닫기버튼 클릭 시
        this.btnClose_onclick = function(obj,e)
        {
        	var arg = new Array();
        	application.goMain.gfn_POP_close(this, arg);
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);

        };

        this.loadIncludeScript("MessageDetailBoardPop.xfdl", true);

       
    };
}
)();
