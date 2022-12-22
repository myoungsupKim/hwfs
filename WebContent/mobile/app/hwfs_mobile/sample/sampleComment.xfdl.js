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
                this.set_name("sampleCommnet");
                this.set_titletext("주석샘플");
                this._setFormPosition(0,0,720,1140);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("dsTest", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"code\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row/></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Button("btnSearch", "absolute", "516", "17", "176", "56", null, null, this);
            obj.set_taborder("0");
            obj.set_text("검색");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 720, 1140, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("orderList");
            		p.set_titletext("주석샘플");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.registerScript("sampleComment.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		건국대학교 모바일 서비스 구축
        // [시스템명]		학부
        // [부시스템명]	학적 - 인적사항 변경
        // [설명]
        // 		인적 사항을 조회, 수정한다.
        //		추가 설명이 있으면 위 문장처럼 계속 기입.
        // [작성자명] 		홍길동
        // [작성일자]		2014.03.14
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2014.04.01 : 홍길동 : 수정이 필요하여 수정함.
        //########################################################

        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/
        this.F_test = 0;		  //폼변수 설명
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
        this.sampleCommnet_onload = function(obj,e)
        {
        	//title 변경
        	application.goMain.fn_setTitle("");
        	
        	//MAIN OR SUB
        	application.goMain.fn_setLeft("SUB");
        	
        	//있거나 없거나.
        	this.fn_init();
        }

        /** 
         * 화면셋팅
         * @param  : 없음
         * @return : 없음
         */
        this.fn_init = function ()
        {
        	//폼이 load 된 후 필요한 로직 정의
        	application.goTopSub.fn_showBookmark(true); // 즐겨찾기 보이기/숨기기 (보이기 : true/ 숨기기 : false)
        	application.goTopSub.fn_showPrev(true); // 앞으로 가기 보이기/숨기기 (보이기 : true/ 숨기기 : false)

        	//TODO
        }

        /*==========================================================================
         * 3. DataSet관련 Script
        *========================================================================*/
        /** 
         * 테이터셋셋팅
         * @param  
        	value  : 셋팅값
         * @return : 없음
         */
        this.fn_setDs = function(value)
        {
        	dsTest.setColumn(0,"code",value);
        }

        /*==========================================================================
         * 4. Component관련 Script
        *========================================================================*/
        /** 
         * 검색버튼클릭
         * @param  
        	obj, e
         * @return : 없음
         */
        this.btnSearch_onclick = function(obj,e)
        {
        	//TODO
        }

        /*================================================================================
         * 5. UserFunction관련 Script
         *===============================================================================*/
        /** 
         * 사용자정의 함수
         * @param  : 없음
         * @return : true, false
         */
        this.fn_test() = function()
        {
        	//TODO
        	return true;
        }

        /*================================================================================
         * 6. FSP 함수 관련 Script
         *===============================================================================*/
        /*******************************************************************************
        * 기      능   :  OOO 조회 (예 : 개인시간표 조회)
        * 설      명   :  
        ********************************************************************************/
        this.fn_search = function()
        {
        // 	this.alert(this.ds_cond.saveXML());
        	this.fsp_clear();
        	this.fsp_addSearch("sample:fsp_sample_sel", false);
        	// connect the server 
        	this.fsp_callService
        	(
        		""
        		,""
        		,"ds_cond=ds_cond"	// inDs
        		,"ds_list=ds_list"	// outDs
        		,""	// args 
        		,"fn_afterSearch"
        		,true
        	);
        }

        /*******************************************************************************
        * 기      능   : OOO 조회 callback (예 : 개인시간표 조회 callback)
        ********************************************************************************/
        this.fn_afterSearch = function(ErrorCode,ErrorMsg)
        {
        //	this.alert("성공");
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.sampleCommnet_onload, this);
            this.btnSearch.addEventHandler("onclick", this.btnSearch_onclick, this);

        };

        this.loadIncludeScript("sampleComment.xfdl", true);

       
    };
}
)();
