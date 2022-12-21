<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/노무관리
■ 프로그램ID   : FMO00770V_T001.jsp
■ 프로그램명   : 근태집계현황 조회
■ 작성일자     : 2012.08.21
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
		
		//In 데이타
		DataSet ds_Cond  	    = in_dl.get("ds_Cond");
		
	    //out 데이타
		DataSet ds_List;
		
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.delete(0,sbSql.length());
        sbSql.append("SELECT A.UPJANG                                                 \n");
        sbSql.append("     , B.UPJANGNM_DISP                                          \n");
        sbSql.append("     , A.SABUN                                                  \n");
        sbSql.append("     , C.NM_KOR                                                 \n");
        sbSql.append("     , SUM(DECODE(A.DL_GB, '001', 1, 0)) AS WORK                \n");
        sbSql.append("     , SUM(DECODE(A.DL_GB, '002', 1, 0)) AS PAY                 \n");
        sbSql.append("     , SUM(DECODE(A.DL_GB, '003', 1, 0)) AS NOPAY               \n");
        sbSql.append("     , SUM(DECODE(A.DL_GB, '004', 1, 0)) AS SICK                \n");
        sbSql.append("     , SUM(DECODE(A.DL_GB, '005', 1, 0)) AS VAC                 \n");
        sbSql.append("  FROM FMO_KUNTAE A, FMS_UPJANG B, FMO_PERSONAL C \n");
        sbSql.append(" WHERE A.UPJANG = B.UPJANG                                      \n");
        sbSql.append("   AND A.SABUN = C.SABUN                                        \n");
        sbSql.append("   AND A.DL_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "DATEF")) + "' AND '" + nullToBlank(ds_Cond.getString(0, "DATET")) + "' \n");
        sbSql.append("   AND B.MAIN_UPJANG = '" + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + "'  															 \n");
        sbSql.append("   AND C.REG_GB = 'N'                                                                                      \n");
        if (! nullToBlank(ds_Cond.getString(0, "UPJANG")).equals(""))
            sbSql.append("   AND A.UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "'                                     \n");
        sbSql.append(" GROUP BY A.UPJANG , B.UPJANGNM_DISP , A.SABUN , C.NM_KOR                                                                                                    \n");
        sbSql.append(" ORDER BY A.UPJANG                                                                                                    \n");
out_vl.add("fa_Sql", sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery();
		
		ds_List = this.makeDataSet(rs,"ds_List");
		
		out_dl.add(ds_List);
		//FileLog.println("c:\\ds_stock.txt",ds_stock);			
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
//			if(stmt != null) {
//				try {
//					stmt.close();
//				}catch(Exception e) {}
//			}
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