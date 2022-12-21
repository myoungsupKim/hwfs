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
                this.set_name("productOrder");
                this.set_titletext("상품발주");
                this._setFormPosition(0,0,540,760);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_storageCd", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"256\"/><Column id=\"cdNm\" type=\"STRING\" size=\"256\"/><Column id=\"subinvNameDisp\" type=\"STRING\" size=\"256\"/><Column id=\"subinvNameDisp2\" type=\"STRING\" size=\"256\"/><Column id=\"stockYn\" type=\"STRING\" size=\"256\"/><Column id=\"consumYn\" type=\"STRING\" size=\"256\"/><Column id=\"taxCode\" type=\"STRING\" size=\"256\"/><Column id=\"subinvClass\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_bookmarkCd", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"FAVOR_GROUP\" type=\"STRING\" size=\"256\"/><Column id=\"FAVOR_NAME\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_Days", this);
            obj._setContents("<ColumnInfo><Column id=\"D_DAYS\" size=\"22\" type=\"INT\"/><Column id=\"D_TIMES\" size=\"4\" type=\"STRING\"/><Column id=\"DAYS\" size=\"50\" type=\"STRING\"/><Column id=\"D_OVER_DAYS\" size=\"22\" type=\"INT\"/><Column id=\"QTY_CONTROL_YN\" size=\"1\" type=\"STRING\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_List", this);
            obj._setContents("<ColumnInfo><Column id=\"CENTER_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"CENTER_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"CLS_STATUS\" type=\"STRING\" size=\"256\"/><Column id=\"CUSTCD\" type=\"STRING\" size=\"256\"/><Column id=\"INVAT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_SIZE\" type=\"STRING\" size=\"256\"/><Column id=\"LINE_STATUS\" type=\"STRING\" size=\"256\"/><Column id=\"MARGIN_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"MIN_ORD_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"MAX_ORD_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"MULTIPLIER_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"NEED_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"OTCUSTCD\" type=\"STRING\" size=\"256\"/><Column id=\"OUTVAT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"PO_UOM\" type=\"STRING\" size=\"256\"/><Column id=\"POINT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"PR_ID\" type=\"STRING\" size=\"256\"/><Column id=\"PR_NUM\" type=\"STRING\" size=\"256\"/><Column id=\"PR_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"PR_REMARK\" type=\"STRING\" size=\"256\"/><Column id=\"PR_UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"RC_UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"SALE_AMOUNT\" type=\"STRING\" size=\"256\"/><Column id=\"SALE_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"SUBINV_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"TAX_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"UNIT_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"OP_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"OP_AMOUNT\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAYS\" type=\"STRING\" size=\"256\"/><Column id=\"D_TIMES\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAY_DISP\" type=\"STRING\" size=\"256\"/><Column id=\"IMAGE_PATH\" type=\"STRING\" size=\"256\"/><Column id=\"OP_AMOUNT_OLD\" type=\"STRING\" size=\"256\"/><Column id=\"DOCU_SOURCE\" type=\"STRING\" size=\"256\"/><Column id=\"KEEPING_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"APPLY_SD\" type=\"STRING\" size=\"256\"/><Column id=\"VD_SN\" type=\"STRING\" size=\"256\"/><Column id=\"MOBILE_GUBUN\" type=\"STRING\" size=\"256\"/><Column id=\"ORIGIN_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"MAX_SO_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"UPJANG_GRP\" type=\"STRING\" size=\"256\"/><Column id=\"OP_RATE\" type=\"STRING\" size=\"256\"/><Column id=\"APPROVE_NUM\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_List1", this);
            obj._setContents("<ColumnInfo><Column id=\"CENTER_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"CENTER_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"CLS_STATUS\" type=\"STRING\" size=\"256\"/><Column id=\"CUSTCD\" type=\"STRING\" size=\"256\"/><Column id=\"INVAT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_SIZE\" type=\"STRING\" size=\"256\"/><Column id=\"LINE_STATUS\" type=\"STRING\" size=\"256\"/><Column id=\"MARGIN_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"MIN_ORD_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"MAX_ORD_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"MULTIPLIER_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"NEED_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"OTCUSTCD\" type=\"STRING\" size=\"256\"/><Column id=\"OUTVAT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"PO_UOM\" type=\"STRING\" size=\"256\"/><Column id=\"POINT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"PR_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"PR_REMARK\" type=\"STRING\" size=\"256\"/><Column id=\"PR_UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"RC_UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"SALE_AMOUNT\" type=\"STRING\" size=\"256\"/><Column id=\"SALE_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"SUBINV_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"TAX_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"UNIT_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"OP_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"OP_AMOUNT\" type=\"STRING\" size=\"256\"/><Column id=\"OP_AMOUNT_OLD\" type=\"STRING\" size=\"256\"/><Column id=\"G_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAYS\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAY_DISP\" type=\"STRING\" size=\"256\"/><Column id=\"D_TIMES\" type=\"STRING\" size=\"256\"/><Column id=\"OTCUSTNM\" type=\"STRING\" size=\"256\"/><Column id=\"KG_CONVERT_RATE\" type=\"STRING\" size=\"256\"/><Column id=\"FEATURE_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"IMAGE_PATH\" type=\"STRING\" size=\"256\"/><Column id=\"LIMIT_ITEM\" type=\"STRING\" size=\"256\"/><Column id=\"LIMIT_REASON\" type=\"STRING\" size=\"256\"/><Column id=\"WEEK_ITEM_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"CONSUM_YN\" type=\"STRING\" size=\"256\"/><Column id=\"IMAGE_YN\" type=\"STRING\" size=\"256\"/><Column id=\"KEEPING_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"APPLY_SD\" type=\"STRING\" size=\"256\"/><Column id=\"VD_SN\" type=\"STRING\" size=\"256\"/><Column id=\"ORIGIN_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"MOBILE_GUBUN\" type=\"STRING\" size=\"256\"/><Column id=\"MAX_SO_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"CART_IMG\" type=\"STRING\" size=\"256\"/><Column id=\"UPJANG_GRP\" type=\"STRING\" size=\"256\"/><Column id=\"FEATURE_ICON\" type=\"STRING\" size=\"256\"/><Column id=\"OP_RATE\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_OrdCtrl", this);
            obj._setContents("<ColumnInfo><Column id=\"CTRL_TYPE\" size=\"50\" type=\"STRING\"/><Column id=\"FRI\" size=\"1\" type=\"STRING\"/><Column id=\"ITEM_TYPE\" size=\"50\" type=\"STRING\"/><Column id=\"MON\" size=\"1\" type=\"STRING\"/><Column id=\"SAT\" size=\"1\" type=\"STRING\"/><Column id=\"SUN\" size=\"1\" type=\"STRING\"/><Column id=\"THU\" size=\"1\" type=\"STRING\"/><Column id=\"TUE\" size=\"1\" type=\"STRING\"/><Column id=\"WED\" size=\"1\" type=\"STRING\"/><Column id=\"CHK_TYPE\" size=\"100\" type=\"STRING\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_CrdInfo", this);
            obj._setContents("<ColumnInfo><Column id=\"CREDIT_AMOUNT\" size=\"22\" prop=\"default\" type=\"BIGDECIMAL\"/><Column id=\"CREDIT_AMOUNT_CONTROL_YN\" size=\"1\" prop=\"default\" type=\"STRING\"/><Column id=\"CREDIT_AMOUNT_TOT\" size=\"22\" prop=\"default\" type=\"BIGDECIMAL\"/><Column id=\"CREDIT_AVAIL_AMT\" size=\"22\" prop=\"default\" type=\"BIGDECIMAL\"/><Column id=\"CREDIT_EXT_AMOUNT\" size=\"22\" prop=\"default\" type=\"BIGDECIMAL\"/><Column id=\"CREDIT_EXT_DAYS\" size=\"22\" prop=\"default\" type=\"BIGDECIMAL\"/><Column id=\"CREDIT_OVER_AMOUNT\" size=\"22\" prop=\"default\" type=\"BIGDECIMAL\"/><Column id=\"CREDIT_RMN_AMT\" size=\"22\" prop=\"default\" type=\"BIGDECIMAL\"/><Column id=\"CREDIT_TURN_CONTROL_YN\" size=\"1\" prop=\"default\" type=\"STRING\"/><Column id=\"CREDIT_TURN_DAYS\" size=\"22\" prop=\"default\" type=\"BIGDECIMAL\"/><Column id=\"CREDIT_TURN_DAYS_TOT\" size=\"22\" prop=\"default\" type=\"BIGDECIMAL\"/><Column id=\"L_BILL_DATE\" size=\"8\" prop=\"default\" type=\"STRING\"/><Column id=\"L_BILL_DATE_DISP\" size=\"50\" prop=\"default\" type=\"STRING\"/><Column id=\"LAST_TURN_CNT\" size=\"22\" prop=\"default\" type=\"BIGDECIMAL\"/><Column id=\"PO_AMT\" size=\"22\" prop=\"default\" type=\"BIGDECIMAL\"/><Column id=\"PR_AMT\" size=\"22\" prop=\"default\" type=\"BIGDECIMAL\"/><Column id=\"RMN_AMT\" size=\"22\" prop=\"default\" type=\"BIGDECIMAL\"/><Column id=\"TR_AMT\" size=\"22\" prop=\"default\" type=\"BIGDECIMAL\"/><Column id=\"BOND_AMT\" size=\"22\" prop=\"default\" type=\"BIGDECIMAL\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_Cond", this);
            obj._setContents("<ColumnInfo><Column id=\"ITEM_NAME\" size=\"100\" type=\"STRING\"/><Column id=\"NEED_DATE\" size=\"8\" type=\"STRING\"/><Column id=\"UPJANG\" size=\"22\" type=\"INT\"/><Column id=\"SUBINV_CODE\" size=\"8\" type=\"STRING\"/><Column id=\"CONSUM_YN\" size=\"1\" type=\"STRING\"/><Column id=\"QTY_CONTROL_YN\" size=\"1\" type=\"STRING\"/><Column id=\"CENTER_CODE\" size=\"22\" type=\"INT\"/><Column id=\"AP_UNITPRICE_UPJANG\" size=\"22\" type=\"INT\"/><Column id=\"OTCUST_PRICE_UPJANG\" size=\"22\" type=\"INT\"/><Column id=\"FAVOR_GROUP\" size=\"50\" type=\"STRING\"/><Column id=\"NEED_DATEP\" size=\"8\" type=\"STRING\"/><Column id=\"UPJANGP\" size=\"22\" type=\"INT\"/><Column id=\"SUBINV_CODEP\" size=\"8\" type=\"STRING\"/><Column id=\"ITEM_CLASS2\" size=\"8\" type=\"STRING\"/><Column id=\"ITEM_CLASS3\" size=\"8\" type=\"STRING\"/><Column id=\"ITEM_CLASS4\" size=\"8\" type=\"STRING\"/><Column id=\"ITEM_CODE\" size=\"256\" type=\"STRING\"/><Column id=\"UPJANG_NM\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_CtUpj", this);
            obj._setContents("<ColumnInfo><Column id=\"AP_UNITPRICE_UPJANG\" size=\"22\" type=\"INT\"/><Column id=\"CENTER_CODE\" size=\"22\" type=\"INT\"/><Column id=\"OTCUST_PRICE_UPJANG\" size=\"22\" type=\"INT\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_List2", this);
            obj._setContents("<ColumnInfo><Column id=\"CENTER_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"CENTER_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"CLS_STATUS\" type=\"STRING\" size=\"256\"/><Column id=\"CUSTCD\" type=\"STRING\" size=\"256\"/><Column id=\"INVAT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_SIZE\" type=\"STRING\" size=\"256\"/><Column id=\"LINE_STATUS\" type=\"STRING\" size=\"256\"/><Column id=\"MARGIN_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"MIN_ORD_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"MAX_ORD_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"MULTIPLIER_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"NEED_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"OTCUSTCD\" type=\"STRING\" size=\"256\"/><Column id=\"OUTVAT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"PO_UOM\" type=\"STRING\" size=\"256\"/><Column id=\"POINT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"PR_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"PR_REMARK\" type=\"STRING\" size=\"256\"/><Column id=\"PR_UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"RC_UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"SALE_AMOUNT\" type=\"STRING\" size=\"256\"/><Column id=\"SALE_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"SUBINV_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"TAX_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"UNIT_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"OP_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"OP_AMOUNT\" type=\"STRING\" size=\"256\"/><Column id=\"OP_AMOUNT_OLD\" type=\"STRING\" size=\"256\"/><Column id=\"G_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAYS\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAY_DISP\" type=\"STRING\" size=\"256\"/><Column id=\"D_TIMES\" type=\"STRING\" size=\"256\"/><Column id=\"OTCUSTNM\" type=\"STRING\" size=\"256\"/><Column id=\"KG_CONVERT_RATE\" type=\"STRING\" size=\"256\"/><Column id=\"FEATURE_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"IMAGE_PATH\" type=\"STRING\" size=\"256\"/><Column id=\"LIMIT_ITEM\" type=\"STRING\" size=\"256\"/><Column id=\"LIMIT_REASON\" type=\"STRING\" size=\"256\"/><Column id=\"WEEK_ITEM_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"CONSUM_YN\" type=\"STRING\" size=\"256\"/><Column id=\"IMAGE_YN\" type=\"STRING\" size=\"256\"/><Column id=\"KEEPING_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"APPLY_SD\" type=\"STRING\" size=\"256\"/><Column id=\"VD_SN\" type=\"STRING\" size=\"256\"/><Column id=\"ORIGIN_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"MOBILE_GUBUN\" type=\"STRING\" size=\"256\"/><Column id=\"MAX_SO_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"CART_IMG\" type=\"STRING\" size=\"256\"/><Column id=\"UPJANG_GRP\" type=\"STRING\" size=\"256\"/><Column id=\"FEATURE_ICON\" type=\"STRING\" size=\"256\"/><Column id=\"OP_RATE\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_WeekendTime", this);
            obj._setContents("<ColumnInfo><Column id=\"CODE\" type=\"STRING\" size=\"256\"/><Column id=\"CODE_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"USE_YN\" type=\"STRING\" size=\"256\"/><Column id=\"SET1\" type=\"STRING\" size=\"256\"/><Column id=\"SET2\" type=\"STRING\" size=\"256\"/><Column id=\"SET3\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
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
            obj = new Button("btn_productOrder", "absolute", "0", "0", "270", "63", null, null, this);
            obj.set_taborder("34");
            obj.set_text("상품발주");
            obj.set_cssclass("btn_WF_TabMFOn");
            this.addChild(obj.name, obj);

            obj = new Button("btn_productOrderBookMark", "absolute", "270", "0", "270", "63", null, null, this);
            obj.set_taborder("88");
            obj.set_text("즐겨찾기");
            obj.set_cssclass("btn_WF_TabMFOff");
            this.addChild(obj.name, obj);

            obj = new Div("div_productOrder", "absolute", "0", "62", "540", null, null, "0", this);
            obj.set_taborder("91");
            obj.style.set_background("white");
            this.addChild(obj.name, obj);
            obj = new Div("div_search", "absolute", "0", "58", null, "172", "0", null, this.div_productOrder);
            obj.set_taborder("17");
            this.div_productOrder.addChild(obj.name, obj);
            obj = new Static("Static04", "absolute", "0", "0", null, "59", "0", null, this.div_productOrder.div_search);
            obj.set_taborder("30");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.div_productOrder.div_search.addChild(obj.name, obj);
            obj = new Static("Static22", "absolute", "0", "58", null, "59", "0", null, this.div_productOrder.div_search);
            obj.set_taborder("31");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.div_productOrder.div_search.addChild(obj.name, obj);
            obj = new Button("btn_search", "absolute", "430", "64", null, "47", "10", null, this.div_productOrder.div_search);
            obj.set_taborder("32");
            obj.set_cssclass("btn_WF_Search");
            obj.set_text("검색");
            this.div_productOrder.div_search.addChild(obj.name, obj);
            obj = new Combo("cbo_storage", "absolute", "10", "6", null, "47", "239", null, this.div_productOrder.div_search);
            this.div_productOrder.div_search.addChild(obj.name, obj);
            obj.set_taborder("33");
            obj.set_displaynulltext("식당 선택");
            obj.set_innerdataset("@ds_storageCd");
            obj.set_codecolumn("cd");
            obj.set_datacolumn("cdNm");
            obj.set_index("-1");
            obj = new Calendar("cal_dtFrom", "absolute", "73", "64", null, "47", "287", null, this.div_productOrder.div_search);
            this.div_productOrder.div_search.addChild(obj.name, obj);
            obj.set_taborder("34");
            obj.set_displaynulltext("2015-12-29");
            obj.set_dateformat("yyyy-MM-dd");
            obj = new Static("Static24", "absolute", "0", "58", null, "59", "478", null, this.div_productOrder.div_search);
            obj.set_taborder("35");
            obj.set_text("입고\r\n일자");
            obj.set_cssclass("sta_WF_Label02");
            obj.style.set_padding("0 0 0 20");
            obj.style.set_font("bold antialias 15 Droid Sans");
            this.div_productOrder.div_search.addChild(obj.name, obj);
            obj = new Static("Static25", "absolute", "62", "58", null, "59", "466", null, this.div_productOrder.div_search);
            obj.set_taborder("36");
            obj.set_text("글자사이간격w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.div_productOrder.div_search.addChild(obj.name, obj);
            obj = new Edit("edt_itemNm", "absolute", "306", "6", null, "47", "10", null, this.div_productOrder.div_search);
            obj.set_taborder("37");
            obj.set_displaynulltext("상품명 검색");
            obj.set_imemode("hangul");
            obj.set_autoselect("true");
            this.div_productOrder.div_search.addChild(obj.name, obj);
            obj = new Static("Static33", "absolute", "301", "12", null, "29", "234", null, this.div_productOrder.div_search);
            obj.set_taborder("38");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.div_productOrder.div_search.addChild(obj.name, obj);
            obj = new Edit("edt_credit", "absolute", "10", "121", null, "47", "304", null, this.div_productOrder.div_search);
            obj.set_taborder("39");
            obj.style.set_align("right middle");
            obj.set_readonly("true");
            obj.set_enable("false");
            this.div_productOrder.div_search.addChild(obj.name, obj);
            obj = new Edit("edt_bond", "absolute", "599", "121", null, "47", "-172", null, this.div_productOrder.div_search);
            obj.set_taborder("40");
            obj.set_visible("false");
            this.div_productOrder.div_search.addChild(obj.name, obj);
            obj = new Static("sta_week", "absolute", "252", "116", "45", "34", null, null, this.div_productOrder.div_search);
            obj.set_taborder("41");
            obj.set_text("(월)");
            obj.style.set_font("bold antialias 14 arial");
            this.div_productOrder.div_search.addChild(obj.name, obj);
            obj = new Static("sta_days", "absolute", "308", "119", "229", "26", null, null, this.div_productOrder.div_search);
            obj.set_taborder("42");
            obj.set_text("(발주마감 : D-0 00시)");
            obj.style.set_font("bold antialias 14 arial");
            this.div_productOrder.div_search.addChild(obj.name, obj);
            obj = new Static("sta_timer", "absolute", "253", "145", "294", "25", null, null, this.div_productOrder.div_search);
            obj.set_taborder("43");
            obj.set_text("마감시간 : 00일 00시간 00분 전");
            obj.style.set_font("bold antialias 14 arial");
            this.div_productOrder.div_search.addChild(obj.name, obj);
            obj = new Combo("cbo_bookmark", "absolute", "306", "38", null, "47", "10", null, this.div_productOrder.div_search);
            this.div_productOrder.div_search.addChild(obj.name, obj);
            obj.set_taborder("44");
            obj.set_displaynulltext("즐겨찾기그룹");
            obj.set_innerdataset("@ds_bookmarkCd");
            obj.set_codecolumn("FAVOR_GROUP");
            obj.set_datacolumn("FAVOR_NAME");
            obj.set_visible("false");
            obj.set_index("-1");
            obj = new Static("sta_dtFrom", "absolute", "73", "64", "180", "47", null, null, this.div_productOrder.div_search);
            obj.set_taborder("45");
            this.div_productOrder.div_search.addChild(obj.name, obj);
            obj = new Static("Static00", "absolute", "253", "74", "5", "29", null, null, this.div_productOrder.div_search);
            obj.set_taborder("46");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.div_productOrder.div_search.addChild(obj.name, obj);
            obj = new Grid("grd_list", "absolute", "0", "229", null, null, "1", "0", this.div_productOrder);
            obj.set_cssclass("grd_WF_Default2");
            obj.set_taborder("18");
            obj.set_binddataset("ds_List1");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"8\"/><Column size=\"239\"/><Column size=\"115\"/><Column size=\"110\"/><Column size=\"66\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"53\"/><Row size=\"50\"/><Row size=\"53\"/><Row size=\"3\"/></Rows><Band id=\"head\"><Cell text=\"Column1\"/><Cell col=\"1\" text=\"Column0\"/><Cell col=\"2\"/><Cell col=\"3\"/><Cell col=\"4\"/></Band><Band id=\"body\"><Cell displaytype=\"normal\" style=\"line:0 none #808080ff ;selectbackground:ghostwhite;\"/><Cell col=\"1\" colspan=\"2\" style=\"align:left bottom;padding:EXPR(FEATURE_ICON == undefined ?&quot;'0 10 0 0&quot; :&quot;'0 10 0 65&quot;);line:0 solid #808080ff ;background:transparent left bottom;background2:transparent left bottom;selectbackground:ghostwhite left bottom;backgroundimage:BIND(FEATURE_ICON);\" text=\"bind:ITEM_NAME\" wordwrap=\"char\"/><Cell col=\"3\" rowspan=\"2\" displaytype=\"number\" edittype=\"none\" style=\"align:right middle;padding:53 0 0 0;line:0 solid #808080ff ;selectbackground:ghostwhite;\" text=\"bind:PR_QTY\" mask=\"#,##0.0#\" maskchar=\" \" editdisplay=\"display\"/><Cell col=\"4\" rowspan=\"2\" displaytype=\"button\" edittype=\"button\" style=\"padding:53 6 0 6;line:0 solid transparent ;selectbackground:ghostwhite;controlbackground:BIND(CART_IMG);controlborder:0 solid #808080ff ;\" calendardisplay=\"edit\"/><Cell row=\"1\" displaytype=\"image\" style=\"line:0 none #808080ff ;selectbackground:ghostwhite;\"/><Cell row=\"1\" col=\"1\" style=\"align:left middle;padding:0 10 0 0;line:0 none #808080ff ;color:blue;color2:blue;selectbackground:ghostwhite;selectcolor:blue;\" text=\"bind:ITEM_CODE\" wordwrap=\"char\"/><Cell row=\"1\" col=\"2\" displaytype=\"number\" style=\"align:right middle;padding:0 10 0 10;line:0 solid #808080ff ;color:red;color2:red;selectbackground:ghostwhite;selectcolor:red;\" text=\"bind:OP_PRICE\" mask=\"###,###,###.##\"/><Cell row=\"2\" style=\"line:0 solid #808080ff ;selectbackground:ghostwhite;\"/><Cell row=\"2\" col=\"1\" style=\"align:left top;padding:0 10 0 0;line:0 solid #808080ff ;selectbackground:ghostwhite;\" text=\"bind:ITEM_SIZE\" wordwrap=\"char\"/><Cell row=\"2\" col=\"2\" style=\"align:right top;padding:0 10 0 10;line:0 solid #808080ff ;selectbackground:ghostwhite;\" text=\"bind:PO_UOM\" wordwrap=\"char\"/><Cell row=\"2\" col=\"3\" style=\"line:0 solid #808080ff ;selectbackground:ghostwhite;\"/><Cell row=\"2\" col=\"4\" style=\"line:0 solid #808080ff ;selectbackground:ghostwhite;\"/><Cell row=\"3\"/><Cell row=\"3\" col=\"1\"/><Cell row=\"3\" col=\"2\"/><Cell row=\"3\" col=\"3\"/><Cell row=\"3\" col=\"4\"/></Band></Format></Formats>");
            this.div_productOrder.addChild(obj.name, obj);
            obj = new Static("Static00", "absolute", "0", "0", null, "59", "1", null, this.div_productOrder);
            obj.set_taborder("26");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.div_productOrder.addChild(obj.name, obj);
            obj = new Edit("edt_upjang", "absolute", "10", "6", null, "47", "11", null, this.div_productOrder);
            obj.set_taborder("27");
            obj.set_displaynulltext("사업장을 입력하세요");
            obj.set_readonly("true");
            obj.set_autoselect("true");
            this.div_productOrder.addChild(obj.name, obj);
            obj = new Button("btn_upjang", "absolute", null, "6", "47", "47", "12", null, this.div_productOrder);
            obj.set_taborder("28");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.div_productOrder.addChild(obj.name, obj);
            obj = new Grid("grd_list2", "absolute", "0", "333", null, null, "1", "0", this.div_productOrder);
            obj.set_cssclass("grd_WF_Default2");
            obj.set_taborder("29");
            obj.set_binddataset("ds_List2");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_visible("false");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"8\"/><Column size=\"236\"/><Column size=\"118\"/><Column size=\"110\"/><Column size=\"66\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"53\"/><Row size=\"50\"/><Row size=\"53\"/><Row size=\"3\"/></Rows><Band id=\"head\"><Cell text=\"Column1\"/><Cell col=\"1\" text=\"Column0\"/><Cell col=\"2\"/><Cell col=\"3\"/><Cell col=\"4\"/></Band><Band id=\"body\"><Cell displaytype=\"normal\" style=\"line:0 none #808080ff ;selectbackground:ghostwhite;\"/><Cell col=\"1\" colspan=\"2\" style=\"align:left bottom;padding:EXPR(FEATURE_ICON == undefined ?&quot;'0 10 0 0&quot; :&quot;'0 10 0 65&quot;);line:0 solid #808080ff ;background:transparent left bottom;background2:transparent left bottom;selectbackground:ghostwhite left bottom;backgroundimage:BIND(FEATURE_ICON);\" text=\"bind:ITEM_NAME\" wordwrap=\"char\"/><Cell col=\"3\" rowspan=\"2\" displaytype=\"number\" edittype=\"none\" style=\"align:right middle;padding:53 0 0 0;line:0 solid #808080ff ;selectbackground:ghostwhite;\" text=\"bind:PR_QTY\" mask=\"#,##0.0#\" maskchar=\" \" editdisplay=\"display\"/><Cell col=\"4\" rowspan=\"2\" displaytype=\"button\" edittype=\"button\" style=\"padding:53 6 0 6;line:0 solid transparent ;selectbackground:ghostwhite;controlbackground:BIND(CART_IMG);controlborder:0 solid #808080ff ;\" calendardisplay=\"edit\"/><Cell row=\"1\" displaytype=\"image\" style=\"line:0 none #808080ff ;selectbackground:ghostwhite;\"/><Cell row=\"1\" col=\"1\" style=\"align:left middle;padding:0 10 0 0;line:0 none #808080ff ;color:blue;color2:blue;selectbackground:ghostwhite;selectcolor:blue;\" text=\"bind:ITEM_CODE\" wordwrap=\"char\"/><Cell row=\"1\" col=\"2\" displaytype=\"number\" style=\"align:right middle;padding:0 10 0 10;line:0 solid #808080ff ;color:red;color2:red;selectbackground:ghostwhite;selectcolor:red;\" text=\"bind:OP_PRICE\" mask=\"###,###,###.##\"/><Cell row=\"2\" style=\"line:0 solid #808080ff ;selectbackground:ghostwhite;\"/><Cell row=\"2\" col=\"1\" style=\"align:left top;padding:0 10 0 0;line:0 solid #808080ff ;selectbackground:ghostwhite;\" text=\"bind:ITEM_SIZE\" wordwrap=\"char\"/><Cell row=\"2\" col=\"2\" style=\"align:right top;padding:0 10 0 10;line:0 solid #808080ff ;selectbackground:ghostwhite;\" text=\"bind:PO_UOM\" wordwrap=\"char\"/><Cell row=\"2\" col=\"3\" style=\"line:0 solid #808080ff ;selectbackground:ghostwhite;\"/><Cell row=\"2\" col=\"4\" style=\"line:0 solid #808080ff ;selectbackground:ghostwhite;\"/><Cell row=\"3\"/><Cell row=\"3\" col=\"1\"/><Cell row=\"3\" col=\"2\"/><Cell row=\"3\" col=\"3\"/><Cell row=\"3\" col=\"4\"/></Band></Format></Formats>");
            this.div_productOrder.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "573", "408", "417", "35", null, null, this);
            obj.set_taborder("92");
            obj.set_text("즐겨찾기_GRID");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "485", "423", "76", "2", null, null, this);
            obj.set_taborder("93");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static14", "absolute", "485", "311", "71", "2", null, null, this);
            obj.set_taborder("94");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "571", "296", "417", "35", null, null, this);
            obj.set_taborder("95");
            obj.set_text("상품발주_GRID");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 0, 172, this.div_productOrder.div_search,
            	//-- Layout function
            	function(p) {
            		p.set_taborder("17");

            	}
            );
            this.div_productOrder.div_search.addLayout(obj.name, obj);

            //-- Default Layout
            obj = new Layout("default", "", 540, 0, this.div_productOrder,
            	//-- Layout function
            	function(p) {
            		p.set_taborder("91");
            		p.style.set_background("white");

            	}
            );
            this.div_productOrder.addLayout(obj.name, obj);

            //-- Default Layout
            obj = new Layout("default", "", 540, 760, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("GUIDE_class");
            		p.set_titletext("상품발주");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("ProductOrder.xfdl", "lib::lib_Com.xjs");
        this.registerScript("ProductOrder.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		발주관리
        // [부시스템명]	상품발주 - 등록, 조회
        // [설명]
        // 		상품발주.
        // [작성자명] 		강대성
        // [작성일자]		2015.02.04
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.04 : 강대성 : 화면생성.
        // 2015.06.22 : 강대성 : 업무로직 수정.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/
        this.preDate = undefined;
        this.upjang = undefined;
        this.gubun = undefined;
        var vRtn = 0;
        var vRtnBookmark = 0;
        var fa_Sql;
        var fa_sDay;
        var fa_DocSrc = '07 FM(모바일)';
        var fa_DocSrc1 = '07 FM';             //구 푸드엠 주문내용  ---> 상품발주로 간주
        var fa_DocSrc2 = '01 BO';             //아이리스 주문내용   ---> 상품발주로 간주
        var fa_DocSrc3 = '07 FM(상품)';
        var pre_need_date = this.gfn_AddDate(this.gfn_Today(),1);  				  //날짜 변경전 이전 날짜 기억
        this.subinvCd = undefined;
        this.tabIndex = '1';

        var fa_weekendTimeCheck = "N"; // 주말 발주 통제 여부
        var fa_startTime; // 통제시작시간
        var fa_endTime; // 통제종료시간

        this.fa_Sql = undefined;    //여신정보 콜백시 서비스에서 리턴받는 파라미터 값 변수
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
        	//메세지 공통 코드 호출\
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
        	
        	application.g_System_Mst = "FICS";
        	
        	//trace(application.gds_menu.saveXML());
        		
        	//초기화
        	this.fn_ResetData();
        	
        	this.fsp_init();	
        	
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정
        	//this.fn_SetBtnControl("this.div_productOrder.div_search.btn_search","");
        	
        	// 권한에 따른 버튼 활성화 및 디폴트값 설정
        	//this.fn_SetAuth("this.div_productOrder.edt_upjang", "this.div_productOrder.btn_upjang");
        	
        	this.preDate = this.gfn_Today();
        	this.div_productOrder.div_search.cal_dtFrom.set_value(this.gfn_AddDate(this.preDate, 1));
        	
        	//사업장 세팅
        	this.div_productOrder.edt_upjang.set_value(application.g_UpjangNm);	
        	this.upjang = application.g_Upjang;		
        	
        	//사용자관리화면에서 [여신/공급업체] 항목의 값을 들고와서 
        	//발주가능금액, 채권잔액, 실시간입금확인을 컨트롤 함 - (김진희 2014.02.19)
        	if (application.g_Simple_Po_Yn == "Y") 
        	{
        		//발주가능금액 컨트롤
        		this.div_productOrder.div_search.edt_credit.set_visible(true);		
        	}	
        	else 
        	{
        		//발주가능금액 컨트롤
        		this.div_productOrder.div_search.edt_credit.set_visible(false);		
        	}
        	
        	//기본적으로 사업장은 채권잔액 공개않함. - 이혜은(20130422)
        	if(application.g_UserKind == "사업장")
        	{
        		this.div_productOrder.div_search.edt_credit.set_visible(false);		
        	}	
        	
        	// FICS 발주제한요일, 시간 설정 조회
        	this.fn_getWeekendTime();
        	
        	//창고 콤보 데이터 호출
        	//this.subInventorySearch();
        			
        	//자동조회
        	//this.fn_search();	
        	
        	switch ( application.gds_menu.lookup("prgId", "ProductOrder", "attr01") ) {
        		case "01" :
        			this.btn_productOrder.click();
        			this.btn_productOrderBookMark.set_text("");
        			this.btn_productOrderBookMark.set_enable(false);
        			break;
        			
        		case"02" :	
        			this.btn_productOrderBookMark.click();
        			this.btn_productOrder.set_text("");
        			this.btn_productOrder.set_enable(false);
        			break;
        			
        		default :
        			break;
        	}
        }

        //데이터셋 초기화
        this.fn_ResetData = function ()
        {
        	this.ds_storageCd.clearData();
        	vRtn = 0;
        	this.div_productOrder.div_search.sta_days.set_text("(발주 마감 : - -)");
        	this.div_productOrder.div_search.sta_timer.set_text("");
        	this.div_productOrder.div_search.edt_credit.set_value("");
        	this.ds_List.clearData();
        	this.ds_List1.clearData();
        	this.ds_List2.clearData();	
        }

        //사업장 검색 팝업
        this.div_productOrder_btn_upjang_onclick = function(obj,e)
        {
        	var arg = new Array();
        	arg[1] = this.upjang;
        	arg[2] = "FMS";	
        	
        	application.goMain.gfn_POP_create("upjangNm", "M_MLM::WorkplaceSearchPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        //창고 콤보조회 검색 팝업
        this.cbo_storage_ondropdown = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_storageCd;
        	arg[1] = "조회조건(창고)";
        	arg[2] = "";
        	arg[3] = "cdNm";
        	application.goMain.gfn_POP_create("Storage", "cmmn::CmmnComboList.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        //즐겨찾기그룹 콤보조회 검색 팝업
        this.cbo_bookmark_ondropdown = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_bookmarkCd;
        	arg[1] = "조회조건(즐겨찾기)";
        	arg[2] = "";
        	arg[3] = "FAVOR_NAME";
        	application.goMain.gfn_POP_create("bookmark", "cmmn::CmmnComboList.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        //그리드 더블 클릭시 상품 상세팝업 호출
        this.grd_list_oncelldblclick = function(obj,e)
        {
        	var arg = new Array();
        	var nRow = e.row;
        	arg[0] = eval("this.ds_List" + this.gfn_toString(this.tabIndex)).getColumn(nRow, "ITEM_NAME");
        	arg[1] = eval("this.ds_List" + this.gfn_toString(this.tabIndex)).getColumn(nRow, "ITEM_SIZE");
        	arg[2] = eval("this.ds_List" + this.gfn_toString(this.tabIndex)).getColumn(nRow, "PO_UOM");
        	arg[3] = eval("this.ds_List" + this.gfn_toString(this.tabIndex)).getColumn(nRow, "KEEPING_TYPE");
        	arg[4] = eval("this.ds_List" + this.gfn_toString(this.tabIndex)).getColumn(nRow, "ORIGIN_TYPE");
        	arg[5] = eval("this.ds_List" + this.gfn_toString(this.tabIndex)).getColumn(nRow, "IMAGE_PATH");
        	
        	application.goMain.gfn_POP_create("", "M_MOM::ProductDetailPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	
        }

        // 달력 클릭 시(From)
        this.sta_dtFrom_onclick = function(obj,e)
        {
        	var objCalArg = this.div_productOrder.div_search.cal_dtFrom.value;
        	
        	application.goMain.gfn_POP_create("PopCalFrom", "cmmn::CmmnCalendarPop.xfdl", "fn_callbackPOP", this, objCalArg, "POP", application.goMain.divBase);
        	return false;
        }

        // tab버튼 동작
        this.btn_tab_onclick = function(obj,e)
        {
        	// bottom영역 초기화
        	this.parent.parent.divBottom.set_visible(true);
        	this.parent.parent.divMain.set_height(833);
        	this.parent.parent.divBottom.bringToFront();
        	// 맨위로 버튼 안보이게
        	this.parent.btnGoTopDiv.set_visible(false);

        	//this.div_productOrder.div_search.edt_itemNm.set_value("");
        	
        	if (obj.name == "btn_productOrder")
        	{
        		//세팅
        		this.btn_productOrder.set_cssclass("btn_WF_TabMFOn");
        		this.btn_productOrderBookMark.set_cssclass("btn_WF_TabMFOff");
        		
        		//보이기
        		this.div_productOrder.div_search.edt_itemNm.setOffsetTop(this.div_productOrder.div_search.cbo_storage.getOffsetTop());
        		this.div_productOrder.div_search.edt_itemNm.setOffsetLeft(this.div_productOrder.div_search.cbo_storage.getOffsetRight()+5);
        		this.div_productOrder.div_search.edt_itemNm.set_right(10);
        		
        		this.div_productOrder.set_visible(true);
        		this.div_productOrder.grd_list.set_visible(true);
        		this.div_productOrder.div_search.edt_itemNm.set_visible(true);
        		
        		this.div_productOrder.Static00.set_visible(true);
        		this.div_productOrder.edt_upjang.set_visible(true);
        		this.div_productOrder.btn_upjang.set_visible(true);
        		
        		this.div_productOrder.bringToFront();
        		
        		this.div_productOrder.div_search.setOffsetTop(this.div_productOrder.Static00.getOffsetBottom());
        		this.div_productOrder.grd_list.setOffsetTop(this.div_productOrder.div_search.getOffsetBottom());
        		//숨기기
        		this.div_productOrder.grd_list2.set_visible(false);
        		this.div_productOrder.div_search.cbo_bookmark.set_visible(false);
        		
        		this.tabIndex = "1"
        	}
        	else if (obj.name == "btn_productOrderBookMark")
        	{	
        		//즐겨찾기그룹호출
        		this.fn_SetFav();
        		
        		//세팅
        		this.btn_productOrder.set_cssclass("btn_WF_TabMFOff");
        		this.btn_productOrderBookMark.set_cssclass("btn_WF_TabMFOn");
        		
        		//보이기
        		this.div_productOrder.div_search.edt_itemNm.setOffsetTop(this.div_productOrder.div_search.sta_dtFrom.getOffsetTop());
        		this.div_productOrder.div_search.edt_itemNm.setOffsetLeft(this.div_productOrder.div_search.sta_dtFrom.getOffsetRight()+5);
        		this.div_productOrder.div_search.edt_itemNm.setOffsetRight(this.div_productOrder.div_search.btn_search.getOffsetLeft()-5);
        		
        		this.div_productOrder.set_visible(true);
        		this.div_productOrder.grd_list2.set_visible(true);
        		this.div_productOrder.grd_list2.set_top(229);
        		this.div_productOrder.div_search.cbo_bookmark.set_visible(true);
        		this.div_productOrder.div_search.cbo_bookmark.set_top(6);
        		
        		this.div_productOrder.Static00.set_visible(true);
        		this.div_productOrder.edt_upjang.set_visible(true);
        		this.div_productOrder.btn_upjang.set_visible(true);
        		
        		this.div_productOrder.bringToFront();
        		
        		this.div_productOrder.div_search.setOffsetTop(this.div_productOrder.Static00.getOffsetBottom());
        		this.div_productOrder.grd_list2.setOffsetTop(this.div_productOrder.div_search.getOffsetBottom());
        		//숨기기
        		this.div_productOrder.grd_list.set_visible(false);
        		//this.div_productOrder.div_search.edt_itemNm.set_visible(false);
        		
        		this.tabIndex = "2"
        	}
        }

        //그리드 cell선택시
        this.grd_list_oncellclick = function(obj,e)
        {
        	/*
        	  주문시점의 업장, 창고, 입고일자를 저장한다.
        	  왜냐하면 주문을 하고 발주내역에 등록이 된 뒤에
        	  날짜를 변경하면 발주된된 데이터에 대해서 
        	  변경을 하겠습니까? 라고 확인메세지를 주는데
        	  여기서 아니오라고 해도 업장과 창고 입고일자는 
        	  바뀌어 버리기 때문에(공통함수라서) 
        	  아니오 일때는 주문시점의 데이터를 다시 불러와야함
        	*/
        	pre_need_date = this.div_productOrder.div_search.cal_dtFrom.value;
        	
        	var nRow = e.row;
        	
        	var prQty = eval("this."+obj.binddataset).getColumn(nRow, "PR_QTY");
        	var opPrice = eval("this."+obj.binddataset).getColumn(nRow, "OP_PRICE");
        	var itemName = eval("this."+obj.binddataset).getColumn(nRow, "ITEM_NAME")	
        	
         	if(e.cell == "2")
         	{
         		var arg = new Array();
         	
         		arg[0] = eval("this."+obj.binddataset).getColumn(nRow, "PR_QTY");
         		arg[1] = eval("this."+obj.binddataset).getColumn(nRow, "ITEM_CODE");
        		arg[2] = eval("this."+obj.binddataset).getColumn(nRow, "ITEM_NAME");
         	
         		application.goMain.gfn_POP_create("itemCount", "cmmn::CmmnInputNumber.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
         		return false;
         	}
        		
        	if(e.cell == "3")
        	{
        		if (eval("this."+obj.binddataset).rowcount < 1) return;
        		if (e.row < 0) return;
        		//리조트 물류스케줄 체크
        		if (!this.gfn_isNull(eval("this."+obj.binddataset).getColumn(e.row,"WEEK_ITEM_CODE")))
        		{
        			application.goMain.gfn_Msg("OK", "알림", "해당 상품은 요일통제 상품입니다!", "OK", "OK");
        			return;
        		}
        		
        		//주문통제체크	
        		if (!this.gfn_isNull(eval("this."+obj.binddataset).getColumnInfo("LIMIT_ITEM"))) {	
        			if (!this.gfn_isNull(eval("this."+obj.binddataset).getColumn(e.row,"LIMIT_ITEM")))
        			{
        				application.goMain.gfn_Msg("OK", "알림", "해당 상품은 주문통제 상품입니다!" + "\n\n" + "통제내용:" + eval(obj.binddataset).getColumn(e.row,"LIMIT_REASON"), "OK", "OK");
        				return;
        			}
        		}
        		
        		//발주마감체크
        		if (this.fn_GetDayStatus(eval("this."+obj.binddataset).getColumn(e.row,"D_DAYS"), eval("this."+obj.binddataset).getColumn(e.row,"D_TIMES")) == "0")
        		{
        			application.goMain.gfn_Msg("OK", "알림", "마감시간이 초과되어 주문이 불가합니다.", "OK", "OK");
        			return;
        		}
        		
        		//창고가 식재/소모품 통합창고인 경우 주문통제 점검
        		if (this.gfn_isNull(this.ds_storageCd.getColumn(vRtn, "consumYn")))
        		{
        			//주문통제(주문일자)
        			var jRow;
        			jRow = this.ds_OrdCtrl.findRowExpr("CTRL_TYPE=='주문'&&ITEM_TYPE==iif('" + eval("this."+obj.binddataset).getColumn(e.row,"CONSUM_YN") + "','Y','소모품','식자재')");
        			if (jRow >= 0)
        			{
        				if (this.ds_OrdCtrl.getColumn(jRow, this.ToUpper(application.gds_currdate.getColumn(0, "WEEK_ENG"))) == "Y")
        				{
        					application.goMain.gfn_Msg("OK", application.gds_currdate.getColumn(0, "WEEK_KOR") + "요일은 " + this.ds_OrdCtrl.getColumn(jRow,"ITEM_TYPE") + " 주문불가 요일입니다.", "OK", "OK");
        					return;
        				}
        			}
        			
        			//주문통제(입고일자)
        			jRow = this.ds_OrdCtrl.findRowExpr("CTRL_TYPE=='입고'&&ITEM_TYPE==iif('" + eval("this."+obj.binddataset).getColumn(e.row,"CONSUM_YN") + "','Y','소모품','식자재')");
        			if (jRow >= 0)
        			{
        				if (this.ds_OrdCtrl.getColumn(jRow, this.ToUpper(this.fn_DayToWeek(this.div_productOrder.div_search.cal_dtFrom.value,"1"))) == "Y")
        				{
        					application.goMain.gfn_Msg("OK", "알림", this.fn_DayToWeek(me_NeedDate.value) + "요일은 " + this.ds_OrdCtrl.getColumn(jRow,"ITEM_TYPE") + " 입고불가 요일입니다." + "\n\n" + "입고예정일을 변경하세요.", "OK", "OK");
        					return;
        				}
        			}
        		}		
        		
        		//application.goMain.gfn_Msg("cart", "장바구니담기", "["+itemName+"]\n["+prQty+"개]\n 장바구니에 담겠습니까??", "YN", true, this);
        		var nRow = eval("this.ds_List" + this.gfn_toString(this.tabIndex)).rowposition;
        			
        		var nIdx = this.FindRowNF(application.gds_marketFicsList,"ITEM_CODE",eval("this.ds_List" + this.gfn_toString(this.tabIndex)).getColumn(nRow,"ITEM_CODE"));
        		var nIdxNew = this.FindRowNF(application.gds_marketFicsNewList,"ITEM_CODE",eval("this.ds_List" + this.gfn_toString(this.tabIndex)).getColumn(nRow,"ITEM_CODE"));

        		if(nIdx >= 0)
        		{	
        			application.goMain.gfn_Msg("cartAdd", "알림", "이미 주문등록한 상품입니다.\n\n추가주문 하시겠습니까?!", "YN", true, this);				
        		}
        		else if(nIdxNew >= 0)
        		{
        			application.goMain.gfn_Msg("cartAdd", "알림", "이미 주문등록한 상품입니다.\n\n추가주문 하시겠습니까?!", "YN", true, this);
        		}
        		else
        		{
        			eval("this.ds_List" + this.gfn_toString(this.tabIndex)).setColumn(eval("this.ds_List" + this.gfn_toString(this.tabIndex)).rowposition, "CNT", "Y");
        			
        			application.gds_marketFicsNewList.addRow();
        			application.gds_marketFicsNewList.copyRow(application.gds_marketFicsNewList.rowposition, eval("this.ds_List" + this.gfn_toString(this.tabIndex)), eval("this.ds_List" + this.gfn_toString(this.tabIndex)).rowposition);
        			
        			application.gds_dsCond.copyData(this.ds_Cond, true);
        			
        			eval("this.ds_List" + this.gfn_toString(this.tabIndex)).setColumn(eval("this.ds_List" + this.gfn_toString(this.tabIndex)).rowposition, "CART_IMG", "URL('HWImage::CellGrd_WF_CartAftbtn.png') stretch");
        			
        			//trace(application.gds_marketFicsNewList.saveXML("application.gds_marketFicsNewList", "V"));			
        			
        		}			
        	
        	}
        	
        }

        /*******************************************************************************
        * 기      능   :  데이터셋변경시
        * 설      명   :  데이터셋변경시 슈량 체크
        ********************************************************************************/
        this.common_cancolumnchange = function(obj,e)
        {
        	//수량체크
        	if (e.columnid == "PR_QTY")
        	{
        		//(-)발주여부
        		if ( nexacro.toNumber(e.newvalue) < 0 )
        		{
        			application.goMain.gfn_Msg("OK", "알림", "(-)발주는 불가합니다.", "OK");
        			return false;
        		}
        		//발주마감체크
        		this.fn_CurrDateWeek();
        		
        		if (this.fn_GetDayStatus(obj.getColumn(e.row,"D_DAYS"), obj.getColumn(e.row,"D_TIMES")) == "0")
        		{
        			application.goMain.gfn_Msg("OK", "알림", "해당 상품은 마감시간(D-Days)이 초과되어 수정이 불가합니다.", "OK");
        			return false;
        		}
        		
        		if ( nexacro.toNumber(e.newvalue) > 0 )
        		{
        			//최소발주량 체크
        			if ( (nexacro.toNumber(obj.getColumn(e.row,"MIN_ORD_QTY")) > 0) && (nexacro.toNumber(obj.getColumn(e.row,"MIN_ORD_QTY")) > nexacro.toNumber(e.newvalue)) )
        			{
        				application.goMain.gfn_Msg("OK", "알림", "해당 상품은 최소발주량이 " + obj.getColumn(e.row,"MIN_ORD_QTY") + "입니다.", "OK");	
        				return false;
        			}
        			//최대발주량 체크
        			if ( (nexacro.toNumber(obj.getColumn(e.row,"MAX_ORD_QTY")) > 0) && (nexacro.toNumber(obj.getColumn(e.row,"MAX_ORD_QTY")) < nexacro.toNumber(e.newvalue)) )
        			{
        				application.goMain.gfn_Msg("OK", "알림", "해당 상품은 최대발주량이 " + obj.getColumn(e.row,"MAX_ORD_QTY") + "입니다.", "OK");
        				return false;
        			}
        			//소숫점발주여부
        			if ( (obj.getColumn(e.row,"POINT_FLAG") != "Y") && (Math.ceil(nexacro.toNumber(e.newvalue)) != nexacro.toNumber(e.newvalue)) )
        			{
        				application.goMain.gfn_Msg("OK", "알림", "해당 상품은 소숫점발주가 불가합니다.", "OK");
        				return false;
        			}
        			
        			//발주승수량
        			if (nexacro.toNumber(obj.getColumn(e.row,"MULTIPLIER_QTY")) != 0)
        			{
        				var nMqty = nexacro.toNumber(obj.getColumn(e.row,"MULTIPLIER_QTY"));
        				var nRt = e.newvalue - (Math.floor(e.newvalue / nMqty) * nMqty);
        				// if(nRt != 0)
        				// if ( (toNumber(obj.getColumn(e.row,"MULTIPLIER_QTY")) > 0) && ((Math.round(toNumber(e.newvalue) * 1000) % Math.round(toNumber(obj.getColumn(e.row,"MULTIPLIER_QTY")) * 1000)) <> 0) )
        				if ( nMqty > 0 && ((nexacro.round(nexacro.toNumber(e.newvalue) * 1000) % nexacro.round(nexacro.toNumber(obj.getColumn(e.row, "MULTIPLIER_QTY")) * 1000)) != 0) ) {
        					application.goMain.gfn_Msg("OK", "알림", "해당 상품은 발주승수량이 " + obj.getColumn(e.row,"MULTIPLIER_QTY") + "입니다.", "OK");
        					return false;
        				}
        			}			
        			
        		}
        		
        		if(!this.gfn_isNull(obj.getColumn(e.row,"MAX_SO_QTY")))
        		{
        			//3개월치 최대발주량 초과시 알람
        			if ( nexacro.toNumber(e.newvalue) >  nexacro.toNumber(obj.getColumn(e.row,"MAX_SO_QTY")) )
        			{
        				application.goMain.gfn_Msg("ALERT_0", "알림", "해당 상품은 3개월치 최대발주량이 " + obj.getColumn(e.row,"MAX_SO_QTY") + "입니다.", "OK");
        			}
        		}
        		
        	}
        	return true;
        }

        this.common_oncolumnchanged = function(obj,e)
        {
        }
        /*******************************************************************************
        * 기      능   :  검색
        * 설      명   :  등록
        ********************************************************************************/
        this.btnSearch_onclick = function(obj,e)
        {
        	this.fn_SearchItem();
        }

        /*******************************************************************************
        * 기      능   :  검색
        * 설      명   :  마스터검색
        ********************************************************************************/
        this.fn_SearchItem = function ()
        {
        	//필수항목 
        	if (this.fn_searchChk()) return;
        	
        	//발주가능 체크
        	if (!this.fn_OrdChk())
        	{
        		return;
        	}
        	
        	this.subinvCd = this.ds_storageCd.getColumn(vRtn, "cd");
        	
        	// 초기화
        	eval("this.ds_List" + this.gfn_toString(this.tabIndex)).clearData();
        	this.ds_Cond.setColumn(0, "QTY_CONTROL_YN",			this.ds_Days.getColumn(0,"QTY_CONTROL_YN"));
        	this.ds_Cond.setColumn(0, "CENTER_CODE",   			this.ds_CtUpj.getColumn(0,"CENTER_CODE"));
        	this.ds_Cond.setColumn(0, "AP_UNITPRICE_UPJANG",    this.ds_CtUpj.getColumn(0,"AP_UNITPRICE_UPJANG"));
        	this.ds_Cond.setColumn(0, "OTCUST_PRICE_UPJANG",    this.ds_CtUpj.getColumn(0,"OTCUST_PRICE_UPJANG"));
        	this.ds_Cond.setColumn(0, "ITEM_NAME",     			this.div_productOrder.div_search.edt_itemNm.value);
        	if (this.tabIndex == 2)
        	{
        		this.ds_Cond.setColumn(0, "FAVOR_GROUP",   this.ds_bookmarkCd.getColumn(vRtnBookmark, "FAVOR_GROUP"));
        	}	
        	else if (this.tabIndex == 1) // 2008.12.11 추가(분류별 상품 조회 기능)
        	{
        		this.ds_Cond.setColumn(0, "ITEM_CLASS2", "");    //대분류
        		this.ds_Cond.setColumn(0, "ITEM_CLASS3", "");	//중분류
        		this.ds_Cond.setColumn(0, "ITEM_CLASS4", "");	//소분류
        	}	
        	
        	// 조회
        	var strSvcID, strURL, strInDatasets, strOutDatasets, strArgument, strCallbackFunc;
        	// 경로 설정
        	strSvcID = "FMP00080E_T001";
        	strURL   = application.services[strDataGroup].url + "fm/fmp/FMP00080E_T001.jsp";
        	// 데이터셋 설정
        	strInDatasets  = "ds_Cond=ds_Cond";
        	strOutDatasets = "ds_List" + this.gfn_toString(this.tabIndex)+ "=ds_List";
        	// 파라메터 설정
        	strArgument  = "g_Upjang=" + nexacro.wrapQuote(application.g_Upjang);
        	strArgument += " g_EmpNo=" + nexacro.wrapQuote(application.g_EmpNo);
        	strArgument += " Holiday_YN=" + nexacro.wrapQuote(application.g_HOLIDAY_CHK_YN);	
        	strArgument += " strIndex=" + nexacro.wrapQuote(this.gfn_toString(this.tabIndex));
        	strArgument += " strWeekendTimeCheck=" + nexacro.wrapQuote(fa_weekendTimeCheck);
            strArgument += " strOnly='TRUE'";
            strArgument += " sType=" + "A.ITEM_NAME";
            strArgument += " nMonth=" + "'0'";	// 전체(최근발주기간설정 0:전체 / n:n달 이전)
        	
        	// 콜백함수 지정
        	strCallbackFunc = "fn_CallBack_SearchItem";
        	// 서버 호출 
        	this.jsp_transaction(this, strSvcID, strURL, strInDatasets, strOutDatasets, strArgument, strCallbackFunc, false, false, false);
        }

        /*******************************************************************************
        * 기      능   :  검색
        * 설      명   :  마스터검색 콜백
        ********************************************************************************/
        this.fn_CallBack_SearchItem = function (errCode,errMsg)
        {
        	if (errCode == 0)
        	{
        		if (eval("this.ds_List" + this.gfn_toString(this.tabIndex)).rowcount < 1)
        		{
        			application.goMain.gfn_Msg("OK", "알림", "검색된 상품이 없습니다.", "OK", "OK");
        		}
        		else
        		{
        			//상품 정상조회 후 컬럼 항목 추가 및 이미지 경로 데이터셋에 세팅 
        			eval("this.ds_List" + this.gfn_toString(this.tabIndex)).addColumn("CART_IMG", "String", 255);
        			
        			for(var i=0; i < eval("this.ds_List" + this.gfn_toString(this.tabIndex)).rowcount; i++)
        			{			
        				eval("this.ds_List" + this.gfn_toString(this.tabIndex)).setColumn(i, "CART_IMG", "URL('HWImage::CellGrd_WF_Cartbtn.png') stretch");
        				
        				//기획 아이콘
        			    if(eval("this.ds_List" + this.gfn_toString(this.tabIndex)).getColumn(i, "FEATURE_ICON") == "theme://Images/new/grd_WF_Icon11.png")
        			    {
        					eval("this.ds_List" + this.gfn_toString(this.tabIndex)).setColumn(i, "FEATURE_ICON", "URL('HWImage::grd_WF_Icon11.png')");
        			    }
        			    //PB상품 아이콘
        			    else if(eval("this.ds_List" + this.gfn_toString(this.tabIndex)).getColumn(i, "FEATURE_ICON") == "theme://Images/new/grd_WF_Icon09.png")
        			    {
        					eval("this.ds_List" + this.gfn_toString(this.tabIndex)).setColumn(i, "FEATURE_ICON", "URL('HWImage::grd_WF_Icon09.png')");
        			    }
        			    //친환경 아이콘
        			    else if(eval("this.ds_List" + this.gfn_toString(this.tabIndex)).getColumn(i, "FEATURE_ICON") == "theme://Images/new/grd_WF_Icon08.png")
        			    {
        					eval("this.ds_List" + this.gfn_toString(this.tabIndex)).setColumn(i, "FEATURE_ICON", "URL('HWImage::grd_WF_Icon08.png')");
        			    }
        			    //전처리 아이콘
        			    else if(eval("this.ds_List" + this.gfn_toString(this.tabIndex)).getColumn(i, "FEATURE_ICON") == "theme://Images/new/grd_WF_Icon10.png")
        			    {
        					eval("this.ds_List" + this.gfn_toString(this.tabIndex)).setColumn(i, "FEATURE_ICON", "URL('HWImage::grd_WF_Icon10.png')");
        			    }
        			    
        			}		
        			
        			//trace(eval("this.ds_List" + this.gfn_toString(this.tabIndex)).saveXML("this.ds_List 1111 >>>>", "V"));				
        		}
        	}
        	else
        		application.goMain.gfn_Msg("OK", "알림", "주문상품 조회하는 중에 오류가 발생하였습니다! \n 관리자에게 문의하세요.", "OK", "OK");		
        }

        
        /*******************************************************************************
        * 기      능   :  검색
        * 설      명   :  발주상세검색
        ********************************************************************************/
        this.fn_search = function()
        {
        	//발주상세 검색시 조회된 상품 데이터셋 초기화
        	this.ds_List1.clearData();
        	this.ds_List2.clearData();
        	
        	//필수항목 
        	if (this.fn_searchChk()) return;
        	
        	
        	//입고통제일 체크 
        	if (this.fn_NeedDateCheck()) 
        	{
        		application.goMain.gfn_Msg("OK", "알림", "해당일자는 입고통제일 입니다.", "OK", "OK");
        	    this.ds_List.clearData();
        	    this.ds_List1.clearData();
        		return;
        	}	
        	
        	this.subinvCd = this.ds_storageCd.getColumn(vRtn, "cd");
        		
        	this.fn_SetTimer();
        	//최종발주정보
        	this.fn_GetLastOrd();
        	// 초기화
        	this.ds_Cond.clearData();
        	this.ds_List.clearData();
        	this.ds_Cond.addRow();
        	this.ds_Cond.setColumn(0, "SUBINV_CODE",    this.subinvCd);
        	this.ds_Cond.setColumn(0, "NEED_DATE",      this.div_productOrder.div_search.cal_dtFrom.value);
        	this.ds_Cond.setColumn(0, "QTY_CONTROL_YN", this.ds_Days.getColumn(0,"QTY_CONTROL_YN"));
        	this.ds_Cond.setColumn(0, "UPJANG",         this.upjang);
        	this.ds_Cond.setColumn(0, "UPJANG_NM",     	this.div_productOrder.edt_upjang.value);
        	this.ds_Cond.setColumn(0, "CONSUM_YN",     	this.ds_storageCd.getColumn(vRtn, "consumYn"));		
        	
        	// 조회
        	var actionName, cmdName, inData, outData, otherArg, callBackFnc;
        	
        	// 파라미터셋팅
            inData		= "ds_Cond=ds_Cond";
            outData		= "ds_List=ds_List";
            callBackFnc	= "fn_CallBack_Search";
        	otherArg    = "DocSrc=" + nexacro.wrapQuote(fa_DocSrc);
        	otherArg   += " DocSrc1=" + nexacro.wrapQuote(fa_DocSrc1);
        	otherArg   += " DocSrc2=" + nexacro.wrapQuote(fa_DocSrc2);
        	otherArg   += " DocSrc3=" + nexacro.wrapQuote(fa_DocSrc3);
        	//action 정보 초기화 
        	this.fsp_clear(); 
            // 서버에서 조회할 정보 추가 
        	this.fsp_addSearch("fm/fmp:FMP00160E_S002", false);
        	// 서버 호출 
        	this.fsp_callService(this, actionName, cmdName, inData, outData, otherArg, callBackFnc, false, false, true);		// 서비스 호출 
            
        }

        /*******************************************************************************
        * 기      능   :  사업장 창고 호출
        * 설      명   :  사업장 창고 호출
        ********************************************************************************/
        this.subInventorySearch = function()
        {
        	var strSvcID   		 = "subInventory";
        	var strUrl     		 = "/ms/mom/subInventory/selectList.xdo";
        	var strInDataset     = "";
        	var strOutDataset    = "ds_storageCd=ds_list";
        	var strArguments	 = "upjang=" + nexacro.wrapQuote(this.upjang);
        	var strCallbackFunc	 = "fn_callBack";
        	var bAsync			 = true;

        	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);
          		
        }

        /*******************************************************************************
        * 기      능   :  디데이
        * 설      명   :  디데이
        ********************************************************************************/
        this.fn_GetDays = function ()
        {
        	// 초기화(디데이)
        	this.ds_Days.clearData();
        	
        	this.subinvCd = this.ds_storageCd.getColumn(vRtn, "cd");
        	
        	// 조회
        	var actionName, cmdName, inData, outData, otherArg, callBackFnc;
        	// 파라미터셋팅
            outData		= "ds_Days=ds_List";
            otherArg	= "UPJANG=" + nexacro.wrapQuote(this.upjang) + " SUBINV_CODE=" + nexacro.wrapQuote(this.subinvCd) + " NEED_DATE=" + nexacro.wrapQuote(this.div_productOrder.div_search.cal_dtFrom.value);
        	callBackFnc = "fn_GetDays_callback";
        	//action 정보 초기화 
        	this.fsp_clear(); 
            // 서버에서 조회할 정보 추가 
        	this.fsp_addSearch("fm/fmz:FMZ_GETDAYS_S001", false);
        	// 서버 호출 	
        	this.fsp_callService(this, actionName, cmdName, inData, outData, otherArg, callBackFnc, false, false, true);

        }
        	
        this.fn_GetDays_callback = function(errCode,errMsg)
        {
        	//디데이 표시
        	if (this.ds_Days.rowcount > 0)
        		this.div_productOrder.div_search.sta_days.set_text("(발주 마감 : " + this.ds_Days.getColumn(0,"DAYS") + ")");
        	else
        	{
        		application.goMain.gfn_Msg("getDaysAlert", "알림", "발주마감정보를 확인할 수 없습니다.!" + "\n\n" + "관리자에게 문의하세요.", "OK", true, this);
        		return;
        	}
        	
        	this.fn_OrdCtrl();
        }

        this.fn_OrdCtrl = function ()
        {	
        	// 초기화(주문통제)
        	this.ds_OrdCtrl.clearData();
        	// 조회
        	var actionName, cmdName, inData, outData, otherArg, callBackFnc;
        	// 파라미터셋팅
            outData		= "ds_OrdCtrl=ds_List";
            otherArg	= "UPJANG=" + nexacro.wrapQuote(this.upjang);
            callBackFnc = "fn_GetOrdCtrl_callback";
        	//action 정보 초기화 
        	this.fsp_clear(); 
            // 서버에서 조회할 정보 추가 
        	this.fsp_addSearch("fm/fmz:FMZ_ORD_CTRL_S001", false);
        	
        	// 서버 호출 	
        	this.fsp_callService(this, actionName, cmdName, inData, outData, otherArg, callBackFnc, false, false, true);
        }

        this.fn_GetOrdCtrl_callback = function(errCode,errMsg)
        {
        	// 여신체크
        	this.fn_GetCredit();	
        	
        	// 업장정보체크
        	this.fn_SetCtUpj();
        }

        /*******************************************************************************
        * 기      능   :  여신정보
        * 설      명   :  여신정보
        ********************************************************************************/
        this.fn_GetCredit = function (isSync)
        {
         	if (!this.fn_GetCrdYn())
         	{
         		//여신정보 초기화
         		this.ds_CrdInfo.clearData();
         	    this.div_productOrder.div_search.edt_credit.set_value("무 제 한");
         		return;
         	}
         	
         	// 초기화
        	this.ds_Cond.clearData();
        	this.ds_CrdInfo.clearData();
        	this.ds_Cond.addRow();
        	this.ds_Cond.setColumn(0, "UPJANG",         this.upjang);
        	this.ds_Cond.setColumn(0, "NEED_DATE",      this.div_productOrder.div_search.cal_dtFrom.value);

        	// 조회
        	var strSvcID, strURL, strInDatasets, strOutDatasets, strArgument, strCallbackFunc;
        	// 경로 설정
        	strSvcID = "FMZ_CREDIT_INFO_T001";
        	strURL   = application.services[strDataGroup].url + "fm/fmz/FMZ_CREDIT_INFO_T001.jsp";
        	// 데이터셋 설정
        	strInDatasets  = "ds_Cond=ds_Cond";
        	strOutDatasets = "ds_CrdInfo=ds_List";
        	// 파라메터 설정
        	strArgument  = "g_Upjang=" + nexacro.wrapQuote(application.g_Upjang);
        	strArgument += " g_EmpNo=" + nexacro.wrapQuote(application.g_EmpNo);
        	strCallbackFunc = "fn_GetCredit_callback";
        	//strArgument += " strDate=" + quote(me_Pdate.Value);
        	// 서버 호출 
        	//Transaction(strSvcID, strURL, strInDatasets, strOutDatasets, strArgument, strCallbackFunc);
        	this.jsp_transaction(this, strSvcID, strURL, strInDatasets, strOutDatasets, strArgument, strCallbackFunc, false, false, isSync);
        }

        /*******************************************************************************
        * 기      능   :  사업장이 여신관리하는지 여부
        * 설      명   :  사업장이 여신관리하는지 여부체크
        ********************************************************************************/
        this.fn_GetCrdYn = function ()
        {
        	//ds임시생성
        	var dsObjin, dsObjot;
        		
        	this.ds_Dummyin = new Dataset;
        	this.ds_Dummyot = new Dataset;
        	
        	this.ds_Dummyin.addColumn("UPJANG", "INT", 22);
        	this.ds_Dummyin.addColumn("NEED_DATE", "STRING", 8);
        	
        	this.ds_Dummyot.addColumn("CRD_YN", "STRING", 1);
        	
        	// 초기화
        	this.ds_Dummyin.clearData();
        	this.ds_Dummyot.clearData();
        	this.ds_Dummyin.addRow();
        	this.ds_Dummyin.setColumn(0, "UPJANG",         this.upjang);
        	this.ds_Dummyin.setColumn(0, "NEED_DATE",      this.div_productOrder.div_search.cal_dtFrom.value);
        	// 조회
        	var actionName, cmdName, inData, outData, otherArg, callBackFnc;
        	// 파라미터셋팅
            inData		= "ds_Cond=ds_Dummyin";
            outData		= "ds_Dummyot=ds_List";
            callBackFnc = "fn_GetCrdYn_callback";
        	//action 정보 초기화 
        	this.fsp_clear(); 
            // 서버에서 조회할 정보 추가 
        	this.fsp_addSearch("fm/fmz:FMZ_CREDIT_CHKYN_S001", false);
        	// 서버 호출 
            this.fsp_callService(this, actionName, cmdName, inData, outData, otherArg, callBackFnc, false, false, true);
        	
        	var bYn = (this.ds_Dummyot.rowcount > 0);
        	
        	//ds임시생성 해제
        	//Destroy("ds_Dummyin");
        	//Destroy("ds_Dummyot");
        	return  bYn;
        }

        this.fn_GetCrdYn_callback = function(errCode,errMsg)
        {
        	
        }

        
        /*******************************************************************************
        * 기      능   :  최종발주정보
        * 설      명   :  최종발주정보
        ********************************************************************************/
        this.fn_GetLastOrd = function ()
        {
        	//ds임시생성
        	this.ds_Dummyin = new Dataset;
        	this.ds_Dummyot = new Dataset;
        	
        	this.ds_Dummyin.addColumn("SUBINV_CODE", "STRING", 8);
        	this.ds_Dummyin.addColumn("NEED_DATE", "STRING", 8);
        	this.ds_Dummyin.addColumn("DOCU_SOURCE", "STRING", 50);
        	
        	this.ds_Dummyot.addColumn("NEED_DATE", "STRING", 8);
        	this.ds_Dummyot.addColumn("CNT", "DECIMAL", 22);
        	this.ds_Dummyot.addColumn("AMT", "DECIMAL", 22);
        	
        	// 초기화
        	this.ds_Dummyin.clearData();
        	this.ds_Dummyot.clearData();
        	this.ds_Dummyin.addRow();
        	this.ds_Dummyin.setColumn(0, "SUBINV_CODE",    this.subinvCd);
        	this.ds_Dummyin.setColumn(0, "NEED_DATE",      this.div_productOrder.div_search.cal_dtFrom.value);
        	this.ds_Dummyin.setColumn(0, "DOCU_SOURCE",    fa_DocSrc);
        	// 조회
        	var actionName, cmdName, inData, outData, otherArg, callBackFnc;
        	// 파라미터셋팅
            inData		= "ds_Cond=ds_Dummyin";
            outData		= "ds_Dummyot=ds_List";
        	otherArg    = "DocSrc1=" + nexacro.wrapQuote(fa_DocSrc1);
        	otherArg   += " DocSrc2=" + nexacro.wrapQuote(fa_DocSrc2);
        	callBackFnc = "fn_GetLastOrd_callback";
        	//action 정보 초기화 
        	this.fsp_clear(); 
            // 서버에서 조회할 정보 추가 
        	this.fsp_addSearch("fm/fmp:FMP00160E_S001", false);
        	// 서버 호출 
            this.fsp_callService(this, actionName, cmdName, inData, outData, otherArg, callBackFnc, false, false, true);		// 서비스 호출 

        }

        /*******************************************************************************
        * 기      능   :  센터단가업장정보
        * 설      명   :  센터단가업장정보
        ********************************************************************************/
        this.fn_SetCtUpj = function ()
        {
        	// 조회
        	var actionName, cmdName, inData, outData, otherArg, callBackFnc;
        	// 파라미터셋팅
            outData		= "ds_CtUpj=ds_List";
            otherArg	= "UPJANG=" + nexacro.wrapQuote(this.upjang);
            callBackFnc = "fn_SetCtUpj_callback";
        	//action 정보 초기화 
        	this.fsp_clear(); 
            // 서버에서 조회할 정보 추가 
        	this.fsp_addSearch("fm/fmz:FMZ_GET_CTUPJ_S001", false);
        	// 서버 호출 
            this.fsp_callService(this, actionName, cmdName, inData, outData, otherArg, callBackFnc, false, false, true);    

        }

        this.fn_SetCtUpj_callback = function(errCode,errMsg)
        {
        	if (this.ds_CtUpj.rowcount <= 0)
        	{	
        		application.goMain.gfn_Msg("setCtUpjAlert", "알림", "업장기초정보를 확인할 수 없습니다.!" + "\n\n" + "관리자에게 문의하세요.", "OK", true, this);
        		return;
        	}	
        	
        	this.fn_SetTimer();
        	this.setTimer(777,30000); //일단 30초 세팅
        	
        	this.fn_search();	
        }

        /*******************************************************************************
        * 기      능   :  타이머
        * 설      명   :  타이머
        ********************************************************************************/
        this.fn_SetTimer = function ()
        {
        	this.fn_CurrDateWeek();
        	
        	this.fn_setWeekendTime();
        		
        	var sChkDate, sDay, sTime;
        	
        	trace("application.gds_currdate :: " +application.gds_currdate.saveXML("gds_currdate", "V"));
        	
        	trace("this.ds_Days :: " +this.ds_Days.saveXML("ds_Days", "V"));
        	
        	if ( this.gfn_subStr(application.gds_currdate.getColumn(0, "YMD_TM"),8,4)>= this.gfn_Trim(this.ds_Days.getColumn(0,"D_TIMES")) )
        	{
        		sChkDate = this.gfn_AddDate(this.div_productOrder.div_search.cal_dtFrom.value, (-1 * (nexacro.toNumber(this.gfn_Trim(this.ds_Days.getColumn(0,"D_DAYS"))) + 1)));	
        		sTime = this.G_fn_GapTime("1", this.gfn_subStr(application.gds_currdate.getColumn(0, "YMD_TM"),8,4), nexacro.toNumber(this.gfn_Trim(this.ds_Days.getColumn(0,"D_TIMES"))), "");	
        	}
        	else
        	{
        		sChkDate = this.gfn_AddDate(this.div_productOrder.div_search.cal_dtFrom.value, (-1 * nexacro.toNumber(this.gfn_Trim(this.ds_Days.getColumn(0,"D_DAYS")))));
        		sTime = this.G_fn_GapTime("0", this.gfn_subStr(application.gds_currdate.getColumn(0, "YMD_TM"),8,4), this.gfn_Trim(this.ds_Days.getColumn(0,"D_TIMES")), "");
        	}
        	
        	if (parseInt(application.gds_currdate.getColumn(0, "YMD")) <= parseInt(sChkDate))
        		sDay = this.G_fn_CalcDay(application.gds_currdate.getColumn(0, "YMD"), sChkDate);		
        	else
        		sDay = this.G_fn_CalcDay(sChkDate, application.gds_currdate.getColumn(0, "YMD")) * (-1);		
        		
        	if ((nexacro.toNumber(sDay) >= 0) && (nexacro.toNumber(sDay) < 10)) sDay = "0" + sDay;
        		
        		this.div_productOrder.div_search.sta_timer.set_text("마감시간 : " + sDay + "일 " + this.gfn_Left(sTime,2)+ "시간 " + this.gfn_Right(sTime,2)+ "분 전");	
        		this.div_productOrder.div_search.sta_week.set_text("(" + this.fn_DayToWeek(this.div_productOrder.div_search.cal_dtFrom.value) + ")");
        	
        	if (this.div_productOrder.div_search.sta_week.text == "(토)")
        		this.div_productOrder.div_search.sta_week.style.color = "blue";
        	else if (this.div_productOrder.div_search.sta_week.text == "(일)")
        		this.div_productOrder.div_search.sta_week.style.color = "red";
        	else
        		this.div_productOrder.div_search.sta_week.style.color = "black";
        		
        	fa_sDay = sDay;	
        	if (nexacro.toNumber(sDay) < 0) this.fn_CLS_STATUS_Setting(); 		
        }

        this.fn_CLS_STATUS_Setting = function ()
        {
        	if (fa_sDay >= 0) return;
            
        	for (i=0; i<this.ds_List.rowcount; i++)
        	{
        		if (this.ds_List.getColumn(i, "OTCUSTCD") != "0000")
        		{
        			this.ds_List.setColumn(i, "CLS_STATUS", "마감");
        		}
        	}		
        }

        /*******************************************************************************
        * 기      능   :  필수체크
        * 설      명   :  필수체크
        ********************************************************************************/
        this.fn_searchChk = function ()
        {
        	if ( this.gfn_isNull(this.upjang) )
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "사업장" + this.fn_AlertMsg("005"), "OK");
        		return true;
        	}
        	
         	if ( this.gfn_isNull(this.div_productOrder.div_search.cbo_storage.value) )
         	{
         		application.goMain.gfn_Msg("ALERT_0", "알림", "식당을 선택하세요.", "OK");
         		return true;
         	}
        	
        	if ( this.gfn_isNull(this.div_productOrder.div_search.cal_dtFrom.value) || (this.gfn_Length(this.div_productOrder.div_search.cal_dtFrom.value)< 8) )
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "입고예정일을 정확하게 입력하세요.", "OK");
        		return true;
        	}
        	
        	return false;
        }

        /*******************************************************************************
        * 기      능   :  발주가능 체크 
        * 설      명   :  발주가능 체크
        ********************************************************************************/
        this.fn_OrdChk = function ()
        {
        	//this.fn_GetDays();
        	this.fn_CurrDateWeek();

        	//입고통제일 체크 
        	if (this.fn_NeedDateCheck()) 
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "해당일자는 입고통제일 입니다.", "OK");
        	    this.ds_List.clearData();
        	    this.ds_List1.clearData();

        		return false;
        	}

        	//발주통제일자
        	if (nexacro.toNumber(this.ds_Days.getColumn(0,"D_OVER_DAYS")) > 0)
        	{
        		if (this.div_productOrder.div_search.cal_dtFrom.value > this.gfn_AddDate(application.gds_currdate.getColumn(0, "YMD"),nexacro.toNumber(this.ds_Days.getColumn(0,"D_OVER_DAYS"))))
        		{	
        			application.goMain.gfn_Msg("ALERT_0", "알림", this.ds_Days.getColumn(0,"D_OVER_DAYS") + "일을 초과하여 입고예정일을 지정할 수 없습니다.", "OK");
        			return false;
        		}
        	}
        	//발주제한일자
        	if (nexacro.toNumber(this.ds_Days.getColumn(0,"D_DAYS")) > 0)
        	{
        		if (this.div_productOrder.div_search.cal_dtFrom.value < this.gfn_AddDate(application.gds_currdate.getColumn(0, "YMD"),nexacro.toNumber(this.ds_Days.getColumn(0,"D_DAYS"))))
        		{
        			application.goMain.gfn_Msg("ALERT_0", "알림", "발주마감은 " + this.ds_Days.getColumn(0,"DAYS") + "입니다.", "OK");
        			return false;
        		}
        		if (this.div_productOrder.div_search.cal_dtFrom.value == this.gfn_AddDate(application.gds_currdate.getColumn(0, "YMD"),nexacro.toNumber(this.ds_Days.getColumn(0,"D_DAYS"))))
        		{
        			if (this.gfn_subStr(application.gds_currdate.getColumn(0, "YMD_TM"),8,6)> this.ds_Days.getColumn(0,"D_TIMES"))
        			{
        				application.goMain.gfn_Msg("ALERT_0", "알림", "발주마감은 " + this.ds_Days.getColumn(0,"DAYS") + "입니다.", "OK");
        				return false;
        			}
        		}
        	}
        	
        	//창고가 식재 또는 소모품 전용창고인 경우 주문통제 점검
        	if (!this.gfn_isNull(this.ds_storageCd.getColumn(vRtn, "consumYn")))
        	{
        		//주문통제(주문일자)
        		
        		var nRow;

        		if (this.ds_storageCd.getColumn(vRtn, "consumYn") == "Y")
        		{
        			nRow = this.ds_OrdCtrl.findRowExpr("CTRL_TYPE=='주문' && ITEM_TYPE=='소모품'")
        		}
        		else
        		{
        			nRow = this.ds_OrdCtrl.findRowExpr("CTRL_TYPE=='주문' && ITEM_TYPE=='식자재'")
        		}
        			
        		if (nRow >= 0)
        		{
        			if (this.ds_OrdCtrl.getColumn(nRow,this.ToUpper(application.gds_currdate.getColumn(0, "WEEK_ENG"))) == "Y")
        			{
        				application.goMain.gfn_Msg("ALERT_0", "알림", application.gds_currdate.getColumn(0, "WEEK_KOR") + "요일은 주문불가 요일입니다.", "OK");
        				return false;
        			}
        		}
        		
        		//주문통제(입고일자)
        		if (this.ds_storageCd.getColumn(vRtn, "consumYn") == "Y")
        		{
        			nRow = this.ds_OrdCtrl.findRowExpr("CTRL_TYPE=='입고' && ITEM_TYPE=='소모품'")
        		}
        		else
        		{
        			nRow = this.ds_OrdCtrl.findRowExpr("CTRL_TYPE=='입고' && ITEM_TYPE=='식자재'")
        		}
        		
        		if (nRow >= 0)
        		{
        			if (this.ds_OrdCtrl.getColumn(nRow,this.ToUpper(this.fn_DayToWeek(this.div_productOrder.div_search.cal_dtFrom.value,"1"))) == "Y")
        			{
        				application.goMain.gfn_Msg("ALERT_0", "알림", this.fn_DayToWeek(this.div_productOrder.div_search.cal_dtFrom.value) + "요일은 입고불가 요일입니다." + "\n\n" + "입고예정일을 변경하세요.", "OK");
        				return false;
        			}
        		}
        	}
        	
        	return true;
        }

        /*******************************************************************************
        * 기      능   :  입고통제일 체크 
        * 설      명   :  입고통제일 체크 
        ********************************************************************************/
        this.fn_NeedDateCheck = function ()
        {
        	//ds임시생성
        	this.ds_Dummyin = new Dataset;
        	this.ds_Dummyot = new Dataset;
        	
        	this.ds_Dummyin.addColumn("UPJANG", "INT", 22);
        	this.ds_Dummyin.addColumn("NEED_DATE", "STRING", 8);
        	
        	this.ds_Dummyot.addColumn("CNT", "INT", 22);
        	
        	// 초기화
        	this.ds_Dummyin.clearData();
        	this.ds_Dummyot.clearData();
        	this.ds_Dummyin.addRow();
        	this.ds_Dummyin.setColumn(0, "UPJANG",         this.upjang);
        	this.ds_Dummyin.setColumn(0, "NEED_DATE",      this.div_productOrder.div_search.cal_dtFrom.value);
        	// 조회
        	var actionName, cmdName, inData, outData, otherArg, callBackFnc;
        	// 파라미터셋팅
            inData		= "ds_Cond=ds_Dummyin";
            outData		= "ds_Dummyot=ds_List";
            callBackFnc = "fn_NeedDateCheck_callback";
            
        	//action 정보 초기화 
        	this.fsp_clear(); 
            // 서버에서 조회할 정보 추가 
        	this.fsp_addSearch("fm/fmz:FMZ_ORD_CTRL_S002", false);
        	// 서버 호출 
        	trace("this.ds_Dummyin :: " +this.ds_Dummyin.saveXML("ds_Dummyin", "V"));
        	
            this.fsp_callService(this, actionName, cmdName, inData, outData, otherArg, callBackFnc, false, false, true);
        	
        	var bYn = (this.ds_Dummyot.getColumn(0, "CNT") > 0);
        	
        	return bYn;
        }

        this.fn_NeedDateCheck_callback = function (errCode,errMsg)
        {
        	
        }

        this.fn_SetRowColor = function (nDdays,nDtimes,sWeekItemCode)
        {
        	return this.iif(this.fn_GetDayStatus(nDdays,nDtimes,sWeekItemCode)=="0","thistle","white");
        }

        /*******************************************************************************
        * 기      능   :  발주마감체크
        * 설      명   :  발주마감체크
        ********************************************************************************/
        this.fn_GetDayStatus = function (nDdays,nDtimes,sWeekItemCode)
        {
        	//리조트 물류스케주울 체크
        	if (!this.gfn_isNull(sWeekItemCode)) return "0";
        	//무통제면 패스...
        	if ( this.numFormat(nDdays)== "0" )	return "2";
        	//디데이체크
        	if ( this.gfn_AddDate(application.gds_currdate.getColumn(0,"YMD"),nDdays)> this.div_productOrder.div_search.cal_dtFrom.value )
        		return "0";
        	else if ( this.gfn_AddDate(application.gds_currdate.getColumn(0,"YMD"),nDdays)== this.div_productOrder.div_search.cal_dtFrom.value )
        	{
        		//디타임체크
        		if ( this.gfn_subStr(application.gds_currdate.getColumn(0, "YMD_TM"),8,4)> nDtimes )
        			return "0";
        		else if ( this.G_fn_GapTime(0, this.gfn_subStr(application.gds_currdate.getColumn(0, "YMD_TM"),8,4), nDtimes, "") <= "0030" )
        			return "1";
        		else
        			return "2";
        	}
        	else
        		return "2";
        }

        /*******************************************************************************
        * 기      능   :  즐겨찾기그룹
        * 설      명   :  즐겨찾기그룹호출
        ********************************************************************************/
        this.fn_SetFav = function()
        {
        	// 조회
        	var actionName, cmdName, inData, outData, otherArg, callBackFnc;
        	// 파라미터셋팅
            outData		= "ds_bookmarkCd=ds_List";
            otherArg	= "UPJANG=" + nexacro.wrapQuote(this.upjang);
            callBackFnc = "fn_SetFav_callback";
        	//action 정보 초기화 
        	this.fsp_clear(); 
            // 서버에서 조회할 정보 추가 
        	this.fsp_addSearch("fm/fmz:FMZ_FAVORITE_GROUP_S001", false);
        	// 서버 호출 
            this.fsp_callService(this, actionName, cmdName, inData, outData, otherArg, callBackFnc, false, false, true);
        	
        }

        this.fn_SetFav_callback = function (errCode,errMsg)
        {
        	if (errCode == 0)
        	{
        		if (this.ds_bookmarkCd.rowcount < 1)
        		{	
        			application.goMain.gfn_Msg("OK", "알림", "즐겨찾기 그룹이 존재하지 않습니다.", "OK");
        			return;		
        		}
        		else
        		{
        			//정상적으로 창고명 호출 시 즐겨찾기 세팅
        			this.div_productOrder.div_search.cbo_bookmark.set_text(this.ds_bookmarkCd.getColumn(0, "FAVOR_NAME"));
        		}
        	}
        	else
        	{
        		application.goMain.gfn_Msg("OK", "알림", this.fn_AlertMsg("002"), "OK", "OK");		
        	}
        }

        /*================================================================================
         * 5. UserFunction관련 Script
         *===============================================================================*/
        /*******************************************************************************
        * 설      명   :  조회 콜백 함수
        ********************************************************************************/
        this.fn_CallBack_Search = function (errCode,errMsg)
        {
        	if (errCode == 0)
        	{
        		if (this.ds_List.rowcount < 1)
        		{
        			application.goMain.gfn_Msg("OK", "알림", "주문등록한 상품이 없습니다.", "OK", "OK");
        			application.gds_marketFicsList.clearData();
        			application.gds_marketFicsNewList.clearData();
        			application.gds_dsCond.clearData();
        		}
        		else
        		{
        			application.goMain.gfn_Msg("OK", "알림", "주문등록한 상품이" +this.ds_List.rowcount+ "건 있습니다. 장바구니에서 확인하십시요", "OK", "OK");
        			
        			application.gds_marketFicsList.clearData();
        			application.gds_marketFicsNewList.clearData();
        			application.gds_dsCond.clearData();
        			
        			application.gds_marketFicsList.copyData(this.ds_List, true);
        			application.gds_dsCond.copyData(this.ds_Cond, true);
        			
        			trace(application.gds_dsCond.saveXML("application.gds_dsCond >>>> ", "V"));
        	
        			this.fn_CLS_STATUS_Setting();
        		}
        			
        	}
        	else
        		application.goMain.gfn_Msg("OK", "알림", this.fn_AlertMsg("002"), "OK", "OK");		
        }

        /*******************************************************************************
        * 설      명   :  여신정보 콜백 함수
        ********************************************************************************/
        this.fn_GetCredit_callback = function (errCode,errMsg)
        {
        	if (errCode == 0)
        	{
        		//여신 표시
        		if (this.ds_CrdInfo.rowcount > 0) 
        		{
        			if (this.ds_CrdInfo.getColumn(0,"CREDIT_AMOUNT_CONTROL_YN") == "Y")
        			{
        				this.div_productOrder.div_search.edt_credit.set_value(this.gfn_NumFormat(this.ds_CrdInfo.getColumn(0,"CREDIT_RMN_AMT"))+ " 원");				
        			}
        			else
        				this.div_productOrder.div_search.edt_credit.set_value("무 제 한");
        		}
        		else
        		{
        			application.goMain.gfn_Msg("getCreditAlert", "알림", "업장여신정보를 확인할 수 없습니다.!" + "\n\n" + "관리자에게 문의하세요.", "OK", true, this);
        			return;
        		}
        	}
        	else
        	{
        		application.goMain.gfn_Msg("getCreditAlert", "알림", this.fn_AlertMsg("002"), "OK", true, this);
        		return;
        	}
        			
        	this.fn_SetCtUpj();	
        }

        
        this.fn_GetLastOrd_callback = function(errCode,errMsg)
        {
        	if (errCode == 0)
        	{
        				
        	}
        	else
        		application.goMain.gfn_Msg("OK", "알림", this.fn_AlertMsg("002"), "OK", "OK");		
        }

        this.div_productOrder_div_search_edt_itemNm_onchanged = function(obj,e)
        {
        	this.div_productOrder.div_search.edt_itemNm.set_autoselect(false);
        }

        /*----------------------------------------------------------------------------------------------
        * 설명      : JSP트랜잭션 콜백 함수 (필수)
        *---------------------------------------------------------------------------------------------*/
          
        /*----------------------------------------------------------------------------------------------
        * 설명      : 트랜잭션 콜백 함수 (필수)
        *---------------------------------------------------------------------------------------------*/
        this.fn_callBack = function (strSvcID,nErrorCode,strErrorMsg)
        {		
        	// 에러시 gfn_callBack에서 메시지 제공, 화면별 특정 에러 발생시에만 사용하세요.
        	if (nErrorCode < 0) 
        	{
        		return;
        	}
        	
            switch(strSvcID)
            {		
        		//추가발주조회
                case "search" :
        			// TODO parameter로 전체건수를 받는다.
        			this.fv_totalpageRow = this.ds_grd.getRowCount();
        			
                    // 조회 건수 확인  
                    if (this.ds_grd.getRowCount() == 0) 
                    {
                        application.goMain.gfn_Msg("alertTest", "Information", "조회되는 내용이 없습니다.", "OK");	//조회되는 내용이 없습니다.
                        return;
                    }
                    else	// 조회건수가 1페이지 이상일때
                    {

        			}
          			break;
          		// 창고 콜백 함수
                case "subInventory" :
        			
        			
        			//정상적으로 창고명 호출 시 창고코드 세팅
        			this.div_productOrder.div_search.cbo_storage.set_text(this.ds_storageCd.getColumn(0, "cdNm"));
        			
        			//디데이
        			this.fn_GetDays();			
        				
        			break;
            }   
           
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
        		case "upjangNm":
        			this.div_productOrder.edt_upjang.set_value(rtn[1]);
        			this.upjang = rtn[0];
        			//업장조회후 모든 값 초기화시킴
        			this.fn_ResetData();
        			this.subInventorySearch();
        			
        			//즐겨찾기 탭 선택후 업장 선택시 즐겨찾기 그룹 호출
        			if(this.tabIndex == 2)
        			{
        				this.fn_SetFav();
        			}			
        			
        			break;
        		case "Storage":
        			this.div_productOrder.div_search.cbo_storage.set_index(rtn);
        		    vRtn = rtn;
        		    //디데이
        			this.fn_GetDays();
        			//자동조회
        			//this.fn_search();			
        			break;
        		case "itemCount":
        		    eval("this.ds_List" + this.gfn_toString(this.tabIndex)).setColumn(eval("this.ds_List" + this.gfn_toString(this.tabIndex)).rowposition, "PR_QTY", rtn);
        			eval("this.ds_List" + this.gfn_toString(this.tabIndex)).setColumn(eval("this.ds_List" + this.gfn_toString(this.tabIndex)).rowposition, "MOBILE_GUBUN", "M");
        			break;				
        		case "bookmark":
        			this.div_productOrder.div_search.cbo_bookmark.set_index(rtn);
        		    vRtnBookmark = rtn;		    		
        			break;
        		case "PopCalFrom":
        			this.div_productOrder.div_search.cal_dtFrom.set_value(rtn);
        			
        			//디데이
        			this.fn_GetDays();
        			//자동조회
        			//this.fn_search();	
        			break;
        		case "msg":
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
        	
        	//디데이체크시 경고창 콜백
        	if (id == "getDaysAlert")
        	{
        		this.fn_OrdCtrl();
        	}
        	//여신체크후 경고창 콜백
        	if (id == "getCreditAlert")
        	{
        		//센터단가업장정보
        		this.fn_SetCtUpj();	
        	}
        	
        	//센터단가업장정보 체크후 경고창 콜백
        	if (id == "setCtUpjAlert")
        	{
        		//센터단가업장정보
        		this.fn_SetTimer();
        		this.setTimer(777,30000); //일단 30초 세팅
        	}
        	
        	if (id == "cart")
        	{
        		if (rtn == "Y") 
        		{	
        			var nRow = eval("this.ds_List" + this.gfn_toString(this.tabIndex)).rowposition;
        			
        			var nIdx = this.FindRowNF(application.gds_marketFicsList,"ITEM_CODE",eval("this.ds_List" + this.gfn_toString(this.tabIndex)).getColumn(nRow,"ITEM_CODE"));
        			var nIdxNew = this.FindRowNF(application.gds_marketFicsNewList,"ITEM_CODE",eval("this.ds_List" + this.gfn_toString(this.tabIndex)).getColumn(nRow,"ITEM_CODE"));
        	
        			if(nIdx >= 0)
        			{	
        				application.goMain.gfn_Msg("cartAdd", "알림", "이미 주문등록한 상품입니다.\n\n추가주문 하시겠습니까?!", "YN", true, this);				
        			}
        			else if(nIdxNew >= 0)
        			{
        				application.goMain.gfn_Msg("cartAdd", "알림", "이미 주문등록한 상품입니다.\n\n추가주문 하시겠습니까?!", "YN", true, this);
        			}
        			else
        			{
        				eval("this.ds_List" + this.gfn_toString(this.tabIndex)).setColumn(eval("this.ds_List" + this.gfn_toString(this.tabIndex)).rowposition, "CNT", "Y");
        				trace(eval("this.ds_List" + this.gfn_toString(this.tabIndex)).saveXML("this.ds_List", "V"));
        				application.gds_marketFicsNewList.addRow();
        				application.gds_marketFicsNewList.copyRow(application.gds_marketFicsNewList.rowposition, eval("this.ds_List" + this.gfn_toString(this.tabIndex)), eval("this.ds_List" + this.gfn_toString(this.tabIndex)).rowposition);
        				
        				application.gds_dsCond.copyData(this.ds_Cond, true);								

        				trace(application.gds_marketFicsNewList.saveXML("application.gds_marketFicsNewList", "V"));				
        				
        			}			
        		}
        		else
        		{
        			return;
        		}
        	}
        	
        	if (id == "cartAdd")
        	{
        		if (rtn == "Y") 
        		{	
        			eval("this.ds_List" + this.gfn_toString(this.tabIndex)).setColumn(eval("this.ds_List" + this.gfn_toString(this.tabIndex)).rowposition, "CNT", "Y");
        			trace(eval("this.ds_List" + this.gfn_toString(this.tabIndex)).saveXML("this.ds_List", "V"));
        			application.gds_marketFicsNewList.addRow();
        			application.gds_marketFicsNewList.copyRow(application.gds_marketFicsNewList.rowposition, eval("this.ds_List" + this.gfn_toString(this.tabIndex)), eval("this.ds_List" + this.gfn_toString(this.tabIndex)).rowposition);
        			application.gds_marketFicsNewList.setColumn(application.gds_marketFicsNewList.rowposition, "PR_QTY", 0);
        			
        			application.gds_dsCond.copyData(this.ds_Cond, true);
        			
        			eval("this.ds_List" + this.gfn_toString(this.tabIndex)).setColumn(eval("this.ds_List" + this.gfn_toString(this.tabIndex)).rowposition, "CART_IMG", "URL('HWImage::CellGrd_WF_CartAftbtn.png') stretch");
        			
        			trace(application.gds_marketFicsNewList.saveXML("application.gds_marketFicsNewList", "V"));
        					
        		}
        		else
        		{
        			return;
        		}
        	}
        }

        this.div_productOrder_grd_list_onslide = function(obj,e)
        {
        	if (e.yaccvalue > 0)
        	{
        		this.parent.parent.divBottom.set_visible(true);
        		this.parent.parent.divMain.set_height(833);
        		this.parent.parent.divBottom.bringToFront();
        		// 검색 영역 컨트롤
        		this.div_productOrder.div_search.set_visible(true);
        		this.div_productOrder.Static00.set_visible(true);
        		this.div_productOrder.edt_upjang.set_visible(true);
        		this.div_productOrder.btn_upjang.set_visible(true);
        		
        		this.div_productOrder.div_search.setOffsetTop(this.div_productOrder.Static00.getOffsetBottom());
        		
        		if (this.tabIndex == 1)
        		{
        			this.div_productOrder.grd_list.setOffsetTop(this.div_productOrder.div_search.getOffsetBottom());
        		}
        		else if(this.tabIndex == 2)
        		{	
        			this.div_productOrder.grd_list2.setOffsetTop(this.div_productOrder.div_search.getOffsetBottom());
        		}
        		
        	}
        	else if (e.yaccvalue < 0)
        	{
        		this.parent.parent.divBottom.set_visible(false);
        		this.parent.parent.divMain.set_height(923);
        		// 검색 영역 컨트롤
        		this.div_productOrder.div_search.set_visible(true);
        		this.div_productOrder.Static00.set_visible(false);
        		this.div_productOrder.edt_upjang.set_visible(false);
        		this.div_productOrder.btn_upjang.set_visible(false);
        		
        		this.div_productOrder.div_search.setOffsetTop(this.div_productOrder.Static00.getOffsetTop());
        			
        		if (this.tabIndex == 1)
        		{
        			this.div_productOrder.grd_list.setOffsetTop(this.div_productOrder.div_search.getOffsetBottom());
        		}
        		else if(this.tabIndex == 2)
        		{
        			this.div_productOrder.grd_list2.setOffsetTop(this.div_productOrder.div_search.getOffsetBottom());
        		}		
        	}
        }

        this.div_productOrder_grd_list_onvscroll = function(obj,e)
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
        	if (this.tabIndex == 1)
        	{	
        		// 해당 div로 바꿔준다.
        		this.div_productOrder.grd_list.vscrollbar.set_pos(0);
        	}
        	else if(this.tabIndex == 2)
        	{
        		// 해당 div로 바꿔준다.
        		this.div_productOrder.grd_list2.vscrollbar.set_pos(0);
        	}
        	
        	// 검색 영역 컨트롤
        	this.div_productOrder.div_search.set_visible(true);
        	
        	if (this.tabIndex == 1)
        	{
        		this.div_productOrder.grd_list.setOffsetTop(this.div_productOrder.div_search.getOffsetBottom());
        	}
        	else if(this.tabIndex == 2)
        	{
        		this.div_productOrder.grd_list2.setOffsetTop(this.div_productOrder.div_search.getOffsetBottom());
        	}
        	
        }

        this.productOrder_onactivate = function(obj,e)
        {
        	//화면 액트브시 타이머 재설정
        	this.fn_SetTimer();
        	this.setTimer(777,30000); //일단 30초 세팅
        }

        this.productOrder_ondeactivate = function(obj,e)
        {
        	//타이머 종료...(타이머 발생으로 쿼리 수행하여 결과값 가져오면 화면이 앞으로 올라온다.
        	this.killTimer(777);
        }

        this.productOrder_ontimer = function(obj,e)
        {
        	if (e.timerid == 777) this.fn_SetTimer();
        }

        // FICS 발주제한요일, 시간 설정 조회
        this.fn_getWeekendTime = function ()
        {
        	this.fn_CurrDateWeek();
        	
        	// 조회
        	var actionName, cmdName, inData, outData, otherArg, callBackFnc;
        	// 파라미터셋팅
            outData		= "ds_WeekendTime=ds_List";
            callBackFnc = "callBackWeekendTime"
            //action 정보 초기화 
        	this.fsp_clear(); 
            // 서버에서 조회할 정보 추가 
        	this.fsp_addSearch("fm/fmz:FMZ_GET_WEEKENDTIME_S001", false);
        	
        	// 서버 호출 
            this.fsp_callService(this, actionName, cmdName, inData, outData, otherArg, callBackFnc, false, false, true);
        }

        this.callBackWeekendTime = function (errCode,errMsg)
        {
        	if (errCode == 0)
        	{
        	    this.fn_setWeekendTime();
        	    
        	    //발주제한 체크후 콜백에서 창고조회 및 기타 체크로직을 타게함
        	    this.subInventorySearch();
        	} else {
        		application.goMain.gfn_Msg("ALERT_0", "알림", this.fn_AlertMsg("002"), "OK");
        	}
        }

        // FICS 발주제한요일, 시간 설정에 따른 화면 제어 	
        this.fn_setWeekendTime = function()
        {
        	var sCurWeekCd = application.gds_currdate.getColumn(0, "WEEK_CD");
        	var sCurTm = this.gfn_subStr(application.gds_currdate.getColumn(0, "YMD_TM"),8,4);
        	var nRow = this.ds_WeekendTime.findRow("CODE", sCurWeekCd);
        	
        	if ( nRow > -1 ) {
        		
        		fa_startTime = this.ds_WeekendTime.getColumn(nRow, "SET2");
        		fa_endTime = this.ds_WeekendTime.getColumn(nRow, "SET3");
        		
        		if ( sCurTm >= fa_startTime && sCurTm <= fa_endTime ) {			
        			
        			// 발주 통제 함
        			fa_weekendTimeCheck = "Y";			
        		} else {
        		    
        		    // 발주 통제 안함
        			fa_weekendTimeCheck = "N"; 			
        		}			
        	}
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.ds_List.addEventHandler("cancolumnchange", this.ds_List_CanColumnChange, this);
            this.ds_List.addEventHandler("oncolumnchanged", this.ds_List_OnColumnChanged, this);
            this.ds_List1.addEventHandler("oncolumnchanged", this.common_oncolumnchanged, this);
            this.ds_List1.addEventHandler("cancolumnchange", this.common_cancolumnchange, this);
            this.ds_List2.addEventHandler("cancolumnchange", this.common_cancolumnchange, this);
            this.ds_List2.addEventHandler("oncolumnchanged", this.common_oncolumnchanged, this);
            this.addEventHandler("onload", this.form_onload, this);
            this.addEventHandler("onactivate", this.productOrder_onactivate, this);
            this.addEventHandler("ondeactivate", this.productOrder_ondeactivate, this);
            this.addEventHandler("ontimer", this.productOrder_ontimer, this);
            this.btn_productOrder.addEventHandler("onclick", this.btn_tab_onclick, this);
            this.btn_productOrderBookMark.addEventHandler("onclick", this.btn_tab_onclick, this);
            this.div_productOrder.addEventHandler("onvscroll", this.div_productOrder_onvscroll, this);
            this.div_productOrder.addEventHandler("onslide", this.div_productOrder_onslide, this);
            this.div_productOrder.div_search.btn_search.addEventHandler("onclick", this.btnSearch_onclick, this);
            this.div_productOrder.div_search.cbo_storage.addEventHandler("ondropdown", this.cbo_storage_ondropdown, this);
            this.div_productOrder.div_search.edt_itemNm.addEventHandler("onchanged", this.div_productOrder_div_search_edt_itemNm_onchanged, this);
            this.div_productOrder.div_search.cbo_bookmark.addEventHandler("ondropdown", this.cbo_bookmark_ondropdown, this);
            this.div_productOrder.div_search.sta_dtFrom.addEventHandler("onclick", this.sta_dtFrom_onclick, this);
            this.div_productOrder.grd_list.addEventHandler("onvscroll", this.div_productOrder_grd_list_onvscroll, this);
            this.div_productOrder.grd_list.addEventHandler("oncellclick", this.grd_list_oncellclick, this);
            this.div_productOrder.grd_list.addEventHandler("oncelldblclick", this.grd_list_oncelldblclick, this);
            this.div_productOrder.grd_list.addEventHandler("onslide", this.div_productOrder_grd_list_onslide, this);
            this.div_productOrder.btn_upjang.addEventHandler("onclick", this.div_productOrder_btn_upjang_onclick, this);
            this.div_productOrder.grd_list2.addEventHandler("onvscroll", this.div_productOrder_grd_list_onvscroll, this);
            this.div_productOrder.grd_list2.addEventHandler("oncellclick", this.grd_list_oncellclick, this);
            this.div_productOrder.grd_list2.addEventHandler("oncelldblclick", this.grd_list_oncelldblclick, this);
            this.div_productOrder.grd_list2.addEventHandler("onslide", this.div_productOrder_grd_list_onslide, this);

        };

        this.loadIncludeScript("ProductOrder.xfdl", true);

       
    };
}
)();
