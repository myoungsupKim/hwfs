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
                this.set_name("AdditionOrder");
                this.set_titletext("추가발주");
                this._setFormPosition(0,0,540,760);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_list", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"Column2\" type=\"STRING\" size=\"256\"/><Column id=\"Column4\" type=\"STRING\" size=\"256\"/><Column id=\"Column5\" type=\"STRING\" size=\"256\"/><Column id=\"Column6\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_ColorChipGuide", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"Column5\" type=\"STRING\" size=\"256\"/><Column id=\"Column6\" type=\"STRING\" size=\"256\"/><Column id=\"Column7\" type=\"STRING\" size=\"256\"/><Column id=\"Column8\" type=\"STRING\" size=\"256\"/><Column id=\"Column9\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column5\">grd_WF_ColorchipPlanning.png</Col><Col id=\"Column6\">grd_WF_ColorchipNew.png</Col><Col id=\"Column7\">grd_WF_ColorchipSpecial.png</Col><Col id=\"Column8\">grd_WF_ColorchipRecommend.png</Col><Col id=\"Column9\">grd_WF_ColorchipLimit.png</Col></Row></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_storageCd", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"256\"/><Column id=\"cdNm\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"cd\">01</Col><Col id=\"cdNm\">창고1</Col></Row><Row><Col id=\"cd\">02</Col><Col id=\"cdNm\">창고2</Col></Row><Row><Col id=\"cd\">03</Col><Col id=\"cdNm\">창고3</Col></Row><Row><Col id=\"cd\">04</Col><Col id=\"cdNm\">창고4</Col></Row></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_listServer", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"Column2\" type=\"STRING\" size=\"256\"/><Column id=\"Column4\" type=\"STRING\" size=\"256\"/><Column id=\"Column5\" type=\"STRING\" size=\"256\"/><Column id=\"Column6\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row><Row><Col id=\"Column2\">통감자(20Kg/EA)</Col><Col id=\"Column4\">10070000</Col><Col id=\"Column5\">3,300원</Col><Col id=\"Column6\">1000</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Div("div_additionOrderBookMark", "absolute", "0", "57", "540", "703", null, null, this);
            obj.set_taborder("90");
            obj.style.set_background("white");
            obj.set_text("즐겨찾기");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "608", "62", "540", "57", null, null, this);
            obj.set_taborder("3");
            obj.set_text("한촌강남점");
            obj.set_cssclass("sta_WF_Label01");
            this.addChild(obj.name, obj);

            obj = new Button("Button36", "absolute", "608", null, null, "35", "-608", "0", this);
            obj.set_taborder("33");
            obj.set_text("더보기");
            obj.set_cssclass("btn_WF_More");
            this.addChild(obj.name, obj);

            obj = new Button("btn_additionOrder", "absolute", "0", "0", "270", "63", null, null, this);
            obj.set_taborder("34");
            obj.set_text("추가발주");
            obj.set_cssclass("btn_WF_TabTFOn");
            this.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "608", "120", null, "59", "-608", null, this);
            obj.set_taborder("36");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Static("Static22", "absolute", "608", "178", null, "59", "-608", null, this);
            obj.set_taborder("37");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Button("btn_search", "absolute", null, "184", "100", "47", "-598", null, this);
            obj.set_taborder("38");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.addChild(obj.name, obj);

            obj = new Combo("cbo_Storage", "absolute", "618", "126", "298", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("39");
            obj.set_text("창고명 선택");
            obj.set_displaynulltext("창고명 선택");
            obj.set_innerdataset("@ds_storageCd");
            obj.set_codecolumn("cd");
            obj.set_datacolumn("cdNm");
            obj.set_index("-1");

            obj = new Calendar("cal_dtTo", "absolute", "721", "184", "195", "47", null, null, this);
            this.addChild(obj.name, obj);
            obj.set_taborder("40");
            obj.set_displaynulltext("2015-12-29");

            obj = new Static("Static24", "absolute", "608", "178", "110", "59", null, null, this);
            obj.set_taborder("46");
            obj.set_text("입고일");
            obj.set_cssclass("sta_WF_Label02");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_productKind", "absolute", "921", "126", null, "47", "-598", null, this);
            obj.set_taborder("50");
            obj.set_value("품목명 검색");
            obj.set_displaynulltext("품목명 검색");
            this.addChild(obj.name, obj);

            obj = new Button("Button02", "absolute", null, "126", "47", "47", "-598", null, this);
            obj.set_taborder("49");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid00", "absolute", "608", "236", null, "417", "-608", null, this);
            obj.set_cssclass("grd_WF_Default2");
            obj.set_taborder("57");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("none");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"56\"/><Column size=\"229\"/><Column size=\"120\" band=\"right\"/><Column size=\"72\" band=\"right\"/><Column size=\"53\" band=\"right\"/><Column size=\"10\" band=\"right\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"17\"/><Row size=\"10\"/><Row size=\"25\"/><Row size=\"25\"/><Row size=\"10\"/><Row size=\"17\"/></Rows><Band id=\"head\"><Cell text=\"Column1\"/><Cell col=\"1\" text=\"Column0\"/><Cell col=\"2\" text=\"Column2\"/><Cell col=\"3\" text=\"Column3\"/><Cell col=\"4\" text=\"Column7\"/><Cell col=\"5\"/></Band><Band id=\"body\"><Cell style=\"line:0 none;\"/><Cell col=\"1\" style=\"line:0 none;\"/><Cell col=\"2\" style=\"line:0 none;\"/><Cell col=\"3\" style=\"line:0 none;\"/><Cell col=\"4\" style=\"line:0 none;\" text=\"bind:Column7\"/><Cell col=\"5\" style=\"line:0 none;\"/><Cell row=\"1\" rowspan=\"2\" displaytype=\"image\" style=\"line:0 none #808080ff ;backgroundimage:URL('HWImage::grd_WF_ColorchipPlanning.png');\"/><Cell row=\"1\" col=\"1\" rowspan=\"2\" style=\"align:left middle;padding:0 10 0 10;line:0 none;\" text=\"bind:Column2\"/><Cell row=\"1\" col=\"2\" style=\"line:0 none;\"/><Cell row=\"1\" col=\"3\" style=\"line:0 none;\"/><Cell row=\"1\" col=\"4\" style=\"line:0 none;\"/><Cell row=\"1\" col=\"5\" style=\"line:0 none;\"/><Cell row=\"2\" col=\"2\" style=\"line:0 none;\"/><Cell row=\"2\" col=\"3\" rowspan=\"2\" displaytype=\"normal\" edittype=\"normal\" style=\"align:right middle;line:0 none;\" text=\"bind:Column6\" editdisplay=\"display\"/><Cell row=\"2\" col=\"4\" rowspan=\"2\" displaytype=\"image\" edittype=\"button\" style=\"line:0 none #808080ff ;backgroundimage:URL('HWImage::CellGrd_WF_Cartbtn.png');\"/><Cell row=\"2\" col=\"5\" style=\"line:0 none;\"/><Cell row=\"3\" rowspan=\"2\" displaytype=\"image\" style=\"line:0 none #808080ff ;backgroundimage:URL('HWImage::grd_WF_ColorchipNew.png');\"/><Cell row=\"3\" col=\"1\" rowspan=\"2\" style=\"align:left middle;padding:0 10 0 10;line:0 none;\" text=\"bind:Column4\"/><Cell row=\"3\" col=\"2\" rowspan=\"2\" style=\"line:0 none;\" text=\"bind:Column5\"/><Cell row=\"3\" col=\"5\" style=\"line:0 none;\"/><Cell row=\"4\" col=\"3\" style=\"line:0 none;\"/><Cell row=\"4\" col=\"4\" style=\"line:0 none;\"/><Cell row=\"4\" col=\"5\" style=\"line:0 none;\"/><Cell row=\"5\" style=\"line: ;\"/><Cell row=\"5\" col=\"1\" style=\"line: ;\"/><Cell row=\"5\" col=\"2\" style=\"line: ;\"/><Cell row=\"5\" col=\"3\" style=\"line: ;\"/><Cell row=\"5\" col=\"4\" style=\"line: ;\"/><Cell row=\"5\" col=\"5\" style=\"line: ;\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static30", "absolute", "1874", "58", "276", "35", null, null, this);
            obj.set_taborder("84");
            obj.set_text("ImageName : CellGrd_WF_Xbtn.png");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Button("btn_additionOrderBookMark", "absolute", "270", "0", "270", "63", null, null, this);
            obj.set_taborder("88");
            obj.set_text("즐겨찾기");
            obj.set_cssclass("btn_WF_TabTFOff");
            this.addChild(obj.name, obj);

            obj = new Div("div_additionOrder", "absolute", "0", "62", null, null, "0", "0", this);
            obj.set_taborder("89");
            obj.style.set_background("white");
            this.addChild(obj.name, obj);
            obj = new Static("Static01", "absolute", "0", "0", "538", "57", null, null, this.div_additionOrder);
            obj.set_taborder("0");
            obj.set_text("한촌강남점");
            obj.set_cssclass("sta_WF_Label01");
            this.div_additionOrder.addChild(obj.name, obj);
            obj = new Static("Static04", "absolute", "0", "58", null, "59", "1", null, this.div_additionOrder);
            obj.set_taborder("2");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.div_additionOrder.addChild(obj.name, obj);
            obj = new Static("Static22", "absolute", "0", "116", null, "59", "1", null, this.div_additionOrder);
            obj.set_taborder("3");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.div_additionOrder.addChild(obj.name, obj);
            obj = new Button("btn_search", "absolute", null, "122", "100", "47", "11", null, this.div_additionOrder);
            obj.set_taborder("4");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.div_additionOrder.addChild(obj.name, obj);
            obj = new Combo("cbo_Storage", "absolute", "10", "64", "298", "47", null, null, this.div_additionOrder);
            this.div_additionOrder.addChild(obj.name, obj);
            obj.set_taborder("5");
            obj.set_displaynulltext("창고명 선택");
            obj.set_innerdataset("@ds_storageCd");
            obj.set_codecolumn("cd");
            obj.set_datacolumn("cdNm");
            obj = new Calendar("cal_dtTo", "absolute", "113", "122", "195", "47", null, null, this.div_additionOrder);
            this.div_additionOrder.addChild(obj.name, obj);
            obj.set_taborder("6");
            obj.set_displaynulltext("2015-12-29");
            obj = new Static("Static24", "absolute", "0", "116", "110", "59", null, null, this.div_additionOrder);
            obj.set_taborder("7");
            obj.set_text("입고일");
            obj.set_cssclass("sta_WF_Label02");
            this.div_additionOrder.addChild(obj.name, obj);
            obj = new Edit("edt_productKind", "absolute", "313", "64", null, "47", "11", null, this.div_additionOrder);
            obj.set_taborder("8");
            obj.set_value("품목명 검색");
            obj.set_displaynulltext("품목명 검색");
            this.div_additionOrder.addChild(obj.name, obj);
            obj = new Button("Button02", "absolute", null, "64", "47", "47", "11", null, this.div_additionOrder);
            obj.set_taborder("9");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.div_additionOrder.addChild(obj.name, obj);
            obj = new Grid("Grid00", "absolute", "0", "174", null, "476", "1", null, this.div_additionOrder);
            obj.set_cssclass("grd_WF_Default2");
            obj.set_taborder("10");
            obj.set_binddataset("ds_list");
            obj.set_scrollbars("autovert");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"56\"/><Column size=\"229\"/><Column size=\"120\" band=\"right\"/><Column size=\"72\" band=\"right\"/><Column size=\"53\" band=\"right\"/><Column size=\"10\" band=\"right\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"17\"/><Row size=\"10\"/><Row size=\"25\"/><Row size=\"25\"/><Row size=\"10\"/><Row size=\"17\"/></Rows><Band id=\"head\"><Cell text=\"Column1\"/><Cell col=\"1\" text=\"Column0\"/><Cell col=\"2\" text=\"Column2\"/><Cell col=\"3\" text=\"Column3\"/><Cell col=\"4\" text=\"Column7\"/><Cell col=\"5\"/></Band><Band id=\"body\"><Cell style=\"line:0 none;\"/><Cell col=\"1\" style=\"line:0 none;\"/><Cell col=\"2\" style=\"line:0 none;\"/><Cell col=\"3\" style=\"line:0 none;\"/><Cell col=\"4\" style=\"line:0 none;\" text=\"bind:Column7\"/><Cell col=\"5\" style=\"line:0 none;\"/><Cell row=\"1\" rowspan=\"2\" displaytype=\"image\" style=\"line:0 none #808080ff ;backgroundimage:URL('HWImage::grd_WF_ColorchipPlanning.png');\"/><Cell row=\"1\" col=\"1\" rowspan=\"2\" style=\"align:left middle;padding:0 10 0 10;line:0 none;\" text=\"bind:Column2\"/><Cell row=\"1\" col=\"2\" style=\"line:0 none;\"/><Cell row=\"1\" col=\"3\" style=\"line:0 none;\"/><Cell row=\"1\" col=\"4\" style=\"line:0 none;\"/><Cell row=\"1\" col=\"5\" style=\"line:0 none;\"/><Cell row=\"2\" col=\"2\" style=\"line:0 none;\"/><Cell row=\"2\" col=\"3\" rowspan=\"2\" displaytype=\"normal\" edittype=\"normal\" style=\"align:right middle;line:0 none;\" text=\"bind:Column6\" editdisplay=\"display\"/><Cell row=\"2\" col=\"4\" rowspan=\"2\" displaytype=\"image\" edittype=\"button\" style=\"line:0 none #808080ff ;backgroundimage:URL('HWImage::CellGrd_WF_Cartbtn.png');\"/><Cell row=\"2\" col=\"5\" style=\"line:0 none;\"/><Cell row=\"3\" rowspan=\"2\" displaytype=\"image\" style=\"line:0 none #808080ff ;backgroundimage:URL('HWImage::grd_WF_ColorchipNew.png');\"/><Cell row=\"3\" col=\"1\" rowspan=\"2\" style=\"align:left middle;padding:0 10 0 10;line:0 none;\" text=\"bind:Column4\"/><Cell row=\"3\" col=\"2\" rowspan=\"2\" style=\"line:0 none;\" text=\"bind:Column5\"/><Cell row=\"3\" col=\"5\" style=\"line:0 none;\"/><Cell row=\"4\" col=\"3\" style=\"line:0 none;\"/><Cell row=\"4\" col=\"4\" style=\"line:0 none;\"/><Cell row=\"4\" col=\"5\" style=\"line:0 none;\"/><Cell row=\"5\" style=\"line: ;\"/><Cell row=\"5\" col=\"1\" style=\"line: ;\"/><Cell row=\"5\" col=\"2\" style=\"line: ;\"/><Cell row=\"5\" col=\"3\" style=\"line: ;\"/><Cell row=\"5\" col=\"4\" style=\"line: ;\"/><Cell row=\"5\" col=\"5\" style=\"line: ;\"/></Band></Format></Formats>");
            this.div_additionOrder.addChild(obj.name, obj);
            obj = new Button("btn_", "absolute", "0", "662", null, "35", "0", null, this.div_additionOrder);
            obj.set_taborder("1");
            obj.set_text("더보기");
            obj.set_cssclass("btn_WF_More");
            this.div_additionOrder.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 0, 0, this.div_additionOrder,
            	//-- Layout function
            	function(p) {
            		p.set_taborder("89");
            		p.style.set_background("white");

            	}
            );
            this.div_additionOrder.addLayout(obj.name, obj);

            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("추가발주");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("frmWorkTest2.xfdl", "lib::sz_fsp_mobile_xp.xjs");
        this.registerScript("frmWorkTest2.xfdl", function(exports) {
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::sz_fsp_mobile_xp.xjs", null, exports); }	//include "lib::sz_fsp_mobile_xp.xjs"

        

        this.cbo_Storage_ondropdown = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_storageCd;
        	arg[1] = "조회조건(창고)";
        	arg[2] = "";
        	arg[3] = "cdNm";
        	application.goMain.gfn_POP_create("Storage", "cmmn::CmmnComboList.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        this.Button01_onclick = function(obj,e)
        {
        	application.goMain.fn_action("AdditionOrderBookmark");
        }

        this.Grid00_oncelldblclick = function(obj,e)
        {
        	
        	application.goMain.gfn_POP_create("", "M_MOM::ProductDetailPop.xfdl", "fn_callbackPOP", this, "", "POP", application.goMain.divBase);
        	
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
        		case "Storage":
        			this.cbo_Storage.set_index(rtn);
        			break;
        		case "PopCalFrom":
        			this.div_additionOrder.cal_dtTo.set_value(rtn);
        			break;
        	}
        }

        // tab버튼 동작
        this.btn_tab_onclick = function(obj,e)
        {
        	if (obj.name == "btn_additionOrder")
        	{
        		this.div_additionOrder.set_visible(true);
        		this.div_additionOrderBookMark.set_visible(false);
        		this.div_additionOrder.bringToFront();
        	}
        	else if (obj.name == "btn_additionOrderBookMark")
        	{
        		this.div_additionOrderBookMark.set_visible(true);
        		this.div_additionOrder.set_visible(false);
        		this.div_additionOrderBookMark.bringToFront();
        	}
        	this.btn_additionOrder.bringToFront();
        	this.btn_additionOrderBookMark.bringToFront();
        }

        // 더보기 버튼 동작
        this.div_additionOrder_btn__onclick = function(obj,e)
        {
        	//application.goMain.
        }

        
        // 달력 클릭 시
        this.div_additionOrder_cal_dtTo_ontouchstart = function(obj,e)
        {
        	var objCalArg = obj.value;
        	
        	application.goMain.gfn_POP_create("PopCalFrom", "cmmn::CmmnCalendarPop.xfdl", "fn_callbackPOP", this, objCalArg, "POP", application.goMain.divBase);
        	return false;
        }

        this.div_additionOrder_cal_dtTo_ondropdown = function(obj,e)
        {
        	var objCalArg = obj.value;
        	
        	application.goMain.gfn_POP_create("PopCalFrom", "cmmn::CmmnCalendarPop.xfdl", "fn_callbackPOP", this, objCalArg, "POP", application.goMain.divBase);
        	return false;
        }

        this.div_additionOrder_Grid00_onlongpress = function(obj,e)
        {
        	application.goMain.gfn_POP_create("", "M_MOM::ProductDetailPop.xfdl", "fn_callbackPOP", this, "", "POP", application.goMain.divBase);
        }

        this.div_additionOrder_onslide = function(obj,e)
        {
        	if (e.yaccvalue > 0)
        	{
        		this.parent.parent.divBottom.set_visible(true);
        		this.parent.parent.divMain.set_height(833);
        		this.parent.parent.divBottom.bringToFront();
        	}
        	else if (e.yaccvalue < 0)
        	{
        		this.parent.parent.divBottom.set_visible(false);
        		this.parent.parent.divMain.set_height(923);
        	}
        }

        this.div_additionOrder_onvscroll = function(obj,e)
        {
        	// div안의 스크롤 컨트롤일 경우 btnGoTop 대신 btnGoTopDiv 사용
        	if (e.pos == 0)
        	{
        		this.parent.btnGoTopDiv.set_visible(false);
        	}
        	else
        	{
        		this.parent.btnGoTopDiv.set_visible(true);
        	}
        }

        // div안의 스크롤바 조정일 경우 아래 함수 추가
        this.fn_setDivScrollbar = function()
        {
        	// 해당 div로 바꿔준다.
        	this.div_additionOrder.vscrollbar.set_pos(0);
        }
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.btn_additionOrder.addEventHandler("onclick", this.btn_tab_onclick, this);
            this.cbo_Storage.addEventHandler("ondropdown", this.cbo_Storage_ondropdown, this);
            this.Grid00.addEventHandler("oncelldblclick", this.Grid00_oncelldblclick, this);
            this.btn_additionOrderBookMark.addEventHandler("onclick", this.btn_tab_onclick, this);
            this.div_additionOrder.addEventHandler("onvscroll", this.div_additionOrder_onvscroll, this);
            this.div_additionOrder.addEventHandler("onslide", this.div_additionOrder_onslide, this);
            this.div_additionOrder.cbo_Storage.addEventHandler("ondropdown", this.cbo_Storage_ondropdown, this);
            this.div_additionOrder.cal_dtTo.addEventHandler("ontouchstart", this.div_additionOrder_cal_dtTo_ontouchstart, this);
            this.div_additionOrder.cal_dtTo.addEventHandler("ondropdown", this.div_additionOrder_cal_dtTo_ondropdown, this);
            this.div_additionOrder.Grid00.addEventHandler("oncelldblclick", this.Grid00_oncelldblclick, this);
            this.div_additionOrder.Grid00.addEventHandler("onlongpress", this.div_additionOrder_Grid00_onlongpress, this);
            this.div_additionOrder.btn_.addEventHandler("onclick", this.div_additionOrder_btn__onclick, this);

        };

        this.loadIncludeScript("frmWorkTest2.xfdl", true);

       
    };
}
)();
