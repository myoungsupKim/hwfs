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
                this.set_name("frmCalendarTest");
                this.set_titletext("New Form");
                this._setFormPosition(0,0,540,758);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_yearCombo", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"year\" type=\"STRING\" size=\"4\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Edit("edtYM", "absolute", "19", "24", "205", "48", null, null, this);
            obj.set_taborder("0");
            this.addChild(obj.name, obj);

            obj = new Button("btnPop", "absolute", "237", "24", "103", "47", null, null, this);
            obj.set_taborder("1");
            obj.set_text("년월");
            this.addChild(obj.name, obj);

            obj = new Button("Button00", "absolute", "122", "120", "202", "58", null, null, this);
            obj.set_taborder("2");
            obj.set_text("Button00");
            this.addChild(obj.name, obj);

            obj = new Button("Button01", "absolute", "56", "268", "346", "78", null, null, this);
            obj.set_taborder("3");
            obj.set_text("년도 목록 가져오기");
            this.addChild(obj.name, obj);

            obj = new Combo("cmbYear", "absolute", "99", "374", "237", "61", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("4");
            obj.set_innerdataset("ds_yearCombo");
            obj.set_codecolumn("year");
            obj.set_datacolumn("year");

            obj = new Edit("Edit00", "absolute", "56", "469", "249", "51", null, null, this);
            obj.set_taborder("5");
            obj.set_value("20140101");
            this.addChild(obj.name, obj);

            obj = new Button("Button02", "absolute", "311", "469", "120", "53", null, null, this);
            obj.set_taborder("6");
            obj.set_text("Button02");
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
        this.addIncludeScript("frmCalendarTest.xfdl", "lib::lib_Date.xjs");
        this.registerScript("frmCalendarTest.xfdl", function(exports) {
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Date.xjs", null, exports); }	//include "lib::lib_Date.xjs"

        this.frmCalendarTest_onload = function(obj,e)
        {
        	var sYM = this.gfn_Today().toString().substr(0, 6);
        	
        	this.edtYM.set_value(sYM);
        }

        this.btnPop_onclick = function(obj,e)
        {
        	var objCalArg = this.edtYM.value;
        	
        	application.goMain.gfn_POP_create("PopCalMonth", "cmmn::frmCalMonth.xfdl", "fn_callbackPOP", this, objCalArg, "POPx", application.goMain.divBase);
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
        		case "PopCalMonth":				// 년월
        			this.edtYM.set_value(rtn);
        			break;
        	}
        }

        this.Button00_onclick = function(obj,e)
        {
        	var sDate;
        	
        //	this.alert(typeof(sDate));
        	sDate = this.gfn_AddMonth(this.edtYM.value, -1);
        	
        	this.edtYM.set_value(sDate);
        }

        this.Button01_onclick = function(obj,e)
        {
        	this.ds_yearCombo.copyData(this.gfn_getYearList(10));
        }

        this.Button02_onclick = function(obj,e)
        {
        //	this.gfn_GetDateMaskFormat = function (sDate, sMask, sDispSect)

        	this.alert(this.gfn_GetDateMaskFormat(this.Edit00.text, "-", "1"));
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.frmCalendarTest_onload, this);
            this.btnPop.addEventHandler("onclick", this.btnPop_onclick, this);
            this.Button00.addEventHandler("onclick", this.Button00_onclick, this);
            this.Button01.addEventHandler("onclick", this.Button01_onclick, this);
            this.Button02.addEventHandler("onclick", this.Button02_onclick, this);

        };

        this.loadIncludeScript("frmCalendarTest.xfdl", true);

       
    };
}
)();
