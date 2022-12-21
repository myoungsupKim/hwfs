
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;	
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
		
		String UPJANG 	= in_vl.getString("UPJANG");
		
		DataSet ds_out;
		StringBuffer sbSelSql = new StringBuffer();
	
		sbSelSql.delete(0, sbSelSql.length());
		
		sbSelSql.append("SELECT A.SUBINV_CODE \n");
		//sbSelSql.append("     , A.SUBINV_NAME||' '||REPLACE(B.UPJANGNM,'단체급식 ') SUBINV_NAME \n");
		sbSelSql.append("     , A.SUBINV_NAME \n");
		sbSelSql.append("  FROM HLDC_PO_SUBINVENTORY A \n");
		sbSelSql.append("     , ST_UPJANG B \n");
		sbSelSql.append(" WHERE A.UPJANG = B.UPJANG \n");
		sbSelSql.append("   AND A.USE_YN = 'Y' \n");
		sbSelSql.append("   AND B.UPJANG = '" + UPJANG + "' \n");
		sbSelSql.append(" ORDER BY CASE WHEN SUBSTR(A.SUBINV_CODE, 1, 1) = 'C' THEN 0 \n");
		sbSelSql.append("               WHEN SUBSTR(A.SUBINV_CODE, 1, 1) = 'E' THEN 1 \n");
		sbSelSql.append("               WHEN SUBSTR(A.SUBINV_CODE, 1, 1) = 'A' THEN 2 \n");
		sbSelSql.append("               ELSE 3 END \n");
		sbSelSql.append("     , SUBINV_CODE \n");
		
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSelSql.toString());
		
		DataSet ds_subinv = this.makeDataSet(rs,"ds_subinv_cd");
		out_dl.add(ds_subinv);
		
	   	this.setResultMessage(0, "OK",out_vl);
		
	} catch(Exception ex) {
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
