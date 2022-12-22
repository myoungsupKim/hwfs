<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%@ page language="java" import="com.sz.core.ServiceManagerFactory" %>
<%@ page language="java" import="com.sz.service.ui.HttpFileManager" %>
<%@ page language="java" import="org.apache.commons.io.FileUtils" %>
<%@ page language="java" import="java.io.File" %>
<%
	Statement stmt = null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//오토커밋 강제 false
		conn.setAutoCommit(false);
		
		//입력 데이타               
		DataSet ds_input    = in_dl.get("ds_input");		    // 입력마스터값
		DataSet ds_imgeSvrList = in_dl.get("ds_imgeSvrList");
		String g_EmpNo      = in_vl.getString("g_EmpNo");

		String SRLNUM            = "";		
		String TABLE_TYPE        = ds_input.getString(0, "TABLE_TYPE");
		String FORM_CD           = ds_input.getString(0, "FORM_CD");
		String UPJANG            = ds_input.getString(0, "UPJANG");
		String CHK_DD            = ds_input.getString(0, "CHK_DD");
		String CLASS_CD          = ds_input.getString(0, "CLASS_CD");
		String ORGNL_IMGE        = "";
		String SVR_IMGE          = "";
		String FILE_SIZE         = "";
		String PRE_VIEW          = "";
		
		HttpFileManager file = (HttpFileManager) ServiceManagerFactory.getServiceObject("HttpFileManagerService");		
		String DIR_FROM      = file.getRealDirPath("MOBILE_ROOT");
		String DIR_TO        = file.getRealDirPath("FSC_RESULT_PHOTO");

		StringBuffer sbSql 	= new StringBuffer();		//sql문 버퍼생성
		int RowCnt = ds_imgeSvrList.getRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			ORGNL_IMGE        = nullToBlank(ds_imgeSvrList.getString(i, "FILE_NM"));          
			SVR_IMGE          = nullToBlank(ds_imgeSvrList.getString(i, "FILE_NM"));
			FILE_SIZE         = nullToBlank(ds_imgeSvrList.getString(i, "FILE_SIZE"));
			PRE_VIEW          = nullToBlank(ds_imgeSvrList.getString(i, "PRE_VIEW"));
			
			// 파일 이동처리
			FileUtils.copyFile(new File(DIR_FROM + PRE_VIEW), new File(DIR_TO + "/" + ORGNL_IMGE));
			
			sbSql.delete(0, sbSql.length());
			sbSql.append("INSERT INTO FSC_PATL_CHK_IMGE   ( \n");
			sbSql.append("       SRLNUM                     \n");			
			sbSql.append("     , TABLE_TYPE                 \n");
			sbSql.append("     , FORM_CD                    \n");
			sbSql.append("     , UPJANG                     \n");
			sbSql.append("     , CHK_DD                     \n");
			sbSql.append("     , CLASS_CD                   \n");
			sbSql.append("     , ORGNL_IMGE                 \n");
			sbSql.append("     , SVR_IMGE                   \n");
			sbSql.append("     , FILE_SIZE                  \n");
			sbSql.append("     , CUSER                      \n");
			sbSql.append("     , CDATE                      \n");
			sbSql.append("     , UUSER                      \n");
			sbSql.append("     , UDATE                      \n");
			sbSql.append(") VALUES (                        \n");
			sbSql.append("       (SELECT NVL(MAX(SRLNUM), 0) + 1 FROM FSC_PATL_CHK_IMGE) \n");
			sbSql.append("     , '" + TABLE_TYPE       + "' \n");
			sbSql.append("     , '" + FORM_CD          + "' \n");
			sbSql.append("     , '" + UPJANG           + "' \n");
			sbSql.append("     , '" + CHK_DD           + "' \n");
			sbSql.append("     , '" + CLASS_CD         + "' \n");
			sbSql.append("     , '" + ORGNL_IMGE       + "' \n");
			sbSql.append("     , '" + SVR_IMGE         + "' \n");
			sbSql.append("     , '" + FILE_SIZE        + "' \n");
			sbSql.append("     , '" + g_EmpNo          + "' \n");
			sbSql.append("     , SYSDATE                    \n");
			sbSql.append("     , '" + g_EmpNo          + "' \n");
			sbSql.append("     , SYSDATE                    \n");
			sbSql.append(")                                 \n");			
			
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
		}
		
		conn.commit();
	   	this.setResultMessage(0, "OK", out_vl);
		
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