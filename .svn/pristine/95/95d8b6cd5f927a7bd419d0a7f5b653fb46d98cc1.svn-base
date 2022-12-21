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
                this.set_name("ShoppingFicsBasket");
                this.set_titletext("식재장바구니");
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
            obj._setContents("<ColumnInfo><Column id=\"CENTER_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"CENTER_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"CLS_STATUS\" type=\"STRING\" size=\"256\"/><Column id=\"CUSTCD\" type=\"STRING\" size=\"256\"/><Column id=\"INVAT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_SIZE\" type=\"STRING\" size=\"256\"/><Column id=\"LINE_STATUS\" type=\"STRING\" size=\"256\"/><Column id=\"MARGIN_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"MIN_ORD_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"MAX_ORD_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"MULTIPLIER_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"NEED_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"OTCUSTCD\" type=\"STRING\" size=\"256\"/><Column id=\"OUTVAT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"PO_UOM\" type=\"STRING\" size=\"256\"/><Column id=\"POINT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"PR_ID\" type=\"STRING\" size=\"256\"/><Column id=\"PR_NUM\" type=\"STRING\" size=\"256\"/><Column id=\"PR_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"PR_REMARK\" type=\"STRING\" size=\"256\"/><Column id=\"PR_UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"RC_UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"SALE_AMOUNT\" type=\"STRING\" size=\"256\"/><Column id=\"SALE_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"SUBINV_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"TAX_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"UNIT_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"OP_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"OP_AMOUNT\" type=\"STRING\" size=\"256\"/><Column id=\"G_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAYS\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAY_DISP\" type=\"STRING\" size=\"256\"/><Column id=\"D_TIMES\" type=\"STRING\" size=\"256\"/><Column id=\"OTCUSTNM\" type=\"STRING\" size=\"256\"/><Column id=\"KG_CONVERT_RATE\" type=\"STRING\" size=\"256\"/><Column id=\"FEATURE_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"IMAGE_PATH\" type=\"STRING\" size=\"256\"/><Column id=\"LIMIT_ITEM\" type=\"STRING\" size=\"256\"/><Column id=\"LIMIT_REASON\" type=\"STRING\" size=\"256\"/><Column id=\"WEEK_ITEM_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"CONSUM_YN\" type=\"STRING\" size=\"256\"/><Column id=\"IMAGE_YN\" type=\"STRING\" size=\"256\"/><Column id=\"KEEPING_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"APPLY_SD\" type=\"STRING\" size=\"256\"/><Column id=\"VD_SN\" type=\"STRING\" size=\"256\"/><Column id=\"ORIGIN_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"MOBILE_GUBUN\" type=\"STRING\" size=\"256\"/><Column id=\"MAX_SO_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"UPJANG_GRP\" type=\"STRING\" size=\"256\"/><Column id=\"FEATURE_ICON\" type=\"STRING\" size=\"256\"/><Column id=\"OP_RATE\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);

            obj = new Dataset("ds_Days", this);
            obj._setContents("<ColumnInfo><Column id=\"D_DAYS\" size=\"22\" type=\"INT\"/><Column id=\"D_TIMES\" size=\"4\" type=\"STRING\"/><Column id=\"DAYS\" size=\"50\" type=\"STRING\"/><Column id=\"D_OVER_DAYS\" size=\"22\" type=\"INT\"/><Column id=\"QTY_CONTROL_YN\" size=\"1\" type=\"STRING\"/></ColumnInfo>");
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

            obj = new Div("div_search", "absolute", "0", "116", null, "59", "0", null, this);
            obj.set_taborder("59");
            this.addChild(obj.name, obj);
            obj = new Static("Static22", "absolute", "0", "0", null, "59", "0", null, this.div_search);
            obj.set_taborder("33");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.div_search.addChild(obj.name, obj);
            obj = new Button("btn_save", "absolute", "466", "6", "65", "47", null, null, this.div_search);
            obj.set_taborder("34");
            obj.set_text("발주");
            obj.set_cssclass("btn_WF_Function");
            this.div_search.addChild(obj.name, obj);
            obj = new Edit("edt_totalAmt", "absolute", "10", "6", null, "47", "284", null, this.div_search);
            obj.set_taborder("38");
            obj.set_enable("false");
            obj.style.set_align("right middle");
            obj.style.setStyleValue("align", "disabled", "left middle");
            obj.set_readonly("true");
            this.div_search.addChild(obj.name, obj);
            obj = new Button("btn_search", "absolute", "358", "6", null, "47", "80", null, this.div_search);
            obj.set_taborder("39");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_Search");
            this.div_search.addChild(obj.name, obj);
            obj = new Static("Static00", "absolute", "264", "7", "87", null, null, "33", this.div_search);
            obj.set_taborder("40");
            obj.set_text("※발주된상품");
            obj.style.set_background("azure");
            obj.style.set_color("#555555ff");
            obj.style.set_font("bold antialias 10 Droid Sans");
            this.div_search.addChild(obj.name, obj);
            obj = new Static("Static01", "absolute", "265", "34", "87", null, null, "7", this.div_search);
            obj.set_taborder("41");
            obj.set_text("※마감된상품");
            obj.style.set_background("navajowhite");
            obj.style.set_color("#555555ff");
            obj.style.set_font("bold antialias 10 Droid Sans");
            this.div_search.addChild(obj.name, obj);

            obj = new Grid("grd_list", "absolute", "0", "174", null, null, "0", "0", this);
            obj.set_cssclass("grd_WF_Default2");
            obj.set_taborder("43");
            obj.set_binddataset("ds_grd");
            obj.set_scrollbars("autovert");
            obj.set_scrollpixel("all");
            obj.set_nodataimage("URL('theme://Image/cart_empty.gif')");
            obj.set_fillareatype("none");
            obj.set_summarytype("default");
            obj.set_useselcolor("true");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"8\"/><Column size=\"143\"/><Column size=\"117\"/><Column size=\"121\"/><Column size=\"86\"/><Column size=\"64\"/></Columns><Rows><Row size=\"0\" band=\"head\"/><Row size=\"53\"/><Row size=\"50\"/><Row size=\"53\"/><Row size=\"3\"/></Rows><Band id=\"head\"><Cell text=\"Column1\"/><Cell col=\"1\" text=\"Column0\"/><Cell col=\"2\"/><Cell col=\"3\"/><Cell col=\"4\"/><Cell col=\"5\"/></Band><Band id=\"body\"><Cell displaytype=\"image\" style=\"line:0 none #808080ff ;background:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));background2:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));selectbackground:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));\"/><Cell col=\"1\" colspan=\"3\" style=\"align:left bottom;padding:EXPR(FEATURE_ICON == undefined ?&quot;'0 10 0 0&quot; :&quot;'0 10 0 65&quot;);line:0 solid #808080ff ;background:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite left bottom&quot;:(PR_NUM == undefined?&quot;white  left bottom&quot;:&quot;azure  left bottom&quot;));background2:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite left bottom&quot;:(PR_NUM == undefined?&quot;white  left bottom&quot;:&quot;azure  left bottom&quot;));selectbackground:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite left bottom&quot;:(PR_NUM == undefined?&quot;white  left bottom&quot;:&quot;azure  left bottom&quot;));backgroundimage:BIND(FEATURE_ICON);\" text=\"bind:ITEM_NAME\" wordwrap=\"char\"/><Cell col=\"4\" rowspan=\"2\" displaytype=\"number\" edittype=\"none\" style=\"align:right middle;padding:53 5 0 5;line:0 solid #808080ff ;background:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));background2:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));selectbackground:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));\" text=\"bind:PR_QTY\" mask=\"#,##0.0#\" maskchar=\" \" editdisplay=\"expr:CLS_STATUS == &quot;마감&quot;?&quot;none&quot;:&quot;display&quot;\"/><Cell col=\"5\" rowspan=\"2\" displaytype=\"button\" edittype=\"button\" style=\"padding:53 6 0 6;line:0 solid transparent ;background:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));background2:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));selectbackground:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));controlbackground:URL('theme://Image/CellGrd_WF_Xbtn.png') stretch;controlborder:0 solid #808080ff ;\" calendardisplay=\"edit\"/><Cell row=\"1\" displaytype=\"image\" style=\"line:0 none #808080ff ;background:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));background2:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));selectbackground:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));\"/><Cell row=\"1\" col=\"1\" style=\"align:left middle;padding:0 10 0 0;line:0 none #808080ff ;background:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));background2:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));color:blue;color2:blue;selectbackground:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));selectcolor:blue;\" text=\"bind:ITEM_CODE\" wordwrap=\"char\"/><Cell row=\"1\" col=\"2\" style=\"align:left middle;padding:0 10 0 0;line:0 none #808080ff ;background:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));background2:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));color:blue;color2:blue;selectbackground:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));selectcolor:blue;\" text=\"bind:CLS_STATUS\" wordwrap=\"char\"/><Cell row=\"1\" col=\"3\" displaytype=\"number\" style=\"align:right middle;padding:0 10 0 10;line:0 solid #808080ff ;background:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));background2:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));color:red;color2:red;selectbackground:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));selectcolor:red;\" text=\"bind:OP_PRICE\" wordwrap=\"char\" mask=\"###,###,###.##\"/><Cell row=\"2\" style=\"line:0 solid #808080ff ;background:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));background2:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));selectbackground:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));\"/><Cell row=\"2\" col=\"1\" colspan=\"2\" style=\"align:left top;padding:0 10 0 0;line:0 solid #808080ff ;background:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));background2:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));selectbackground:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));\" text=\"bind:ITEM_SIZE\" wordwrap=\"char\"/><Cell row=\"2\" col=\"3\" style=\"align:right top;padding:0 10 0 10;line:0 solid #808080ff ;background:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));background2:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));selectbackground:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));\" text=\"bind:PO_UOM\" wordwrap=\"char\"/><Cell row=\"2\" col=\"4\" style=\"line:0 solid #808080ff ;background:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));background2:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));selectbackground:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));\"/><Cell row=\"2\" col=\"5\" style=\"line:0 solid #808080ff ;background:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));background2:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));selectbackground:EXPR(CLS_STATUS == &quot;마감&quot;?&quot;navajowhite&quot;:(PR_NUM == undefined?&quot;white&quot;:&quot;azure&quot;));\"/><Cell row=\"3\"/><Cell row=\"3\" col=\"1\"/><Cell row=\"3\" col=\"2\" style=\"line: ;\"/><Cell row=\"3\" col=\"3\"/><Cell row=\"3\" col=\"4\"/><Cell row=\"3\" col=\"5\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("sta_setTimer", "absolute", "0", "58", null, "59", "0", null, this);
            obj.set_taborder("60");
            obj.set_cssclass("sta_WFSA_LabelBg");
            this.addChild(obj.name, obj);

            obj = new Edit("edt_credit", "absolute", "10", "64", null, "47", "363", null, this);
            obj.set_taborder("61");
            obj.style.set_align("right middle");
            obj.set_enable("false");
            obj.set_readonly("true");
            this.addChild(obj.name, obj);

            obj = new Static("sta_days", "absolute", "337", "62", "209", "26", null, null, this);
            obj.set_taborder("62");
            obj.set_text("(발주마감 : D-0 00시)");
            obj.style.set_font("bold antialias 14 arial");
            this.addChild(obj.name, obj);

            obj = new Static("sta_week", "absolute", "300", "58", "45", "34", null, null, this);
            obj.set_taborder("63");
            obj.set_text("(월)");
            obj.style.set_font("bold antialias 14 arial");
            this.addChild(obj.name, obj);

            obj = new Static("sta_timer", "absolute", "257", "89", "294", "25", null, null, this);
            obj.set_taborder("64");
            obj.set_text("마감시간 : 00일 00시간 00분 전");
            obj.style.set_font("bold antialias 14 arial");
            this.addChild(obj.name, obj);

            obj = new Static("sta_needTime", "absolute", "188", "63", "117", "26", null, null, this);
            obj.set_taborder("65");
            obj.set_text("입고일자");
            obj.style.set_font("bold antialias 14 arial");
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
            		p.set_titletext("식재장바구니");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("ShoppingFicsBasket.xfdl", "lib::lib_Com.xjs");
        this.registerScript("ShoppingFicsBasket.xfdl", function(exports) {
        //########################################################
        // [프로젝트]		FC종합전산 모바일시스템 구축
        // [시스템명]		장바구니(식재)
        // [부시스템명]	장바구니(식재) - 저장
        // [설명]
        // 		장바구니(식재) 발주처리.
        // [작성자명] 		강대성
        // [작성일자]		2015.02.17
        // -----------------[수정이력]--------------------------
        // 수정일자 : 수정자 : 수정내용
        // 2015.02.17 : 강대성 : 화면 신규생성.
        // 2015.06.24 : 강대성 : 업무로직 추가.
        //########################################################
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        /*================================================================================
         * 1. 변수 선언
         *===============================================================================*/
        this.preDate = "";
        this.tTimeout = "";
        this.upjang = "";
        this.needDate = "";
        this.subinvCode = "";
        this.totalAmt = 0;
        var saveChk = "INIT"
        var fa_DocSrc = '07 FM(모바일)';
        var fa_DocSrc1 = '07 FM';             //구 푸드엠 주문내용  ---> 상품발주로 간주
        var fa_DocSrc2 = '01 BO';             //아이리스 주문내용   ---> 상품발주로 간주
        var fa_DocSrc3 = '07 FM(상품)';
        var fa_sDay;
        var sRtn;
        var strDataGroup = "U_svc";

        //최초등록시 주문번호 채번, 이후에는 같은 주문번호로 발주되도록 함
        var fn_gubunNewOrOld = "NEW";
        var fn_maxPrNum = "";
        var fn_maxApproveNum = "";
        var fn_dsListCnt = 0;

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
        	
        	this.fsp_init();
        	
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정(검색)
        	this.fn_SetBtnControl("this.div_search.btn_search","");
        	
        	// 메뉴권한에 따른 버튼 활성화 및 디폴트값 설정(발주확정)
        	this.fn_SetBtnControl("","this.div_search.btn_save");	
        	
        	this.ds_grd.copyData(application.gds_marketFicsList, true);
        	this.ds_Cond.copyData(application.gds_dsCond, true);
        	
        	//신규건 데이터 셋에 담는다
        	for(var i=0; i < application.gds_marketFicsNewList.rowcount; i++)
        	{	
        		var nRow = this.ds_grd.addRow();
        		this.ds_grd.copyRow(nRow, application.gds_marketFicsNewList, i);
        	}
        	
        	//사업장 세팅
        	if(this.gfn_isNull(this.ds_Cond.getColumn(0, "UPJANG_NM")))
        	{
        		this.sta_upjang.set_text(application.g_UpjangNm);
        	}
        	else
        	{
        		this.sta_upjang.set_text(this.ds_Cond.getColumn(0, "UPJANG_NM"));
        	}
        	
        	this.upjang = this.gfn_transNullToEmpty(this.ds_Cond.getColumn(0, "UPJANG"));
        	this.needDate = this.gfn_transNullToEmpty(this.ds_Cond.getColumn(0, "NEED_DATE"));
        	this.subinvCode = this.gfn_transNullToEmpty(this.ds_Cond.getColumn(0, "SUBINV_CODE"));
        	
        	//기본적으로 사업장은 채권잔액 공개않함. - 이혜은(20130422) 
        	if(application.g_UserKind == "사업장") {
        		//this.edt_credit.set_visible(false);		
        	}
        	
        	//사용자관리화면에서 [여신/공급업체] 항목의 값을 들고와서 
        	//발주가능금액, 채권잔액, 실시간입금확인을 컨트롤 함 - (김진희 2014.02.19)
        	if (application.g_Simple_Po_Yn == "Y") 
        	{
        		//발주가능금액 컨트롤
        		this.edt_credit.set_visible(true);		
        	}	
        	else 
        	{
        		//발주가능금액 컨트롤
        		this.edt_credit.set_visible(false);		
        	}
        	
        	//입고일자를 표시해준다
        	if(!this.gfn_isNull(this.needDate))
        	{
        		this.sta_needTime.set_text(this.gfn_subStr(this.needDate,0,4) + "/" + this.gfn_subStr(this.needDate,4,2) + "/" + this.gfn_subStr(this.needDate,6,2));
        	}
        	
        	//합계금액을 구한후 총합계를 데이터셋에 담는다
        	for(var i=0; i < this.ds_grd.rowcount; i++)
        	{	
        		this.totalAmt = Math.round(nexacro.toNumber(this.ds_grd.getColumn(i,"OP_PRICE")) * nexacro.toNumber(this.ds_grd.getColumn(i,"PR_QTY")));
        		this.ds_grd.setColumn(i, "OP_AMOUNT", this.totalAmt);
        	}
        	
        	var yTax = this.ds_grd.getCaseSum("TAX_CODE == 100", "OP_AMOUNT") * 1.1;
        	var nTax = this.ds_grd.getCaseSum("TAX_CODE != 100", "OP_AMOUNT") * 1;
        	this.div_search.edt_totalAmt.set_value("총합계: " + this.gfn_NumFormat(yTax+nTax) + "원");	
        	
        	//디데이
        	this.fn_GetDays();
        	
        	this.setTimer(777,30000); //일단 30초 세팅
        	
        	//장바구니 화면 로그시 바로 장바구니 내역 조회
        	this.fn_finalSearch();	
        }

        //데이터셋 초기화
        this.fn_ResetData = function ()
        {
        	this.sta_days.set_text("(발주 마감 : - -)");
        	this.sta_timer.set_text("");
        	this.edt_credit.set_value("");
        	
        	this.ds_grd.clearData();
        	this.ds_Cond.clearData();
        	this.ds_CrdInfo.clearData();
        	this.ds_Days.clearData();
        	this.ds_OrdCtrl.clearData();	
        }

        //버튼 초기화
        this.fn_Btn_con = function ()
        {
        	//데이터셋 데이터가 없을 경우 검색 및 저장버튼 비활성화 시킴
        	if(this.ds_grd.getRowCount() == "0")
        	{
        		this.div_search.btn_search.set_enable(false);
        		this.div_search.btn_save.set_enable(false);		
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
        	arg[5] = this.ds_grd.getColumn(nRow, "IMAGE_PATH");
        	
        	application.goMain.gfn_POP_create("", "M_MOM::ProductDetailPop.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        	
        }

        //버튼 클릭시(공통)
        this.Common_Btn_common_OnClick = function (obj,e)
        {
        	switch(obj.name)
        	{
        		case "btn_search":
        			//this.fn_init();
        			this.fn_search();
        			break;
        		case "btn_save":
        			// v_ds_check 미사용시 변경사항 체크
         			if (this.gfn_getUpdate(this.ds_grd) == false) 
         			{
         				application.goMain.gfn_Msg("ALERT_0", "알림", "변경된 데이터가 없습니다.", "OK");
         				return;
         			}
        			
        			application.goMain.gfn_Msg("save", "발주", "주문내역을 저장하시겠습니까?!", "YN", true, this);
        			break;
        		default:
        			break;
        	}
        }

        //그리드 cell선택시
        this.grd_list_oncellclick = function(obj,e)
        {
        	//alert(e.cell);
        	var nRow = e.row;
        	
        	var prQty = this.ds_grd.getColumn(nRow, "PR_QTY");
        	var opPrice = this.ds_grd.getColumn(nRow, "OP_PRICE");
        	var itemName = this.ds_grd.getColumn(nRow, "ITEM_NAME")	
        	
        	if (this.ds_grd.getColumn(this.ds_grd.rowposition,"CLS_STATUS") != "마감")
        	{
        		if(e.cell == "2")
        		{
        			var arg = new Array();
        		
        			arg[0] = this.ds_grd.getColumn(nRow, "PR_QTY");
        			arg[1] = this.ds_grd.getColumn(nRow, "ITEM_CODE");
        			arg[2] = this.ds_grd.getColumn(nRow, "ITEM_NAME");
        		
        			application.goMain.gfn_POP_create("itemCount", "cmmn::CmmnInputNumber.xfdl", "fn_callbackPOP", this, arg, "POP", application.goMain.divBase);
        			return false;
        		}
        	}
        		
        	if(e.cell == "3")
        	{
        		if (this.ds_grd.rowcount < 1)
        		{	
        			application.goMain.gfn_Msg("ALERT_0", "알림", this.fn_AlertMsg("006"), "OK");
        			return;
        		}
        		if (this.ds_grd.rowposition < 0)
        		{
        			application.goMain.gfn_Msg("ALERT_0", "알림", "삭제할 상품을 선택하세요.", "OK");
        			return;
        		}
        		//if (ds_grd.GetColumn(ds_grd.row,"LINE_STATUS") <> "004")
        		if (this.ds_grd.getColumn(this.ds_grd.rowposition,"CLS_STATUS") == "마감")
        		{
        			application.goMain.gfn_Msg("ALERT_0", "알림", "해당상품은 마감이 완료되어 삭제가 불가합니다.", "OK");
        			return;
        		}
        		
        		//발주가능 체크
        		if (! this.fn_OrdChk()) return;
        		
        		//기존 자료인 경우 디데이 체크
        		if (this.GetRowType(this.ds_grd,this.ds_grd.rowposition) != "insert")
        		{
        			
        			if (this.fn_GetDayStatus(this.ds_grd.getColumn(this.ds_grd.rowposition,"D_DAYS"), this.ds_grd.getColumn(this.ds_grd.rowposition,"D_TIMES")) == "0")
        			{
        				application.goMain.gfn_Msg("ALERT_0", "알림", "해당 상품은 마감시간(D-Days)이 초과되어 삭제가 불가합니다.", "OK");
        				return;
        			}
        		}
        	
        		application.goMain.gfn_Msg("delete", "삭제", "["+itemName+"]\n["+this.gfn_NumFormat(opPrice)+"]\n["+prQty+"개]\n 삭제하시겠습니까?", "YN", true, this);
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
        			application.goMain.gfn_Msg("ALERT_0", "알림", "(-)발주는 불가합니다.", "OK");
        			return false;
        		}
        		//발주마감체크
        		this.fn_CurrDateWeek();
        		
        		if (this.fn_GetDayStatus(obj.getColumn(e.row,"D_DAYS"), obj.getColumn(e.row,"D_TIMES")) == "0")
        		{
        			application.goMain.gfn_Msg("ALERT_0", "알림", "해당 상품은 마감시간(D-Days)이 초과되어 수정이 불가합니다.", "OK");	
        			return false;
        		}
        		
        		if ( nexacro.toNumber(e.newvalue) > 0 )
        		{
        			//최소발주량 체크
        			if ( (nexacro.toNumber(obj.getColumn(e.row,"MIN_ORD_QTY")) > 0) && (nexacro.toNumber(obj.getColumn(e.row,"MIN_ORD_QTY")) > nexacro.toNumber(e.newvalue)) )
        			{
        				application.goMain.gfn_Msg("ALERT_0", "알림", "해당 상품은 최소발주량이 " + obj.getColumn(e.row,"MIN_ORD_QTY") + "입니다.", "OK");	
        				return false;
        			}
        			//최대발주량 체크
        			if ( (nexacro.toNumber(obj.getColumn(e.row,"MAX_ORD_QTY")) > 0) && (nexacro.toNumber(obj.getColumn(e.row,"MAX_ORD_QTY")) < nexacro.toNumber(e.newvalue)) )
        			{
        				application.goMain.gfn_Msg("ALERT_0", "알림", "해당 상품은 최대발주량이 " + obj.getColumn(e.row,"MAX_ORD_QTY") + "입니다.", "OK");
        				return false;
        			}
        			//소숫점발주여부
        			if ( (obj.getColumn(e.row,"POINT_FLAG") != "Y") && (Math.ceil(nexacro.toNumber(e.newvalue)) != nexacro.toNumber(e.newvalue)) )
        			{
        				application.goMain.gfn_Msg("ALERT_0", "알림", "해당 상품은 소숫점발주가 불가합니다.", "OK");
        				return false;
        			}
        			//발주승수량
        			if (nexacro.toNumber(obj.getColumn(e.row,"MULTIPLIER_QTY")) != 0)
        			{
        				var nMqty = nexacro.toNumber(obj.getColumn(e.row,"MULTIPLIER_QTY"));
        				var nRt = e.newvalue - (Math.floor(e.newvalue / nMqty) * nMqty)
        					
        				if(nRt != 0)
        				{
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
        	//금액계산
        	if (e.columnid == "PR_QTY")
        	{
        		var nAmt = Math.round(nexacro.toNumber(obj.getColumn(e.row,"SALE_PRICE")) * nexacro.toNumber(e.newvalue));		
        		obj.setColumn(e.row, "SALE_AMOUNT", nAmt);
        		
        		nAmt = Math.round(nexacro.toNumber(obj.getColumn(e.row,"OP_PRICE")) * nexacro.toNumber(e.newvalue));
        		obj.setColumn(e.row, "OP_AMOUNT", nAmt);		
        	}
        }

        
        /*******************************************************************************
        * 기      능   :  검색
        * 설      명   :  발주상세검색
        ********************************************************************************/
        this.fn_search = function()
        {
        	if(this.gfn_dsIsUpdated(this.ds_grd)==true)
        	{	
        		application.goMain.gfn_Msg("confirm", "확인", "검색을 진행하면 변경된 데이터가 사라집니다.\n 계속 진행 하시겠습니까?", "YN", true, this);	
        	}
        	else
        	{
        		this.fn_finalSearch();	
        	}	
        }

        this.fn_finalSearch = function()
        {
        	//입고통제일 체크 
        	if (this.fn_NeedDateCheck()) 
        	{
        		application.goMain.gfn_Msg("OK", "알림", "해당일자는 입고통제일 입니다.", "OK", "OK");
        	    this.ds_grd.clearData();
        	    return;
        	}	
        	
        	this.fn_SetTimer();
        	//최종발주정보
        	this.fn_GetLastOrd();
        	// 초기화
        	this.ds_Cond.addRow();
        	this.ds_Cond.setColumn(0, "SUBINV_CODE",    this.subinvCode);
        	this.ds_Cond.setColumn(0, "NEED_DATE",      this.needDate);
        	this.ds_Cond.setColumn(0, "QTY_CONTROL_YN", this.ds_Days.getColumn(0,"QTY_CONTROL_YN"));
        	
        	// 조회
        	var actionName, cmdName, inData, outData, otherArg, callBackFnc;
        	
        	// 파라미터셋팅
            inData		= "ds_Cond=ds_Cond";
            outData		= "ds_grd=ds_List";
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
        	this.fsp_callService(this, actionName, cmdName, inData, outData, otherArg, callBackFnc, false, false, false);		// 서비스 호출 
            
        }

        this.fn_CallBack_Search = function ()
        {
        	this.ds_grd.addColumn("FEATURE_ICON", "String", 255);
        	
        	for(var i=0; i < this.ds_grd.rowcount; i++)
        	{	
        		//기획 아이콘
        		if(this.ds_grd.getColumn(i, "FEATURE_ICON") == "theme://Images/new/grd_WF_Icon11.png")
        		{
        			this.ds_grd.setColumn(i, "FEATURE_ICON", "URL('HWImage::grd_WF_Icon11.png')");
        		}
        		//PB상품 아이콘
        		else if(this.ds_grd.getColumn(i, "FEATURE_ICON") == "theme://Images/new/grd_WF_Icon09.png")
        		{
        			this.ds_grd.setColumn(i, "FEATURE_ICON", "URL('HWImage::grd_WF_Icon09.png')");
        		}
        		//친환경 아이콘
        		else if(this.ds_grd.getColumn(i, "FEATURE_ICON") == "theme://Images/new/grd_WF_Icon08.png")
        		{
        			this.ds_grd.setColumn(i, "FEATURE_ICON", "URL('HWImage::grd_WF_Icon08.png')");
        		}
        		//전처리 아이콘
        		else if(this.ds_grd.getColumn(i, "FEATURE_ICON") == "theme://Images/new/grd_WF_Icon10.png")
        		{
        			this.ds_grd.setColumn(i, "FEATURE_ICON", "URL('HWImage::grd_WF_Icon10.png')");
        		}
        	}
        	
        	//최초등록시 주문번호 채번, 이후에는 같은 주문번호로 발주
        	this.ds_grd.filter("OTCUSTCD=='0000'");
        	fn_dsListCnt = 0;
        	fn_dsListCnt = this.ds_grd.rowcount;	
        	this.ds_grd.filter("");
        	
        	//신규건 데이터 셋에 담는다
        	for(var i=0; i < application.gds_marketFicsNewList.rowcount; i++)
        	{	
        		var nRow = this.ds_grd.addRow();
        		this.ds_grd.copyRow(nRow, application.gds_marketFicsNewList, i);
        	}	
        			
        	//trace(this.ds_grd.saveXML("this.ds_grd  >>>>", "V"));
        	
        	//합계금액을 구한후 총합계를 데이터셋에 담는다
        	for(var i=0; i < this.ds_grd.rowcount; i++)
        	{	
        		this.totalAmt = Math.round(nexacro.toNumber(this.ds_grd.getColumn(i,"OP_PRICE")) * nexacro.toNumber(this.ds_grd.getColumn(i,"PR_QTY")));
        		this.ds_grd.setColumn(i, "OP_AMOUNT", this.totalAmt);
        	}
        	
        	var yTax = this.ds_grd.getCaseSum("TAX_CODE == 100", "OP_AMOUNT") * 1.1;
        	var nTax = this.ds_grd.getCaseSum("TAX_CODE != 100", "OP_AMOUNT") * 1;
        	this.div_search.edt_totalAmt.set_value("총합계: " + this.gfn_NumFormat(yTax+nTax) + "원");	
        	
        	this.fn_Btn_con();
        }

        /*******************************************************************************
        * 기      능   :  상품발주
        * 설      명   :  상품발주
        ********************************************************************************/
        this.fn_save = function ()
        {
        	//발주량 0상품 확인
        	var nRow;
        	nRow = this.ds_grd.findRowExpr("PR_QTY==0");
        	if (nRow >= 0)
        	{
        		application.goMain.gfn_Msg("saveChk", "확인", "발주량이 0인 상품이 있습니다.\n\n그대로 저장하시겠습니까?", "YN", true, this);
        	}
        	else
        	{
        		this.fn_saveChk();
        	}	
        }

        this.fn_saveChk = function ()
        {
        	saveChk = "SAVE";
        	//현재시간 초기화. 	
        	//발주가능, 데이타체크에서 현재시간을 통해 계산하기때문에
        	this.fn_SetTimer();
        	
        	this.fn_GetDays();	
        	
        }

        this.fn_lastSave = function ()
        {		
        	// 조회건수가 1건이라도 있을경우
        	this.ds_grd.filter("OTCUSTCD=='0000'");
        	if (fn_dsListCnt > 0)
        	{
        		for (i=0; i<this.ds_grd.rowcount; i++)
        		{
        			fn_gubunNewOrOld = "OLD";	
        			
        			if(!this.gfn_isNull(this.ds_grd.getColumn(i, "PR_NUM")) && this.ds_grd.getColumn(i, "OTCUSTCD") == "0000")
        			{
        				fn_maxPrNum = this.ds_grd.getColumn(i, "PR_NUM");
        			}
        			
        			if(!this.gfn_isNull(this.ds_grd.getColumn(i, "APPROVE_NUM")))
        			{
        				fn_maxApproveNum = this.ds_grd.getColumn(i, "APPROVE_NUM");	
        			}			
        		}
        	}
        	else
        	{
        		fn_maxPrNum = "";
        		fn_maxApproveNum = "";
        		fn_gubunNewOrOld = "NEW";
        	}
        	this.ds_grd.filter("OTCUSTCD=='0000'");
        	
        	if (sRtn != null)
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", sRtn, "OK");
        		return;
        	}
        	
        	var strSvcID, strURL, strInDatasets, strOutDatasets, strArgument, strCallbackFunc;
        	// 경로 설정
        	strSvcID = "FMP00160E_T001";
        	strURL   = application.services[strDataGroup].url + "fm/fmp/FMP00160E_T001.jsp";
        	// 데이터셋 설정U
        	strInDatasets  = "ds_IUD=ds_grd:U";
        	strOutDatasets = "ds_save_out=ds_save_out";
        	// 파라메터 설정
        	strArgument  = "sSubinv=" + nexacro.wrapQuote(this.subinvCode);
        	strArgument += " sNeedDate=" + nexacro.wrapQuote(this.needDate);
        	strArgument += " g_Upjang=" + nexacro.wrapQuote(application.g_Upjang);
        	strArgument += " g_EmpNo=" + nexacro.wrapQuote(application.g_EmpNo);
        	strArgument += " sDocSrc=" + nexacro.wrapQuote(fa_DocSrc);
        	strArgument += " sPrUpjang=" + nexacro.wrapQuote(this.upjang);
        	strArgument += " sPrSabun=" + nexacro.wrapQuote(application.g_EmpNo);
        // [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
        	strArgument += " scrnId=" + nexacro.wrapQuote("ShoppingFicsBasket");  // 화면ID
        	strArgument += " scrnName=" + nexacro.wrapQuote("식재장바구니");      // 화면명
        // [속도개선 Project   끝] 2017. 8. 4. 최범주
        	
        	// 콜백함수 지정
        	strCallbackFunc = "fn_CallBack_Save";

        	// 서버 호출 
        	//this.jsp_transaction(this, strSvcID, strURL, strInDatasets, strOutDatasets, strArgument, strCallbackFunc, false, false, false);
        	this.jsp_transaction(this, strSvcID, strURL, strInDatasets, strOutDatasets, strArgument, strCallbackFunc, false, false, true);
        }

        this.fn_CallBack_Save = function (errCode,errMsg)
        {	
        	saveChk = "";
        	
        	if (errCode == 0)
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "주문된 상품" +this.fn_AlertMsg("000"), "OK");
        		
        		//발주후 모든 데이터셋 데이터 초기화 시킴
        		saveChk = "";
        		application.gds_marketFicsList.clearData();
        		application.gds_marketFicsNewList.clearData();
        		this.fn_search();	
        				
        	}
        	else if(errCode == 1)
        	{
        		application.goMain.gfn_Msg("error", "알림", "발주처리가 안되었습니다.\n메세지:" + errMsg, "OK", true, this);
        	}
        	else
        		application.goMain.gfn_Msg("error", "알림", "확정(저장) 중 오류가 발생했습니다.\n에러메세지:" + errMsg, "OK", true, this);	
        }

        /*******************************************************************************
        * 기      능   :  삭제
        * 설      명   :  삭제처리
        ********************************************************************************/
        this.fn_delete = function ()
        {
        	var strSvcID, strURL, strInDatasets, strOutDatasets, strArgument, strCallbackFunc;
        	// 경로 설정
        	strSvcID = "FMP00160E_T003";
        	strURL   = application.services[strDataGroup].url + "fm/fmp/FMP00160E_T003.jsp";
        	// 데이터셋 설정U
        	strInDatasets  = "";
        	strOutDatasets = "";
        	// 파라메터 설정
        	strArgument  = "g_Upjang=" + nexacro.wrapQuote(application.g_Upjang);
        	strArgument += " g_EmpNo=" + nexacro.wrapQuote(application.g_EmpNo);
        	strArgument += " sDocSrc=" + nexacro.wrapQuote(fa_DocSrc);
        	strArgument += " sPrID="   + nexacro.wrapQuote(this.ds_grd.getColumn(this.ds_grd.rowposition,"PR_ID"));
        	strArgument += " sPrNum="  + nexacro.wrapQuote(this.ds_grd.getColumn(this.ds_grd.rowposition,"PR_NUM"));
        	strArgument += " sOtcustCD=" + nexacro.wrapQuote(this.ds_grd.getColumn(this.ds_grd.rowposition,"OTCUSTCD"));
        	strArgument += " sMenuFlag=" + nexacro.wrapQuote("N");
        	strArgument += " sUpjang=" + nexacro.wrapQuote(this.ds_grd.getColumn(this.ds_grd.rowposition,"RC_UPJANG"));
        	strArgument += " sMenuCD=" + nexacro.wrapQuote(this.ds_grd.getColumn(this.ds_grd.rowposition,"NEED_DATE") + "-" + this.ds_grd.getColumn(this.ds_grd.rowposition,"SUBINV_CODE"));
        	strArgument += " sItemCode=" + nexacro.wrapQuote(this.ds_grd.getColumn(this.ds_grd.rowposition,"ITEM_CODE"));
        	strArgument += " sPrUpjang=" + nexacro.wrapQuote(this.upjang);
        	strArgument += " sPrSabun=" + nexacro.wrapQuote(application.g_EmpNo);
        // [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
            strArgument += " sSubinv=" + nexacro.wrapQuote(this.subinvCode);      // 식당(창고)
            strArgument += " sNeedDate=" + nexacro.wrapQuote(this.needDate);      // 입고예정일
        	strArgument += " scrnId=" + nexacro.wrapQuote("ShoppingFicsBasket");  // 화면ID
        	strArgument += " scrnName=" + nexacro.wrapQuote("식재장바구니");      // 화면명
        // [속도개선 Project   끝] 2017. 8. 4. 최범주
        	// 콜백함수 지정
        	strCallbackFunc = "fn_CallBack_Delete";
        	// 서버 호출 
        	//Transaction(strSvcID, strURL, strInDatasets, strOutDatasets, strArgument, strCallbackFunc);
        	this.jsp_transaction(this, strSvcID, strURL, strInDatasets, strOutDatasets, strArgument, strCallbackFunc, false, false, false);
        }

        this.fn_CallBack_Delete = function (errCode,errMsg)
        {
        	if (errCode == 0)
        	{
        		//PR_ID를 (-)으로 설정하여 저장 시 다시 삭제하는 일이 없도록 한다.
        		this.ds_grd.setColumn(this.ds_grd.rowposition,"PR_ID","-1");
        		this.ds_grd.deleteRow(this.ds_grd.rowposition);
        		
        		//삭제자료만 존재한다면 데이타셑의 row type을 초기화 하여 삭제상태를 초기화 한다.
        		if (this.ds_grd.getCaseCount("dataset.getRowType(rowidx)==2 || dataset.getRowType(rowidx)==4") <= 0) this.ds_grd.applyChange();
        		
        		//삭제후 신규 데이터셋을 제외한 기존 데이터셋 데이터 초기화 시킴
        		application.gds_marketFicsList.clearData();
        		
        		//최초등록시 주문번호 채번, 이후에는 같은 주문번호로 발주
        		this.ds_grd.filter("OTCUSTCD=='0000'");
        		if (this.ds_grd.rowcount == 0)
        		{
        			fn_dsListCnt = 0;
        		}
        		else
        		{
        			fn_dsListCnt = this.ds_grd.rowcount;
        		}
        		this.ds_grd.filter("");
        		
        		this.fn_finalSearch();	
        	}
        	else
        		application.goMain.gfn_Msg("ALERT_0", "알림", this.fn_AlertMsg("002"), "OK");	
        }

        /*******************************************************************************
        * 기      능   :  발주가능 체크 
        * 설      명   :  발주가능 체크
        ********************************************************************************/
        this.fn_OrdChk = function ()
        {	
        	this.fn_CurrDateWeek();
        	
        	//입고통제일 체크 
        	if (this.fn_NeedDateCheck()) 
        	{
        		application.goMain.gfn_Msg("ALERT_0", "알림", "해당일자는 입고통제일 입니다.", "OK");
        	    this.ds_grd.clearData();
        	    return false;
        	}

        	//발주통제일자
        	if (nexacro.toNumber(this.ds_Days.getColumn(0,"D_OVER_DAYS")) > 0)
        	{
        		if (this.needDate > this.gfn_AddDate(application.gds_currdate.getColumn(0, "YMD"),nexacro.toNumber(this.ds_Days.getColumn(0,"D_OVER_DAYS"))))
        		{	
        			application.goMain.gfn_Msg("ALERT_0", "알림", this.ds_Days.getColumn(0,"D_OVER_DAYS") + "일을 초과하여 입고예정일을 지정할 수 없습니다.", "OK");
        			return false;
        		}
        	}
        	//발주제한일자
        	if (nexacro.toNumber(this.ds_Days.getColumn(0,"D_DAYS")) > 0)
        	{
        		if (this.needDate < this.gfn_AddDate(application.gds_currdate.getColumn(0, "YMD"),nexacro.toNumber(this.ds_Days.getColumn(0,"D_DAYS"))))
        		{
        			application.goMain.gfn_Msg("ALERT_0", "알림", "발주마감은 " + this.ds_Days.getColumn(0,"DAYS") + "입니다.", "OK");
        			return false;
        		}
        		if (this.needDate == this.gfn_AddDate(application.gds_currdate.getColumn(0, "YMD"),nexacro.toNumber(this.ds_Days.getColumn(0,"D_DAYS"))))
        		{
        			if (this.gfn_subStr(application.gds_currdate.getColumn(0, "YMD_TM"),8,6)> this.ds_Days.getColumn(0,"D_TIMES"))
        			{
        				application.goMain.gfn_Msg("ALERT_0", "알림", "발주마감은 " + this.ds_Days.getColumn(0,"DAYS") + "입니다.", "OK");
        				return false;
        			}
        		}
        	}	
        	
        	//창고가 식재 또는 소모품 전용창고인 경우 주문통제 점검
        	if (!this.gfn_isNull(this.ds_Cond.getColumn(0, "CONSUM_YN")))
        	{
        		//주문통제(주문일자)
        		
        		var nRow;

        		if (this.ds_Cond.getColumn(0, "CONSUM_YN") == "Y")
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
        		if (this.ds_Cond.getColumn(0, "CONSUM_YN") == "Y")
        		{
        			nRow = this.ds_OrdCtrl.findRowExpr("CTRL_TYPE=='입고' && ITEM_TYPE=='소모품'")
        		}
        		else
        		{
        			nRow = this.ds_OrdCtrl.findRowExpr("CTRL_TYPE=='입고' && ITEM_TYPE=='식자재'")
        		}
        		
        		if (nRow >= 0)
        		{
        			if (this.ds_OrdCtrl.getColumn(nRow,this.ToUpper(this.fn_DayToWeek(this.needDate,"1"))) == "Y")
        			{
        				application.goMain.gfn_Msg("ALERT_0", "알림", this.fn_DayToWeek(this.needDate) + "요일은 입고불가 요일입니다." + "\n\n" + "입고예정일을 변경하세요.", "OK");
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
        	this.ds_Dummyin.setColumn(0, "NEED_DATE",      this.needDate);
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
        	//trace("this.ds_Dummyin :: " +this.ds_Dummyin.saveXML("ds_Dummyin", "V"));
        	
            this.fsp_callService(this, actionName, cmdName, inData, outData, otherArg, callBackFnc, false, false, true);
        	
        	var bYn = (this.ds_Dummyot.getColumn(0, "CNT") > 0);
        	
        	return bYn;
        }

        this.fn_NeedDateCheck_callback = function (errCode,errMsg)
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
        	this.ds_Dummyin.setColumn(0, "SUBINV_CODE",    this.subinvCode);
        	this.ds_Dummyin.setColumn(0, "NEED_DATE",      this.needDate);
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

        this.fn_GetLastOrd_callback = function(errCode,errMsg)
        {
        	if (errCode == 0)
        	{
        		// 여신체크
        		this.fn_GetCredit(false);			
        	}
        	else
        		application.goMain.gfn_Msg("OK", "알림", this.fn_AlertMsg("002"), "OK", "OK");		
        }

        /*******************************************************************************
        * 기      능   :  디데이
        * 설      명   :  디데이
        ********************************************************************************/
        this.fn_GetDays = function ()
        {
        	// 초기화(디데이)
        	this.ds_Days.clearData();	
        	
        	// 조회
        	var actionName, cmdName, inData, outData, otherArg, callBackFnc;
        	// 파라미터셋팅
            outData		= "ds_Days=ds_List";
            otherArg	= "UPJANG=" + nexacro.wrapQuote(this.upjang) + " SUBINV_CODE=" + nexacro.wrapQuote(this.subinvCode) + " NEED_DATE=" + nexacro.wrapQuote(this.needDate);
        	callBackFnc = "fn_GetDays_callback";
        	//action 정보 초기화 
        	this.fsp_clear(); 
            // 서버에서 조회할 정보 추가 
        	this.fsp_addSearch("fm/fmz:FMZ_GETDAYS_S001", false);
        	// 서버 호출 
        	this.fsp_callService(this, actionName, cmdName, inData, outData, otherArg, callBackFnc, false, false, false);
        }
        	
        this.fn_GetDays_callback = function(errCode,errMsg)
        {
        	//디데이 표시
        	if (this.ds_Days.rowcount > 0)
        		this.sta_days.set_text("(발주 마감 : " + this.ds_Days.getColumn(0,"DAYS") + ")");
        	else
        	{
        		//alert("발주마감정보를 확인할 수 없습니다.!" + "\n\n" + "관리자에게 문의하세요.");
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
        	this.fsp_callService(this, actionName, cmdName, inData, outData, otherArg, callBackFnc, false, false, false);
        }

        this.fn_GetOrdCtrl_callback = function(errCode,errMsg)
        {
        	// 여신체크
        	this.fn_GetCredit();
        	
        	// 타이머...
        	this.fn_SetTimer();
        }

        /*******************************************************************************
        * 기      능   :  타이머
        * 설      명   :  타이머
        ********************************************************************************/
        this.fn_SetTimer = function ()
        {
        	if(!this.gfn_isNull(this.needDate)){
        		
        		this.fn_CurrDateWeek();
        		
        		var sChkDate, sDay, sTime;
        		
        		if ( this.gfn_subStr(application.gds_currdate.getColumn(0, "YMD_TM"),8,4)>= this.gfn_Trim(this.ds_Days.getColumn(0,"D_TIMES")) )
        		{
        			sChkDate = this.gfn_AddDate(this.needDate, (-1 * (nexacro.toNumber(this.gfn_Trim(this.ds_Days.getColumn(0,"D_DAYS"))) + 1)));	
        			sTime = this.G_fn_GapTime("1", this.gfn_subStr(application.gds_currdate.getColumn(0, "YMD_TM"),8,4), nexacro.toNumber(this.gfn_Trim(this.ds_Days.getColumn(0,"D_TIMES"))), "");	
        		}
        		else
        		{
        			sChkDate = this.gfn_AddDate(this.needDate, (-1 * nexacro.toNumber(this.gfn_Trim(this.ds_Days.getColumn(0,"D_DAYS")))));
        			sTime = this.G_fn_GapTime("0", this.gfn_subStr(application.gds_currdate.getColumn(0, "YMD_TM"),8,4), this.gfn_Trim(this.ds_Days.getColumn(0,"D_TIMES")), "");
        		}
        		
        		if (parseInt(application.gds_currdate.getColumn(0, "YMD")) <= parseInt(sChkDate))
        			sDay = this.G_fn_CalcDay(application.gds_currdate.getColumn(0, "YMD"), sChkDate);		
        		else
        			sDay = this.G_fn_CalcDay(sChkDate, application.gds_currdate.getColumn(0, "YMD")) * (-1);		
        			
        		if ((nexacro.toNumber(sDay) >= 0) && (nexacro.toNumber(sDay) < 10)) sDay = "0" + sDay;
        			
        			this.sta_timer.set_text("마감시간 : " + sDay + "일 " + this.gfn_Left(sTime,2)+ "시간 " + this.gfn_Right(sTime,2)+ "분 전");	
        			this.sta_week.set_text("(" + this.fn_DayToWeek(this.needDate) + ")");
        		
        		if (this.sta_week.text == "(토)")
        			this.sta_week.style.color = "blue";
        		else if (this.sta_week.text == "(일)")
        			this.sta_week.style.color = "red";
        		else
        			this.sta_week.style.color = "black";
        			
        		fa_sDay = sDay;	
        		if (nexacro.toNumber(sDay) < 0) this.fn_CLS_STATUS_Setting(); 
        	}else{
        		this.fn_ResetData();
        	}
        			
        }

        this.fn_CLS_STATUS_Setting = function ()
        {
            if (fa_sDay >= 0) return;
            
        	for (i=0; i<this.ds_grd.rowcount; i++)
        	{
        		if (this.ds_grd.getColumn(i, "OTCUSTCD") != "0000")
        		{
        			this.ds_grd.setColumn(i, "CLS_STATUS", "마감");
        		}
        	}		
        }

        /*******************************************************************************
        * 기      능   :  데이타체크(여신및 상품별 디데이체크)
        * 설      명   :  데이타체크(여신및 상품별 디데이체크)
        ********************************************************************************/
        this.fn_ChkData = function ()
        {
        	//변경여부 확인
        	if ( (!this.gfn_getUpdate(this.ds_grd)) )
        	{
        		return this.fn_AlertMsg("007");
        	}
        	
        	//여신한도초과여부
        	if (this.ds_CrdInfo.rowcount > 0)
        	{
        		//여신금액
        		if (this.ds_CrdInfo.getColumn(0,"CREDIT_AMOUNT_CONTROL_YN") == "Y")
        		{
        			var nAmt = 0;
        			for (i=0; i<this.ds_grd.rowcount; i++)
        			{
        				nAmt += nexacro.round((nexacro.toNumber(this.ds_grd.getColumn(i,"OP_AMOUNT")) - nexacro.toNumber(this.ds_grd.getColumn(i,"OP_AMOUNT_OLD"))) * this.iif(this.ds_grd.getColumn(i,"TAX_CODE")=="100",1.1,1));
        				
        				if (nAmt > nexacro.toNumber(this.ds_CrdInfo.getColumn(0,"CREDIT_AVAIL_AMT")))
        				{
        					return "주문가능한 여신한도를 초과하여 주문이 불가합니다.";
        				}
        			}
        		}
        		//여신회전일
        		if (this.ds_CrdInfo.getColumn(0,"CREDIT_TURN_CONTROL_YN") == "Y")
        		{
        			if (nexacro.toNumber(this.ds_CrdInfo.getColumn(0,"LAST_TURN_CNT")) >= 0)
        			{
        				if (nexacro.toNumber(this.ds_CrdInfo.getColumn(0,"LAST_TURN_CNT")) > nexacro.toNumber(this.ds_CrdInfo.getColumn(0,"CREDIT_TURN_DAYS_TOT")))
        				{
        					return this.ds_CrdInfo.getColumn(0,"L_BILL_DATE_DISP") + "에 매출채권이 존재하여 주문이 불가합니다.";
        				}
        			}
        		}
        	}
        	
        	trace("this.ds_grd >>>>>>:: " +this.ds_grd.saveXML("this.ds_grd  ", "V"));
        	
        	//상품별 디데이 체크
        	for (i=0; i<this.ds_grd.rowcount; i++)
        	{
        		if (this.GetRowType(this.ds_grd,i) != "normal")
        		{
        			if (( this.GetRowType(this.ds_grd,i)== "insert" ) && ( this.gfn_NumFormat(this.gfn_Trim(this.ds_grd.getColumn(i,"PR_QTY")),1)== "0" )) continue;
        			//기존자료이거나 무통제면 패스...
        			
        			if ( this.numFormat(this.ds_grd.getColumn(i,"D_DAYS"))== "0" ) continue;
        			//디데이체크	
        			if (this.fn_GetDayStatus(this.ds_grd.getColumn(i,"D_DAYS"), this.ds_grd.getColumn(i,"D_TIMES")) == "0")
        			{
        				this.ds_grd.rowposition = i;
        				
        				return ("[" + this.ds_grd.getColumn(i,"ITEM_NAME") + "]상품은 마감시간(D-Days)을 초과하여 주문이 불가합니다.");
        			}
        		}
                //-----------------------------------------------------------------------------------
        		//--- 체크로직 추가 
        		//    수정일    : 2010/10/28 BY 노규완
        		//    수정내용  : 상품 수량 입력 시 기존에는 라인별로 최대발주량 체크 하였으나,
        		//                추가 상품으로 동일 상품을 등록 한 다음 최대 발주량만 넘지 않으면 
        		//                추가로 상품이 저장 되는 문제가 발생하여, 입고 예정일 기준으로 
        		//                동일 상품의 총 합계를 체크 하여 최대 발주량을 넘는지 체크 한다.
        		//    수정일    : 2013/08/01 BY 박용대
        		//    수정내용  : 상품을 저장할때 아이리스에서 취소한 목록들이 발주내역에 올라오게되는데
        		//                이것들이 최대 발주량계산에 포함되어 있어 발주상태가 003,005인 항목을
        		//                제외하고 CASESUM 하는 부분을 추가.
        		//-----------------------------------------------------------------------------------
        		if ((this.ds_grd.getColumn(i,"MAX_ORD_QTY") > 0) && ( this.ds_grd.getCaseSum("ITEM_CODE=='"+ this.ds_grd.getColumn(i,"ITEM_CODE")+"'&& ((LINE_STATUS != '005' && LINE_STATUS != '002') && LINE_STATUS != '003') && DOCU_SOURCE != '01 BO'","PR_QTY") > this.ds_grd.getColumn(i,"MAX_ORD_QTY")))  
        		{   
        		    if (nexacro.toNumber(this.ds_grd.getColumn(i,"PR_NUM")) != 0)
        		    {
        		        //동일상품의 다른 주문날짜일 경우 합산은 최대발주량을 넘어도 상관없다.
        		        if ( this.ds_grd.getCaseSum("PR_NUM=='"+this.ds_grd.getColumn(i,"PR_NUM")+"'","PR_QTY") <= this.ds_grd.getColumn(i,"MAX_ORD_QTY"))
        		            continue;
        		    }
               	    this.ds_grd.rowposition = i;
        		    return ("[" + this.ds_grd.getColumn(i,"ITEM_NAME") + "] 상품이 최대 발주량" + this.ds_grd.getColumn(i,"MAX_ORD_QTY") + ")를 초과하여 주문이 불가합니다.");
        		}		
        	}
        	//수량 0인거 제거...
        // 	for (i=this.ds_grd.rowcount-1; i>=0; i--)
        // 	{
        // 		if ( this.gfn_NumFormat(this.gfn_Trim(this.ds_grd.getColumn(i,"PR_QTY")),1)== "0" ) this.ds_grd.deleteRow(i);
        // 		
        // 	}
        	
        	// 신규 입력 시 수량이 0인 자재 삭제 처리
        	for( var i = this.ds_grd.getRowCount()-1; i >= 0; i-- ) {		
        		if( this.ds_grd.getColumn(i, "PR_QTY") == 0 || this.gfn_Length(this.gfn_Trim(this.ds_grd.getColumn(i, "PR_QTY"))) == 0 ) {
        			this.ds_grd.deleteRow(i);
        		}		
        	}
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
        	if ( this.gfn_AddDate(application.gds_currdate.getColumn(0,"YMD"),nDdays)> this.needDate )
        		return "0";
        	else if ( this.gfn_AddDate(application.gds_currdate.getColumn(0,"YMD"),nDdays)== this.needDate )
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
        * 기      능   :  여신정보
        * 설      명   :  여신정보
        ********************************************************************************/
        this.fn_GetCredit = function (isSync)
        {
         	if (!this.fn_GetCrdYn())
         	{
         		//여신정보 초기화
         		this.ds_CrdInfo.clearData();
         	    this.edt_credit.set_value("무 제 한");
         		return;
         	}
         	
         	// 초기화
        	this.ds_CrdInfo.clearData();
        	this.ds_Cond.addRow();
        	this.ds_Cond.setColumn(0, "UPJANG",         this.upjang);
        	this.ds_Cond.setColumn(0, "NEED_DATE",      this.needDate);

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
        				this.edt_credit.set_value(this.gfn_NumFormat(this.ds_CrdInfo.getColumn(0,"CREDIT_RMN_AMT"))+ " 원");				
        			}
        			else
        			{
        				this.edt_credit.set_value("무 제 한");
        			}
        				
        			if(saveChk == "SAVE")
        			{
        				//발주가능 체크(창고)
        				if (! this.fn_OrdChk()) return;
        				
        				// 데이타체크(디데이체크)
        				sRtn = this.fn_ChkData();
        				if ( !this.gfn_isNull(sRtn) ) {
        					application.goMain.gfn_Msg("OK", "알림", sRtn, "OK", "OK");
        					return;
        				} else {
        					this.fn_lastSave();
        				}
        			}	
        				
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
        	this.ds_Dummyin.setColumn(0, "NEED_DATE",      this.needDate);
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

        /*================================================================================
         * 5. UserFunction관련 Script
         *===============================================================================*/
        /*----------------------------------------------------------------------------------------------
         * 설명      : 트랜잭션 콜백 함수 (필수)
         *---------------------------------------------------------------------------------------------*/
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
        		    
        		    //합계금액을 구한후 총합계를 데이터셋에 담는다		
        			this.totalAmt = Math.round(nexacro.toNumber(this.ds_grd.getColumn(this.ds_grd.rowposition,"OP_PRICE")) * nexacro.toNumber(this.ds_grd.getColumn(this.ds_grd.rowposition,"PR_QTY")));
        			this.ds_grd.setColumn(this.ds_grd.rowposition, "OP_AMOUNT", this.totalAmt);		
        	
        			var yTax = this.ds_grd.getCaseSum("TAX_CODE == 100", "OP_AMOUNT") * 1.1;
        			var nTax = this.ds_grd.getCaseSum("TAX_CODE != 100", "OP_AMOUNT") * 1;
        			this.div_search.edt_totalAmt.set_value("총합계: " + this.gfn_NumFormat(yTax+nTax) + "원");
        			
        			break;
        		case "errorListPop":
        		    this.fn_search();
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
        	
        	var nRow = this.ds_grd.rowposition;;
        	
        	//디데이체크시 경고창 콜백
        	if (id == "getDaysAlert")
        	{
        		this.fn_OrdCtrl();
        	}
        	//여신체크후 경고창 콜백
        	if (id == "getCreditAlert")
        	{
        		
        	}
        	//검색전 변경 체크후
        	if (id == "confirm")
        	{
        		if (rtn == "Y") 
        		{
        			this.fn_finalSearch();
        		}
        		else
        		{
        			return;
        		}		
        	}

        	// 건별로 삭제할 경우
        	if (id == "delete")
        	{
        		if (rtn == "Y") 
        		{				
        			if (this.GetRowType(this.ds_grd,this.ds_grd.rowposition)== "insert")
        			{	
        				this.ds_grd.deleteRow(nRow);
        				
        				this.ds_grd.filter("dataset.getRowType(rowidx)==2"); 
        				
        				application.gds_marketFicsNewList.clearData();
        				application.gds_marketFicsNewList.copyData(this.ds_grd, true);
        				
        				this.ds_grd.filter(""); 
        				
        				//합계금액을 구한후 총합계를 데이터셋에 담는다
        				for(var i=0; i < this.ds_grd.rowcount; i++)
        				{	
        					this.totalAmt = Math.round(nexacro.toNumber(this.ds_grd.getColumn(i,"OP_PRICE")) * nexacro.toNumber(this.ds_grd.getColumn(i,"PR_QTY")));
        					this.ds_grd.setColumn(i, "OP_AMOUNT", this.totalAmt);
        				}
        				
        					var yTax = this.ds_grd.getCaseSum("TAX_CODE == 100", "OP_AMOUNT") * 1.1;
        					var nTax = this.ds_grd.getCaseSum("TAX_CODE != 100", "OP_AMOUNT") * 1;
        					this.div_search.edt_totalAmt.set_value("총합계: " + this.gfn_NumFormat(yTax+nTax) + "원");				
        				return;
        			}
        			
        			this.fn_delete();
        			
        		}
        		else
        		{
        			return;
        		}
        	}
        	// 발주확정시 저장체크
        	else if (id == "save")
        	{
        		if (rtn == "Y") 
        		{
        			this.fn_save();
        		}
        		else
        		{
        			return;
        		}
        	}
        	// 발주확정시 최종저장일경우
        	else if (id == "lastSave")
        	{
        		if (rtn == "Y") 
        		{
        			this.fn_saveChk();
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
        		if ( this.parent.parent.divBottom.visible == true)
        		{
        			this.parent.parent.divBottom.set_visible(false);
        			this.parent.parent.divMain.set_height(923);
        		}
        		// 검색 영역 컨트롤
        		if ( this.div_search.visible == true)
        		{
        			this.div_search.set_visible(false);
        			this.grd_list.setOffsetTop(this.sta_setTimer.getOffsetBottom());
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

        this.ShoppingFicsBasket_ontimer = function(obj,e)
        {
        	if (e.timerid == 777) this.fn_SetTimer();
        }

        this.ShoppingFicsBasket_onactivate = function(obj,e)
        {
        	//화면 액트브시 타이머 재설정
        	this.fn_SetTimer();
        	this.setTimer(777,30000); //일단 30초 세팅	
        }

        this.ShoppingFicsBasket_ondeactivate = function(obj,e)
        {	
        	//타이머 종료...(타이머 발생으로 쿼리 수행하여 결과값 가져오면 화면이 앞으로 올라온다.
        	this.killTimer(777);
        }
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.ds_grd.addEventHandler("cancolumnchange", this.common_cancolumnchange, this);
            this.ds_grd.addEventHandler("oncolumnchanged", this.common_oncolumnchanged, this);
            this.addEventHandler("onload", this.form_onload, this);
            this.addEventHandler("ontimer", this.ShoppingFicsBasket_ontimer, this);
            this.addEventHandler("onactivate", this.ShoppingFicsBasket_onactivate, this);
            this.addEventHandler("ondeactivate", this.ShoppingFicsBasket_ondeactivate, this);
            this.Static68.addEventHandler("onclick", this.Static68_onclick, this);
            this.Static21.addEventHandler("onclick", this.Static68_onclick, this);
            this.div_search.btn_save.addEventHandler("onclick", this.Common_Btn_common_OnClick, this);
            this.div_search.btn_search.addEventHandler("onclick", this.Common_Btn_common_OnClick, this);
            this.grd_list.addEventHandler("onvscroll", this.div_shoppingBasket_grd_list_onvscroll, this);
            this.grd_list.addEventHandler("oncellclick", this.grd_list_oncellclick, this);
            this.grd_list.addEventHandler("oncelldblclick", this.grd_list_oncelldblclick, this);
            this.grd_list.addEventHandler("onslide", this.div_shoppingBasket_grd_list_onslide, this);

        };

        this.loadIncludeScript("ShoppingFicsBasket.xfdl", true);

       
    };
}
)();
