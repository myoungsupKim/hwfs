<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/노무관리
■ 프로그램ID   : FMO00780V_T001.jsp
■ 프로그램명   : 월급여내역서 조회
■ 작성일자     : 2012.08.21
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
		
		
		//In 데이타
		DataSet ds_Cond  	    = in_dl.get("ds_Cond");
		
		String vDate			= nullToBlank(ds_Cond.getString(0, "DATE"));
		//String vDateF           = nullToBlank(ds_Cond.getString(0, "DATE")) + "01";
		//String vDateT           = nullToBlank(ds_Cond.getString(0, "DATE")) + "31";
		String upjang			= nullToBlank(ds_Cond.getString(0, "UPJANG"));
		String p_MaskAuth       = nullToBlank(in_vl.getString("p_MaskAuth"));
		String g_PersInfoMask   = nullToBlank(in_vl.getString("g_PersInfoMask"));
		
	    //out 데이타
		DataSet ds_List;
		
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.delete(0,sbSql.length());

        sbSql.append("SELECT C.UPJANG,                                                                                                                                                  \n");
        sbSql.append("       C.UPJANGNM_DISP,                                                                                                                                           \n");
        sbSql.append("       A.SABUN,                                                                                                                                                   \n");
        sbSql.append("       SCC_CRYPTO.MASKAUTH_FUN(D.NM_KOR, 12, '"+g_PersInfoMask+"', '"+p_MaskAuth+"') AS NM_KOR,                                                                   \n");
        sbSql.append("       A.PAY_GB,                                                                                                                                                  \n");
        sbSql.append("       A.PAY_AMT + NVL(A.REG_PAY,0) + NVL(B.ADD_PAY,0) + NVL(B.OUT_PAY,0) PAY_AMT,                                                                                \n");
        sbSql.append("       A.PAY_AMT - (NVL(B.MED_INS,0) + NVL(B.NAT_PES,0) + NVL(B.EMP_INS,0) + NVL(B.ACC_INS,0)) + NVL(A.REG_PAY,0) + NVL(B.ADD_PAY,0) + NVL(B.OUT_PAY,0) REAL_PAY, \n");
        sbSql.append("       0 AS OT_PAY,                                                                                                                                               \n");
        sbSql.append("       NVL(B.MED_INS + B.NAT_PES + B.EMP_INS + B.ACC_INS,0) AS INS_CHA,                                                                                           \n");
        sbSql.append("       NVL(A.REG_PAY,0) REG_PAY,                                                                                                                                  \n");
        sbSql.append("       NVL(B.ADD_PAY,0) ADD_PAY,                                                                                                                                  \n");
        sbSql.append("       NVL(B.OUT_PAY,0) OUT_PAY,                                                                                                                                  \n");
        sbSql.append("       0 WORK_TMC,                                                                                                                                                \n");
        sbSql.append("       0 OTHH,                                                                                                                                                    \n");
        sbSql.append("       0 NIGHT_OTHH,                                                                                                                                              \n");
        sbSql.append("       0 HOLI                                                                                                                                                     \n");
        sbSql.append("  FROM FMO_PAY A, (SELECT * FROM FMO_CHARGE WHERE DU_MONTH='"+vDate+"') B, FMS_UPJANG C, FMO_PERSONAL D                                                           \n");
        sbSql.append(" WHERE 1=1                                                                                                                                                        \n");
        sbSql.append(" AND A.SABUN = B.SABUN(+)                                                                                                                                         \n");
        sbSql.append(" AND A.SABUN = D.SABUN                                                                                                                                            \n");
        sbSql.append(" AND A.UPJANG = C.UPJANG                                                                                                                                          \n");
        sbSql.append(" AND A.UPJANG = '"+upjang+"'                                                                                                                                      \n");
        sbSql.append(" AND '"+vDate+"' BETWEEN SUBSTR(A.WORK_SDT,0,6) AND SUBSTR(A.WORK_EDT,0,6)                                                                                        \n");
        sbSql.append(" AND A.PAY_GB = '001'                                                                                                                                             \n");
        sbSql.append(" UNION ALL                                                                                                                                                        \n");
        sbSql.append("SELECT C.UPJANG,                                                                                                                                                  \n");
        sbSql.append("       C.UPJANGNM_DISP,                                                                                                                                           \n");
        sbSql.append("       A.SABUN,                                                                                                                                                   \n");
        sbSql.append("       SCC_CRYPTO.MASKAUTH_FUN(D.NM_KOR, 12, '"+g_PersInfoMask+"', '"+p_MaskAuth+"') AS NM_KOR,                                                                   \n");
        sbSql.append("       A.PAY_GB,                                                                                                                                                  \n");
        sbSql.append("       SUM((A.PAY_AMT*E.WORK_TMC)+(E.OTHH+E.NIGHT_OTHH+E.HOLI)*A.PAY_AMT*1.5) PAY_AMT,                                                                            \n");
        sbSql.append("       SUM((A.PAY_AMT*E.WORK_TMC)+(E.OTHH+E.NIGHT_OTHH+E.HOLI)*A.PAY_AMT*1.5) REAL_PAY,                                                                           \n");
        sbSql.append("       SUM((E.OTHH+E.NIGHT_OTHH+E.HOLI)*A.PAY_AMT*1.5) OT_PAY,                                                                                                    \n");
        sbSql.append("       SUM(0) INS_CHA,                                                                                                                                            \n");
        sbSql.append("       SUM(0) REG_PAY,                                                                                                                                            \n");
        sbSql.append("       SUM(0) ADD_PAY,                                                                                                                                            \n");
        sbSql.append("       SUM(0) OUT_PAY,                                                                                                                                            \n");
        sbSql.append("       SUM(E.WORK_TMC) WORK_TMC,                                                                                                                                  \n");
        sbSql.append("       SUM(E.OTHH) OTHH,                                                                                                                                          \n");
        sbSql.append("       SUM(E.NIGHT_OTHH) NIGHT_OTHH,                                                                                                                              \n");
        sbSql.append("       SUM(E.HOLI) HOLI                                                                                                                                           \n");
        sbSql.append("       --E.DL_DATE                                                                                                                                                \n");
        sbSql.append("  FROM FMO_PAY A, (SELECT * FROM FMO_CHARGE WHERE DU_MONTH='"+vDate+"') B, FMS_UPJANG C, FMO_PERSONAL D, FMO_KUNTAE E                                             \n");
        sbSql.append(" WHERE 1=1                                                                                                                                                        \n");
        sbSql.append(" AND A.SABUN = B.SABUN(+)                                                                                                                                         \n");
        sbSql.append(" AND A.SABUN = D.SABUN                                                                                                                                            \n");
        sbSql.append(" AND A.SABUN = E.SABUN(+)                                                                                                                                         \n");
        sbSql.append(" AND A.UPJANG = C.UPJANG                                                                                                                                          \n");
        sbSql.append(" AND A.UPJANG = '"+upjang+"'                                                                                                                                      \n");
        sbSql.append(" AND '"+vDate+"' BETWEEN SUBSTR(A.WORK_SDT,0,6) AND SUBSTR(A.WORK_EDT,0,6)                                                                                        \n");
        sbSql.append(" AND E.DL_DATE LIKE '"+vDate+"%'                                                                                                                                  \n");
        sbSql.append(" AND A.PAY_GB = '002'                                                                                                                                             \n");
        sbSql.append(" GROUP BY C.UPJANG, C.UPJANGNM_DISP, A.SABUN, D.NM_KOR, A.PAY_GB                                                                                                  \n");

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