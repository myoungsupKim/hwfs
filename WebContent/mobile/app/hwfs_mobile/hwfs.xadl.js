(function()
{
    return function()
    {
        // Theme, Component URI Setting
        this._theme_uri = "./_theme_/";
        this._globalvar_uri = "globalvars.xml";
        this.loadTypedefition = function()
        {
            // this._addService(prefixid, type, url, cachelevel, codepage, language, version, communication);
            this._addService("default_typedef.xml", "frame", "form", "./frame/", "", null, "", "0", "0");
            this._addService("default_typedef.xml", "lib", "js", "./lib/", "", null, "", "0", "0");
            this._addService("default_typedef.xml", "cmmn", "form", "./cmmn/", "", null, "", "0", "0");
            this._addService("default_typedef.xml", "sample", "form", "./sample/", "", null, "", "0", "0");
            this._addService("default_typedef.xml", "frame_sample", "form", "./frame_sample/", "", null, "", "0", "0");
            this._addService("default_typedef.xml", "guide", "form", "./guide/", "", null, "", "0", "0");
            this._addService("default_typedef.xml", "fspmob", "js", "./fspmob/", "", null, "", "0", "0");
            this._addService("default_typedef.xml", "svc", "JSP", "http://localhost:8080/", "session", null, "", "0", "0");
            this._addService("default_typedef.xml", "HWImage", "file", "./HWImage/", "", null, "", "0", "0");
            this._addService("default_typedef.xml", "M_MOM", "form", "./mForm/ms/mom/", "session", null, "", "0", "0");
            this._addService("default_typedef.xml", "M_MIM", "form", "./mForm/ms/mim/", "session", null, "", "0", "0");
            this._addService("default_typedef.xml", "M_MPI", "form", "./mForm/ms/mpi/", "session", null, "", "0", "0");
            this._addService("default_typedef.xml", "M_MLM", "form", "./mForm/ms/mlm/", "session", null, "", "0", "0");
            this._addService("default_typedef.xml", "M_MEF", "form", "./mForm/ms/mef/", "session", null, "", "0", "0");
            this._addService("default_typedef.xml", "M_MSM", "form", "./mForm/ms/msm/", "session", null, "", "0", "0");
            this._addService("default_typedef.xml", "M_MTM", "form", "./mForm/ms/mtm/", "session", null, "", "0", "0");
            this._addService("default_typedef.xml", "M_MCM", "form", "./mForm/ms/mcm/", "session", null, "", "0", "0");
            this._addService("default_typedef.xml", "M_MWR", "form", "./mForm/ms/mwr/", "session", null, "", "0", "0");
            this._addService("default_typedef.xml", "M_MMB", "form", "./mForm/ms/mmb/", "session", null, "", "0", "0");
            this._addService("default_typedef.xml", "M_MES", "form", "./mForm/ms/mes/", "session", null, "", "0", "0");
            this._addService("default_typedef.xml", "M_MPM", "form", "./mForm/ms/mpm/", "session", null, "", "0", "0");
            this._addService("default_typedef.xml", "U_svc", "form", "http://localhost:8080/hwfs_svc/", "session", null, "", "0", "0");

            this._component_uri = (this._arg_compurl ? this._arg_compurl : "./nexacro14lib/component/");
            // load components
            var registerclass = [
            		{"id":"Div", "classname":"nexacro.Div", "type":"JavaScript"},
            		{"id":"Button", "classname":"nexacro.Button", "type":"JavaScript"},
            		{"id":"PopupDiv", "classname":"nexacro.PopupDiv", "type":"JavaScript"},
            		{"id":"Combo", "classname":"nexacro.Combo", "type":"JavaScript"},
            		{"id":"CheckBox", "classname":"nexacro.CheckBox", "type":"JavaScript"},
            		{"id":"ListBox", "classname":"nexacro.ListBox", "type":"JavaScript"},
            		{"id":"Edit", "classname":"nexacro.Edit", "type":"JavaScript"},
            		{"id":"MaskEdit", "classname":"nexacro.MaskEdit", "type":"JavaScript"},
            		{"id":"TextArea", "classname":"nexacro.TextArea", "type":"JavaScript"},
            		{"id":"Menu", "classname":"nexacro.Menu", "type":"JavaScript"},
            		{"id":"Tab", "classname":"nexacro.Tab", "type":"JavaScript"},
            		{"id":"ImageViewer", "classname":"nexacro.ImageViewer", "type":"JavaScript"},
            		{"id":"Radio", "classname":"nexacro.Radio", "type":"JavaScript"},
            		{"id":"Calendar", "classname":"nexacro.Calendar", "type":"JavaScript"},
            		{"id":"Static", "classname":"nexacro.Static", "type":"JavaScript"},
            		{"id":"Grid", "classname":"nexacro.Grid", "type":"JavaScript"},
            		{"id":"Spin", "classname":"nexacro.Spin", "type":"JavaScript"},
            		{"id":"PopupMenu", "classname":"nexacro.PopupMenu", "type":"JavaScript"},
            		{"id":"GroupBox", "classname":"nexacro.GroupBox", "type":"JavaScript"},
            		{"id":"ProgressBar", "classname":"nexacro.ProgressBar", "type":"JavaScript"},
            		{"id":"Plugin", "classname":"nexacro.Plugin", "type":"JavaScript"},
            		{"id":"Dataset", "classname":"nexacro.NormalDataset", "type":"JavaScript"},
            		{"id":"WebBrowser", "classname":"nexacro.WebBrowser", "type":"JavaScript"},
            		{"id":"Map", "classname":"nexacro.Map", "type":"JavaScript"},
            		{"id":"FSPMobile", "classname":"nexacro.FSPMobile", "type":"JavaScript"},
            		{"id":"Utils", "classname":"nexacro.Utils", "type":"JavaScript"},
            		{"id":"GeoLocation", "classname":"nexacro.Geolocation", "type":"JavaScript"},
            		{"id":"MapMarker", "classname":"nexacro.MapMarker", "type":"JavaScript"}
            ];
            this._addClasses(registerclass);
        };
        
        this.on_loadGlobalVariables = function()
        {
            // global variable
            this._addVariable("goMain", null, "false", "false");
            this._addVariable("gv_ID", null, "false", "false");
            this._addVariable("gv_PW", null, "false", "false");
            this._addVariable("gv_saveID", "0", "false", "false");
            this._addVariable("gvWaitCount", "0", "false", "false");
            this._addVariable("goTopMain", null, "false", "false");
            this._addVariable("gv_menuId", "undefined", "false", "false");
            this._addVariable("gv_menuName", "undefined", "false", "false");
            this._addVariable("gv_formUrl", "undefined", "false", "false");
            this._addVariable("goTopSub", null, "false", "false");
            this._addVariable("gvTimerID_PopDestroy", null, "false", "false");
            this._addVariable("gn_pageCnt", "10", "false", "false");
            this._addVariable("gvLoginYN", "N", "false", "false");
            this._addVariable("gv_backFlag", "menu", "false", "false");
            this._addVariable("gv_autoLogin", "N", "false", "false");
            this._addVariable("gv_isHybrid", "N", "false", "false");
            this._addVariable("g_AuthLevel", "999", "false", "false");
            this._addVariable("g_Cc_Cd", "AC008", "false", "false");
            this._addVariable("g_Cc_Nm", "정보기획팀", "false", "false");
            this._addVariable("g_CustCd", "227031", "false", "false");
            this._addVariable("g_CustNm", "한양식품", "false", "false");
            this._addVariable("g_Deptid", "2982", "false", "false");
            this._addVariable("g_DeptNm", "본사 Staff 정보기획팀", "false", "false");
            this._addVariable("g_EmpNo", "L20141113", "false", "false");
            this._addVariable("g_Main_Upjang", null, "false", "false");
            this._addVariable("g_Main_UpjangNm", null, "false", "false");
            this._addVariable("g_Mu_Cd", "AC", "false", "false");
            this._addVariable("g_Mu_Nm", "본사", "false", "false");
            this._addVariable("g_Name", "개발자", "false", "false");
            this._addVariable("g_OtCustCd", null, "false", "false");
            this._addVariable("g_OtCustNm", null, "false", "false");
            this._addVariable("g_Sc_Cd", "AT", "false", "false");
            this._addVariable("g_Sc_Nm", "Staff", "false", "false");
            this._addVariable("g_Tm_Cd", "A87", "false", "false");
            this._addVariable("g_Tm_Nm", "Staff", "false", "false");
            this._addVariable("g_Upjang", "114998", "false", "false");
            this._addVariable("g_UpjangGroup", null, "false", "false");
            this._addVariable("g_UpjangNm", "본사 정보기획팀", "false", "false");
            this._addVariable("g_UserGroup", "리조트", "false", "false");
            this._addVariable("g_UserKind", "본부", "false", "false");
            this._addVariable("g_Simple_Po_Yn", "N", "false", "false");
            this._addVariable("g_SystemId", "FSMOBILE", "false", "false");
            this._addVariable("g_Board_Mst", "관리자", "false", "false");
            this._addVariable("gv_sysType", "ALL", "false", "false");
            this._addVariable("gv_runMode", null, "false", "false");
            this._addVariable("gv_webRoot", null, "false", "false");
            this._addVariable("gv_chartPath", null, "false", "false");
            this._addVariable("gv_namoInitUrl", null, "false", "false");
            this._addVariable("gv_IsGridCheckAll", null, "false", "false");
            this._addVariable("gv_progrmId", null, "false", "false");
            this._addVariable("gv_ktagTokenField", "savedToken", "false", "false");
            this._addVariable("gv_savedToken", null, "false", "false");
            this._addVariable("gv_xp_txdatatype", "0", "true", "false");
            this._addVariable("outSavedToken", null, "false", "false");
            this._addVariable("g_UserType", "내부", "false", "false");
            this._addVariable("gv_param", "undefined", "false", "false");
            this._addVariable("g_userId", null, "false", "false");
            this._addVariable("goButtom", null, "false", "false");
            this._addVariable("gv_saveId", "N", "false", "false");
            this._addVariable("gv_pushChk", "N", "false", "false");
            this._addVariable("gv_subinvCd", null, "false", "false");
            this._addVariable("g_updateChk", "false", "false", "false");
            this._addVariable("goMenu", null, "false", "false");
            this._addVariable("gv_menuBefId", null, "false", "false");
            this._addVariable("gv_formBefUrl", null, "false", "false");
            this._addVariable("gv_menuBefName", null, "false", "false");
            this._addVariable("gv_progrmBefId", null, "false", "false");
            this._addVariable("gv_runMode2", null, "false", "false");
            this._addVariable("g_UpjangGubun", "upjangRole", "false", "false");
            this._addVariable("g_UpjangFlag1", "N", "false", "false");
            this._addVariable("g_UpjangFlag2", "N", "false", "false");
            this._addVariable("g_RoleSetId1", "ScoAuthLevel", "false", "false");
            this._addVariable("g_RoleSetId2", "ScoAuthLevel", "false", "false");
            this._addVariable("g_useTmCd", "Y", "false", "false");

            // global image

            // global dataset
            var obj = null;
            obj = new Dataset("gds_loginInfo", this);
            obj.set_preload("true");
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj._setContents("<ColumnInfo><Column id=\"IP_ADDR\" size=\"6\" type=\"STRING\"/><Column id=\"SINGLE_ID\" size=\"20\" type=\"STRING\"/><Column id=\"CAMP_FG\" size=\"1\" type=\"STRING\"/><Column id=\"USER_ID\" size=\"9\" type=\"STRING\"/><Column id=\"KOR_NM\" size=\"40\" type=\"STRING\"/><Column id=\"RESNO\" size=\"13\" type=\"STRING\"/><Column id=\"DEPT_CD\" size=\"6\" type=\"STRING\"/><Column id=\"DEPT_NM\" size=\"40\" type=\"STRING\"/><Column id=\"DEPT_TTNM\" size=\"100\" type=\"STRING\"/><Column id=\"STAFF_CD\" size=\"1\" type=\"STRING\"/><Column id=\"STAFF_NM\" size=\"4\" type=\"STRING\"/><Column id=\"STAFF_GB\" size=\"5\" type=\"STRING\"/><Column id=\"STAFF_GB_NM\" size=\"3\" type=\"STRING\"/><Column id=\"MISS_CD\" size=\"6\" type=\"STRING\"/><Column id=\"WKGD_CD\" size=\"6\" type=\"STRING\"/><Column id=\"MISS_NM\" size=\"100\" type=\"STRING\"/><Column id=\"MISS_GRP_CD\" size=\"6\" type=\"STRING\"/><Column id=\"UP_DEPT_CD\" size=\"6\" type=\"STRING\"/><Column id=\"DEPT_GRP\" size=\"6\" type=\"STRING\"/><Column id=\"OFCE_TEL_NO\" size=\"20\" type=\"STRING\"/><Column id=\"HAND_NO\" size=\"20\" type=\"STRING\"/><Column id=\"NOW_COLG\" size=\"6\" type=\"STRING\"/><Column id=\"NOW_SUST\" size=\"6\" type=\"STRING\"/><Column id=\"NOW_MJ\" size=\"6\" type=\"STRING\"/><Column id=\"SHREG_CD\" size=\"6\" type=\"STRING\"/><Column id=\"SHREG_NM\" size=\"80\" type=\"STRING\"/><Column id=\"REG_TM_CNT\" size=\"22\" type=\"STRING\"/><Column id=\"CETE_TM_CNT\" size=\"22\" type=\"STRING\"/><Column id=\"TLSN_TM_CNT\" size=\"22\" type=\"STRING\"/><Column id=\"STD_DIV\" size=\"6\" type=\"STRING\"/><Column id=\"STD_DIV_NM\" size=\"80\" type=\"STRING\"/><Column id=\"SHYR\" size=\"1\" type=\"STRING\"/></ColumnInfo>");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_promShtmStud", this);
            obj._setContents("<ColumnInfo><Column id=\"BASI_YY\" type=\"STRING\" size=\"256\"/><Column id=\"BASI_SHTM_CD\" type=\"STRING\" size=\"256\"/><Column id=\"BASI_SHTM\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_tretFg", this);
            obj._setContents("<ColumnInfo><Column id=\"CODE\" type=\"STRING\" size=\"1\"/><Column id=\"NAME\" type=\"STRING\" size=\"20\"/></ColumnInfo><Rows><Row><Col id=\"CODE\">1</Col><Col id=\"NAME\">작성</Col></Row><Row><Col id=\"CODE\">2</Col><Col id=\"NAME\">결재중(팀)</Col></Row><Row><Col id=\"CODE\">3</Col><Col id=\"NAME\">반려</Col></Row><Row><Col id=\"CODE\">4</Col><Col id=\"NAME\">접수</Col></Row><Row><Col id=\"CODE\">5</Col><Col id=\"NAME\">결재중</Col></Row><Row><Col id=\"CODE\">6</Col><Col id=\"NAME\">승인</Col></Row><Row><Col id=\"CODE\">7</Col><Col id=\"NAME\">반려</Col></Row><Row><Col id=\"CODE\">9</Col><Col id=\"NAME\">취소</Col></Row></Rows>");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_msgInfo", this);
            obj._setContents("<ColumnInfo><Column id=\"CODE\" type=\"STRING\" size=\"4\"/><Column id=\"TITLE\" type=\"STRING\" size=\"100\"/><Column id=\"MSG\" type=\"STRING\" size=\"256\"/><Column id=\"KIND\" type=\"STRING\" size=\"1\"/></ColumnInfo><Rows><Row/></Rows>");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_ovtmTime", this);
            obj._setContents("<ColumnInfo><Column id=\"CODE\" type=\"STRING\" size=\"1\"/><Column id=\"NAME\" type=\"STRING\" size=\"20\"/></ColumnInfo><Rows><Row><Col id=\"CODE\">0</Col><Col id=\"NAME\">당일</Col></Row><Row><Col id=\"CODE\">1</Col><Col id=\"NAME\">익일</Col></Row></Rows>");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_menuList", this);
            obj._setContents("<ColumnInfo><Column id=\"ROLE_ID\" type=\"STRING\" size=\"256\"/><Column id=\"MENU_CD\" type=\"STRING\" size=\"256\"/><Column id=\"UP_MENU_CD\" type=\"STRING\" size=\"256\"/><Column id=\"USE_GRD\" type=\"STRING\" size=\"256\"/><Column id=\"PGM_NM\" type=\"STRING\" size=\"256\"/><Column id=\"PGM_ID\" type=\"STRING\" size=\"256\"/><Column id=\"MENU_DEP\" type=\"STRING\" size=\"256\"/><Column id=\"MENU_CD1\" type=\"STRING\" size=\"256\"/><Column id=\"MENU_CD2\" type=\"STRING\" size=\"256\"/><Column id=\"PGM_PATH\" type=\"STRING\" size=\"256\"/><Column id=\"MENU_ORD\" type=\"STRING\" size=\"256\"/><Column id=\"FORM_URL\" type=\"STRING\" size=\"256\"/><Column id=\"TREE_LVL\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_myKuList", this);
            obj.set_useclientlayout("true");
            obj._setContents("<ColumnInfo><Column id=\"ROLE_ID\" type=\"STRING\" size=\"256\"/><Column id=\"MENU_CD\" type=\"STRING\" size=\"256\"/><Column id=\"SINGLE_ID\" type=\"STRING\" size=\"256\"/><Column id=\"UP_MENU_CD\" type=\"STRING\" size=\"256\"/><Column id=\"USE_GRD\" type=\"STRING\" size=\"256\"/><Column id=\"PGM_NM\" type=\"STRING\" size=\"256\"/><Column id=\"PGM_ID\" type=\"STRING\" size=\"256\"/><Column id=\"MENU_DEP\" type=\"STRING\" size=\"256\"/><Column id=\"MENU_CD1\" type=\"STRING\" size=\"256\"/><Column id=\"MENU_CD2\" type=\"STRING\" size=\"256\"/><Column id=\"PGM_PATH\" type=\"STRING\" size=\"256\"/><Column id=\"MENU_ORD\" type=\"STRING\" size=\"256\"/><Column id=\"FULL_PATH\" type=\"STRING\" size=\"256\"/><Column id=\"chk\" type=\"STRING\" size=\"1\"/></ColumnInfo>");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_staffCb", this);
            obj._setContents("<ColumnInfo><Column id=\"code\" type=\"STRING\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/><Column id=\"userid\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_subMenu", this);
            obj._setContents("<ColumnInfo><Column id=\"ROLE_ID\" type=\"STRING\" size=\"256\"/><Column id=\"MENU_CD\" type=\"STRING\" size=\"256\"/><Column id=\"UP_MENU_CD\" type=\"STRING\" size=\"256\"/><Column id=\"USE_GRD\" type=\"STRING\" size=\"256\"/><Column id=\"PGM_NM\" type=\"STRING\" size=\"256\"/><Column id=\"PGM_ID\" type=\"STRING\" size=\"256\"/><Column id=\"MENU_DEP\" type=\"STRING\" size=\"256\"/><Column id=\"MENU_CD1\" type=\"STRING\" size=\"256\"/><Column id=\"MENU_CD2\" type=\"STRING\" size=\"256\"/><Column id=\"PGM_PATH\" type=\"STRING\" size=\"256\"/><Column id=\"MENU_ORD\" type=\"STRING\" size=\"256\"/><Column id=\"FORM_URL\" type=\"STRING\" size=\"256\"/><Column id=\"TREE_LVL\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_promShtmGrdt", this);
            obj._setContents("<ColumnInfo><Column id=\"BASI_YY\" type=\"STRING\" size=\"256\"/><Column id=\"BASI_SHTM_CD\" type=\"STRING\" size=\"256\"/><Column id=\"BASI_SHTM\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_userInfo", this);
            obj._setContents("<ColumnInfo><Column id=\"userid\" type=\"STRING\" size=\"256\"/><Column id=\"pswdChk\" type=\"STRING\" size=\"256\"/><Column id=\"usrNm\" type=\"STRING\" size=\"256\"/><Column id=\"usrEngNm\" type=\"STRING\" size=\"256\"/><Column id=\"rno\" type=\"STRING\" size=\"256\"/><Column id=\"offcCd\" type=\"STRING\" size=\"256\"/><Column id=\"offcNm\" type=\"STRING\" size=\"256\"/><Column id=\"ogCd\" type=\"STRING\" size=\"256\"/><Column id=\"ogNm\" type=\"STRING\" size=\"256\"/><Column id=\"posCd\" type=\"STRING\" size=\"256\"/><Column id=\"posNm\" type=\"STRING\" size=\"256\"/><Column id=\"psitNm\" type=\"STRING\" size=\"256\"/><Column id=\"pno\" type=\"STRING\" size=\"256\"/><Column id=\"faxNo\" type=\"STRING\" size=\"256\"/><Column id=\"mblPno\" type=\"STRING\" size=\"256\"/><Column id=\"zipNo\" type=\"STRING\" size=\"256\"/><Column id=\"addr\" type=\"STRING\" size=\"256\"/><Column id=\"emailAddr\" type=\"STRING\" size=\"256\"/><Column id=\"fnlConnIp\" type=\"STRING\" size=\"256\"/><Column id=\"fnlConnDtm\" type=\"STRING\" size=\"256\"/><Column id=\"bgnDt\" type=\"STRING\" size=\"256\"/><Column id=\"edt\" type=\"STRING\" size=\"256\"/><Column id=\"fnlModrId\" type=\"STRING\" size=\"256\"/><Column id=\"fnlModDtm\" type=\"STRING\" size=\"256\"/><Column id=\"certDn\" type=\"STRING\" size=\"256\"/><Column id=\"popupYn\" type=\"STRING\" size=\"256\"/><Column id=\"sesId\" type=\"STRING\" size=\"256\"/><Column id=\"pupMarkYn\" type=\"STRING\" size=\"256\"/><Column id=\"usrDivCd\" type=\"STRING\" size=\"256\"/><Column id=\"dfnYn\" type=\"STRING\" size=\"256\"/><Column id=\"smsUseYn\" type=\"STRING\" size=\"256\"/><Column id=\"persInfoAgreeYn\" type=\"STRING\" size=\"256\"/><Column id=\"persInfoMask\" type=\"STRING\" size=\"256\"/><Column id=\"persInfoProcLevel\" type=\"STRING\" size=\"256\"/><Column id=\"ctiUseYn\" type=\"STRING\" size=\"256\"/><Column id=\"ctiUserId\" type=\"STRING\" size=\"256\"/><Column id=\"authLevels\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row/></Rows>");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_menu", this);
            obj.set_useclientlayout("true");
            obj._setContents("<ColumnInfo><Column id=\"sysId\" type=\"STRING\" size=\"256\"/><Column id=\"sysName\" type=\"STRING\" size=\"256\"/><Column id=\"menuId\" type=\"STRING\" size=\"256\"/><Column id=\"menuName\" type=\"STRING\" size=\"256\"/><Column id=\"parentMenuId\" type=\"STRING\" size=\"256\"/><Column id=\"prgId\" type=\"STRING\" size=\"256\"/><Column id=\"prgName\" type=\"STRING\" size=\"256\"/><Column id=\"prgPath\" type=\"STRING\" size=\"256\"/><Column id=\"menuType\" type=\"STRING\" size=\"256\"/><Column id=\"levels\" type=\"STRING\" size=\"256\"/><Column id=\"sortSeq\" type=\"STRING\" size=\"256\"/><Column id=\"useYn\" type=\"STRING\" size=\"256\"/><Column id=\"prgType\" type=\"STRING\" size=\"256\"/><Column id=\"leaderMenu\" type=\"STRING\" size=\"256\"/><Column id=\"isLeaf\" type=\"INT\" size=\"256\"/><Column id=\"callParam\" type=\"STRING\" size=\"256\"/><Column id=\"ALL\" type=\"STRING\" size=\"256\"/><Column id=\"IFIS\" type=\"STRING\" size=\"256\"/><Column id=\"FICS\" type=\"STRING\" size=\"256\"/><Column id=\"isRMenu\" type=\"STRING\" size=\"256\"/><Column id=\"attr01\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_rMenu", this);
            obj.set_useclientlayout("true");
            obj._setContents("<ColumnInfo><Column id=\"sysId\" type=\"STRING\" size=\"256\"/><Column id=\"sysName\" type=\"STRING\" size=\"256\"/><Column id=\"menuId\" type=\"STRING\" size=\"256\"/><Column id=\"menuName\" type=\"STRING\" size=\"256\"/><Column id=\"parentMenuId\" type=\"STRING\" size=\"256\"/><Column id=\"prgId\" type=\"STRING\" size=\"256\"/><Column id=\"prgName\" type=\"STRING\" size=\"256\"/><Column id=\"prgPath\" type=\"STRING\" size=\"256\"/><Column id=\"menuType\" type=\"STRING\" size=\"256\"/><Column id=\"levels\" type=\"STRING\" size=\"256\"/><Column id=\"sortSeq\" type=\"STRING\" size=\"256\"/><Column id=\"useYn\" type=\"STRING\" size=\"256\"/><Column id=\"prgType\" type=\"STRING\" size=\"256\"/><Column id=\"leaderMenu\" type=\"STRING\" size=\"256\"/><Column id=\"isLeaf\" type=\"INT\" size=\"256\"/><Column id=\"callParam\" type=\"STRING\" size=\"256\"/><Column id=\"ALL\" type=\"STRING\" size=\"256\"/><Column id=\"IFIS\" type=\"STRING\" size=\"256\"/><Column id=\"FICS\" type=\"STRING\" size=\"256\"/><Column id=\"isRMenu\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"sysId\">1</Col><Col id=\"sysName\">발주관리</Col><Col id=\"menuId\">0101</Col><Col id=\"menuName\">추가발주</Col><Col id=\"parentMenuId\">01</Col><Col id=\"levels\">1</Col><Col id=\"prgId\">AdditionOrder.xfdl</Col><Col id=\"prgPath\">M_MOM</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"sysId\">1</Col><Col id=\"sysName\">발주관리</Col><Col id=\"menuId\">0103</Col><Col id=\"menuName\">상품발주</Col><Col id=\"parentMenuId\">01</Col><Col id=\"levels\">1</Col><Col id=\"prgPath\">M_MOM</Col><Col id=\"prgId\">ProductOrderTab.xfdl</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"sysId\">1</Col><Col id=\"sysName\">발주관리</Col><Col id=\"menuId\">0104</Col><Col id=\"menuName\">일일발주내역</Col><Col id=\"parentMenuId\">01</Col><Col id=\"levels\">1</Col><Col id=\"prgPath\">M_MOM</Col><Col id=\"prgId\">ProductOrderReport.xfdl</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"sysId\">2</Col><Col id=\"sysName\">재고관리</Col><Col id=\"menuId\">0201</Col><Col id=\"menuName\">재고등록</Col><Col id=\"parentMenuId\">02</Col><Col id=\"levels\">1</Col><Col id=\"prgPath\">M_MIM</Col><Col id=\"prgId\">InventoryRegt.xfdl</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"sysId\">4</Col><Col id=\"sysName\">E-FOODIST</Col><Col id=\"menuId\">0401</Col><Col id=\"menuName\">E-FOODIST</Col><Col id=\"parentMenuId\">04</Col><Col id=\"prgId\">Efoodist.xfdl</Col><Col id=\"prgPath\">M_MEF</Col><Col id=\"levels\">1</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"sysName\">클레임관리</Col><Col id=\"menuName\">클레임 신청</Col><Col id=\"sysId\">8</Col><Col id=\"menuId\">0801</Col><Col id=\"parentMenuId\">08</Col><Col id=\"prgId\">ClaimProcessReqt.xfdl</Col><Col id=\"prgPath\">M_MCM</Col><Col id=\"levels\">1</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"sysName\">클레임관리</Col><Col id=\"menuName\">클레임 현황</Col><Col id=\"sysId\">8</Col><Col id=\"menuId\">0802</Col><Col id=\"parentMenuId\">08</Col><Col id=\"prgId\">ClaimProcessReport.xfdl</Col><Col id=\"prgPath\">M_MCM</Col><Col id=\"levels\">1</Col><Col id=\"useYn\">Y</Col></Row><Row><Col id=\"sysId\">11</Col><Col id=\"sysName\">게시판</Col><Col id=\"menuId\">11</Col><Col id=\"menuName\">공지사항</Col><Col id=\"parentMenuId\"/><Col id=\"prgId\">MassageBoard</Col><Col id=\"prgName\"/><Col id=\"prgPath\">M_MMB</Col><Col id=\"menuType\"/><Col id=\"levels\">1</Col><Col id=\"sortSeq\"/><Col id=\"useYn\">Y</Col><Col id=\"prgType\"/><Col id=\"leaderMenu\"/><Col id=\"isLeaf\"/><Col id=\"callParam\"/></Row></Rows>");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_common_code", this);
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"256\"/><Column id=\"cdNm\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_menuAuth", this);
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"256\"/><Column id=\"cdNm\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_cmnAuth", this);
            obj._setContents("<ColumnInfo><Column id=\"srcYn\" type=\"STRING\" size=\"256\"/><Column id=\"insYn\" type=\"STRING\" size=\"256\"/><Column id=\"delYn\" type=\"STRING\" size=\"256\"/><Column id=\"savYn\" type=\"STRING\" size=\"256\"/><Column id=\"prtYn\" type=\"STRING\" size=\"256\"/><Column id=\"exlYn\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_marketList", this);
            obj._setContents("<ColumnInfo><Column id=\"ITEM_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_CLASS4\" type=\"STRING\" size=\"256\"/><Column id=\"FEATURE_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_SIZE\" type=\"STRING\" size=\"256\"/><Column id=\"PO_UOM\" type=\"STRING\" size=\"256\"/><Column id=\"KG_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"CANCEL_PR_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"G_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"PR_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"PR_AMT\" type=\"STRING\" size=\"256\"/><Column id=\"TOT_AMT\" type=\"STRING\" size=\"256\"/><Column id=\"TAX_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"CENTER_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"PR_REMARK\" type=\"STRING\" size=\"256\"/><Column id=\"REMARK\" type=\"STRING\" size=\"256\"/><Column id=\"POINT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"SUBINV_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"NEED_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"DEPT_ID\" type=\"STRING\" size=\"256\"/><Column id=\"ACCTCD\" type=\"STRING\" size=\"256\"/><Column id=\"BUD_CLS\" type=\"STRING\" size=\"256\"/><Column id=\"MU_CD\" type=\"STRING\" size=\"256\"/><Column id=\"INVAT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"OUTVAT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"MIN_ORD_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"MAX_ORD_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"CENTER_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"STOCK_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"BARCODE\" type=\"STRING\" size=\"256\"/><Column id=\"KEEPING_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"MULTIPLIER_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"BUDDEPT_ID\" type=\"STRING\" size=\"256\"/><Column id=\"USE_YN\" type=\"STRING\" size=\"256\"/><Column id=\"CONTRACT_YN\" type=\"STRING\" size=\"256\"/><Column id=\"MARGIN_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"UNIT_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"CUSTCD\" type=\"STRING\" size=\"256\"/><Column id=\"CHEAP_YN\" type=\"STRING\" size=\"256\"/><Column id=\"KG_CONVERT_RATE\" type=\"STRING\" size=\"256\"/><Column id=\"MARGIN_RATE\" type=\"STRING\" size=\"256\"/><Column id=\"AP_UNITPRICE_UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"RESTRICT_PERIOD\" type=\"STRING\" size=\"256\"/><Column id=\"RESTRICT_REASON\" type=\"STRING\" size=\"256\"/><Column id=\"DUTY_END_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"MIN_DUTY_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"DUTY_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"REAL_USE_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"PR_YN\" type=\"STRING\" size=\"256\"/><Column id=\"SCH_INFO\" type=\"STRING\" size=\"256\"/><Column id=\"SHP_MAP\" type=\"STRING\" size=\"256\"/><Column id=\"MTG_UNS\" type=\"STRING\" size=\"256\"/><Column id=\"MTG_STP\" type=\"STRING\" size=\"256\"/><Column id=\"REQ_WKD\" type=\"STRING\" size=\"256\"/><Column id=\"SCH\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAY\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAYS\" type=\"STRING\" size=\"256\"/><Column id=\"D_TIMES\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAY_YN\" type=\"STRING\" size=\"256\"/><Column id=\"SPICE_YN\" type=\"STRING\" size=\"256\"/><Column id=\"CORN_YN\" type=\"STRING\" size=\"256\"/><Column id=\"IMG_PATH\" type=\"STRING\" size=\"256\"/><Column id=\"ORIGIN_NAT\" type=\"STRING\" size=\"256\"/><Column id=\"ORIGIN_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"VD_SN\" type=\"STRING\" size=\"256\"/><Column id=\"APPLY_SD\" type=\"STRING\" size=\"256\"/><Column id=\"MOBILE_GUBUN\" type=\"STRING\" size=\"256\"/><Column id=\"AGG_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"LINE_STATUS\" type=\"STRING\" size=\"256\"/><Column id=\"CART_IMG\" type=\"STRING\" size=\"256\"/><Column id=\"UPJANG_GRP\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_potype", this);
            obj._setContents("<ColumnInfo><Column id=\"PO_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"TYPE_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAYS\" type=\"STRING\" size=\"256\"/><Column id=\"D_TIMES\" type=\"STRING\" size=\"256\"/><Column id=\"PR_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"PR_APPROVE_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"PO_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"PO_APPROVE_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"PO_CLOSING_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"ORD_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"RC_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"RC_APPROVE_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"AP_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"AP_APPROVE_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"PAST_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"CONTRACT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"SUBINV_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"BUDGET_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"CONTRACT_TABLE\" type=\"STRING\" size=\"256\"/><Column id=\"PR_FORM\" type=\"STRING\" size=\"256\"/><Column id=\"BUDCLS_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"MINUS_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"PREORDER_FLAG\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_storageCd", this);
            obj._setContents("<ColumnInfo><Column id=\"cd\" type=\"STRING\" size=\"256\"/><Column id=\"cdNm\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_currdate", this);
            obj._setContents("<ColumnInfo><Column id=\"YMD\" type=\"STRING\" size=\"256\"/><Column id=\"YMD_TM\" type=\"STRING\" size=\"256\"/><Column id=\"WEEK_CD\" type=\"STRING\" size=\"256\"/><Column id=\"WEEK_KOR\" type=\"STRING\" size=\"256\"/><Column id=\"WEEK_CHA\" type=\"STRING\" size=\"256\"/><Column id=\"WEEK_ENG\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_type", this);
            obj._setContents("<ColumnInfo><Column id=\"TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"PO_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"PR_NUM\" type=\"STRING\" size=\"256\"/><Column id=\"PR_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"NEED_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"SORT_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"PR_FORM\" type=\"STRING\" size=\"256\"/><Column id=\"RC_UPJANG\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_dsPoLineStatus", this);
            obj._setContents("");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_dsPoAuthType", this);
            obj._setContents("");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_dsPoType", this);
            obj._setContents("");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_dsTransType", this);
            obj._setContents("");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_marketFicsList", this);
            obj._setContents("<ColumnInfo><Column id=\"CENTER_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"CENTER_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"CLS_STATUS\" type=\"STRING\" size=\"256\"/><Column id=\"CUSTCD\" type=\"STRING\" size=\"256\"/><Column id=\"INVAT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_SIZE\" type=\"STRING\" size=\"256\"/><Column id=\"LINE_STATUS\" type=\"STRING\" size=\"256\"/><Column id=\"MARGIN_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"MIN_ORD_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"MAX_ORD_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"MULTIPLIER_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"NEED_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"OTCUSTCD\" type=\"STRING\" size=\"256\"/><Column id=\"OUTVAT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"PO_UOM\" type=\"STRING\" size=\"256\"/><Column id=\"POINT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"PR_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"PR_REMARK\" type=\"STRING\" size=\"256\"/><Column id=\"PR_UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"RC_UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"SALE_AMOUNT\" type=\"STRING\" size=\"256\"/><Column id=\"SALE_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"SUBINV_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"TAX_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"UNIT_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"OP_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"OP_AMOUNT\" type=\"STRING\" size=\"256\"/><Column id=\"OP_AMOUNT_OLD\" type=\"STRING\" size=\"256\"/><Column id=\"G_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAYS\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAY_DISP\" type=\"STRING\" size=\"256\"/><Column id=\"D_TIMES\" type=\"STRING\" size=\"256\"/><Column id=\"OTCUSTNM\" type=\"STRING\" size=\"256\"/><Column id=\"KG_CONVERT_RATE\" type=\"STRING\" size=\"256\"/><Column id=\"FEATURE_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"IMAGE_PATH\" type=\"STRING\" size=\"256\"/><Column id=\"LIMIT_ITEM\" type=\"STRING\" size=\"256\"/><Column id=\"LIMIT_REASON\" type=\"STRING\" size=\"256\"/><Column id=\"WEEK_ITEM_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"CONSUM_YN\" type=\"STRING\" size=\"256\"/><Column id=\"IMAGE_YN\" type=\"STRING\" size=\"256\"/><Column id=\"KEEPING_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"APPLY_SD\" type=\"STRING\" size=\"256\"/><Column id=\"VD_SN\" type=\"STRING\" size=\"256\"/><Column id=\"ORIGIN_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"MOBILE_GUBUN\" type=\"STRING\" size=\"256\"/><Column id=\"MAX_SO_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"UPJANG_GRP\" type=\"STRING\" size=\"256\"/><Column id=\"FEATURE_ICON\" type=\"STRING\" size=\"256\"/><Column id=\"OP_RATE\" type=\"STRING\" size=\"256\"/><Column id=\"APPROVE_NUM\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_dsCond", this);
            obj._setContents("<ColumnInfo><Column id=\"ITEM_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"NEED_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"SUBINV_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"CONSUM_YN\" type=\"STRING\" size=\"256\"/><Column id=\"QTY_CONTROL_YN\" type=\"STRING\" size=\"256\"/><Column id=\"CENTER_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"AP_UNITPRICE_UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"OTCUST_PRICE_UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"FAVOR_GROUP\" type=\"STRING\" size=\"256\"/><Column id=\"NEED_DATEP\" type=\"STRING\" size=\"256\"/><Column id=\"UPJANGP\" type=\"STRING\" size=\"256\"/><Column id=\"SUBINV_CODEP\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_CLASS2\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_CLASS3\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_CLASS4\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_CODE\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_dummy", this);
            obj._setContents("");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_condi", this);
            obj._setContents("");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_marketFicsNewList", this);
            obj._setContents("<ColumnInfo><Column id=\"CENTER_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"CENTER_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"CLS_STATUS\" type=\"STRING\" size=\"256\"/><Column id=\"CUSTCD\" type=\"STRING\" size=\"256\"/><Column id=\"INVAT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"ITEM_SIZE\" type=\"STRING\" size=\"256\"/><Column id=\"LINE_STATUS\" type=\"STRING\" size=\"256\"/><Column id=\"MARGIN_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"MIN_ORD_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"MAX_ORD_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"MULTIPLIER_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"NEED_DATE\" type=\"STRING\" size=\"256\"/><Column id=\"OTCUSTCD\" type=\"STRING\" size=\"256\"/><Column id=\"OUTVAT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"PO_UOM\" type=\"STRING\" size=\"256\"/><Column id=\"POINT_FLAG\" type=\"STRING\" size=\"256\"/><Column id=\"PR_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"PR_REMARK\" type=\"STRING\" size=\"256\"/><Column id=\"PR_UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"RC_UPJANG\" type=\"STRING\" size=\"256\"/><Column id=\"SALE_AMOUNT\" type=\"STRING\" size=\"256\"/><Column id=\"SALE_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"SUBINV_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"TAX_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"UNIT_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"OP_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"OP_AMOUNT\" type=\"STRING\" size=\"256\"/><Column id=\"OP_AMOUNT_OLD\" type=\"STRING\" size=\"256\"/><Column id=\"G_PRICE\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAYS\" type=\"STRING\" size=\"256\"/><Column id=\"D_DAY_DISP\" type=\"STRING\" size=\"256\"/><Column id=\"D_TIMES\" type=\"STRING\" size=\"256\"/><Column id=\"OTCUSTNM\" type=\"STRING\" size=\"256\"/><Column id=\"KG_CONVERT_RATE\" type=\"STRING\" size=\"256\"/><Column id=\"FEATURE_NAME\" type=\"STRING\" size=\"256\"/><Column id=\"IMAGE_PATH\" type=\"STRING\" size=\"256\"/><Column id=\"LIMIT_ITEM\" type=\"STRING\" size=\"256\"/><Column id=\"LIMIT_REASON\" type=\"STRING\" size=\"256\"/><Column id=\"WEEK_ITEM_CODE\" type=\"STRING\" size=\"256\"/><Column id=\"CONSUM_YN\" type=\"STRING\" size=\"256\"/><Column id=\"IMAGE_YN\" type=\"STRING\" size=\"256\"/><Column id=\"KEEPING_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"APPLY_SD\" type=\"STRING\" size=\"256\"/><Column id=\"VD_SN\" type=\"STRING\" size=\"256\"/><Column id=\"ORIGIN_TYPE\" type=\"STRING\" size=\"256\"/><Column id=\"MOBILE_GUBUN\" type=\"STRING\" size=\"256\"/><Column id=\"MAX_SO_QTY\" type=\"STRING\" size=\"256\"/><Column id=\"UPJANG_GRP\" type=\"STRING\" size=\"256\"/><Column id=\"FEATURE_ICON\" type=\"STRING\" size=\"256\"/><Column id=\"OP_RATE\" type=\"STRING\" size=\"256\"/><Column id=\"APPROVE_NUM\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_comboMenuAuthList", this);
            obj._setContents("");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_upjangList", this);
            obj._setContents("");
            this._addDataset(obj.name, obj);
            obj = null;

            obj = new Dataset("gds_limsAuthLevels", this);
            obj._setContents("<ColumnInfo><Column id=\"authCd\" type=\"STRING\" size=\"256\"/><Column id=\"sabun\" type=\"STRING\" size=\"256\"/><Column id=\"insptFld\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this._addDataset(obj.name, obj);
            obj = null;


            

        };
        
        // property, event, createMainFrame
        this.on_initApplication = function()
        {
            // properties
            this.set_id("HWFS");
            this.set_version("");
            this.set_tracemode("");
            this.set_themeid("Mobile.xtheme");
            this.set_enabletouchevent("true");
            this.set_loadingimage("HWImage::loading.gif");
            this.set_httptimeout("600");
            this.set_httpretry("0");

            if (this._is_attach_childframe)
            	return;

            // frame
            var mainframe = this.createMainFrame("mainframe", "absolute", "0", "0", "540", "923", null, null, this);
            mainframe.set_resizable("true");
            mainframe.set_showtitlebar("false");
            mainframe.set_showstatusbar("true");
            mainframe.on_createBodyFrame = this.mainframe_createBodyFrame;

            // tray
            var tray = null;

        };
        
        this.loadPreloadList = function()
        {
            this._addPreloadList("data", "", "gds_loginInfo");
        };
        
        this.mainframe_createBodyFrame = function()
        {
            var obj = new ChildFrame("childframe", "absolute", null, null, null, null, null, null, "frame::CmmnFrameBase.xfdl", this);
            this.addChild(obj.name, obj);
            this.frame = obj;

            obj.set_formurl("frame::CmmnFrameBase.xfdl");
            obj.set_showtitlebar("false");
            obj.set_showstatusbar("false");
            obj = null;

        };
        
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.application_onload, this);

        };
        
        // screeninfo
        this.loadScreenInfo = function()
        {
            var screeninfo = [
            		{"name":"ScreenPhone", "type":"phone", "width":"540", "autozoom":"true", "screenwidth":"540", "sizeorientation":"portrait", "themeid":"Mobile.xtheme", "zoommin":"100%", "zoommax":"100%", "systemos":"android,ios"},
            		{"name":"ScreenPad", "type":"tablet", "width":"708", "autozoom":"true", "screenwidth":"708", "sizeorientation":"portrait", "themeid":"Mobile.xtheme", "zoommin":"100%", "zoommax":"100%", "systemos":"android,ios"}];
            this._loadScreenInfo(screeninfo);

        }
        
        // script Compiler
        this.registerScript("hwfs.xadl", function(exports) {
        this.application_onload = function(obj,e)
        {
        	// 20150105 	svc 설정	 김광호
        	//-----------------------------------------------------------------------
            // adl별로 실행모드 설정
            //-----------------------------------------------------------------------
        	var sXadlUrl = application.xadl;
        	
        	trace("sXadlUrl<>" +sXadlUrl);
        	var sUrl;
        	    sUrl     = sXadlUrl.substring(0, sXadlUrl.indexOf('/hwfs_mobile')+1);   
            trace("nexacro.OS :: "+nexacro.OS);
        	//서버 실행
        	if(sXadlUrl.indexOf("http://") != -1)  
        	{		
        		// globalvars 변경
        		application.gv_webRoot = sUrl;
        		
        		// Service URL 변경
        		application.services["svc"].url   		      = sUrl;
        		application.services["U_svc"].url 			  = sUrl + "hwfs_svc/";
        		application.gv_chartPath                      = sUrl + "fusionchart/";
        		application.gv_namoInitUrl                    = sUrl + "namo/namowec.js";
        		 
        		 
        		 trace("sUrl :: "+sUrl);
        		 
        		// 개발서버일 경우
        		if ( sUrl.indexOf("172.16.1.121:8091") > -1 )  
        		{
        			application.gv_runMode = "D";
        		} 	
        		// 운영서버일 경우
        		else if ( sUrl.indexOf("m.hanwhafoodist.co.kr") > -1 )  
        		{ 
        			application.gv_runMode = "S";
        		} 
        		// localhost일 경우
        		else if ( sUrl.indexOf("localhost") > -1 )
        		{
        			trace("로컬호스트 모드");
        			application.gv_runMode = "L";
        		}
        	}
        	else if (nexacro.OS == "Android" || nexacro.OS == "iOS")	// 모바일앱일 경우
        	{
        		// 개발서버일 경우
        		if(application.key.indexOf("TEST") > -1 )
        		{
        			application.services["svc"].url   = "http://172.16.1.121:8091/";	// 개발서버
        			application.services["U_svc"].url = "http://172.16.1.121:8091/hwfs_svc/";
        			application.gv_runMode2 = "D";
        		}
        		// 운영서버일 경우	
        		else
        		{
        			application.services["svc"].url   = "https://m.hanwhafoodist.co.kr/";	// 운영서버
        			application.services["U_svc"].url = "https://m.hanwhafoodist.co.kr/hwfs_svc/";
        			application.gv_runMode2 = "S";
        		}	
        		
        		application.gv_runMode = "Hybrid";	 		
        			
        	}
        	// 실행모드가 UX Studio 일때
        	else {
        		trace("Runtime으로 실행됨");
        		application.gv_runMode = "Runtime";		
        		application.services["svc"].url   = "http://localhost:8080/";	// 로컬서버
        		application.services["U_svc"].url = "http://localhost:8080/hwfs_svc/";
        		
        		//application.services["svc"].url   = "http://m.hanwhafoodist.co.kr/";	 // 운영서버
        		//application.services["U_svc"].url = "http://m.hanwhafoodist.co.kr/hwfs_svc/";
        	}
        }

        this.gfn_IsNull = function (sValue)
        {
        	if (sValue == null) 
        	{
        		return true;
        	}
        	if (""+sValue == "null") //ios 로컬에서 null 체크 추가
        	{
        		return true;
        	}
        	if (sValue == undefined) 
        	{
        		return true;
        	}
        	if (("x" + sValue == "xNaN") && (sValue == undefined)) 
        	{
        		return true;
        	}
        	if (sValue.length == 0) 
        	{
        		return true;
        	}
        	sValue = ""+sValue;
        	if (sValue.trim() == "") 
        	{
        		return true;
        	}
        	return false;
        }

        this.gfn_IsEmpty = function (sValue)
        {
        	return this.gfn_IsNull(sValue);
        }

        this.gfn_setWaitCursor = function (flag,obj,msg)
        {
        	if (this.gvWaitCount <= 0 && flag == false) 
        	{
        		return;
        	}

        	if (this.gvWaitCount > 0 && flag == true) 
        	{
        		return;
        	}
        	/* coolmind 2012.08.02 - Hybrid는 WaitMessage지원 안함		
        	 if (flag == true)
        	 {
        	 if(!gfn_IsNull(msg)) obj.setWaitMessage(msg);
        	 else obj.setWaitMessage("처리중입니다...");
        	 }
        	 */
        	obj.setWaitCursor(flag);
        	if (flag == true) 
        	{ 
        		this.gvWaitCount++;
        	}
        	else 
        	{
        		this.gvWaitCount--;
        	}

        	trace("***************** gvWaitCount count : " + this.gvWaitCount);
        }

        /*********************************************************************************************
         * @type   : function
         * @access : public
         * @desc   : 현재 전체 경로를 가지고온다.
         * @param  : obj 현재 obj
         * @return :
         *********************************************************************************************/
        this.gfn_getObjPath = function (obj)
        {
        	var arrPath = new Array();
        	var tmpObj = obj;
        	var cnt = 1;

        	arrPath[0] = tmpObj.name;
        	while (true) 
        	{
        		if (tmpObj.parent == "[object ChildFrame]") 
        		{
        			arrPath[cnt-1] = "application.mainframe.childframe.form";
        			break;
        		}

        		arrPath[cnt] = tmpObj.parent.name;
        		tmpObj = tmpObj.parent;
        		cnt++;
        	}

        	var path = "";
        	for (var i = arrPath.length - 1; i >= 0; i--) 
        	{
        		path += arrPath[i] + ".";
        	}

        	return path;
        }

        /*********************************************************************************************
         * @type   : function
         * @access : public
         * @desc   : Main Division의 Title을 세팅한다.
         * @param  : 
         * @return :
         *********************************************************************************************/
        this.gfn_setTitleMain = function (parmTitle)
        {
        	application.goTopMain.staTitle.set_text(parmTitle);
        }

        /*********************************************************************************************
         * @type   : function
         * @access : public
         * @desc   : Sub Division의 Title을 세팅한다.
         * @param  : 
         * @return :
         *********************************************************************************************/
        this.gfn_setTitleSub = function (parmTitle)
        {
        	application.goTopSub.staTitle.set_text(parmTitle);
        }

        // FSP푸시 수신하는 함수
        this.gfn_pushReceivePopup = function(msgId,msgTitle,sendUserName)
        {
        //	this.alert("Push Message = "+msgId+" :: "+ msgTitle+" :: "+ sendUserName);

        	// this.alert("gfn_pushTest:"+msgId);
        	//this.fspmob_toast(this, "[알림 도착]\n\n"+msg.message , "" , "" , 10, "fnCallbackToast");
        	//push 알림 받았을 시 콜백
        	application.goMain.fn_callbackPush(0, msgTitle);
        }
        });


        this.checkLicense("");
        this.loadTypedefition();
        this.loadScreenInfo();
        this.loadTheme("Mobile.xtheme");
        this.loadPreloadList();

        this.loadIncludeScript("hwfs.xadl", true);
    };
}
)();
