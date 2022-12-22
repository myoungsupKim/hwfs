
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
		
		DataSet ds_input  	= in_dl.get("dsPoLineStatus");
		String v_POCancel = nullToBlank(ds_input.getString(0,"POCancel"));
		String v_PRSave   = nullToBlank(ds_input.getString(0,"PRSave"));
		String v_PRFix    = nullToBlank(ds_input.getString(0,"PRFix"));
		String v_PRApprove = nullToBlank(ds_input.getString(0,"PRApprove"));
		
		String v_GroupCode	= in_vl.getString("strGroupCode");
		String v_Upjang  	= in_vl.getString("g_Upjang");
		String v_EmpNo 		= in_vl.getString("g_EmpNo");	
		
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		//stmt 		=  conn.createStatement();
	
	
		DataSet ds_out;
		StringBuffer sbSelSql = new StringBuffer();
	
		sbSelSql.delete(0, sbSelSql.length());
		
		sbSelSql.append("SELECT E.TYPE_NAME, A.SUBINV_CODE||' '||B.SUBINV_NAME SUBINV_NAME \n");
		sbSelSql.append("	     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.PR_QTY, C.CODE_NAME \n");
		sbSelSql.append("	     , A.NEED_DATE \n");
		sbSelSql.append("	     , DECODE(A.LINE_STATUS, '" + v_POCancel + "', 'Y', \n");
		sbSelSql.append("	              DECODE( SIGN( \n");
		sbSelSql.append("	                           TO_NUMBER(TO_CHAR((TO_DATE(A.NEED_DATE,'YYYYMMDD')-E.D_DAYS),'YYYYMMDD') || RPAD(DECODE(E.D_TIMES,0,23),2,'0')) \n");
		sbSelSql.append("	                           -TO_NUMBER(TO_CHAR(SYSDATE,'YYYYMMDDHH24')) \n");
		sbSelSql.append("	                          ) \n");
		sbSelSql.append("	                      ,1,'N','Y') \n");
		sbSelSql.append("	             ) CLS_YN \n");
		sbSelSql.append("	     , A.PR_ID \n");
		sbSelSql.append("	     , A.PR_DATE, A.PO_TYPE \n");
		sbSelSql.append("	     , A.LINE_STATUS \n");
		sbSelSql.append("	     , E.D_DAYS \n");
		sbSelSql.append("	     , E.D_TIMES \n");
		sbSelSql.append("	  FROM PO_PR A \n");
		sbSelSql.append("	     , PO_SUBINVENTORY B \n");
		sbSelSql.append("	     , PO_CODE C \n");
		sbSelSql.append("	     , ( \n");
		sbSelSql.append("	        SELECT PR_ID \n");
		sbSelSql.append("	          FROM \n");
		sbSelSql.append("	               ( \n");
		sbSelSql.append("	                SELECT PR_ID \n");
		sbSelSql.append("                     , TO_NUMBER(SUBSTR(PRC, INSTR(PRC,';',1,2)+1, INSTR(PRC,';',1,3)-INSTR(PRC,';',1,2)-1)) UNIT_PRICE \n");
		sbSelSql.append("					FROM \n");
		sbSelSql.append("						( \n");
		sbSelSql.append("	                    SELECT PR_ID, PO_CONTRACT_PRICE(NEED_DATE, RC_UPJANG, ITEM_CODE, SUBINV_CODE, 'PO_CONTRACT_F') PRC \n");
		sbSelSql.append("	                      FROM PO_PR \n");
		sbSelSql.append("	                     WHERE NEED_DATE >= TO_CHAR(SYSDATE,'YYYYMMDD') \n");
		sbSelSql.append("	                       AND (PR_UPJANG = '" + v_Upjang + "' OR PR_SABUN = '" + v_EmpNo + "') \n");
		sbSelSql.append("	                       AND LINE_STATUS IN ('" + v_PRSave + "','" + v_PRFix + "','" + v_PRApprove + "') \n");
		sbSelSql.append("	                       AND ITEM_CODE BETWEEN '010100000001' AND '019999999999' \n");
		sbSelSql.append("	                    ) \n");
		sbSelSql.append("	                ) \n");
		sbSelSql.append("	         WHERE UNIT_PRICE = 0 \n");
		sbSelSql.append("	        UNION ALL \n");
		sbSelSql.append("	        SELECT PR_ID \n");
		sbSelSql.append("	          FROM PO_PR \n");
		sbSelSql.append("	         WHERE NEED_DATE >= TO_CHAR(SYSDATE,'YYYYMMDD') \n");
		sbSelSql.append("	           AND (PR_UPJANG = '" + v_Upjang + "' OR PR_SABUN = '" + v_EmpNo + "') \n");
		sbSelSql.append("	           AND LINE_STATUS = '" + v_POCancel + "' \n");
		sbSelSql.append("	           AND ITEM_CODE BETWEEN '010100000001' AND '019999999999' \n");
		sbSelSql.append("	       ) D \n");
		sbSelSql.append("	    , PO_TYPE E \n");
		sbSelSql.append("	 WHERE A.LINE_STATUS = C.CODE \n");
		sbSelSql.append("	   AND A.SUBINV_CODE = B.SUBINV_CODE(+) \n");
		sbSelSql.append("	   AND C.GROUP_CODE  = '" + v_GroupCode + "' \n");
		sbSelSql.append("	   AND A.PR_ID = D.PR_ID \n");
		sbSelSql.append("	   AND A.PO_TYPE = E.PO_TYPE \n");
  
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSelSql.toString()); 
		
		//pstmt = conn.prepareStatement(sbSelSql.toString());		
		//rs = pstmt.executeQuery();
		
		DataSet ds_return = this.makeDataSet(rs,"ds_out");
		out_dl.add(ds_return);
		
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