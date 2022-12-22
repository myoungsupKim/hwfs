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
                this.set_name("frmSampleComboList");
                this.set_titletext("New Form");
                this._setFormPosition(0,0,540,758);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_year", this);
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

            obj = new Dataset("ds_test", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"code\" type=\"STRING\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"code\">01</Col><Col id=\"name\">사과</Col></Row><Row><Col id=\"code\">02</Col><Col id=\"name\">배</Col></Row><Row><Col id=\"code\">03</Col><Col id=\"name\">포도</Col></Row><Row><Col id=\"code\">04</Col><Col id=\"name\">오렌지</Col></Row><Row><Col id=\"code\">05</Col><Col id=\"name\">사과</Col></Row><Row><Col id=\"code\">06</Col><Col id=\"name\">배</Col></Row><Row><Col id=\"code\">07</Col><Col id=\"name\">포도</Col></Row><Row><Col id=\"code\">08</Col><Col id=\"name\">오렌지</Col></Row><Row><Col id=\"code\">09</Col><Col id=\"name\">사과</Col></Row><Row><Col id=\"code\">10</Col><Col id=\"name\">배</Col></Row><Row><Col id=\"code\">11</Col><Col id=\"name\">포도</Col></Row><Row><Col id=\"code\">12</Col><Col id=\"name\">오렌지</Col></Row><Row><Col id=\"code\">13</Col><Col id=\"name\">사과</Col></Row><Row><Col id=\"code\">14</Col><Col id=\"name\">배</Col></Row><Row><Col id=\"code\">15</Col><Col id=\"name\">포도</Col></Row><Row><Col id=\"code\">16</Col><Col id=\"name\">오렌지</Col></Row><Row><Col id=\"code\">17</Col><Col id=\"name\">사과</Col></Row><Row><Col id=\"code\">18</Col><Col id=\"name\">배</Col></Row><Row><Col id=\"code\">19</Col><Col id=\"name\">포도</Col></Row><Row><Col id=\"code\">20</Col><Col id=\"name\">오렌지</Col></Row><Row><Col id=\"code\">21</Col><Col id=\"name\">사과</Col></Row><Row><Col id=\"code\">22</Col><Col id=\"name\">배</Col></Row><Row><Col id=\"code\">23</Col><Col id=\"name\">포도</Col></Row><Row><Col id=\"code\">24</Col><Col id=\"name\">오렌지</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Combo("cmbLtYy", "absolute", "10", "74", "200", "60", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("0");
            obj.set_innerdataset("@ds_year");
            obj.set_codecolumn("year");
            obj.set_datacolumn("year");

            obj = new Combo("cmbFruits", "absolute", "10", "210", "200", "60", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("1");
            obj.set_innerdataset("@ds_test");
            obj.set_codecolumn("code");
            obj.set_datacolumn("name");

            obj = new Static("Static00", "absolute", "12", "7", "348", "60", null, null, this);
            obj.set_taborder("2");
            obj.set_text("년도(년도 공통함수 이용)");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "12", "143", "120", "60", null, null, this);
            obj.set_taborder("3");
            obj.set_text("과일");
            this.addChild(obj.name, obj);

            obj = new Button("Button00", "absolute", "47.96%", "1608", null, "50", "29.81%", null, this);
            obj.set_taborder("4");
            obj.set_text("Button00");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 758, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frmCalendarTest");
            		p.set_titletext("New Form");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("frmSampleComboList.xfdl", "lib::lib_Date.xjs");
        this.registerScript("frmSampleComboList.xfdl", function(exports) {
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Date.xjs", null, exports); }	//include "lib::lib_Date.xjs"

        
        this.frmSampleComboList_onload = function(obj,e)
        {
        	this.fn_yearSearch(10);		// 10년전
        }

        
        /*******************************************************************************
        * 기      능   :  당해년도 10년전
        * 설      명   :  
        ********************************************************************************/
        this.fn_yearSearch = function(year)
        {
        	this.ds_year.clearData();
        	var ds = this.gfn_getYearList(year);
        	this.ds_year.copyData(ds);
        	
        }

        
        this.cmbLtYy_ondropdown = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_year;
        	arg[1] = "년도선택";
        	arg[2] = "";
        	arg[3] = "year";
        	application.goMain.gfn_POP_create("Year", "cmmn::CmmnComboList.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        this.cmbFruits_ondropdown = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_test;
        	arg[1] = "콤보테스트";
        	arg[2] = "";
        	arg[3] = "name";
        	application.goMain.gfn_POP_create("Fruits", "cmmn::CmmnComboList.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        /** 
         * 팝업 callBack
         * @param  : popname - 팝업을 구분짓는 id
         rtn : 팝업이 닫히면서 전달된 값
         * @return : 없음
         */
        this.fn_callbackPOP = function (popname,rtn)
        {
        	switch (popname)
        	{
        		case "Year":		// 년도
        			this.cmbLtYy.set_index(rtn);
        			break;
        		case "Fruits":
        			this.cmbFruits.set_index(rtn);
        			break;
        	}
        }

        
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.frmSampleComboList_onload, this);
            this.cmbLtYy.addEventHandler("ondropdown", this.cmbLtYy_ondropdown, this);
            this.cmbFruits.addEventHandler("ondropdown", this.cmbFruits_ondropdown, this);

        };

        this.loadIncludeScript("frmSampleComboList.xfdl", true);

       
    };
}
)();
