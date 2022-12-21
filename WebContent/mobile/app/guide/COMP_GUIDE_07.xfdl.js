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
                this.set_titletext("Label,DataPattern,Search");
                this._setFormPosition(0,0,540,1128);
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
            obj._setContents("<ColumnInfo><Column id=\"Column0\" type=\"STRING\" size=\"256\"/><Column id=\"Column1\" type=\"STRING\" size=\"256\"/><Column id=\"Column2\" type=\"STRING\" size=\"256\"/><Column id=\"Column3\" type=\"STRING\" size=\"256\"/><Column id=\"Column4\" type=\"STRING\" size=\"256\"/><Column id=\"Column5\" type=\"STRING\" size=\"256\"/><Column id=\"Column6\" type=\"STRING\" size=\"256\"/><Column id=\"Column7\" type=\"STRING\" size=\"256\"/><Column id=\"Column8\" type=\"STRING\" size=\"256\"/><Column id=\"Column9\" type=\"STRING\" size=\"256\"/><Column id=\"Column10\" type=\"STRING\" size=\"256\"/><Column id=\"Column11\" type=\"STRING\" size=\"256\"/><Column id=\"Column12\" type=\"STRING\" size=\"256\"/><Column id=\"Column13\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column0\">품목</Col><Col id=\"Column1\">소고기 한우 ++A 특수부위</Col><Col id=\"Column2\">규격</Col><Col id=\"Column3\">3523 X 1213</Col><Col id=\"Column4\">수량</Col><Col id=\"Column5\">100</Col><Col id=\"Column6\">코드</Col><Col id=\"Column7\">100700</Col><Col id=\"Column8\">단위</Col><Col id=\"Column9\">200Kg</Col><Col id=\"Column10\">단가</Col><Col id=\"Column11\">12000</Col><Col id=\"Column12\">금액</Col><Col id=\"Column13\">71000</Col></Row></Rows>");
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
            obj = new Static("Static00", "absolute", "0", "0", "540", "50", null, null, this);
            obj.set_taborder("0");
            obj.set_text("Label");
            obj.style.set_background("#edeee6ff");
            obj.style.set_border("1 solid #c6c6c5ff");
            obj.style.set_align("center middle");
            obj.style.set_font("antialias 15 Tahoma");
            this.addChild(obj.name, obj);

            obj = new Static("Static27", "absolute", "345", "91", "195", "35", null, null, this);
            obj.set_taborder("4");
            obj.set_text("Class : sta_WF_Label01");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static28", "absolute", "299", "106", "37", "2", null, null, this);
            obj.set_taborder("5");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "43", "78", "265", "57", null, null, this);
            obj.set_taborder("6");
            obj.set_text("Title");
            obj.set_cssclass("sta_WF_Label01");
            this.addChild(obj.name, obj);

            obj = new Static("Static02", "absolute", "43", "146", "265", "59", null, null, this);
            obj.set_taborder("7");
            obj.set_text("Label Title");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static03", "absolute", "43", "214", "265", "59", null, null, this);
            obj.set_taborder("8");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static05", "absolute", "8", "78", "21", "57", null, null, this);
            obj.set_taborder("9");
            obj.set_text("h57");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static07", "absolute", "8", "146", "21", "59", null, null, this);
            obj.set_taborder("10");
            obj.set_text("h59");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static08", "absolute", "8", "214", "21", "59", null, null, this);
            obj.set_taborder("11");
            obj.set_text("h59");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static09", "absolute", "345", "157", "195", "35", null, null, this);
            obj.set_taborder("12");
            obj.set_text("Class : sta_WF_Label02");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static10", "absolute", "299", "172", "37", "2", null, null, this);
            obj.set_taborder("13");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static11", "absolute", "345", "225", "195", "35", null, null, this);
            obj.set_taborder("14");
            obj.set_text("Class : sta_WFSA_LabelBg");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static12", "absolute", "299", "240", "37", "2", null, null, this);
            obj.set_taborder("15");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "-1", "655", null, "50", "0", null, this);
            obj.set_taborder("16");
            obj.set_text("Search");
            obj.style.set_background("#edeee6ff");
            obj.style.set_border("1 solid #c6c6c5ff");
            obj.style.set_align("center middle");
            obj.style.set_font("antialias 15 Tahoma");
            this.addChild(obj.name, obj);

            obj = new Static("Static14", "absolute", "0", "742", null, "59", "0", null, this);
            obj.set_taborder("17");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static15", "absolute", "0", "800", null, "59", "0", null, this);
            obj.set_taborder("18");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static16", "absolute", "549", "742", "21", "59", null, null, this);
            obj.set_taborder("19");
            obj.set_text("h59");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static17", "absolute", "549", "800", "21", "59", null, null, this);
            obj.set_taborder("20");
            obj.set_text("h59");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static18", "absolute", "613", "785", "195", "35", null, null, this);
            obj.set_taborder("21");
            obj.set_text("1px 겹침");
            obj.set_cssclass("sta_GUIDE_RedText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static19", "absolute", "567", "800", "37", "2", null, null, this);
            obj.set_taborder("22");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Combo("Combo00", "absolute", "10", "748", "298", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("23");
            obj.set_text("창고명 선택");

            obj = new Static("Static20", "absolute", "0", "758", "10", "29", null, null, this);
            obj.set_taborder("24");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static21", "absolute", "19", "742", "50", "6", null, null, this);
            obj.set_taborder("25");
            obj.set_text("h06");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static22", "absolute", "19", "795", "50", "6", null, null, this);
            obj.set_taborder("26");
            obj.set_text("h06");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static23", "absolute", "308", "758", "5", "29", null, null, this);
            obj.set_taborder("27");
            obj.set_text("05");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static25", "absolute", "0", "800", "105", "59", null, null, this);
            obj.set_taborder("28");
            obj.set_text("입고일");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static26", "absolute", "93", "814", "20", "29", null, null, this);
            obj.set_taborder("29");
            obj.set_text("글자사이간격w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Calendar("Calendar00", "absolute", "113", "806", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("30");
            obj.set_value("null");
            obj.set_dateformat("yyyy-MM-dd ddd");
            obj.set_displaynulltext("2015-12-29");

            obj = new Static("Static04", "absolute", "0", "316", "540", "50", null, null, this);
            obj.set_taborder("31");
            obj.set_text("Data Pattern");
            obj.style.set_background("#edeee6ff");
            obj.style.set_border("1 solid #c6c6c5ff");
            obj.style.set_align("center middle");
            obj.style.set_font("antialias 15 Tahoma");
            this.addChild(obj.name, obj);

            obj = new Button("Button14", "absolute", null, "806", "100", "47", "10", null, this);
            obj.set_taborder("32");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Static("Static06", "absolute", "530", "813", "10", "29", null, null, this);
            obj.set_taborder("33");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static24", "absolute", "457", "800", "50", "6", null, null, this);
            obj.set_taborder("34");
            obj.set_text("h06");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static29", "absolute", "457", "853", "50", "6", null, null, this);
            obj.set_taborder("35");
            obj.set_text("h06");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit00", "absolute", "313", "748", null, "47", "10", null, this);
            obj.set_taborder("36");
            obj.set_value("품목명 선택");
            this.addChild(obj.name, obj);

            obj = new Button("Button34", "absolute", null, "748", "47", "47", "10", null, this);
            obj.set_taborder("37");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit01", "absolute", "160", "430", "212", "47", null, null, this);
            obj.set_taborder("38");
            this.addChild(obj.name, obj);

            obj = new Button("Button00", "absolute", "325", "430", "47", "47", null, null, this);
            obj.set_taborder("39");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);

            obj = new Calendar("Calendar01", "absolute", "50", "577", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("46");
            obj.set_displaynulltext("2015-12-29");

            obj = new Calendar("Calendar02", "absolute", "265", "577", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("47");
            obj.set_displaynulltext("2015-12-29");

            obj = new Static("Static34", "absolute", "250", "577", "15", "47", null, null, this);
            obj.set_taborder("48");
            obj.set_text("~");
            this.addChild(obj.name, obj);

            obj = new Static("Static35", "absolute", "245", "590", "5", "17", null, null, this);
            obj.set_taborder("49");
            obj.set_text("컴포넌트 사이 간격 h08");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static36", "absolute", "245", "614", "20", "17", null, null, this);
            obj.set_taborder("50");
            obj.set_text("w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static30", "absolute", "0", "363", "540", "47", null, null, this);
            obj.set_taborder("53");
            obj.set_text("Edit + SearchBtn");
            obj.style.set_background("#ffffffff");
            obj.style.set_border("1 solid #c6c6c5ff");
            obj.style.set_padding("0 0 0 10");
            obj.style.set_align("center middle");
            obj.style.set_font("antialias 15 Tahoma");
            this.addChild(obj.name, obj);

            obj = new Static("Static33", "absolute", "0", "503", "541", "47", null, null, this);
            obj.set_taborder("55");
            obj.set_text("Calendar");
            obj.style.set_background("#ffffffff");
            obj.style.set_border("1 solid #c6c6c5ff");
            obj.style.set_padding("0 0 0 10");
            obj.style.set_align("center middle");
            obj.style.set_font("antialias 15 Tahoma");
            this.addChild(obj.name, obj);

            obj = new Static("Static32", "absolute", "0", "922", null, "59", "0", null, this);
            obj.set_taborder("57");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static37", "absolute", "0", "980", null, "59", "0", null, this);
            obj.set_taborder("58");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static38", "absolute", "0", "980", "135", "59", null, null, this);
            obj.set_taborder("59");
            obj.set_text("연회장명");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit02", "absolute", "139", "928", null, "47", "10", null, this);
            obj.set_taborder("60");
            obj.set_value("연세플라자점");
            this.addChild(obj.name, obj);

            obj = new Static("Static39", "absolute", "0", "1038", null, "59", "0", null, this);
            obj.set_taborder("61");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static40", "absolute", "0", "1038", "135", "59", null, null, this);
            obj.set_taborder("62");
            obj.set_text("예약일자");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static41", "absolute", "119", "1051", "20", "29", null, null, this);
            obj.set_taborder("63");
            obj.set_text("글자사이간격w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Calendar("Calendar03", "absolute", "139", "1044", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("64");
            obj.set_displaynulltext("2015-12-29");

            obj = new Button("Button01", "absolute", null, "1044", "100", "47", "10", null, this);
            obj.set_taborder("65");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Static("Static42", "absolute", "0", "922", "135", "59", null, null, this);
            obj.set_taborder("66");
            obj.set_text("사업장");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Static("Static43", "absolute", "119", "993", "20", "29", null, null, this);
            obj.set_taborder("67");
            obj.set_text("글자사이간격w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit03", "absolute", "139", "986", null, "47", "10", null, this);
            obj.set_taborder("68");
            obj.set_value("연회장을 입력");
            this.addChild(obj.name, obj);

            obj = new Button("Button02", "absolute", null, "986", "47", "47", "10", null, this);
            obj.set_taborder("69");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);

            obj = new Static("Static31", "absolute", "153", "875", "451", "35", null, null, this);
            obj.set_taborder("70");
            obj.set_text("라벨 글자수가 행마다 다를때 긴글자를 기준으로 컴포넌드를 정렬한다.");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static44", "absolute", "549", "922", "21", "59", null, null, this);
            obj.set_taborder("71");
            obj.set_text("h59");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static45", "absolute", "549", "980", "21", "59", null, null, this);
            obj.set_taborder("72");
            obj.set_text("h59");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static46", "absolute", "567", "980", "37", "2", null, null, this);
            obj.set_taborder("73");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static47", "absolute", "549", "1038", "21", "59", null, null, this);
            obj.set_taborder("74");
            obj.set_text("h59");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static48", "absolute", "567", "1038", "37", "2", null, null, this);
            obj.set_taborder("75");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static49", "absolute", "137", "891", "2", "169", null, null, this);
            obj.set_taborder("76");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static50", "absolute", "138", "890", "12", "2", null, null, this);
            obj.set_taborder("77");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static51", "absolute", "613", "963", "195", "35", null, null, this);
            obj.set_taborder("78");
            obj.set_text("1px 겹침");
            obj.set_cssclass("sta_GUIDE_RedText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static52", "absolute", "613", "1021", "195", "35", null, null, this);
            obj.set_taborder("79");
            obj.set_text("1px 겹침");
            obj.set_cssclass("sta_GUIDE_RedText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 1128, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("Label,DataPattern,Search");

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

        this.loadIncludeScript("COMP_GUIDE_07.xfdl", true);

       
    };
}
)();
