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
                this.set_name("CmmnComboList");
                this.set_titletext("콤보리스트");
                this.set_scrollbars("none");
                this._setFormPosition(0,0,420,196);
            }
            this.getSetter("inheritanceid").set("");
            this.getSetter("ondevicebuttondown").set("frmComboList_ondevicebuttondown");

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "420", "175", null, null, this);
            obj.set_text("");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("staTitle", "absolute", "0", "0", "400", "70", null, null, this);
            obj.set_text("Title");
            obj.set_cssclass("sta_POP_TitleBg");
            this.addChild(obj.name, obj);

            obj = new Grid("grdList", "absolute", "0", "70", "420", "123", null, null, this);
            obj.set_taborder("1");
            obj.set_wheelscrollrow("1");
            obj.style.set_border("0 solid #b2b2b2ff");
            obj.style.set_bordertype("normal 0 0");
            obj.style.set_font("bold antialias 24 arial");
            obj.set_autofittype("col");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_autosizingtype("row");
            obj.set_extendsizetype("row");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"372\"/></Columns><Rows><Row size=\"55\" band=\"head\"/><Row size=\"67\"/></Rows><Band id=\"head\"><Cell style=\"padding:0 0 0 10;\"/></Band><Band id=\"body\"><Cell style=\"align:left;padding:0 15 0 15;\" wordwrap=\"char\" autosizerow=\"limitmin\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("staBtnClose", "absolute", "301", "0", null, "67", "0", null, this);
            obj.set_taborder("3");
            this.addChild(obj.name, obj);

            obj = new Button("btnClose", "absolute", null, "0", "68", "70", "0", null, this);
            obj.set_taborder("2");
            obj.set_cssclass("btn_POP_XBtn");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 420, 196, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frmComboList");
            		p.getSetter("inheritanceid").set("");
            		p.set_titletext("콤보리스트");
            		p.set_scrollbars("none");
            		p.getSetter("ondevicebuttondown").set("frmComboList_ondevicebuttondown");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.registerScript("CmmnComboList.xfdl", function(exports) {

        /*======================================================
         전역변수
         ======================================================*/
        // arg[0] : 바인딩되는 데이타셋
        // arg[1] : 타이틀
        // arg[2] : Grid의 Header 명
        // arg[3] : Grid의 Body에 binding 되는 columnID
        // arg[4] : 메뉴로 사용할 때만 사용
        this.arg = undefined;
        this.maxViewCount = 7; //한번에 보여지는 최대 리스트 수
        this.F_erow = 0; //20140715 콤보리스트 선택 시 색상 표현
        /*======================================================
         From 관련 함수
         ======================================================*/
        this.CmmnComboList_onload = function (obj,e)
        {
        	this.arg = application.goMain.gfn_POP_getArg();

        	this.ds.copyData(this.arg[0], true);

        	var count = this.ds.rowcount;
        	var strTitle = this.arg[1];
        	var arrHead = this.arg[2].split("|");
        	var arrBody = this.arg[3].split("|");
        	var arrBodyAttr = new Array();
        	var bTitle;
        	var borderW = this.grdList.currentstyle.border.width.replace("px","");
        	var scrollW = this.grdList.vscrollbar.getOffsetWidth();

        	this.grdList.setFormatColProperty(0, "size", this.grdList.getOffsetWidth() - 2 * borderW - scrollW);

        	// 컬럼 속성 정보 -------------------------------
        	var tmp;
        	for (var i = 0; i < arrBody.length; i++) 
        	{
        		tmp = arrBody[i].split(":");
        		if (tmp.length <= 1) 
        		{
        			arrBodyAttr.getSetter(i).set("String");
        		}
        		else if (tmp[1] == "I") 
        		{
        			arrBodyAttr.getSetter(i).set("Image");
        			arrBody.getSetter(i).set(tmp[0]);
        		}
        	}
        	// -------------------------------------------------

        	// 타이틀 설정
        	// 값이 없으면 보이지 않게 한다.
        	if (application.gfn_IsNull(strTitle)) 
        	{
        		bTitle = false;
        		this.staTitle.set_visible(false);
        		this.btnClose.set_visible(false);
        	}
        	else 
        	{
        		bTitle = true;
        		this.staTitle.set_text(strTitle);
        		this.staTitle.set_visible(true);
        		this.btnClose.set_visible(true);
        	}

        	var heightHEAD;
        	var heightBODY;

        	// Grid Header
        	// 값이 없으면 보이지 않게 한다.
        	if (application.gfn_IsNull(arrHead) || arrHead[0].length <= 0) 
        	{
        		this.grdList.deleteContentsRow("head", 0);
        		heightHEAD = 0;
        		heightBODY = this.grdList.getFormatRowSize(0);
        	}
        	else 
        	{
        		heightHEAD = this.grdList.getFormatRowSize(0);
        		heightBODY = this.grdList.getFormatRowSize(1);
        	}

        	var contentsH = this.parent.getOffsetHeight();

        	// Grid의 크기(높이) 설정
        	// 최대 maxViewCount 가 보여질 만큼
        	if (count >= this.maxViewCount) 
        	{
        		this.grdList.set_height(heightBODY * this.maxViewCount + heightHEAD + borderW * 2);
        	}
        	else if (count <= 0) 
        	{
        	}
        	// grdList.nodatatext = "No Data";		// nodatatext Ajax 미지원
        	else 
        	{
        		this.grdList.set_height(heightBODY * count + heightHEAD + borderW * 2);
        	}

        	// 높이를 정했으니 Grid에 dataset를 연결한다.
        	//this.grdList.setBindDatasetObject(this.ds);
        	this.grdList.set_binddataset(this.ds.id);

        	// 보여줄 컬럼이 2개 이상이면 col을 추가한다.
        	if (arrBody.length > 1) 
        	{
        		// grdList.autosizingtype = "col";

        		for (var i = 0; i < arrBody.length - 1; i++) 
        		{
        			this.grdList.appendContentsCol();
        		}

        		this.grdList.set_autosizingtype("col");
        	}

        	// 컬럼 속성에 따른 설정 --------------------------
        	for (var i = 0; i < this.grdList.getFormatColCount(); i++) 
        	{
        		if (arrBodyAttr[i] == "Image") 
        		{
        			this.grdList.setCellProperty("Body", i, "displaytype", "image");
        			this.grdList.setCellProperty("Body", i, "padding", "0 5 0 5");
        		}
        	}
        	// ----------------------------------------------------

        	var colTotalWidth = 0;
        	for (var i = 0; i < this.grdList.getCellCount("body"); i++) 
        	{
        		colTotalWidth += this.grdList.getFormatColSize(i);
        	}
        	if (colTotalWidth + borderW * 2 > this.grdList.getOffsetWidth()) 
        	{
        		if (application.gfn_IsNull(system.mobileproducttype) == false) 
        		{
        			this.grdList.hscrollbar.getSetter("scrollbarsize", "set_scrollbarsize").set(0);
        		}
        		else 
        		{
        			this.grdList.set_height(this.grdList.getOffsetHeight() + this.grdList.hscrollbar.getOffsetHeight());
        		}
        	}

        	for (var i = 0; i < arrHead.length; i++) 
        	{
        		if (arrHead[i].length > 0) 
        		{
        			this.grdList.setCellProperty("Head", i, "text", arrHead[i]);
        		}
        	}

        	for (var i = 0; i < arrBody.length; i++) 
        	{
        		this.grdList.setCellProperty("Body", i, "text", "bind:" + arrBody[i]);
        	}

        
        	var colSize = new Array();
        	for (var i = 0; i < arrBody.length; i++) 
        	{
        		colSize.getSetter(i).set(this.grdList.getRealColSize(i));
        	}

        	if (arrBody.length > 1 && (colSize[0] + colSize[1]) < this.grdList.getOffsetWidth() - borderW * 2) 
        	{
        		this.grdList.setRealColSize(1, this.grdList.getOffsetWidth() - colSize[0] - borderW * 2);
        	}

        	var gw = this.grdList.getOffsetWidth();
        	var gh = this.grdList.getOffsetHeight() + 5;

        	if (bTitle) 
        	{
        		gh += this.staTitle.getOffsetHeight();
        	}
        	else 
        	{
        		this.grdList.set_top(0);
        	}

        	this.staFormSize.set_width(gw);
        	this.staFormSize.set_height(gh);
        	//안드로이드4.3TODO
        // 	if(this.ds.rowcount  < 8)
        // 	{
        // 		this.staFormSize.set_height(gh);
        // 	}
        // 	else
        // 	{
        // 		this.staFormSize.set_height(gh-5);
        // 	}

        	this.ds.set_rowposition(-1);
        	
        	//this.setTimer(2,100);
        	application.goMain.gfn_POP_resize(this);
        }

        // 안드로이드 취소, 메뉴키 관련 이벤트
        this.frmComboList_ondevicebuttondown = function (obj,e)
        {
        	return false;
        }

        /*======================================================
         Component 관련 함수
         ======================================================*/
        this.grdList_oncellclick = function (obj,e)
        {
        	//20140715 콤보리스트 선택 시 색상 표현
        	this.F_erow = e.row;
        	this.setTimer(1,200);

        }

        this.btnClose_onclick = function (obj,e)
        {
        	application.goMain.gfn_POP_close(this, "CLOSEONLY");
        }

        this.staBtnClose_onclick = function(obj,e)
        {
        	application.goMain.gfn_POP_close(this, "CLOSEONLY");
        }

        this.CmmnComboList_ontimer = function(obj,e)
        {
        	this.killTimer(e.timerid);

        	if(e.timerid == 1)
        	{
        		if (this.arg[4] == "MENU") 
        		{
        			var value = this.ds.getColumn(this.F_erow, "url");

        			if (!application.gfn_IsNull(value)) 
        			{
        				if (value.substr(0, 1) == "+") 
        				{
        					application.goMain.gfn_POP_close(this, this.F_erow, false);
        					return;
        				}
        			}
        		}

        		application.goMain.gfn_POP_close(this, this.F_erow);
        	}
        	else
        	{
        		application.goMain.gfn_POP_resize(this);
        	}
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.CmmnComboList_onload, this);
            this.addEventHandler("ontimer", this.CmmnComboList_ontimer, this);
            this.grdList.addEventHandler("oncellclick", this.grdList_oncellclick, this);
            this.staBtnClose.addEventHandler("onclick", this.staBtnClose_onclick, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);

        };

        this.loadIncludeScript("CmmnComboList.xfdl", true);

       
    };
}
)();
