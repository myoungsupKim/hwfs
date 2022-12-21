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
                this.set_name("OrderReturnReportPop");
                this.set_titletext("구매취소상세현황팝업");
                this.set_scrollbars("none");
                this.set_enable("true");
                this._setFormPosition(0,0,520,397);
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
            obj._setContents("<ColumnInfo><Column id=\"upjangSubinv\" type=\"STRING\" size=\"256\"/><Column id=\"returnDatetime\" type=\"STRING\" size=\"256\"/><Column id=\"needDate\" type=\"STRING\" size=\"256\"/><Column id=\"typeName\" type=\"STRING\" size=\"256\"/><Column id=\"itemCode\" type=\"STRING\" size=\"256\"/><Column id=\"itemName\" type=\"STRING\" size=\"256\"/><Column id=\"itemSize\" type=\"STRING\" size=\"256\"/><Column id=\"poUom\" type=\"STRING\" size=\"256\"/><Column id=\"prQty\" type=\"STRING\" size=\"256\"/><Column id=\"custnm\" type=\"STRING\" size=\"256\"/><Column id=\"prRemark\" type=\"STRING\" size=\"256\"/><Column id=\"rcUpjang\" type=\"STRING\" size=\"256\"/><Column id=\"muNm\" type=\"STRING\" size=\"256\"/><Column id=\"tmNm\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "520", "394", null, null, this);
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

            obj = new Static("Static02", "absolute", "442", "572", "102", "10", null, null, this);
            obj.set_taborder("9");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("right middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "0", "476", "10", "100", null, null, this);
            obj.set_taborder("10");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("left bottom");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "510", "500", "10", "100", null, null, this);
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

            obj = new Grid("grd_list", "absolute", "8", "72", "505", "315", null, null, this);
            obj.set_taborder("20");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_selecttype("row");
            obj.set_autosizingtype("row");
            obj.set_extendsizetype("row");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"131\"/><Column size=\"74\"/><Column size=\"59\"/><Column size=\"34\"/><Column size=\"39\"/><Column size=\"167\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"45\"/><Row size=\"45\"/><Row size=\"45\"/><Row size=\"45\"/><Row size=\"45\"/><Row size=\"45\"/><Row size=\"45\"/></Rows><Band id=\"head\"><Cell text=\"GrayLabel\"/><Cell col=\"1\" text=\"WhiteLabel\"/><Cell col=\"2\" text=\"WhiteLabel\"/><Cell col=\"3\"/><Cell col=\"4\"/><Cell col=\"5\"/></Band><Band id=\"body\"><Cell style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"규격\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell col=\"1\" colspan=\"5\" displaytype=\"normal\" style=\"align:left middle;padding:0 10 0 10;background:white;background2:white;selectbackground:white;\" text=\"bind:itemSize\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"1\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"발주량\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"1\" col=\"1\" colspan=\"5\" displaytype=\"number\" style=\"align:left middle;padding:0 10 0 10;background:white;background2:white;selectbackground:white;\" text=\"bind:prQty\" wordwrap=\"char\" mask=\"###,###,###.##\" autosizerow=\"limitmin\"/><Cell row=\"2\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"취소수량\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"2\" col=\"1\" colspan=\"5\" displaytype=\"number\" style=\"align:left middle;padding:0 10 0 10;background:white;background2:white;selectbackground:white;\" text=\"bind:prQty\" wordwrap=\"char\" mask=\"###,###,###.##\" autosizerow=\"limitmin\"/><Cell row=\"3\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"취소일자\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"3\" col=\"1\" colspan=\"5\" displaytype=\"normal\" style=\"align:left middle;padding:0 10 0 10;background:white;background2:white;selectbackground:white;\" text=\"bind:returnDatetime\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"4\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"입고예정일\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"4\" col=\"1\" colspan=\"5\" displaytype=\"date\" style=\"align:left middle;padding:0 10 0 10;background:white;background2:white;selectbackground:white;\" text=\"bind:needDate\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"5\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"업체명\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"5\" col=\"1\" colspan=\"5\" displaytype=\"normal\" style=\"align:left middle;padding:0 10 0 10;background:white;background2:white;selectbackground:white;\" text=\"bind:custnm\" wordwrap=\"char\" calendardisplaynulltype=\"none\" autosizerow=\"limitmin\"/><Cell row=\"6\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"사유\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"6\" col=\"1\" colspan=\"5\" displaytype=\"normal\" style=\"align:left middle;padding:0 10 0 10;background:white;background2:white;selectbackground:white;\" text=\"bind:prRemark\" wordwrap=\"char\" calendardisplaynulltype=\"none\" autosizerow=\"limitmin\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 520, 397, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frmCalendar");
            		p.getSetter("inheritanceid").set("");
            		p.set_titletext("구매취소상세현황팝업");
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
        this.addIncludeScript("OrderReturnReportPop.xfdl", "lib::lib_Com.xjs");
        this.registerScript("OrderReturnReportPop.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		발주관리
        // [부시스템명]	구매취소상현황 - 구매취소상세현황팝업
        // [설명]		    구매취소상세현황팝업.
        // [작성자명] 		강대성
        // [작성일자]		2015.05.26
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.06.26 : 강대성 : 구매취소상세현황팝업 신규
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
        	
        }

        // 데이터 초기화
        this.fn_init = function ()
        {
        	//this.fsp_init();
        	this.arg = application.goMain.gfn_POP_getArg();
        	
        	var nRow = this.ds_grd.addRow();
        	this.ds_grd.setColumn(nRow, "prQty", this.arg[0]);           //발주량, 취소수량
        	this.ds_grd.setColumn(nRow, "returnDatetime", this.arg[1]);	 //취소일자/시간
        	this.ds_grd.setColumn(nRow, "needDate", this.arg[2]);        //입고예정일
        	this.ds_grd.setColumn(nRow, "custnm", this.arg[3]);          //업체명
        	this.ds_grd.setColumn(nRow, "prRemark", this.arg[4]);        //사유
        	this.ds_grd.setColumn(nRow, "itemSize", this.arg[5]);        //규격
        	
        	application.goMain.gfn_POP_resize(this);
        }

        //상단 x 버튼 클릭 시
        this.btnClose_onclick = function(obj,e)
        {
        	application.goMain.gfn_POP_close(this , this.preDate);
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);
            this.Static05.addEventHandler("onclick", this.Static05_onclick, this);

        };

        this.loadIncludeScript("OrderReturnReportPop.xfdl", true);

       
    };
}
)();
