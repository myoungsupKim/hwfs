<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 협력업체단가견적제출
■ 프로그램ID   : FSV00370E_T003.jsp
■ 프로그램명   : 협력업체단가견적제출 저장
■ 작성일자     : 2012.07.20
■ 작성자       : 문형광
■ 이력관리     : 2012.07.20
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
		DataSet ds_list    = in_dl.get("ds_list");
		DataSet ds_Cond    = in_dl.get("ds_Cond");
		//입력 파라메터
		String vCENTER_CODE    = nullToBlank(ds_Cond.getString(0, "CENTER_CODE"));
		String vCUSTCD         = nullToBlank(ds_Cond.getString(0, "CUSTCD")); 
		String vESTIMATE_START = nullToBlank(ds_Cond.getString(0, "ESTIMATE_START"));
		String vESTIMATE_ID    = nullToBlank(ds_Cond.getString(0, "ESTIMATE_ID"));
		String vREMARK         = nullToBlank(ds_Cond.getString(0, "REMARK"));
		String g_EmpNo         = nullToBlank(in_vl.getString("g_EmpNo"));
		
		String sESTID       = "";
		String sESTIMATE_ID = "";
		String sCheckDate   = "";
			
		if(conn != null && !conn.isClosed()) conn.close(); 
		conn = getIRISConn();
		
		StringBuffer sbSql 	= new StringBuffer();	//sql문 버퍼생성
		
		//기존 견적내역 확인
		sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT ESTIMATE_ID        						   \n");
        sbSql.append("  FROM PO_ESTIMATE_MASTER 						   \n");
        sbSql.append(" WHERE CENTER_CODE = '" + vCENTER_CODE + "'          \n");
        sbSql.append("   AND CUSTCD = '" + vCUSTCD + "'          		   \n");
        sbSql.append("   AND ESTIMATE_START = '" + vESTIMATE_START + "'    \n");
        sbSql.append("   AND ESTIMATE_STATUS IN ('승인', '완료')    \n");
        sbSql.append("   AND USE_YN = 'Y' 							       \n");
        sbSql.append("   AND ROWNUM <= 1          						   \n");
out_vl.add("fa_Sql", sbSql.toString());					
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		if(rs.next())
		{
			sCheckDate = rs.getString("ESTIMATE_ID");
			rs.close();
			pstmt.close();
			out_vl.add("sCheckDate", "해당일자(견적번호 :"+sCheckDate+")로 견적이 등록되어 작업이 불가합니다!.");
			proc_output(response,out,out_vl,out_dl);
			return;
		}
		else
		{
				rs.close();
				pstmt.close();		 
		}
		
	//	System.out.println(v_OTCUSTCD +"ddd");	
		if ( !vESTIMATE_ID.equals("전체")) //단가계약번호 넘어오는거...
		{
			//기존 EST_ID 조회
			sbSql.delete(0, sbSql.length());
			sbSql.append( "SELECT EST_ID \n");
			sbSql.append( "  FROM PO_ESTIMATE_MASTER  \n");
			sbSql.append( " WHERE ESTIMATE_ID = '" + vESTIMATE_ID + "' \n");
			sbSql.append( "   AND USE_YN = 'Y' \n");
out_vl.add("fa_Sql", sbSql.toString());					
			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();
			rs.next();
			sESTID = rs.getString("EST_ID");
			rs.close();
			pstmt.close();
			//Master 삭제
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FROM PO_ESTIMATE_MASTER      \n");
			sbSql.append(" WHERE EST_ID = '" + sESTID + "'      \n");
out_vl.add("fa_Sql", sbSql.toString());					
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
			//DETAIL 삭제
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FROM PO_ESTIMATE_DETAIL      \n");
			sbSql.append(" WHERE EST_ID = '" + sESTID + "'      \n");
out_vl.add("fa_Sql", sbSql.toString());					
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
			//신규 ID 생성
//			sESTID = "";
//			sbSql.delete(0, sbSql.length());
//			sbSql.append( "SELECT EST_ID_S.NEXTVAL AS EST_ID \n");
//			sbSql.append( "  FROM DUAL  \n");
//out_vl.add("fa_Sql", sbSql.toString());					
//			pstmt = conn.prepareStatement(sbSql.toString());
//			rs = pstmt.executeQuery();
//      	rs.next();
//			sESTID = rs.getString("EST_ID");
//			rs.close();
//			pstmt.close();
			
			//시작
			sbSql.delete(0, sbSql.length());
			sbSql.append( "INSERT INTO PO_ESTIMATE_MASTER  \n");
			sbSql.append( "     ( EST_ID                   \n");
			sbSql.append( "     , CENTER_CODE              \n");
			sbSql.append( "     , CUSTCD                   \n");
			sbSql.append( "     , ESTIMATE_START           \n");
			sbSql.append( "     , ESTIMATE_ID              \n");
			sbSql.append( "     , ESTIMATE_STATUS          \n");
			sbSql.append( "     , REMARK                   \n");
			sbSql.append( "     , USE_YN                   \n");
			sbSql.append( "     , CREATE_DATE              \n");
			sbSql.append( "     , CREATE_BY                \n");
			sbSql.append( "     , UPDATE_DATE              \n");
			sbSql.append( "     , UPDATE_BY ) VALUES       \n");
			sbSql.append("      ( '" + sESTID + "'		   \n");
			sbSql.append("      , '" + vCENTER_CODE + "'   \n");
			sbSql.append("      , '" + vCUSTCD + "'		   \n");
			sbSql.append("      , '" + vESTIMATE_START + "'\n");
			sbSql.append("      , '" + vESTIMATE_ID + "'   \n");
			sbSql.append("      , '저장'					   \n");
			sbSql.append("      , '" + vREMARK + "'		   \n");
			sbSql.append("      , 'Y'		               \n");
			sbSql.append("      , SYSDATE		           \n");
			sbSql.append("      , '" + g_EmpNo + "'		   \n");
			sbSql.append("      , SYSDATE		           \n");
			sbSql.append("      , '" + g_EmpNo + "'        \n");
			sbSql.append("      )                          \n");
out_vl.add("fa_Sql", sbSql.toString());  		         
		    pstmt = conn.prepareStatement(sbSql.toString());
		    pstmt.executeUpdate();
			pstmt.close();
	        
			for ( int i = 0 ; i < ds_list.getRowCount() ; i++ )
	        {
				//시작
				sbSql.delete(0, sbSql.length());
				sbSql.append( "INSERT INTO PO_ESTIMATE_DETAIL  												\n");
				sbSql.append( "     ( EST_ID                   												\n");
				sbSql.append( "     , ITEM_CODE              												\n");
				sbSql.append( "     , ESTIMATE_PRICE                   										\n");
				sbSql.append( "     , USE_YN           														\n");
				sbSql.append( "     , CREATE_DATE              												\n");
				sbSql.append( "     , CREATE_BY                												\n");
				sbSql.append( "     , UPDATE_DATE              												\n");
				sbSql.append( "     , UPDATE_BY ) VALUES       												\n");
				sbSql.append("      ( '" + sESTID + "'		   												\n");
				sbSql.append("      , '" + nullToBlank(ds_list.getString(i, "ITEM_CODE")) + "'      \n");
				sbSql.append("      , '" + nullToBlank(ds_list.getString(i, "ESTIMATE_PRICE")) + "' \n");
				sbSql.append("      , 'Y'		               												\n");
				sbSql.append("      , SYSDATE		           												\n");
				sbSql.append("      , '" + g_EmpNo + "'		   												\n");
				sbSql.append("      , SYSDATE		           												\n");
				sbSql.append("      , '" + g_EmpNo + "'		   												\n");
				sbSql.append("      )						   												\n");
out_vl.add("fa_Sql", sbSql.toString());  		         
			    pstmt = conn.prepareStatement(sbSql.toString());
			    pstmt.executeUpdate();
				pstmt.close();
	        }
		}
		else
		{	
			//견적 ID 생성
			sbSql.delete(0, sbSql.length());
	        sbSql.append("SELECT '"+vESTIMATE_START+"'||'-'||'"+vCUSTCD+"'||'-'||TRIM(TO_CHAR(PO_CONTRACT_F_S.NEXTVAL,'000')) AS ESTIMATE_ID  \n");
	        sbSql.append("  FROM DUAL                                                             \n");
out_vl.add("fa_Sql", sbSql.toString());					
			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();
			rs.next();
			sESTIMATE_ID = rs.getString("ESTIMATE_ID");
			rs.close();
			pstmt.close();
			//신규 ID 생성
			sESTID = "";
			sbSql.delete(0, sbSql.length());
			sbSql.append( "SELECT EST_ID_S.NEXTVAL AS EST_ID \n");
			sbSql.append( "  FROM DUAL  \n");
out_vl.add("fa_Sql", sbSql.toString());					
			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();
			rs.next();
			sESTID = rs.getString("EST_ID");
			rs.close();
			pstmt.close();
			//시작
			sbSql.delete(0, sbSql.length());
			sbSql.append( "INSERT INTO PO_ESTIMATE_MASTER  \n");
			sbSql.append( "     ( EST_ID                   \n");
			sbSql.append( "     , CENTER_CODE              \n");
			sbSql.append( "     , CUSTCD                   \n");
			sbSql.append( "     , ESTIMATE_START           \n");
			sbSql.append( "     , ESTIMATE_ID              \n");
			sbSql.append( "     , ESTIMATE_STATUS          \n");
			sbSql.append( "     , REMARK                   \n");
			sbSql.append( "     , USE_YN                   \n");
			sbSql.append( "     , CREATE_DATE              \n");
			sbSql.append( "     , CREATE_BY                \n");
			sbSql.append( "     , UPDATE_DATE              \n");
			sbSql.append( "     , UPDATE_BY ) VALUES       \n");
			sbSql.append("      ( '" + sESTID + "'		   \n");
			sbSql.append("      , '" + vCENTER_CODE + "'   \n");
			sbSql.append("      , '" + vCUSTCD + "'		   \n");
			sbSql.append("      , '" + vESTIMATE_START + "'\n");
			sbSql.append("      , '" + sESTIMATE_ID + "'   \n");
			sbSql.append("      , '저장'					   \n");
			sbSql.append("      , '" + vREMARK + "'		   \n");
			sbSql.append("      , 'Y'		               \n");
			sbSql.append("      , SYSDATE		           \n");
			sbSql.append("      , '" + g_EmpNo + "'		   \n");
			sbSql.append("      , SYSDATE		           \n");
			sbSql.append("      , '" + g_EmpNo + "'		   \n");
			sbSql.append("      )						   \n");
out_vl.add("fa_Sql", sbSql.toString());  		         
		    pstmt = conn.prepareStatement(sbSql.toString());
		    pstmt.executeUpdate();
			pstmt.close();
	        
			for ( int i = 0 ; i < ds_list.getRowCount() ; i++ )
	        {
				//시작
				sbSql.delete(0, sbSql.length());
				sbSql.append( "INSERT INTO PO_ESTIMATE_DETAIL  												\n");
				sbSql.append( "     ( EST_ID                   												\n");
				sbSql.append( "     , ITEM_CODE              												\n");
				sbSql.append( "     , ESTIMATE_PRICE                   										\n");
				sbSql.append( "     , USE_YN           														\n");
				sbSql.append( "     , CREATE_DATE              												\n");
				sbSql.append( "     , CREATE_BY                												\n");
				sbSql.append( "     , UPDATE_DATE              												\n");
				sbSql.append( "     , UPDATE_BY ) VALUES       												\n");
				sbSql.append("      ( '" + sESTID + "'		   												\n");
				sbSql.append("      , '" + nullToBlank(ds_list.getString(i, "ITEM_CODE")) + "'      \n");
				sbSql.append("      , '" + nullToBlank(ds_list.getString(i, "ESTIMATE_PRICE")) + "' \n");
				sbSql.append("      , 'Y'		               												\n");
				sbSql.append("      , SYSDATE		           												\n");
				sbSql.append("      , '" + g_EmpNo + "'		   												\n");
				sbSql.append("      , SYSDATE		           												\n");
				sbSql.append("      , '" + g_EmpNo + "'		   												\n");
				sbSql.append("      )						   												\n");
out_vl.add("fa_Sql", sbSql.toString());  		         
			    pstmt = conn.prepareStatement(sbSql.toString());
			    pstmt.executeUpdate();
				pstmt.close();
	        }
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
