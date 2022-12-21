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
                this.set_name("CmmnPushPop");
                this.set_scrollbars("none");
                this.set_titletext("받은알림");
                this._setFormPosition(0,0,420,304);
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
            obj._setContents("<ColumnInfo><Column id=\"title\" type=\"STRING\" size=\"256\"/><Column id=\"body\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "420", "299", null, null, this);
            obj.set_taborder("0");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "0", "0", null, null, "0", "129", this);
            obj.set_taborder("34");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list", "absolute", "0", "0", null, null, "0", "0", this);
            obj.set_cssclass("grd_WF_noline");
            obj.set_taborder("35");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("autovert");
            obj.set_extendsizetype("row");
            obj.set_cellsizingtype("row");
            obj.set_autosizingtype("row");
            obj.set_useselcolor("false");
            obj.style.set_opacity("85");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"420\"/></Columns><Rows><Row size=\"55\"/><Row size=\"248\"/><Row size=\"1\"/></Rows><Band id=\"body\"><Cell style=\"align:center middle;padding:0 10 0 10;background:#f2f2f2ff;background2:#f2f2f2ff;font:antialias 15 Droid Sans;\" text=\"bind:title\" autosizerow=\"limitmin\"/><Cell row=\"1\" style=\"align:left middle;padding:0 50 0 50;selectbackground: ;\" text=\"bind:body\" wordwrap=\"true\" autosizerow=\"limitmin\"/><Cell row=\"2\" style=\"font:5 arial;\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 420, 304, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_COMP_03");
            		p.set_scrollbars("none");
            		p.set_titletext("받은알림");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("CmmnPushPop.xfdl", "lib::lib_Com.xjs");
        this.registerScript("CmmnPushPop.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		PUSH알림 팝업창
        // [부시스템명]	PUSH알림 팝업창
        // [설명]		    PUSH알림 팝업창
        // [작성자명] 		강대성
        // [작성일자]		2015.06.18
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.06.18 : 강대성 : PUSH알림 수신시 팝업창 띄움
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*======================================================
         전역변수
         ======================================================*/

        
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
        	this.arg = application.goMain.gfn_POP_getArg();
        	
        	var nRow = this.ds_grd.addRow();
        	this.ds_grd.setColumn(nRow, "title", this.arg[0]);
        	this.ds_grd.setColumn(nRow, "body", this.arg[1]);	
        	
        	application.goMain.gfn_POP_resize(this);
        }

        /*******************************************************************************
        * 기      능   :  화면 터치시 화면 닫음
        * 설      명   :  화면 터치시 화면 닫음
        ********************************************************************************/ 
        this.grdAlramList_ontouchend = function(obj,e)
        {
        	application.goMain.gfn_POP_close(this, "CLOSEONLY");
        }

        

        
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.grd_list.addEventHandler("ontouchend", this.grdAlramList_ontouchend, this);

        };

        this.loadIncludeScript("CmmnPushPop.xfdl", true);

       
    };
}
)();
