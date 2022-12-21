<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 재고조사
■ 프로그램ID   : FMW00400E_T003.jsp
■ 프로그램명   : 재고조사내역 삭제
■ 작성일자     : 2011.01.20
■ 작성자       : 문형광
■ 이력관리     : 
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt              =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();	
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));	
		//오토커밋 강제 false
		conn.setAutoCommit(false);
		//In 데이타
		DataSet ds_List  	    = in_dl.get("ds_List");
		DataSet ds_Cond  	    = in_dl.get("ds_Cond");
		
		String v_Upjang         = nullToBlank(ds_Cond.getString(0, "UPJANG"));
		String v_TransDate      = nullToBlank(ds_Cond.getString(0, "TRANS_DATE"));
		String v_SubinvCode     = nullToBlank(ds_Cond.getString(0, "SUBINV_CODE"));
		String g_EmpNo          = nullToBlank(in_vl.getString("g_EmpNo"));
		String sPhysicDate        = "";
		
	    //out 데이타
		StringBuffer sbSql = new StringBuffer();
	    
		sbSql.delete(0, sbSql.length());
		sbSql.append( "SELECT CLS_YM \n");
		sbSql.append( "  FROM FMW_CLOSING  \n");
		sbSql.append( " WHERE CLS_YM      >= SUBSTR('"+ v_TransDate +"',1,6) \n");
		sbSql.append( "   AND SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSql.append( "   AND CLS_FLAG    = 'Y' \n");
		sbSql.append( "   AND ROWNUM      <= 1 \n");
out_vl.add("fa_Sql", sbSql.toString());					
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		
		if(rs.next())
		{
			sPhysicDate = rs.getString("CLS_YM");
			rs.close();
			pstmt.close();
			out_vl.add("sPhysicDate", sPhysicDate+"월 마감이 되어 작업이 불가합니다!.");
//this.setResultMessage(0, "OK",out_vl);
			proc_output(response,out,out_vl,out_dl);
			return;
		}
		else
		{
				rs.close();
				pstmt.close();		 
		}
	    
		sbSql.delete(0, sbSql.length());
		sbSql.append( "SELECT A.PHYSIC_DATE						        \n");
		sbSql.append( "  FROM FMW_PHYSICAL_INV A                       \n");
		sbSql.append( " WHERE A.SUBINV_CODE = '" + v_SubinvCode + "'   \n");
		sbSql.append( "   AND A.PHYSIC_DATE > '" + v_TransDate + "' \n");
		sbSql.append( "   AND ROWNUM        <= 1 \n");
out_vl.add("fa_Sql", sbSql.toString());					
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();

		if(rs.next())
		{
			sPhysicDate = rs.getString("PHYSIC_DATE");
			rs.close();
			pstmt.close();
			out_vl.add("sPhysicDate", sPhysicDate+" 일자 재고조사내역을 삭제해야 처리가 가능합니다!.");
			proc_output(response,out,out_vl,out_dl);
			return;
		}
		else
		{
			rs.close();
		    pstmt.close();
		    
		    sbSql.delete(0, sbSql.length());
			sbSql.append( "DELETE FROM FMW_PHYSICAL_INV               \n");
			sbSql.append( " WHERE PHYSIC_DATE = '" + v_TransDate + "' \n");
			sbSql.append( "   AND SUBINV_CODE = '" + v_SubinvCode + "'\n");
out_vl.add("fa_Sql", sbSql.toString());					
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();

			sbSql.delete(0, sbSql.length());
			sbSql.append( "DELETE FROM FMW_PO_TRANSACTION        \n");
			sbSql.append( " WHERE SUBINV_CODE = '" + v_SubinvCode + "'\n");
			sbSql.append( "   AND TRANS_DATE = '" + v_TransDate + "'\n");
			sbSql.append( "   AND TRANS_TYPE LIKE 'P%' \n");
//			sbSql.append( " WHERE ORG_NUM = " + sDPhysicId + " \n");
out_vl.add("fa_Sql", sbSql.toString());					
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}	
			
		conn.commit();
		this.setResultMessage(0, "OK", out_vl);
	}   	
	catch(Exception ex)
	{
		conn.rollback();
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);		
		this.setResultMessage(-1, ex.toString(),out_vl);
	}
	finally
	{
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