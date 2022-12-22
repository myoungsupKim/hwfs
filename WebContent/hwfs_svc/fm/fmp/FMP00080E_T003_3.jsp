<%  
/*-----------------------------------------------------------------------------
■ 시스템명     : 상품발주(브랜드) 내 냉동상품 낱개발주 권한 체크 
■ 프로그램ID   : FMP00080E_T003_3.jsp
■ 프로그램명   : 상품발주(브랜드)
■ 작성일자     : 2022.01.18
■ 작성자       : 
■ 이력관리     : 2022.01.18
-----------------------------------------------------------------------------*/
%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//int sabun = Integer.parseInt(in_vl.getString("sabun"));
		String sabun = in_vl.getString("sabun");
		StringBuffer sbSql = new StringBuffer();
				        
		sbSql.setLength(0);
		sbSql.append(" /* fm/fmp/FMP00080E_T003_3.jsp */                                                        \n");
		sbSql.append(" SELECT 'Y' FROZEN_YN                                                            			\n");
		sbSql.append("		FROM   SCC_COMMON_CODE A                                                   			\n");
		sbSql.append("		WHERE GROUP_CODE = 'FROZEN_YN' AND USE_YN = 'Y'                                   	\n");
		sbSql.append("		AND CODE = :sabun                                                         			\n");

		out_vl.add("fa_Sql", "");
		
		DataSet ds_list; 
        npstmt = new NamedParameterStatement(conn, sbSql.toString());
        //npstmt.setInt("sabun", sabun);
        npstmt.setString("sabun", sabun);
        rs = npstmt.executeQuery();
		ds_list = this.makeDataSet(rs, "ds_frozenYn");
		
        npstmt.close();
        rs.close();
        sbSql.setLength(0);
     
	    out_dl.add(ds_list);
		this.setResultMessage(0, "OK", out_vl);    
	}
	catch(Exception ex) {
		logger.debug(ex.getMessage(), ex);		
		this.setResultMessage(-1, ex.toString(),out_vl);
	} finally {
		if (rs != null) { try { rs.close(); } catch(Exception e) {} }
		if (pstmt != null) { try { pstmt.close(); } catch (Exception e) {} }
        if (npstmt != null) { try { npstmt.close(); } catch (Exception e) {} }
		if(conn != null) { try { conn.close(); } catch (Exception e) {} }
		
		try {
			logger.endIndividualLog();
		} catch (Exception logE) {
			logE.printStackTrace();
		}		
	}

	proc_output(response,out,out_vl,out_dl);
%>