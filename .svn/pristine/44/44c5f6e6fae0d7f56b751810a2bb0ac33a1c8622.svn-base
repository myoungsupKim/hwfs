
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
		
		//DataSet ds_input  	= in_dl.get("dsPoLineStatus");
		
		String p_PrNum 		= in_vl.getString("p_PrNum");	
		
		StringBuffer sbSelSql = new StringBuffer();
	
		// 신청서 수정시 신청서중 아래의 상태코드의 자재가 존재할 경우 체크
		// ( DL:배송중, GC:입고완료, IV:정산완료 )
		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("SELECT B.ITEM_CODE|| ' ' || B.ITEM_NAME    \n");
		sbSelSql.append("  FROM SO_PR A                             \n");
		sbSelSql.append("     , HLDC_PO_PO B                        \n");
		sbSelSql.append(" WHERE A.PR_NUM = B.PO_NUM                 \n");
		sbSelSql.append("   AND A.ORG_PR_NUM = '" + p_PrNum + "'    \n");
		sbSelSql.append("   AND B.LINE_STATUS IN ('DL', 'GC', 'IV') \n");
		sbSelSql.append("   AND ROWNUM = 1                          \n");
		
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSelSql.toString());		
		
		String strItemName;
		
		if(rs.next())
			strItemName = rs.getString("ITEM_NAME");
		else
			strItemName = "";
		
		out_vl.add("v_ItemName", strItemName);
		
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