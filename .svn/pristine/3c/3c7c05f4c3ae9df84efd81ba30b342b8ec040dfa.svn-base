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
                this.set_name("SampleFileUpDown");
                this.set_titletext("New Form");
                this._setFormPosition(0,0,943,549);
            }

            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("dsFile", this);
            obj.set_firefirstcount("0");
            obj.getSetter("firenextcount").set("0");
            obj.set_useclientlayout("true");
            obj.set_updatecontrol("true");
            obj.set_enableevent("true");
            obj.set_loadkeymode("keep");
            obj.set_loadfiltermode("keep");
            obj.set_reversesubsum("false");
            obj._setContents("<ColumnInfo><Column id=\"chk\" type=\"STRING\" size=\"256\"/><Column id=\"seqRel\" type=\"STRING\" size=\"256\"/><Column id=\"snAtch\" type=\"STRING\" size=\"256\"/><Column id=\"nmFile\" type=\"STRING\" size=\"256\"/><Column id=\"nmSavefile\" type=\"STRING\" size=\"256\"/><Column id=\"sizeFile\" type=\"BIGDECIMAL\" size=\"256\"/><Column id=\"pathRel\" type=\"STRING\" size=\"256\"/><Column id=\"cdClDocatchfl\" type=\"STRING\" size=\"256\"/><Column id=\"dscCntsFl\" type=\"STRING\" size=\"256\"/><Column id=\"ynUse\" type=\"STRING\" size=\"1\"/><Column id=\"ynFax\" type=\"STRING\" size=\"1\"/><Column id=\"filePath\" type=\"STRING\" size=\"256\"/><Column id=\"fileUploadName\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            
            // UI Components Initialize
            obj = new Button("btnDownload", "absolute", "216", "240", "70", "20", null, null, this);
            obj.set_taborder("2");
            obj.set_text("파일다운로드");
            obj.style.set_padding("0 0 0 0");
            obj.style.set_align("center middle");
            obj.style.set_font("Dotum,8");
            this.addChild(obj.name, obj);

            obj = new Button("btnUpload", "absolute", "136", "240", "70", "20", null, null, this);
            obj.set_taborder("4");
            obj.set_text("파일업로드");
            obj.style.set_padding("0 0 0 0");
            obj.style.set_align("center middle");
            obj.style.set_font("Dotum,8");
            this.addChild(obj.name, obj);

            obj = new Grid("grdList", "absolute", "10", "10", null, "220", "343", null, this);
            obj.set_taborder("7");
            obj.set_binddataset("dsFile");
            obj.set_cellsizingtype("both");
            obj.set_cellsizebandtype("allband");
            obj.set_cellmovingtype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"40\"/><Column size=\"40\"/><Column size=\"134\"/><Column size=\"79\"/><Column size=\"187\"/><Column size=\"92\"/></Columns><Rows><Row size=\"24\" band=\"head\"/><Row size=\"24\"/></Rows><Band id=\"head\"><Cell text=\"No\"/><Cell col=\"1\" displaytype=\"checkbox\" edittype=\"checkbox\"/><Cell col=\"2\" text=\"파일명\"/><Cell col=\"3\" text=\"파일크기\"/><Cell col=\"4\" text=\"파일패스\"/><Cell col=\"5\" edittype=\"none\" text=\"업로드파일명\"/></Band><Band id=\"body\"><Cell expr=\"rowidx+1\" autosizerow=\"default\"/><Cell col=\"1\" displaytype=\"checkbox\" edittype=\"checkbox\" text=\"bind:chk\"/><Cell col=\"2\" edittype=\"none\" style=\"align:left;\" text=\"bind:nmFile\"/><Cell col=\"3\" edittype=\"none\" style=\"align:right;\" text=\"bind:sizeFile\"/><Cell col=\"4\" displaytype=\"normal\" edittype=\"none\" style=\"align:left;\" text=\"bind:filePath\" combodataset=\"dsCombo\" combocodecol=\"code\" combodatacol=\"value\"/><Cell col=\"5\" displaytype=\"normal\" edittype=\"none\" style=\"align:left;\" text=\"bind:fileUploadName\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new FileUpload("FileUpload00", "absolute", "608", "8", "83", "91", null, null, this);
            obj.set_taborder("8");
            obj.getSetter("retry").set("0");
            obj.set_scrollbars("none");
            obj.style.set_buttonsize("60");
            obj.style.set_buttonbordertype("normal 0 0");
            obj.style.set_buttoncolor("#504038ff");
            obj.style.set_buttontext("파일첨부");
            obj.style.set_align("left");
            obj.set_itemcount("1");
            obj.getSetter("onload").set("FileUpload00_onload");
            obj.set_index("0");
            this.addChild(obj.name, obj);

            obj = new Button("Button00", "absolute", "10", "283", "163", "37", null, null, this);
            obj.set_taborder("9");
            obj.set_text("Button00");
            this.addChild(obj.name, obj);

            obj = new FileDownload("fdnDownload", "absolute", "13", "256", "118", "23", null, null, this);
            obj.set_taborder("10");
            obj.set_tabstop("false");
            obj.getSetter("retry").set("0");
            obj.getSetter("onload").set("fileDownload_onload");
            obj.set_text("FileDownload");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Button("btnDownloadTemp", "absolute", "194", "283", "230", "34", null, null, this);
            obj.set_taborder("11");
            obj.set_text("임시파일 다운로드");
            this.addChild(obj.name, obj);


            
            // Layout Functions
            //-- Default Layout
            obj = new Layout("default", "", 943, 549, this,
            	//-- Layout function
            	function(p) {
            		p.set_classname("SampleFileUpDown");
            		p.set_titletext("New Form");

            	}
            );
            this.addLayout(obj.name, obj);


            
            // BindItem Information

            
            // Remove Reference
            obj = null;
        };
        

        
        // User Script
        this.addIncludeScript("SampleFileUpDown.xfdl", "lib::lib_Com.xjs");
        this.registerScript("SampleFileUpDown.xfdl", function(exports) {
        /**
         * 파일업로드/다운로드 테스트 Sample 화면
         * 업무로직과 연결된 처리는 SampleRecord 참조
         * @ClassName SampleFileUpDown.xfdl
         * @Description SampleFileUpDown Form 
         * @Modification-Information
         *    수정일       수정자              수정내용
         *  ----------   ----------   -------------------------------
         *  2015.03.10.   kksoo       최초생성
         * 
         * @author FC종합전산구축 : AA kksoo
         * @since 2013. 5. 11.
         * @version 1.0
         * @see 
         * 
         *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
         */

        if (this.executeIncludeScript) { this.executeIncludeScript("lib::lib_Com.xjs", null, exports); }	//include "lib::lib_Com.xjs"

        var common_fileup_url = "http://localhost:8080/sc/cmn/uploadFile.do";
        var common_filedown_url = "http://localhost:8080/sc/cmn/downloadFile.do";
        var common_filedowntemp_url = "http://localhost:8080/sc/cmn/downloadTempFile.do";

        /**
         * 파일첨부 버튼 클릭 이벤트 처리
         */
        this.FileUpload00_onitemchanged = function(obj,e)
        {
        	//application.SCFile.addUploadFile (obj.value, this.FileUpload00, this.dsFile);
        }

        /**
         * 파일업로드 버튼 클릭 이벤트 처리
         */
        this.btnUpload_onclick = function(obj,e)
        {
        	//var bSucc = this.FileUpload00.upload(application.common_fileup_url);	
        	var bSucc = this.FileUpload00.upload(common_fileup_url);	
        }

        /**
         * 파일업로드 컴포넌트에서 업로드 후 발생하는 이벤트 처리
         */
        this.FileUpload00_onload = function(obj,e)
        {
        	//alert (e.errorcode + "," + e.errormsg); // errorcode=0, errormsg= "OK" 이면 성공,  datasets이 null이 아니어야 함
        	//업로드되어 저장된 파일명이 데이터셋으로 전달 됨
        	if (e.datasets == null) {
        		application.SCMessage.alertError("업로드 실패=" + e.errormsg);
        		return;
        	}
        	application.SCMessage.alertInfo ("업로드 성공"); //application.common_success_upload);
        	//trace(e.datasets[0].saveXML());
        	alert(e.datasets[0].saveXML());

        	//업로드 성공 후 받은 데이터셋에서 해당 파일의 업로드파일명과 파일 타입을 데이터셋에 저장.
        	application.SCFile.setUploadFileInfo (e.datasets[0], this.dsFile);

        }

        /**
         * 파일다운로드 버튼 클릭 이벤트 처리
         * 파일 다운로드 컴포넌트를 이용하여 구현했으면 다운로드 파일을 오픈할 수 없는 문제점이 있다. 
         * HTNL5에서 이용할 수 있다.
         */
        this.btnDownload_onclick = function(obj,e)
        {
        	var arrSelRows = application.SCGrid.getSelectedRows (this.grdList, 1);
        	alert(arrSelRows);
        	if (arrSelRows.length == 0) {
        		application.SCMessage.alertMsg("다운로드 할 파일을 선택하세요!");
        		return;
        	}
        	
        	for (var i=0; i<arrSelRows.length; i++) {
        		var strFileName = this.dsFile.getColumn(arrSelRows[i],"nmFile");
        		var strFileUploadName = this.dsFile.getColumn(arrSelRows[i],"fileUploadName");
        		var strRelPath ="";	//파일 저장소의 Root를 제외한 상대 Path
        		//alert(strFileName + "," + strFileUploadName + "," + strRelPath);
        		
        		//(주의) 이 샘플에서는 다운로드 위치에서 파일이 없으므로 오류 발생
        		var strUrl = application.common_filedown_url + "?FileName=" + strFileUploadName + "&RelPath=" + strRelPath;
        		
        		//this.fdnDownload.show();	//V13 추가
        		
        		var bSucc = this.fdnDownload.download(strUrl);
        	}
        }

        this.Button00_onclick = function(obj,e)
        {
        	//this.FileUpload00.deleteItem(0); //테스트
        	alert("첨부파일이 있는지 여부=" + application.SCFile.hasUploadFile (this.FileUpload00));
        }

        this.btnDownloadTemp_onclick = function(obj,e)
        {
        	//var strFileName = "test.txt";
        	var strFileName = "한글 파일.txt";
        	var strRelPath = "";	//파일 저장소의 Root를 제외한 상대 Path
        	
        	//임시파일 저장소에서 다운로드
        	//var strUrl = application.common_filedowntemp_url + "?FileName=" + strFileName + "&RelPath=" + strRelPath;
        	var strUrl = common_filedowntemp_url + "?FileName=" + strFileName + "&RelPath=" + strRelPath;
        	var bSucc = this.fdnDownload.download(strUrl);
        }
        
        });


        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.btnDownload.addEventHandler("onclick", this.btnDownload_onclick, this);
            this.btnUpload.addEventHandler("onclick", this.btnUpload_onclick, this);
            this.grdList.addEventHandler("onheadclick", this.grdList_onheadclick, this);
            this.grdList.addEventHandler("onheaddblclick", this.divRoot_grdList_onheaddblclick, this);
            this.FileUpload00.addEventHandler("onitemchanged", this.FileUpload00_onitemchanged, this);
            this.Button00.addEventHandler("onclick", this.Button00_onclick, this);
            this.btnDownloadTemp.addEventHandler("onclick", this.btnDownloadTemp_onclick, this);

        };

        this.loadIncludeScript("SampleFileUpDown.xfdl", true);

       
    };
}
)();
