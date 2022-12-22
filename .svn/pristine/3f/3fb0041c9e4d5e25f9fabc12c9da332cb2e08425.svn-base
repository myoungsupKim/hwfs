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
                this.set_name("CmmnCalMonthPop");
                this.set_titletext("월력");
                this._setFormPosition(0,0,417,569);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("dsMonth", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"MN01\" type=\"STRING\" size=\"256\"/><Column id=\"MS01\" type=\"STRING\" size=\"256\"/><Column id=\"MN02\" type=\"STRING\" size=\"256\"/><Column id=\"MS02\" type=\"STRING\" size=\"256\"/><Column id=\"MN03\" type=\"STRING\" size=\"256\"/><Column id=\"MS03\" type=\"STRING\" size=\"256\"/><Column id=\"MN04\" type=\"STRING\" size=\"256\"/><Column id=\"MS04\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"MN01\">1</Col><Col id=\"MN02\">2</Col><Col id=\"MN03\">3</Col><Col id=\"MN04\">4</Col><Col id=\"MS01\">JAN</Col><Col id=\"MS02\">FEB</Col><Col id=\"MS03\">MAR</Col><Col id=\"MS04\">APR</Col></Row><Row><Col id=\"MN01\">5</Col><Col id=\"MN02\">6</Col><Col id=\"MN03\">7</Col><Col id=\"MN04\">8</Col><Col id=\"MS01\">MAY</Col><Col id=\"MS02\">JUN</Col><Col id=\"MS03\">JUL</Col><Col id=\"MS04\">AUG</Col></Row><Row><Col id=\"MN04\">12</Col><Col id=\"MN03\">11</Col><Col id=\"MN02\">10</Col><Col id=\"MN01\">9</Col><Col id=\"MS01\">SEP</Col><Col id=\"MS02\">OCT</Col><Col id=\"MS03\">NOV</Col><Col id=\"MS04\">DEC</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "417", "567", null, null, this);
            obj.set_taborder("4");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "0", "0", "417", "70", null, null, this);
            obj.set_taborder("7");
            obj.set_text("Calendar");
            obj.set_cssclass("sta_POP_TitleBg");
            this.addChild(obj.name, obj);

            obj = new Button("btnClose", "absolute", "347", "0", "70", "70", null, null, this);
            obj.set_taborder("5");
            obj.set_cssclass("btn_POP_XBtn");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "342", "70", "102", "10", null, null, this);
            obj.set_taborder("8");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("right middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "407", "488", "10", "100", null, null, this);
            obj.set_taborder("9");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("left bottom");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "10", "80", "397", "477", null, null, this);
            obj.set_taborder("10");
            obj.set_cssclass("sta_WF_MonthCalBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "342", "559", "102", "10", null, null, this);
            obj.set_taborder("11");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("right middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "0", "488", "10", "100", null, null, this);
            obj.set_taborder("12");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("left bottom");
            this.addChild(obj.name, obj);

            obj = new Static("staYear", "absolute", "11", "81", "395", "65", null, null, this);
            obj.set_taborder("1");
            obj.set_text("2014");
            obj.set_cssclass("sta_WF_MonthCalTitle");
            this.addChild(obj.name, obj);

            obj = new Button("btnNext", "absolute", "325", "81", "81", "65", null, null, this);
            obj.set_taborder("2");
            obj.set_cssclass("btn_WF_MonthCalNextBtn");
            this.addChild(obj.name, obj);

            obj = new Button("btnPrev", "absolute", "11", "81", "81", "65", null, null, this);
            obj.set_taborder("3");
            obj.set_cssclass("btn_WF_MonthCalPreBtn");
            this.addChild(obj.name, obj);

            obj = new Grid("grdCal", "absolute", "20", "156", "382", "397", null, null, this);
            obj.set_taborder("0");
            obj.set_binddataset("dsMonth");
            obj.set_autofittype("col");
            obj.set_selecttype("cell");
            obj.set_scrollbars("none");
            obj.set_cssclass("grd_WF_MonthCal");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"95\"/><Column size=\"95\"/><Column size=\"95\"/><Column size=\"95\"/></Columns><Rows><Row size=\"67\"/><Row size=\"65\"/></Rows><Band id=\"body\"><Cell rowspan=\"2\" style=\"background:URL('HWImage::grd_WF_MonthCalBg.png') stretch 6,6;background2:URL('HWImage::grd_WF_MonthCalBg.png') stretch 6,6;selectbackground:URL('HWImage::grd_WF_MonthCalBgS.png') stretch 6,6;\"><Cell style=\"align: ;\" text=\"bind:MN01\"/><Cell row=\"1\" style=\"align:center top;color:#999999ff;color2:#999999ff;font:antialias 17 Droid Sans;selectcolor:#999999ff;selectfont:antialias 17 Droid Sans;\" text=\"bind:MS01\"/></Cell><Cell col=\"1\" rowspan=\"2\" style=\"background:URL('HWImage::grd_WF_MonthCalBg.png') stretch 6,6;background2:URL('HWImage::grd_WF_MonthCalBg.png') stretch 6,6;selectbackground:URL('HWImage::grd_WF_MonthCalBgS.png') stretch 6,6;\"><Cell style=\"align: ;\" text=\"bind:MN02\"/><Cell row=\"1\" style=\"align:center top;color:#999999ff;color2:#999999ff;font:antialias 17 Droid Sans;selectcolor:#999999ff;selectfont:antialias 17 Droid Sans;\" text=\"bind:MS02\"/></Cell><Cell col=\"2\" rowspan=\"2\" style=\"background:URL('HWImage::grd_WF_MonthCalBg.png') stretch 6,6;background2:URL('HWImage::grd_WF_MonthCalBg.png') stretch 6,6;selectbackground:URL('HWImage::grd_WF_MonthCalBgS.png') stretch 6,6;\"><Cell style=\"align: ;\" text=\"bind:MN03\"/><Cell row=\"1\" style=\"align:center top;color:#999999ff;color2:#999999ff;font:antialias 17 Droid Sans;selectcolor:#999999ff;selectfont:antialias 17 Droid Sans;\" text=\"bind:MS03\"/></Cell><Cell col=\"3\" rowspan=\"2\" style=\"background:URL('HWImage::grd_WF_MonthCalBg.png') stretch 6,6;background2:URL('HWImage::grd_WF_MonthCalBg.png') stretch 6,6;selectbackground:URL('HWImage::grd_WF_MonthCalBgS.png') stretch 6,6;\"><Cell style=\"align: ;\" text=\"bind:MN04\"/><Cell row=\"1\" style=\"align:center top;color:#999999ff;color2:#999999ff;font:antialias 17 Droid Sans;selectcolor:#999999ff;selectfont:antialias 17 Droid Sans;\" text=\"bind:MS04\"/></Cell></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "158", "146", "102", "10", null, null, this);
            obj.set_taborder("13");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "158", "552", "102", "5", null, null, this);
            obj.set_taborder("14");
            obj.set_text("h05");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "10", "298", "10", "100", null, null, this);
            obj.set_taborder("15");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "402", "298", "5", "100", null, null, this);
            obj.set_taborder("16");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 417, 569, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frmCalMonth");
            		p.set_titletext("월력");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("CmmnCalMonthPop.xfdl", "lib::lib_Date.xjs");
        this.addIncludeScript("CmmnCalMonthPop.xfdl", "lib::lib_String.xjs");
        this.registerScript("CmmnCalMonthPop.xfdl", function(exports) {
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Date.xjs", null, exports); }	//include "lib::lib_Date.xjs"
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_String.xjs", null, exports); }	//include "lib::lib_String.xjs"

        this.preMonth = undefined;

        this.CmmnCalMonthPop_onload = function(obj,e)
        {
        	var sYear;
        	var sMonth;
        	var nMonth;
        	var nRow, nCol;
        	
        	this.preMonth = application.goMain.gfn_POP_getArg();	

        	if (application.gfn_IsNull(this.preMonth))
        	{
        		this.preMonth = this.gfn_Today().toString().substr(0, 6);
        	}
        	
        	sYear = this.preMonth.toString().substr(0, 4);
        	sMonth = this.preMonth.toString().substr(4, 2);
        	nMonth = nexacro.toNumber(sMonth);
        	
        	this.staYear.set_text(sYear);
        	
        	nRow = (nMonth - 1) / 4;
        	nCol = ((nMonth - 1) % 4);

        	this.dsMonth.set_rowposition(nRow);
        	this.grdCal.setCellPos(nCol);
        	
        	application.goMain.gfn_POP_resize(this);
        }

        this.btnNext_onclick = function(obj,e)
        {
        	var nYear;
        	
        	nYear = nexacro.toNumber(this.staYear.text);
        	++nYear;
        	
        	this.staYear.set_text(nYear);
        }

        this.btnPrev_onclick = function(obj,e)
        {
        	var nYear;
        	
        	nYear = nexacro.toNumber(this.staYear.text);
        	--nYear;
        	
        	this.staYear.set_text(nYear);
        }

        this.grdCal_oncellclick = function(obj,e)
        {
        	var sRtn;
        	var sMonth;

        	sMonth = this.dsMonth.getColumn(e.row, e.col * 2).toString().padLeft(2, "0");
        	sRtn = this.staYear.text + sMonth;
        	
        	application.goMain.gfn_POP_close(this, sRtn);
        }

        this.btnClose_onclick = function(obj,e)
        {
        	application.goMain.gfn_POP_close(this, "CLOSEONLY");
        }

        this.staClose_onclick = function(obj,e)
        {
        	application.goMain.gfn_POP_close(this, "CLOSEONLY");
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.CmmnCalMonthPop_onload, this);
            this.btnClose.addEventHandler("onclick", this.btnClose_onclick, this);
            this.btnNext.addEventHandler("onclick", this.btnNext_onclick, this);
            this.btnPrev.addEventHandler("onclick", this.btnPrev_onclick, this);
            this.grdCal.addEventHandler("oncellclick", this.grdCal_oncellclick, this);

        };

        this.loadIncludeScript("CmmnCalMonthPop.xfdl", true);

       
    };
}
)();
