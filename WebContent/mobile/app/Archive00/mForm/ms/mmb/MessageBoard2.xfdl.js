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
                this.set_name("MessageBoard");
                this.set_titletext("공지사항");
                this._setFormPosition(0,0,540,760);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_list", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"bbsId\" type=\"bigdecimal\" size=\"255\"/><Column id=\"bbsName\" type=\"string\" size=\"255\"/><Column id=\"parentBbsId\" type=\"bigdecimal\" size=\"255\"/><Column id=\"bbsType\" type=\"string\" size=\"255\"/><Column id=\"bbsGubun\" type=\"string\" size=\"255\"/><Column id=\"levels\" type=\"bigdecimal\" size=\"255\"/><Column id=\"sortSeq\" type=\"bigdecimal\" size=\"255\"/><Column id=\"useYn\" type=\"string\" size=\"255\"/><Column id=\"level\" type=\"bigdecimal\" size=\"255\"/><Column id=\"isMobile\" type=\"bigdecimal\" size=\"255\"/><Column id=\"tot\" type=\"bigdecimal\" size=\"255\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Button("btn_moreView", "absolute", "128", null, null, "42", "136", "0", this);
            obj.set_taborder("118");
            obj.set_visible("false");
            obj.style.set_background("darkgray");
            obj.style.set_color("white");
            obj.style.set_opacity("75");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_list", "absolute", "0", "0", null, null, "0", "0", this);
            obj.set_taborder("122");
            obj.set_binddataset("ds_list");
            obj.set_autofittype("col");
            obj.set_treeusecheckbox("false");
            obj.set_treeuseexpandkey("true");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"541\"/></Columns><Rows><Row size=\"90\"/></Rows><Band id=\"body\"><Cell displaytype=\"tree\" edittype=\"tree\" text=\"bind:bbsName\" treelevel=\"bind:levels\" treeexpandimage=\"URL('theme://Image\\btn_WF_SpinMinusP.png')\" treecollapseimage=\"URL('theme://Image\\btn_WF_SpinPlusP.png')\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("공지사항");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("MessageBoard2.xfdl", "lib::lib_Com.xjs");
        this.registerScript("MessageBoard2.xfdl", function(exports) {
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs";

        this.bbsId = undefined;

        this.form_onload = function(obj,e) {
        	//필수
        	this.fn_init();
        }

        this.fn_init = function () {
        	this.fn_search();	
        }

        this.fn_search = function() {
        	//검색
        	var strSvcID   		 = "search";
        	var strUrl     		 = "ms/mmb/messageBoard/selectList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "ds_list=ds_list";
        	var strArguments	 = " userId=" + nexacro.wrapQuote(application.g_userId);
        		strArguments	+= " upjangCd=" + nexacro.wrapQuote(application.g_Upjang);
        		strArguments	+= " gubun=" + nexacro.wrapQuote("01");
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);  	
        }

        this.fn_callBack = function (strSvcID,nErrorCode,strErrorMsg) {	
        	if ( nErrorCode < 0 ) {
        		return;
        	}
        	
            switch ( strSvcID ) {		
        		//공지사항
                case "search" :
        			trace(this.ds_list.saveXML());
        			break;
            }    
        }

        this.grd_list_oncellclick = function(obj,e) {
        	
        	//trace(e.canvasX);
        	
        	//추가 - 트리버튼의 영역이 눌렸을 경우는 로직을 타지 않도록 처리 함.
        	if( e.canvasX < 18 ) { 
        		return; 
        	}
        	
        	var objDs = this[obj.binddataset];

        	if ( this.treeStatus == 1 ) {
        		this.treeStatus = 0;
        		return;
        	}

        	var childRow = obj.getTreeChildRow(objDs.rowposition, 0, true);

        	// 자식 노드가 존재할 경우
        	if ( childRow >= 0 ) {
        		var gridRow = obj.getTreeRow(objDs.rowposition);
        		if (obj.isTreeCollapsedRow(childRow, true)) {
        			obj.setTreeStatus(gridRow, true);
        		} else {
        			obj.setTreeStatus(gridRow, false);
        		}
        	}
        	this.treeStatus = 0;
        	
        	if ( obj.isTreeLeafRow(e.row) ) {
        		this.parent.pArgument = objDs.getColumn(e.row, "bbsId");
        		application.gfn_setTitleMain(objDs.getColumn(e.row, "bbsName"));
        		
        		// action 실행
        		application.gv_menuBefId = "3244";
        		application.gv_formBefUrl = "M_MMB::MessageBoard2.xfdl";
        		application.gv_menuBefName = "게시판";
        		application.gv_progrmBefId = "";
        		application.gv_backFlag = "CUSTOM";
        		this.parent.divWork.set_url("M_MMB::MessageBoardList.xfdl");
        	}
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.btn_moreView.addEventHandler("onclick", this.btn_moreView_onclick, this);
            this.grd_list.addEventHandler("onvscroll", this.grd_list_onvscroll, this);
            this.grd_list.addEventHandler("oncellclick", this.grd_list_oncellclick, this);
            this.grd_list.addEventHandler("onslide", this.grd_list_onslide, this);

        };

        this.loadIncludeScript("MessageBoard2.xfdl", true);

       
    };
}
)();
