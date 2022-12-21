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
                this.set_name("CmmnPop");
                this.set_titletext("공통팝업");
                this._setFormPosition(0,0,420,458);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_grd", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("true");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"upjang\" type=\"STRING\" size=\"256\"/><Column id=\"upjangnmDisp\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "420", "458", null, null, this);
            obj.set_taborder("44");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "0", "0", "420", "70", null, null, this);
            obj.set_taborder("46");
            obj.set_cssclass("sta_POP_TitleBg");
            obj.set_text("검색");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "70", "420", "10", null, null, this);
            obj.set_taborder("47");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "410", "80", "10", "358", null, null, this);
            obj.set_taborder("48");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "80", "10", "358", null, null, this);
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

            obj = new Static("Static03", "absolute", "0", "438", "420", "20", null, null, this);
            obj.set_taborder("54");
            obj.set_text("h20");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_value", "absolute", "10", "80", "295", "47", null, null, this);
            obj.set_taborder("71");
            obj.set_displaynulltext("업장명");
            obj.set_imemode("hangul");
            this.addChild(obj.name, obj);

            obj = new Button("btn_search", "absolute", "310", "80", "100", "47", null, null, this);
            obj.set_taborder("72");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "305", "86", "5", "30", null, null, this);
            obj.set_taborder("73");
            obj.set_text("h05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "0", "127", "420", "10", null, null, this);
            obj.set_taborder("74");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list", "absolute", "10", "137", "400", "301", null, null, this);
            obj.set_taborder("75");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"43\"/><Column size=\"48\"/><Column size=\"40\"/><Column size=\"40\"/><Column size=\"40\"/><Column size=\"40\"/><Column size=\"40\"/><Column size=\"40\"/><Column size=\"40\"/><Column size=\"40\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\" band=\"head\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"Column0\"/><Cell col=\"1\"/><Cell col=\"2\"/><Cell col=\"3\"/><Cell col=\"4\"/><Cell col=\"5\"/><Cell col=\"6\"/><Cell col=\"7\"/><Cell col=\"8\"/><Cell col=\"9\"/><Cell row=\"1\"/><Cell row=\"1\" col=\"1\"/><Cell row=\"1\" col=\"2\"/><Cell row=\"1\" col=\"3\"/><Cell row=\"1\" col=\"4\"/><Cell row=\"1\" col=\"5\"/><Cell row=\"1\" col=\"6\"/><Cell row=\"1\" col=\"7\"/><Cell row=\"1\" col=\"8\"/><Cell row=\"1\" col=\"9\"/></Band><Band id=\"body\"><Cell style=\"align:center middle;padding:0 10 0 10;\" editlimitbymask=\"decimal\"/><Cell col=\"1\" style=\"align:left;\"/><Cell col=\"2\"/><Cell col=\"3\"/><Cell col=\"4\"/><Cell col=\"5\"/><Cell col=\"6\"/><Cell col=\"7\"/><Cell col=\"8\"/><Cell col=\"9\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Button("btn_moreView", "absolute", "128", null, null, "42", "136", "21", this);
            obj.set_taborder("79");
            obj.set_visible("false");
            obj.style.set_background("darkgray");
            obj.style.set_color("white");
            obj.style.set_opacity("75");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 420, 458, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("공통팝업");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("CmmnPop.xfdl", "lib::lib_Com.xjs");
        this.registerScript("CmmnPop.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		공통검색팝업
        // [부시스템명]	공통검색팝업 - 조회
        // [설명]		    공통검색팝업.
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
        this.fv_totalpageRow;	// 전체건수

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
        	// Form Load 시 공통 기능 처리(obj:Form, bCreateEvent:이벤트 생성 여부)
        	this.gfn_formOnLoad(this);
        	
        	// 초기값 셋팅
        	this.fn_init();
        }

        /*----------------------------------------------------------------------------------------------
         * 설명      : 초기값 셋팅
         *---------------------------------------------------------------------------------------------*/
        this.fn_init = function()
        {
        	//그리드를 디자인한다.
        	this.fn_gridDesign();
        }

        /************************************************************************************************
         * 공통기능 FUNCTION 영역 (필수)
        ************************************************************************************************/
        /*----------------------------------------------------------------------------------------------
         * 설명      : 조회 버튼 클릭 시 (필수-공통버튼에서 호출됨)
         *---------------------------------------------------------------------------------------------*/
        this.fn_search = function()
        {
        	var parameter = gfn_jsonStringToObject(SEND_PARAMETER);
        	parameter.option.value = gfn_nvl(edt_value.value);
        	
            var strSvcID    = "search";
            var strURL      = "/sc/cmn/binding/select.xdo";
            var strInDs     = "";
            var strOutDs    = "ds_grd=output";
            var strArg      = "input="+wrapQuote(gfn_jsonObjectToString(parameter));
            var strCallback = "fn_callBack";
            var bAsync      = true;
            
            this.gfn_transaction(this, strSvcID, strURL, strInDs, strOutDs, strArg, strCallback, bAsync);
        }

        
        /************************************************************************************************
         * TRANSACTION 및 CallBack 영역 (필수)
        ************************************************************************************************/
        /*----------------------------------------------------------------------------------------------
         * 설명      : 트랜잭션 콜백 함수 (필수)
         *---------------------------------------------------------------------------------------------*/
        this.fn_callBack = function(strSvcID,nErrorCode,strErrorMsg)
        {
            switch(strSvcID)
            {
        		// 조회
                case "search" :    
                    break;
            }
        }

        /************************************************************************************************
         * 사용자 FUNCTION 영역 (필수)
        ************************************************************************************************/
        /*----------------------------------------------------------------------------------------------
         * 설명      : Return할 Array 생성 및 창 닫기
         *---------------------------------------------------------------------------------------------*/
        this.fn_return = function()
        {
        	var design = gfn_jsonStringToObject(SEND_DESIGN_PARAMETER);
        	var parameter = gfn_jsonStringToObject(SEND_PARAMETER);
        	var rowIdx = ds_grd.rowposition;
        	var arr = new Array();
        	var openerDataset = opener.objects[parameter.outDs];
        	openerDataset.clear();

        	for ( var i = 0; i < ds_grd.getColCount(); i++ ) {
        		openerDataset.addColumn(ds_grd.getColID(i), "string", 1000);
        		arr[ds_grd.getColID(i)] = ds_grd.getColumn(rowIdx, i);
        	}
        	
         	var newRow = openerDataset.addRow();
         	openerDataset.copyRow(newRow, ds_grd, rowIdx);
        	
        	this.close(arr);
        }

        /*----------------------------------------------------------------------------------------------
         * 설명      : 그리드를 디자인한다.
         *---------------------------------------------------------------------------------------------*/
        this.fn_gridDesign = function()
        {
        	var parameter = gfn_jsonStringToObject(SEND_PARAMETER);
        	var design = gfn_jsonStringToObject(SEND_DESIGN_PARAMETER);
        	var cols = null;
        	
        	//[[디자인 정보를 각 화면에서 설정한 경우에 처리한다.
        	if (parameter.option.design != undefined) {
        		var p = parameter.option.design;
        		
        		if (p.title != undefined) {
        			design.title = p.title;
        		}
        		
        		if (p.label != undefined) {
        			design.label = p.label;
        		}
        		
        		if (p.labelWidth != undefined) {
        			design.labelWidth = p.labelWidth;
        		}
        		
        		if (p.columns != undefined) {
        			cols = p.columns;
        		}
        	}
        	//디자인 정보를 각 화면에서 설정한 경우에 처리한다.]]
        	
        	this.titletext = design.title; //SEND_DESIGN_DATASET.getColumn(0, "title");
        	sta_title.text = design.title; //SEND_DESIGN_DATASET.getColumn(0, "title");
        	
        	var width = parseInt(design.labelWidth); //SEND_DESIGN_DATASET.getColumn(0, "labelWidth"));
        	var right = sta_label.position.left + width;
        	sta_label.position.width = width;
        	sta_label.position.right = right;
        	sta_label.text = design.label; //SEND_DESIGN_DATASET.getColumn(0, "label");

        	this.edt_value.position.left = sta_label.position.right + 8;
        	edt_value.position.right = parseInt(design.width) - 30; //SEND_DESIGN_DATASET.getColumn(0, "width")) - 30;
        	
        	var columnInfo = design.columns; //gfn_jsonStringToObject(SEND_DESIGN_DATASET.getColumn(0, "columnInfo")).columnInfo;
        	
        	for (var i=0, len=grd_list.getCellCount("head"); i<len; i++) grd_list.setFormatColProperty(i, "size", 0); //보여지는 컬럼을 숨긴다.
        	//[[그리드에 열의 Width 및 Align, Text를 설정한다.
        	for (var i=0, len=columnInfo.length; i<len; i++)
        	{
        		//[[디자인 정보를 각 화면에서 설정한 경우에 처리한다.
        		if (cols != null) {
        			if (cols[i].width != undefined) {
        				columnInfo[i].width = cols[i].width;
        			}
        			
        			if (cols[i].text != undefined) {
        				columnInfo[i].text = cols[i].text;
        			}
        		}
        		//디자인 정보를 각 화면에서 설정한 경우에 처리한다.]]
        		
        		grd_list.setFormatColProperty(i, "size", parseInt(columnInfo[i].width));
        		grd_list.setCellProperty("head", i, "text", columnInfo[i].text);
        		
        		if (columnInfo[i].align != undefined) grd_list.setCellProperty("body", i, "align", columnInfo[i].align);
        		else grd_list.setCellProperty("body", i, "align", "center");
        		
        		grd_list.setCellProperty("body", i, "displaytype", "text");
        		grd_list.setCellProperty("body", i, "text", "bind:"+columnInfo[i].id);
        	}
        	//그리드에 열의 Width 및 Align, Text를 설정한다.]]
        	
        	//ds_search.copyData(SEND_DESIGN_DATASET);
        	//this.removeChild("SEND_DESIGN_DATASET");
        }

        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.CmmnDeptSearchPop_onload, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);
            this.btn_search.addEventHandler("onclick", this.btnSearch_onclick, this);
            this.grd_list.addEventHandler("oncellclick", this.grdList_oncellclick, this);
            this.btn_moreView.addEventHandler("onclick", this.div_tab01_btn_moreView_onclick, this);

        };

        this.loadIncludeScript("CmmnPop.xfdl", true);

       
    };
}
)();
