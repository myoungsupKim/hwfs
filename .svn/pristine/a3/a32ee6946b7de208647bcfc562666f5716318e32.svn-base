<%  
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/여신 예외 업장(주문단계에서만 예외처리)
■ 프로그램ID   : FMP00080E_T003_2.jsp
■ 프로그램명   : 여신확인 제외 업장 확인
■ 작성일자     : 2017.04.20
■ 작성자       : kihoon
■ 이력관리     : 2017.04.20
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

// [속도개선 Project 시작] 2017. 8. 28. 최범주 쿼리 변수 바인딩기능 추가
		int upjang       = Integer.parseInt(in_vl.getString("upjang"));
		StringBuffer sbSql = new StringBuffer();
				        
		sbSql.setLength(0);
		sbSql.append(" /* fm/fmp/FMP00080E_T003_2.jsp */                                                        \n");
		sbSql.append(" SELECT 'Y' EXCEPT_YN                                                            			\n");
		sbSql.append("		FROM   SCC_COMMON_CODE A                                                   			\n");
		sbSql.append("		WHERE  A.GROUP_CODE = '여신체크제외업장'                                   			\n");
		sbSql.append("		AND A.USE_YN = 'Y'                                                         			\n");
		sbSql.append("		AND CODE = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = :upjang)              \n");

		out_vl.add("fa_Sql", "");
		
		DataSet ds_list; 
        npstmt = new NamedParameterStatement(conn, sbSql.toString());
        npstmt.setInt("upjang", upjang);
        rs = npstmt.executeQuery();
	    
		ds_list = this.makeDataSet(rs, "ds_checkExceptCredit");
		
        npstmt.close();
        rs.close();
        sbSql.setLength(0);
// [속도개선 Project 시작] 2017. 8. 28. 최범주
     
	    out_dl.add(ds_list);
		this.setResultMessage(0, "OK", out_vl);    
	}
	catch(Exception ex)
	{
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
// [속도개선 Project 시작] 2017. 8. 28. 최범주 쿼리 변수 바인딩기능 추가
        if (npstmt != null) {
            try {
                npstmt.close();
            } catch (Exception e) {
            }
        }
// [속도개선 Project 시작] 2017. 8. 28. 최범주		
		if(conn != null) {
			try {
				conn.close();
			}catch(Exception e) {}
		}
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}		
	}

	proc_output(response,out,out_vl,out_dl);

%>
