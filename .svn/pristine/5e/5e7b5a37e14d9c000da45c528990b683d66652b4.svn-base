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
                this.set_name("ComTabMenu");
                this.set_titletext("탭");
                this.set_scrollbars("autohorz");
                this._setFormPosition(0,0,540,75);
            }
            this.getSetter("inheritanceid").set("");

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("dsInfo", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"id\" type=\"STRING\" size=\"256\"/><Column id=\"enable\" type=\"STRING\" size=\"256\"/><Column id=\"text\" type=\"STRING\" size=\"256\"/><Column id=\"url\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("sta_bg", "absolute", "0", "0px", null, null, "0px", "0px", this);
            obj.set_cssclass("sta_TopBg2");
            this.addChild(obj.name, obj);

            obj = new Button("btnArrowL", "absolute", "0", "3", "28", "70", null, null, this);
            obj.set_taborder("1");
            obj.set_cssclass("btn_TopLeft");
            obj.set_text("<");
            this.addChild(obj.name, obj);

            obj = new Button("btnArrowR", "absolute", null, "3", "28", "70", "0", null, this);
            obj.set_taborder("1");
            obj.set_cssclass("btn_TopRight_S");
            obj.set_text(">");
            this.addChild(obj.name, obj);

            obj = new Button("Button06", "absolute", "217", "4", "136", "70", null, null, this);
            obj.set_taborder("2");
            obj.set_text("산학/연구");
            obj.set_cssclass("btn_TopMenu");
            obj.getSetter("class").set("btn_TopMenu");
            this.addChild(obj.name, obj);

            obj = new Button("Button05", "absolute", "118", "4", "84", "70", null, null, this);
            obj.set_taborder("3");
            obj.set_text("학생");
            obj.set_cssclass("btn_TopMenu_S");
            obj.getSetter("class").set("btn_TopMenu_S");
            this.addChild(obj.name, obj);

            obj = new Button("Button04", "absolute", "34", "4", "71", "70", null, null, this);
            obj.set_taborder("4");
            obj.set_text("학사");
            obj.set_cssclass("btn_TopMenu");
            obj.getSetter("class").set("btn_TopMenu");
            this.addChild(obj.name, obj);

            obj = new Button("Button07", "absolute", "373", "4", "120", "70", null, null, this);
            obj.set_taborder("5");
            obj.set_text("입찰공고");
            obj.set_cssclass("btn_TopMenu");
            obj.getSetter("class").set("btn_TopMenu");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "116", "28", "1", "20", null, null, this);
            obj.set_taborder("6");
            obj.set_text("Static00");
            obj.style.set_background("#c0c0c0ff");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "205", "27", "1", "20", null, null, this);
            obj.set_taborder("7");
            obj.set_text("Static00");
            obj.style.set_background("#c0c0c0ff");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "361", "27", "1", "20", null, null, this);
            obj.set_taborder("8");
            obj.set_text("Static00");
            obj.style.set_background("#c0c0c0ff");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 75, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("ComTabMenu");
            		p.getSetter("inheritanceid").set("");
            		p.set_titletext("탭");
            		p.set_scrollbars("autohorz");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.registerScript("frmTabMenu.xfdl", function(exports) {

        /*======================================================
         전역변수
         ======================================================*/
        this.preSelectName = undefined; //이전에 선택한 버튼
        this.tabCount = 0; //탭 버튼 수
        this.tabW = 150; //탭 버튼의 너비 (Ajax에서는 문자열의 길이를 알 수 있는 방법이 없어서 고정 너비로 함)
        this.tabH = 68; //var SELECTED_COLOR = "#ff0068";
        this.SELECTED_COLOR = "#ffffff";
        this.NORMAL_COLOR = "#b8b8b8"; //var NORMAL_COLOR   = "#ffffff";  // 디자인시 테마에 적용한 color값이 반환되지 않아 임의로 지정하도록 한 임시 변수

        this.bArrow = true;

        
        /*======================================================
         public function - start
         ======================================================*/
        this.pfn_initTabMenu = function (ds,btnW,arrow)
        {
        	if (!application.gfn_IsNull(arrow)) 
        	{
        		this.bArrow = arrow;
        	}

        	if (!application.gfn_IsNull(btnW)) 
        	{
        		this.tabW = btnW;
        	}

        	this.dsInfo.copyData(ds);

        	// 탭의 개수
        	this.tabCount = this.dsInfo.getRowCount();

        	// 개수만큼 탭버튼 생성
        	this.fn_makeTabButton();

        	// // 애초속성을 scrollbars 설정하고 단말에서는 script로 스크롤바 안보이게 함.(터치 스크롤 이용)
        	// if (gfn_IsNull(system.mobileproducttype) == false)	// 단말인 경우
        	// {
        	// // 		divTab.hscrollbar.visible = true;
        	// // 		divTab.hscrollbar.scrollbarsize = 0;
        	// //		divTab.hscrollbar.position.top = divTab.hscrollbar.position.bottom;
        	// divTab.hscrollbar.position.height = 0;
        	// }

        	if (!this.bArrow) 
        	{
        		this.btnArrowL.set_visible(false);
        		this.btnArrowR.set_visible(false);
        		this.divTab.__setPosition9x("absolute l:0 r:0 t:0 b:0");
        	}

        	this.divTab.resetScroll();

        	this.fn_setArrow(0);

        	// 애초속성을 scrollbars 설정하고 단말에서는 script로 스크롤바 안보이게 함.(터치 스크롤 이용)
        	if (application.gfn_IsNull(system.mobileproducttype) == false) 
        	{
        		// 단말인 경우
        		// divTab.hscrollbar.visible = true;
        		// divTab.hscrollbar.scrollbarsize = 0;
        		// divTab.hscrollbar.position.top = divTab.hscrollbar.position.bottom;
        		this.divTab.hscrollbar.set_height(0);
        		this.divTab.vscrollbar.set_height(0);
        		this.divTab.vscrollbar.set_enable(false);
        		this.divTab.resetScroll();
        	}
        }

        this.pfn_select = function (id)
        {
        	var idx = this.dsInfo.findRow("id", id);
        	this.tabButton_onclick(this.divTab.components["tab" + idx]);
        }
        /*======================================================
         public function - end
         ======================================================*/

        this.fn_makeTabButton = function ()
        {
        	var btn;

        	for (var i = 0; i < this.tabCount; i++) 
        	{
        		btn = new Button();
        		btn.init("tab" + i, "absolute", 0, 5, this.tabW - 0, this.tabH - 5);
        		btn.addEventHandler("onclick", this.tabButton_onclick, this);
        		btn.set_enable(this.dsInfo.getColumn(i, "enable"));
        		btn.set_text(this.dsInfo.getColumn(i, "text"));
        		// class 수정작업 후 반영
        		btn.set_cssclass("btn_TopMenu");
        		// btn.align = "center middle";

        		this.divTab.addChild("tab" + i, btn);
        		this.fn_positionTabButton(i, btn);
        		btn.show();
        	}
        }

        

        // 탭버튼 위치 조정
        this.fn_positionTabButton = function (idx,obj)
        {
        	var posX = 0;
        	posX = this.tabW * idx;
        	obj.set_left(posX);
        }

        this.tabButton_onclick = function (obj)
        {
        	var idx = parseInt(obj.name.split("tab").join(""));
        	var id = this.dsInfo.getColumn(idx, "id");
        	var preName = this.preSelectName;

        	if (preName == obj.name) 
        	{
        		return;
        	}

        	this.fn_initEnableColor(obj);
        	// this.hscrollbar.pos = obj.left;  // 스크롤 위치 이동 : 동작안함

        	this.parent.pfn_callbackTabMenu(id);
        }

        // 선택 색상지정
        this.fn_initEnableColor = function (obj)
        {
        	if (!application.gfn_IsNull(this.preSelectName)) 
        	{
        		this.divTab.components[this.preSelectName].set_cssclass("btn_TopMenu");
        	}

        	obj.set_cssclass("btn_TopMenu_S"); //선택효과 class 적용

        	// 이전 아이디에 현재 아이디 저장
        	this.preSelectName = obj.name;
        }

        this.frmTabMenu_onsize = function (obj,e)
        {
        	// if (gfn_IsNull(system.mobileproducttype) == false)	// 단말인 경우
        	// {
        	// // 		divTab.hscrollbar.visible = true;
        	// // 		divTab.hscrollbar.scrollbarsize = 0;
        	// 
        	// divTab.hscrollbar.position = "absolute 0 68 418 68";
        	// }

        	// obj.resetScroll();

        	// // 애초속성을 scrollbars 설정하고 단말에서는 script로 스크롤바 안보이게 함.(터치 스크롤 이용)
        	// if (gfn_IsNull(system.mobileproducttype) == false)	// 단말인 경우
        	// {
        	// // 		divTab.hscrollbar.visible = true;
        	// // 		divTab.hscrollbar.scrollbarsize = 0;
        	// divTab.hscrollbar.position.top = divTab.hscrollbar.position.bottom;
        	// }
        }

        
        this.divTab_onsize = function (obj,e)
        {
        	// divTab.hscrollbar.resize(400, 0);

        	obj.resetScroll();

        	// 
        	this.setTimer(1, 100);
        }

        this.ComTabMenu_ontimer = function (obj,e)
        {
        	if (e.timerid == 1) 
        	{
        		this.killTimer(1);
        		// divTab.hscrollbar.position.height = 0;
        	}
        }

        this.divTab_onhscroll = function (obj,e)
        {
        	this.fn_setArrow(e.pos);
        	// var lastBtn = divTab.components["tab"+(tabCount-1)].position.right;
        	// var divW = divTab.position.width;
        	// 
        	// if (e.pos <= 0)
        	// {
        	// btnArrowL.class = "btn_TopLeft";
        	// }
        	// else if (e.pos + divW >= lastBtn)
        	// {
        	// btnArrowR.class = "btn_TopRight";
        	// }
        	// else
        	// {
        	// btnArrowL.class = "btn_TopLeft_S";
        	// btnArrowR.class = "btn_TopRight_S";
        	// }
        }

        this.fn_setArrow = function (scrollPos)
        {
        	var lastBtn = this.divTab.components["tab" + (this.tabCount - 1)].getOffsetRight();
        	var divW = this.divTab.getOffsetWidth();

        	if (scrollPos <= 0) 
        	{
        		this.btnArrowL.set_cssclass("btn_TopLeft");
        		if (scrollPos + divW >= lastBtn) 
        		{
        			this.btnArrowR.set_cssclass("btn_TopRight");
        		}
        	}
        	else if (scrollPos + divW >= lastBtn) 
        	{
        		this.btnArrowR.set_cssclass("btn_TopRight");
        	}
        	else 
        	{
        		this.btnArrowL.set_cssclass("btn_TopLeft_S");
        		this.btnArrowR.set_cssclass("btn_TopRight_S");
        	}
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.frmTabMenu_onload, this);
            this.addEventHandler("onsize", this.frmTabMenu_onsize, this);
            this.addEventHandler("ontimer", this.ComTabMenu_ontimer, this);

        };

        this.loadIncludeScript("frmTabMenu.xfdl", true);

       
    };
}
)();
