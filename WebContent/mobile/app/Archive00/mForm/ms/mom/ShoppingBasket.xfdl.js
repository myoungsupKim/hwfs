﻿(function()
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
                this.set_name("ShoppingBasket");
                this.set_titletext("장바구니");
                this._setFormPosition(0,0,540,760);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
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

            obj = new Dataset("ds_grd", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"ITEM_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_CLASS4\" type=\"STRING\" size=\"256\"/><Column id=\"FEATURE_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_SIZE\" type=\"STRING\" size=\"256\"/><Column id=\"PO_UOM\" type=\"STRING\" size=\"256\"/><Column id=\"KG_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"CANCEL_PR_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"G_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"PR_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"PR_AMT\" type=\"STRING\" size=\"256\"/><Column id=\"TOT_AMT\" type=\"STRING\" size=\"256\"/><Column id=\"TAX_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"CENTER_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"PR_REMARK\" type=\"STRING\" size=\"256\"/><Column id=\"REMARK\" type=\"STRING\" size=\"256\"/><Column id=\"POINT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"SUBINV_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"NEED_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"DEPT_ID\" type=\"STRING\" size=\"256\"/><Column id=\"ACCTCD\" type=\"STRING\" size=\"256\"/><Column id=\"BUD_CLS\" type=\"STRING\" size=\"256\"/><Column id=\"MU_CD\" type=\"STRING\" size=\"256\"/><Column id=\"INVAT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"OUTVAT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"MIN_ORD_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"MAX_ORD_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"CENTER_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"STOCK_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"BARCODE\" type=\"STRING\" size=\"256\"/><Column id=\"KEEPING_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"MULTIPLIER_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"BUDDEPT_ID\" type=\"STRING\" size=\"256\"/><Column id=\"USE_YN\" type=\"STRING\" size=\"256\"/><Column id=\"CONTRACT_YN\" type=\"STRING\" size=\"256\"/><Column id=\"MARGIN_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"UNIT_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"CUSTCD\" type=\"STRING\" size=\"256\"/><Column id=\"CHEAP_YN\" type=\"STRING\" size=\"256\"/><Column id=\"KG_CONVERT_RATE\" type=\"STRING\" size=\"256\"/><Column id=\"MARGIN_RATE\" type=\"STRING\" size=\"256\"/><Column id=\"AP_UNITPRICE_UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"RESTRICT_PERIOD\" type=\"STRING\" size=\"256\"/><Column id=\"RESTRICT_REASON\" type=\"STRING\" size=\"256\"/><Column id=\"DUTY_END_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"MIN_DUTY_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"DUTY_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"REAL_USE_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"PR_YN\" type=\"STRING\" size=\"256\"/><Column id=\"SCH_INFO\" type=\"STRING\" size=\"256\"/><Column id=\"SHP_MAP\" type=\"STRING\" size=\"256\"/><Column id=\"MTG_UNS\" type=\"STRING\" size=\"256\"/><Column id=\"MTG_STP\" type=\"STRING\" size=\"256\"/><Column id=\"REQ_WKD\" type=\"STRING\" size=\"256\"/><Column id=\"SCH\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAY\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAYS\" type=\"STRING\" size=\"256\"/><Column id=\"D_TIMES\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAY_YN\" type=\"STRING\" size=\"256\"/><Column id=\"SPICE_YN\" type=\"STRING\" size=\"256\"/><Column id=\"CORN_YN\" type=\"STRING\" size=\"256\"/><Column id=\"IMG_PATH\" type=\"STRING\" size=\"256\"/><Column id=\"ORIGIN_NAT\" type=\"STRING\" size=\"256\"/><Column id=\"ORIGIN_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"VD_SN\" type=\"STRING\" size=\"256\"/><Column id=\"APPLY_SD\" type=\"STRING\" size=\"256\"/><Column id=\"MOBILE_GUBUN\" type=\"STRING\" size=\"256\"/><Column id=\"AGG_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"LINE_STATUS\" type=\"STRING\" size=\"256\"/><Column id=\"CART_IMG\" type=\"STRING\" size=\"256\"/><Column id=\"UPJANG_GRP\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_InsItem", this);
            obj._setContents("<ColumnInfo><Column id=\"ACCTCD\" size=\"7\" type=\"STRING\"/><Column id=\"BARCODE\" size=\"13\" type=\"STRING\"/><Column id=\"BUD_CLS\" size=\"6\" type=\"STRING\"/><Column id=\"BUDDEPT_ID\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"CENTER_CODE\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"CENTER_FLAG\" size=\"1\" type=\"STRING\"/><Column id=\"CUSTCD\" size=\"40\" type=\"STRING\"/><Column id=\"D_DAY\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"D_DAYS\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"D_TIMES\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"DEPT_ID\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"DUTY_QTY\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"EXP_CD\" size=\"3\" type=\"STRING\"/><Column id=\"FEATURE_NAME\" size=\"100\" type=\"STRING\"/><Column id=\"G_PRICE\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"IMG_PATH\" size=\"100\" type=\"STRING\"/><Column id=\"INVAT_FLAG\" size=\"1\" type=\"STRING\"/><Column id=\"ITEM_CODE\" size=\"12\" type=\"STRING\"/><Column id=\"ITEM_NAME\" size=\"200\" type=\"STRING\"/><Column id=\"ITEM_SIZE\" size=\"100\" type=\"STRING\"/><Column id=\"KEEPING_TYPE\" size=\"50\" type=\"STRING\"/><Column id=\"KG_CONVERT_RATE\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"MARGIN_PRICE\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"MIN_ORD_QTY\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"MAX_ORD_QTY\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"MU_CD\" size=\"2\" type=\"STRING\"/><Column id=\"MULTIPLIER_QTY\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"NEED_DATE\" size=\"8\" type=\"STRING\"/><Column id=\"OUTVAT_FLAG\" size=\"1\" type=\"STRING\"/><Column id=\"PO_UOM\" size=\"10\" type=\"STRING\"/><Column id=\"ORIGIN_INFO\" size=\"100\" type=\"STRING\"/><Column id=\"POINT_FLAG\" size=\"1\" type=\"STRING\"/><Column id=\"PR_AMT\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"PR_QTY\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"PR_YN\" size=\"1\" type=\"STRING\"/><Column id=\"REAL_USE_QTY\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"REMARK\" size=\"0\" type=\"STRING\"/><Column id=\"RESTRICT_PERIOD\" size=\"21\" type=\"STRING\"/><Column id=\"RESTRICT_REASON\" size=\"200\" type=\"STRING\"/><Column id=\"STOCK_FLAG\" size=\"1\" type=\"STRING\"/><Column id=\"SUBINV_CODE\" size=\"8\" type=\"STRING\"/><Column id=\"TAX_CODE\" size=\"3\" type=\"STRING\"/><Column id=\"UNIT_PRICE\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"UPJANG\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"D_DAY_YN\" size=\"1\" type=\"STRING\"/><Column id=\"MIN_DUTY_QTY\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"DUTY_END_DATE\" size=\"100\" type=\"STRING\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_budget", this);
            obj._setContents("<ColumnInfo><Column id=\"ACCT_NAME\" size=\"68\" type=\"STRING\"/><Column id=\"AMT\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"BALANCE_AMT\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"BDGT_YM\" size=\"13\" type=\"STRING\"/><Column id=\"BUDCLS_NAME\" size=\"67\" type=\"STRING\"/><Column id=\"DEPT_NAME\" size=\"142\" type=\"STRING\"/><Column id=\"OFFER_AMT\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"PR_YN\" size=\"8\" type=\"STRING\"/><Column id=\"PROJECT_NAME\" size=\"69\" type=\"STRING\"/><Column id=\"REMAINDER\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"BUD_CLS\" size=\"256\" type=\"STRING\"/><Column id=\"DEPT_ID\" size=\"256\" type=\"STRING\"/><Column id=\"ACCTCD\" size=\"256\" type=\"STRING\"/><Column id=\"BDGT_Y\" size=\"256\" type=\"STRING\"/><Column id=\"BDGT_M\" size=\"256\" type=\"STRING\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_condi", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"EXPT_UPJANG_YN\" type=\"STRING\" size=\"256\"/><Column id=\"APPROV_YN\" type=\"STRING\" size=\"256\"/><Column id=\"TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"PR_SABUN\" type=\"STRING\" size=\"256\"/><Column id=\"PR_DEPT_ID\" type=\"STRING\" size=\"256\"/><Column id=\"PO_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"PO_TYPE_NM\" type=\"STRING\" size=\"256\"/><Column id=\"PR_UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"PR_UPJANG_NM\" type=\"STRING\" size=\"256\"/><Column id=\"RC_UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"RC_UPJANG_NM\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAYS\" type=\"STRING\" size=\"256\"/><Column id=\"D_TIMES\" type=\"STRING\" size=\"256\"/><Column id=\"PR_NUM\" type=\"STRING\" size=\"256\"/><Column id=\"PR_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"NEED_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"SUBINV_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"SORT_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"STATUS\" type=\"STRING\" size=\"256\"/><Column id=\"REASON_CD\" type=\"STRING\" size=\"256\"/><Column id=\"PR_REASON\" type=\"STRING\" size=\"256\"/><Column id=\"LINE_STATUS\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_del_item", this);
            obj._setContents("<ColumnInfo><Column id=\"ITEM_CODE\" type=\"string\" size=\"18\"/><Column id=\"ITEM_NAME\" type=\"string\" size=\"601\"/><Column id=\"ITEM_CLASS4\" type=\"string\" size=\"18\"/><Column id=\"FEATURE_NAME\" type=\"string\" size=\"1\"/><Column id=\"ITEM_SIZE\" type=\"string\" size=\"1000\"/><Column id=\"PO_UOM\" type=\"string\" size=\"18\"/><Column id=\"KG_QTY\" type=\"bigdecimal\" size=\"39\"/><Column id=\"ONHAND_QTY\" type=\"bigdecimal\" size=\"14\"/><Column id=\"CANCEL_PR_QTY\" type=\"bigdecimal\" size=\"39\"/><Column id=\"PR_QTY\" type=\"bigdecimal\" size=\"39\"/><Column id=\"TOT_AMT\" type=\"bigdecimal\" size=\"39\"/><Column id=\"TAX_CODE\" type=\"string\" size=\"3\"/><Column id=\"CENTER_FLAG\" type=\"string\" size=\"1\"/><Column id=\"REMARK\" type=\"string\" size=\"255\"/><Column id=\"POINT_FLAG\" type=\"string\" size=\"1\"/><Column id=\"SUBINV_CODE\" type=\"string\" size=\"8\"/><Column id=\"NEED_DATE\" type=\"string\" size=\"8\"/><Column id=\"UPJANG\" type=\"bigdecimal\" size=\"7\"/><Column id=\"DEPT_ID\" type=\"string\" size=\"6\"/><Column id=\"ACCTCD\" type=\"string\" size=\"255\"/><Column id=\"BUD_CLS\" type=\"string\" size=\"30\"/><Column id=\"MU_CD\" type=\"string\" size=\"4\"/><Column id=\"INVAT_FLAG\" type=\"string\" size=\"1\"/><Column id=\"OUTVAT_FLAG\" type=\"string\" size=\"1\"/><Column id=\"MIN_ORD_QTY\" type=\"bigdecimal\" size=\"14\"/><Column id=\"MAX_ORD_QTY\" type=\"bigdecimal\" size=\"14\"/><Column id=\"CENTER_CODE\" type=\"string\" size=\"18\"/><Column id=\"STOCK_FLAG\" type=\"string\" size=\"1\"/><Column id=\"BARCODE\" type=\"string\" size=\"60\"/><Column id=\"MULTIPLIER_QTY\" type=\"bigdecimal\" size=\"14\"/><Column id=\"BUDDEPT_ID\" type=\"string\" size=\"30\"/><Column id=\"USE_YN\" type=\"string\" size=\"1\"/><Column id=\"CONTRACT_YN\" type=\"string\" size=\"1\"/><Column id=\"MARGIN_PRICE\" type=\"string\" size=\"40\"/><Column id=\"UNIT_PRICE\" type=\"bigdecimal\" size=\"22\"/><Column id=\"CUSTCD\" type=\"bigdecimal\" size=\"39\"/><Column id=\"CHEAP_YN\" type=\"string\" size=\"1\"/><Column id=\"KG_CONVERT_RATE\" type=\"bigdecimal\" size=\"39\"/><Column id=\"MARGIN_RATE\" type=\"bigdecimal\" size=\"8\"/><Column id=\"AP_UNITPRICE_UPJANG\" type=\"bigdecimal\" size=\"7\"/><Column id=\"RESTRICT_PERIOD\" type=\"string\" size=\"21\"/><Column id=\"RESTRICT_REASON\" type=\"string\" size=\"200\"/><Column id=\"DUTY_END_DATE\" type=\"string\" size=\"255\"/><Column id=\"MIN_DUTY_QTY\" type=\"bigdecimal\" size=\"39\"/><Column id=\"DUTY_QTY\" type=\"bigdecimal\" size=\"39\"/><Column id=\"REAL_USE_QTY\" type=\"bigdecimal\" size=\"39\"/><Column id=\"PR_YN\" type=\"string\" size=\"1\"/><Column id=\"D_DAY\" type=\"bigdecimal\" size=\"39\"/><Column id=\"D_DAYS\" type=\"bigdecimal\" size=\"39\"/><Column id=\"D_TIMES\" type=\"bigdecimal\" size=\"39\"/><Column id=\"D_DAY_YN\" type=\"string\" size=\"1\"/><Column id=\"SPICE_YN\" type=\"string\" size=\"1\"/><Column id=\"CORN_YN\" type=\"string\" size=\"1\"/><Column id=\"IMG_PATH\" type=\"string\" size=\"756\"/><Column id=\"ORIGIN_NAT\" type=\"string\" size=\"60\"/><Column id=\"ORIGIN_TYPE\" type=\"string\" size=\"60\"/><Column id=\"VD_SN\" type=\"string\" size=\"18\"/><Column id=\"APPLY_SD\" type=\"string\" size=\"8\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_save_out", this);
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

            obj = new Dataset("ds_commonCd", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"256\"/><Column id=\"cdNm\" type=\"STRING\" size=\"256\"/><Column id=\"set1\" type=\"STRING\" size=\"256\"/><Column id=\"set2\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("Static04", "absolute", "0", "0", null, "2", "0", null, this);
            obj.set_taborder("4");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid01", "absolute", "566", "279", "377", "226", null, null, this);
            obj.set_taborder("25");
            obj.set_binddataset("ds_ColorChipGuide");
            obj.set_cssclass("grd_WF_Default2");
            obj.set_scrollbars("none");
            obj.set_visible("false");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"56\"/><Column size=\"320\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\" band=\"head\"/><Row size=\"35\"/><Row size=\"35\"/><Row size=\"35\"/><Row size=\"35\"/><Row size=\"35\"/></Rows><Band id=\"head\"><Cell text=\"Column1\"/><Cell col=\"1\" text=\"Column2\"/><Cell row=\"1\"/><Cell row=\"1\" col=\"1\" text=\"ImageName\"/></Band><Band id=\"body\"><Cell displaytype=\"image\" style=\"backgroundimage:URL('theme://Image/grd_WF_ColorchipPlanning.png');\" text=\"bind:Column0\"/><Cell col=\"1\" style=\"padding:0 10 0 10;font:9 Dotum;selectfont:9 Dotum;\" text=\"bind:Column5\"/><Cell row=\"1\" displaytype=\"image\" style=\"backgroundimage:URL('theme://Image/grd_WF_ColorchipNew.png');\" text=\"bind:Column1\"/><Cell row=\"1\" col=\"1\" style=\"padding:0 10 0 10;font:9 Dotum;selectfont:9 Dotum;\" text=\"bind:Column6\"/><Cell row=\"2\" displaytype=\"image\" style=\"backgroundimage:URL('theme://Image/grd_WF_ColorchipSpecial.png');\" text=\"bind:Column2\"/><Cell row=\"2\" col=\"1\" style=\"padding:0 10 0 10;font:9 Dotum;selectfont:9 Dotum;\" text=\"bind:Column7\"/><Cell row=\"3\" displaytype=\"image\" style=\"backgroundimage:URL('theme://Image/grd_WF_ColorchipRecommend.png');\" text=\"bind:Column3\"/><Cell row=\"3\" col=\"1\" style=\"padding:0 10 0 10;font:9 Dotum;selectfont:9 Dotum;\" text=\"bind:Column8\"/><Cell row=\"4\" displaytype=\"image\" style=\"backgroundimage:URL('theme://Image/grd_WF_ColorchipLimit.png');\" text=\"bind:Column4\"/><Cell row=\"4\" col=\"1\" style=\"padding:0 10 0 10;font:9 Dotum;selectfont:9 Dotum;\" text=\"bind:Column9\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static68", "absolute", "-3", "284", "21", "35", null, null, this);
            obj.set_taborder("26");
            obj.set_text("Fix h35 (10+25)");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static16", "absolute", "-3", "319", "21", "35", null, null, this);
            obj.set_taborder("28");
            obj.set_text("Fix h35 (10+25)");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static20", "absolute", "565", "315", "56", "23", null, null, this);
            obj.set_taborder("31");
            obj.set_text("Fix w56");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static21", "absolute", "562", "330", "21", "35", null, null, this);
            obj.set_taborder("32");
            obj.set_text("Fix h35 (10+25)");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static24", "absolute", "530", "684", "10", "76", null, null, this);
            obj.set_taborder("35");
            obj.set_text("w10");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static27", "absolute", "1135", "87", "53", "50", null, null, this);
            obj.set_taborder("37");
            obj.style.set_background("URL('theme://Image/CellGrd_WF_Cartbtn.png')");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static28", "absolute", "1176", "108", "37", "2", null, null, this);
            obj.set_taborder("38");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static29", "absolute", "1219", "93", "276", "35", null, null, this);
            obj.set_taborder("39");
            obj.set_text("ImageName : CellGrd_WF_Cartbtn.png");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static31", "absolute", "1135", "69", "53", "23", null, null, this);
            obj.set_taborder("40");
            obj.set_text("Fix w53");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static32", "absolute", "1124", "87", "21", "50", null, null, this);
            obj.set_taborder("41");
            obj.set_text("Fix h50 (25+25)");
            obj.set_cssclass("sta_GUIDE_Area");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("sta_upjang", "absolute", "0", "0", "538", "57", null, null, this);
            obj.set_taborder("58");
            obj.set_text("한촌강남점");
            obj.set_cssclass("sta_WF_Label01");
            this.addChild(obj.name, obj);

            obj = new Div("div_search", "absolute", "0", "56", null, "59", "0", null, this);
            obj.set_taborder("59");
            this.addChild(obj.name, obj);
            obj = new Static("Static22", "absolute", "0", "0", null, "59", "0", null, this.div_search);
            obj.set_taborder("33");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.div_search.addChild(obj.name, obj);
            obj = new Button("btn_confirm", "absolute", "414", "6", "117", "47", null, null, this.div_search);
            obj.set_taborder("34");
            obj.set_text("발주확정");
            obj.set_cssclass("btn_WF_Function");
            this.div_search.addChild(obj.name, obj);
            obj = new Button("btn_save", "absolute", "291", "6", "117", "47", null, null, this.div_search);
            obj.set_taborder("35");
            obj.set_text("중간저장");
            obj.set_cssclass("btn_WF_Function");
            this.div_search.addChild(obj.name, obj);
            obj = new Button("btn_allDelete", "absolute", "168", "6", "117", "47", null, null, this.div_search);
            obj.set_taborder("36");
            obj.set_text("전체삭제");
            obj.set_cssclass("btn_WF_Function");
            this.div_search.addChild(obj.name, obj);
            obj = new Button("btn_search", "absolute", "60", "6", null, "47", "378", null, this.div_search);
            obj.set_taborder("37");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.div_search.addChild(obj.name, obj);

            obj = new Grid("grd_list", "absolute", "0", "114", null, null, "0", "0", this);
            obj.set_cssclass("grd_WF_Default2");
            obj.set_taborder("43");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_nodataimage("URL('theme://Image/cart_empty.gif')");
            obj.set_fillareatype("none");
            obj.set_summarytype("default");
            obj.set_useselcolor("true");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"8\"/><Column size=\"131\"/><Column size=\"79\"/><Column size=\"145\"/><Column size=\"110\"/><Column size=\"66\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"55\"/><Row size=\"50\"/><Row size=\"55\"/><Row size=\"3\"/></Rows><Band id=\"head\"><Cell text=\"Column1\"/><Cell col=\"1\" text=\"Column0\"/><Cell col=\"2\"/><Cell col=\"3\"/><Cell col=\"4\"/><Cell col=\"5\"/></Band><Band id=\"body\"><Cell displaytype=\"normal\" style=\"line:0 none #808080ff ;background2: ;selectbackground:ghostwhite;\"/><Cell col=\"1\" colspan=\"3\" style=\"align:left bottom;padding:EXPR(FEATURE_NAME == undefined ?&quot;'0 10 0 0&quot; :&quot;'0 10 0 65&quot;);line:0 solid #808080ff ;background:transparent left bottom;background2:transparent left bottom;selectbackground:ghostwhite left bottom;backgroundimage:BIND(FEATURE_NAME);\" text=\"expr:ITEM_CODE + &quot; &quot; + ITEM_NAME\" wordwrap=\"char\"/><Cell col=\"4\" rowspan=\"2\" displaytype=\"number\" edittype=\"none\" style=\"align:right middle;padding:55 0 0 0;line:0 solid #808080ff ;selectbackground:ghostwhite;\" text=\"bind:PR_QTY\" mask=\"#,##0.0#\" maskchar=\" \" editdisplay=\"display\"/><Cell col=\"5\" rowspan=\"2\" displaytype=\"button\" edittype=\"button\" style=\"padding:55 6 0 6;line:0 solid transparent ;selectbackground:ghostwhite;controlbackground:URL('theme://Image/CellGrd_WF_Xbtn.png') stretch;controlborder:0 solid #808080ff ;\" calendardisplay=\"edit\"/><Cell row=\"1\" colspan=\"2\" displaytype=\"date\" style=\"align:center middle;padding:0 10 0 10;line:0 none #808080ff ;selectbackground:ghostwhite;\" text=\"bind:NEED_DATE\"/><Cell row=\"1\" col=\"2\" displaytype=\"normal\" style=\"align:right middle;padding:0 10 0 10;line:0 none #808080ff ;selectbackground:ghostwhite;\" text=\"bind:PO_UOM\"/><Cell row=\"1\" col=\"3\" displaytype=\"number\" style=\"align:right middle;padding:0 10 0 10;line:0 solid #808080ff ;color:red;color2:red;selectbackground:ghostwhite;selectcolor:red;\" text=\"bind:MARGIN_PRICE\" mask=\"###,###,###.##\"/><Cell row=\"2\" style=\"line:0 solid #808080ff ;selectbackground:ghostwhite;\"/><Cell row=\"2\" col=\"1\" colspan=\"3\" style=\"align:left top;padding: ;line:0 solid #808080ff ;selectbackground:ghostwhite;\" text=\"bind:ITEM_SIZE\"/><Cell row=\"2\" col=\"4\" style=\"line:0 solid #808080ff ;selectbackground:ghostwhite;\"/><Cell row=\"2\" col=\"5\" style=\"line:0 solid #808080ff ;selectbackground:ghostwhite;\"/><Cell row=\"3\" style=\"line: ;selectbackground:ghostwhite;\"/><Cell row=\"3\" col=\"1\" colspan=\"3\" style=\"align:left top;padding:0 10 0 10;line: ;selectbackground:ghostwhite;\" text=\"bind:ITEM_SIZE\"/><Cell row=\"3\" col=\"4\" style=\"line: ;selectbackground:ghostwhite;\"/><Cell row=\"3\" col=\"5\" style=\"line: ;selectbackground:ghostwhite;\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 0, 59, this.div_search,
            	//-- Layout function
            	function(p) {
            		p.set_taborder("59");

            	}
            );
            this.div_search.addLayout(obj.name, obj);

            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("장바구니");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("ShoppingBasket.xfdl", "lib::lib_Com.xjs");
        this.registerScript("ShoppingBasket.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		장바구니
        // [부시스템명]	장바구니 - 조회
        // [설명]
        // 		부서 검색하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.02.17
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.17 : 강대성 : 수정이 필요하여 수정함.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/
        this.preDate = undefined;
        this.tTimeout = undefined;
        var fv_PoItemName;
        var fv_closeRamak;   // 유형별 디데이 디타임 체크 변수(확정시 리턴되는 값)
        var strDataGroup = "U_svc";

        /*================================================================================
         * 2. Form관련 Script
         *===============================================================================*/
        /** 
         * Form의 모든 컴포넌트가 생성되고, 모든 Object가 Load 되었을 때에 발생하는 Event
         * @param
        	obj : Event가 발생한 Object
        	e : Event Object
         * @return : 없음
         */ 
        this.form_onload = function(obj,e)
        {
        	//메세지 공통 코드 호출
        	this.fn_common_code("SYS_CLS_PRD", "PO","","","AND TO_CHAR(SYSDATE, 'YYYYMMDDHH24MI') BETWEEN REPLACE(REPLACE(REPLACE(SET1,'/',''),' ',''),':','') AND REPLACE(REPLACE(REPLACE(SET2,'/',''),' ',''),':','')");
        	this.ds_commonCd.copyData(application.gds_common_code);
        	
        	if(this.ds_commonCd.getRowCount() > 0 )
        	{
        		this.commonMsg(this.ds_commonCd.getColumn(0, "set1"), this.ds_commonCd.getColumn(0, "set2"));		
        	}
        	else
        	{
        		//필수
        		this.fn_init();
        	}
        }

        // 데이터 초기화
        this.fn_init = function ()
        {
        	application.goMenu = this;	
        	
        	//FSP초기화
        	this.fsp_init();
        	
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정(검색)
        	this.fn_SetBtnControl("this.div_search.btn_search","");
        	
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정(전체삭제)
        	this.fn_SetBtnControl("","this.div_search.btn_allDelete");
        	
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정(중간저장)
        	this.fn_SetBtnControl("","this.div_search.btn_save");
        	
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정(발주확정)
        	this.fn_SetBtnControl("","this.div_search.btn_confirm");	
        	
        	//현재날짜 세팅
        	this.preDate = this.gfn_Today();
        	
        	// 데이터셋 카피(추가발주시 등록된 데이터셋)
        	this.ds_grd.copyData(application.gds_marketList, true);
        	this.ds_condi.copyData(application.gds_condi, true);
        	
        	trace(this.ds_grd.saveXML("this.ds_grd", "V"));
        	trace(this.ds_condi.saveXML("this.ds_condi", "V"));
        	
        	//사업장 세팅
        	if(this.gfn_isNull(this.ds_condi.getColumn(0, "RC_UPJANG_NM")))
        	{
        		this.sta_upjang.set_text(application.g_UpjangNm);
        	}
        	else
        	{
        		this.sta_upjang.set_text(this.ds_condi.getColumn(0, "RC_UPJANG_NM"));
        	}
        	
        	//버튼 컨트롤 초기화 시킴
        	this.fn_Btn_con();
        	
        	trace(this.ds_condi.saveXML("this.ds_condi", "V"));
        }

        //버튼 초기화
        this.fn_Btn_con = function ()
        {
        	var sType  = this.ds_condi.getColumn(0, "TYPE");
        	var sLineStatus = this.ds_condi.getColumn(0, "LINE_STATUS");
        	
        	//진행상태가 신청저장, 발주취소 또는 신규일경우만 중간저장 버튼 활성화 시킴
        	if(sLineStatus == "001" || sLineStatus == "PD" || sType == "NEW")		
        	{
        		this.div_search.btn_save.set_enable(true);
        	}
        	//그 외의 경우 중간저장 버튼 비활성화 시킴
        	else
        	{
        		this.div_search.btn_save.set_enable(false);
        	}	
        	
        	//데이터셋 데이터가 없을 경우 검색 및 저장버튼 비활성화 시킴
        	if(this.ds_grd.getRowCount() == "0")
        	{
        		this.div_search.btn_search.set_enable(false);
        		this.div_search.btn_allDelete.set_enable(false);
        		this.div_search.btn_save.set_enable(false);
        		this.div_search.btn_confirm.set_enable(false);
        	}		
        	
        }

        //그리드 더블 클릭시 상품 상세팝업 호출
        this.grd_list_oncelldblclick = function(obj,e)
        {
        	var arg = new Array();
        	var nRow = e.row;
        	arg[0] = this.ds_grd.getColumn(nRow, "ITEM_NAME");
        	arg[1] = this.ds_grd.getColumn(nRow, "ITEM_SIZE");
        	arg[2] = this.ds_grd.getColumn(nRow, "PO_UOM");
        	arg[3] = this.ds_grd.getColumn(nRow, "KEEPING_TYPE");
        	arg[4] = this.ds_grd.getColumn(nRow, "ORIGIN_TYPE");
        	arg[5] = this.ds_grd.getColumn(nRow, "IMG_PATH");
        	
        	application.goMain.gfn_POP_create("", "M_MOM::ProductDetailPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	
        }

        // 달력 클릭 시
        this.div_shoppingBasket_cal_dtFrom_ondropdown = function(obj,e)
        {
        	var objCalArg = obj.value;
        	
        	application.goMain.gfn_POP_create("PopCalFrom", application.goMain.divBase.div_calendar, "fn_callbackPOP", this, objCalArg, "POPDivx", application.goMain.divBase);
        	return false;
        }

        //버튼 클릭시(공통)
        this.Common_Btn_common_OnClick = function (obj,e)
        {
        	switch(obj.name)
        	{
        		case "btn_search":
        			this.fn_init();
        			break;
        		case "btn_save":
        			application.goMain.gfn_Msg("save", "중간저장", "신청자료를 저장하시겠습니까?!\n향후 확정하지 않으면 발주되지 않으니 참고하시기 바랍니다.", "YN", true, this);
        			break;
        		case "btn_confirm":
        			application.goMain.gfn_Msg("confirm", "확정", "신청자료를 확정하시겠습니까?!", "YN", true, this);
        			break;
        		default:
        			break;
        	}
        }

        //전체삭제 버튼 클릭시
        this.div_search_btn_allDelete_onclick = function(obj,e)
        {
        	application.goMain.gfn_Msg("deleteAll", "삭제", "전체 삭제하시겠습니까?", "YN", true, this);
        }

        //그리드 cell선택시
        this.grd_list_oncellclick = function(obj,e)
        {
        	//alert(e.cell);
        	var nRow = e.row;
        	
        	var prQty = this.ds_grd.getColumn(nRow, "PR_QTY");
        	var marginPrice = this.ds_grd.getColumn(nRow, "MARGIN_PRICE");
        	var itemName = this.ds_grd.getColumn(nRow, "ITEM_NAME")	
        	
        	if(e.cell == "2")
        	{
        		var arg = new Array();
        	
        		arg[0] = this.ds_grd.getColumn(nRow, "PR_QTY");
         		arg[1] = this.ds_grd.getColumn(nRow, "ITEM_CODE");
        		arg[2] = this.ds_grd.getColumn(nRow, "ITEM_NAME");
        	
        		application.goMain.gfn_POP_create("itemCount", "cmmn::CmmnInputNumber.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        		return false;
        	}
        		
        	if(e.cell == "3")
        	{
        		application.goMain.gfn_Msg("delete", "삭제", "["+itemName+"]\n["+this.gfn_NumFormat(marginPrice)+"]\n["+prQty+"개]\n 삭제하시겠습니까?", "YN", true, this);
        	}
        	//application.goMain.gfn_Msg("logout", "로그아웃", "로그아웃 하시겠습니까?", "YN", true, this);
        }

        /*******************************************************************************
        * 기      능   :  중간저장 및 확정
        * 설      명   :  중간저장 및 확정
        ********************************************************************************/
        this.fn_save = function (sType)
        {
        	
        	var strSvcID;				// 서비스 ID
        	var strURL;				    // jsp 경로
        	var strInDatasets;			// 입력 데이터셋
        	var strOutDatasets;			// 출력 데이터셋
        	var strArgument;			// 추가 파라미터
        	var strCallbackFunc;		// 콜백함수명	
        	
        	strSvcID   		  = "SAVE";
        	
        	if(this.ds_condi.getColumn(0,"TYPE") == "TEMP_UPDATE" || this.ds_condi.getColumn(0,"TYPE") == "UPDATE") 
        	{
        		strURL      	  = application.services[strDataGroup].url + "fs/fsp/FSP00032E_T012.jsp";
        		strInDatasets     = "ds_pr_item=ds_grd:A ds_condi=ds_condi ds_del_item=ds_del_item";
        	}
        	else 
        	{
        		strURL      	  = application.services[strDataGroup].url + "fs/fsp/FSP00032E_T007.jsp";
        		strInDatasets     = "ds_pr_item=ds_grd ds_condi=ds_condi ds_del_item=ds_del_item";
        	}
        	
        	strOutDatasets    = "ds_save_out=ds_save_out";
        	
        	// 파라메터 설정
        	strArgument       = "p_mobile_gubun=" + "M";  //모바일 구분자
        	strCallbackFunc   = "fn_CallBackSave";
        	
        	if(!this.fn_transation_validation(strSvcID)) return;
        	
        	this.ds_condi.setColumn(0, "STATUS", sType);	// sType : 001-신청저장, 002-신청확정
        	
        	// 트랜잭션
        	this.jsp_transaction(this,strSvcID,strURL,strInDatasets,strOutDatasets,strArgument,strCallbackFunc,false,false,false);
        }

        /*----------------------------------------------------------------------------------------------
         * 함  수  명   : fn_transation_validation()
         * 기      능   : 조회 전 유효성체크
        *----------------------------------------------------------------------------------------------*/
        this.fn_transation_validation = function (sSvcID)
        {	
        	switch(sSvcID)
        	{
        		case "SEARCH_SUBINV" :
        			break;
        		
        		case "SEARCH" :
        			break;
        		
        		case "SAVE" :
        		    //모바일에서 추가발주 신청 또는 수정시 사유등록은 공통사항임
        			this.ds_condi.setColumn(0, "REASON_CD" , "4");   //모바일 대분류 코드
        			this.ds_condi.setColumn(0, "PR_REASON" , "41");  //모바일 중분류 코드
        		
        			var sReasonCd = this.ds_condi.getColumn(0, "REASON_CD");
        			var sPrReason = this.ds_condi.getColumn(0, "PR_REASON");

        			if(this.gfn_isNull(sReasonCd) || this.gfn_isNull(sPrReason))
        			{
        				application.goMain.gfn_Msg("OK", "알림", "식자재 구매신청은 사유 선택/입력을 반드시 해야 합니다.", "OK", "OK");
        				return;		
        			}
        			
        			// 작성 내역 확인
        			if(this.ds_grd.getCountNF() < 0){
        				application.goMain.gfn_Msg("OK", "알림", "작성된 구매 신청 내역이 없습니다.", "OK", "OK");
        				this.ds_grd.filter("");
        				return false;
        			}
        			
        			this.ds_grd.filter("PR_QTY>0");
        			if(this.ds_grd.getRowCount() < 1){
        				application.goMain.gfn_Msg("OK", "알림", "구매신청내역중 확정이 가능한 자재가 없습니다.\n신청수량,발주가능여부등을 점검하시기 바랍니다.", "OK", "OK");
        				this.ds_grd.filter("");
        				return;
        			}
        			
        			//D-Day 점검
        			if(!this.fn_CheckDateTime()) {
        				this.ds_grd.filter("");
        				return false;
        			}
        			
        			//선발주 점검,의무자재 제한 점검
        			if(!this.fn_CheckDutyAndPreOrder()){
        				this.ds_grd.filter("");
        				return false;
        			}	
        			
        			break;
        			
        	}
        	
        	return true;
        }

        /*******************************************************************************
        * 기      능   : 사업유형 점검(델리카업장인지 판단) 
        * 설      명   : 사업유형 점검(델리카업장인지 판단)  
        ********************************************************************************/
        var v_SaupType;
        this.fn_CheckSaupType = function ()
        {
        	var strSvcID,strURL,strInDatasets,strOutDatasets,strArgument,strCallbackFunc;
        	
        	// 경로 설정
        	strSvcID = "FSP00035E_T005";
        	strURL   = application.services[strDataGroup].url + "fs/fsp/FSP00035E_T005.jsp";
        	
        	// 데이터셋 설정
        	strInDatasets = "";
        	strOutDatasets = "";
        	
        	// 파라메터 설정
        	strArgument  = "p_SubinvCode=" + nexacro.wrapQuote(application.gv_subinvCd);
        	
        	// 콜백함수 지정
        	strCallbackFunc = "";

        	this.jsp_transaction(this,strSvcID,strURL,strInDatasets,strOutDatasets,strArgument,strCallbackFunc,false,false,true);
        	
        	if(v_SaupType == "003")
        	{
        		return false;
        	}
        	
        	return true;
        }

        /*******************************************************************************
        * 기      능   : 데이트타임 체크
        * 설      명   : 데이트타임 체크
        ********************************************************************************/
        this.fn_CheckDateTime = function ()
        {
        	//구매유형 재조회(디데이 설정등이 바뀌었을 수 있다.)
        	//this.fn_search_potype();
        	
        	if(this.ds_condi.getColumn(0, "D_DAYS") == "0") return true;
        	
        	var f_CurrDateTime = this.fn_CurrDateWeek("ymdtm");
        	
        	if( this.ds_condi.getColumn(0, "NEED_DATE") < this.gfn_AddDate(this.gfn_subStr(f_CurrDateTime,0,8),nexacro.toNumber(this.ds_condi.getColumn(0, "D_DAYS"))))
        	{
        		var v_Msg;
        		v_Msg  = " ※ 현재 입고일로는 추가발주할 수 없습니다. \n\n";
        		v_Msg += "    구 매  유 형 : " + this.ds_condi.getColumn(0, "PO_TYPE_NM") + "\n";
        		v_Msg += "    현 재  시 간 : " + this.fn_FormatDateTime(f_CurrDateTime) + "\n";
        		v_Msg += "    신청가능일자 : " + this.fn_FormatDateTime(this.gfn_AddDate(this.gfn_subStr(f_CurrDateTime,0,8),nexacro.toNumber(this.ds_condi.getColumn(0, "D_DAYS")))) + " (D_DAY=" + this.ds_condi.getColumn(0, "D_DAYS") + "일" + this.ds_condi.getColumn(0, "D_TIMES") + "시) \n";
        		
        		application.goMain.gfn_Msg("OK", "알림", v_Msg, "OK", "OK");
        		
        		return false;
        	}
        	
        	if( this.ds_condi.getColumn(0, "NEED_DATE") == this.gfn_AddDate(this.gfn_subStr(f_CurrDateTime,0,8),nexacro.toNumber(this.ds_condi.getColumn(0, "D_DAYS"))))
        	{
        		if(nexacro.toNumber(this.ds_condi.getColumn(0, "D_TIMES")) == 0) return true;
        		
        		if( nexacro.toNumber(this.gfn_subStr(f_CurrDateTime,8,2)) >= nexacro.toNumber(this.ds_condi.getColumn(0, "D_TIMES")))
        		{
        			var v_Msg;
        			v_Msg  = " ※ 현재 시간은 추가발주할 수 없습니다. \n\n";
        			v_Msg += "    구 매  유 형 : " + this.ds_condi.getColumn(0, "PO_TYPE_NM") + "\n";
        			v_Msg += "    현 재  시 간 : " + this.fn_FormatDateTime(f_CurrDateTime) + "\n";
        			v_Msg += "    신청가능일시 : " + this.fn_FormatDateTime(this.gfn_AddDate(this.gfn_subStr(f_CurrDateTime,0,8),nexacro.toNumber(this.ds_condi.getColumn(0, "D_DAYS")))) + " " + this.ds_condi.getColumn(0, "D_TIMES") + "시 (D_DAY=" + this.ds_condi.getColumn(0, "D_DAYS") + "일" + this.ds_condi.getColumn(0, "D_TIMES") + "시) \n";
        			
        			application.goMain.gfn_Msg("OK", "알림", v_Msg, "OK", "OK");
        			
        			return false;
        		}
        	}	

        	return true;
        }

        /*******************************************************************************
        * 기      능   : 수불마감 및 재고마감 점검
        * 설      명   : 수불마감 및 재고마감 점검
        ********************************************************************************/
        var v_SubulCloseYN, v_JaegoCloseYN;
        this.fn_CheckCloseYN = function ()
        {
        	var strSvcID,strURL,strInDatasets,strOutDatasets,strArgument,strCallbackFunc;
        	
        	// 경로 설정
        	strSvcID = "FSP000000_T001";
        	strURL   = application.services[strDataGroup].url + "fs/fsp/FSP000000_T001.jsp";
        	
        	// 데이터셋 설정
        	strInDatasets = "";
        	strOutDatasets = "";
        	
        	trace("application.gv_subinvCd >>>>" +application.gv_subinvCd);
        	
        	// 파라메터 설정
        	strArgument  = "p_SubinvCode=" + nexacro.wrapQuote(application.gv_subinvCd, "");
        	strArgument += " p_NeedDate=" + nexacro.wrapQuote(this.ds_condi.getColumn(0, "NEED_DATE"), "");
        	
        	// 콜백함수 지정
        	strCallbackFunc = "";
        	this.jsp_transaction(this,strSvcID,strURL,strInDatasets,strOutDatasets,strArgument,strCallbackFunc,false,false,true);
        	
        	var strMsg;
        	
        	trace("v_SubulCloseYN >>>>" +v_SubulCloseYN);
        	
        	if(v_SubulCloseYN != "N")
        	{
        		strMsg = " ※ 구매신청 불가!! 수불 마감 완료 창고\n";
        		strMsg+= "    마감월 : " + v_SubulCloseYN;
        	
        		application.goMain.gfn_Msg("OK", "알림", strMsg, "OK", "OK");
        		return false;
        	}
        	
        	if(v_JaegoCloseYN != "N")
        	{
        		strMsg = " ※ 구매신청 불가!! 재고 반영 완료 창고\n";
        		strMsg+= "    재고반영일 : " + v_JaegoCloseYN;
        	
        		application.goMain.gfn_Msg("OK", "알림", strMsg, "OK", "OK");
        		return false;
        	}
        		
        	return true;
        }

        /*******************************************************************************
        * 기      능   : 선발주 제한 및 의무자재 사용량 점검
        * 설      명   : 선발주 제한 및 의무자재 사용량 점검
        ********************************************************************************/
        this.fn_CheckDutyAndPreOrder = function ()
        {
        	var v_Msg;
        	
        	var f_CurrDateTime = this.fn_CurrDateWeek("ymdtm");
        	
        	for(var i = 0; i < this.ds_grd.getRowCount(); i++)
        	{
        		if( (nexacro.toNumber(this.ds_grd.getColumn(i,"DUTY_QTY")) > 0) && (nexacro.toNumber(this.ds_grd.getColumn(i,"DUTY_QTY")) < nexacro.toNumber(this.ds_grd.getColumn(i,"REAL_USE_QTY")) + nexacro.toNumber(this.ds_grd.getColumn(i,"PR_QTY"))) )
        		{

        			v_Msg  = " ※ 의무사용량 초과!! \n\n";
        			v_Msg += "    자  재  명 : " + this.ds_grd.getColumn(i,"ITEM_NAME") + "\n";
        			v_Msg += "    의무사용량 : " + this.gfn_toString(this.ds_grd.getColumn(i,"DUTY_QTY"))+ this.ds_grd.getColumn(i,"PO_UOM") + "\n";
        			v_Msg += "    기간신청량 : " + this.gfn_toString(nexacro.toNumber(this.ds_grd.getColumn(i,"REAL_USE_QTY")) + nexacro.toNumber(this.ds_grd.getColumn(i,"PR_QTY")))+ this.ds_grd.getColumn(i,"PO_UOM");
        			
        			application.goMain.gfn_Msg("OK", "알림", v_Msg, "OK", "OK");	
        			return false;
        		}
        		else if( (this.ds_grd.getColumn(i,"NEED_DATE") == this.ds_grd.getColumn(i,"DUTY_END_DATE")) && (nexacro.toNumber(this.ds_grd.getColumn(i,"MIN_DUTY_QTY")) > 0) && (nexacro.toNumber(this.ds_grd.getColumn(i,"MIN_DUTY_QTY")) > nexacro.toNumber(this.ds_grd.getColumn(i,"REAL_USE_QTY")) + nexacro.toNumber(this.ds_grd.getColumn(i,"PR_QTY"))) )
        		{

        			v_Msg  = " ※ 의무사용량 미달!! \n\n";
        			v_Msg += "    자  재  명 : " + this.ds_grd.getColumn(i,"ITEM_NAME") + "\n";
        			v_Msg += "    최소의무사용량 : " + this.gfn_toString(this.ds_grd.getColumn(i,"MIN_DUTY_QTY"))+ this.ds_grd.getColumn(i,"PO_UOM") + "\n";
        			v_Msg += "    기간신청량 : " + this.gfn_toString(nexacro.toNumber(this.ds_grd.getColumn(i,"REAL_USE_QTY")) + nexacro.toNumber(this.ds_grd.getColumn(i,"PR_QTY")))+ this.ds_grd.getColumn(i,"PO_UOM");
        			
        			application.goMain.gfn_Msg("OK", "알림", v_Msg, "OK", "OK");	
        			return false;
        		}				
        	} 
        	
        	return true;
        }

        var v_PreOrderMsg;
        this.fn_CheckPreOrder = function ()
        {
        	v_PreOrderMsg = '';

        	var strSvcID,strURL,strInDatasets,strOutDatasets,strArgument,strCallbackFunc;
        	// 경로 설정
        	strSvcID = "FSP00032E_T011";
        	strURL   = application.services[strDataGroup].url + "fs/fsp/FSP00032E_T011.jsp";
        	// 데이터셋 설정
        	strInDatasets = "ds_List=ds_grd";
        	strOutDatasets = "";
        	// 파라메터 설정
        	strArgument  = "";
        	// 콜백함수 지정
        	strCallbackFunc = "";
        	
        	// 트랜잭션 실행
        	this.jsp_transaction(strSvcID,strURL,strInDatasets,strOutDatasets,strArgument,strCallbackFunc,false,false,true); 
        	
        	return v_PreOrderMsg;
        }

        /*******************************************************************************
        * 기      능   : 신청리스트 값 변경시
        * 설      명   : 신청리스트 값 변경시
        ********************************************************************************/
        this.ds_grd_oncolumnchanged = function(obj,e)
        {
        	var strMsg;
        	
        	if(e.columnid != "PR_QTY" && e.columnid != "MARGIN_PRICE") return;
        	
        	if(e.columnid == "PR_QTY")
        	{	
        	
        		//소숫점 발주 제한 점검
        		if(this.ds_grd.getColumn(e.row,"POINT_FLAG") == "N" && Math.ceil(nexacro.toNumber(e.newvalue)) != nexacro.toNumber(e.newvalue))
        		{
        			strMsg = " ※ 소숫점 신청 불가!!\n";
        			strMsg+= "    자재명 : " + this.ds_grd.getColumn(e.row,"ITEM_NAME");
        			application.goMain.gfn_Msg("OK", "알림", strMsg, "OK");
        			this.ds_grd.setColumn(e.row,"PR_QTY",e.oldvalue);
        			return;
        		}
        		//최소발주량 제한 점검
        		else if(nexacro.toNumber(this.ds_grd.getColumn(e.row,"MIN_ORD_QTY")) > 0 && nexacro.toNumber(e.newvalue) < nexacro.toNumber(this.ds_grd.getColumn(e.row,"MIN_ORD_QTY")) )
        		{
        			strMsg = " ※ 최소발주량 이하 신청 불가!!\n";
        			strMsg+= "    자재명     : " + this.ds_grd.getColumn(e.row,"ITEM_NAME") + "\n";
        			strMsg+= "    최소발주량 : " + this.ds_grd.getColumn(e.row,"MIN_ORD_QTY") + "\n";
        			application.goMain.gfn_Msg("OK", "알림", strMsg, "OK");
        			this.ds_grd.setColumn(e.row,"PR_QTY",e.oldvalue);
        			return false;
        		}
        		//최대발주량 제한 점검
        		else if(nexacro.toNumber(this.ds_grd.getColumn(e.row,"MAX_ORD_QTY")) > 0 && nexacro.toNumber(e.newvalue) > nexacro.toNumber(this.ds_grd.getColumn(e.row,"MAX_ORD_QTY")) )
        		{
        			strMsg = " ※ 최대발주량 이상 신청 불가!!\n";
        			strMsg+= "    자재명     : " + this.ds_grd.getColumn(e.row,"ITEM_NAME") + "\n";
        			strMsg+= "    최대발주량 : " + this.ds_grd.getColumn(e.row,"MAX_ORD_QTY") + "\n";
        			application.goMain.gfn_Msg("OK", "알림", strMsg, "OK");
        			this.ds_grd.setColumn(e.row,"PR_QTY",e.oldvalue);
        			return;
        		}
        		//발주승수량 제한 점검
        		else if(nexacro.toNumber(this.ds_grd.getColumn(nRow,"MULTIPLIER_QTY")) != 0)
        		{
        			var nMqty = nexacro.toNumber(this.ds_grd.getColumn(nRow,"MULTIPLIER_QTY"));
        			var nRt = e.newvalue - (Math.floor(e.newvalue / nMqty) * nMqty)
        			
        			if(nRt != 0)
        			{
        				strMsg  = " ※ 발주승수량 이외 신청 불가!!\n";
        				strMsg += "     자재명       : " + this.ds_grd.getColumn(e.row,"ITEM_NAME") + "\n";
        				strMsg += "     발주승수량 : "  + this.ds_grd.getColumn(e.row,"MULTIPLIER_QTY") + "\n";

        				application.goMain.gfn_Msg("OK", "알림", strMsg, "OK");
        				return;
        			}
        		}
        	
        		//마이너스 신청 여부 점검
        		if(nexacro.toNumber(e.newvalue) < 0)
        		{
        			strMsg = " ※ (-)수량 신청 신청 불가!!\n";
        			strMsg+= "    자재명 : " + this.ds_grd.getColumn(e.row,"ITEM_NAME");
        		
        			application.goMain.gfn_Msg("OK", "알림", strMsg, "OK");
        			this.ds_grd.setColumn(e.row,"PR_QTY",e.oldvalue);
        			return false;
        		}
        		
        		this.ds_grd.setColumn(e.row, "PR_AMT", nexacro.toNumber(this.ds_grd.getColumn(e.row,"MARGIN_PRICE"))*nexacro.toNumber(e.newvalue));
        	}
        	
        	if(e.columnid == "MARGIN_PRICE")
        	{
        		this.ds_grd.setColumn(e.row, "PR_AMT", nexacro.toNumber(this.ds_grd.getColumn(e.row,"MARGIN_PRICE"))*nexacro.toNumber(e.newvalue));
        	}	
        	
        }

        /*================================================================================
         * 5. UserFunction관련 Script
         *===============================================================================*/
        /*----------------------------------------------------------------------------------------------
         * 설명      : 트랜잭션 콜백 함수 (필수)
         *---------------------------------------------------------------------------------------------*/
        this.fn_CallBackSave = function (errCode,errMsg)
        {
        	this.ds_grd.filter("");
        	
        	if(nexacro.toNumber(errCode) == 0)
        	{
        	
        		if(this.gfn_Length(this.gfn_Trim(fv_PoItemName))!= 0)
        		{
        			var strMsg = "";
        			strMsg = " ※ 수정 불가!! 수정 중 일부 자재 구매 결의됨\n";
        			strMsg+= "    결의된 자재명 : " + fv_PoItemName;
        		    
        			application.goMain.gfn_Msg("OK", "알림", strMsg, "OK", "OK");
        			fv_PoItemName = "";
        			return;		
        		}	
        		if(this.gfn_Length(this.gfn_Trim(fv_closeRamak))!= 0)
        		{
        			var strMsg = "";
        			sMsg = " ※ 신청서 확정 가능시간 초과\n";
        			sMsg+= "    사유 : " + fv_closeRamak;
        		    
        			application.goMain.gfn_Msg("OK", "알림", strMsg, "OK", "OK");
        			fv_closeRamak = "";
        			return;		
        		}	
        		else
        		{
        			application.goMain.gfn_Msg("OK", "알림", "정상적으로 확정(저장)되었습니다.", "OK", "OK");
        			
        			//데이터셋 초기화
        			this.ds_grd.clearData();
        			this.ds_InsItem.clearData();
        			this.ds_condi.clearData();
        			application.gds_marketList.clearData();
        			application.gds_condi.clearData();
        			application.gds_currdate.clearData();
        			
        			this.fn_Btn_con();
        			
        		}
        	}	
        	else
        	{
        		application.goMain.gfn_Msg("error", "알림", "확정(저장) 중 오류가 발생했습니다.\n에러메세지:" + errMsg, "OK", true, this);
        	}
        }

        
        this.fn_CallbackPotype = function (errCode,errMsg)
        {
        	trace("errCode >>>" +errCode);
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
        		case "itemCount":
        		    this.ds_grd.setColumn(this.ds_grd.rowposition, "PR_QTY", rtn);
        			break;
        		case "errorListPop":
        		    this.fn_init();
        			break;	
        	}
        }

        /** Message callback 함수
         * @param
        	id : id
        	rtn : type이 "OK" 일 때는 none
        	type이 "YN" 일 때는 "Y" or "N"
         * @return : 없음
         * @note : Alert 이나 Confirm 메시지의 콜백 함수
         *         gfn_Msg(...) 함수를 사용하여 띄운 창을 닫을 때 호출된다.
         */
        this.msg_callback = function (id,rtn)
        { 
        	//공지사항 콜백
        	if (id == "NOTICE")
        	{
        		//앱종료
        		application.goMain.fn_action("EXIT");		
        	}
        	
        	var nRow = this.ds_grd.rowposition;
        	
        	// 건별로 삭제할 경우
        	if (id == "delete")
        	{
        		if (rtn == "Y") 
        		{
        			this.ds_grd.deleteRow(nRow);
        		    application.gds_marketList.copyData(this.ds_grd);
        		}
        		else
        		{
        			return;
        		}
        	}
        	// 전체삭제할 경우
        	else if (id == "deleteAll")
        	{
        		if (rtn == "Y") 
        		{
        			this.ds_grd.deleteAll();
        			application.gds_marketList.copyData(this.ds_grd);
        		}
        		else
        		{
        			return;
        		}
        	}
        	// 중간저장일경우
        	else if (id == "save")
        	{
        		if (rtn == "Y") 
        		{
        			this.fn_save(application.gds_dsPoLineStatus.getColumn(0,"PRSave"));
        		}
        		else
        		{
        			return;
        		}
        	}	
        	// 확정일경우
        	else if (id == "confirm")
        	{
        		if (rtn == "Y") 
        		{
        			this.fn_save(application.gds_dsPoLineStatus.getColumn(0,"PRFix"));
        		}
        		else
        		{
        			return;
        		}
        	}	
        	// 저장도중 에러
        	else if (id == "error")
        	{	
        		trace(this.ds_save_out.saveXML("this.ds_save_out >>>", "V"));
        		if(this.ds_save_out.rowcount > 0)
        		{
        			// 자재유효성체크에서 걸린 리스트
        			var arg = new Array();					
        	
        			application.goMain.gfn_POP_create("errorListPop", "M_MOM::AdditionOrderErrorListPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        		}	
        	}	
        	
        }

        this.div_shoppingBasket_grd_list_onslide = function(obj,e)
        {	
        	if (e.yaccvalue > 0)
        	{
        		if ( this.parent.parent.divBottom.visible == false)
        		{
        			this.parent.parent.divBottom.set_visible(true);
          
        			this.parent.parent.divMain.set_height(833);
        			this.parent.parent.divBottom.bringToFront();
        		}
        		// 검색 영역 컨트롤
          
        		if ( this.div_search.visible == false)
        		{
        			this.div_search.set_visible(true);
        			this.grd_list.setOffsetTop(this.div_search.getOffsetBottom());
        		}
        	}
        	else if (e.yaccvalue < 0)
        	{
        		if (this.ds_grd.getRowCount() > 0)
        		{
        			if ( this.parent.parent.divBottom.visible == true)
        			{
        				this.parent.parent.divBottom.set_visible(false);
        				this.parent.parent.divMain.set_height(923);
        			}
        			// 검색 영역 컨트롤
        			if ( this.div_search.visible == true)
        			{
        				this.div_search.set_visible(false);
        				this.grd_list.setOffsetTop(this.sta_upjang.getOffsetBottom());
        			}
        		}		
        	}
        }

        this.div_shoppingBasket_grd_list_onvscroll = function(obj,e)
        {
        	// div안의 스크롤 컨트롤일 경우 btnGoTop 대신 btnGoTopDiv 사용
        	if (e.pos == 0)
        	{
        		this.parent.btnGoTopDiv.set_visible(false);
        	}
        	
        	if (this.parent.btnGoTopDiv.visible == false )
        	{
        		this.parent.btnGoTopDiv.set_visible(true);
        	}		
        }

        // div안의 스크롤바 조정일 경우 아래 함수 추가
        this.fn_setDivScrollbar = function()
        {
        	// 해당 div로 바꿔준다.
        	this.grd_list.vscrollbar.set_pos(0);
        	// 검색 영역 컨트롤
        	this.div_search.set_visible(true);
        	this.grd_list.setOffsetTop(this.div_search.getOffsetBottom());
        }

        
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.ds_grd.addEventHandler("oncolumnchanged", this.ds_grd_oncolumnchanged, this);
            this.addEventHandler("onload", this.form_onload, this);
            this.Static68.addEventHandler("onclick", this.Static68_onclick, this);
            this.Static21.addEventHandler("onclick", this.Static68_onclick, this);
            this.div_search.btn_confirm.addEventHandler("onclick", this.Common_Btn_common_OnClick, this);
            this.div_search.btn_save.addEventHandler("onclick", this.Common_Btn_common_OnClick, this);
            this.div_search.btn_allDelete.addEventHandler("onclick", this.div_search_btn_allDelete_onclick, this);
            this.div_search.btn_search.addEventHandler("onclick", this.Common_Btn_common_OnClick, this);
            this.grd_list.addEventHandler("onvscroll", this.div_shoppingBasket_grd_list_onvscroll, this);
            this.grd_list.addEventHandler("oncellclick", this.grd_list_oncellclick, this);
            this.grd_list.addEventHandler("oncelldblclick", this.grd_list_oncelldblclick, this);
            this.grd_list.addEventHandler("onslide", this.div_shoppingBasket_grd_list_onslide, this);

        };

        this.loadIncludeScript("ShoppingBasket.xfdl", true);

       
    };
}
)();