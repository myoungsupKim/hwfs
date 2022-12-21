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
            obj = new Dataset("ds_storageCd", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"SUBINV_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"SUBINV_NAME\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
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

            obj = new Dataset("ds_grd1", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("true");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"ITEM_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_CLASS4\" type=\"STRING\" size=\"256\"/><Column id=\"FEATURE_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_SIZE\" type=\"STRING\" size=\"256\"/><Column id=\"PO_UOM\" type=\"STRING\" size=\"256\"/><Column id=\"KG_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"CANCEL_PR_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"G_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"PR_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"PR_AMT\" type=\"STRING\" size=\"256\"/><Column id=\"TOT_AMT\" type=\"STRING\" size=\"256\"/><Column id=\"TAX_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"CENTER_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"PR_REMARK\" type=\"STRING\" size=\"256\"/><Column id=\"REMARK\" type=\"STRING\" size=\"256\"/><Column id=\"POINT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"SUBINV_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"NEED_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"DEPT_ID\" type=\"STRING\" size=\"256\"/><Column id=\"ACCTCD\" type=\"STRING\" size=\"256\"/><Column id=\"BUD_CLS\" type=\"STRING\" size=\"256\"/><Column id=\"MU_CD\" type=\"STRING\" size=\"256\"/><Column id=\"INVAT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"OUTVAT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"MIN_ORD_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"MAX_ORD_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"CENTER_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"STOCK_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"BARCODE\" type=\"STRING\" size=\"256\"/><Column id=\"KEEPING_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"MULTIPLIER_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"BUDDEPT_ID\" type=\"STRING\" size=\"256\"/><Column id=\"USE_YN\" type=\"STRING\" size=\"256\"/><Column id=\"CONTRACT_YN\" type=\"STRING\" size=\"256\"/><Column id=\"MARGIN_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"UNIT_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"CUSTCD\" type=\"STRING\" size=\"256\"/><Column id=\"CHEAP_YN\" type=\"STRING\" size=\"256\"/><Column id=\"KG_CONVERT_RATE\" type=\"STRING\" size=\"256\"/><Column id=\"MARGIN_RATE\" type=\"STRING\" size=\"256\"/><Column id=\"AP_UNITPRICE_UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"RESTRICT_PERIOD\" type=\"STRING\" size=\"256\"/><Column id=\"RESTRICT_REASON\" type=\"STRING\" size=\"256\"/><Column id=\"DUTY_END_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"MIN_DUTY_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"DUTY_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"REAL_USE_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"PR_YN\" type=\"STRING\" size=\"256\"/><Column id=\"SCH_INFO\" type=\"STRING\" size=\"256\"/><Column id=\"SHP_MAP\" type=\"STRING\" size=\"256\"/><Column id=\"MTG_UNS\" type=\"STRING\" size=\"256\"/><Column id=\"MTG_STP\" type=\"STRING\" size=\"256\"/><Column id=\"REQ_WKD\" type=\"STRING\" size=\"256\"/><Column id=\"SCH\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAY\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAYS\" type=\"STRING\" size=\"256\"/><Column id=\"D_TIMES\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAY_YN\" type=\"STRING\" size=\"256\"/><Column id=\"SPICE_YN\" type=\"STRING\" size=\"256\"/><Column id=\"CORN_YN\" type=\"STRING\" size=\"256\"/><Column id=\"IMG_PATH\" type=\"STRING\" size=\"256\"/><Column id=\"ORIGIN_NAT\" type=\"STRING\" size=\"256\"/><Column id=\"ORIGIN_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"VD_SN\" type=\"STRING\" size=\"256\"/><Column id=\"APPLY_SD\" type=\"STRING\" size=\"256\"/><Column id=\"MOBILE_GUBUN\" type=\"STRING\" size=\"256\"/><Column id=\"AGG_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"LINE_STATUS\" type=\"STRING\" size=\"256\"/><Column id=\"CART_IMG\" type=\"STRING\" size=\"256\"/><Column id=\"UPJANG_GRP\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_potype", this);
            obj._setContents("<ColumnInfo><Column id=\"PO_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"PO_TYPE_NM\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAY\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAYS\" type=\"STRING\" size=\"256\"/><Column id=\"D_TIMES\" type=\"STRING\" size=\"256\"/><Column id=\"REMARK\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_approver", this);
            obj._setContents("<ColumnInfo><Column id=\"SABUN\" size=\"20\" type=\"STRING\"/><Column id=\"NM_KOR\" size=\"100\" type=\"STRING\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_item_condi", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"APPROV_YN\" type=\"STRING\" size=\"256\"/><Column id=\"EXPT_UPJANG_YN\" type=\"STRING\" size=\"256\"/><Column id=\"PR_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"NEED_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"SUBINV_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_CLASS1\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_CLASS2\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_CLASS3\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_CLASS4\" type=\"STRING\" size=\"256\"/><Column id=\"BARCODE\" type=\"STRING\" size=\"256\"/><Column id=\"CUSTCD\" type=\"STRING\" size=\"256\"/><Column id=\"FAVOR_GROUP\" type=\"STRING\" size=\"256\"/><Column id=\"UPJANG\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row/></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_condi", this);
            obj.set_useclientlayout("true");
            obj._setContents("<ColumnInfo><Column id=\"EXPT_UPJANG_YN\" type=\"STRING\" size=\"256\"/><Column id=\"APPROV_YN\" type=\"STRING\" size=\"256\"/><Column id=\"TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"PR_SABUN\" type=\"STRING\" size=\"256\"/><Column id=\"PR_DEPT_ID\" type=\"STRING\" size=\"256\"/><Column id=\"PO_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"PO_TYPE_NM\" type=\"STRING\" size=\"256\"/><Column id=\"PR_UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"PR_UPJANG_NM\" type=\"STRING\" size=\"256\"/><Column id=\"RC_UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"RC_UPJANG_NM\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAYS\" type=\"BIGDECIMAL\" size=\"128\"/><Column id=\"D_TIMES\" type=\"BIGDECIMAL\" size=\"128\"/><Column id=\"PR_NUM\" type=\"STRING\" size=\"256\"/><Column id=\"PR_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"NEED_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"SUBINV_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"SORT_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"STATUS\" type=\"STRING\" size=\"256\"/><Column id=\"REASON_CD\" type=\"STRING\" size=\"256\"/><Column id=\"PR_REASON\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_item_class1", this);
            obj._setContents("<ColumnInfo><Column id=\"cd\" size=\"8\" type=\"STRING\"/><Column id=\"cdNm\" size=\"50\" type=\"STRING\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_expt_upjang_list", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"100\"/><Column id=\"cdNm\" type=\"STRING\" size=\"50\"/><Column id=\"contents\" type=\"STRING\" size=\"256\"/><Column id=\"set1\" type=\"STRING\" size=\"256\"/><Column id=\"set2\" type=\"STRING\" size=\"256\"/><Column id=\"set3\" type=\"STRING\" size=\"256\"/><Column id=\"set4\" type=\"STRING\" size=\"256\"/><Column id=\"set5\" type=\"STRING\" size=\"256\"/><Column id=\"remark\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_grd2", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("true");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"ITEM_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_CLASS4\" type=\"STRING\" size=\"256\"/><Column id=\"FEATURE_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_SIZE\" type=\"STRING\" size=\"256\"/><Column id=\"PO_UOM\" type=\"STRING\" size=\"256\"/><Column id=\"KG_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"CANCEL_PR_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"G_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"PR_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"PR_AMT\" type=\"STRING\" size=\"256\"/><Column id=\"TOT_AMT\" type=\"STRING\" size=\"256\"/><Column id=\"TAX_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"CENTER_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"PR_REMARK\" type=\"STRING\" size=\"256\"/><Column id=\"REMARK\" type=\"STRING\" size=\"256\"/><Column id=\"POINT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"SUBINV_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"NEED_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"DEPT_ID\" type=\"STRING\" size=\"256\"/><Column id=\"ACCTCD\" type=\"STRING\" size=\"256\"/><Column id=\"BUD_CLS\" type=\"STRING\" size=\"256\"/><Column id=\"MU_CD\" type=\"STRING\" size=\"256\"/><Column id=\"INVAT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"OUTVAT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"MIN_ORD_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"MAX_ORD_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"CENTER_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"STOCK_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"BARCODE\" type=\"STRING\" size=\"256\"/><Column id=\"KEEPING_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"MULTIPLIER_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"BUDDEPT_ID\" type=\"STRING\" size=\"256\"/><Column id=\"USE_YN\" type=\"STRING\" size=\"256\"/><Column id=\"CONTRACT_YN\" type=\"STRING\" size=\"256\"/><Column id=\"MARGIN_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"UNIT_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"CUSTCD\" type=\"STRING\" size=\"256\"/><Column id=\"CHEAP_YN\" type=\"STRING\" size=\"256\"/><Column id=\"KG_CONVERT_RATE\" type=\"STRING\" size=\"256\"/><Column id=\"MARGIN_RATE\" type=\"STRING\" size=\"256\"/><Column id=\"AP_UNITPRICE_UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"RESTRICT_PERIOD\" type=\"STRING\" size=\"256\"/><Column id=\"RESTRICT_REASON\" type=\"STRING\" size=\"256\"/><Column id=\"DUTY_END_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"MIN_DUTY_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"DUTY_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"REAL_USE_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"PR_YN\" type=\"STRING\" size=\"256\"/><Column id=\"SCH_INFO\" type=\"STRING\" size=\"256\"/><Column id=\"SHP_MAP\" type=\"STRING\" size=\"256\"/><Column id=\"MTG_UNS\" type=\"STRING\" size=\"256\"/><Column id=\"MTG_STP\" type=\"STRING\" size=\"256\"/><Column id=\"REQ_WKD\" type=\"STRING\" size=\"256\"/><Column id=\"SCH\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAY\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAYS\" type=\"STRING\" size=\"256\"/><Column id=\"D_TIMES\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAY_YN\" type=\"STRING\" size=\"256\"/><Column id=\"SPICE_YN\" type=\"STRING\" size=\"256\"/><Column id=\"CORN_YN\" type=\"STRING\" size=\"256\"/><Column id=\"IMG_PATH\" type=\"STRING\" size=\"256\"/><Column id=\"ORIGIN_NAT\" type=\"STRING\" size=\"256\"/><Column id=\"ORIGIN_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"VD_SN\" type=\"STRING\" size=\"256\"/><Column id=\"APPLY_SD\" type=\"STRING\" size=\"256\"/><Column id=\"MOBILE_GUBUN\" type=\"STRING\" size=\"256\"/><Column id=\"AGG_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"LINE_STATUS\" type=\"STRING\" size=\"256\"/><Column id=\"CART_IMG\" type=\"STRING\" size=\"256\"/><Column id=\"UPJANG_GRP\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Button("btn_additionOrder", "absolute", "0", "0", "270", "63", null, null, this);
            obj.set_taborder("34");
            obj.set_text("추가발주");
            obj.set_cssclass("btn_WF_TabTFOn");
            this.addChild(obj.name, obj);

            obj = new Button("btn_additionOrderBookMark", "absolute", "270", "0", "270", "63", null, null, this);
            obj.set_taborder("88");
            obj.set_text("즐겨찾기");
            obj.set_cssclass("btn_WF_TabTFOff");
            this.addChild(obj.name, obj);

            obj = new Div("div_additionOrder", "absolute", "0", "62", "540", null, null, "0", this);
            obj.set_taborder("89");
            obj.style.set_background("white");
            this.addChild(obj.name, obj);
            obj = new Div("div_search", "absolute", "0%", "58", null, "117", "0.37%", null, this.div_additionOrder);
            obj.set_taborder("11");
            this.div_additionOrder.addChild(obj.name, obj);
            obj = new Static("Static22", "absolute", "0%", "58", null, "59", "0%", null, this.div_additionOrder.div_search);
            obj.set_taborder("12");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.div_additionOrder.div_search.addChild(obj.name, obj);
            obj = new Calendar("cal_prDate", "absolute", "113", "40", null, "47", "230", null, this.div_additionOrder.div_search);
            this.div_additionOrder.div_search.addChild(obj.name, obj);
            obj.set_taborder("22");
            obj.set_displaynulltext("2015-12-29");
            obj.set_dateformat("yyyy-MM-dd");
            obj.set_visible("false");
            obj.set_value("null");
            obj = new Button("btn_search", "absolute", "430", "64", null, "47", "8", null, this.div_additionOrder.div_search);
            obj.set_taborder("21");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.div_additionOrder.div_search.addChild(obj.name, obj);
            obj = new Static("Static04", "absolute", "0.19%", "0", null, "59", "0%", null, this.div_additionOrder.div_search);
            obj.set_taborder("11");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.div_additionOrder.div_search.addChild(obj.name, obj);
            obj = new Calendar("cal_dtFrom", "absolute", "20.93%", "64", null, "47", "42.78%", null, this.div_additionOrder.div_search);
            this.div_additionOrder.div_search.addChild(obj.name, obj);
            obj.set_taborder("15");
            obj.set_dateformat("yyyy-MM-dd");
            obj = new Combo("cbo_Storage", "absolute", "1.85%", "6", null, "47", "42.78%", null, this.div_additionOrder.div_search);
            this.div_additionOrder.div_search.addChild(obj.name, obj);
            obj.set_taborder("14");
            obj.set_displaynulltext("창고명 선택");
            obj.set_innerdataset("@ds_storageCd");
            obj.set_codecolumn("SUBINV_CODE");
            obj.set_datacolumn("SUBINV_NAME");
            obj.set_index("-1");
            obj = new Static("Static24", "absolute", "0%", "58", null, "59", "79.63%", null, this.div_additionOrder.div_search);
            obj.set_taborder("16");
            obj.set_text("입고일");
            obj.set_cssclass("sta_WF_Label02");
            this.div_additionOrder.div_search.addChild(obj.name, obj);
            obj = new Static("Static25", "absolute", "17.22%", "58", null, "59", "79.07%", null, this.div_additionOrder.div_search);
            obj.set_taborder("17");
            obj.set_text("글자사이간격w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.div_additionOrder.div_search.addChild(obj.name, obj);
            obj = new Edit("edt_itemNm", "absolute", "58.18%", "6", null, "47", "1.49%", null, this.div_additionOrder.div_search);
            obj.set_taborder("18");
            obj.set_displaynulltext("자재명 검색");
            obj.set_autoselect("true");
            obj.set_imemode("hangul");
            this.div_additionOrder.div_search.addChild(obj.name, obj);
            obj = new Static("Static33", "absolute", "57.22%", "12", null, "29", "41.85%", null, this.div_additionOrder.div_search);
            obj.set_taborder("20");
            obj.set_text("w05");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.div_additionOrder.div_search.addChild(obj.name, obj);
            obj = new Combo("cbo_itemClass1", "absolute", "313", "64", null, "47", "113", null, this.div_additionOrder.div_search);
            this.div_additionOrder.div_search.addChild(obj.name, obj);
            obj.set_taborder("23");
            obj.set_innerdataset("@ds_item_class1");
            obj.set_codecolumn("cd");
            obj.set_datacolumn("cdNm");
            obj.set_visible("false");
            obj.set_index("-1");
            obj = new Combo("cbo_bookmark", "absolute", "313", "35", null, "47", "8", null, this.div_additionOrder.div_search);
            this.div_additionOrder.div_search.addChild(obj.name, obj);
            obj.set_taborder("24");
            obj.set_displaynulltext("즐겨찾기그룹");
            obj.set_innerdataset("@ds_bookmarkCd");
            obj.set_codecolumn("FAVOR_GROUP");
            obj.set_datacolumn("FAVOR_NAME");
            obj.set_visible("false");
            obj.set_index("-1");
            obj = new Static("sta_dtFrom", "absolute", "112", "64", "196", "47", null, null, this.div_additionOrder.div_search);
            obj.set_taborder("25");
            this.div_additionOrder.div_search.addChild(obj.name, obj);
            obj = new Static("sta_upjang", "absolute", "0", "1", null, "59", "0", null, this.div_additionOrder);
            obj.set_taborder("13");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.div_additionOrder.addChild(obj.name, obj);
            obj = new Edit("edt_upjang", "absolute", "10", "7", null, "47", "10", null, this.div_additionOrder);
            obj.set_taborder("14");
            obj.set_displaynulltext("사업장을 입력하세요");
            obj.set_autoselect("true");
            obj.set_readonly("true");
            this.div_additionOrder.addChild(obj.name, obj);
            obj = new Button("btn_upjang", "absolute", null, "7", "47", "47", "10", null, this.div_additionOrder);
            obj.set_taborder("15");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.div_additionOrder.addChild(obj.name, obj);
            obj = new Grid("grd_list1", "absolute", "0%", "174", null, null, "0%", "0", this.div_additionOrder);
            obj.set_taborder("12");
            obj.set_binddataset("ds_grd1");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_cssclass("grd_WF_Default2");
            obj.set_autosizingtype("none");
            obj.set_extendsizetype("none");
            obj.set_nodataimage("URL('theme://Image/grd_WF_NoDataImg.png')");
            obj.set_fillareatype("none");
            obj.set_selecttype("row");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"8\"/><Column size=\"56\"/><Column size=\"185\"/><Column size=\"115\"/><Column size=\"110\"/><Column size=\"66\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"4\"/></Rows><Band id=\"head\"><Cell/><Cell col=\"1\" text=\"Column1\"/><Cell col=\"2\" text=\"Column0\"/><Cell col=\"3\"/><Cell col=\"4\"/><Cell col=\"5\"/></Band><Band id=\"body\"><Cell style=\"line:0 solid #808080ff ;selectbackground:ghostwhite;\"/><Cell col=\"1\" colspan=\"3\" displaytype=\"normal\" edittype=\"none\" style=\"align:left bottom;padding:EXPR(FEATURE_NAME == undefined ?&quot;'0 10 0 0&quot; :&quot;'0 10 0 65&quot;);line:0 none #808080ff ;background:transparent left bottom;background2:transparent left bottom;selectbackground:ghostwhite left bottom;backgroundimage:BIND(FEATURE_NAME);\" text=\"bind:ITEM_NAME\" wordwrap=\"char\" autosizerow=\"default\" autosizecol=\"default\"/><Cell col=\"4\" rowspan=\"2\" displaytype=\"number\" edittype=\"none\" editfilter=\"number\" style=\"align:right middle;padding:25 0 25 0;line:0 solid #808080ff ;selectbackground:ghostwhite;\" text=\"bind:PR_QTY\" wordwrap=\"char\" mask=\"#,##0.0#\" maskchar=\" \" editdisplay=\"display\" autosizerow=\"default\" autosizecol=\"default\"/><Cell col=\"5\" rowspan=\"2\" displaytype=\"button\" edittype=\"button\" style=\"padding:25 6 25 6;line:0 solid transparent ;selectbackground:ghostwhite;controlbackground:BIND(CART_IMG);controlborder:0 solid #808080ff ;\" wordwrap=\"char\" calendardisplay=\"edit\" autosizerow=\"default\" autosizecol=\"default\"/><Cell row=\"1\" style=\"line:0 solid #808080ff ;selectbackground:ghostwhite;\"/><Cell row=\"1\" col=\"1\" colspan=\"2\" displaytype=\"normal\" style=\"align:left top;padding:0 10 0 0;line:0 none #808080ff ;color:blue;color2:blue;selectbackground:ghostwhite;selectcolor:blue;\" text=\"expr:ITEM_CODE + &quot;   &quot; + PO_UOM\" wordwrap=\"char\" autosizerow=\"default\" autosizecol=\"default\"/><Cell row=\"1\" col=\"3\" displaytype=\"number\" style=\"align:right top;padding:0 10 0 10;line:0 solid #808080ff ;color:red;color2:red;selectbackground:ghostwhite;selectcolor:red;\" text=\"bind:MARGIN_PRICE\" wordwrap=\"char\" mask=\"###,###,###.##\" autosizerow=\"default\" autosizecol=\"default\"/><Cell row=\"2\"/><Cell row=\"2\" col=\"1\" autosizerow=\"limitmax\" autosizecol=\"default\"/><Cell row=\"2\" col=\"2\" autosizerow=\"limitmax\" autosizecol=\"default\"/><Cell row=\"2\" col=\"3\" autosizerow=\"limitmax\" autosizecol=\"default\"/><Cell row=\"2\" col=\"4\" autosizerow=\"limitmax\" autosizecol=\"default\"/><Cell row=\"2\" col=\"5\" autosizerow=\"limitmax\" autosizecol=\"default\"/></Band></Format></Formats>");
            this.div_additionOrder.addChild(obj.name, obj);
            obj = new Grid("grd_list2", "absolute", "0", "265", null, null, "0", "0", this.div_additionOrder);
            obj.set_cssclass("grd_WF_Default2");
            obj.set_taborder("16");
            obj.set_binddataset("ds_grd2");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_nodataimage("URL('theme://Image/grd_WF_NoDataImg.png')");
            obj.set_visible("false");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"8\"/><Column size=\"185\"/><Column size=\"124\"/><Column size=\"110\"/><Column size=\"66\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"4\"/></Rows><Band id=\"head\"><Cell text=\"Column1\"/><Cell col=\"1\" text=\"Column0\"/><Cell col=\"2\"/><Cell col=\"3\"/><Cell col=\"4\"/></Band><Band id=\"body\"><Cell displaytype=\"normal\" style=\"line:0 solid #808080 ;selectbackground:ghostwhite;\"/><Cell col=\"1\" colspan=\"2\" displaytype=\"normal\" style=\"align:left bottom;padding:EXPR(FEATURE_NAME == undefined ?&quot;'0 10 0 0&quot; :&quot;'0 10 0 65&quot;);line:0 solid #808080ff ;background:transparent left bottom;background2:transparent left bottom;selectbackground:ghostwhite left bottom;backgroundimage:BIND(FEATURE_NAME);\" text=\"bind:ITEM_NAME\" wordwrap=\"char\"/><Cell col=\"3\" rowspan=\"2\" displaytype=\"number\" edittype=\"none\" style=\"align:right middle;padding:25 0 25 0;line:0 solid #808080ff ;selectbackground:ghostwhite;\" text=\"bind:PR_QTY\" mask=\"#,##0.0#\" maskchar=\" \" editdisplay=\"display\"/><Cell col=\"4\" rowspan=\"2\" displaytype=\"button\" edittype=\"button\" style=\"padding:25 6 25 6;line:0 solid transparent ;selectbackground:ghostwhite;controlbackground:BIND(CART_IMG);controlborder:0 solid #808080ff ;\" calendardisplay=\"edit\"/><Cell row=\"1\" displaytype=\"image\" style=\"line:0 none #808080ff ;selectbackground:ghostwhite;\"/><Cell row=\"1\" col=\"1\" style=\"align:left top;padding:0 10 0 0;line:0 none #808080ff ;color:blue;color2:blue;selectbackground:ghostwhite;selectcolor:blue;\" text=\"expr:ITEM_CODE + &quot;   &quot; + PO_UOM\" wordwrap=\"char\"/><Cell row=\"1\" col=\"2\" displaytype=\"number\" style=\"align:right top;padding:0 10 0 10;line:0 solid #808080ff ;color:red;color2:red;selectbackground:ghostwhite;selectcolor:red;\" text=\"bind:MARGIN_PRICE\" mask=\"###,###,###.##\"/><Cell row=\"2\"/><Cell row=\"2\" col=\"1\"/><Cell row=\"2\" col=\"2\"/><Cell row=\"2\" col=\"3\"/><Cell row=\"2\" col=\"4\"/></Band></Format></Formats>");
            this.div_additionOrder.addChild(obj.name, obj);

            obj = new Static("Static13", "absolute", "571", "240", "417", "35", null, null, this);
            obj.set_taborder("90");
            obj.set_text("추가발주_GRID");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static14", "absolute", "485", "255", "71", "2", null, null, this);
            obj.set_taborder("91");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "573", "352", "417", "35", null, null, this);
            obj.set_taborder("92");
            obj.set_text("즐겨찾기_GRID");
            obj.set_cssclass("sta_GUIDE_BlackText");
            obj.set_visible("false");
            obj.style.set_font("bold 9 Dotum");
            this.addChild(obj.name, obj);

            obj = new Static("Static01", "absolute", "485", "367", "76", "2", null, null, this);
            obj.set_taborder("93");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            obj.style.set_align("center middle");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 0, 117, this.div_additionOrder.div_search,
            	//-- Layout function
            	function(p) {
            		p.set_taborder("11");

            	}
            );
            this.div_additionOrder.div_search.addLayout(obj.name, obj);

            //-- Default Layout
            obj = new Layout("default", "", 540, 0, this.div_additionOrder,
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
        this.addIncludeScript("AdditionOrder_copy.xfdl", "lib::lib_Com.xjs");
        this.registerScript("AdditionOrder_copy.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		추가발주
        // [부시스템명]	추가발주 - 조회
        // [설명]
        // 		부서 검색하기.
        // [작성자명] 		강대성
        // [작성일자]		2015.02.04
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.04 : 강대성 : 수정이 필요하여 수정함.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/
        this.preDate = undefined;
        this.fv_totalpageRow;	// 전체건수
        this.upjang = undefined;
        this.itemClass1 = undefined;
        this.fv_addApprovYn = undefined;
        this.subinvCd = undefined;
        this.vRtn = 0;
        this.vRtn2 = 0;
        this.vRtn3 = 0;
        this.nIndex;
        this.tabIndex = "1";
        this.dsTabGubun = this.ds_grd1;
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
        	//필수
        	this.fn_init();
        }

        // 데이터 초기화
        this.fn_init = function ()
        {
        	application.g_System_Mst = "";
        	
        	application.goMenu = this;	
        	
        	this.fsp_init();
        	//application.gds_marketList.clearData();		
        	//application.gds_condi.clearData();	
        	this.ds_grd1.clearData();	
        	this.ds_grd2.clearData();
        	
        	this.fn_common_code("MS002", "", "");	
        	this.ds_item_class1.copyData(application.gds_common_code);	
        	
        	// 추가구매승인예외 사업장코드
        	this.fn_common_code("FS0125", "", "");	
        	this.ds_expt_upjang_list.copyData(application.gds_common_code);	
        	
        	//첫번쨰 index로 세팅
        	this.itemClass1 = this.ds_item_class1.getColumn(this.vRtn2, "cd");
        	this.div_additionOrder.div_search.cbo_itemClass1.set_text(this.ds_item_class1.getColumn(this.vRtn2, "cdNm"));
        	
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetBtnControl("this.div_additionOrder.div_search.btn_search","");
        		
        	// 권한에 따른 버튼 활성화 및 디폴트값 설정
        	this.fn_SetAuth("this.div_additionOrder.edt_upjang", "this.div_additionOrder.btn_upjang");
        	
        	this.preDate = this.gfn_Today();
        	this.div_additionOrder.div_search.cal_dtFrom.set_value(this.preDate);
        	this.div_additionOrder.div_search.cal_prDate.set_value(this.preDate);
        	
        	//사업장 세팅
        	this.div_additionOrder.edt_upjang.set_value(application.g_UpjangNm);	
        	this.upjang = application.g_Upjang;	
        	
        	nIndex = this.ds_condi.addRow();
        	this.ds_condi.setColumn(nIndex, "PR_SABUN"		, application.g_EmpNo);
        	this.ds_condi.setColumn(nIndex, "PR_DEPT_ID"	, application.g_Deptid);
        	this.ds_condi.setColumn(nIndex, "PR_UPJANG"		, application.g_Upjang); 
        	this.ds_condi.setColumn(nIndex, "RC_UPJANG"		, application.g_Upjang);
        	this.ds_condi.setColumn(nIndex, "SORT_TYPE"		, "1");  //코드순
        		
        	this.fn_PoCommon();
        	
        	this.fn_search_potype();	
        	
        	//창고 콤보 데이터 호출
        	this.subInventorySearch();	
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

        	if (obj.name == "btn_additionOrder")
        	{	
        		// 화면 보이기
        		this.div_additionOrder.div_search.set_visible(true);
        		this.div_additionOrder.div_search.edt_itemNm.set_visible(true);
        		this.div_additionOrder.grd_list1.set_visible(true);
        		
        		// 화면 숨기기
        		this.div_additionOrder.div_search.cbo_bookmark.set_visible(false);
        		this.div_additionOrder.grd_list2.set_visible(false);
        		
        		// class
        		this.btn_additionOrder.set_cssclass("btn_WF_TabTFOn");
        		this.btn_additionOrderBookMark.set_cssclass("btn_WF_TabTFOff");
        		this.tabIndex = "1"
        		this.dsTabGubun = this.ds_grd1;
        		
        		
        	}
        	else if (obj.name == "btn_additionOrderBookMark")
        	{
        		// 즐겨찾기 그룹조회
        		this.fn_search_group();		
        		// 화면 보이기
        		this.div_additionOrder.div_search.set_visible(true);
        		this.div_additionOrder.div_search.cbo_bookmark.set_visible(true);
        		this.div_additionOrder.grd_list2.set_visible(true);		
        		
        		// 화면 숨기기
        		this.div_additionOrder.div_search.edt_itemNm.set_visible(false);
        		this.div_additionOrder.grd_list1.set_visible(false);		
        		
        		// 위치조정
        		this.div_additionOrder.grd_list2.set_top(174);
        		this.div_additionOrder.div_search.cbo_bookmark.set_top(6);
        		
        		// class
        		this.btn_additionOrder.set_cssclass("btn_WF_TabTFOff");
        		this.btn_additionOrderBookMark.set_cssclass("btn_WF_TabTFOn");
        		this.tabIndex = "2"
        		this.dsTabGubun = this.ds_grd2;
        		
        		
        	}	
        }

        //사업장 검색 팝업
        this.div_additionOrder_btn_upjang_onclick = function(obj,e)
        {
        	var arg = new Array();
        	if(application.g_AuthLevel == "999" || application.g_AuthLevel == "99")
        	{
        		arg[4] = application.g_RoleSetId1;
        		arg[9] = "exception";
        		arg[10] = "AND A.MU_CD IN ('2002','2003')";
        		arg[11] = application.g_UpjangFlag1;
        		arg[12] = application.g_UpjangFlag2;
        	}
        	else
        	{
        		arg[4] = application.g_RoleSetId2;
        		arg[5] = application.g_AuthLevel;
        		arg[6] = application.g_EmpNo;
        		//arg[7] = application.g_Tm_Cd;
        		arg[8] = application.g_Mu_Cd;
        		arg[9] = application.g_UpjangGubun;
        		arg[11] = application.g_UpjangFlag1;
        		arg[12] = application.g_UpjangFlag2;
        	}	
        	
        	application.goMain.gfn_POP_create("upjangNm", "M_MLM::WorkplaceSearchPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        //창고 콤보조회 검색 팝업
        this.cbo_Storage_ondropdown = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_storageCd;
        	arg[1] = "조회조건(창고)";
        	arg[2] = "";
        	arg[3] = "SUBINV_NAME";
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

        this.div_additionOrder_div_search_cbo_itemClass1_ondropdown = function(obj,e)
        {
        	var arg = new Array();
        	arg[0] = this.ds_item_class1;
        	arg[1] = "조회조건";
        	arg[2] = "";
        	arg[3] = "cdNm";
        	application.goMain.gfn_POP_create("itemClass1", "cmmn::CmmnComboList.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        // 달력 클릭 시(From)
        this.sta_dtFrom_onclick = function(obj,e)
        {
        	var objCalArg = this.div_additionOrder.div_search.cal_dtFrom.value;
        	
        	application.goMain.gfn_POP_create("PopCalFrom", "cmmn::CmmnCalendarPop.xfdl", "fn_callbackPOP", this, objCalArg, "POP", application.goMain.divBase);
        	return false;
        }

        //그리드 더블 클릭시 상품 상세팝업 호출
        this.grd_list_oncelldblclick = function(obj,e)
        {
        	var objCalArg = obj.v;
        	
        	var arg = new Array();
        	var nRow = e.row;
        	arg[0] = this.dsTabGubun.getColumn(nRow, "ITEM_NAME");
        	arg[1] = this.dsTabGubun.getColumn(nRow, "ITEM_SIZE");
        	arg[2] = this.dsTabGubun.getColumn(nRow, "PO_UOM");
        	arg[3] = this.dsTabGubun.getColumn(nRow, "KEEPING_TYPE");
        	arg[4] = this.dsTabGubun.getColumn(nRow, "ORIGIN_TYPE");
        	arg[5] = this.dsTabGubun.getColumn(nRow, "IMG_PATH");
        	
        	application.goMain.gfn_POP_create("itemImage", "M_MOM::ProductDetailPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	
        }

        //그리드 길게 터치시 상품 상세팝업 호출
        this.div_productOrder_grd_list_onlongpress = function(obj,e)
        {	

        	var arg = new Array();	
        	arg[0] = this.dsTabGubun.getColumn(this.dsTabGubun.rowposition, "ITEM_NAME");
        	arg[1] = this.dsTabGubun.getColumn(this.dsTabGubun.rowposition, "ITEM_SIZE");
        	arg[2] = this.dsTabGubun.getColumn(this.dsTabGubun.rowposition, "PO_UOM");
        	arg[3] = this.dsTabGubun.getColumn(this.dsTabGubun.rowposition, "KEEPING_TYPE");
        	arg[4] = this.dsTabGubun.getColumn(this.dsTabGubun.rowposition, "ORIGIN_TYPE");
        	arg[5] = this.dsTabGubun.getColumn(this.dsTabGubun.rowposition, "IMG_PATH");
        	
        	application.goMain.gfn_POP_create("itemImage", "M_MOM::ProductDetailPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);

        }

        //그리드 cell선택시
        this.grd_list_oncellclick = function(obj,e)
        {
        	var nRow = e.row;
        	
        	var prQty = this.dsTabGubun.getColumn(nRow, "PR_QTY");
        	var marginPrice = this.dsTabGubun.getColumn(nRow, "MARGIN_PRICE");
        	var itemName = this.dsTabGubun.getColumn(nRow, "ITEM_NAME")	
        	
         	if(e.cell == "2")
         	{
         		var arg = new Array();
         	
         		arg[0] = this.dsTabGubun.getColumn(nRow, "PR_QTY");
         		arg[1] = this.dsTabGubun.getColumn(nRow, "ITEM_CODE");
        		arg[2] = this.dsTabGubun.getColumn(nRow, "ITEM_NAME");
         	
         		application.goMain.gfn_POP_create("itemCount", "cmmn::CmmnInputNumber.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
         		return false;
         	}
        		
        	if(e.cell == "3")
        	{
        		//장바구니 상품 추가시 체크
        		if(!this.fn_AddItem())
        		{
        			return;
        		}		
        		
        		var nRow = application.gds_marketList.addRow();
        		application.gds_marketList.copyRow(nRow, this.dsTabGubun, this.dsTabGubun.rowposition);
        		
        		this.dsTabGubun.setColumn(this.dsTabGubun.rowposition, "CART_IMG", "URL('HWImage::CellGrd_WF_CartAftbtn.png') stretch");
        		
        		trace(application.gds_marketList.saveXML("application.gds_marketList", "V"));
        		
        	}
        	
        }

        /*******************************************************************************
        * 기      능   :  검색
        * 설      명   :  등록
        ********************************************************************************/
        this.btnSearch_onclick = function(obj,e)
        {
        	this.subinvCd = this.ds_storageCd.getColumn(this.vRtn, "SUBINV_CODE");
        	
        	this.ds_condi.setColumn(0, "PR_DATE"  		, this.div_additionOrder.div_search.cal_prDate.value);	
        	this.ds_condi.setColumn(0, "SUBINV_CODE"	, this.subinvCd);
        	this.ds_condi.setColumn(0, "NEED_DATE"  	, this.div_additionOrder.div_search.cal_dtFrom.value);	
        	this.ds_condi.setColumn(0, "RC_UPJANG_NM"	, this.div_additionOrder.edt_upjang.value);
        	
        	var rcUpjangBef = application.gds_condi.getColumn(0, "RC_UPJANG");
        	var rcUpjangAft = this.ds_condi.getColumn(0, "RC_UPJANG");
        	var needDateBef = application.gds_condi.getColumn(0, "NEED_DATE");
        	var needDateAft = this.ds_condi.getColumn(0, "NEED_DATE");
        	var subinvCodeBef = application.gds_condi.getColumn(0, "SUBINV_CODE");
        	var subinvCodeAft = this.ds_condi.getColumn(0, "SUBINV_CODE");
        	
        	if(!this.gfn_isNull(rcUpjangBef))
        	{
        		if(rcUpjangBef != rcUpjangAft)
        		{
        			application.goMain.gfn_Msg("searchChk", "확정", "업장이 변경되었습니다!검색시 장바구니 내역이 사라집니다. 계속진행하시겠습니까?", "YN", true, this);
        		}
        		else if(needDateBef != needDateAft)
        		{
        			application.goMain.gfn_Msg("searchChk", "확정", "입고일이 변경되었습니다!검색시 장바구니 내역이 사라집니다. 계속진행하시겠습니까?", "YN", true, this);
        		}
        		else if(subinvCodeBef != subinvCodeAft)
        		{
        			application.goMain.gfn_Msg("searchChk", "확정", "창고가 변경되었습니다!검색시 장바구니 내역이 사라집니다. 계속진행하시겠습니까?", "YN", true, this);
        		}
        		else
        		{		
        			this.fn_search();
        		}
        	}	
            else
            {		
        		this.fn_search();
        	}
        }

        this.fn_searchBef = function()
        {
        	var sPoType   = this.ds_condi.getColumn(0, "PO_TYPE");
        	var msg = "";
        	
        	// 구매유형이 식자재추가 일경우 추가구매승인 여부에 따른 로직
        	if(sPoType == "05")
        	{
        		var sExpYn = this.ds_item_condi.getColumn(0, "EXPT_UPJANG_YN");
        		var sApvYn = this.ds_item_condi.getColumn(0, "APPROV_YN");
        		
        		if(sExpYn){	// 제외업장은 승인여부 없이 추가신청 가능
        			msg  = "추가신청 제외 업장입니다.";
        			application.goMain.gfn_Msg("search", "메세지", msg, "OK", true, this);	
        		}else{		// 제외업장이 아닐경우 추가신청승인여부에 따라 자재선택에 제한이 있다.
        			if(sApvYn == "Y"){
        				msg  = "추가구매신청이 승인된 업장입니다.";
        				application.goMain.gfn_Msg("search", "메세지", msg, "OK", true, this);	
        			}else{
        				msg  = "추가구매신청이 되지 않아 양념/미곡만 신청가능합니다.";
        				application.goMain.gfn_Msg("search", "메세지", msg, "OK", true, this);	
        			}			
        		}
        	}
        	else
        	{
        		msg  = "해당 유형은 승인여부 상관없이 구매신청가능합니다.";
        		application.goMain.gfn_Msg("search", "메세지", msg, "OK", true, this);	
        	}
        	
        	if(this.div_additionOrder.div_search.cal_dtFrom.value < "20080701")
        	{
        		application.goMain.gfn_Msg("search", "메세지", "2008년7월1일 이전 데이터는 IFIS에서 신청할 수 없습니다.", "OK", true, this);	
        			
        	}
        }

        this.fn_search = function()
        {
        	this.dsTabGubun.clearData();	
        	
        	var strSvcID,strURL,strInDatasets,strOutDatasets,strArgument,strCallbackFunc;
        	
        	application.gv_subinvCd = this.ds_storageCd.getColumn(this.vRtn, "SUBINV_CODE");
        	
        	if(this.tabIndex == "1")
        	{
        		this.ds_item_condi.setColumn(0, "ITEM_CODE"  	, this.div_additionOrder.div_search.edt_itemNm.value);
        	}
        	else
        	{
        		this.ds_item_condi.setColumn(0, "ITEM_CODE"  	, "");
        	}
        		
        	this.ds_item_condi.setColumn(0, "ITEM_CLASS1"   , this.ds_item_class1.getColumn(this.vRtn2, "cd"));	
        	this.ds_item_condi.setColumn(0, "ITEM_CLASS2"   , "");	
        	this.ds_item_condi.setColumn(0, "ITEM_CLASS3"   , "");	
        	this.ds_item_condi.setColumn(0, "ITEM_CLASS4"   , "");
        	this.ds_item_condi.setColumn(0, "BARCODE"  		, "");	
        	this.ds_item_condi.setColumn(0, "PR_DATE"  	    , this.preDate);	
        	this.ds_item_condi.setColumn(0, "NEED_DATE"  	, this.div_additionOrder.div_search.cal_dtFrom.value);	
        	this.ds_item_condi.setColumn(0, "CUSTCD"  		, "");	
        	this.ds_item_condi.setColumn(0, "SUBINV_CODE"	, this.subinvCd);
        	this.ds_item_condi.setColumn(0, "FAVOR_GROUP"	, this.ds_bookmarkCd.getColumn(this.vRtn3, "FAVOR_GROUP"));
        	
        	
        	//필수항목 
        	if (this.fn_searchChk()) return;
        	
        	// 경로 설정
        	strSvcID = "SEARCH";	
        	
        	// 추가발주 자재조회(식자재)
        	if(this.tabIndex == "1")
        	{
        		strURL   = application.services[strDataGroup].url + "fs/fsp/FSP00035E_T002.jsp";
        		// 데이터셋 설정
        		strInDatasets = "ds_item_condi=ds_item_condi";
        		strOutDatasets = "ds_grd1=ds_out";
        		
        	}
        	// 추가발주 즐겨찾기(식자재)
        	else
        	{
        		strURL   = application.services[strDataGroup].url + "fs/fsp/FSP00035E_T006.jsp";
        		// 데이터셋 설정
        		strInDatasets = "ds_favor_cond=ds_item_condi";
        		strOutDatasets = "ds_grd2=ds_out";
        	}	
        	
        	// 콜백함수 지정
        	strCallbackFunc = "fn_transation_callback";

        	this.jsp_transaction(this,strSvcID,strURL,strInDatasets,strOutDatasets,strArgument,strCallbackFunc,false,false,false);	
        }

        /*----------------------------------------------------------------------------------------------
         * 설명      : 구매유형코드 조회
         *---------------------------------------------------------------------------------------------*/
        this.fn_search_potype = function ()
        {
        	this.fsp_clear();
        	
        	var sSvcID;			// 서비스 ID
        	var sUrl;			// jsp 경로
        	var sInDs;			// 입력 데이터셋
        	var sOutDs;			// 출력 데이터셋
        	var sArg;			// 추가 파라미터
        	var sCallFunc;		// 콜백함수명
        	
        	strSvcID    = "PO_TYPE_SEARCH";
        	strURL      = application.services[strDataGroup].url + "fs/fsp/FSP00030E_T004.jsp";
        	strInDatasets     = "";
        	strOutDatasets    = "ds_potype=ds_out";
        	strCallbackFunc = "fn_transation_callback";
        	
        	strArgument = "MU_CD="+ application.g_Mu_Cd;
        	
        	this.ds_potype.clearData();
        	// 트랜잭션
        	this.jsp_transaction(this, strSvcID, strURL, strInDatasets, strOutDatasets, strArgument, strCallbackFunc, false, false, true);
        }

        /*----------------------------------------------------------------------------------------------
         * 설명      : 즐겨찾기그룹코드 조회
         *---------------------------------------------------------------------------------------------*/
        this.fn_search_group = function ()
        {
        	this.fsp_clear();
        	
        	this.ds_item_condi.setColumn(0, "UPJANG" , this.upjang);	
        	
        	var strSvcID;				// 서비스 ID
        	var strURL;					// jsp 경로
        	var strInDatasets;			// 입력 데이터셋
        	var strOutDatasets;			// 출력 데이터셋
        	var strArgument;			// 추가 파라미터
        	var strCallbackFunc;		// 콜백함수명
        	
        	strSvcID    	  = "SEARCH_GROUP";
        	strURL     		  = application.services[strDataGroup].url + "fs/fsp/FSP90020E_S002.jsp";
        	strInDatasets     = "ds_cond=ds_item_condi";
        	strOutDatasets    = "ds_bookmarkCd=ds_out";
        	strCallbackFunc   = "fn_transation_callback";
        	
        	this.ds_bookmarkCd.clearData();
        	
        	// 트랜잭션
        	this.jsp_transaction(this, strSvcID, strURL, strInDatasets, strOutDatasets, strArgument, strCallbackFunc, false, false, true);
        }

        /*******************************************************************************
        * 기      능   :  사업장 창고 호출
        * 설      명   :  사업장 창고 호출
        ********************************************************************************/
        // this.subInventorySearch = function()
        // {
        // 	var strSvcID   		 = "subInventory";
        // 	var strUrl     		 = "/ms/mom/subInventory/selectVoSubinList.xdo";
        // 	var strInDataset     = "";
        // 	var strOutDataset    = "ds_storageCd=ds_list";
        // 	var strArguments	 = "upjang=" + nexacro.wrapQuote(this.upjang);
        // 	var strCallbackFunc	 = "fn_callBack";
        // 	var bAsync			 = true;
        // 
        // 	this.gfn_transaction(this, strSvcID, strUrl, strInDataset, strOutDataset, strArguments, strCallbackFunc, bAsync);  	
        // }

        this.subInventorySearch = function()
        {
        	this.ds_condi.setColumn(0, "PR_UPJANG"		, application.g_Upjang);
        	
        	var sSvcID;			// 서비스 ID
        	var sUrl;			// jsp 경로
        	var sInDs;			// 입력 데이터셋
        	var sOutDs;			// 출력 데이터셋
        	var sArg;			// 추가 파라미터
        	var sCallFunc;		// 콜백함수명
        	
        	sSvcID    = "subInventory";
        	sUrl      = application.services[strDataGroup].url + "fs/fsp/FSP00032E_T001.jsp";
        	sInDs     = "ds_condi=ds_condi";
        	sOutDs    = "ds_storageCd=ds_out";
        	sCallFunc = "fn_callBack";
        	
        	// 트랜잭션
        	this.jsp_transaction(this, sSvcID, sUrl, sInDs, sOutDs, sArg, sCallFunc, false, false, true);
        }

        /*******************************************************************************
        * 기      능   :  승인자 데이터 호출
        * 설      명   :  승인자 데이터 호출
        ********************************************************************************/
        this.fn_SearchApprover = function()
        {
        	var strSvcID,strURL,strInDatasets,strOutDatasets,strArgument,strCallbackFunc;
        	
        	// 경로 설정	
        	strURL   = application.services[strDataGroup].url + "fs/fsp/FSP00035E_T001.jsp";
        	
        	// 데이터셋 설정
        	strInDatasets = "";
        	strOutDatasets = "ds_approver=ds_pprover";
        	
        	// 파라메터 설정
        	strArgument  = "p_PrSgn=" + nexacro.wrapQuote(application.gds_dsPoAuthType.getColumn(0,"PrSgn"));
        	strArgument += " p_PoType=" + nexacro.wrapQuote(this.ds_condi.getColumn(0,"PO_TYPE"));
        	//strArgument += " p_MuCd=" + wrapQuote(g_Mu_Cd);
        	strArgument += " p_MuCd=" + nexacro.wrapQuote("AC");
        	
        	// 콜백함수 지정
        	strCallbackFunc = "fn_SearchApproverCallback";

        	this.jsp_transaction(this, strSvcID, strURL, strInDatasets, strOutDatasets, strArgument, strCallbackFunc, false, false, false);
         }

        /*******************************************************************************
        * 기      능   :  검색필수체크
        * 설      명   :  검색필수체크
        ********************************************************************************/
        this.fn_searchChk = function ()
        {	
        	// 필수 데이터 입력 점검
        	if( this.gfn_isNull(this.div_additionOrder.edt_upjang.value) )
        	{
        		application.goMain.gfn_Msg("OK", "알림", "사업장이 누락되었습니다.", "OK", "OK");
        		return true;
        	}	
        	
        	if ( this.gfn_isNull(this.div_additionOrder.div_search.cbo_Storage.value) )
         	{
         		application.goMain.gfn_Msg("ALERT_0", "알림", "창고를 선택하세요.", "OK");
         		return true;
         	}	
        	
        	if(this.tabIndex == "1")
        	{	
        		// 필수 데이터 입력 점검(신청일, 입고일)
        		if( this.gfn_isNull(this.div_additionOrder.div_search.edt_itemNm.value) )
        		{
        			application.goMain.gfn_Msg("OK", "알림", "자재명은 필수입력입니다.", "OK", "OK");
        			return true;
        		}
        	
        	}
        	else
        	{
        		// 필수 데이터 입력 점검(신청일, 입고일)
        		if( this.gfn_isNull(this.div_additionOrder.div_search.cbo_bookmark.value) )
        		{
        			application.goMain.gfn_Msg("OK", "알림", "즐겨찾기그룹을 선택하십시요.", "OK", "OK");
        			return true;
        		}
        	}	
        	
        	if( this.gfn_isNull(this.div_additionOrder.div_search.cal_dtFrom.value) )
        	{
        		application.goMain.gfn_Msg("OK", "알림", "입고일이 누락되었습니다.", "OK", "OK");
        		return true;
        	}
        	
        	if(this.div_additionOrder.div_search.cal_dtFrom.value < this.div_additionOrder.div_search.cal_prDate.value)
        	{
        		application.goMain.gfn_Msg("OK", "알림", "※ 입고일이 신청일보다 빠를 수 없습니다.", "OK", "OK");
        		return true;
        	}

        	if( this.div_additionOrder.div_search.cal_dtFrom.value < "20080701" )
        	{
        		application.goMain.gfn_Msg("OK", "알림", "2008년7월1일 이전 데이터는 IFIS에서 신청할 수 없습니다.", "OK", "OK");
        		return true;
        	}	
        	
        	if(!this.fn_CheckDateTime()) return true;
        	
        	return false;
        }

        this.fn_CheckDateTime = function ()
        {
        	
        	if(this.ds_condi.getColumn(0, "D_DAYS") == "0") return true;
        	
        	var f_CurrDateTime = this.fn_CurrDateWeek("ymdtm");
        	
        	trace("f_CurrDateTime22 >>>" +f_CurrDateTime);
         	/*
         	if( this.dateTime(this.div_additionOrder.div_search.cal_dtFrom.value)< this.dateTime(this.gfn_AddDate(this.gfn_subStr(f_CurrDateTime,0,8),nexacro.toNumber(this.ds_type.getColumn(0, "D_DAYS")))))
         	{
         		var v_Msg;
         		v_Msg  = " ※ 현재 입고일로는 추가발주할 수 없습니다. \n\n";
         		v_Msg += "    구 매  유 형 : " + this.ds_type.getColumn(0, "PO_TYPE_NM") + "\n";
         		v_Msg += "    현 재  시 간 : " + this.fn_FormatDateTime(f_CurrDateTime) + "\n";
         		v_Msg += "    신청가능일자 : " + this.fn_FormatDateTime(this.gfn_AddDate(this.gfn_subStr(f_CurrDateTime,0,8),nexacro.toNumber(this.ds_condi.getColumn(0, "D_DAYS")))) + " (D_DAY=" + this.ds_condi.getColumn(0, "D_DAYS") + "일" + this.ds_condi.getColumn(0, "D_TIMES") + "시) \n";
         		
         		application.goMain.gfn_Msg("OK", "알림", v_Msg, "OK", "OK");
         		
         		return false;
         	}
        	*/
        	
        	if( this.div_additionOrder.div_search.cal_dtFrom.value < this.gfn_AddDate(this.gfn_subStr(f_CurrDateTime,0,8),nexacro.toNumber(this.ds_condi.getColumn(0, "D_DAYS"))))
        	{
        		var v_Msg;
        		v_Msg  = " ※ 현재 입고일로는 추가발주할 수 없습니다. \n";
        		v_Msg += "    구 매  유 형 : " + this.ds_condi.getColumn(0, "PO_TYPE_NM") + "\n";
        		v_Msg += "    현 재  시 간 : " + this.fn_FormatDateTime(f_CurrDateTime) + "\n";
        		v_Msg += "    신청가능일자 : " + this.fn_FormatDateTime(this.gfn_AddDate(this.gfn_subStr(f_CurrDateTime,0,8),nexacro.toNumber(this.ds_condi.getColumn(0, "D_DAYS")))) + " (D_DAY=" + this.ds_condi.getColumn(0, "D_DAYS") + "일" + this.ds_condi.getColumn(0, "D_TIMES") + "시) \n";
        		
        		application.goMain.gfn_Msg("OK", "알림", v_Msg, "OK", "OK");
        		
        		return false;
        	}
        	
        	/*
        	if( this.dateTime(this.div_additionOrder.div_search.cal_dtFrom.value)== this.dateTime(this.gfn_AddDate(this.gfn_subStr(f_CurrDateTime,0,8),nexacro.toNumber(this.ds_condi.getColumn(0, "D_DAYS")))))
        	{
        		if(nexacro.toNumber(this.ds_condi.getColumn(0, "D_TIMES")) == 0) return true;
        		
        		if( nexacro.toNumber(this.gfn_subStr(f_CurrDateTime,8,2)) >= nexacro.toNumber(this.ds_condi.getColumn(0, "D_TIMES")))
        		{
        			var v_Msg;
        			v_Msg  = " ※ 현재 시간은 추가발주할 수 없습니다. \n\n";
        			v_Msg += "    구 매  유 형 : " + this.ds_type.getColumn(0, "PO_TYPE_NM") + "\n";
        			v_Msg += "    현 재  시 간 : " + this.fn_FormatDateTime(f_CurrDateTime) + "\n";
        			v_Msg += "    신청가능일시 : " + this.fn_FormatDateTime(this.gfn_AddDate(this.gfn_subStr(f_CurrDateTime,0,8),nexacro.toNumber(this.ds_condi.getColumn(0, "D_DAYS")))) + " " + this.ds_condi.getColumn(0, "D_TIMES") + "시 (D_DAY=" + this.ds_condi.getColumn(0, "D_DAYS") + "일" + this.ds_condi.getColumn(0, "D_TIMES") + "시) \n";
        			
        			application.goMain.gfn_Msg("OK", "알림", v_Msg, "OK", "OK");
        			
        			return false;
        		}
        	}
        	*/
        	if( this.div_additionOrder.div_search.cal_dtFrom.value == this.gfn_AddDate(this.gfn_subStr(f_CurrDateTime,0,8),nexacro.toNumber(this.ds_condi.getColumn(0, "D_DAYS"))))
        	{
        		if(nexacro.toNumber(this.ds_condi.getColumn(0, "D_TIMES")) == 0) return true;
        		
        		if( nexacro.toNumber(this.gfn_subStr(f_CurrDateTime,8,2)) >= nexacro.toNumber(this.ds_condi.getColumn(0, "D_TIMES")))
        		{
        			var v_Msg;
        			v_Msg  = " ※ 현재 시간은 추가발주할 수 없습니다. \n";
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
        * 기      능   :  상품추가체크
        * 설      명   :  상품추가체크
        ********************************************************************************/
        this.fn_AddItem = function ()
        {
        	var nRow = this.dsTabGubun.rowposition;
        	var varNewValue = this.dsTabGubun.getColumn(nRow, "PR_QTY");
        	
        	if(this.gfn_Length(this.dsTabGubun.getColumn(nRow, "PR_REMARK")) > 0){
        		application.goMain.gfn_Msg("ALERT_0", "알림", "선택하신 자재는 사유로 인해 신청하실 수 없습니다..\n사유 : " + this.dsTabGubun.getColumn(this.dsTabGubun.rowposition, "PR_REMARK"), "OK");
        		return false;
        	}
        	
        	if (this.gfn_isNull(this.dsTabGubun.getColumn(nRow, "PR_QTY"))){
        		application.goMain.gfn_Msg("OK", "알림", "신청수량을 입력하세요.", "OK");
                return false;	
        	}
        	
        	if(this.dsTabGubun.getColumn(nRow, "PR_QTY") <= 0)
        	{
        		application.goMain.gfn_Msg("OK", "알림", "신청수량은 '0'보다 커야 합니다.", "OK");
        		return false;		
        	}	
        	
        	var nIdx = this.FindRowNF(application.gds_marketList,"ITEM_CODE",this.dsTabGubun.getColumn(nRow,"ITEM_CODE"));
        	
        	if(nIdx >= 0)
        	{
        		application.goMain.gfn_Msg("OK", "알림", "선택된 자재는 장바구니에 이미 포함되어 있습니다.", "OK");
        		return false;
        	}		
        	
        	//소숫점 발주 제한 점검
        	if(this.dsTabGubun.getColumn(nRow,"POINT_FLAG") == "N" && Math.ceil(nexacro.toNumber(varNewValue)) != nexacro.toNumber(varNewValue))
        	{
        		strMsg = " ※ 소숫점 신청 불가!!\n";
        		strMsg+= "    자재명 : " + this.dsTabGubun.getColumn(nRow,"ITEM_NAME");
        		application.goMain.gfn_Msg("OK", "알림", strMsg, "OK");
        		return false;
        	}
        	//최소발주량 제한 점검
        	else if(nexacro.toNumber(this.dsTabGubun.getColumn(nRow,"MIN_ORD_QTY")) > 0 && nexacro.toNumber(varNewValue) < nexacro.toNumber(this.dsTabGubun.getColumn(nRow,"MIN_ORD_QTY")) )
        	{
        		strMsg = " ※ 최소발주량 이하 신청 불가!!\n";
        		strMsg+= "    자재명     : " + this.dsTabGubun.getColumn(nRow,"ITEM_NAME") + "\n";
        		strMsg+= "    최소발주량 : " + this.dsTabGubun.getColumn(nRow,"MIN_ORD_QTY") + "\n";
        		application.goMain.gfn_Msg("OK", "알림", strMsg, "OK");
        		return false;
        	}
        	//최대발주량 제한 점검
        	else if(nexacro.toNumber(this.dsTabGubun.getColumn(nRow,"MAX_ORD_QTY")) > 0 && nexacro.toNumber(varNewValue) > nexacro.toNumber(this.dsTabGubun.getColumn(nRow,"MAX_ORD_QTY")) )
        	{
        		strMsg = " ※ 최대발주량 이상 신청 불가!!\n";
        		strMsg+= "    자재명     : " + this.dsTabGubun.getColumn(nRow,"ITEM_NAME") + "\n";
        		strMsg+= "    최대발주량 : " + this.dsTabGubun.getColumn(nRow,"MAX_ORD_QTY") + "\n";
        		application.goMain.gfn_Msg("OK", "알림", strMsg, "OK");
        		return false;
        	}
        	//발주승수량 제한 점검
            else if(nexacro.toNumber(this.dsTabGubun.getColumn(nRow,"MULTIPLIER_QTY")) != 0)
            {
        		var nMqty = nexacro.toNumber(this.dsTabGubun.getColumn(nRow,"MULTIPLIER_QTY"));
        		var nRt = varNewValue - (Math.floor(varNewValue / nMqty) * nMqty)
        		
        		if(nRt != 0)
            	{
        			strMsg  = " ※ 발주승수량 이외 신청 불가!!\n";
        			strMsg += "     자재명       : " + this.dsTabGubun.getColumn(nRow,"ITEM_NAME") + "\n";
        			strMsg += "     발주승수량 : "  + this.dsTabGubun.getColumn(nRow,"MULTIPLIER_QTY") + "\n";

        			application.goMain.gfn_Msg("OK", "알림", strMsg, "OK");
        			return;
        		}
            }
        	
        	//마이너스 신청 여부 점검
        	if(nexacro.toNumber(varNewValue) < 0)
        	{
        		strMsg = " ※ (-)수량 신청 신청 불가!!\n";
        		strMsg+= "    자재명 : " + this.dsTabGubun.getColumn(nRow,"ITEM_NAME");
        	
        		application.goMain.gfn_Msg("OK", "알림", strMsg, "OK");
        		return false;
        	}
        	//선발주 제한 여부 점검(조회시 미리 D-Day제한은 점검하고, "C"일 경우 D-Times만 점검한다.
        	else if(this.dsTabGubun.getColumn(nRow,"D_DAY_YN") == "C")
        	{
        		var f_CurrDateTime = this.fn_CurrDateWeek("ymdtm");
        		
        		if( nexacro.toNumber(this.gfn_subStr(f_CurrDateTime,8,2)) >= nexacro.toNumber(this.dsTabGubun.getColumn(nRow,"D_TIMES")))
        		{
        			strMsg  = " ※ 선발주 시간 제한 \n\n";
        			strMsg += "    자  재   명 : " + this.dsTabGubun.getColumn(nRow,"ITEM_NAME") + "\n";
        			strMsg += "    선발주 제한 : D_DAY=" + this.dsTabGubun.getColumn(nRow, "D_DAYS") + "일 " + this.dsTabGubun.getColumn(nRow, "D_TIMES") + "시";
        			
        			application.goMain.gfn_Msg("OK", "알림", strMsg, "OK");
        			return false;
        		}		
        	}
        	
        	this.dsTabGubun.setColumn(nRow, "PR_QTY", varNewValue);
        	this.dsTabGubun.setColumn(nRow, "PR_AMT", nexacro.toNumber(this.dsTabGubun.getColumn(nRow,"MARGIN_PRICE"))*nexacro.toNumber(varNewValue));
        	
        	return true;
        }

        /*******************************************************************************
        * 기      능   :  추가구매제외업장체크
        * 설      명   :  추가구매제외업장체크
        ********************************************************************************/
        this.fn_expt_upjang_check = function ()
        {
        	var nCnt = 0;
        		
        	// 업장이 없으면 리턴
        	if(this.gfn_isNull(this.upjang)) return;
        	
        	nCnt = this.ds_expt_upjang_list.getCaseCount("cd == '" + this.upjang + "'");

        	if(nCnt == 0)
        	{
        		this.fn_search_approve(this.upjang);	// 추가구매승인여부 조회
        	}
        	else
        	{		
        		this.ds_item_condi.setColumn(0, "EXPT_UPJANG_YN", "Y");		
        		this.fn_searchBef();
        	}
        }

        /*******************************************************************************
        * 기      능   :  추가구매승인여부체크
        * 설      명   :  추가구매승인여부체크
        ********************************************************************************/
        this.fn_search_approve = function (sUpjang)
        {
        	var sSvcID;			// 서비스 ID
        	var sUrl;			// jsp 경로
        	var sInDs;			// 입력 데이터셋
        	var sOutDs;			// 출력 데이터셋
        	var sArg;			// 추가 파라미터
        	var sCallFunc;		// 콜백함수명
        	
        	sSvcID    = "APPROVE_YN";
        	sUrl      = application.services[strDataGroup].url + "fs/fsp/FSP00030E_S001.jsp";
        	sInDs     = "";
        	sOutDs    = "ds_potype=ds_out";
        	sCallFunc = "fn_transation_callback";
        	
        	sArg = "UPJANG="+ sUpjang;
        	
        	// 트랜잭션
        	this.jsp_transaction(this, sSvcID, sUrl, sInDs, sOutDs, sArg, sCallFunc, false, false, true);
        }

        /*================================================================================
         * 5. UserFunction관련 Script
         *===============================================================================*/
         /*----------------------------------------------------------------------------------------------
         * 설명      : JSP트랜잭션 콜백 함수 (필수)
         *---------------------------------------------------------------------------------------------*/
        this.fn_transation_callback = function (nErrorCode,sErrorMag,sSvcID)
        {
        	if(nexacro.toNumber(nErrorCode) != 0)
        	{
        		application.goMain.gfn_Msg("OK", "알림", "조회 중 오류가 발생했습니다.\n에러메세지:" + errMsg, "OK");
        		return;
        	}	
        	
        	switch(sSvcID){
        		
        		case "PO_TYPE_SEARCH" :	// 구매유형
        		
        			if(application.g_Mu_Cd == "2002") //FS사업부
        			{
        				nIndex = this.ds_potype.findRowExpr("PO_TYPE=='05'");		
        			}
        			else if(application.g_Mu_Cd == "2003") //외식사업부
        			{
        				nIndex = this.ds_potype.findRowExpr("PO_TYPE=='99'");			
        			}
        			else
        			{
        				nIndex = this.ds_potype.findRowExpr("PO_TYPE=='05'");
        			}
        			
        			this.ds_condi.setColumn(0, "TYPE"			, "NEW");
        			this.ds_condi.setColumn(0, "PO_TYPE"		, this.ds_potype.getColumn(nIndex,"PO_TYPE"));
        			this.ds_condi.setColumn(0, "PO_TYPE_NM"		, this.ds_potype.getColumn(nIndex,"PO_TYPE_NM"));			
        			this.ds_condi.setColumn(0, "D_DAYS"			, this.ds_potype.getColumn(nIndex,"D_DAYS"   ));
        			this.ds_condi.setColumn(0, "D_TIMES"		, this.ds_potype.getColumn(nIndex,"D_TIMES"  ));
        			this.ds_condi.setColumn(0, "PR_NUM"			, "");
        			this.ds_condi.setColumn(0, "GROUP_CODE"		, "FM0037");			
        			break;
        		case "SEARCH_GROUP" :	// 즐겨찾기
        			if(this.ds_bookmarkCd.getCountNF() <= 0)
        			{
        				application.goMain.gfn_Msg("OK", "알림", "즐겨찾기 그룹이 존재하지 않습니다.", "OK");
        				return;		
        			}				
        			this.div_additionOrder.div_search.cbo_bookmark.set_index(0);
        			break;
        		case "SEARCH" :	// 메인조회	
        			
        			if(this.dsTabGubun.getCountNF() <= 0)
        			{
        				application.goMain.gfn_Msg("OK", "알림", "조회되는 내용이 없습니다.", "OK");
        				return;		
        			}		
        			
        			var	strRemark = "";
        			
        			for(var i = this.dsTabGubun.getCountNF()-1; i >= 0; i--)
        			{
        				strRemark = "";
        				
        				if(this.dsTabGubun.getColumn(i,"PR_YN") == "N")
        				{
        					this.dsTabGubun.setColumn(i,"PR_REMARK","요일 제한(입고가능요일:" + this.dsTabGubun.getColumn(i,"SCH_INFO") + ")");
        				}	
        				else if	(this.dsTabGubun.getColumn(i,"SHP_MAP") ==	"N")
        				{
        					strRemark = "단가계약 안됨";
        					this.dsTabGubun.setColumn(i,"PR_REMARK",strRemark);
        				}
        				else if	(this.dsTabGubun.getColumn(i,"MTG_UNS") ==	"N")
        				{
        					strRemark = "불용자재";
        					this.dsTabGubun.setColumn(i,"PR_REMARK",strRemark);
        				}
        				
        				else if	(this.dsTabGubun.getColumn(i,"MTG_STP") ==	"N")
        				{
        					strRemark = "중지자재";
        					this.dsTabGubun.setColumn(i,"PR_REMARK",strRemark);
        				}
        				
        				else if	(this.dsTabGubun.getColumn(i,"REQ_WKD") ==	"N")
        				{
        					strRemark = "요일제한";
        					this.dsTabGubun.setColumn(i,"PR_REMARK",strRemark);
        				}
        				else if(this.gfn_Length(this.dsTabGubun.getColumn(i,"RESTRICT_PERIOD"))> 0)
        				{
        					strRemark = "금지자재(" + this.dsTabGubun.getColumn(i,"RESTRICT_PERIOD") + "," + this.dsTabGubun.getColumn(i,"RESTRICT_REASON") + ")";
        					this.dsTabGubun.setColumn(i,"PR_REMARK",strRemark);
        				}	
        				else if(this.dsTabGubun.getColumn(i,"SCH") ==  "N")
        				{
        					var strRemark = "요일 제한";
        					this.dsTabGubun.setColumn(i,"PR_REMARK",strRemark);
        					this.dsTabGubun.setColumn(i,"PR_YN" , "A");
        					this.dsTabGubun.setColumn(i,"PR_QTY", 0);
        				}
        				else if( (nexacro.toNumber(this.dsTabGubun.getColumn(i,"DUTY_QTY")) > 0) && (nexacro.toNumber(this.dsTabGubun.getColumn(i,"DUTY_QTY")) <= nexacro.toNumber(this.dsTabGubun.getColumn(i,"REAL_USE_QTY"))) )
        				{
        					this.dsTabGubun.setColumn(i,"PR_REMARK","의무사용량 초과");
        				}	
        				else if(this.dsTabGubun.getColumn(i,"D_DAY_YN") == "N")
        				{						
        					strRemark = "D-" + this.dsTabGubun.getColumn(i,"D_DAYS") + "일" + this.dsTabGubun.getColumn(i,"D_TIMES") + "시 제한";
        					this.dsTabGubun.setColumn(i,"PR_REMARK",strRemark);					
        				}	
        				
        			} 	
        					
        			this.dsTabGubun.addColumn("CART_IMG", "String", 255);
        			
        			for(var i=0; i < this.dsTabGubun.rowcount; i++)
        			{		
        				this.dsTabGubun.setColumn(i, "CART_IMG", "URL('HWImage::CellGrd_WF_Cartbtn.png') stretch");
        			    
        			    //기획 아이콘
        			    if(this.dsTabGubun.getColumn(i, "FEATURE_NAME") == "theme://Images/new/grd_WF_Icon11.png")
        			    {
        					this.dsTabGubun.setColumn(i, "FEATURE_NAME", "URL('HWImage::grd_WF_Icon11.png')");
        			    }
        			    //PB상품 아이콘
        			    else if(this.dsTabGubun.getColumn(i, "FEATURE_NAME") == "theme://Images/new/grd_WF_Icon09.png")
        			    {
        					this.dsTabGubun.setColumn(i, "FEATURE_NAME", "URL('HWImage::grd_WF_Icon09.png')");
        			    }
        			    //친환경 아이콘
        			    else if(this.dsTabGubun.getColumn(i, "FEATURE_NAME") == "theme://Images/new/grd_WF_Icon08.png")
        			    {
        					this.dsTabGubun.setColumn(i, "FEATURE_NAME", "URL('HWImage::grd_WF_Icon08.png')");
        			    }
        			    //전처리 아이콘
        			    else if(this.dsTabGubun.getColumn(i, "FEATURE_NAME") == "theme://Images/new/grd_WF_Icon10.png")
        			    {
        					this.dsTabGubun.setColumn(i, "FEATURE_NAME", "URL('HWImage::grd_WF_Icon10.png')");
        			    }	
        				
        			}
        				
        			//업장, 입고예정일 및 창고코드 변경 확인후 글로벌 데이터셋 클리어 여부 판단
        			var rcUpjangBef = application.gds_condi.getColumn(0, "RC_UPJANG");
        			var rcUpjangAft = this.ds_condi.getColumn(0, "RC_UPJANG");
        			var needDateBef = application.gds_condi.getColumn(0, "NEED_DATE");
        			var needDateAft = this.ds_condi.getColumn(0, "NEED_DATE");
        			var subinvCodeBef = application.gds_condi.getColumn(0, "SUBINV_CODE");
        			var subinvCodeAft = this.ds_condi.getColumn(0, "SUBINV_CODE");			
        			
        			if(application.gds_condi.getColumn(0, "TYPE") != "NEW")
        			{
        				application.gds_marketList.clearData();
        				application.gds_condi.clearData();
        				application.gds_condi.copyData(this.ds_condi, true);	
        			}
        			else if((rcUpjangBef == rcUpjangAft) && (needDateBef == needDateAft) && (subinvCodeBef == subinvCodeAft))
        			{
        				application.gds_condi.copyData(this.ds_condi, true);	
        			}
        			else
        			{
        				application.gds_marketList.clearData();
        				application.gds_condi.clearData();
        				application.gds_condi.copyData(this.ds_condi, true);		
        			}								
        			
        			break;
        		case "APPROVE_YN" :	// 추가구매승인여부
        			this.ds_item_condi.setColumn(0, "APPROV_YN", this.fv_addApprovYn); 
        			this.fn_searchBef();		
        			break;		
        	}
        }

        this.fn_SearchApproverCallback = function ()
        {	
        }

        this.div_additionOrder_div_search_edt_itemNm_onchanged = function(obj,e)
        {
        	this.div_additionOrder.div_search.edt_itemNm.set_autoselect(false);
        }

        /*----------------------------------------------------------------------------------------------
        * 설명      : 트랜잭션 콜백 함수 (필수)
        *---------------------------------------------------------------------------------------------*/
        this.fn_callBack = function (nErrorCode,sErrorMag,sSvcID)
        {	
        	// 에러시 gfn_callBack에서 메시지 제공, 화면별 특정 에러 발생시에만 사용하세요.
        	if (nErrorCode < 0) 
        	{
        		return;
        	}
        	
            switch(sSvcID)
            {		
        		// 창고 콜백 함수
                case "subInventory" :
        			
        			//정상적으로 창고명 호출 시 창고코드 세팅
        			this.div_additionOrder.div_search.cbo_Storage.set_text(this.ds_storageCd.getColumn(0, "SUBINV_NAME"));  			
        	
          			// 추가구매제외업장 체크
        			this.fn_expt_upjang_check();
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
        			this.div_additionOrder.edt_upjang.set_value(rtn[1]);
        			this.upjang = rtn[0];	
        			this.ds_grd1.clearData();
        			this.ds_grd2.clearData();
        			this.subInventorySearch();
        			break;
        		case "Storage":
        			this.div_additionOrder.div_search.cbo_Storage.set_index(rtn);
        			this.vRtn = rtn;
        			this.ds_grd1.clearData();
        			this.ds_grd2.clearData();
        			break;
        		case "itemClass1":
        			this.div_additionOrder.div_search.cbo_itemClass1.set_index(rtn);
        			this.vRtn2 = rtn;
        			break;
        		case "bookmark":
        			this.div_additionOrder.div_search.cbo_bookmark.set_index(rtn);
        			this.vRtn3 = rtn;
        			break;
        		case "itemNm":
        			this.div_additionOrder.div_search.edt_itemNm.set_value(rtn[1]);
        			break;
        		case "itemCount":
        		    this.dsTabGubun.setColumn(this.dsTabGubun.rowposition, "PR_QTY", rtn);	
        		    this.dsTabGubun.setColumn(this.dsTabGubun.rowposition, "MOBILE_GUBUN", "M");
        		    break;	
        		case "PopCalFrom":
        			this.div_additionOrder.div_search.cal_dtFrom.set_value(rtn);
        			this.ds_grd1.clearData();
        			this.ds_grd2.clearData();
        			break;
        		case "itemImage":
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
        	if (id == "searchChk")
        	{
        		if(rtn == "Y")
        		{
        			this.fn_search();
        		}
        		else
        		{
        			return;		
        		}		
        	}
        }

        this.div_additionOrder_grd_list_onslide = function(obj,e)
        {
        	if (e.yaccvalue > 0)
        	{
        		this.parent.parent.divBottom.set_visible(true);
        		this.parent.parent.divMain.set_height(833);
        		this.parent.parent.divBottom.bringToFront();
        		
        		// 검색 영역 컨트롤
        		this.div_additionOrder.div_search.set_visible(true);
        		this.div_additionOrder.grd_list1.setOffsetTop(this.div_additionOrder.div_search.getOffsetBottom());
        		this.div_additionOrder.grd_list2.setOffsetTop(this.div_additionOrder.div_search.getOffsetBottom());
        	}
        	else if (e.yaccvalue < 0)
        	{
        		if (this.ds_grd1.getRowCount() > 0)
        		{
        			this.parent.parent.divBottom.set_visible(false);
        			this.parent.parent.divMain.set_height(923);
        			// 검색 영역 컨트롤
        			this.div_additionOrder.div_search.set_visible(false);
        			this.div_additionOrder.grd_list1.setOffsetTop(this.div_additionOrder.sta_upjang.getOffsetBottom());			
        		}
        		
        		if (this.ds_grd2.getRowCount() > 0) 
        		{
        			this.parent.parent.divBottom.set_visible(false);
        			this.parent.parent.divMain.set_height(923);
        			// 검색 영역 컨트롤
        			this.div_additionOrder.div_search.set_visible(false);			
        			this.div_additionOrder.grd_list2.setOffsetTop(this.div_additionOrder.sta_upjang.getOffsetBottom());			
        		}
        		
        	}
        }

        this.div_additionOrder_grd_list_onvscroll = function(obj,e)
        {
        	// div안의 스크롤 컨트롤일 경우 btnGoTop 대신 btnGoTopDiv 사용
        	if (e.pos == 0)
        	{
        		this.parent.btnGoTopDiv.set_visible(false);
        	}
        	else
        	{
        		this.parent.btnGoTopDiv.set_visible(true);
        		this.parent.btnGoTopDiv.set_left(420);
        		this.parent.btnGoTopDiv.set_right(65);
        		this.parent.btnGoTopDiv.set_bottom(10);		
        	}
        }

        // div안의 스크롤바 조정일 경우 아래 함수 추가
        this.fn_setDivScrollbar = function()
        {
        	// 해당 div로 바꿔준다.
        	this.div_additionOrder.grd_list1.vscrollbar.set_pos(0);
        	this.div_additionOrder.grd_list2.vscrollbar.set_pos(0);
        	// 검색 영역 컨트롤
        	this.div_additionOrder.div_search.set_visible(true);
        	this.div_additionOrder.grd_list1.setOffsetTop(this.div_additionOrder.div_search.getOffsetBottom());
        	this.div_additionOrder.grd_list2.setOffsetTop(this.div_additionOrder.div_search.getOffsetBottom());
        }

        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.btn_additionOrder.addEventHandler("onclick", this.btn_tab_onclick, this);
            this.btn_additionOrderBookMark.addEventHandler("onclick", this.btn_tab_onclick, this);
            this.div_additionOrder.addEventHandler("onvscroll", this.div_additionOrder_onvscroll, this);
            this.div_additionOrder.addEventHandler("onslide", this.div_additionOrder_onslide, this);
            this.div_additionOrder.div_search.cal_prDate.addEventHandler("ondropdown", this.div_additionOrder_cal_dtFrom_ondropdown, this);
            this.div_additionOrder.div_search.cal_prDate.addEventHandler("oneditclick", this.div_additionOrder_div_search_cal_dtFrom_oneditclick, this);
            this.div_additionOrder.div_search.btn_search.addEventHandler("onclick", this.btnSearch_onclick, this);
            this.div_additionOrder.div_search.cbo_Storage.addEventHandler("ondropdown", this.cbo_Storage_ondropdown, this);
            this.div_additionOrder.div_search.Static24.addEventHandler("onclick", this.div_additionOrder_div_search_Static24_onclick, this);
            this.div_additionOrder.div_search.Static25.addEventHandler("onclick", this.div_additionOrder_div_search_Static25_onclick, this);
            this.div_additionOrder.div_search.edt_itemNm.addEventHandler("onchanged", this.div_additionOrder_div_search_edt_itemNm_onchanged, this);
            this.div_additionOrder.div_search.cbo_itemClass1.addEventHandler("ondropdown", this.div_additionOrder_div_search_cbo_itemClass1_ondropdown, this);
            this.div_additionOrder.div_search.cbo_bookmark.addEventHandler("ondropdown", this.cbo_bookmark_ondropdown, this);
            this.div_additionOrder.div_search.sta_dtFrom.addEventHandler("onclick", this.sta_dtFrom_onclick, this);
            this.div_additionOrder.btn_upjang.addEventHandler("onclick", this.div_additionOrder_btn_upjang_onclick, this);
            this.div_additionOrder.grd_list1.addEventHandler("oncellclick", this.grd_list_oncellclick, this);
            this.div_additionOrder.grd_list1.addEventHandler("onslide", this.div_additionOrder_grd_list_onslide, this);
            this.div_additionOrder.grd_list1.addEventHandler("onvscroll", this.div_additionOrder_grd_list_onvscroll, this);
            this.div_additionOrder.grd_list1.addEventHandler("oncelldblclick", this.grd_list_oncelldblclick, this);
            this.div_additionOrder.grd_list2.addEventHandler("onvscroll", this.div_additionOrder_grd_list_onvscroll, this);
            this.div_additionOrder.grd_list2.addEventHandler("oncellclick", this.grd_list_oncellclick, this);
            this.div_additionOrder.grd_list2.addEventHandler("oncelldblclick", this.grd_list_oncelldblclick, this);
            this.div_additionOrder.grd_list2.addEventHandler("onslide", this.div_additionOrder_grd_list_onslide, this);

        };

        this.loadIncludeScript("AdditionOrder_copy.xfdl", true);

       
    };
}
)();
