<%
/*-----------------------------------------------------------------------------
■ 시스템명     : IFIS/구매관리/구매신청
■ 프로그램ID   : FSP0032E_T011.jsp
■ 프로그램명   : 선발주체크
■ 작성일자     : 2008-08-08
■ 작성자       : 박은규
■ 이력관리     : 2008-08-08
-----------------------------------------------------------------------------*/
%>

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
		
		DataSet ds_List  	= in_dl.get("ds_List");
		
		StringBuffer sbSql = new StringBuffer();
		String StrPreOrderMsg = "";

		for ( int i = 0 ; i < ds_List.getRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());
		
			//1.선발주제한 : 오늘로부터 D_Days일자 후 까지 들어와야하는 입고분의 발주(신청)를 제한한다.(D_Days=2인 경우 2일후 즉, 모레까지 입고분은 신청을 못하게 막는다. 3일 후 입고분부터 가능하나 정확히 3일 후 입고분은 시간을 체크)
			//즉,입고예정일과 시스템일자의 차이가 D_Days + 1보다 같거나 커야하며...
			//2.D_Days + 1과 같을 경우 D_Times보다 시스템시간이 작아야 한다...
			//즉, 현재보다 D_Days+1이전에 신청해야 하며..딱 D_Days+1전에 신청할 경우 D_Times전에 신청해야한다.
/*
			sbSql.append("SELECT D_DAYS, TRIM(TO_CHAR(D_TIMES,'00')) AS D_TIMES \n");
			sbSql.append("  FROM PO_PREORDER_LIST \n");
			sbSql.append(" WHERE CENTER_CODE = " + nullToBlank(ds_List.getString(i, "CENTER_CODE")) + " \n");
			sbSql.append("   AND ITEM_CODE = '" + nullToBlank(ds_List.getString(i, "ITEM_CODE")) + "' \n");
			sbSql.append("   AND D_DAYS >= 0 \n");
			sbSql.append("   AND ( \n");
			sbSql.append("        (D_DAYS >= (TO_DATE('" + nullToBlank(ds_List.getString(i, "NEED_DATE")) + "','YYYYMMDD') - TRUNC(SYSDATE))) \n");
			sbSql.append("        OR ( \n");
			sbSql.append("            (D_DAYS = (TO_DATE('" + nullToBlank(ds_List.getString(i, "NEED_DATE")) + "','YYYYMMDD') - TRUNC(SYSDATE) - 1)) \n");
			sbSql.append("            AND (DECODE(D_TIMES,NULL,24,0,24,D_TIMES) <= TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))) \n");
			sbSql.append("           ) \n");
			sbSql.append("       ) \n");
*/
			sbSql.append("SELECT HWFS_FMP_GETEXCDAYS_FUN('" + nullToBlank(ds_List.getString(i, "NEED_DATE")) + "',D_DAYS) AS D_DAYS \n");
			sbSql.append("     , TRIM(TO_CHAR(D_TIMES,'00')) AS D_TIMES \n");
			sbSql.append("  FROM PO_PREORDER_LIST \n");
			sbSql.append(" WHERE CENTER_CODE = " + nullToBlank(ds_List.getString(i, "CENTER_CODE")) + " \n");
			sbSql.append("   AND ITEM_CODE = '" + nullToBlank(ds_List.getString(i, "ITEM_CODE")) + "' \n");
			sbSql.append("   AND D_DAYS >= 0 \n");
			sbSql.append("   AND ( \n");
			sbSql.append("        (HWFS_FMP_GETEXCDAYS_FUN('" + nullToBlank(ds_List.getString(i, "NEED_DATE")) + "',D_DAYS) >= (TO_DATE('" + nullToBlank(ds_List.getString(i, "NEED_DATE")) + "','YYYYMMDD') - TRUNC(SYSDATE))) \n");
			sbSql.append("        OR ( \n");
			sbSql.append("            (HWFS_FMP_GETEXCDAYS_FUN('" + nullToBlank(ds_List.getString(i, "NEED_DATE")) + "',D_DAYS) = (TO_DATE('" + nullToBlank(ds_List.getString(i, "NEED_DATE")) + "','YYYYMMDD') - TRUNC(SYSDATE) - 1)) \n");
			sbSql.append("            AND (DECODE(D_TIMES,NULL,24,0,24,D_TIMES) <= TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))) \n");
			sbSql.append("           ) \n");
			sbSql.append("       ) \n");

			stmt = conn.createStatement();		
			rs = stmt.executeQuery(sbSql.toString());		
		
			if(rs.next())
			{
				StrPreOrderMsg  = " ※ 선발주 제한 신청불가!! \n\n";
				StrPreOrderMsg += ds_List.getString(i,"ITEM_CODE") + " " + ds_List.getString(i,"ITEM_NAME") + "\n";
				StrPreOrderMsg += "    자  재  명 : " + ds_List.getString(i,"ITEM_NAME") + "\n";
				StrPreOrderMsg += "    선발주제한 : D-" + rs.getString("D_DAYS") + "일 " + rs.getString("D_TIMES") + "시";
			   	break;
			}

			rs.close();
			stmt.close();
		}			
		
		out_vl.add("v_PreOrderMsg", StrPreOrderMsg);
		
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