<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 위생관리/문제관리                                                                                                                                                                     
■ 프로그램ID   : FSC91010E_T003.jsp                                                                                                                                                                    
■ 프로그램명   : 문제관리                                                                                                                                                 
■ 작성일자     : 2019-07-03                                                                                                                                                                            
■ 작성자       : 김명섭                                                                                                                                                                                
-----------------------------------------------------------------------------*/                                                                                                                         
%>                                                                                                                                                                                                      

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%@ page import="java.io.*
    , java.util.*
    , org.springframework.web.context.*
    , org.springframework.web.context.support.WebApplicationContextUtils
    , com.hwfs.cmn.service.PropertiesService
    , hone.core.util.record.*
    , com.hwfs.ls.cmn.util.LimsUtil"%>
<%
	ServletContext sc = pageContext.getServletContext();
	WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(sc);

    //propertiesService Bean을 얻는다.
    PropertiesService propertiesService = (PropertiesService)wac.getBean("propertiesService");

    Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//오토커밋 강제 false
		conn.setAutoCommit(false);
		
		//입력 데이타                                                                                                                                                                                         
		DataSet ds_Master  	= in_dl.get("ds_Master");
		DataSet ds_Detail1  = in_dl.get("ds_Detail1");
		DataSet ds_in  		= in_dl.get("ds_in");
		
		String g_EmpNo 		= in_vl.getString("g_EmpNo");
		
		StringBuffer sbSql 	= new StringBuffer();	//sql문 버퍼생성
		
		int RowCnt;
		int i;
		int RowStatus;
		String strFormCD;
	
		// 1.Master
		RowCnt = ds_Master.getRowCount();
		
		if (RowCnt > 0)
		{
			RowStatus 	= ds_Master.getRowType(0);

			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{ 
				// 1.1 inert
				// 1.1.1 Seq생
				sbSql.delete(0, sbSql.length());
				sbSql.append("SELECT TO_CHAR(SYSDATE,'YYYY') || NVL(DECODE(LENGTH(MAX(SUBSTR(FORM_CD,5,2)+1)),1,'0') || MAX(SUBSTR(FORM_CD,5,2)+1),'01') AS FORM_CD \n");
				sbSql.append("  FROM FSC_TEST_FORM_MST \n");
				sbSql.append(" WHERE TEST_TYPE = '"	+	nullToBlank(ds_Master.getString(0,"TEST_TYPE"))		+"' \n");
				sbSql.append("   AND SUBSTR(FORM_CD,0,4) = TO_CHAR(SYSDATE,'YYYY') \n");
				
				//System.out.println(sbSql.toString());
				pstmt = conn.prepareStatement(sbSql.toString());		
				rs = pstmt.executeQuery(); 
				ds_in = this.makeDataSet(rs,"ds_in");
				
				rs.close();
				pstmt.close();
				
				// 1.1.2 insert
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FSC_TEST_FORM_MST( \n");
				sbSql.append("	  TEST_TYPE \n");
				sbSql.append("	, FORM_CD \n");
				sbSql.append("	, FORM_NAME \n");
				sbSql.append("	, START_DATE \n");
				sbSql.append("	, END_DATE \n");
				sbSql.append("	, USE_YN \n");
				sbSql.append("	, ATTR01 \n");
				sbSql.append("	, ATTR02 \n");
				sbSql.append("	, CUSER \n");
				sbSql.append("	, CDATE \n");
				sbSql.append(" ) VALUES ( \n");
				sbSql.append("	  '"	+	ds_Master.getString(0,"TEST_TYPE")						+"' \n");
				sbSql.append("	, '"	+	ds_in.getString(0,"FORM_CD")							+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"FORM_NAME"))			+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"START_DATE"))		+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"END_DATE"))			+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"USE_YN"))			+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"ATTR01"))			+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"ATTR02"))			+"' \n");
				sbSql.append("	, '" 	+ 	g_EmpNo 														+ "' \n");
				sbSql.append("	, SYSDATE \n");
				sbSql.append(" ) \n");
				
				stmt 		=  conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED )
			{
				// 1.2 update
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSC_TEST_FORM_MST \n");
				sbSql.append("   SET FORM_NAME = '"		+	nullToBlank(ds_Master.getString(0,"FORM_NAME"))			+"' \n");
				sbSql.append("   	 , START_DATE = '"	+	nullToBlank(ds_Master.getString(0,"START_DATE"))		+"' \n");
				sbSql.append("	 , END_DATE = '"		+	nullToBlank(ds_Master.getString(0,"END_DATE"))			+"' \n");
				sbSql.append("	 , USE_YN = '"			+	nullToBlank(ds_Master.getString(0,"USE_YN"))			+"' \n");
				sbSql.append("	 , ATTR01 = '"			+	nullToBlank(ds_Master.getString(0,"ATTR01"))			+"' \n");
				sbSql.append("	 , ATTR02 = '"			+	nullToBlank(ds_Master.getString(0,"ATTR02"))			+"' \n");
				sbSql.append("	 , UUSER = '" 			+ 	g_EmpNo 												+ "' \n");
				sbSql.append("	 , UDATE = SYSDATE \n");
				sbSql.append("WHERE TEST_TYPE = '"		+	ds_Master.getString(0,"TEST_TYPE")						+"' \n");
				sbSql.append("  AND FORM_CD = '"		+	ds_Master.getString(0,"FORM_CD")						+"' \n");
				
				stmt 		=  conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			
		}
		strFormCD	= nullToBlank(ds_in.getString(0,"FORM_CD"));

        String realpath = propertiesService.getString("global.imagerepository.path");
        realpath = realpath + propertiesService.getString("fs.file.path") + File.separator;
        String strImgFile = "";
        byte[] blob;
        String strAppendFilenm = "";
        String fileExt = "";
        Integer nSeq;
		
		// 2.Detail
		RowCnt = ds_Detail1.getRowCount();
		
		//삭제 후 재생성
		if(RowCnt > 0)
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FROM FSC_TEST_FORM_DTL \n");
			sbSql.append("WHERE TEST_TYPE = '" + ds_Detail1.getString(0,"TEST_TYPE") + "' \n");
			sbSql.append("  AND FORM_CD = '" + strFormCD + "' \n");
			
			stmt 		=  conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();			
		}
		
		nSeq = 0;
		
		for ( i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus 	= ds_Detail1.getRowType(i);

			nSeq = nSeq + 1;
			
			// 이미지 blob를 파일로 저장 한다.
            if (RowStatus != DataSet.ROW_TYPE_DELETED) {
            	strImgFile = LimsUtil.checkNull(ds_Detail1.getString(i,"IMG_FILE"));
                if (!"".equals(strImgFile)) {
                    blob = (byte[]) ds_Detail1.getBlob(i,"IMG_FILE");
                    strAppendFilenm = LimsUtil.checkNull(ds_Detail1.getString(i,"APPEND_FILENM"));
                    fileExt = LimsUtil.getFileExt(strAppendFilenm);
                    // 이미지파일 유효 확장자 체크
                    if(!"".equals(strAppendFilenm) && !"undefined".equals(strAppendFilenm)) {
                        if(!"bmp".equals(fileExt.toLowerCase()) && !"jpg".equals(fileExt.toLowerCase()) && !"jpeg".equals(fileExt.toLowerCase()) && !"gif".equals(fileExt.toLowerCase()) && !"png".equals(fileExt.toLowerCase())) {
                        	throw new Exception("이미지 확장자가 올바르지 않습니다.");
                        }                    	
                    }
                    else {
                    	throw new Exception("이미지가 올바르지 않습니다.");
                    }

                    LimsUtil.saveBlobToFile(realpath + ds_Detail1.getString(i,"TEST_TYPE") + strFormCD + nSeq.toString() + "." + fileExt, blob);        				

                    if (!"".equals(fileExt)) {
                    	ds_Detail1.set(i, "SERVER_FILENM", ds_Detail1.getString(i,"TEST_TYPE") + strFormCD + nSeq.toString() + "." + fileExt);	// 서버에 저장된 파일명
                    }
                }
            }
			
			sbSql.delete(0, sbSql.length());
			sbSql.append("INSERT INTO FSC_TEST_FORM_DTL( \n");
			sbSql.append("	  TEST_TYPE \n");
			sbSql.append("	, FORM_CD \n");
			sbSql.append("	, SEQ \n");
			sbSql.append("	, TEST \n");
			sbSql.append("	, EXAMPLE1 \n");
			sbSql.append("	, EXAMPLE2 \n");
			sbSql.append("	, EXAMPLE3 \n");
			sbSql.append("	, EXAMPLE4 \n");
			sbSql.append("	, APPEND_FILENM \n");
			sbSql.append("	, SERVER_FILENM \n");
			sbSql.append("	, DISTRIBUTION \n");
			sbSql.append("	, ANSWER \n");
			sbSql.append("	, CUSER \n");
			sbSql.append("	, CDATE \n");
			sbSql.append(" ) VALUES ( \n");
			sbSql.append("	  '"	+	ds_Detail1.getString(i,"TEST_TYPE")							+"' \n");
			sbSql.append("	, '" 	+ 	strFormCD 													+ "' \n");
			sbSql.append("	, "     +   nSeq                         								+ " \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Detail1.getString(i,"TEST"))					+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Detail1.getString(i,"EXAMPLE1"))				+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Detail1.getString(i,"EXAMPLE2"))				+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Detail1.getString(i,"EXAMPLE3"))				+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Detail1.getString(i,"EXAMPLE4"))				+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Detail1.getString(i,"APPEND_FILENM"))		+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Detail1.getString(i,"SERVER_FILENM"))		+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Detail1.getString(i,"DISTRIBUTION"))			+"' \n");
			sbSql.append("	, '"	+	nullToBlank(ds_Detail1.getString(i,"ANSWER"))				+"' \n");
			sbSql.append("	, '" 	+ 	g_EmpNo 													+ "' \n");
			sbSql.append("	, SYSDATE \n");
			sbSql.append(" ) \n");


			stmt 		=  conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
		}
		
		conn.commit();
		out_dl.add(ds_in);
	   	this.setResultMessage(0, "OK",out_vl);
		
	} catch(Exception ex) {
		conn.rollback();
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		this.setResultMessage(-1, ex.toString(),out_vl);
		} finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(Exception e) {}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(Exception e) {}
			}
			if(stmt != null) {
				try {
					stmt.close();
				}catch(Exception e) {}
			}
			if(conn != null) {
				try {
					conn.close();
				}catch(Exception e) {}
			}
			
			//jsp log 서비스 닫기 
			try {
				logger.endIndividualLog();
			} catch( Exception logE) {
				logE.printStackTrace();
			}
		}
		
	  proc_output(response,out,out_vl,out_dl);
	
%>	