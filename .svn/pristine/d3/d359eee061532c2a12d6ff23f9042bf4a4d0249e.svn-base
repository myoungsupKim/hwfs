
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
		
		String p_SubinvCode 	= in_vl.getString("p_SubinvCode");
		String p_NeedDate 		= in_vl.getString("p_NeedDate");	
		
		StringBuffer sbSelSql = new StringBuffer();
	
		sbSelSql.delete(0, sbSelSql.length());
		// 수불마감 점검
		sbSelSql.append("SELECT TO_CHAR(TO_DATE(A.CLS_YM,'YYYYMM'),'YYYY/MM') AS CLS_MONTH \n");
		sbSelSql.append("  FROM HLDC_PO_CLOSING A \n");
		sbSelSql.append(" WHERE A.CLS_YM     >= '" + p_NeedDate.substring(0,6) + "' \n");
		sbSelSql.append("   AND A.SUBINV_CODE = '" + p_SubinvCode + "' \n");
		sbSelSql.append("   AND A.CLS_FLAG    = 'Y' \n");
		sbSelSql.append("   AND ROWNUM        = 1 \n");
		
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSelSql.toString()); 			
		
		String strSubulCloseYN;
		
		if(rs.next())
			//strSubulCloseYN = rs.getString(0);
			strSubulCloseYN = rs.getString("CLS_MONTH");
		else
			strSubulCloseYN = "N";
		
		rs.close();
		stmt.close();
		
		out_vl.add("v_SubulCloseYN", strSubulCloseYN);
		
		sbSelSql.delete(0, sbSelSql.length());
		
		// 재고반영 점검
		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("/* 해당 기간 이후 재고조사가 존재하는지 체크 */ \n");
		sbSelSql.append("SELECT TO_CHAR(TO_DATE(A.PHYSIC_DATE, 'YYYYMMDD'), 'YYYY/MM/DD') AS CLS_DATE \n");
		sbSelSql.append("  FROM HLDC_PO_PHYSICAL_INVENTORY A \n");
		sbSelSql.append("      , ( SELECT DISTINCT A.* \n");
		sbSelSql.append("            FROM HLDC_PO_PHYSICAL_INVENTORY A \n");
		sbSelSql.append("               , ( SELECT PHYSIC_DATE AS PHYSIC_DATE \n");
		sbSelSql.append("                        , ITEM_CODE AS ITEM_CODE \n");
		sbSelSql.append("                        , MAX(UPDATE_DATE) AS UPDATE_DATE \n");
		sbSelSql.append("                     FROM HLDC_PO_PHYSICAL_INVENTORY \n");
		sbSelSql.append("                    WHERE PHYSIC_DATE >= '" + p_NeedDate + "' \n");
		sbSelSql.append("                      AND SUBINV_CODE  = '" + p_SubinvCode + "' \n");
		sbSelSql.append("                    GROUP BY PHYSIC_DATE, ITEM_CODE \n");
		sbSelSql.append("                 ) B \n");
		sbSelSql.append("           WHERE A.PHYSIC_DATE  = B.PHYSIC_DATE \n");
		sbSelSql.append("             AND A.ITEM_CODE    = B.ITEM_CODE \n");
		sbSelSql.append("             AND A.UPDATE_DATE  = B.UPDATE_DATE \n");
		sbSelSql.append("             AND A.PHYSIC_DATE >= '" + p_NeedDate + "' \n");
		sbSelSql.append("             AND A.SUBINV_CODE  = '" + p_SubinvCode + "' \n");
		sbSelSql.append("        ) B \n");
		sbSelSql.append(" WHERE A.PHYSIC_ID    = B.PHYSIC_ID \n");
		sbSelSql.append("   AND A.ITEM_CODE    = B.ITEM_CODE \n");
		sbSelSql.append("   AND A.PHYSIC_DATE >= '" + p_NeedDate + "' \n");
		sbSelSql.append("   AND A.SUBINV_CODE  = '" + p_SubinvCode + "' \n");
		sbSelSql.append("   AND B.CANCEL_YN    = 'N' \n");
		sbSelSql.append(" ORDER BY A.PHYSIC_DATE DESC \n");
		
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSelSql.toString()); 	
		
		String strJaegoCloseYN;
		
		if(rs.next())
			strJaegoCloseYN = rs.getString("CLS_DATE");
		else
			strJaegoCloseYN = "N";
		
		out_vl.add("v_JaegoCloseYN", strJaegoCloseYN);
		
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