<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/노무관리
■ 프로그램ID   : FMO00790E_T002.jsp
■ 프로그램명   : 직원관리 저장
■ 작성일자     : 2012.08.26
■ 작성자       : 문형광
■ 이력관리     : [고도화]_암복호화 관련 수정_김경은
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
		
		String g_Upjang         = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo          = nullToBlank(in_vl.getString("g_EmpNo"));
		String sUpjang          = nullToBlank(in_vl.getString("sUpjang"));
		
	    //out 데이타
		StringBuffer sbSql = new StringBuffer();
	    //그리드 상태값
		int sRowStatus;
		
		this.accessWriteLog(pageContext, new Object[]{"ADDR_INFO"});
		
		for ( int i = 0 ; i < ds_List.getRowCount() ; i++ )
        {
			sbSql.delete(0, sbSql.length());
			sRowStatus = ds_List.getRowType(i);
			
			if (sRowStatus == DataSet.ROW_TYPE_NORMAL)
			{
				continue;
			}
			else if (sRowStatus == DataSet.ROW_TYPE_INSERTED)
			{	
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FMO_PERSONAL          \n");
		        sbSql.append("     ( SABUN                      \n");
		        sbSql.append("     , UPJANG                     \n");
		        sbSql.append("     , WORK_GB                    \n");
		        sbSql.append("     , REG_GB                     \n");
		        sbSql.append("     , JUMINNO_ENC                \n");
		        sbSql.append("     , NM_KOR                     \n");
		        sbSql.append("     , SEX                        \n");
		        sbSql.append("     , ADDR1                      \n");
		        sbSql.append("     , ADDR2_ENC                  \n");
		        sbSql.append("     , ADDR_GUBUN                 \n");
		        sbSql.append("     , ZIP                        \n");
		        sbSql.append("     , TEL_ENC                    \n");
		        sbSql.append("     , M_TEL_ENC                  \n");
		        sbSql.append("     , JIK_MU                     \n");
		        sbSql.append("     , PER_DTC                    \n");
		        sbSql.append("     , WORK_TMA                   \n");
		        sbSql.append("     , WORK_TMB                   \n");
		        sbSql.append("     , WORK_TMC                   \n");
		        sbSql.append("     , CONTRACT_GB                \n");
		        sbSql.append("     , PAY_GB                     \n");
		        sbSql.append("     , WORK_SDT                   \n");
		        sbSql.append("     , WORK_EDT                   \n");
		        sbSql.append("     , BANK_A                     \n");
		        sbSql.append("     , BANK_B                     \n");
		        sbSql.append("     , BANK_C_ENC                 \n");
		        sbSql.append("     , REMARK                     \n");
		        sbSql.append("     , CUSER                      \n");
		        sbSql.append("     , CDATE                      \n");
		        sbSql.append("     , UUSER                      \n");
		        sbSql.append("     , UDATE            		    \n");
		        sbSql.append("     , ADDR_KEY            		\n");		        
		        sbSql.append("     ) VALUES                     \n");
		        //sbSql.append("     ( '" + nullToBlank(sUpjang) + "'||FMO_PERSONAL_S.NEXTVAL    \n");
		        //sbSql.append("     , '" + nullToBlank(sUpjang) + "'                            \n");
		        sbSql.append("     ( '" + nullToBlank(ds_List.getString(i, "UPJANG")) + "'||FMO_PERSONAL_S.NEXTVAL    \n");
		        sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "UPJANG")) + "'                            \n");
		        sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "WORK_GB")) + "'    \n");
		        sbSql.append("     , 'N'													   \n");
		        sbSql.append("     , SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_List.getString(i, "JUMINNO")) + "', '')    \n");
		        sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "NM_KOR")) + "'     \n");
		        sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "SEX")) + "'        \n");
		        sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "ADDR1")) + "'      \n");
		        sbSql.append("     , SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_List.getString(i, "ADDR2")) + "', '')      \n");
		        sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "ADDR_GUBUN")) + "' \n");
		        sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "ZIP")) + "'        \n");
		        sbSql.append("     , SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_List.getString(i, "TEL")) + "', '')        \n");
		        sbSql.append("     , SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_List.getString(i, "M_TEL")) + "', '')      \n");
		        sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "JIK_MU")) + "'     \n");
		        sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "PER_DTC")) + "'    \n");
		        sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "WORK_TMA")) + "'   \n");
		        sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "WORK_TMB")) + "'   \n");
		        sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "WORK_TMC")) + "'   \n");
		        sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "CONTRACT_GB")) + "'\n");
		        sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "PAY_GB")) + "'     \n");
		        sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "WORK_SDT")) + "'   \n");
		        sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "WORK_EDT")) + "'   \n");
		        sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "BANK_A")) + "'     \n");
		        sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "BANK_B")) + "'     \n");
		        sbSql.append("     , SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_List.getString(i, "BANK_C")) + "', '')     \n");
		        sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "REMARK")) + "'     \n");
		        sbSql.append("     , '" + g_EmpNo + "'                          	           \n");
		        sbSql.append("     , SYSDATE                   								   \n");
		        sbSql.append("     , '" + g_EmpNo + "'                          			   \n");
		        sbSql.append("     , SYSDATE                  								   \n");
		        sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "ADDR_KEY")) + "'   \n");
		        sbSql.append("     )                  										   \n");
		        
				out_vl.add("fa_Sql", sbSql.toString());		
				
				pstmt = conn.prepareStatement(sbSql.toString());
				rs = pstmt.executeQuery();
				pstmt.close();	
				rs.close();
				
				sbSql.delete(0, sbSql.length());
				
		     	// IN
				sbSql.append("   call SCC_ADDR_PRO('" + nullToBlank(ds_List.getString(i, "ADDR_INFO")) + "', '" + g_EmpNo + "')              \n");
		     
				out_vl.add("fa_Sql", sbSql.toString());
				//System.out.println(sbSql.toString());
				pstmt = conn.prepareStatement(sbSql.toString());		
				rs = pstmt.executeQuery();
				
				pstmt.close();
				rs.close();
				
				
			}
			else if (sRowStatus == DataSet.ROW_TYPE_UPDATED)
			{
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FMO_PERSONAL                                                                                   \n");
		        sbSql.append("   SET WORK_GB     = '" + nullToBlank(ds_List.getString(i, "WORK_GB")) + "'                           \n");
		        sbSql.append("     , JUMINNO_ENC = SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_List.getString(i, "JUMINNO")) + "', '') \n");
		        sbSql.append("     , SEX         = '" + nullToBlank(ds_List.getString(i, "SEX")) + "'                               \n");
		        sbSql.append("     , ADDR1       = '" + nullToBlank(ds_List.getString(i, "ADDR1")) + "'                             \n");
		        sbSql.append("     , ADDR2_ENC   = SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_List.getString(i, "ADDR2")) + "', '')   \n");
		        sbSql.append("     , ADDR_GUBUN  = '" + nullToBlank(ds_List.getString(i, "ADDR_GUBUN")) + "'                        \n");
		        sbSql.append("     , ZIP         = '" + nullToBlank(ds_List.getString(i, "ZIP")) + "'                               \n");
		        sbSql.append("     , TEL_ENC     = SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_List.getString(i, "TEL")) + "', '')     \n");
		        sbSql.append("     , M_TEL_ENC   = SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_List.getString(i, "M_TEL")) + "', '')   \n");
		        sbSql.append("     , JIK_MU      = '" + nullToBlank(ds_List.getString(i, "JIK_MU")) + "'                            \n");
		        sbSql.append("     , PER_DTC     = '" + nullToBlank(ds_List.getString(i, "PER_DTC")) + "'                           \n");
		        sbSql.append("     , WORK_TMA    = '" + nullToBlank(ds_List.getString(i, "WORK_TMA")) + "'                          \n");
		        sbSql.append("     , WORK_TMB    = '" + nullToBlank(ds_List.getString(i, "WORK_TMB")) + "'                          \n");
		        sbSql.append("     , WORK_TMC    = '" + nullToBlank(ds_List.getString(i, "WORK_TMC")) + "'                          \n");
		        sbSql.append("     , CONTRACT_GB = '" + nullToBlank(ds_List.getString(i, "CONTRACT_GB")) + "'                       \n");
		        sbSql.append("     , PAY_GB      = '" + nullToBlank(ds_List.getString(i, "PAY_GB")) + "'                            \n");
		        sbSql.append("     , WORK_SDT    = '" + nullToBlank(ds_List.getString(i, "WORK_SDT")) + "'                          \n");
		        sbSql.append("     , WORK_EDT    = '" + nullToBlank(ds_List.getString(i, "WORK_EDT")) + "'                          \n");
		        sbSql.append("     , BANK_A      = '" + nullToBlank(ds_List.getString(i, "BANK_A")) + "'                            \n");
		        sbSql.append("     , BANK_B      = '" + nullToBlank(ds_List.getString(i, "BANK_B")) + "'                            \n");
		        sbSql.append("     , BANK_C_ENC  = SC_CRYPTO_FUN('ENC', '" + nullToBlank(ds_List.getString(i, "BANK_C")) + "', '')  \n");
		        sbSql.append("     , REMARK      = '" + nullToBlank(ds_List.getString(i, "REMARK")) + "'                            \n");
		        sbSql.append("     , UUSER       = '" + g_EmpNo + "'                                                                \n");
		        sbSql.append("     , UDATE       = SYSDATE        		                                                            \n");
		        sbSql.append("     , ADDR_KEY 	 = '" + nullToBlank(ds_List.getString(i, "ADDR_KEY")) + "'                          \n");
		        sbSql.append(" WHERE UPJANG      = '" + nullToBlank(ds_List.getString(i, "UPJANG")) + "'                                                   \n");
		        sbSql.append("   AND SABUN       =  '" + nullToBlank(ds_List.getString(i, "SABUN")) + "'                            \n");
				
		        out_vl.add("fa_Sql", sbSql.toString());		
				
				pstmt = conn.prepareStatement(sbSql.toString());
				rs = pstmt.executeQuery();
				pstmt.close();	
				rs.close();
				
				sbSql.delete(0, sbSql.length());
				
		     	// IN
				sbSql.append("   call SCC_ADDR_PRO('" + nullToBlank(ds_List.getString(i, "ADDR_INFO")) + "', '" + g_EmpNo + "')              \n");
		     
				out_vl.add("fa_Sql", sbSql.toString());
				//System.out.println(sbSql.toString());
				pstmt = conn.prepareStatement(sbSql.toString());		
				rs = pstmt.executeQuery();
				
				pstmt.close();
				rs.close();
			}
        }
		
		
		
		//삭제
		for ( int i = 0 ; i < ds_List.getRemovedRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("\n\n");
			sbSql.append("UPDATE FMO_PERSONAL                                      \n");
	        sbSql.append("   SET WORK_GB = '003'                                   \n");
	        sbSql.append(" WHERE UPJANG = '" + nullToBlank(ds_List.getString(i, "UPJANG")) + "'           \n");
	        sbSql.append("   AND SABUN =  '"+ds_List.getRemovedData(i,"SABUN")+"'  \n");
   			sbSql.append("\n\n");
			
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}
		
		//종료
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