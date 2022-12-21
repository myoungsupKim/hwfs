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
                this.set_name("InventoryNoWarehousePop");
                this.set_titletext("미입고리스트");
                this.set_scrollbars("none");
                this.set_enable("true");
                this._setFormPosition(0,0,520,539);
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
            obj._setContents("<ColumnInfo><Column id=\"DELIVERED_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"NEED_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"NONE_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"ORDER_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"UNDELIVERED_QTY\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row/></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_grdSum", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"SUM_DELIVERED_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"SUM_NONE_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"SUM_ORDER_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"SUM_UNDELIVERED_QTY\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row/></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "520", "538", null, null, this);
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "0", "520", "70", null, null, this);
            obj.set_taborder("7");
            obj.set_cssclass("sta_POP_TitleBg");
            obj.set_text("미입고리스트");
            this.addChild(obj.name, obj);

            obj = new Button("btnClose", "absolute", null, "0", "70", "70", "0", null, this);
            obj.set_taborder("6");
            obj.set_cssclass("btn_POP_XBtn");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "442", "528", "102", "10", null, null, this);
            obj.set_taborder("9");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("right middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "0", "428", "10", "100", null, null, this);
            obj.set_taborder("10");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("left bottom");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "510", "436", "10", "100", null, null, this);
            obj.set_taborder("11");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("left bottom");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "70", null, "2", "0", null, this);
            obj.set_taborder("13");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list", "absolute", "8", "254", "505", "274", null, null, this);
            obj.set_taborder("20");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_selecttype("row");
            obj.set_autosizingtype("none");
            obj.set_extendsizetype("none");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"153\"/><Column size=\"74\"/><Column size=\"59\"/><Column size=\"34\"/><Column size=\"39\"/><Column size=\"147\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"45\"/><Row size=\"45\"/><Row size=\"45\"/><Row size=\"45\"/><Row size=\"45\"/><Row size=\"45\"/></Rows><Band id=\"head\"><Cell text=\"GrayLabel\"/><Cell col=\"1\" text=\"WhiteLabel\"/><Cell col=\"2\" text=\"WhiteLabel\"/><Cell col=\"3\"/><Cell col=\"4\"/><Cell col=\"5\"/></Band><Band id=\"body\"><Cell style=\"align:left middle;padding:0 5 0 5;background:gainsboro;background2:gainsboro;color:black;color2:black;selectbackground:gainsboro;selectcolor:black;\" cssclass=\"CellGrd_WF_LabelIndigo\" text=\"입고예정일\" wordwrap=\"none\" autosizerow=\"limitmin\"/><Cell col=\"1\" colspan=\"5\" displaytype=\"date\" style=\"align:right middle;padding:0 5 0 5;background:gainsboro;background2:gainsboro;color:black;color2:black;selectbackground:gainsboro;selectcolor:black;\" cssclass=\"CellGrd_WF_LabelIndigo\" text=\"bind:NEED_DATE\" wordwrap=\"none\" autosizerow=\"default\"/><Cell row=\"1\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"자재코드/명\" wordwrap=\"none\" autosizerow=\"limitmin\"/><Cell row=\"1\" col=\"1\" colspan=\"5\" style=\"align:right middle;padding:0 5 0 5;background:white;background2:white;selectbackground:white;\" text=\"bind:ITEM_NAME\" wordwrap=\"none\" autosizerow=\"default\"/><Cell row=\"2\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"발주량\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"2\" col=\"1\" colspan=\"5\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 5;background:white;background2:white;selectbackground:white;\" text=\"bind:ORDER_QTY\" wordwrap=\"none\" autosizerow=\"default\"/><Cell row=\"3\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"기입고량\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"3\" col=\"1\" colspan=\"5\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 5;background:white;background2:white;selectbackground:white;\" text=\"bind:DELIVERED_QTY\" wordwrap=\"none\" autosizerow=\"default\"/><Cell row=\"4\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"감량\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"4\" col=\"1\" colspan=\"5\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 5;background:white;background2:white;selectbackground:white;\" text=\"bind:UNDELIVERED_QTY\" wordwrap=\"none\" autosizerow=\"default\"/><Cell row=\"5\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"미입고량\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"5\" col=\"1\" colspan=\"5\" displaytype=\"number\" style=\"align:right middle;padding:0 5 0 5;background:white;background2:white;selectbackground:white;\" text=\"bind:NONE_QTY\" wordwrap=\"none\" autosizerow=\"default\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list00", "absolute", "10", "79", null, "172", "10", null, this);
            obj.set_cssclass("grd_WF_SumType");
            obj.set_taborder("21");
            obj.set_binddataset("ds_grdSum");
            obj.set_scrollbars("none");
            obj.set_selecttype("cell");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"185\"/><Column size=\"314\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"5\"/><Row size=\"38\"/><Row size=\"38\"/><Row size=\"38\"/><Row size=\"38\"/><Row size=\"5\"/></Rows><Band id=\"head\"><Cell text=\"GrayLabel\"/><Cell col=\"1\"/></Band><Band id=\"body\"><Cell/><Cell col=\"1\"/><Cell row=\"1\" celltype=\"none\" style=\"align:left;padding:0 10 0 10;line:0 solid #808080ff ;\" text=\"발주량합계\"/><Cell row=\"1\" col=\"1\" displaytype=\"number\" style=\"align:right middle;padding:0 10 0 10;line:0 solid #808080ff ;\" text=\"bind:SUM_ORDER_QTY\" mask=\"#,##0.0\"/><Cell row=\"2\" celltype=\"none\" style=\"align:left;padding:0 10 0 10;line:0 solid #808080ff ;\" text=\"기입고량합계\"/><Cell row=\"2\" col=\"1\" displaytype=\"number\" style=\"align:right middle;padding:0 10 0 10;line:0 solid #808080ff ;\" text=\"bind:SUM_DELIVERED_QTY\" mask=\"#,##0.0\"/><Cell row=\"3\" celltype=\"none\" style=\"align:left;padding:0 10 0 10;line:0 solid #808080ff ;\" text=\"감량합계\"/><Cell row=\"3\" col=\"1\" displaytype=\"number\" style=\"align:right middle;padding:0 10 0 10;line:0 solid #808080ff ;\" text=\"bind:SUM_UNDELIVERED_QTY\" mask=\"#,##0.0\"/><Cell row=\"4\" celltype=\"none\" style=\"align:left;padding:0 10 0 10;line:0 solid #808080ff ;\" text=\"미입고량합계\"/><Cell row=\"4\" col=\"1\" displaytype=\"number\" style=\"align:right middle;padding:0 10 0 10;line:0 solid #808080ff ;selectcolor: ;\" text=\"bind:SUM_NONE_QTY\" mask=\"#,##0.0\"/><Cell row=\"5\"/><Cell row=\"5\" col=\"1\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 520, 539, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frmCalendar");
            		p.getSetter("inheritanceid").set("");
            		p.set_titletext("미입고리스트");
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
        this.addIncludeScript("InventoryNoWarehousePop.xfdl", "lib::lib_Com.xjs");
        this.registerScript("InventoryNoWarehousePop.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		클레임신청상세현황
        // [부시스템명]	클레임신청상세현황
        // [설명]		    클레임신청상세현황.
        // [작성자명] 		강대성
        // [작성일자]		2015.05.26
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.05.26 : 강대성 : 클레임신청상세현황 신규
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
        	this.ds_grd.clearData();
        	this.ds_grdSum.clearData();
        	
        	// 데이터셋 카피
        	this.ds_grd.copyData(application.goMenu.ds_po, true);
        	
        	var nRow = this.ds_grdSum.addRow();
        	this.ds_grdSum.setColumn(nRow, "SUM_ORDER_QTY"       , this.ds_grd.getSum("ORDER_QTY"));
        	this.ds_grdSum.setColumn(nRow, "SUM_DELIVERED_QTY"   , this.ds_grd.getSum("DELIVERED_QTY"));
        	this.ds_grdSum.setColumn(nRow, "SUM_UNDELIVERED_QTY" , this.ds_grd.getSum("UNDELIVERED_QTY"));
        	this.ds_grdSum.setColumn(nRow, "SUM_NONE_QTY"        , this.ds_grd.getSum("ORDER_QTY"));
        	
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

        };

        this.loadIncludeScript("InventoryNoWarehousePop.xfdl", true);

       
    };
}
)();
