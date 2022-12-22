
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
		
		String v_PrSgn 	= in_vl.getString("p_PrSgn");	
		String v_PoType = in_vl.getString("p_PoType");
		String v_MuCd 	= in_vl.getString("p_MuCd");	
		
		DataSet ds_out;
		StringBuffer sbSelSql = new StringBuffer();
	
		sbSelSql.delete(0, sbSelSql.length());
		
/* 		sbSelSql.append("SELECT A.SABUN, A.NM_KOR||';'||B.TM_NM||';'||A.SABUN NM_KOR \n");
		sbSelSql.append("  FROM HR_PERSONAL A, SC_DEPT_V B, PO_USER_POSITION C \n");
		sbSelSql.append(" WHERE A.DEPT_ID  = B.DEPT_ID \n");
		sbSelSql.append("   AND A.SABUN    = C.SABUN \n");
		sbSelSql.append("   AND B.MU_CD    = '" + v_MuCd + "' \n");
		sbSelSql.append("   AND C.SABUN    > '000000000' \n");
		sbSelSql.append("   AND C.POS_CODE = '" + v_PrSgn + "' \n");
		sbSelSql.append("   AND C.PO_TYPE  = '" + v_PoType + "' \n");
		//sbSelSql.append("   AND A.USE_YN   = 'Y' \n");
		sbSelSql.append(" ORDER BY A.NM_KOR \n"); */
		
		sbSelSql.append("SELECT A.SABUN, A.NM_KOR||';'||B.TM_NM||';'||A.SABUN NM_KOR \n");
		sbSelSql.append("  FROM HR_PERSONAL A, HLDC_SC_DEPT_V B \n");
		sbSelSql.append(" WHERE A.DEPT_ID  = B.DEPT_ID \n");

		sbSelSql.append("   AND B.MU_CD    = '" + v_MuCd + "' \n");
		sbSelSql.append("   AND A.SABUN    > '000000000' \n");
		//sbSelSql.append("   AND A.USE_YN   = 'Y' \n");
		sbSelSql.append(" ORDER BY A.NM_KOR \n");
		
		//pstmt = conn.prepareStatement(sbSelSql.toString());		
		//rs = pstmt.executeQuery();
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSelSql.toString());
		
		DataSet ds_pprover = this.makeDataSet(rs,"ds_out");
		out_dl.add(ds_pprover);
		
	   	this.setResultMessage(0, "OK",out_vl);
		
	} catch(Exception ex) {
		ex.printStackTrace();
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