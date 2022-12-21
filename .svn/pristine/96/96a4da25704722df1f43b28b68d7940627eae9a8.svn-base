<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 
■ 프로그램ID   : FMO00800E_T002.jsp
■ 프로그램명   : 근태관리
■ 작성일자     : 2012-08-30
■ 작성자       : 박용대
■ 이력관리     : 2012-08-30 최초작성
				 [고도화]_암복호화 관련 수정_김경은
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	//리퀘스트 객체
	PlatformRequest platformRequest = this.proc_input(request);

	in_vl = platformRequest.getData().getVariableList();	//파라미터 받는 객체
	in_dl = platformRequest.getData().getDataSetList();	//데이터셋 받는 객체
	
	//입력 데이타셋
	DataSet ds_list   = in_dl.get("inds_List");

	//입력 파라미터
	String g_EmpNo    = nullToBlank(in_vl.getString("g_EmpNo"));
	
	//FileLog.println("d:\\aaa.txt", ds_cond);
	this.accessWriteLog(pageContext, new Object[]{"ADDR_INFO"});
	
	try
	{
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		int sRowStatus;
		String checkFlag	= "";
		
		this.accessWriteLog(pageContext, new Object[]{"ADDR_INFO, TEL_NO, HP_NO"});
		
		//입력,수정
		for ( int i = 0 ; i < ds_list.getRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());
			sRowStatus = ds_list.getRowType(i);
			if (sRowStatus == DataSet.ROW_TYPE_NORMAL)
			{
				continue;
			}
			else if (sRowStatus == DataSet.ROW_TYPE_INSERTED)
			{
				sbSql.delete(0, sbSql.length());
				
				sbSql.append("\n\n");
		        sbSql.append("INSERT INTO FMO_PERSONAL(   \n");
		        sbSql.append("    SABUN,                  \n");
		        sbSql.append("    UPJANG,                 \n");
		        sbSql.append("    NM_KOR,                 \n");
		        sbSql.append("    JUMINNO_ENC,            \n");
		        sbSql.append("    SEX,                    \n");
		        sbSql.append("    WORK_GB,                \n");
		        sbSql.append("    ZIP,                    \n");
		        sbSql.append("    ADDR1,                  \n");
		        sbSql.append("    ADDR2_ENC,              \n");
		        sbSql.append("    ADDR_GUBUN,             \n");
		        sbSql.append("    TEL_ENC,                \n");
		        sbSql.append("    M_TEL_ENC,              \n");
		        sbSql.append("    NATION,                 \n");
		        sbSql.append("    REMARK,                 \n");
		        sbSql.append("    COMP_NM,                \n");
		        sbSql.append("    COMP_TEL,               \n");
		        sbSql.append("    REG_GB,                 \n");
		        sbSql.append("    CUSER,                  \n");
		        sbSql.append("    CDATE,                  \n");
		        sbSql.append("    UUSER,                  \n");
		        sbSql.append("    UDATE,                  \n");
		        sbSql.append("    ADDR_KEY           	  \n");
		        sbSql.append(")VALUES(                    \n");
		        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"SABUN"))+"',\n");
		        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"UPJANG"))+"',\n");
		        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"NAME"))+"',\n");
		        sbSql.append("    SC_CRYPTO_FUN('ENC', '"+nullToBlank(ds_list.getString(i,"JUMINNO"))+"', ''),\n");
		        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"SEX"))+"',\n");
		        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"WORK_GB"))+"',\n");
		        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"ZIP"))+"',\n");
		        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"ADDR1"))+"',\n");
		        sbSql.append("    SC_CRYPTO_FUN('ENC', '"+nullToBlank(ds_list.getString(i,"ADDR2"))+"', ''),\n");
		        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"ADDR_GUBUN"))+"',\n");
		        sbSql.append("    SC_CRYPTO_FUN('ENC', '"+nullToBlank(ds_list.getString(i,"TEL"))+"', ''),\n");
		        sbSql.append("    SC_CRYPTO_FUN('ENC', '"+nullToBlank(ds_list.getString(i,"M_TEL"))+"', ''),\n");
		        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"NATION"))+"',\n");
		        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"REMARK"))+"',\n");
		        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"COMP_NM"))+"',\n");
		        sbSql.append("    '"+nullToBlank(ds_list.getString(i,"COMP_TEL"))+"',\n");
		        sbSql.append("    'Y',\n");
		        sbSql.append("    '"+g_EmpNo+"',                                                          \n");
		        sbSql.append("    SYSDATE,              \n");
		        sbSql.append("    '"+g_EmpNo+"',                                                          \n");
		        sbSql.append("    SYSDATE,               \n");
		        sbSql.append("    '" + nullToBlank(ds_list.getString(i, "ADDR_KEY")) + "'   \n");
		        sbSql.append(")                           \n");
		        sbSql.append("\n\n");
			
				out_vl.add("fa_Sql", sbSql.toString());		
				
				pstmt = conn.prepareStatement(sbSql.toString());
				rs = pstmt.executeQuery();
				pstmt.close();	
				rs.close();
				
				sbSql.delete(0, sbSql.length());
				
		     	// IN
				sbSql.append("   call SCC_ADDR_PRO('" + nullToBlank(ds_list.getString(i, "ADDR_INFO")) + "', '" + g_EmpNo + "')              \n");
		     
				out_vl.add("fa_Sql", sbSql.toString());
				//System.out.println(sbSql.toString());
				pstmt = conn.prepareStatement(sbSql.toString());		
				rs = pstmt.executeQuery();
				
				pstmt.close();
				rs.close();
			}else if (sRowStatus == DataSet.ROW_TYPE_UPDATED)
			{
				sbSql.delete(0, sbSql.length());
				
				sbSql.append("\n\n");
		        sbSql.append("UPDATE FMO_PERSONAL          \n");
		        sbSql.append("   SET SABUN = '"		+nullToBlank(ds_list.getString(i,"SABUN"))+"',     \n");
		        //sbSql.append("       UPJANG = '"	+nullToBlank(ds_list.getString(i,"UPJANG"))+"',      \n");
		        sbSql.append("       NM_KOR = '"	+nullToBlank(ds_list.getString(i,"NAME"))+"',  \n");
		        sbSql.append("       JUMINNO_ENC = SC_CRYPTO_FUN('ENC', '"	+nullToBlank(ds_list.getString(i,"JUMINNO"))+"', ''),  \n");
		        sbSql.append("       SEX = '"		+nullToBlank(ds_list.getString(i,"SEX"))+"',  \n");
		        sbSql.append("       WORK_GB = '"	+nullToBlank(ds_list.getString(i,"WORK_GB"))+"',  \n");
		        sbSql.append("       ZIP = '"		+nullToBlank(ds_list.getString(i,"ZIP"))+"',  \n");
		        sbSql.append("       ADDR1 = '"		+nullToBlank(ds_list.getString(i,"ADDR1"))+"',  \n");
		        sbSql.append("       ADDR2_ENC = SC_CRYPTO_FUN('ENC', '"		+nullToBlank(ds_list.getString(i,"ADDR2"))+"', ''),  \n");
		        sbSql.append("       ADDR_GUBUN = '"+nullToBlank(ds_list.getString(i,"ADDR_GUBUN"))+"',  \n");
		        sbSql.append("       TEL_ENC = SC_CRYPTO_FUN('ENC', '"		+nullToBlank(ds_list.getString(i,"TEL"))+"', ''),  \n");
		        sbSql.append("       M_TEL_ENC = SC_CRYPTO_FUN('ENC', '"		+nullToBlank(ds_list.getString(i,"M_TEL"))+"', ''),  \n");
		        sbSql.append("       NATION = '"	+nullToBlank(ds_list.getString(i,"NATION"))+"',  \n");
		        sbSql.append("       COMP_NM = '"	+nullToBlank(ds_list.getString(i,"COMP_NM"))+"',  \n");		        
		        sbSql.append("       COMP_TEL = '"	+nullToBlank(ds_list.getString(i,"COMP_TEL"))+"',  \n");
		        sbSql.append("       REMARK = '"	+nullToBlank(ds_list.getString(i,"REMARK"))+"',  \n");
		        sbSql.append("       UUSER = '"+g_EmpNo+"',     \n");
		        sbSql.append("       UDATE = SYSDATE,           \n");
		        sbSql.append("       ADDR_KEY 	 = '" + nullToBlank(ds_list.getString(i, "ADDR_KEY")) + "'                          \n");
		        sbSql.append(" WHERE 1 = 1               \n");
		        sbSql.append(" AND SABUN = '"		+nullToBlank(ds_list.getString(i,"SABUN"))+"'   \n");
		        sbSql.append("\n\n");

				out_vl.add("fa_Sql", sbSql.toString());		
				
				pstmt = conn.prepareStatement(sbSql.toString());
				rs = pstmt.executeQuery();
				pstmt.close();	
				rs.close();
				
				sbSql.delete(0, sbSql.length());
				
		     	// IN
				sbSql.append("   call SCC_ADDR_PRO('" + nullToBlank(ds_list.getString(i, "ADDR_INFO")) + "', '" + g_EmpNo + "')              \n");
		     
				out_vl.add("fa_Sql", sbSql.toString());
				//System.out.println(sbSql.toString());
				pstmt = conn.prepareStatement(sbSql.toString());		
				rs = pstmt.executeQuery();
				
				pstmt.close();
				rs.close();
			}
		}

		//삭제
		for ( int i = 0 ; i < ds_list.getRemovedRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());
			
			sbSql.append("\n\n");
	        sbSql.append("DELETE FROM FMO_PERSONAL   \n");
	        sbSql.append("WHERE SABUN = '"+ds_list.getRemovedData(i,"SABUN")+"'           \n");
	        sbSql.append("\n\n");
			
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}
		
		/**종료**/
		conn.commit();
		out_vl.add("fa_Msg", "");
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		ex.printStackTrace();
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
	}

	proc_output(response,out,out_vl,out_dl);

%>