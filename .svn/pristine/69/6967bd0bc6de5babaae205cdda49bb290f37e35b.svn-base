<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/노무관리
■ 프로그램ID   : FMO00760E_T003.jsp
■ 프로그램명   : 직원급여 저장
■ 작성일자     : 2012.08.26
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
		DataSet ds_ListDetail   = in_dl.get("ds_ListDetail");
		DataSet ds_Cond  	    = in_dl.get("ds_Cond");
		
		String vSabun           = nullToBlank(in_vl.getString("vSabun"));
		String g_EmpNo          = nullToBlank(in_vl.getString("g_EmpNo"));
		String sCheckDate       = "";
		String sLastDay         = "";
		String sWorkSdt         = "";
		String sWorkEdt         = "";
	    //out 데이타
		StringBuffer sbSql = new StringBuffer();
	    
		//기존에 등록된 데이터가 있으면 지우고 INSERT...
		sbSql.delete(0, sbSql.length());
		sbSql.append( "SELECT 1 \n");
		sbSql.append( "  FROM FMO_PAY  \n");
		sbSql.append( " WHERE UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' \n");
		sbSql.append( "   AND SABUN = '" + nullToBlank(vSabun) + "'   \n");
		sbSql.append( "   AND ROWNUM <= 1 \n");
out_vl.add("fa_Sql", sbSql.toString());					
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		
		if(rs.next())
		{
		
			rs.close();
			pstmt.close();
			
			sbSql.delete(0, sbSql.length());
			sbSql.append( "DELETE FROM FMO_PAY               \n");
			sbSql.append( " WHERE UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' \n");
			sbSql.append( "   AND SABUN = '" + nullToBlank(vSabun) + "'   \n");
out_vl.add("fa_Sql", sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}
	    
		for ( int i = 0 ; i < ds_ListDetail.getRowCount() ; i++ )
        {
			
			sLastDay         = "";
			sWorkSdt         = "";
			sWorkEdt         = "";
			
			//월급제는 DB에서 시작일과 종료일을 강제로 셋팅해준다...
			if (ds_ListDetail.getString(i, "PAY_GB").equals("001"))
			{	
				//월의 마지막 일자를 확인한다...
				sbSql.delete(0, sbSql.length());
				sbSql.append( "SELECT TO_CHAR(LAST_DAY(TO_DATE('" +nullToBlank(ds_ListDetail.getString(i, "WORK_EDT")) + "' , 'YYYYMMDD')),'YYYYMMDD') AS WORK_EDT  \n");
				sbSql.append( "  FROM DUAL  \n");
					
				pstmt = conn.prepareStatement(sbSql.toString());
				rs = pstmt.executeQuery();
				
				if(rs.next())
				{
					sLastDay = rs.getString("WORK_EDT");
					rs.close();
					pstmt.close();
				}
				sWorkSdt = ds_ListDetail.getString(i, "WORK_SDT").substring(0,6) + "01";
				sWorkEdt = sLastDay;
			}
			else
			{
				sWorkSdt = ds_ListDetail.getString(i, "WORK_SDT");
				sWorkEdt = ds_ListDetail.getString(i, "WORK_EDT");
			}
			
			//기존데이터 시작일 체크
			sbSql.delete(0, sbSql.length());
			sbSql.append( "SELECT '" + nullToBlank(sWorkSdt) + "' AS CHK_DATE \n");
			sbSql.append( "  FROM FMO_PAY  \n");
			sbSql.append( " WHERE UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' \n");
			sbSql.append( "   AND SABUN = '" + nullToBlank(vSabun) + "'   \n");
			sbSql.append( "   AND WORK_SDT BETWEEN '" + nullToBlank(sWorkSdt) + "' AND '" + nullToBlank(sWorkEdt) + "' \n");
			sbSql.append( "   AND ROWNUM <= 1 \n");
out_vl.add("fa_Sql", sbSql.toString());					
			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				sCheckDate = rs.getString("CHK_DATE");
				rs.close();
				pstmt.close();
				out_vl.add("sCheckDate", i+ "행의" + sCheckDate+ " 시작일자가 기존기간에 포함됩니다!.");
                //this.setResultMessage(0, "OK",out_vl);
				proc_output(response,out,out_vl,out_dl);
				conn.rollback();
				return;
				//break;
			}
			//기존데이터 종료일 체크
			sbSql.delete(0, sbSql.length());
			sbSql.append( "SELECT '" + nullToBlank(sWorkEdt) + "' AS CHK_DATE \n");
			sbSql.append( "  FROM FMO_PAY  \n");
			sbSql.append( " WHERE UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' \n");
			sbSql.append( "   AND SABUN = '" + nullToBlank(vSabun) + "'   \n");
			sbSql.append( "   AND WORK_EDT BETWEEN '" + nullToBlank(sWorkSdt) + "' AND '" + nullToBlank(sWorkEdt) + "' \n");
			sbSql.append( "   AND ROWNUM <= 1 \n");
out_vl.add("fa_Sql", sbSql.toString());					
			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				sCheckDate = rs.getString("CHK_DATE");
				rs.close();
				pstmt.close();
				out_vl.add("sCheckDate", i+ "행의" + sCheckDate+ "종료일자가 기존기간에 포함됩니다!.");
				proc_output(response,out,out_vl,out_dl);
				conn.rollback();
				return;
				//break;
			}
			//넣는다...
			sbSql.delete(0, sbSql.length());
			sbSql.append("INSERT INTO FMO_PAY               \n");
	        sbSql.append("     ( SABUN                      \n");
	        sbSql.append("     , WORK_SDT                   \n");
	        sbSql.append("     , UPJANG                     \n");
	        sbSql.append("     , WORK_EDT                   \n");
	        sbSql.append("     , PAY_GB                     \n");
	        sbSql.append("     , PAY_AMT                    \n");
	        sbSql.append("     , REG_PAY                    \n");
	        sbSql.append("     , REMARK                     \n");
	        sbSql.append("     , CUSER                      \n");
	        sbSql.append("     , CDATE                      \n");
	        sbSql.append("     , UUSER                      \n");
	        sbSql.append("     , UDATE            		    \n");
	        sbSql.append("     ) VALUES                     \n");
	        sbSql.append("     ( '" + nullToBlank(vSabun) + "'                                           \n");
	        sbSql.append("     , '" + nullToBlank(sWorkSdt) + "'   \n");
	        sbSql.append("     , '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'           \n");
	        sbSql.append("     , '" + nullToBlank(sWorkEdt) + "'   \n");
	        sbSql.append("     , '" + nullToBlank(ds_ListDetail.getString(i, "PAY_GB")) + "'     \n");
	        sbSql.append("     , '" + nullToBlank(ds_ListDetail.getString(i, "PAY_AMT")) + "'    \n");
	        sbSql.append("     , '" + nullToBlank(ds_ListDetail.getString(i, "REG_PAY")) + "'    \n");
	        sbSql.append("     , '" + nullToBlank(ds_ListDetail.getString(i, "REMARK")) + "'     \n");
	        sbSql.append("     , '" + g_EmpNo + "'                          	                         \n");
	        sbSql.append("     , SYSDATE                   										         \n");
	        sbSql.append("     , '" + g_EmpNo + "'                          					         \n");
	        sbSql.append("     , SYSDATE                  										         \n");
	        sbSql.append("     )                  												         \n");
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