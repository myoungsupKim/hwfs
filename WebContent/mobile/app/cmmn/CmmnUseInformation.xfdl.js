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
                this.set_name("CmmnUseInformation");
                this.set_titletext("Sub_MenuList");
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
            obj._setContents("<ColumnInfo><Column id=\"menuName\" type=\"STRING\" size=\"256\"/><Column id=\"menuId\" type=\"STRING\" size=\"256\"/><Column id=\"url\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"menuName\">이용안내</Col><Col id=\"menuId\">01</Col><Col id=\"url\">M_MMB::UseInformation.xfdl</Col></Row><Row><Col id=\"url\">cmmn::CmmnPushList.xfdl</Col><Col id=\"menuId\">02</Col><Col id=\"menuName\">PUSH수신내역조회</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Grid("grd_list", "absolute", "0", "0", null, "756", "0", null, this);
            obj.set_taborder("0");
            obj.set_cssclass("grd_WF_SubMenuList");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("none");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"540\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"65\"/></Rows><Band id=\"head\"><Cell text=\"Column0\"/></Band><Band id=\"body\"><Cell text=\"bind:menuName\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("Sub_MenuList");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.registerScript("CmmnUseInformation.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		기타관리
        // [부시스템명]	기타관리 - 조회
        // [설명]
        // 		부서 검색하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.02.05
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.05 : 강대성 : 수정이 필요하여 수정함.
        //########################################################
        //include "lib::sz_fsp_mobile_xp.xjs"
        //include "lib::sz_fsp_mobile_xp.xjs"

        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/
        //this.preDate = undefined;

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
        	//this.preDate = this.gfn_Today();
        	//this.cal_dtFrom.set_value(this.preDate);	
        }
        this.grd_list_oncellclick = function(obj,e)
        {	
        	var nRow = e.row;
        	
        	// action 실행
        	application.gv_menuId = this.ds_grd.getColumn(nRow, "menuId");
        	application.gv_formUrl = this.ds_grd.getColumn(nRow, "url");
        	application.gv_menuName = this.ds_grd.getColumn(nRow, "menuName");
        	application.goMain.fn_action("INFOMENU");
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.grd_list.addEventHandler("oncellclick", this.grd_list_oncellclick, this);

        };

        this.loadIncludeScript("CmmnUseInformation.xfdl", true);

       
    };
}
)();
