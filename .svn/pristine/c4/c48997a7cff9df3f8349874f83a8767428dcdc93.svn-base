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
		
		DataSet	ds_cond =	in_dl.get("ds_cond");
		
		String UPJANG 		=	nullToBlank(ds_cond.getString(0, "UPJANG"));	// 추가구매승인YN
		String NEED_DATE	=	nullToBlank(ds_cond.getString(0, "NEED_DATE"));	// 추가구매승인YN
		String CUSTCD	=	nullToBlank(ds_cond.getString(0, "CUSTCD"));	// 추가구매승인YN
		String CUSTNM	=	nullToBlank(ds_cond.getString(0, "CUSTNM"));	// 추가구매승인YN
		

		StringBuffer sbSelSql = new StringBuffer();
	
		sbSelSql.delete(0, sbSelSql.length());

		sbSelSql.append("SELECT DISTINCT B.VD_CD AS CUSTCD										\n");
		sbSelSql.append("     , B.VD_NM			 AS CUSTNM										\n");
		sbSelSql.append("  FROM HLDC_PO_CONTRACT_F A											\n");
		sbSelSql.append("     , VO_FC_VENDOR B													\n");
		sbSelSql.append(" WHERE A.CUSTCD = B.VD_CD												\n");
		sbSelSql.append("   AND A.UPJANG = '"+UPJANG+"'											\n");
		sbSelSql.append("   AND '"+NEED_DATE+"' BETWEEN A.CONTRACT_START AND A.CONTRACT_END		\n");
		if(!CUSTCD.equals(""))
			sbSelSql.append("   AND B.VD_CD = '" + CUSTCD + "'									\n");
		if(!CUSTNM.equals(""))
			sbSelSql.append("   AND B.VD_NM LIKE '%'||'" + CUSTNM + "' || '%'					\n");
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sbSelSql.toString());

		DataSet	ds_out = this.makeDataSet(rs,"ds_out");
		out_dl.add(ds_out);

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