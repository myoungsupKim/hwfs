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
                this.set_name("CmmnFrameSubMenu");
                this.set_titletext("Sub Menu Frame");
                this._setFormPosition(0,0,270,758);
            }
            this.style.set_border("2 solid #808080ff");

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_subMenu", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("false");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"ROLE_ID\" type=\"STRING\" size=\"256\"/><Column id=\"MENU_CD\" type=\"STRING\" size=\"256\"/><Column id=\"UP_MENU_CD\" type=\"STRING\" size=\"256\"/><Column id=\"USE_GRD\" type=\"STRING\" size=\"256\"/><Column id=\"PGM_NM\" type=\"STRING\" size=\"256\"/><Column id=\"PGM_ID\" type=\"STRING\" size=\"256\"/><Column id=\"MENU_DEP\" type=\"STRING\" size=\"256\"/><Column id=\"MENU_CD1\" type=\"STRING\" size=\"256\"/><Column id=\"MENU_CD2\" type=\"STRING\" size=\"256\"/><Column id=\"PGM_PATH\" type=\"STRING\" size=\"256\"/><Column id=\"MENU_ORD\" type=\"STRING\" size=\"256\"/><Column id=\"FORM_URL\" type=\"STRING\" size=\"256\"/><Column id=\"TREE_LVL\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"UP_MENU_CD\">총장인사말</Col><Col id=\"ROLE_ID\">INTR</Col><Col id=\"MENU_CD\">01</Col><Col id=\"USE_GRD\">gnrl_intr::IntrPresidentGreeting.xfdl</Col><Col id=\"PGM_NM\">총장인사말</Col></Row><Row><Col id=\"ROLE_ID\">INTR</Col><Col id=\"MENU_CD\">02</Col><Col id=\"UP_MENU_CD\">건국비전</Col><Col id=\"USE_GRD\">gnrl_intr::IntrKonkukVision.xfdl</Col><Col id=\"PGM_NM\">건국비전</Col></Row><Row><Col id=\"ROLE_ID\">NEWS</Col><Col id=\"MENU_CD\">01</Col><Col id=\"UP_MENU_CD\">KU공지</Col><Col id=\"USE_GRD\">gnrl_news::NewsKUNotice.xfdl</Col><Col id=\"PGM_NM\">KU공지</Col></Row><Row><Col id=\"ROLE_ID\">NEWS</Col><Col id=\"MENU_CD\">02</Col><Col id=\"UP_MENU_CD\">장학공지</Col><Col id=\"USE_GRD\">gnrl_news::NewsSchoNotice.xfdl</Col><Col id=\"PGM_NM\">장학공지</Col></Row><Row><Col id=\"ROLE_ID\">NEWS</Col><Col id=\"MENU_CD\">03</Col><Col id=\"UP_MENU_CD\">국제처공지</Col><Col id=\"USE_GRD\">gnrl_news::NewsInterNotice.xfdl</Col><Col id=\"PGM_NM\">국제처공지</Col></Row><Row><Col id=\"ROLE_ID\">NEWS</Col><Col id=\"MENU_CD\">04</Col><Col id=\"UP_MENU_CD\">학생회공지</Col><Col id=\"USE_GRD\">gnrl_news::NewsStudUnNotice.xfdl</Col><Col id=\"PGM_NM\">학생회공지</Col></Row><Row><Col id=\"ROLE_ID\">NEWS</Col><Col id=\"MENU_CD\">05</Col><Col id=\"UP_MENU_CD\">학사일정</Col><Col id=\"USE_GRD\">gnrl_news::NewsStudSchedule.xfdl</Col><Col id=\"PGM_NM\">학사일정</Col></Row><Row><Col id=\"ROLE_ID\">MEAL</Col><Col id=\"MENU_CD\">04</Col><Col id=\"UP_MENU_CD\">학생회관 누리랑</Col><Col id=\"USE_GRD\">gnrl_meal::MealMenuInfo.xfdl</Col><Col id=\"PGM_NM\">학생회관 누리랑</Col></Row><Row><Col id=\"UP_MENU_CD\">학생회관 차루방</Col><Col id=\"ROLE_ID\">MEAL</Col><Col id=\"MENU_CD\">03</Col><Col id=\"USE_GRD\">gnrl_meal::MealMenuInfo.xfdl</Col><Col id=\"PGM_NM\">학생회관 차루방</Col></Row><Row><Col id=\"UP_MENU_CD\">상허도서관 바루방</Col><Col id=\"ROLE_ID\">MEAL</Col><Col id=\"MENU_CD\">02</Col><Col id=\"USE_GRD\">gnrl_meal::MealMenuInfo.xfdl</Col><Col id=\"PGM_NM\">상허도서관 바루방</Col></Row><Row><Col id=\"UP_MENU_CD\">새천년관 교직원식당</Col><Col id=\"ROLE_ID\">MEAL</Col><Col id=\"MENU_CD\">01</Col><Col id=\"USE_GRD\">gnrl_meal::MealMenuInfo.xfdl</Col><Col id=\"PGM_NM\">새천년관 교직원식당</Col></Row><Row><Col id=\"ROLE_ID\">LIFE</Col><Col id=\"MENU_CD\">01</Col><Col id=\"UP_MENU_CD\">전화번호검색</Col><Col id=\"USE_GRD\">gnrl_life::LifePhoneSearch.xfdl</Col><Col id=\"PGM_NM\">전화번호검색</Col></Row><Row><Col id=\"ROLE_ID\">LIFE</Col><Col id=\"MENU_CD\">02</Col><Col id=\"UP_MENU_CD\">행정부서안내</Col><Col id=\"USE_GRD\">gnrl_life::LifeDeptInfo.xfdl</Col><Col id=\"PGM_NM\">행정부서안내</Col></Row><Row><Col id=\"ROLE_ID\">LIFE</Col><Col id=\"MENU_CD\">03</Col><Col id=\"UP_MENU_CD\">신입장학안내</Col><Col id=\"USE_GRD\">gnrl_life::LifeSchoInfo.xfdl</Col><Col id=\"PGM_NM\">신입장학안내</Col></Row><Row><Col id=\"ROLE_ID\">LIFE</Col><Col id=\"MENU_CD\">04</Col><Col id=\"UP_MENU_CD\">휴,복학 안내</Col><Col id=\"USE_GRD\">gnrl_life::LifeSchoolInfo.xfdl</Col><Col id=\"PGM_NM\">휴,복학 안내</Col></Row><Row><Col id=\"ROLE_ID\">ENTR</Col><Col id=\"MENU_CD\">01</Col><Col id=\"UP_MENU_CD\">입학안내</Col><Col id=\"USE_GRD\">gnrl_entr::EntrInfo.xfdl</Col><Col id=\"PGM_NM\">입학안내</Col></Row><Row><Col id=\"ROLE_ID\">PUBL</Col><Col id=\"MENU_CD\">01</Col><Col id=\"UP_MENU_CD\">투데이건국</Col><Col id=\"USE_GRD\">gnrl_publ::PublTodayKu.xfdl</Col><Col id=\"PGM_NM\">투데이건국</Col></Row><Row><Col id=\"ROLE_ID\">PUBL</Col><Col id=\"MENU_CD\">02</Col><Col id=\"UP_MENU_CD\">건국피플</Col><Col id=\"USE_GRD\">gnrl_publ::PublKuPeople.xfdl</Col><Col id=\"PGM_NM\">건국피플</Col></Row><Row><Col id=\"ROLE_ID\">PUBL</Col><Col id=\"MENU_CD\">03</Col><Col id=\"UP_MENU_CD\">캠퍼스투어</Col><Col id=\"USE_GRD\">gnrl_publ::PublCampusTour.xfdl</Col><Col id=\"PGM_NM\">캠퍼스투어</Col></Row><Row><Col id=\"ROLE_ID\">FUND</Col><Col id=\"MENU_CD\">01</Col><Col id=\"UP_MENU_CD\">발전기금안내</Col><Col id=\"USE_GRD\">gnrl_fund::FundInfo.xfdl</Col><Col id=\"PGM_NM\">발전기금안내</Col></Row><Row><Col id=\"ROLE_ID\">FUND</Col><Col id=\"MENU_CD\">02</Col><Col id=\"UP_MENU_CD\">기부참여방법</Col><Col id=\"USE_GRD\">gnrl_fund::FundDonation.xfdl</Col><Col id=\"PGM_NM\">기부참여방법</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Static("staFormSize", "absolute", "0", "0", "270", "758", null, null, this);
            obj.set_taborder("1");
            obj.set_cssclass("sta_POP_Bg");
            this.addChild(obj.name, obj);

            obj = new Grid("grdSubMenu", "absolute", "0", "5", "270", null, null, "251", this);
            obj.set_taborder("0");
            obj.set_autosizingtype("none");
            obj.set_cellsizingtype("none");
            obj.set_autofittype("col");
            obj.set_cssclass("grd_WF_commu");
            obj.set_treeusecheckbox("false");
            obj.set_treeuseline("true");
            obj.style.set_line("2 solid #808080ff");
            obj.style.set_border("0 solid #9e9e9eff,0 solid #cbcbcbff,0 none #808080ff,2 solid #cbcbcbff");
            obj.set_binddataset("ds_subMenu");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"58\"/><Column size=\"435\"/></Columns><Rows><Row size=\"75\"/></Rows><Band id=\"body\"><Cell displaytype=\"image\" edittype=\"none\" style=\"align:center middle;selectline:2 solid #cbcbcbff,1 none #808080,2 solid #cbcbcbff,1 none #808080;\" expandshow=\"show\" expandsize=\"40\" expandimage=\"URL('theme://images/ico_sub_menu1.png')\"/><Cell col=\"1\" displaytype=\"text\" edittype=\"none\" style=\"selectline:2 solid #cbcbcbff,1 none #808080,2 solid #cbcbcbff,1 none #808080;\" text=\"bind:PGM_NM\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 270, 758, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frameSubMenu");
            		p.set_titletext("Sub Menu Frame");
            		p.style.set_border("2 solid #808080ff");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("CmmnFrameSubMenu.xfdl", "lib::sz_fsp_mobile_xp.xjs");
        this.registerScript("CmmnFrameSubMenu.xfdl", function(exports) {
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::sz_fsp_mobile_xp.xjs", null, exports); }	//include "lib::sz_fsp_mobile_xp.xjs"

        this.CmmnFrameSubMenu_onload = function(obj,e)
        {
        	application.gfn_setTitleMain(application.gv_menuName);
        	application.goTopSub.fn_showBookmark(false);
        	
        	this.ds_subMenu.clearData();
        	this.ds_subMenu.copyData(application.gds_subMenu);
        	this.ds_subMenu.filter("UP_MENU_CD=='" + application.gv_menuId + "'");
        	
        	//안드로이드4.3TODO
        //	this.setTimer(1,100);
        	application.goMain.gfn_POP_resize(this);
        }

        this.grdSubMenu_oncellclick = function(obj,e)
        {
        	application.gv_menuId = this.ds_subMenu.getColumn(e.row, "MENU_CD");
        	application.gv_menuName = this.ds_subMenu.getColumn(e.row, "PGM_NM");
        	application.gv_formUrl = this.ds_subMenu.getColumn(e.row, "FORM_URL");
        	application.gv_backFalg = this.ds_subMenu.getColumn(e.row, "UP_MENU_CD");
        	
        	//휴, 복학 안내의 경우 웹브라우져 호출
        	if(application.gv_formUrl == "gnrl_life::LifeSchoolInfo.xfdl")
        	{
        		this.fspmob_browser(this, "http://www.konkuk.ac.kr/jsp/Haksa/haksa_03_05_tab02.jsp" , "fsp_callbackBrowser");
        	}
        	else if(application.gv_formUrl == "gnrl_entr::EntrInfo.xfdl")	//입학안내
        	{
        		this.fspmob_browser(this, "http://enter.konkuk.ac.kr" , "fsp_callbackBrowser");
        	}
        	else
        	{
        		application.goMain.fn_action(application.gv_menuId);
        	}
        }

        /** fsp callback 함수 (fsp_callbackFileUpload)
         * @param
        	errorCode : errorCode
        	message : message
         * @return : 없음
         * @note : fsb 서비스 호출 후 콜백 함수 (파일 업로드 처리 결과)
         * errorCode < 0 경우 해당 message 팝업 처리함
         */
        this.fsp_callbackBrowser = function (errorCode,message)
        {
        	if(errorCode != "0")
        	{
        		// application.goMain.gfn_Msg("ALERT_0", "오류", "["+errorCode+"] "+message, "OK", true, this);
        		application.goMain.gfn_Msg("ALERT_0", "메세지", message, "OK", true, this);		
        		return false;
        	}
        	else
        	{
        		trace("성공");
        	}
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.CmmnFrameSubMenu_onload, this);
            this.grdSubMenu.addEventHandler("oncellclick", this.grdSubMenu_oncellclick, this);

        };

        this.loadIncludeScript("CmmnFrameSubMenu.xfdl", true);

       
    };
}
)();
