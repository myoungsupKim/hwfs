<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 협력업체 > 운영관리
■ 프로그램ID   : FSV00470E_T001.jsp
■ 프로그램명   : 축산자재이력정보입력(입력)
■ 작성일자     : 2014-08-01
■ 작성자       : 문형광
■ 이력관리     : 
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		 
		// log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//오토커밋 강제 false
		conn.setAutoCommit(false);		
		
		//입력 데이타
		DataSet ds_list     = in_dl.get("ds_list");
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String vCENTER_CODE = nullToBlank(ds_Cond.getString(0, "CENTER_CODE"));
		String vCUSTCD      = nullToBlank(ds_Cond.getString(0, "CUSTCD")); 
		String vNEED_DATE 	= nullToBlank(ds_Cond.getString(0, "ESTIMATE_START"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		
		String sCheckDate   = "";
			
		if(conn != null && !conn.isClosed()) conn.close(); 
		conn = getIRISConn();
		
		StringBuffer sbSql 	= new StringBuffer();	//sql문 버퍼생성
		
		//기존 이력내역 확인
		sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT TO_CHAR(TO_DATE(NEED_DATE, 'YYYYMMDD')-1, 'YYYYMMDD') AS CHECKDATE \n");
        sbSql.append("  FROM PO_ANIMAL_HIST 						                            \n");
        sbSql.append(" WHERE CENTER_CODE = '" + vCENTER_CODE + "'  								\n");
        sbSql.append("   AND CUSTCD = '" + vCUSTCD + "'            								\n");
        sbSql.append("   AND NEED_DATE = '" + vNEED_DATE + "'      								\n");
        sbSql.append("   AND SIGN(TO_DATE('" + vNEED_DATE + "', 'YYYYMMDD') - SYSDATE) <= 0 	\n"); 
        sbSql.append("   AND ROWNUM <= 1          						   						\n");
out_vl.add("fa_Sql", sbSql.toString());					
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		if(rs.next())
		{
			sCheckDate = rs.getString("CHECKDATE");
			rs.close();
			pstmt.close();
			out_vl.add("sCheckDate", "해당 입고예정일자("+nullToBlank(ds_Cond.getString(0, "NEED_DATE"))+")는  "+sCheckDate+" 일자까지만 작업이 가능합니다!.");
			proc_output(response,out,out_vl,out_dl);
			return;
		}
		else
		{
			rs.close();
			pstmt.close();		 
		}
		
	//	System.out.println(v_OTCUSTCD +"ddd");	

		for ( int i = 0 ; i < ds_list.getRowCount() ; i++ )
	    {
			//시작
			sbSql.delete(0, sbSql.length());
			sbSql.append( "MERGE INTO PO_ANIMAL_HIST A  												\n");
			sbSql.append( "USING (SELECT '" + vCENTER_CODE + "' AS CENTER_CODE                 												\n");
			sbSql.append( "            , '" + vCUSTCD + "' AS CUSTCD              												\n");
			sbSql.append( "     	   , '" + vNEED_DATE + "' AS NEED_DATE                   							  \n");
			sbSql.append( "            , '" + nullToBlank(ds_list.getString(i, "ITEM_CODE")) + "' AS ITEM_CODE    \n");
			sbSql.append( "            , '" + nullToBlank(ds_list.getString(i, "PO_ID")) + "' AS PO_ID            \n");
			sbSql.append( "         FROM DUAL) B                												          \n");
			sbSql.append( "   ON (A.CENTER_CODE = B.CENTER_CODE AND A.CUSTCD = B.CUSTCD AND A.NEED_DATE = B.NEED_DATE AND \n");
			sbSql.append( "       A.NEED_DATE = B.NEED_DATE AND A.PO_ID = B.PO_ID)										  \n");
			sbSql.append( " WHEN MATCHED THEN			\n");
			sbSql.append( "      UPDATE   												\n");
			sbSql.append( "         SET A.IMPORT_NUM = '" + nullToBlank(ds_list.getString(i, "IMPORT_NUM")) + "' \n");
			sbSql.append( "           , A.BUTCH_NAME = '" + nullToBlank(ds_list.getString(i, "BUTCH_NAME")) + "' \n");
			sbSql.append( "           , A.UPDATE_DATE = SYSDATE \n");
			sbSql.append( "           , A.UPDATE_BY = '" + g_EmpNo + "' \n");
			sbSql.append( " WHEN NOT MATCHED THEN			\n");
			sbSql.append( "      INSERT ( PO_ID			\n");
			sbSql.append( "             , NEED_DATE			\n");
			sbSql.append( "             , CENTER_CODE			\n");
			sbSql.append( "             , CUSTCD			\n");
			sbSql.append( "             , ITEM_CODE			\n");
			sbSql.append( "             , BUTCH_NAME			\n");
			sbSql.append( "             , IMPORT_NUM			\n");
			sbSql.append( "             , CREATE_DATE			\n");
			sbSql.append( "             , CREATE_BY			\n");
			sbSql.append( "             , UPDATE_DATE			\n");
			sbSql.append( "             , UPDATE_BY	)		\n");
			sbSql.append( "      INSERT ( '" + nullToBlank(ds_list.getString(i, "PO_ID")) + "'			\n");
			sbSql.append( "             , '" + vNEED_DATE + "'			\n");
			sbSql.append( "             , '" + vCENTER_CODE + "'			\n");
			sbSql.append( "             , '" + vCUSTCD + "'			\n");
			sbSql.append( "             , '" + nullToBlank(ds_list.getString(i, "ITEM_CODE")) + "'			\n");
			sbSql.append( "             , '" + nullToBlank(ds_list.getString(i, "BUTCH_NAME")) + "'			\n");
			sbSql.append( "             , '" + nullToBlank(ds_list.getString(i, "IMPORT_NUM")) + "'			\n");
			sbSql.append( "             , SYSDATE			\n");
			sbSql.append( "             , '" + g_EmpNo + "'			\n");
			sbSql.append( "             , SYSDATE			\n");
			sbSql.append( "             , '" + g_EmpNo + "'			\n");
			sbSql.append( "             )		\n");
out_vl.add("fa_Sql", sbSql.toString());  		         
		    pstmt = conn.prepareStatement(sbSql.toString());
		    pstmt.executeUpdate();
		    pstmt.close();
	    }
	              
		/**종료**/
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
