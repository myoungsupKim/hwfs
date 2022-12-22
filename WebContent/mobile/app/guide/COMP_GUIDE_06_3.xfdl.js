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
                this.set_name("GUIDE_class");
                this.set_titletext("Grid_Detail");
                this._setFormPosition(0,0,540,942);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_grdDetail01", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"Column1\" type=\"STRING\" size=\"256\"/><Column id=\"Column2\" type=\"STRING\" size=\"256\"/><Column id=\"Column3\" type=\"STRING\" size=\"256\"/><Column id=\"Column4\" type=\"STRING\" size=\"256\"/><Column id=\"Column5\" type=\"STRING\" size=\"256\"/><Column id=\"Column6\" type=\"STRING\" size=\"256\"/><Column id=\"Column7\" type=\"STRING\" size=\"256\"/><Column id=\"Column8\" type=\"STRING\" size=\"256\"/><Column id=\"Column9\" type=\"STRING\" size=\"256\"/><Column id=\"Column10\" type=\"STRING\" size=\"256\"/><Column id=\"Column11\" type=\"STRING\" size=\"256\"/><Column id=\"Column12\" type=\"STRING\" size=\"256\"/><Column id=\"Column13\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column1\">소고기 한우 ++A 특수부위</Col><Col id=\"Column2\">규격</Col><Col id=\"Column3\">3523 X 1213</Col><Col id=\"Column4\">수량</Col><Col id=\"Column5\">100</Col><Col id=\"Column6\">코드</Col><Col id=\"Column7\">100700</Col><Col id=\"Column8\">단위</Col><Col id=\"Column9\">200Kg</Col><Col id=\"Column10\">단가</Col><Col id=\"Column11\">12000</Col><Col id=\"Column12\">금액</Col><Col id=\"Column13\">71000</Col></Row></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_grdDetail02", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"Column0\" type=\"STRING\" size=\"256\"/><Column id=\"Column1\" type=\"STRING\" size=\"256\"/><Column id=\"Column2\" type=\"STRING\" size=\"256\"/><Column id=\"Column3\" type=\"STRING\" size=\"256\"/><Column id=\"Column4\" type=\"STRING\" size=\"256\"/><Column id=\"Column5\" type=\"STRING\" size=\"256\"/><Column id=\"Column6\" type=\"STRING\" size=\"256\"/><Column id=\"Column7\" type=\"STRING\" size=\"256\"/><Column id=\"Column8\" type=\"STRING\" size=\"256\"/><Column id=\"Column9\" type=\"STRING\" size=\"256\"/><Column id=\"Column10\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column0\">업체</Col><Col id=\"Column1\">한촌-강남점</Col><Col id=\"Column2\">채권</Col><Col id=\"Column3\">30000</Col><Col id=\"Column4\">100000</Col><Col id=\"Column5\">총여신</Col><Col id=\"Column6\">2500</Col><Col id=\"Column7\">매출</Col><Col id=\"Column8\">50000</Col><Col id=\"Column9\">입금</Col><Col id=\"Column10\">40000</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("Static00", "absolute", "-1", "0", null, "50", "0", null, this);
            obj.set_taborder("0");
            obj.set_text("Grid_Detail01");
            obj.style.set_background("#edeee6ff");
            obj.style.set_border("1 solid #c6c6c5ff");
            obj.style.set_align("center middle");
            obj.style.set_font("antialias 15 Tahoma");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid00", "absolute", "10", "143", "520", "201", null, null, this);
            obj.set_taborder("15");
            obj.set_binddataset("ds_grdDetail01");
            obj.set_scrollbars("none");
            obj.set_selecttype("cell");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"110\"/><Column size=\"150\"/><Column size=\"110\"/><Column size=\"150\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"GrayLabel\"/><Cell col=\"1\" text=\"WhiteLabel\"/><Cell col=\"2\" text=\"GrayLabel\"/><Cell col=\"3\" text=\"WhiteLabel\"/></Band><Band id=\"body\"><Cell colspan=\"4\" celltype=\"none\" cssclass=\"CellGrd_WF_LabelIndigo\" text=\"bind:Column1\"/><Cell row=\"1\" celltype=\"none\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:Column2\"/><Cell row=\"1\" col=\"1\" displaytype=\"number\" edittype=\"none\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:Column3\"/><Cell row=\"1\" col=\"2\" celltype=\"none\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:Column4\"/><Cell row=\"1\" col=\"3\" displaytype=\"number\" edittype=\"none\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:Column5\"/><Cell row=\"2\" celltype=\"none\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:Column6\"/><Cell row=\"2\" col=\"1\" edittype=\"none\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:Column7\"/><Cell row=\"2\" col=\"2\" celltype=\"none\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:Column8\"/><Cell row=\"2\" col=\"3\" displaytype=\"number\" edittype=\"none\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:Column9\"/><Cell row=\"3\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:Column10\"/><Cell row=\"3\" col=\"1\" displaytype=\"number\" cssclass=\"CellGrd_WF_ColorBlue\" text=\"bind:Column11\"/><Cell row=\"3\" col=\"2\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:Column12\"/><Cell row=\"3\" col=\"3\" displaytype=\"number\" cssclass=\"CellGrd_WF_ColorRed\" text=\"bind:Column13\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static24", "absolute", "25", "64", "510", "60", null, null, this);
            obj.set_taborder("16");
            obj.set_text("※ Detail형 그리드는 Head 높이값이 0으로 사용하지 않는다.\r\n※ 특이 Cell Style에 대해 Cell Class를 사용한다.\r\n※ align은 center정렬이 기본이며 left/right 정렬이 필요 시 해당 Cell의 Properties에 \r\n   align값과 padding값을 직접 입력한다.");
            obj.set_cssclass("sta_GUIDE_RedText");
            obj.set_visible("false");
            obj.style.set_linespace("3");
            obj.style.set_align("left top");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "143", "21", "50", null, null, this);
            obj.set_taborder("27");
            obj.set_text("h50");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "565", "299", "395", "35", null, null, this);
            obj.set_taborder("36");
            obj.set_text("CellClass : CellGrd_WF_ColorRed / DisplayType : number");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "101.48%", "220", "2", "46", null, null, this);
            obj.set_taborder("39");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("true");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "96.11%", "218", "30", "2", null, null, this);
            obj.set_taborder("40");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static10", "absolute", "96.11%", "266", "30", "2", null, null, this);
            obj.set_taborder("41");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static11", "absolute", "565", "225", "365", "35", null, null, this);
            obj.set_taborder("42");
            obj.set_text("CellClass : CellGrd_WF_LabelWhite");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static12", "absolute", "519", "314", "37", "2", null, null, this);
            obj.set_taborder("43");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static23", "absolute", "11", "344", "110", "23", null, null, this);
            obj.set_taborder("57");
            obj.set_text("w110 권장");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "270", "344", "110", "23", null, null, this);
            obj.set_taborder("58");
            obj.set_text("w110 권장");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "0", "193", "21", "50", null, null, this);
            obj.set_taborder("59");
            obj.set_text("h50");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "13.33%", "339", null, "73", "86.3%", null, this);
            obj.set_taborder("35");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "16.67%", "395", "212", "35", null, null, this);
            obj.set_taborder("32");
            obj.set_text("CellClass : CellGrd_WF_LabelGray");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "13.52%", "410", null, "2", "84.26%", null, this);
            obj.set_taborder("34");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "310", "339", null, "73", "228", null, this);
            obj.set_taborder("60");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static14", "absolute", "299", "410", null, "2", "229", null, this);
            obj.set_taborder("61");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "209", "377", "347", "2", null, null, this);
            obj.set_taborder("62");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static16", "absolute", "565", "361", "395", "35", null, null, this);
            obj.set_taborder("63");
            obj.set_text("CellClass : CellGrd_WF_ColorBlue / DisplayType : number");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static17", "absolute", "209", "339", null, "39", "329", null, this);
            obj.set_taborder("64");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static18", "absolute", "52.96%", "220", "2", "46", null, null, this);
            obj.set_taborder("65");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static19", "absolute", "257", "218", "30", "2", null, null, this);
            obj.set_taborder("66");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static20", "absolute", "257", "266", "30", "2", null, null, this);
            obj.set_taborder("67");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static21", "absolute", "274", "267", "2", "16", null, null, this);
            obj.set_taborder("68");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static22", "absolute", "534", "267", "2", "16", null, null, this);
            obj.set_taborder("69");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static25", "absolute", "275", "281", "260", "2", null, null, this);
            obj.set_taborder("70");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static26", "absolute", "550", "244", "8", "2", null, null, this);
            obj.set_taborder("71");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static27", "absolute", "565", "151", "245", "35", null, null, this);
            obj.set_taborder("72");
            obj.set_text("CellClass : CellGrd_WF_LabelIndigo");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static28", "absolute", "519", "166", "37", "2", null, null, this);
            obj.set_taborder("73");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static29", "absolute", "-1", "458", null, "50", "0", null, this);
            obj.set_taborder("74");
            obj.set_text("Grid_Detail02");
            obj.style.set_background("#edeee6ff");
            obj.style.set_border("1 solid #c6c6c5ff");
            obj.style.set_align("center middle");
            obj.style.set_font("antialias 15 Tahoma");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid01", "absolute", "10", "601", "520", "251", null, null, this);
            obj.set_taborder("75");
            obj.set_binddataset("ds_grdDetail02");
            obj.set_scrollbars("none");
            obj.set_selecttype("cell");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"110\"/><Column size=\"205\"/><Column size=\"205\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell text=\"GrayLabel\"/><Cell col=\"1\" text=\"WhiteLabel\"/><Cell col=\"2\" text=\"WhiteLabel\"/></Band><Band id=\"body\"><Cell colspan=\"3\" celltype=\"none\" cssclass=\"CellGrd_WF_LabelIndigo\" text=\"bind:Column1\"/><Cell row=\"1\" celltype=\"none\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:Column2\"/><Cell row=\"1\" col=\"1\" displaytype=\"number\" edittype=\"none\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:Column3\"/><Cell row=\"1\" col=\"2\" displaytype=\"number\" edittype=\"none\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:Column4\"/><Cell row=\"2\" celltype=\"none\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:Column5\"/><Cell row=\"2\" col=\"1\" colspan=\"2\" displaytype=\"number\" edittype=\"none\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:Column6\"/><Cell row=\"3\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:Column7\"/><Cell row=\"3\" col=\"1\" colspan=\"2\" displaytype=\"number\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:Column8\"/><Cell row=\"4\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:Column9\"/><Cell row=\"4\" col=\"1\" colspan=\"2\" displaytype=\"number\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:Column10\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static30", "absolute", "25", "522", "510", "60", null, null, this);
            obj.set_taborder("76");
            obj.set_text("※ Detail형 그리드는 Head 높이값이 0으로 사용하지 않는다.\r\n※ 특이 Cell Style에 대해 Cell Class를 사용한다.\r\n※ align은 center정렬이 기본이며 left/right 정렬이 필요 시 해당 Cell의 Properties에 \r\n   align값과 padding값을 직접 입력한다.");
            obj.set_cssclass("sta_GUIDE_RedText");
            obj.set_visible("false");
            obj.style.set_linespace("3");
            obj.style.set_align("left top");
            this.addChild(obj.name, obj);

            obj = new Static("Static31", "absolute", "0", "601", "21", "50", null, null, this);
            obj.set_taborder("77");
            obj.set_text("h50");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static32", "absolute", "565", "757", "415", "35", null, null, this);
            obj.set_taborder("78");
            obj.set_text("CellClass : CellClass : CellGrd_WF_LabelWhite / DisplayType : number");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static33", "absolute", "101.48%", "678", "2", "196", null, null, this);
            obj.set_taborder("79");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static34", "absolute", "519", "676", "30", "2", null, null, this);
            obj.set_taborder("80");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static35", "absolute", "519", "724", "30", "2", null, null, this);
            obj.set_taborder("81");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static38", "absolute", "11", "852", "110", "23", null, null, this);
            obj.set_taborder("84");
            obj.set_text("w110 권장");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static40", "absolute", "0", "651", "21", "50", null, null, this);
            obj.set_taborder("86");
            obj.set_text("h50");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static41", "absolute", "72", "847", null, "53", "466", null, this);
            obj.set_taborder("87");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static42", "absolute", "90", "883", null, "35", "238", null, this);
            obj.set_taborder("88");
            obj.set_text("CellClass : CellGrd_WF_LabelGray");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static43", "absolute", "73", "858", null, "2", "455", null, this);
            obj.set_taborder("89");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static49", "absolute", "306", "678", "2", "196", null, null, this);
            obj.set_taborder("95");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static51", "absolute", "73", "900", "10", "2", null, null, this);
            obj.set_taborder("97");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static56", "absolute", "565", "609", "425", "35", null, null, this);
            obj.set_taborder("102");
            obj.set_text("CellClass : CellGrd_WF_LabelIndigo");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static57", "absolute", "519", "624", "37", "2", null, null, this);
            obj.set_taborder("103");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static36", "absolute", "519", "772", "40", "2", null, null, this);
            obj.set_taborder("104");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static37", "absolute", "519", "820", "30", "2", null, null, this);
            obj.set_taborder("105");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static39", "absolute", "306", "872", "244", "2", null, null, this);
            obj.set_taborder("106");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 942, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("Grid_Detail");

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

        this.loadIncludeScript("COMP_GUIDE_06_3.xfdl", true);

       
    };
}
)();
