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
                this.set_name("ProductDetailPop");
                this.set_titletext("상품상세내역");
                this._setFormPosition(0,0,420,576);
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
            obj._setContents("<ColumnInfo><Column id=\"itemNm\" type=\"STRING\" size=\"256\"/><Column id=\"itemSize\" type=\"STRING\" size=\"256\"/><Column id=\"itemUom\" type=\"STRING\" size=\"256\"/><Column id=\"itemKeepingType\" type=\"STRING\" size=\"256\"/><Column id=\"itemOriginType\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row/></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "420", "586", null, null, this);
            obj.set_taborder("44");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "0", "0", "420", "70", null, null, this);
            obj.set_taborder("46");
            obj.set_text("상품상세내역");
            obj.set_cssclass("sta_POP_TitleBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "70", "420", "10", null, null, this);
            obj.set_taborder("47");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "410", "80", "10", "486", null, null, this);
            obj.set_taborder("48");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "80", "10", "486", null, null, this);
            obj.set_taborder("50");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Button("btnClose", "absolute", "350", "0", "70", "70", null, null, this);
            obj.set_taborder("45");
            obj.set_cssclass("btn_POP_XBtn");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "0", "566", "420", "20", null, null, this);
            obj.set_taborder("54");
            obj.set_text("h20");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new ImageViewer("img_product", "absolute", "10", "80", "400", "225", null, null, this);
            obj.set_taborder("67");
            obj.style.set_background("#ffffffff URL('theme://Image/img_WF_NoImage.png') center middle");
            obj.set_stretch("fixaspectratio");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "305", "420", "10", null, null, this);
            obj.set_taborder("68");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid00", "absolute", "10", "315", "400", "251", null, null, this);
            obj.set_taborder("69");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("autovert");
            obj.set_autosizingtype("row");
            obj.set_extendsizetype("row");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"110\"/><Column size=\"290\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"Column0\"/><Cell col=\"1\" text=\"Column1\"/></Band><Band id=\"body\"><Cell style=\"align:left;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"상품명\" autosizerow=\"limitmin\"/><Cell col=\"1\" style=\"align:left middle;\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:itemNm\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"1\" style=\"align:left;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"규격\" autosizerow=\"limitmin\"/><Cell row=\"1\" col=\"1\" style=\"align:left middle;\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:itemSize\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"2\" style=\"align:left;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"단위\" autosizerow=\"limitmin\"/><Cell row=\"2\" col=\"1\" style=\"align:left middle;\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:itemUom\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"3\" style=\"align:left;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"보관방법\" autosizerow=\"limitmin\"/><Cell row=\"3\" col=\"1\" style=\"align:left middle;\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:itemKeepingType\" wordwrap=\"char\" autosizerow=\"limitmin\"/><Cell row=\"4\" style=\"align:left;\" cssclass=\"CellGrd_WF_LabelGray\" text=\"원산지\" autosizerow=\"limitmin\"/><Cell row=\"4\" col=\"1\" style=\"align:left middle;\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:itemOriginType\" wordwrap=\"char\" autosizerow=\"limitmin\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 420, 576, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("상품상세내역");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("ProductDetailPop.xfdl", "lib::lib_Com.xjs");
        this.registerScript("ProductDetailPop.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		상품발주
        // [부시스템명]	상품발주 - 조회
        // [설명]
        // 		부서 검색하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.02.04
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.04 : 강대성 : 수정이 필요하여 수정함.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/
        this.preDate = undefined;

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
        	this.arg = application.goMain.gfn_POP_getArg();	
        	
        	this.ds_grd.setColumn(0, "itemNm", this.arg[0]);
        	this.ds_grd.setColumn(0, "itemSize", this.arg[1]);
        	this.ds_grd.setColumn(0, "itemUom", this.arg[2]);
        	this.ds_grd.setColumn(0, "itemKeepingType", this.arg[3]);
        	this.ds_grd.setColumn(0, "itemOriginType", this.arg[4]);
        	
        	var imgPath = this.makeEprocImageUrl(this.gfn_transNullToEmpty(this.arg[5]));
        	this.img_product.set_image(imgPath);
        		
        	application.goMain.gfn_POP_resize(this);	
        }

        //닫기버튼 클릭 시 
        this.btnClose_onclick = function (obj,e)
        {
        	application.goMain.gfn_POP_close(this, "CLOSEONLY");
        }

        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);

        };

        this.loadIncludeScript("ProductDetailPop.xfdl", true);

       
    };
}
)();
