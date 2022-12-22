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
                this.set_name("ClaimProcessDetailReportPop");
                this.set_titletext("클레임신청상세현황");
                this.set_scrollbars("none");
                this.set_enable("true");
                this._setFormPosition(0,0,520,634);
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
            obj._setContents("<ColumnInfo><Column id=\"itemCode\" type=\"STRING\" size=\"256\"/><Column id=\"itemName\" type=\"STRING\" size=\"256\"/><Column id=\"itemSize\" type=\"STRING\" size=\"256\"/><Column id=\"poUom\" type=\"STRING\" size=\"256\"/><Column id=\"custcd\" type=\"STRING\" size=\"256\"/><Column id=\"custnm\" type=\"STRING\" size=\"256\"/><Column id=\"입고구분\" type=\"STRING\" size=\"256\"/><Column id=\"poQty\" type=\"STRING\" size=\"256\"/><Column id=\"reqQty\" type=\"STRING\" size=\"256\"/><Column id=\"ctClaimKind\" type=\"STRING\" size=\"256\"/><Column id=\"reqKind\" type=\"STRING\" size=\"256\"/><Column id=\"claimMemo\" type=\"STRING\" size=\"256\"/><Column id=\"reqDate\" type=\"STRING\" size=\"256\"/><Column id=\"reqTime\" type=\"STRING\" size=\"256\"/><Column id=\"etcMemo\" type=\"STRING\" size=\"256\"/><Column id=\"dlvyKind\" type=\"STRING\" size=\"256\"/><Column id=\"photo\" type=\"STRING\" size=\"256\"/><Column id=\"poId\" type=\"STRING\" size=\"256\"/><Column id=\"centerCode\" type=\"STRING\" size=\"256\"/><Column id=\"upjang\" type=\"STRING\" size=\"256\"/><Column id=\"subinvCode\" type=\"STRING\" size=\"256\"/><Column id=\"needDate\" type=\"STRING\" size=\"256\"/><Column id=\"partTmNm\" type=\"STRING\" size=\"256\"/><Column id=\"mngName\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_claimTypeCd", this);
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

            obj = new Dataset("ds_processTypeCd", this);
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

            obj = new Dataset("ds_prcsStatus", this);
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
            obj = new Static("staFormSize", "absolute", "0", "0", "520", "633", null, null, this);
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

            obj = new Grid("grd_list", "absolute", "8", "72", "505", "554", null, null, this);
            obj.set_taborder("20");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_selecttype("row");
            obj.set_autosizingtype("none");
            obj.set_extendsizetype("none");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"131\"/><Column size=\"74\"/><Column size=\"59\"/><Column size=\"34\"/><Column size=\"39\"/><Column size=\"167\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"45\"/><Row size=\"45\"/><Row size=\"45\"/><Row size=\"45\"/><Row size=\"45\"/><Row size=\"45\"/><Row size=\"45\"/><Row size=\"45\"/><Row size=\"45\"/><Row size=\"45\"/><Row size=\"60\"/><Row size=\"45\"/></Rows><Band id=\"head\"><Cell text=\"GrayLabel\"/><Cell col=\"1\" text=\"WhiteLabel\"/><Cell col=\"2\" text=\"WhiteLabel\"/><Cell col=\"3\"/><Cell col=\"4\"/><Cell col=\"5\"/></Band><Band id=\"body\"><Cell style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"입고예정일\" wordwrap=\"char\" autosizerow=\"default\"/><Cell col=\"1\" colspan=\"5\" displaytype=\"date\" style=\"align:left middle;padding:0 5 0 5;background:white;background2:white;selectbackground:white;\" text=\"bind:needDate\" wordwrap=\"char\" autosizerow=\"default\"/><Cell row=\"1\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"납품업체\" wordwrap=\"char\" autosizerow=\"default\"/><Cell row=\"1\" col=\"1\" colspan=\"5\" style=\"align:left middle;padding:0 5 0 5;background:white;background2:white;selectbackground:white;\" text=\"bind:custnm\" wordwrap=\"char\" autosizerow=\"default\"/><Cell row=\"2\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"입고수량\" wordwrap=\"char\" autosizerow=\"default\"/><Cell row=\"2\" col=\"1\" colspan=\"5\" displaytype=\"number\" style=\"align:left middle;padding:0 5 0 5;background:white;background2:white;selectbackground:white;\" text=\"bind:poQty\" wordwrap=\"char\" mask=\"#,##0.0\" autosizerow=\"default\"/><Cell row=\"3\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"요청량\" wordwrap=\"char\" autosizerow=\"default\"/><Cell row=\"3\" col=\"1\" colspan=\"5\" displaytype=\"number\" style=\"align:left middle;padding:0 5 0 5;background:white;background2:white;selectbackground:white;\" text=\"bind:reqQty\" wordwrap=\"char\" mask=\"#,##0.0\" autosizerow=\"default\"/><Cell row=\"4\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"클레임유형\" wordwrap=\"char\" autosizerow=\"default\"/><Cell row=\"4\" col=\"1\" colspan=\"5\" displaytype=\"combo\" style=\"align:left middle;padding:0 5 0 5;background:white;background2:white;selectbackground:white;\" text=\"bind:ctClaimKind\" wordwrap=\"char\" combodataset=\"ds_claimTypeCd\" combocodecol=\"cd\" combodatacol=\"cdNm\" autosizerow=\"default\"/><Cell row=\"5\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"요청사항\" wordwrap=\"char\" autosizerow=\"default\"/><Cell row=\"5\" col=\"1\" colspan=\"5\" displaytype=\"combo\" style=\"align:left middle;padding:0 5 0 5;background:white;background2:white;selectbackground:white;\" text=\"bind:reqKind\" wordwrap=\"char\" combodataset=\"ds_processTypeCd\" combocodecol=\"cd\" combodatacol=\"cdNm\" autosizerow=\"default\"/><Cell row=\"6\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"상세내역\" wordwrap=\"char\" autosizerow=\"default\"/><Cell row=\"6\" col=\"1\" colspan=\"5\" displaytype=\"normal\" style=\"align:left middle;padding:0 5 0 5;background:white;background2:white;selectbackground:white;\" text=\"bind:claimMemo\" wordwrap=\"char\" autosizerow=\"default\"/><Cell row=\"7\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"요청일자\" wordwrap=\"char\" autosizerow=\"default\"/><Cell row=\"7\" col=\"1\" colspan=\"5\" displaytype=\"date\" style=\"align:left middle;padding:0 5 0 5;background:white;background2:white;selectbackground:white;\" text=\"bind:reqDate\" wordwrap=\"char\" calendardisplaynulltype=\"none\" autosizerow=\"default\"/><Cell row=\"8\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"요청시간\" wordwrap=\"char\" autosizerow=\"default\"/><Cell row=\"8\" col=\"1\" colspan=\"5\" displaytype=\"normal\" style=\"align:left middle;padding:0 5 0 5;background:white;background2:white;selectbackground:white;\" text=\"bind:reqTime\" wordwrap=\"char\" mask=\"@@:@@\" autosizerow=\"default\"/><Cell row=\"9\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"기타사항\" wordwrap=\"char\" autosizerow=\"default\"/><Cell row=\"9\" col=\"1\" colspan=\"5\" displaytype=\"normal\" style=\"align:left middle;padding:0 5 0 5;background:white;background2:white;selectbackground:white;\" text=\"bind:etcMemo\" wordwrap=\"char\" autosizerow=\"default\"/><Cell row=\"10\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"처리부서/담당자\" wordwrap=\"char\" autosizerow=\"default\"/><Cell row=\"10\" col=\"1\" colspan=\"5\" displaytype=\"normal\" style=\"align:left middle;padding:0 5 0 5;background:white;background2:white;selectbackground:white;\" text=\"expr:partTmNm + &quot;  &quot; + mngName\" wordwrap=\"char\" autosizerow=\"default\"/><Cell row=\"11\" style=\"align:left middle;padding:0 5 0 5;background:linen;background2:linen;selectbackground:linen;\" text=\"처리결과\" wordwrap=\"char\" autosizerow=\"default\"/><Cell row=\"11\" col=\"1\" colspan=\"5\" displaytype=\"combo\" style=\"align:left middle;padding:0 5 0 5;background:white;background2:white;selectbackground:white;\" text=\"bind:dlvyKind\" wordwrap=\"char\" combodataset=\"ds_prcsStatus\" combocodecol=\"cd\" combodatacol=\"cdNm\" autosizerow=\"default\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 520, 634, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frmCalendar");
            		p.getSetter("inheritanceid").set("");
            		p.set_titletext("클레임신청상세현황");
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
        this.addIncludeScript("ClaimProcessDetailReportPop.xfdl", "lib::lib_Com.xjs");
        this.registerScript("ClaimProcessDetailReportPop.xfdl", function(exports) {
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
        	//클레임 유형
        	this.fn_common_code("C05", "", "");	
        	this.ds_claimTypeCd.copyData(application.gds_common_code);
        	
        	//요청사항
        	this.fn_common_code("C02", "", "");	
        	this.ds_processTypeCd.copyData(application.gds_common_code);	
        	
        	//처리현황
        	this.fn_common_code("C00", "", "");	
        	this.ds_prcsStatus.copyData(application.gds_common_code);
        	
        	//this.fsp_init();
        	this.arg = application.goMain.gfn_POP_getArg();
        	
        	var nRow = this.ds_grd.addRow();
        	this.ds_grd.setColumn(nRow, "itemName", this.arg[0]);      //자재명	
        	this.ds_grd.setColumn(nRow, "itemCode", this.arg[1]);	   //자재코드
        	this.ds_grd.setColumn(nRow, "custnm", this.arg[2]);        //고객업체
        	this.ds_grd.setColumn(nRow, "poQty", this.arg[3]);         //발주량
        	this.ds_grd.setColumn(nRow, "reqQty", this.arg[4]);		   //요청량
        	this.ds_grd.setColumn(nRow, "ctClaimKind", this.arg[5]);   //클레임유형
        	this.ds_grd.setColumn(nRow, "reqKind", this.arg[6]);       //요청사항
        	this.ds_grd.setColumn(nRow, "claimMemo", this.arg[7]);     //클레임상세내역     
        	this.ds_grd.setColumn(nRow, "reqDate", this.arg[8]);       //입고요청일자
        	this.ds_grd.setColumn(nRow, "reqTime", this.arg[9]);       //입고요청시간
        	this.ds_grd.setColumn(nRow, "etcMemo", this.arg[10]);      //기타사항
        	this.ds_grd.setColumn(nRow, "dlvyKind", this.arg[11]);     //진행상태
        	this.ds_grd.setColumn(nRow, "needDate", this.arg[12]);     //입고예정일
        	this.ds_grd.setColumn(nRow, "partTmNm", this.arg[13]);     //처리부서
        	this.ds_grd.setColumn(nRow, "mngName", this.arg[14]);     //처리담당자
        	
        	//클레임현황에서 팝업 호출시 해당 row숨김
        	if(this.arg[15] == "01")
        	{
        		this.grd_list.setFormatRowProperty(7, "size", 0); 
        		this.grd_list.setFormatRowProperty(8, "size", 0);
        		this.grd_list.setFormatRowProperty(9, "size", 0);
        		this.grd_list.setFormatRowProperty(10, "size", 0);
        		
        		this.grd_list.set_height(377);
        		this.staFormSize.set_height(456);
        				
        	}
        	else
        	{
        		this.grd_list.setFormatRowProperty(11, "size", 0); 
        		this.grd_list.setFormatRowProperty(12, "size", 0);
        		
        		this.grd_list.set_height(461);
        		this.staFormSize.set_height(539);			
        	}
        	
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

        this.loadIncludeScript("ClaimProcessDetailReportPop.xfdl", true);

       
    };
}
)();
