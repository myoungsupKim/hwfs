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
                this.set_name("frmSampleComboList");
                this.set_titletext("New Form");
                this._setFormPosition(0,0,540,758);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new Edit("Edit00", "absolute", "2.22%", "60", null, "60", "39.26%", null, this);
            obj.set_taborder("0");
            obj.set_value("010-8363-5600");
            this.addChild(obj.name, obj);

            obj = new Button("Button00", "absolute", "68.89%", "59", null, "50", "2.22%", null, this);
            obj.set_taborder("1");
            obj.set_text("바로걸기");
            this.addChild(obj.name, obj);

            obj = new Button("Button01", "absolute", "68.89%", "120", null, "50", "2.22%", null, this);
            obj.set_taborder("2");
            obj.set_text("전화앱실행");
            this.addChild(obj.name, obj);

            obj = new Static("Static00", "absolute", "2.41%", "7", null, "44", "72.41%", null, this);
            obj.set_taborder("3");
            obj.set_text("전화걸기");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 540, 758, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("frmCalendarTest");
            		p.set_titletext("New Form");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("frmSampleCall.xfdl", "lib::sz_fsp_xp.xjs");
        this.addIncludeScript("frmSampleCall.xfdl", "lib::sz_fsp_mobile_xp.xjs");
        this.registerScript("frmSampleCall.xfdl", function(exports) {
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::sz_fsp_xp.xjs", null, exports); }	//include "lib::sz_fsp_xp.xjs"
        if (this.executeIncludeScript) { this.executeIncludeScript("lib::sz_fsp_mobile_xp.xjs", null, exports); }	//include "lib::sz_fsp_mobile_xp.xjs"

        // 바로걸기
        this.Button00_onclick = function(obj,e)
        {
        	this.fspmob_call(this, this.Edit00.text, "call_callback");
        }

        // 전화앱 실행
        this.Button01_onclick = function(obj,e)
        {
        	this.fspmob_dial(this, this.Edit00.text, "call_callback");
        }

        // 전화걸기 콜백
        this.call_callback = function(errorCode,message)
        {
        	if(errorCode != "0")
        	{
        		application.goMain.gfn_Msg("ALERT_0", "메세지", message, "OK", true, this);
        		return false;
        	}
        	else
        	{
        		trace(message);
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
        	if (id == "ALERT_0") // 조회 시 오류
        	{
        		// 아무 일도 안함.
        	}
        }
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload", this.frmSampleComboList_onload, this);
            this.Button00.addEventHandler("onclick", this.Button00_onclick, this);
            this.Button01.addEventHandler("onclick", this.Button01_onclick, this);

        };

        this.loadIncludeScript("frmSampleCall.xfdl", true);

       
    };
}
)();
