<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../main/common.jsp" %>
<%
	Statement stmt           =  null;

	try {	
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		//jsp log 서비스 시작 
		//logger.startIndividualLog(in_vl.getString("titLogId"));
		
		String IN_SYS_ID  = in_vl.getString("IN_SYS_ID");


		if(conn!=null)
		{
			StringBuffer sbSql = new StringBuffer();
							
			sbSql.delete(0, sbSql.length());
			sbSql.append("SELECT   MENU_ID,---------------------						\n");
			sbSql.append("         SYS_ID,												\n");
			sbSql.append("         MENU_NAME,											\n");
			sbSql.append("         PARENT_MENU_ID,										\n");
			sbSql.append("         PRG_ID,												\n");
			sbSql.append("         ICON_ID,												\n");
			sbSql.append("         '' ICON,												\n");			
			sbSql.append("         PRG_PATH,											\n");
			sbSql.append("         CALL_PARAM,											\n");
			sbSql.append("         menu_type,											\n");
			sbSql.append("         LEVELS,												\n");
			sbSql.append("         PRG_TYPE,											\n");
			sbSql.append("         SORT_SEQ,											\n");
			sbSql.append("         REMARK,												\n");
			sbSql.append("         CASE WHEN USE_YN='Y' THEN '1' ELSE '0' END USE_YN,	\n");
			sbSql.append("         ATTR01,												\n");
			sbSql.append("         ATTR02,												\n");
			sbSql.append("         ATTR03,												\n");
			sbSql.append("         ATTR04,												\n");
			sbSql.append("         ATTR05,												\n");
			sbSql.append("         ATTR06,												\n");
			sbSql.append("         ATTR07,												\n");
			sbSql.append("         ATTR08,												\n");
			sbSql.append("         ATTR09,												\n");
			sbSql.append("         ATTR10,												\n");
			sbSql.append("         CUSER,												\n");
			sbSql.append("         UUSER												\n");
			sbSql.append("FROM     SCC_MENU												\n");
			sbSql.append("WHERE    SYS_ID='" + IN_SYS_ID + "'							\n");
//			sbSql.append("CONNECT BY PRIOR MENU_ID =SORT_SEQ							\n");
			sbSql.append("ORDER BY MENU_ID,SORT_SEQ										\n");
			
			//pstmt = conn.prepareStatement(sbSql.toString());
			//rs = pstmt.executeQuery(); 
			stmt = conn.createStatement();		
			rs = stmt.executeQuery(sbSql.toString());			

//			out_dl.add("DS_body", this.makeDataSet(rs,"DS_body"));
			
			DataSet SCC00010E_S003 = this.makeDataSet(rs,"SCC00010E_S003");
			out_dl.add(SCC00010E_S003);
			//rs.close();
			//pstmt.close();
			
			this.setResultMessage(0, "OK",out_vl);
//			String fileUrl = "c:/tomcat-4.1/webapps/hwfs/hwfs_svc/log/test.log";
//			tit.util.FileLog.println(fileUrl, "sql=====>"+sbSql.toString());	
		}
	
	} catch(Exception ex) {
		ex.printStackTrace();
		//jsp 로그남기기
		//logger.debug(ex.getMessage(), ex);
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
		//try {
		//	logger.endIndividualLog();
		//} catch( Exception logE) {
		//	logE.printStackTrace();
		//}		
	}
    proc_output(response,out,out_vl,out_dl);
%>