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
                this.set_name("Popup_Default");
                this.set_titletext("공지사항");
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
            obj._setContents("<ColumnInfo><Column id=\"Column0\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column0\">[중요/공지]*설날 연휴….</Col></Row><Row><Col id=\"Column0\">[MSDS]물질 안전보건자료</Col></Row><Row><Col id=\"Column0\">여름철 쌀에서 나올수  있는 벌레 및 쌀 나방…</Col></Row><Row><Col id=\"Column0\">[MSDS]물질 안전보건자료</Col></Row><Row><Col id=\"Column0\">[MSDS]물질 안전보건자료</Col></Row><Row><Col id=\"Column0\">[중요/공지]테스트…</Col></Row><Row><Col id=\"Column0\">[중요/공지]테스트…</Col></Row><Row><Col id=\"Column0\">[공지] 당사 물류센터 방사는 축정기기 도입</Col></Row><Row><Col id=\"Column0\">[공지] 당사 물류센터 방사는 축정기기 도입</Col></Row><Row><Col id=\"Column0\">[공지] 당사 물류센터 방사는 축정기기 도입</Col></Row><Row><Col id=\"Column0\">겨울철 배송관련 안내</Col></Row><Row><Col id=\"Column0\">신정연휴 수급불가 상품안내</Col></Row><Row><Col id=\"Column0\">소모품업체 변경안내</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Button("Button01", "absolute", "270", "0", "270", "63", null, null, this);
            obj.set_taborder("115");
            obj.set_text("본사");
            obj.set_cssclass("btn_WF_TabTFOff");
            this.addChild(obj.name, obj);

            obj = new Button("Button00", "absolute", "0", "0", "270", "63", null, null, this);
            obj.set_taborder("116");
            obj.set_text("한화");
            obj.set_cssclass("btn_WF_TabTFOn");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid00", "absolute", "0", "63", null, "651", "0", null, this);
            obj.set_taborder("117");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("none");
            obj.set_cssclass("grd_WF_Default2");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"540\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"Column0\"/></Band><Band id=\"body\"><Cell style=\"align: ;padding:0 10 0 10;\" text=\"bind:Column0\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Button("Button36", "absolute", "0", null, null, "35", "0", "0", this);
            obj.set_taborder("118");
            obj.set_text("더보기");
            obj.set_cssclass("btn_WF_More");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "580", "413", "411", "35", null, null, this);
            obj.set_taborder("108");
            obj.set_text("Class : grd_WF_Default2 / Padding : 0 10 0 10");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static11", "absolute", "523", "428", null, "2", "-35", null, this);
            obj.set_taborder("109");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
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

        
        // Regist UI Components Event
        this.on_initEvent = function()
        {

        };

        this.loadIncludeScript("TEMPLATE_04.xfdl", true);

       
    };
}
)();
