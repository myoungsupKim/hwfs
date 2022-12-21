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
                this.set_name("frmExam_001");
                this.set_titletext("New Form");
                this._setFormPosition(0,0,562,1130);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("Dataset00", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj.set_keystring("G:column0");
            obj._setContents("<ColumnInfo><Column id=\"column0\" type=\"STRING\" size=\"256\"/><Column id=\"column1\" type=\"STRING\" size=\"256\"/><Column id=\"column2\" type=\"INT\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"column0\">A</Col><Col id=\"column1\">A1</Col><Col id=\"column2\">100</Col></Row><Row><Col id=\"column0\">A</Col><Col id=\"column1\">A2</Col><Col id=\"column2\">120</Col></Row><Row><Col id=\"column0\">B</Col><Col id=\"column1\">B1</Col><Col id=\"column2\">1200</Col></Row></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("Dataset01", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"t1\" type=\"STRING\" size=\"256\"/><Column id=\"t2\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"t1\">A</Col><Col id=\"t2\">A1</Col></Row><Row><Col id=\"t1\">A</Col><Col id=\"t2\">A2</Col></Row><Row><Col id=\"t1\">B</Col><Col id=\"t2\">B1</Col></Row><Row><Col id=\"t1\">B</Col><Col id=\"t2\">B2</Col></Row><Row><Col id=\"t1\">C</Col><Col id=\"t2\">C1</Col></Row><Row><Col id=\"t1\">C</Col><Col id=\"t2\">C2</Col></Row></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("Dataset02", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"Column0\" type=\"STRING\" size=\"256\"/><Column id=\"Column1\" type=\"STRING\" size=\"256\"/><Column id=\"Column2\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column0\">A</Col><Col id=\"Column1\">0</Col></Row><Row><Col id=\"Column0\">A1</Col><Col id=\"Column1\">1</Col></Row><Row><Col id=\"Column0\">A2</Col><Col id=\"Column1\">1</Col></Row><Row><Col id=\"Column0\">B</Col><Col id=\"Column1\">0</Col></Row><Row><Col id=\"Column0\">B1</Col><Col id=\"Column1\">1</Col></Row><Row><Col id=\"Column0\">C</Col><Col id=\"Column1\">0</Col></Row><Row><Col id=\"Column0\">C1</Col><Col id=\"Column1\">1</Col></Row><Row><Col id=\"Column0\">C2</Col><Col id=\"Column1\">1</Col></Row></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_cond", this);
            obj._setContents("<ColumnInfo><Column id=\"USER_NM\" type=\"string\" size=\"32\"/></ColumnInfo><Rows><Row/></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_list", this);
            obj._setContents("<ColumnInfo><Column id=\"USER_ID\" type=\"string\" size=\"32\"/><Column id=\"APP_ID\" type=\"string\" size=\"32\"/><Column id=\"ORG_USER_ID\" type=\"string\" size=\"32\"/><Column id=\"PWD\" type=\"string\" size=\"32\"/><Column id=\"USER_NM\" type=\"string\" size=\"32\"/><Column id=\"ENG_USER_NM\" type=\"string\" size=\"32\"/><Column id=\"EMAIL\" type=\"string\" size=\"32\"/><Column id=\"PSN_CD\" type=\"string\" size=\"32\"/><Column id=\"MBLE_NO\" type=\"string\" size=\"32\"/><Column id=\"H_TEL_NO\" type=\"string\" size=\"32\"/><Column id=\"W_TEL_NO\" type=\"string\" size=\"32\"/><Column id=\"ADDR\" type=\"string\" size=\"32\"/><Column id=\"ADDR_DTL\" type=\"string\" size=\"32\"/><Column id=\"POST_NO\" type=\"string\" size=\"32\"/><Column id=\"ORG_ID\" type=\"string\" size=\"32\"/><Column id=\"ADM_LVL\" type=\"string\" size=\"32\"/><Column id=\"ATTR1\" type=\"string\" size=\"32\"/><Column id=\"ATTR2\" type=\"string\" size=\"32\"/><Column id=\"ATTR3\" type=\"string\" size=\"32\"/><Column id=\"USE_YN\" type=\"string\" size=\"32\"/><Column id=\"LANG\" type=\"string\" size=\"32\"/><Column id=\"REG_USER_ID\" type=\"string\" size=\"32\"/><Column id=\"REG_DT\" type=\"string\" size=\"32\"/><Column id=\"UPD_USER_ID\" type=\"string\" size=\"32\"/><Column id=\"UPD_DT\" type=\"string\" size=\"32\"/></ColumnInfo><Rows/>");
            this.addChild(obj.name, obj);

            obj = new Dataset("Dataset03", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj.set_keystring("G:-Column0");
            obj.set_preload("false");
            obj._setContents("<ColumnInfo><Column id=\"Column0\" type=\"STRING\" size=\"256\" sumtext=\" \"/><Column id=\"Column1\" type=\"STRING\" size=\"256\" sumtext=\" \"/><Column id=\"Column2\" type=\"STRING\" size=\"256\" sumtext=\" \"/><Column id=\"Column3\" type=\"INT\" size=\"256\" prop=\"SUM\"/><Column id=\"Column4\" type=\"FLOAT\" size=\"256\" prop=\"AVG\"/><Column id=\"Column5\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column0\">2014/1</Col><Col id=\"Column1\">일선</Col><Col id=\"Column2\">영어의 세계</Col><Col id=\"Column3\">3</Col><Col id=\"Column4\">4</Col><Col id=\"Column5\">A</Col></Row><Row><Col id=\"Column0\">2014/1</Col><Col id=\"Column1\">일선</Col><Col id=\"Column2\">영어의 네계</Col><Col id=\"Column3\">3</Col><Col id=\"Column4\">3</Col><Col id=\"Column5\">B</Col></Row><Row><Col id=\"Column0\">2013/2</Col><Col id=\"Column1\">일선</Col><Col id=\"Column2\">수학</Col><Col id=\"Column3\">3</Col><Col id=\"Column4\">3</Col><Col id=\"Column5\">B</Col></Row><Row><Col id=\"Column0\">2013/2</Col><Col id=\"Column1\">일선</Col><Col id=\"Column2\">전산</Col><Col id=\"Column3\">3</Col><Col id=\"Column4\">3.5</Col><Col id=\"Column5\">B+</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new CheckBox("CheckBox00", "absolute", "581", "-1", "167", "50", null, null, this);
            obj.set_taborder("0");
            obj.set_text("CheckBox00");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid00", "absolute", "21", "333", "425", "243", null, null, this);
            obj.set_taborder("1");
            obj.set_binddataset("Dataset00");
            obj.set_visible("false");
            obj.set_positionstep("1");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/></Columns><Rows><Row band=\"head\" size=\"24\"/><Row band=\"body\" size=\"24\"/></Rows><Band id=\"head\"><Cell col=\"0\" disptype=\"normal\" text=\"column0\"/><Cell col=\"1\" disptype=\"normal\" text=\"column1\"/><Cell col=\"2\" disptype=\"normal\" text=\"column2\"/></Band><Band id=\"body\"><Cell col=\"0\" disptype=\"normal\" text=\"bind:column0\"/><Cell col=\"1\" disptype=\"normal\" text=\"bind:column1\"/><Cell col=\"2\" disptype=\"normal\" text=\"bind:column2\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Button("Button00", "absolute", "252", "1073", null, "45", "248", null, this);
            obj.set_taborder("4");
            obj.set_text("Button00");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit00", "absolute", "16", "38", "180", "49", null, null, this);
            obj.set_taborder("5");
            this.addChild(obj.name, obj);

            obj = new Button("Button01", "absolute", "224", "36", "178", "57", null, null, this);
            obj.set_taborder("6");
            obj.set_text("Button01");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid02", "absolute", "16", "106", "532", "481", null, null, this);
            obj.set_taborder("7");
            obj.set_binddataset("ds_list");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/></Columns><Rows><Row band=\"head\" size=\"24\"/><Row band=\"body\" size=\"24\"/></Rows><Band id=\"head\"><Cell col=\"0\" disptype=\"normal\" text=\"USER_ID\"/><Cell col=\"1\" disptype=\"normal\" text=\"APP_ID\"/><Cell col=\"2\" disptype=\"normal\" text=\"ORG_USER_ID\"/><Cell col=\"3\" disptype=\"normal\" text=\"PWD\"/><Cell col=\"4\" disptype=\"normal\" text=\"USER_NM\"/><Cell col=\"5\" disptype=\"normal\" text=\"ENG_USER_NM\"/><Cell col=\"6\" disptype=\"normal\" text=\"EMAIL\"/><Cell col=\"7\" disptype=\"normal\" text=\"PSN_CD\"/><Cell col=\"8\" disptype=\"normal\" text=\"MBLE_NO\"/><Cell col=\"9\" disptype=\"normal\" text=\"H_TEL_NO\"/><Cell col=\"10\" disptype=\"normal\" text=\"W_TEL_NO\"/><Cell col=\"11\" disptype=\"normal\" text=\"ADDR\"/><Cell col=\"12\" disptype=\"normal\" text=\"ADDR_DTL\"/><Cell col=\"13\" disptype=\"normal\" text=\"POST_NO\"/><Cell col=\"14\" disptype=\"normal\" text=\"ORG_ID\"/><Cell col=\"15\" disptype=\"normal\" text=\"ADM_LVL\"/><Cell col=\"16\" disptype=\"normal\" text=\"ATTR1\"/><Cell col=\"17\" disptype=\"normal\" text=\"ATTR2\"/><Cell col=\"18\" disptype=\"normal\" text=\"ATTR3\"/><Cell col=\"19\" disptype=\"normal\" text=\"USE_YN\"/><Cell col=\"20\" disptype=\"normal\" text=\"LANG\"/><Cell col=\"21\" disptype=\"normal\" text=\"REG_USER_ID\"/><Cell col=\"22\" disptype=\"normal\" text=\"REG_DT\"/><Cell col=\"23\" disptype=\"normal\" text=\"UPD_USER_ID\"/><Cell col=\"24\" disptype=\"normal\" text=\"UPD_DT\"/></Band><Band id=\"body\"><Cell col=\"0\" disptype=\"normal\" text=\"bind:USER_ID\"/><Cell col=\"1\" disptype=\"normal\" text=\"bind:APP_ID\"/><Cell col=\"2\" disptype=\"normal\" text=\"bind:ORG_USER_ID\"/><Cell col=\"3\" disptype=\"normal\" text=\"bind:PWD\"/><Cell col=\"4\" disptype=\"normal\" text=\"bind:USER_NM\"/><Cell col=\"5\" disptype=\"normal\" text=\"bind:ENG_USER_NM\"/><Cell col=\"6\" disptype=\"normal\" text=\"bind:EMAIL\"/><Cell col=\"7\" disptype=\"normal\" text=\"bind:PSN_CD\"/><Cell col=\"8\" disptype=\"normal\" text=\"bind:MBLE_NO\"/><Cell col=\"9\" disptype=\"normal\" text=\"bind:H_TEL_NO\"/><Cell col=\"10\" disptype=\"normal\" text=\"bind:W_TEL_NO\"/><Cell col=\"11\" disptype=\"normal\" text=\"bind:ADDR\"/><Cell col=\"12\" disptype=\"normal\" text=\"bind:ADDR_DTL\"/><Cell col=\"13\" disptype=\"normal\" text=\"bind:POST_NO\"/><Cell col=\"14\" disptype=\"normal\" text=\"bind:ORG_ID\"/><Cell col=\"15\" disptype=\"normal\" text=\"bind:ADM_LVL\"/><Cell col=\"16\" disptype=\"normal\" text=\"bind:ATTR1\"/><Cell col=\"17\" disptype=\"normal\" text=\"bind:ATTR2\"/><Cell col=\"18\" disptype=\"normal\" text=\"bind:ATTR3\"/><Cell col=\"19\" disptype=\"normal\" text=\"bind:USE_YN\"/><Cell col=\"20\" disptype=\"normal\" text=\"bind:LANG\"/><Cell col=\"21\" disptype=\"normal\" text=\"bind:REG_USER_ID\"/><Cell col=\"22\" disptype=\"normal\" text=\"bind:REG_DT\"/><Cell col=\"23\" disptype=\"normal\" text=\"bind:UPD_USER_ID\"/><Cell col=\"24\" disptype=\"normal\" text=\"bind:UPD_DT\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid01", "absolute", "16", "107", "531", "477", null, null, this);
            obj.set_taborder("2");
            obj.set_treeusecheckbox("false");
            obj.set_treeuseimage("false");
            obj.set_binddataset("Dataset02");
            obj.set_visible("true");
            obj.set_treeinitstatus("collapse,null");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"80\"/></Columns><Rows><Row size=\"24\" band=\"head\"/><Row size=\"24\"/></Rows><Band id=\"head\"><Cell text=\"Column0\"/></Band><Band id=\"body\"><Cell displaytype=\"tree\" edittype=\"tree\" text=\"bind:Column0\" treelevel=\"bind:Column1\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Button("btnTab01", "absolute", "51", "674", "118", "50", null, null, this);
            obj.set_taborder("8");
            obj.set_text("탭1");
            obj.set_cssclass("btn_Tab02");
            this.addChild(obj.name, obj);

            obj = new Button("btnTab02", "absolute", "179", "674", "118", "50", null, null, this);
            obj.set_taborder("9");
            obj.set_text("탭2");
            obj.set_cssclass("btn_Tab01");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid03", "absolute", "16", "106", "532", "478", null, null, this);
            obj.set_taborder("10");
            obj.set_binddataset("Dataset03");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/></Columns><Rows><Row size=\"24\" band=\"head\"/><Row size=\"24\"/></Rows><Band id=\"head\"><Cell text=\"Column0\"/><Cell col=\"1\" text=\"Column1\"/><Cell col=\"2\" text=\"Column2\"/><Cell col=\"3\" text=\"Column3\"/><Cell col=\"4\" text=\"Column4\"/><Cell col=\"5\" text=\"Column5\"/></Band><Band id=\"body\"><Cell style=\"align:center;\" text=\"bind:Column0\" suppress=\"1\"/><Cell col=\"1\" style=\"align:center;\" text=\"bind:Column1\"/><Cell col=\"2\" style=\"align: ;\" text=\"bind:Column2\"/><Cell col=\"3\" style=\"align:center;\" text=\"bind:Column3\"/><Cell col=\"4\" style=\"align:center;\" text=\"bind:Column4\"/><Cell col=\"5\" style=\"align:center;\" text=\"bind:Column5\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "ScreenPhone", 562, 1130, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frmExam_001");
            		p.set_titletext("New Form");

            	}
            );
            obj.set_stepcount("");
            this.addLayout(obj.name, obj);


            
            // BindItem Information
            obj = new BindItem("item0","Edit00","value","ds_cond","USER_NM");
            this.addChild(obj.name, obj);
            obj.bind();

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("frmExam_001.xfdl", "lib::sz_fsp_xp.xjs");
        this.registerScript("frmExam_001.xfdl", function(exports) {
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::sz_fsp_xp.xjs", null, exports); }	//include "lib::sz_fsp_xp.xjs";

        this.form_onload = function (obj,e)
        {
         this.fsp_init();
        }

        /*******************************************************************************
        * 기      능   : 조회
        * 설      명   : undefined
        ********************************************************************************/
        this.fn_search = function ()
        {
        	this.fsp_clear();
        	this.fsp_addSearch("sample:FSP_USER_SELECT", false);
        	// connect the server 
        	this.fsp_callService(
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
        * 기      능   : search callback
        ********************************************************************************/
        this.fn_afterSearch = function (ErrorCode,ErrorMsg)
        {
        	this.alert(this.ds_list.getRowCount()+"건 조회");
        }

        /*******************************************************************************
        * 기      능   : 뒤로 가기 처리
        ********************************************************************************/
        this.fn_back = function ()
        {
        	
        }

        this.btnTab01_onclick = function(obj,e)
        {
        	application.gfn_chgTabCSS(obj, this.btnTab02);
        }

        this.btnTab02_onclick = function(obj,e)
        {
        	application.gfn_chgTabCSS(obj, this.btnTab01);
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.Button01.addEventHandler("onclick", this.fn_search, this);
            this.btnTab01.addEventHandler("onclick", this.btnTab01_onclick, this);
            this.btnTab02.addEventHandler("onclick", this.btnTab02_onclick, this);

        };

        this.loadIncludeScript("frmExam_001.xfdl", true);

       
    };
}
)();
