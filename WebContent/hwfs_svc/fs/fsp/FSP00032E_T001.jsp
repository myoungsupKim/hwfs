
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
		
		DataSet ds_condi  	= in_dl.get("ds_condi");
		
		String TYPE	        = ds_condi.getString(0, "TYPE");
		String PO_TYPE	    = ds_condi.getString(0, "PO_TYPE");
		String UPJANG		= ds_condi.getString(0, "PR_UPJANG");
		String SORT_TYPE	= ds_condi.getString(0, "SORT_TYPE");
		String SUBINV_CODE	= nullToBlank(ds_condi.getString(0, "SUBINV_CODE"));
		
		DataSet ds_out;
		StringBuffer sbSelSql = new StringBuffer();
	
		sbSelSql.delete(0, sbSelSql.length());
		
		sbSelSql.append("SELECT A.SUBINV_CODE                                                  \n");
		sbSelSql.append("     , A.SUBINV_NAME||' '||REPLACE(B.UPJANGNM,'단체급식 ') SUBINV_NAME \n");
		sbSelSql.append("  FROM HLDC_PO_SUBINVENTORY A                                         \n");
		sbSelSql.append("     , ST_UPJANG B                                                    \n");
		sbSelSql.append(" WHERE A.UPJANG = B.UPJANG                                            \n");
		sbSelSql.append("   AND A.USE_YN = 'Y'                                                 \n");
		if(PO_TYPE.equals("11"))
		{
			sbSelSql.append("   AND A.WH_CLS_CD = 'AA'                          \n");
		}
		else if(PO_TYPE.equals("88"))
		{
			//FC본사 오레노는 매점창고 사용 AA조건 추가 2018.01.24 김호석
			sbSelSql.append("   AND (A.WH_CLS_CD IN ('A0','AA'))  AND A.SPECIAL_SALES_YN = 'N'                        \n"); //SPECIAL_SALES_YN -특판 창고 제외
			
		}
		else
		{
			sbSelSql.append("   AND WH_CLS_CD = 'C0'                          \n");		
		}
		sbSelSql.append("   AND B.UPJANG = '" + UPJANG + "'                                    \n");
		// 신규와 취소 재작성이 아닐경우 (수정일경우)
		if(!SUBINV_CODE.equals("") && !TYPE.equals("CANCEL_UPDATE"))
			sbSelSql.append("   AND A.SUBINV_CODE = '" + SUBINV_CODE + "'                      \n");
		sbSelSql.append(" ORDER BY " + SORT_TYPE + "                                           \n");

		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSelSql.toString());
		
		DataSet ds_subinv = this.makeDataSet(rs,"ds_out");
		out_dl.add(ds_subinv);
		
	   	this.setResultMessage(0, "OK",out_vl);
		
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