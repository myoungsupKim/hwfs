<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt = null;

	try
	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log 서비스 시작
		logger.startIndividualLog(in_vl.getString("titLogId"));

		String v_SubinvCode 	= nullToBlank(in_vl.getString("v_SubinvCode"));
		String v_Date 			= nullToBlank(in_vl.getString("v_Date"));
		String v_chkPoUom 		= nullToBlank(in_vl.getString("v_chkPoUom"));
		String g_EmpNo 			= nullToBlank(in_vl.getString("g_EmpNo"));
		String v_AppDate		= nullToBlank(in_vl.getString("v_AppDate"));

		StringBuffer sbSelSql = new StringBuffer();

		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("/* 서버날짜 조회 */");
		sbSelSql.append("SELECT TO_CHAR(SYSDATE,'YYYYMMDD') TODAY FROM DUAL ");

		pstmt = conn.prepareStatement(sbSelSql.toString());
		rs = pstmt.executeQuery();
		rs.next();
		
		String toDay = rs.getString("TODAY");

		rs.close();
		pstmt.close();
		
		if( v_Date.equals(toDay) )
		{
			sbSelSql.delete(0, sbSelSql.length());
			sbSelSql.append("SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') AS FR_DATE \n");
			sbSelSql.append("     , TO_CHAR(SYSDATE, 'YYYYMMDD') AS TO_DATE \n");
			sbSelSql.append("  FROM DUAL \n");

			pstmt = conn.prepareStatement(sbSelSql.toString());
			rs = pstmt.executeQuery();
		}
		else
		{
			// 수불 마감월 확인
			sbSelSql.delete(0, sbSelSql.length());
			sbSelSql.append("SELECT CASE WHEN MAX(CLS_YM) <> SUBSTR('"+ v_Date +"', 1, 6) \n");
			sbSelSql.append("            THEN TO_CHAR(ADD_MONTHS(TO_DATE(MAX(CLS_YM), 'YYYYMM'), 1), 'YYYYMM') || '01' \n");
			sbSelSql.append("            ELSE '"+ v_Date + "' END AS CLS_DATE \n");
			sbSelSql.append("  FROM HLDC_PO_CLOSING \n");
			sbSelSql.append(" WHERE CLS_YM   <= SUBSTR('"+ v_Date +"', 1, 6) \n");
			sbSelSql.append("   AND SUBINV_CODE = '"+ v_SubinvCode +"' \n");
			sbSelSql.append("   AND CLS_FLAG  = 'Y' \n");

			pstmt = conn.prepareStatement(sbSelSql.toString());
			rs = pstmt.executeQuery();
			
			String clsDate = "";

			if( rs.next() )
			{
				clsDate = nullToBlank(rs.getString("CLS_DATE"));
			}
			else
			{
				clsDate = v_Date;	
			}

			rs.close();
			pstmt.close();

			sbSelSql.delete(0, sbSelSql.length());
			sbSelSql.append("SELECT CASE WHEN TO_CHAR(TO_DATE(MAX(CLOSE_DATE), 'YYYYMMDD')+1, 'YYYYMMDD') < '" + v_Date + "' \n");
			sbSelSql.append("            THEN '" + v_Date + "' \n");
			sbSelSql.append("            ELSE TO_CHAR(TO_DATE(MAX(CLOSE_DATE), 'YYYYMMDD')+1, 'YYYYMMDD') \n");
			sbSelSql.append("            END AS FR_DATE \n");
			sbSelSql.append("     , CASE WHEN MAX(CLOSE_DATE) = TO_CHAR(SYSDATE, 'YYYYMMDD') \n");
			sbSelSql.append("            THEN TO_CHAR(SYSDATE, 'YYYYMMDD') \n");
			sbSelSql.append("            ELSE TO_CHAR(SYSDATE-1, 'YYYYMMDD') \n");
			sbSelSql.append("            END AS TO_DATE \n");
			sbSelSql.append("  FROM MAS_CLOSE_MGMT \n");
			sbSelSql.append(" WHERE UPJANG = (SELECT UPJANG FROM HLDC_PO_SUBINVENTORY WHERE SUBINV_CODE = '"+v_SubinvCode+"') \n");
			sbSelSql.append("   AND CLOSE_GUBUN = '004' \n");
			sbSelSql.append("   AND CLOSE_DATE >= SUBSTR('"+clsDate+"', 1, 6) \n"); 

			pstmt = conn.prepareStatement(sbSelSql.toString());
			rs = pstmt.executeQuery();
		}

		DataSet ds_applyDate = this.makeDataSet(rs, "ds_applyDate");
		out_dl.add(ds_applyDate);

	   	this.setResultMessage(0, "OK", out_vl);

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