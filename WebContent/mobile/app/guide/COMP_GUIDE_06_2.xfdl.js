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
                this.set_titletext("Grid_Summary,Image");
                this._setFormPosition(0,0,540,874);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_grdSummary", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"Column0\" type=\"STRING\" size=\"256\"/><Column id=\"Column1\" type=\"STRING\" size=\"256\"/><Column id=\"Column2\" type=\"STRING\" size=\"256\"/><Column id=\"Column3\" type=\"STRING\" size=\"256\"/><Column id=\"Column4\" type=\"STRING\" size=\"256\"/><Column id=\"Column5\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column0\">공급가</Col><Col id=\"Column1\">부가세</Col><Col id=\"Column2\">총발주금액</Col><Col id=\"Column3\">100000</Col><Col id=\"Column4\">5000</Col><Col id=\"Column5\">105000</Col></Row></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_grdImage", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"Column0\" type=\"STRING\" size=\"256\"/><Column id=\"Column1\" type=\"STRING\" size=\"256\"/><Column id=\"Column2\" type=\"STRING\" size=\"256\"/><Column id=\"Column3\" type=\"STRING\" size=\"256\"/><Column id=\"Column4\" type=\"STRING\" size=\"256\"/><Column id=\"Column5\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column0\">수량</Col><Col id=\"Column1\">단위</Col><Col id=\"Column2\">10070000</Col><Col id=\"Column3\">상추</Col><Col id=\"Column4\">2.4Kg 수입</Col><Col id=\"Column5\">4,500원</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("Static31", "absolute", "10", "163", "520", "132", null, null, this);
            obj.set_taborder("64");
            obj.set_cssclass("sta_WF_GrdSumTypeBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "-1", "0", null, "50", "0", null, this);
            obj.set_taborder("0");
            obj.set_text("Grid_Summary");
            obj.style.set_background("#edeee6ff");
            obj.style.set_border("1 solid #c6c6c5ff");
            obj.style.set_align("center middle");
            obj.style.set_font("antialias 15 Tahoma");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid00", "absolute", "10", "173", "520", "122", null, null, this);
            obj.set_taborder("15");
            obj.set_binddataset("ds_grdSummary");
            obj.set_scrollbars("none");
            obj.set_selecttype("cell");
            obj.set_cssclass("grd_WF_SumType");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"140\"/><Column size=\"380\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"10\"/><Row size=\"34\"/><Row size=\"34\"/><Row size=\"34\"/><Row size=\"10\"/></Rows><Band id=\"head\"><Cell text=\"GrayLabel\"/><Cell col=\"1\" text=\"WhiteLabel\"/></Band><Band id=\"body\"><Cell/><Cell col=\"1\"/><Cell row=\"1\" celltype=\"none\" text=\"bind:Column0\"/><Cell row=\"1\" col=\"1\" displaytype=\"number\" edittype=\"none\" style=\"align:right middle;\" text=\"bind:Column3\"/><Cell row=\"2\" celltype=\"none\" text=\"bind:Column1\"/><Cell row=\"2\" col=\"1\" displaytype=\"number\" edittype=\"none\" style=\"align:right middle;\" text=\"bind:Column4\"/><Cell row=\"3\" celltype=\"none\" text=\"bind:Column2\"/><Cell row=\"3\" col=\"1\" displaytype=\"number\" edittype=\"none\" cssclass=\"CellGrd_WF_ColorRed\" text=\"bind:Column5\"/><Cell row=\"4\"/><Cell row=\"4\" col=\"1\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static24", "absolute", "25", "64", "510", "70", null, null, this);
            obj.set_taborder("16");
            obj.set_text("※ Summary형 그리드는 Head 높이값이 0으로 사용하지 않는다.\r\n※ 특이 Cell Style에 대해 Cell Class를 사용한다.\r\n※ align은 center정렬이 기본이며 left/right 정렬이 필요 시 해당 Cell의 Properties에 \r\n   align값과 padding값을 직접 입력한다.");
            obj.set_cssclass("sta_GUIDE_RedText");
            obj.set_visible("false");
            obj.style.set_linespace("3");
            obj.style.set_align("left top");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "0", "183", "21", "34", null, null, this);
            obj.set_taborder("27");
            obj.set_text("h34");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "35.19%", "305", null, "35", "25.56%", null, this);
            obj.set_taborder("32");
            obj.set_text("Class : grd_WF_SumType");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "32.04%", "320", null, "2", "65.74%", null, this);
            obj.set_taborder("34");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "31.85%", "269", null, "53", "67.78%", null, this);
            obj.set_taborder("35");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "565", "245", null, "35", "-420", null, this);
            obj.set_taborder("36");
            obj.set_text("CellClass : CellGrd_WF_ColorRed / DisplayType : number");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "101.48%", "200", "2", "46", null, null, this);
            obj.set_taborder("39");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("true");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "96.11%", "198", "30", "2", null, null, this);
            obj.set_taborder("40");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static10", "absolute", "96.11%", "246", "30", "2", null, null, this);
            obj.set_taborder("41");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static11", "absolute", "565", "205", null, "35", "-390", null, this);
            obj.set_taborder("42");
            obj.set_text("Align : right middle / DisplayType : number");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static12", "absolute", "519", "264", "30", "2", null, null, this);
            obj.set_taborder("43");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "-1", "378", null, "50", "0", null, this);
            obj.set_taborder("44");
            obj.set_text("Grid_Image");
            obj.style.set_background("#edeee6ff");
            obj.style.set_border("1 solid #c6c6c5ff");
            obj.style.set_align("center middle");
            obj.style.set_font("antialias 15 Tahoma");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid01", "absolute", "10", "541", "520", "151", null, null, this);
            obj.set_taborder("45");
            obj.set_binddataset("ds_grdImage");
            obj.set_scrollbars("none");
            obj.set_selecttype("cell");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"140\"/><Column size=\"130\"/><Column size=\"250\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/></Rows><Band id=\"head\"><Cell/><Cell col=\"1\" text=\"GrayLabel\"/><Cell col=\"2\" text=\"WhiteLabel\"/></Band><Band id=\"body\"><Cell rowspan=\"3\" style=\"background:URL('theme://Image/img_WF_NoImage.png') center middle;background2:URL('theme://Image/img_WF_NoImage.png') center middle;selectbackground:URL('theme://Image/img_WF_NoImage.png') center middle;\"/><Cell col=\"1\" celltype=\"none\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:Column0\"/><Cell col=\"2\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:Column3\"/><Cell row=\"1\" col=\"1\" celltype=\"none\" cssclass=\"CellGrd_WF_LabelGray\" text=\"bind:Column1\"/><Cell row=\"1\" col=\"2\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:Column4\"/><Cell row=\"2\" col=\"1\" celltype=\"none\" style=\"align:left middle;\" cssclass=\"CellGrd_WF_LabelWhite\" text=\"bind:Column2\"/><Cell row=\"2\" col=\"2\" cssclass=\"CellGrd_WF_ColorRed\" text=\"bind:Column5\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "25", "442", "510", "70", null, null, this);
            obj.set_taborder("46");
            obj.set_text("※ Image형 그리드는 Head 높이값이 0으로 사용하지 않는다.\r\n※ 특이 Cell Style에 대해 Cell Class를 사용한다.\r\n※ align은 center정렬이 기본이며 left/right 정렬이 필요 시 해당 Cell의 Properties에 \r\n   align값과 padding값을 직접 입력한다.");
            obj.set_cssclass("sta_GUIDE_RedText");
            obj.set_visible("false");
            obj.style.set_linespace("3");
            obj.style.set_align("left top");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "280", "541", "21", "50", null, null, this);
            obj.set_taborder("47");
            obj.set_text("h50");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static14", "absolute", "150", "733", null, "35", "178", null, this);
            obj.set_taborder("48");
            obj.set_text("CellClass : CellGrd_WF_LabelGray");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "133", "748", null, "2", "395", null, this);
            obj.set_taborder("49");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static16", "absolute", "132", "567", null, "183", "406", null, this);
            obj.set_taborder("50");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static17", "absolute", "565", "643", "234", "35", null, null, this);
            obj.set_taborder("51");
            obj.set_text("CellClass : CellGrd_WF_ColorRed");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static18", "absolute", "101.48%", "568", "2", "46", null, null, this);
            obj.set_taborder("52");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static19", "absolute", "519", "566", "30", "2", null, null, this);
            obj.set_taborder("53");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static20", "absolute", "519", "614", "30", "2", null, null, this);
            obj.set_taborder("54");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static21", "absolute", "565", "573", "255", "35", null, null, this);
            obj.set_taborder("55");
            obj.set_text("CellClass : CellGrd_WF_LabelWhite");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static22", "absolute", "519", "662", "30", "2", null, null, this);
            obj.set_taborder("56");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static23", "absolute", "11", "150", "140", "23", null, null, this);
            obj.set_taborder("57");
            obj.set_text("w140 권장");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            obj.style.set_font("9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static25", "absolute", "151", "518", "130", "23", null, null, this);
            obj.set_taborder("58");
            obj.set_text("w130 권장");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static26", "absolute", "98", "766", "452", "34", null, null, this);
            obj.set_taborder("59");
            obj.set_text("property 속성중 background / background2/ selectbackground \r\n세 속성에 아래와 같은 코드를 입력한다 ");
            obj.set_cssclass("sta_GUIDE_BlackBoldText");
            obj.set_visible("false");
            obj.style.set_align("left top");
            this.addChild(obj.name, obj);

            obj = new Static("Static27", "absolute", "81", "770", "12", "2", null, null, this);
            obj.set_taborder("60");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static28", "absolute", "80", "677", "2", "93", null, null, this);
            obj.set_taborder("61");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static29", "absolute", "98", "804", "452", "28", null, null, this);
            obj.set_taborder("62");
            obj.set_text("URL('theme://Image/이미지네임.png') center middle");
            obj.set_cssclass("sta_GUIDE_BlackBoldText");
            obj.set_visible("false");
            obj.style.set_color("#ff4900ff");
            obj.style.set_align("left top");
            this.addChild(obj.name, obj);

            obj = new Static("Static37", "absolute", "133", "617", null, "2", "395", null, this);
            obj.set_taborder("70");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static38", "absolute", "133", "565", null, "2", "395", null, this);
            obj.set_taborder("71");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static39", "absolute", "218", "693", "349", "35", null, null, this);
            obj.set_taborder("72");
            obj.set_text("CellClass : CellGrd_WF_LabelWhite / Align : left middle");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static40", "absolute", "201", "708", null, "2", "327", null, this);
            obj.set_taborder("73");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static41", "absolute", "200", "677", null, "33", "338", null, this);
            obj.set_taborder("74");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static35", "absolute", "0", "173", "21", "10", null, null, this);
            obj.set_taborder("75");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static36", "absolute", "0", "217", "21", "34", null, null, this);
            obj.set_taborder("76");
            obj.set_text("h34");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static42", "absolute", "0", "251", "21", "34", null, null, this);
            obj.set_taborder("77");
            obj.set_text("h34");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static43", "absolute", "0", "285", "21", "10", null, null, this);
            obj.set_taborder("78");
            obj.set_text("h10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 874, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("Grid_Summary,Image");

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

        this.loadIncludeScript("COMP_GUIDE_06_2.xfdl", true);

       
    };
}
)();
