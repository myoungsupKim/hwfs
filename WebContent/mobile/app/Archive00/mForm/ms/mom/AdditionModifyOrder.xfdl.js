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
                this.set_name("AdditionModifyOrder");
                this.set_titletext("추가발주수정");
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
            obj._setContents("<ColumnInfo><Column id=\"ITEM_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_CLASS4\" type=\"STRING\" size=\"256\"/><Column id=\"FEATURE_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_SIZE\" type=\"STRING\" size=\"256\"/><Column id=\"PO_UOM\" type=\"STRING\" size=\"256\"/><Column id=\"KG_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"CANCEL_PR_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"G_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"PR_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"PR_AMT\" type=\"STRING\" size=\"256\"/><Column id=\"TOT_AMT\" type=\"STRING\" size=\"256\"/><Column id=\"TAX_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"CENTER_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"PR_REMARK\" type=\"STRING\" size=\"256\"/><Column id=\"REMARK\" type=\"STRING\" size=\"256\"/><Column id=\"POINT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"SUBINV_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"NEED_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"DEPT_ID\" type=\"STRING\" size=\"256\"/><Column id=\"ACCTCD\" type=\"STRING\" size=\"256\"/><Column id=\"BUD_CLS\" type=\"STRING\" size=\"256\"/><Column id=\"MU_CD\" type=\"STRING\" size=\"256\"/><Column id=\"INVAT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"OUTVAT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"MIN_ORD_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"MAX_ORD_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"CENTER_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"STOCK_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"BARCODE\" type=\"STRING\" size=\"256\"/><Column id=\"KEEPING_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"MULTIPLIER_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"BUDDEPT_ID\" type=\"STRING\" size=\"256\"/><Column id=\"USE_YN\" type=\"STRING\" size=\"256\"/><Column id=\"CONTRACT_YN\" type=\"STRING\" size=\"256\"/><Column id=\"MARGIN_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"UNIT_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"CUSTCD\" type=\"STRING\" size=\"256\"/><Column id=\"CHEAP_YN\" type=\"STRING\" size=\"256\"/><Column id=\"KG_CONVERT_RATE\" type=\"STRING\" size=\"256\"/><Column id=\"MARGIN_RATE\" type=\"STRING\" size=\"256\"/><Column id=\"AP_UNITPRICE_UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"RESTRICT_PERIOD\" type=\"STRING\" size=\"256\"/><Column id=\"RESTRICT_REASON\" type=\"STRING\" size=\"256\"/><Column id=\"DUTY_END_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"MIN_DUTY_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"DUTY_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"REAL_USE_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"PR_YN\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAY\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAYS\" type=\"STRING\" size=\"256\"/><Column id=\"D_TIMES\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAY_YN\" type=\"STRING\" size=\"256\"/><Column id=\"SPICE_YN\" type=\"STRING\" size=\"256\"/><Column id=\"CORN_YN\" type=\"STRING\" size=\"256\"/><Column id=\"IMG_PATH\" type=\"STRING\" size=\"256\"/><Column id=\"ORIGIN_NAT\" type=\"STRING\" size=\"256\"/><Column id=\"ORIGIN_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"VD_SN\" type=\"STRING\" size=\"256\"/><Column id=\"APPLY_SD\" type=\"STRING\" size=\"256\"/><Column id=\"UPJANG_GRP\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_potype", this);
            obj._setContents("<ColumnInfo><Column id=\"PO_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"PO_TYPE_NM\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAY\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAYS\" type=\"STRING\" size=\"256\"/><Column id=\"D_TIMES\" type=\"STRING\" size=\"256\"/><Column id=\"REMARK\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_approver", this);
            obj._setContents("<ColumnInfo><Column id=\"SABUN\" size=\"20\" type=\"STRING\"/><Column id=\"NM_KOR\" size=\"100\" type=\"STRING\"/></ColumnInfo>");
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

            obj = new Dataset("ds_master", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"MOBILE_GUBUN\" type=\"STRING\" size=\"256\"/><Column id=\"PR_NUM\" type=\"STRING\" size=\"256\"/><Column id=\"CUSTCD\" type=\"STRING\" size=\"256\"/><Column id=\"CUSTNM\" type=\"STRING\" size=\"256\"/><Column id=\"PR_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"CC_NM\" type=\"STRING\" size=\"256\"/><Column id=\"SUBINV_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"SUBINV_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_TITLE\" type=\"STRING\" size=\"256\"/><Column id=\"TYPE_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"AMT\" type=\"STRING\" size=\"256\"/><Column id=\"VAT\" type=\"STRING\" size=\"256\"/><Column id=\"TOT\" type=\"STRING\" size=\"256\"/><Column id=\"CODE_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"LINE_STATUS\" type=\"STRING\" size=\"256\"/><Column id=\"PR_SABUN\" type=\"STRING\" size=\"256\"/><Column id=\"PR_APPROVE_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"PO_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"NEED_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"PR_DEPT_ID\" type=\"STRING\" size=\"256\"/><Column id=\"RC_UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"MOBILE_GUBUN_IMG\" type=\"STRING\" size=\"256\"/><Column id=\"CLOSE_YN\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
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
            obj._setContents("<ColumnInfo><Column id=\"APPROV_YN\" type=\"STRING\" size=\"256\"/><Column id=\"PR_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"NEED_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"SUBINV_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_CLASS1\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_CLASS2\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_CLASS3\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_CLASS4\" type=\"STRING\" size=\"256\"/><Column id=\"BARCODE\" type=\"STRING\" size=\"256\"/><Column id=\"CUSTCD\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row/></Rows>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_condiMaster", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"MU_CD\" type=\"STRING\" size=\"256\"/><Column id=\"TM_CD\" type=\"STRING\" size=\"256\"/><Column id=\"DATE_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"DT_FR\" type=\"STRING\" size=\"256\"/><Column id=\"DT_TO\" type=\"STRING\" size=\"256\"/><Column id=\"PO_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"PR_UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"PR_SABUN\" type=\"STRING\" size=\"256\"/><Column id=\"PR_DEPT_ID\" type=\"STRING\" size=\"256\"/><Column id=\"RC_UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"RC_UPJANG_NM\" type=\"STRING\" size=\"256\"/><Column id=\"GROUP_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"CHK_CUST\" type=\"STRING\" size=\"256\"/><Column id=\"CHK_DEPT\" type=\"STRING\" size=\"256\"/><Column id=\"CHK_STATUS\" type=\"STRING\" size=\"256\"/><Column id=\"LINE_STATUS\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_detail", this);
            obj._setContents("<ColumnInfo><Column id=\"ITEM_CODE\" size=\"256\" type=\"STRING\"/><Column id=\"ITEM_NAME\" size=\"256\" type=\"STRING\"/><Column id=\"ITEM_SIZE\" size=\"256\" type=\"STRING\"/><Column id=\"PO_UOM\" size=\"256\" type=\"STRING\"/><Column id=\"TAX_CODE\" size=\"256\" type=\"STRING\"/><Column id=\"PR_REMARK\" size=\"256\" type=\"STRING\"/><Column id=\"NEED_DATE\" size=\"256\" type=\"STRING\"/><Column id=\"MARGIN_PRICE\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"PR_QTY\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"PO_QTY\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"PR_AMT\" size=\"22\" type=\"BIGDECIMAL\"/><Column id=\"SUBINV_CODE\" size=\"256\" type=\"STRING\"/><Column id=\"SUBINV_NAME\" size=\"256\" type=\"STRING\"/><Column id=\"CC_NM\" size=\"256\" type=\"STRING\"/><Column id=\"CODE_NAME\" size=\"256\" type=\"STRING\"/><Column id=\"PR_ID\" size=\"256\" type=\"STRING\"/><Column id=\"PR_DATE\" size=\"256\" type=\"STRING\"/><Column id=\"PO_TYPE\" size=\"256\" type=\"STRING\"/><Column id=\"DML\" size=\"256\" type=\"STRING\"/><Column id=\"LINE_STATUS\" size=\"256\" type=\"STRING\"/><Column id=\"CUSTNM\" size=\"256\" type=\"STRING\"/><Column id=\"SCHOOL_YN\" size=\"1\" type=\"STRING\"/><Column id=\"PR_NUM\" size=\"256\" type=\"STRING\"/><Column id=\"ORG_PR_NUM\" type=\"STRING\" size=\"256\"/><Column id=\"RC_UPJANG\" size=\"22\" type=\"STRING\"/><Column id=\"RC_UPJANG_NM\" type=\"STRING\" size=\"256\"/><Column id=\"CONTRACT_TABLE\" size=\"256\" type=\"STRING\"/><Column id=\"MAX_LINE_STATUS\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_condi_detail", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"PR_NUM\" type=\"STRING\" size=\"256\"/><Column id=\"DATE_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"DT_FR\" type=\"STRING\" size=\"256\"/><Column id=\"DT_TO\" type=\"STRING\" size=\"256\"/><Column id=\"CUSTCD\" type=\"STRING\" size=\"256\"/><Column id=\"SUBINV_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"RC_DEPT_ID\" type=\"STRING\" size=\"256\"/><Column id=\"LINE_STATUS\" type=\"STRING\" size=\"256\"/><Column id=\"GROUP_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"CHK_CUST\" type=\"STRING\" size=\"256\"/><Column id=\"CHK_DEPT\" type=\"STRING\" size=\"256\"/><Column id=\"CHK_STATUS\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_line_status", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"256\"/><Column id=\"cdNm\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
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
            obj = new Div("div_additionOrder", "absolute", "0", "1", "540", null, null, "0", this);
            obj.set_taborder("89");
            obj.style.set_background("white");
            this.addChild(obj.name, obj);
            obj = new Div("div_search", "absolute", "0%", "58", null, "60", "0.37%", null, this.div_additionOrder);
            obj.set_taborder("11");
            this.div_additionOrder.addChild(obj.name, obj);
            obj = new Static("Static22", "absolute", "0%", "1", null, "59", "0%", null, this.div_additionOrder.div_search);
            obj.set_taborder("12");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.div_additionOrder.div_search.addChild(obj.name, obj);
            obj = new Calendar("cal_prDate", "absolute", "313", "7", null, "47", "30", null, this.div_additionOrder.div_search);
            this.div_additionOrder.div_search.addChild(obj.name, obj);
            obj.set_taborder("22");
            obj.set_displaynulltext("2015-12-29");
            obj.set_dateformat("yyyy-MM-dd");
            obj.set_visible("false");
            obj.set_value("null");
            obj = new Button("btn_search", "absolute", "428", "7", null, "47", "10", null, this.div_additionOrder.div_search);
            obj.set_taborder("21");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.div_additionOrder.div_search.addChild(obj.name, obj);
            obj = new Calendar("cal_dtFrom", "absolute", "21%", "7", null, "47", "42.75%", null, this.div_additionOrder.div_search);
            this.div_additionOrder.div_search.addChild(obj.name, obj);
            obj.set_taborder("15");
            obj.set_dateformat("yyyy-MM-dd");
            obj.set_displaynulltext("2015-12-29");
            obj = new Static("Static24", "absolute", "0%", "1", null, "59", "79.55%", null, this.div_additionOrder.div_search);
            obj.set_taborder("16");
            obj.set_text("입고일");
            obj.set_cssclass("sta_WF_Label02");
            this.div_additionOrder.div_search.addChild(obj.name, obj);
            obj = new Static("Static25", "absolute", "17.29%", "1", null, "59", "79%", null, this.div_additionOrder.div_search);
            obj.set_taborder("17");
            obj.set_text("글자사이간격w20");
            obj.set_cssclass("sta_GUIDE_Area2");
            obj.set_visible("false");
            this.div_additionOrder.div_search.addChild(obj.name, obj);
            obj = new Static("sta_dtFrom", "absolute", "113", "7", "196", "47", null, null, this.div_additionOrder.div_search);
            obj.set_taborder("23");
            this.div_additionOrder.div_search.addChild(obj.name, obj);
            obj = new Static("Static00", "absolute", "0", "1", null, "59", "1", null, this.div_additionOrder);
            obj.set_taborder("13");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.div_additionOrder.addChild(obj.name, obj);
            obj = new Edit("edt_upjang", "absolute", "10", "7", null, "47", "12", null, this.div_additionOrder);
            obj.set_taborder("14");
            obj.set_displaynulltext("사업장을 입력하세요");
            obj.set_autoselect("true");
            obj.set_readonly("true");
            this.div_additionOrder.addChild(obj.name, obj);
            obj = new Button("btn_upjang", "absolute", null, "7", "47", "47", "12", null, this.div_additionOrder);
            obj.set_taborder("15");
            obj.set_cssclass("btn_WF_EdtSearch");
            this.div_additionOrder.addChild(obj.name, obj);
            obj = new Grid("grd_list", "absolute", "0%", "117", null, null, "0%", "0", this.div_additionOrder);
            obj.set_taborder("12");
            obj.set_binddataset("ds_master");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_cssclass("grd_WF_Default2");
            obj.set_autosizingtype("none");
            obj.set_extendsizetype("none");
            obj.set_nodataimage("URL('theme://Image/grd_WF_NoDataImg.png')");
            obj.set_fillareatype("none");
            obj.set_selecttype("row");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"128\"/><Column size=\"171\"/><Column size=\"147\"/><Column size=\"93\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"50\"/><Row size=\"4\"/></Rows><Band id=\"head\"><Cell/><Cell col=\"1\" text=\"Column0\"/><Cell col=\"2\"/><Cell col=\"3\"/></Band><Band id=\"body\"><Cell style=\"align:left middle;padding:0 10 0 10;line:0 solid #808080ff ;\" text=\"신청번호\"/><Cell col=\"1\" colspan=\"2\" style=\"align:left middle;padding:0 10 0 10;line:0 solid #808080ff ;\" text=\"bind:PR_NUM\" wordwrap=\"char\" autosizerow=\"limitmin\" autosizecol=\"default\"/><Cell col=\"3\" displaytype=\"button\" style=\"align:center middle;padding:5 20 5 20;line:0 solid transparent ;controlbackground:BIND(MOBILE_GUBUN_IMG);controlborder:0 solid #808080ff ;\" wordwrap=\"char\" calendardisplay=\"edit\" autosizerow=\"limitmin\" autosizecol=\"default\"/><Cell row=\"1\" style=\"align:left middle;padding:0 10 0 10;line:0 solid #808080ff ;\" text=\"제목\"/><Cell row=\"1\" col=\"1\" colspan=\"2\" style=\"align:left middle;padding:0 10 0 10;line:0 solid #808080ff ;\" text=\"bind:ITEM_TITLE\" wordwrap=\"char\" autosizerow=\"limitmin\" autosizecol=\"default\"/><Cell row=\"1\" col=\"3\" displaytype=\"button\" edittype=\"button\" style=\"align:center middle;padding:5 5 5 5;line:0 solid transparent ;controlbackground:EXPR(LINE_STATUS == &quot;003&quot;?&quot;&quot;:(LINE_STATUS == &quot;PD&quot;?&quot;&quot;:(LINE_STATUS == &quot;001&quot;?&quot;&quot;:(LINE_STATUS == &quot;002&quot;?&quot;&quot;:(LINE_STATUS == &quot;PC&quot;?&quot;&quot;:&quot;silver&quot;)))));controlborder:0 solid #808080ff ;\" text=\"expr:LINE_STATUS == &quot;003&quot;?&quot;재작성&quot;:(LINE_STATUS == &quot;PD&quot;?&quot;재작성&quot;:&quot;수정&quot;)\" wordwrap=\"char\" calendardisplay=\"edit\" autosizerow=\"limitmin\" autosizecol=\"default\"/><Cell row=\"2\" style=\"align:left middle;padding:0 10 0 10;line:0 solid #808080ff ;\" text=\"신청/상태\"/><Cell row=\"2\" col=\"1\" displaytype=\"date\" style=\"align:left middle;padding:0 10 0 10;line:0 none #808080ff ;\" text=\"bind:PR_DATE\" wordwrap=\"char\" autosizerow=\"limitmin\" autosizecol=\"default\"/><Cell row=\"2\" col=\"2\" displaytype=\"combo\" style=\"align:left middle;padding:0 10 0 10;line:0 solid #808080ff ;color:red;color2:red;selectcolor:red;\" text=\"bind:LINE_STATUS\" wordwrap=\"char\" combodataset=\"ds_line_status\" combocodecol=\"cd\" combodatacol=\"cdNm\" autosizerow=\"limitmin\" autosizecol=\"default\"/><Cell row=\"2\" col=\"3\" displaytype=\"button\" edittype=\"button\" style=\"align:center middle;padding:5 5 5 5;line:0 solid transparent ;controlbackground:EXPR(LINE_STATUS == &quot;001&quot;?&quot;&quot;:(LINE_STATUS == &quot;002&quot;?&quot;&quot;:(LINE_STATUS == &quot;PC&quot;?&quot;&quot;:&quot;silver&quot;)));controlborder:0 solid #808080ff ;\" text=\"삭제\" wordwrap=\"char\" calendardisplay=\"edit\" autosizerow=\"limitmin\" autosizecol=\"default\"/><Cell row=\"3\"/><Cell row=\"3\" col=\"1\" autosizerow=\"limitmax\" autosizecol=\"default\"/><Cell row=\"3\" col=\"2\" autosizerow=\"limitmax\" autosizecol=\"default\"/><Cell row=\"3\" col=\"3\" autosizerow=\"limitmax\" autosizecol=\"default\"/></Band></Format></Formats>");
            this.div_additionOrder.addChild(obj.name, obj);

            obj = new Static("Static04", "absolute", "0", "0", null, "2", "0", null, this);
            obj.set_taborder("90");
            obj.set_cssclass("sta_WF_TopLine");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 0, 60, this.div_additionOrder.div_search,
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
            		p.set_titletext("추가발주수정");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("AdditionModifyOrder.xfdl", "lib::lib_Com.xjs");
        this.registerScript("AdditionModifyOrder.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		발주관리
        // [부시스템명]	추가발주수정
        // [설명]
        // 		추가발주수정 및 장바구니 등록
        // [작성자명] 		강대성
        // [작성일자]		2015.02.04
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.04 : 강대성 : 화면신규생성.
        // 2015.06.14 : 강대성 : 업무로직 추가.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/
        this.preDate = undefined;
        this.fv_totalpageRow;	// 전체건수
        this.upjang = undefined;
        var fv_type = "";
        this.nIndex;
        this.vCell = 0; //cell값 변수
        var strDataGroup = "U_svc";

        /*================================================================================
         * 2. Form관련 Script
         *===============================================================================*/
        /*******************************************************************************
        * 기      능   :  form_onload
        * 설      명   :  Form의 모든 컴포넌트가 생성되고, 모든 Object가 Load 되었을 때에 발생하는 Event
        ********************************************************************************/ 
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

        /*******************************************************************************
        * 기      능   :  fn_init
        * 설      명   :  데이터 초기화
        ********************************************************************************/
        this.fn_init = function ()
        {
        	application.g_System_Mst = "";
        	
        	this.fsp_init();
        	application.gds_marketList.clearData();		
        	application.gds_condi.clearData();	
        	
        	// 진행상태코드
        	this.fn_common_code("FM0037", "", "");	
        	this.ds_line_status.copyData(application.gds_common_code);
        						
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
        	
        	//초기 데이터 셋 세팅
        	nIndex = this.ds_condiMaster.addRow();
        	this.ds_condiMaster.setColumn(nIndex, "PR_SABUN"	, application.g_EmpNo);
        	this.ds_condiMaster.setColumn(nIndex, "PR_DEPT_ID"	, application.g_Deptid);
        	this.ds_condiMaster.setColumn(nIndex, "PR_UPJANG"	, application.g_Upjang);
        	this.ds_condiMaster.setColumn(nIndex, "GROUP_CODE"	, "FM0037");
        	
        	this.fn_PoCommon();
        	
        	this.fn_CurrDateWeek("ymdtm");
        	
        	this.fn_search_potype();	
        	
        }

        /*******************************************************************************
        * 기      능   :  사업장 검색 팝업
        * 설      명   :  사업장 검색 팝업
        ********************************************************************************/
        this.div_additionOrder_btn_upjang_onclick = function(obj,e)
        {
        	var arg = new Array();
        	if(this.fn_masterRole())
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
        		if(application.g_useTmCd == "Y")
        		{
        			arg[7] = application.g_Tm_Cd;
        		}
        		arg[8] = application.g_Mu_Cd;
        		arg[9] = application.g_UpjangGubun;
        		arg[11] = application.g_UpjangFlag1;
        		arg[12] = application.g_UpjangFlag2;
        	}	
        	
        	application.goMain.gfn_POP_create("upjangNm", "M_MLM::WorkplaceSearchPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	return false;
        }

        /*******************************************************************************
        * 기      능   :  달력 클릭 시
        * 설      명   :  달력 클릭 시
        ********************************************************************************/ 
        this.sta_dtFrom_onclick = function(obj,e)
        {
        	var objCalArg = this.div_additionOrder.div_search.cal_dtFrom.value;
        	
        	application.goMain.gfn_POP_create("PopCalFrom", "cmmn::CmmnCalendarPop.xfdl", "fn_callbackPOP", this, objCalArg, "POP", application.goMain.divBase);
        	return false;
        }

        /*******************************************************************************
        * 기      능   :  그리드 CELL선택시
        * 설      명   :  그리드 CELL선택시
        ********************************************************************************/ 
        this.grd_list_oncellclick = function(obj,e)
        {
        	this.vCell = e.cell;
        	
        	this.fn_searchDetail();	
        	
        }

        /*================================================================================
         * 3. SERVICE호출 Script
         *===============================================================================*/
        /*******************************************************************************
        * 기      능   :  검색
        * 설      명   :  추가발주자재 조회
        ********************************************************************************/
        this.btnSearch_onclick = function(obj,e)
        {
        	this.fn_search();
        }

        this.fn_search = function()
        {
        	// 입력 데이터셋 셋팅
        	var nRow = this.ds_condiMaster.rowposition;
        	this.ds_condiMaster.setColumn(nRow, "RC_UPJANG"	  , this.upjang);          //업장코드
        	this.ds_condiMaster.setColumn(nRow, "DT_FR"		  , this.div_additionOrder.div_search.cal_dtFrom.value);          //입고일자
        	this.ds_condiMaster.setColumn(nRow, "DT_TO"       , this.div_additionOrder.div_search.cal_dtFrom.value);          //입고일자
        	
        	if(application.g_Mu_Cd == "2002") //FS사업부
        	{
        		this.ds_condiMaster.setColumn(nRow, "PO_TYPE"  	  , "05");			
        	}
        	else if(application.g_Mu_Cd == "2003") //외식사업부
        	{
        		this.ds_condiMaster.setColumn(nRow, "PO_TYPE"  	  , "99");				
        	}	
        	else
        	{
        		this.ds_condiMaster.setColumn(nRow, "PO_TYPE"  	  , "05");	
        	}
        	
        	this.ds_condiMaster.setColumn(nRow, "MU_CD"    	  , application.g_Mu_Cd);                                         //사업장코드
        	
        	this.ds_condiMaster.setColumn(nRow, "DATE_TYPE"     , "1");
        	this.ds_condiMaster.setColumn(nRow, "CHK_CUST"      , "N");
        	this.ds_condiMaster.setColumn(nRow, "CHK_DEPT"      , "N");
        	this.ds_condiMaster.setColumn(nRow, "CHK_STATUS"    , "N");

        
        	var sSvcID;			// 서비스 ID
        	var sUrl;			// jsp 경로
        	var sInDs;			// 입력 데이터셋
        	var sOutDs;			// 출력 데이터셋
        	var sArg;			// 추가 파라미터
        	var sCallFunc;		// 콜백함수명
        	
        	this.fsp_clear();	// Action 호출 정보 초기화하기	
        	
        	sSvcID		= "SEARCH";
        	sUrl		= application.services[strDataGroup].url + "fs/fsp/FSP00030E_T001.jsp";
        	sInDs		= "ds_condi=ds_condiMaster";
        	sOutDs		= "ds_master=ds_master";
        	sCallFunc 	= "fn_transation_callback";
        	
        	// 데이터셋 초기화
        	this.ds_master.clearData();
        	
        	// 트랜잭션
        	this.jsp_transaction(this, sSvcID, sUrl, sInDs, sOutDs, sArg, sCallFunc, true, false, false);
        	
        }

        /*******************************************************************************
        * 기      능   :  검색
        * 설      명   :  구매내역 상세 조회
        ********************************************************************************/
        this.fn_searchDetail = function ()
        {
        	var sSvcID;			// 서비스 ID
        	var sUrl;			// jsp 경로
        	var sInDs;			// 입력 데이터셋
        	var sOutDs;			// 출력 데이터셋
        	var sArg;			// 추가 파라미터
        	var sCallFunc;		// 콜백함수명
        	
        	var nRow;
        	this.ds_condi_detail.clearData();
        	nRow = this.ds_condi_detail.addRow();
        	
        	// 경로 설정
        	sSvcID = "DETAIL";
        	sUrl   = application.services[strDataGroup].url + "fs/fsp/FSP00030E_T002.jsp";
        	
        	// 데이터셋 설정
        	sInDs  = "ds_condi_detail=ds_condi_detail";
        	sOutDs = "ds_detail=ds_detail";
        	
        	// 조회 조건값 설정
        	this.ds_condi_detail.setColumn(nRow, "PR_NUM"		, this.ds_master.getColumn(this.ds_master.rowposition, "PR_NUM")	);		// 신청번호
        	this.ds_condi_detail.setColumn(nRow, "DATE_TYPE"	, "1" 										                );		// 날짜구분
        	this.ds_condi_detail.setColumn(nRow, "DT_FR"		, this.div_additionOrder.div_search.cal_dtFrom.value	    );		// 시작일자
        	this.ds_condi_detail.setColumn(nRow, "DT_TO"		, this.div_additionOrder.div_search.cal_dtFrom.value		);		// 종료일자
        	this.ds_condi_detail.setColumn(nRow, "CUSTCD"		, ""														);		// 거래처코드
        	this.ds_condi_detail.setColumn(nRow, "LINE_STATUS"	, this.ds_master.getColumn(this.ds_master.rowposition, "LINE_STATUS"	));		// 진행상황 
        	this.ds_condi_detail.setColumn(nRow, "SUBINV_CODE"	, this.ds_master.getColumn(this.ds_master.rowposition, "SUBINV_CODE"	));
        	this.ds_condi_detail.setColumn(nRow, "GROUP_CODE"	, "FM0037"								);		// 공통그룹코드
        	this.ds_condi_detail.setColumn(nRow, "CHK_CUST"		, "N"						);		// 신청번호
        	this.ds_condi_detail.setColumn(nRow, "CHK_DEPT"		, "N"						);		// 신청번호
        	this.ds_condi_detail.setColumn(nRow, "CHK_STATUS"	, "N"						);		// 신청번호
        	
        	// 콜백함수 지정
        	sCallFunc = "fn_transation_callback";

        	this.jsp_transaction(this, sSvcID, sUrl, sInDs, sOutDs, sArg, sCallFunc, false, false, false);
        }

        /*******************************************************************************
        * 기      능   :  검색
        * 설      명   :  추가발주자재조회(신청번호)
        ********************************************************************************/
        this.fn_SearchPr = function ()
        {
        	
        	var strSvcID,strURL,strInDatasets,strOutDatasets,strArgument,strCallbackFunc;
        	
        	// 경로 설정
        	strSvcID = "PR_SEARCH";
        	strURL   = application.services[strDataGroup].url + "fs/fsp/FSP00035E_T003.jsp";
        	
        	// 데이터셋 설정
        	strInDatasets = "ds_condi=ds_condi";
        	strOutDatasets = "ds_grd=ds_pr_item ds_reson_save=ds_reson_save";
        	strCallbackFunc = "fn_transation_callback";
        	
        	this.ds_grd.clearData();
        	
         	// 콜백함수 지정
        	strCallbackFunc = "fn_transation_callback";
        	
        	this.jsp_transaction(this,strSvcID,strURL,strInDatasets,strOutDatasets,strArgument,strCallbackFunc,false,false,false);
        }

        /*******************************************************************************
        * 기      능   :  삭제
        * 설      명   :  신청서 삭제
        ********************************************************************************/
        this.fn_delete = function ()
        {	
        	var sSvcID;			// 서비스 ID
        	var sUrl;			// jsp 경로
        	var sInDs;			// 입력 데이터셋
        	var sOutDs;			// 출력 데이터셋
        	var sArg;			// 추가 파라미터
        	var sCallFunc;		// 콜백함수명
        	
        	// 경로 설정
        	sSvcID = "DELETE";
        	sUrl   = application.services[strDataGroup].url + "fs/fsp/FSP00030E_T008.jsp";
        	
        	// 데이터셋 설정
        	sInDs  = "dsPoType=gds_dsPoType dsPoLineStatus=gds_dsPoLineStatus";
        	sOutDs = "";
        	
        	// 파라메터 설정
        	sArg  = "p_PrNum="          + nexacro.wrapQuote(this.ds_detail.getColumn(this.ds_detail.rowposition, "PR_NUM"));
        	sArg += " p_PoType="        + nexacro.wrapQuote(this.ds_detail.getColumn(this.ds_detail.rowposition, "PO_TYPE"));
        	sArg += " p_NeedDate="      + nexacro.wrapQuote(this.ds_detail.getColumn(this.ds_detail.rowposition, "NEED_DATE"));
        	sArg += " p_SubinvCode="    + nexacro.wrapQuote(this.ds_detail.getColumn(this.ds_detail.rowposition, "SUBINV_CODE"));
        	sArg += " g_EmpNo="         + nexacro.wrapQuote(application.g_EmpNo);
        	sArg += " p_RcUpjang="      + nexacro.wrapQuote(this.ds_detail.getColumn(this.ds_detail.rowposition, "RC_UPJANG"));
        	sArg += " p_LineStatus="    + nexacro.wrapQuote(this.ds_detail.getColumn(this.ds_detail.rowposition, "LINE_STATUS"));
        	sCallFunc = "fn_transation_callback";
        	
        	if(!this.fn_transation_validation(sSvcID)) return;

        	this.jsp_transaction(this, sSvcID, sUrl, sInDs, sOutDs, sArg, sCallFunc, false, false, false);
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
        	strCallbackFunc   = "fn_transation_callback";
        	
        	strArgument = "MU_CD="+ application.g_Mu_Cd;
        	
        	this.ds_potype.clearData();
        	// 트랜잭션
        	this.jsp_transaction(this, strSvcID, strURL, strInDatasets, strOutDatasets, strArgument, strCallbackFunc, false, false, true);
        }

        /*******************************************************************************
        * 기      능   :  승인자 데이터 호출
        * 설      명   :  승인자 데이터 호출
        ********************************************************************************/
        this.fn_SearchApprover = function()
        {
        	var strSvcID,strURL,strInDatasets,strOutDatasets,strArgument,strCallbackFunc;
        	
        	// 경로 설정
        	strSvcID = "FSP00035E_T001";
        	strURL   = application.services[strDataGroup].url + "fs/fsp/FSP00035E_T001.jsp";
        	
        	// 데이터셋 설정
        	strInDatasets = "";
        	strOutDatasets = "ds_approver=ds_pprover";
        	
        	// 파라메터 설정
        	strArgument  = "p_PrSgn=" + nexacro.wrapQuote(application.gds_dsPoAuthType.getColumn(0,"PrSgn"));
        	strArgument += " p_PoType=" + nexacro.wrapQuote(this.ds_type.getColumn(0,"PO_TYPE"));
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
        	// 필수 데이터 입력 점검(신청일, 입고일)
        	if( this.gfn_isNull(this.div_additionOrder.edt_upjang.value) )
        	{
        		application.goMain.gfn_Msg("OK", "알림", "사업장이 누락되었습니다.", "OK", "OK");
        		return true;
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
        	
        	return false;
        }

        /*******************************************************************************
        * 기      능   :  삭제전
        * 설      명   :  삭제전 유효성체크
        ********************************************************************************/
        this.fn_transation_validation = function (sSvcID)
        {
        	switch(sSvcID)
        	{
        		case "DELETE" :
        			
        			var nIdx = this.ds_potype.findRowExpr("PO_TYPE=='" + this.ds_detail.getColumn(this.ds_detail.rowposition,"PO_TYPE")+"'");
        			
        			// 신청서 재작성&수정시 수정가능한 시간 체크
        			if(!this.fn_CheckDateTime(nIdx)) return;
        			
        			//결의 이상의 작업이 진행되었는지 확인
        			if(!this.fn_CheckPoYN(this.ds_detail.getColumn(this.ds_detail.rowposition, "ORG_PR_NUM"))) return false;
        			
        			break;		
        		
        	}
        	
        	return true;
        }

        /*
         ******************************************************************************************
         * 함  수  명   : fn_CheckPoYN()
         * 입      력   : 없음
         * 반      환   : 없음
         * 기      능   : 신청서 수정 중 결의 여부 점검
         * 작  성  자   : 김동표
         * 작성  일자   : 2008-01-31
         * ----------------------------------------------------------------------------------------
         * HISTORY    :
         ******************************************************************************************
        */
        var v_ItemName;
        this.fn_CheckPoYN = function (strPrNum)
        {
        	var strSvcID,strURL,strInDatasets,strOutDatasets,strArgument,strCallbackFunc;
        	
        	// 경로 설정
        	strSvcID = "CHECK_PO";
        	strURL   = application.services[strDataGroup].url + "fs/fsp/FSP00032E_T008.jsp";
        	
        	// 데이터셋 설정
        	strInDatasets = "dsPoLineStatus=gds_dsPoLineStatus";
        	strOutDatasets = "";
        	
        	// 파라메터 설정
        	strArgument  = "p_PrNum=" + nexacro.wrapQuote(strPrNum);
        	
        	// 콜백함수 지정
        	strCallbackFunc = "";

        	this.jsp_transaction(this, strSvcID, strURL, strInDatasets, strOutDatasets, strArgument, strCallbackFunc, false, false, true);
        	
        	var strMsg;
        	
        	if(this.gfn_Length(v_ItemName)!= 0)
        	{
        		strMsg = " ※ 작업 불가!! 작업이 불가한 자재가 포함되어 있습니다.\n";
        		strMsg+= "    불가 자재명 : " + v_ItemName;
        		
        		application.goMain.gfn_Msg("OK", "알림", strMsg, "OK", "OK");
        		return false;
        	}
        	
        	return true;
        }

        this.fn_CheckDateTime = function (nIdx)
        {
        	if(this.ds_potype.getColumn(nIdx, "D_DAYS") == "0") return true;
        	
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
        	
        	if( this.div_additionOrder.div_search.cal_dtFrom.value < this.gfn_AddDate(this.gfn_subStr(f_CurrDateTime,0,8),nexacro.toNumber(this.ds_potype.getColumn(nIdx, "D_DAYS"))))
        	{
        		var v_Msg;
        		v_Msg  = " ※ 현재 입고일로는 추가발주할 수 없습니다. \n";
        		v_Msg += "    구 매  유 형 : " + this.ds_potype.getColumn(nIdx, "PO_TYPE_NM") + "\n";
        		v_Msg += "    현 재  시 간 : " + this.fn_FormatDateTime(f_CurrDateTime) + "\n";
        		v_Msg += "    신청가능일자 : " + this.fn_FormatDateTime(this.gfn_AddDate(this.gfn_subStr(f_CurrDateTime,0,8),nexacro.toNumber(this.ds_potype.getColumn(nIdx, "D_DAYS")))) + " (D_DAY=" + this.ds_potype.getColumn(0, "D_DAYS") + "일" + this.ds_potype.getColumn(0, "D_TIMES") + "시) \n";
        		
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
        	if( this.div_additionOrder.div_search.cal_dtFrom.value == this.gfn_AddDate(this.gfn_subStr(f_CurrDateTime,0,8),nexacro.toNumber(this.ds_potype.getColumn(nIdx, "D_DAYS"))))
        	{
        		if(nexacro.toNumber(this.ds_potype.getColumn(nIdx, "D_TIMES")) == 0) return true;
        		
        		if( nexacro.toNumber(this.gfn_subStr(f_CurrDateTime,8,2)) >= nexacro.toNumber(this.ds_potype.getColumn(nIdx, "D_TIMES")))
        		{
        			var v_Msg;
        			v_Msg  = " ※ 현재 시간은 추가발주할 수 없습니다. \n";
        			v_Msg += "    구 매  유 형 : " + this.ds_potype.getColumn(nIdx, "PO_TYPE_NM") + "\n";
        			v_Msg += "    현 재  시 간 : " + this.fn_FormatDateTime(f_CurrDateTime) + "\n";
        			v_Msg += "    신청가능일시 : " + this.fn_FormatDateTime(this.gfn_AddDate(this.gfn_subStr(f_CurrDateTime,0,8),nexacro.toNumber(this.ds_potype.getColumn(nIdx, "D_DAYS")))) + " " + this.ds_potype.getColumn(nIdx, "D_TIMES") + "시 (D_DAY=" + this.ds_potype.getColumn(nIdx, "D_DAYS") + "일" + this.ds_potype.getColumn(nIdx, "D_TIMES") + "시) \n";
        			
        			application.goMain.gfn_Msg("OK", "알림", v_Msg, "OK", "OK");
        			
        			return false;
        		}
        	}	

        	return true;
        }

        /*================================================================================
         * 5. UserFunction관련 Script
         *===============================================================================*/
         /*----------------------------------------------------------------------------------------------
         * 설명      : JSP트랜잭션 콜백 함수 (필수)
         *---------------------------------------------------------------------------------------------*/
        this.fn_transation_callback = function (nErrorCode,sErrorMag,sSvcID)
        {	
        	// 에러시 gfn_callBack에서 메시지 제공, 화면별 특정 에러 발생시에만 사용하세요.
        	if (nErrorCode < 0) 
        	{
        		return;
        	}
        	
        	switch(sSvcID)
            {		
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
        			
        			this.ds_condi.setColumn(0, "PO_TYPE"		, this.ds_potype.getColumn(nIndex,"PO_TYPE"));
        			this.ds_condi.setColumn(0, "PO_TYPE_NM"		, this.ds_potype.getColumn(nIndex,"PO_TYPE_NM"));			
        			this.ds_condi.setColumn(0, "D_DAYS"			, this.ds_potype.getColumn(nIndex,"D_DAYS"   ));
        			this.ds_condi.setColumn(0, "D_TIMES"		, this.ds_potype.getColumn(nIndex,"D_TIMES"  ));
        			this.ds_condi.setColumn(0, "PR_NUM"			, "");
        			this.ds_condi.setColumn(0, "GROUP_CODE"		, "FM0037");	
        			break;
        			
        		//신청번호조회
                case "SEARCH" :
        			// 조회 건수 확인  
                    if (this.ds_master.getRowCount() == 0) 
                    {
                        application.goMain.gfn_Msg("alertTest", "Information", "조회되는 내용이 없습니다.", "OK");	//조회되는 내용이 없습니다.
                        return;
                    }else{		
                    	
                    	//상품 정상조회 후 컬럼 항목 추가 및 이미지 경로 데이터셋에 세팅 
        				this.ds_master.addColumn("MOBILE_GUBUN_IMG", "String", 255);
        				
        				for(var i=0; i < this.ds_master.rowcount; i++)
        				{			
        					if(this.ds_master.getColumn(i, "MOBILE_GUBUN") == "M")
        					{
        						this.ds_master.setColumn(i, "MOBILE_GUBUN_IMG", "URL('HWImage::grd_WF_M.png') stretch");
        					}
        					else
        					{
        						this.ds_master.setColumn(i, "MOBILE_GUBUN_IMG", "URL('HWImage::grd_WF_P.png') stretch");
        					}					
        				}
        					
        				this.fn_searchDetail();
                    }
                    
          		break;
          		
          		//상세
                case "DETAIL" :
        			var sLineStatus = this.ds_detail.getColumn(0,"LINE_STATUS");
        							
        			if(sLineStatus == "003" || sLineStatus == "PD"){
        				fv_type = "CANCEL_UPDATE";
        			}
        			else if(sLineStatus == "001")
        			{
        				fv_type = "TEMP_UPDATE";
        			}			
        			else if(sLineStatus == "002" || sLineStatus == "PC")
        			{
        				fv_type = "UPDATE";
        			}
        			else
        			{
        				fv_type = "";
        			}
        			
        			//cell선택에 따라 수정 및 삭제 confirm팝업 띄움		
        			if(this.vCell == "5")
        			{
        				this.vCell = 0;
        				
        				if(this.ds_master.getColumn(this.ds_master.rowposition, "CLOSE_YN") == "N")
        				{
        					if(sLineStatus == "003" || sLineStatus == "PD" || sLineStatus == "001" || sLineStatus == "002" || sLineStatus == "PC")
        					{
        						application.goMain.gfn_Msg("cart", "장바구니이동", "장바구니로 이동하시겠습니까?", "YN", true, this);
        					}	
        				}
        				else
        				{
        					application.goMain.gfn_Msg("OK", "알림", "수정기한이 지났거나 수정 권한이 없습니다.", "OK");
        					return;
        				}
        			}
        			else if(this.vCell == "9")
        			{	
        				this.vCell = 0;
        				
        				if(this.ds_master.getColumn(this.ds_master.rowposition, "CLOSE_YN") == "N")
        				{
        					
        					if(sLineStatus == "001" || sLineStatus == "002" || sLineStatus == "PC")
        					{
        						if(this.ds_detail.getColumn(this.ds_detail.rowposition,"NEED_DATE") < "20080701")
        						{
        							application.goMain.gfn_Msg("OK", "알림", "2008년7월1일 이전 신청데이터는 IFIS에서 삭제할 수 없습니다.", "OK", "OK");
        							return;
        						}
        						
        						if(application.g_Upjang != this.ds_detail.getColumn(0, "RC_UPJANG"))
        						{
        							application.goMain.gfn_Msg("OK", "알림", "구매신청한 업장계정이 아니라 삭제가 불가합니다.\n전산관리자 문의해 주세요.", "OK");
        							return;
        						}	
        						
        						application.goMain.gfn_Msg("delete", "삭제", "취소된 신청서는 복원되지 않습니다. \n\n" +" 작업을 계속하시겠습니까?", "YN", true, this);
        						
        					}	
        				}
        				else
        				{
        					application.goMain.gfn_Msg("OK", "알림", "삭제기한이 지났거나 삭제 권한이 없습니다.", "OK");
        					return;
        				}
        			}		
        			
        						
        			
        		break;
        		//신청내역 조회
                case "PR_SEARCH" :	
        			
        			this.ds_grd.setColumn(this.ds_master.rowposition, "NEED_DATE"		, this.ds_detail.getColumn(this.ds_detail.rowposition,"NEED_DATE"));			// 상세조회의 입고일자
        			
        			this.ds_grd.addColumn("CART_IMG", "String", 255);
        			
        			for(var i=0; i < this.ds_grd.rowcount; i++)
        			{	
        				this.ds_grd.setColumn(i, "CART_IMG", "URL('HWImage::CellGrd_WF_Cartbtn.png') stretch");
        			    
        			    //기획 아이콘
        			    if(this.ds_grd.getColumn(i, "FEATURE_NAME") == "theme://Images/new/grd_WF_Icon11.png")
        			    {
        					this.ds_grd.setColumn(i, "FEATURE_NAME", "URL('HWImage::grd_WF_Icon11.png')");
        			    }
        			    //PB 아이콘
        			    else if(this.ds_grd.getColumn(i, "FEATURE_NAME") == "theme://Images/new/grd_WF_Icon09.png")
        			    {
        					this.ds_grd.setColumn(i, "FEATURE_NAME", "URL('HWImage::grd_WF_Icon09.png')");
        			    }
        			    //친환경 아이콘
        			    else if(this.ds_grd.getColumn(i, "FEATURE_NAME") == "theme://Images/new/grd_WF_Icon08.png")
        			    {
        					this.ds_grd.setColumn(i, "FEATURE_NAME", "URL('HWImage::grd_WF_Icon08.png')");
        			    }
        			    //전처리 아이콘
        			    else if(this.ds_grd.getColumn(i, "FEATURE_NAME") == "theme://Images/new/grd_WF_Icon10.png")
        			    {
        					this.ds_grd.setColumn(i, "FEATURE_NAME", "URL('HWImage::grd_WF_Icon10.png')");
        			    }			    
        			    
        			}	
        			
        			application.gds_marketList.copyData(this.ds_grd, true);
        			application.gds_condi.copyData(this.ds_condi, true);
        			
        			this.f_sSetFlag = "CART";
        			
        			application.goMain.fn_action("CART");	
                    
          		break;
          		//신청내역 삭제
                case "DELETE" :	
        			
        			if(nErrorCode == 0){
        				application.goMain.gfn_Msg("alertTest", "Information", "정상적으로 취소되었습니다.", "OK");	
        				this.vCell = 0;
        				this.fn_search();
        			}else{
        				application.goMain.gfn_Msg("alertTest", "Information", "저장 중 오류가 발생했습니다.\n에러메세지:" + sErrorMag, "OK");				
        			}
                    
          		break;
            }  
            
        }

        this.fn_SearchApproverCallback = function ()
        {
        	
        }

        /*******************************************************************************
        * 기      능   :  팝업 callBack
        * 설      명   :  팝업이 닫히면서 전달된 값
        ********************************************************************************/ 
        this.fn_callbackPOP = function (popname,rtn)
        {
        	switch (popname)
        	{
        		case "upjangNm":
        			this.div_additionOrder.edt_upjang.set_value(rtn[1]);
        			this.upjang = rtn[0];			
        			break;
        		case "itemNm":
        			this.div_additionOrder.div_search.edt_itemNm.set_value(rtn[1]);
        			break;
        		case "itemCount":
        		    this.ds_grd.setColumn(this.ds_grd.rowposition, "PR_QTY", rtn);
        			break;	
        		case "PopCalFrom":
        			this.div_additionOrder.div_search.cal_dtFrom.set_value(rtn);
        			break;
        	}
        }

        /*******************************************************************************
        * 기      능   :  Message callback 함수
        * 설      명   :  Alert 이나 Confirm 메시지의 콜백 함수
                          gfn_Msg(...) 함수를 사용하여 띄운 창을 닫을 때 호출된다. 
        ********************************************************************************/ 
        this.msg_callback = function (id,rtn)
        { 
        	//공지사항 콜백
        	if (id == "NOTICE")
        	{
        		//앱종료
        		application.goMain.fn_action("EXIT");		
        	}
        	
        	if (id == "cart")
        	{
        		if (rtn == "Y") 
        		{			
        			
        			if(fv_type == "CANCEL_UPDATE")	//003
        			{
        				if(this.ds_detail.getColumn(this.ds_detail.rowposition,"PO_TYPE") == "04")
        				{
        					application.goMain.gfn_Msg("OK", "알림", "식단에 의한 구매신청의 경우 취소 후 '신규'로 동일 식단을 신청한 이력이 있을 경우 '취소재작성'시 중복 발주될 수 있습니다.\n신청이력을 확인해서 중복 여부를 판단 후 작업하시기 바랍니다.", "OK");
        				}
        			}
        			
        			if(application.g_Upjang != this.ds_detail.getColumn(0, "RC_UPJANG"))
        			{
        				application.goMain.gfn_Msg("OK", "알림", "구매신청한 업장계정이 아니라 수정이 불가합니다.\n전산관리자 문의해 주세요.", "OK");
        				return false;
        			}			
        			
        			var nIdx = this.ds_potype.findRowExpr("PO_TYPE=='" + this.ds_detail.getColumn(this.ds_detail.rowposition,"PO_TYPE")+"'");
        			
        			// 신청서 재작성&수정시 수정가능한 시간 체크
        			if(!this.fn_CheckDateTime(nIdx)) return;
        			
        			//결의 이상의 작업이 진행되었는지 확인
        			if(!this.fn_CheckPoYN(this.ds_detail.getColumn(this.ds_detail.rowposition, "ORG_PR_NUM"))) return false;
        		
        			
        			var nRow = this.ds_condi.addRow();
        			this.ds_condi.setColumn(nRow, "TYPE"			, fv_type);
        			this.ds_condi.setColumn(nRow, "PO_TYPE"			, this.ds_potype.getColumn(nIdx,"PO_TYPE"));							// 상세조회의 구매유형
        			this.ds_condi.setColumn(nRow, "PO_TYPE_NM"  	, this.ds_potype.getColumn(nIdx,"PO_TYPE_NM"));							// 상세조회의 구매유형명
        			
        			this.ds_condi.setColumn(nRow, "D_DAYS"			, this.ds_potype.getColumn(nIdx,"D_DAYS"));								// 구매유형의 D_DAYS
        			this.ds_condi.setColumn(nRow, "D_TIMES"			, this.ds_potype.getColumn(nIdx,"D_TIMES"));							// 구매유형의 D_TIMES
        			this.ds_condi.setColumn(nRow, "PR_SABUN"		, this.ds_condiMaster.getColumn(0, "PR_SABUN"));
        			this.ds_condi.setColumn(nRow, "PR_DEPT_ID"		, this.ds_condiMaster.getColumn(0, "PR_DEPT_ID"));
        			this.ds_condi.setColumn(nRow, "PR_UPJANG"		, this.ds_condiMaster.getColumn(0, "PR_UPJANG"));
        			this.ds_condi.setColumn(nRow, "PR_NUM"			, this.ds_master.getColumn(this.ds_master.rowposition,"PR_NUM"));			// 상세조회의 구매번호
        			this.ds_condi.setColumn(nRow, "RC_UPJANG"		, this.ds_detail.getColumn(this.ds_detail.rowposition,"RC_UPJANG"));			// 상세조회의 구매업장
        			this.ds_condi.setColumn(nRow, "RC_UPJANG_NM"	, this.ds_detail.getColumn(this.ds_detail.rowposition,"RC_UPJANG_NM"));		// 상세조회의 업장명
        			this.ds_condi.setColumn(nRow, "PR_DATE"			, this.ds_detail.getColumn(this.ds_detail.rowposition,"PR_DATE"));			// 상세조회의 신청일자
        			this.ds_condi.setColumn(nRow, "NEED_DATE"		, this.ds_detail.getColumn(this.ds_detail.rowposition,"NEED_DATE"));			// 상세조회의 입고일자
        			this.ds_condi.setColumn(nRow, "SUBINV_CODE"		, this.ds_detail.getColumn(this.ds_detail.rowposition,"SUBINV_CODE"));		// 상세조회의 창고코드 
        			this.ds_condi.setColumn(nRow, "LINE_STATUS"	    , this.ds_master.getColumn(this.ds_master.rowposition,"LINE_STATUS"));		// 진행상황
        			
        			this.fn_SearchPr();			
        			
        		}
        		else
        		{
        			return;
        		}
        	}
        	
        	if (id == "delete")
        	{
        		if (rtn == "Y") 
        		{	
        			this.fn_delete();
        		}
        		else
        		{
        			return;
        		}
        		
        	}
        }

        /*================================================================================
         * 6. 공통 기능(하단 메뉴 사라짐_top버튼 보임)
         *===============================================================================*/
        this.div_additionOrder_grd_list_onslide = function(obj,e)
        {
        	if (e.yaccvalue > 0)
        	{
        		this.parent.parent.divBottom.set_visible(true);
        		this.parent.parent.divMain.set_height(833);
        		this.parent.parent.divBottom.bringToFront();
        	}
        	else if (e.yaccvalue < 0)
        	{
        		if (this.ds_master.getRowCount() > 0)
        		{
        			this.parent.parent.divBottom.set_visible(false);
        			this.parent.parent.divMain.set_height(923);
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
        	this.div_additionOrder.grd_list.vscrollbar.set_pos(0);
        	
        }

        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.form_onload, this);
            this.div_additionOrder.addEventHandler("onvscroll", this.div_additionOrder_onvscroll, this);
            this.div_additionOrder.addEventHandler("onslide", this.div_additionOrder_onslide, this);
            this.div_additionOrder.div_search.cal_prDate.addEventHandler("ondropdown", this.div_additionOrder_cal_dtFrom_ondropdown, this);
            this.div_additionOrder.div_search.cal_prDate.addEventHandler("oneditclick", this.div_additionOrder_div_search_cal_dtFrom_oneditclick, this);
            this.div_additionOrder.div_search.btn_search.addEventHandler("onclick", this.btnSearch_onclick, this);
            this.div_additionOrder.div_search.Static24.addEventHandler("onclick", this.div_additionOrder_div_search_Static24_onclick, this);
            this.div_additionOrder.div_search.sta_dtFrom.addEventHandler("onclick", this.sta_dtFrom_onclick, this);
            this.div_additionOrder.btn_upjang.addEventHandler("onclick", this.div_additionOrder_btn_upjang_onclick, this);
            this.div_additionOrder.grd_list.addEventHandler("oncellclick", this.grd_list_oncellclick, this);
            this.div_additionOrder.grd_list.addEventHandler("onslide", this.div_additionOrder_grd_list_onslide, this);
            this.div_additionOrder.grd_list.addEventHandler("onvscroll", this.div_additionOrder_grd_list_onvscroll, this);

        };

        this.loadIncludeScript("AdditionModifyOrder.xfdl", true);

       
    };
}
)();
