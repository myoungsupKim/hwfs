<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 폐식용유관리현황조회
■ 프로그램ID   : MAS50040E_S001.jsp
■ 프로그램명   : 폐식용유관리현황조회
■ 작성일자     : 2015-12-18
■ 작성자       : 강대성
■ 이력관리     : 2015-12-23, 김민수, 사용량 현재일자만 집계되는 오류 수정
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log 서비스 시작
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//입력 데이타
		DataSet ds_Cond     = in_dl.get("ds_cond");

		String MU_CD      = nullToBlank(ds_Cond.getString(0, "MU_CD"));
        String TM_CD       = nullToBlank(ds_Cond.getString(0, "TM_CD"));
        String UPJANG    = nullToBlank(ds_Cond.getString(0, "UPJANG"));
        String CUSTCD    = nullToBlank(ds_Cond.getString(0, "CUSTCD"));

		//out 데이타
		DataSet ds_listItemCode;
		DataSet ds_list;
		int RowCnt;

		String strKeyword	= "";

		//sql문 버퍼생성
        StringBuffer sbSql_tmp = new StringBuffer();
        sbSql_tmp.delete(0,sbSql_tmp.length());

        sbSql_tmp.append("SELECT ITEM_CODE FROM HLDC_PO_ITEM_MST WHERE ITEM_CLASS4 = 'F151210' \n");

        out_vl.add("fa_Sql", sbSql_tmp.toString());
        pstmt = conn.prepareStatement(sbSql_tmp.toString());
        rs = pstmt.executeQuery();
        ds_listItemCode = this.makeDataSet(rs, "ds_listItemCode");

        RowCnt = ds_listItemCode.getRowCount();
        int LastRowCnt = RowCnt - 1;

        for (int i=0; i<RowCnt; i++) {
        	strKeyword += "'" + nullToBlank(ds_listItemCode.getString(i,"ITEM_CODE")) + "'";
        	if ( i < LastRowCnt) {
        	        strKeyword += ",";
            }
        }

        rs.close();
        pstmt.close();

        //sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//폐식용유현황관리
		sbSql.append("SELECT A.MU_NM                                                                                                              \n");
		sbSql.append("     , A.TM_NM                                                                                                              \n");
		sbSql.append("     , A.UPJANGNM                                                                                                           \n");
		sbSql.append("     , B.USE_QTY                                                                                                            \n");
		sbSql.append("     , B.OCCUR_QTY                                                                                                          \n");
		sbSql.append("     , B.REMV_QTY                                                                                                           \n");
		sbSql.append("     , (SELECT CUSTNM                                                                                                       \n");
		sbSql.append("          FROM HLDC_ST_CUST                                                                                                 \n");
		sbSql.append("         WHERE CUSTCD = B.CUSTCD) AS CUSTNM                                                                                 \n");
		sbSql.append("     , B.CONTRACT_UNIT                                                                                                      \n");
		sbSql.append("     , B.CONTRACT_AMT                                                                                                       \n");
		sbSql.append("     , B.REMV_AMT                                                                                                           \n");
		sbSql.append("     , B.SAL_AMT                                                                                                            \n");
		sbSql.append("     , B.BAL_AMT                                                                                                            \n");
		sbSql.append("     , DECODE(B.JOURNALZ_YN,'J','Y','N') AS JOURNALZ_YN                                                                     \n");
		sbSql.append("  FROM SCO_UPJANG_MST_V A                                                                                                   \n");
		sbSql.append("     , (                                                                                                                    \n");
		sbSql.append("        SELECT A.UPJANG                                                                                                     \n");
		sbSql.append("             , SUM(ROUND(A.USE_QTY / B.CONTRACT_UNIT, 2)) AS USE_QTY                                                        \n");
		sbSql.append("             , SUM(A.OCCUR_QTY) AS OCCUR_QTY                                                                                \n");
		sbSql.append("             , SUM(A.REMV_QTY) AS REMV_QTY                                                                                  \n");
		sbSql.append("             , SUM(A.REMV_AMT) AS REMV_AMT                                                                                  \n");
		sbSql.append("             , SUM(A.SAL_AMT) AS SAL_AMT                                                                                    \n");
		sbSql.append("             , SUM(A.BAL_AMT) AS BAL_AMT                                                                                    \n");
		sbSql.append("             , MAX(A.JOURNALZ_YN) AS JOURNALZ_YN                                                                            \n");
		sbSql.append("             , MAX(B.CONTRACT_AMT) AS CONTRACT_AMT                                                                          \n");
		sbSql.append("             , MAX(B.CONTRACT_UNIT) AS CONTRACT_UNIT                                                                        \n");
		sbSql.append("             , MAX(B.CUSTCD) AS CUSTCD                                                                                      \n");
		sbSql.append("         FROM  (                                                                                                            \n");
		sbSql.append("                SELECT REG_DD                                                                                               \n");
		sbSql.append("                     , UPJANG                                                                                               \n");
		sbSql.append("                     , SUM(USE_QTY) AS USE_QTY                                                                              \n");
		sbSql.append("                     , SUM(OCCUR_QTY) AS OCCUR_QTY                                                                          \n");
		sbSql.append("                     , SUM(REMV_QTY) AS REMV_QTY                                                                            \n");
		sbSql.append("                     , SUM(REMV_AMT) AS REMV_AMT                                                                            \n");
		sbSql.append("                     , SUM(SAL_AMT) AS SAL_AMT                                                                              \n");
		sbSql.append("                     , SUM(BAL_AMT) AS BAL_AMT                                                                              \n");
		sbSql.append("                     , MAX(JOURNALZ_YN) AS JOURNALZ_YN                                                                      \n");
		sbSql.append("                  FROM (                                                                                                    \n");
		sbSql.append("                        SELECT A.REG_DD                                                                                     \n");
		sbSql.append("                             , TO_CHAR(A.UPJANG) AS UPJANG                                                                  \n");
		sbSql.append("                             , 0 AS USE_QTY                                                                                 \n");
		sbSql.append("                             , A.OCCUR_QTY                                                                                  \n");
		sbSql.append("                             , A.REMV_QTY                                                                                   \n");
		sbSql.append("                             , A.REMV_AMT                                                                                   \n");
		sbSql.append("                             , NVL((SELECT SUM(SAL_AMT)                                                                     \n");
		sbSql.append("                                      FROM SLA_IF_UPJANG_SALS_DETAIL  Z                                                     \n");
		sbSql.append("                                     WHERE Z.RECEIPT_NUM = A.RECEIPT_NUM                                                    \n");
		sbSql.append("                                       AND Z.OCCUR_DATE = A.REG_DD                                                          \n");
		sbSql.append("                                       AND Z.UPJANG_CD = A.UPJANG                                                           \n");
		sbSql.append("                                       AND Z.SYS_CLASS = '19'                                                               \n");
		sbSql.append("                                       AND Z.RECD_STATUS = 'L'), 0) SAL_AMT                                                 \n");
		sbSql.append("                             , NVL((SELECT SUM(AMT)                                                                         \n");
		sbSql.append("                                         FROM SLA_TAX_SHET_OCCUR_OBJ  V                                                     \n");
		sbSql.append("                                        WHERE V.UPJANG_SALS_NUM = (SELECT UPJANG_SALS_NUM                                   \n");
		sbSql.append("                                                                     FROM SLA_IF_UPJANG_SALS_DETAIL  Z                      \n");
		sbSql.append("                                                                    WHERE  Z.RECEIPT_NUM = A.RECEIPT_NUM                    \n");
		sbSql.append("                                                                      AND Z.OCCUR_DATE = A.REG_DD                           \n");
		sbSql.append("                                                                      AND Z.UPJANG_CD = A.UPJANG                            \n");
		sbSql.append("                                                                      AND Z.SYS_CLASS = '19'                                \n");
		sbSql.append("                                                                      AND Z.RECD_STATUS = 'L')                              \n");
		sbSql.append("                                         AND V.RECD_STATUS = 'L'), 0) BAL_AMT                                               \n");
		//2018.04.05 김명섭 중복데이터조회 개선
		//sbSql.append("                             , (SELECT ZZ.JOURNALZ_YN                                                                       \n");
		sbSql.append("                             , (SELECT MAX(ZZ.JOURNALZ_YN)                                                                  \n");
		sbSql.append("                                      FROM SLA_IF_UPJANG_SALS_DETAIL  Z                                                     \n");
		sbSql.append("                                         , SLA_TAX_SHET_OCCUR_OBJ ZZ                                                        \n");
		sbSql.append("                                     WHERE Z.RECEIPT_NUM = A.RECEIPT_NUM                                                    \n");
		sbSql.append("                                       AND Z.OCCUR_DATE = A.REG_DD                                                          \n");
		sbSql.append("                                       AND Z.UPJANG_CD = A.UPJANG                                                           \n");
		sbSql.append("                                       AND Z.UPJANG_SALS_NUM = ZZ.UPJANG_SALS_NUM                                           \n");
		sbSql.append("                                       AND Z.SYS_CLASS = '19'                                                               \n");
		sbSql.append("                                       AND Z.RECD_STATUS = 'L'                                                              \n");
		sbSql.append("                                       AND ZZ.RECD_STATUS = 'L') JOURNALZ_YN                                                \n");
		sbSql.append("                          FROM MAS_DC_OIL_MGMT A                                                                            \n");
		sbSql.append("                         WHERE A.REG_DD BETWEEN '" + ds_Cond.getString(0, "REG_DD_FROM") + "' AND '" + ds_Cond.getString(0, "REG_DD_TO") + "' \n");
		sbSql.append("                        UNION ALL                                                                                           \n");
		//sbSql.append("                        SELECT A.TRANS_DATE                                                                                 \n");
		//sbSql.append("                             , TO_CHAR(A.TRANS_UPJANG)                                                                      \n");
		//sbSql.append("                             , SUM(A.TRANS_QTY) AS TRANS_QTY                                                                \n");
		//sbSql.append("                             , 0                                                                                            \n");
		//sbSql.append("                             , 0                                                                                            \n");
		//sbSql.append("                             , 0                                                                                            \n");
		//sbSql.append("                             , 0                                                                                            \n");
		//sbSql.append("                             , 0                                                                                            \n");
		//sbSql.append("                             , ''                                                                                            \n");

		//sbSql.append("                          FROM HLDC_PO_TRANSACTION_NHASH A                                                                        \n");
		//sbSql.append("                         WHERE A.TRANS_DATE BETWEEN '" + ds_Cond.getString(0, "REG_DD_FROM") + "' AND '" + ds_Cond.getString(0, "REG_DD_TO") + "' \n");
		//sbSql.append("                           AND A.TRANS_TYPE LIKE 'O%'                                                                       \n");
		//sbSql.append("                           AND A.TRANS_TYPE   <>   'O002'                                                                   \n");
		//sbSql.append("                           AND A.ITEM_CODE IN (" + strKeyword + ")                                                          \n");
		//sbSql.append("                         GROUP BY A.TRANS_DATE, A.TRANS_UPJANG                                                              \n");
		sbSql.append("                        SELECT MIHD.INSP_DATE AS JDATE                                                                                \n");
		sbSql.append("                             ,MIHD.SHOP_CD AS UPJANG                                                                       \n");
		sbSql.append("                             , SUM(DECODE(MIDT.CANCEL_YN, 'N', MIDT.GAP_QTY, 0)  ) AS TRANS_QTY                                                               \n");
		sbSql.append("                             , 0                                                                                            \n");
		sbSql.append("                             , 0                                                                                            \n");
		sbSql.append("                             , 0                                                                                            \n");
		sbSql.append("                             , 0                                                                                            \n");
		sbSql.append("                             , 0                                                                                            \n");
		sbSql.append("                             , ''                                                                                            \n"); 
		sbSql.append("  					   FROM EPROCUSR.ESIMIHD MIHD    \n"); 
		sbSql.append("   				     INNER JOIN EPROCUSR.ESIMIDT MIDT    \n");
		sbSql.append("   					         ON MIHD.SYS_ID = MIDT.SYS_ID    \n");
		sbSql.append("     					         AND MIHD.COMP_CD = MIDT.COMP_CD    \n");
		sbSql.append("     				             AND MIHD.IVT_INSP_NO = MIDT.IVT_INSP_NO    \n");
		sbSql.append("    					  INNER JOIN EPROCUSR.ESPSWHU SWHU    \n");
		sbSql.append("    					          ON MIHD.SYS_ID = SWHU.SYS_ID    \n");
		sbSql.append("      				         AND MIHD.COMP_CD = SWHU.COMP_CD    \n");
		sbSql.append("        						 AND MIHD.WH_CD = SWHU.WH_CD    \n");
		sbSql.append("    					  INNER JOIN SCO_UPJANG_MST A    \n");
		sbSql.append("      					      ON TO_NUMBER(SWHU.SHOP_CD) = A.UPJANG    \n");
		sbSql.append("   					  INNER JOIN ST_UPJANG B    \n");
		sbSql.append("    						      ON A.UPJANG = B.UPJANG    \n");
		sbSql.append("   					  INNER JOIN HLDC_SC_DEPT_V C    \n");
		sbSql.append("    						      ON B.DEPT_ID = C.DEPT_ID     \n");
		sbSql.append("  				       WHERE MIHD.SYS_ID = '100'    \n");
		sbSql.append("     				         AND MIHD.COMP_CD = 'HFC'    \n");
		if(!MU_CD.equals("")){
			sbSql.append("					     AND C.MU_CD = '" + MU_CD + "'                                                                                        \n");
		}
		if(!UPJANG.equals("")){
			sbSql.append("  					 AND MIHD.SHOP_CD  = '" + UPJANG + "'                                                                                      \n");
		}
		sbSql.append("                         AND  MIHD.INSP_DATE BETWEEN '" + ds_Cond.getString(0, "REG_DD_FROM") + "' AND '" + ds_Cond.getString(0, "REG_DD_TO") + "' \n");
        sbSql.append("                           AND  MIDT.ITEM_CD IN (" + strKeyword + ")                                                          \n");
		sbSql.append("                        GROUP BY MIHD.INSP_DATE ,MIHD.SHOP_CD                                                              \n");						
		sbSql.append("                        ) A                                                                                                 \n");
		sbSql.append("                  GROUP BY REG_DD, UPJANG                                                                                   \n");
		sbSql.append("               ) A                                                                                                          \n");
		sbSql.append("             , (                                                                                                            \n");
		sbSql.append("                SELECT A.UPJANG                                                                                             \n");
		sbSql.append("                     , B.CUSTCD                                                                                             \n");
		sbSql.append("                     , B.CONTRACT_TERM_START                                                                                \n");
		sbSql.append("                     , B.CONTRACT_TERM_END                                                                                  \n");
		sbSql.append("                     , B.CONTRACT_UNIT                                                                                      \n");
		sbSql.append("                     , B.CONTRACT_AMT                                                                                       \n");
		sbSql.append("                  FROM MAS_DC_OIL_UPJANG A                                                                                  \n");
		sbSql.append("                     , MAS_DC_OIL_REMV_VENDOR B                                                                             \n");
		sbSql.append("                 WHERE A.CUSTCD = B.CUSTCD                                                                                  \n");
		sbSql.append("                   AND A.CONTRACT_DD = B.CONTRACT_DD                                                                        \n");
		sbSql.append("               ) B                                                                                                          \n");
		sbSql.append("         WHERE A.UPJANG = B.UPJANG                                                                                          \n");
		sbSql.append("         GROUP BY A.UPJANG                                                                                                  \n");
		sbSql.append("       ) B                                                                                                                  \n");
		sbSql.append(" WHERE A.UPJANG = B.UPJANG(+)                                                                                               \n");
		sbSql.append("   AND A.CLOSE_DATE IS NULL                                                                                                 \n");
		sbSql.append("   AND B.UPJANG IS NOT NULL                                                                                                 \n");
		if(!MU_CD.equals("")){
			sbSql.append("   AND A.MU_CD = '" + MU_CD + "'                                                                                        \n");
		}
		if(!TM_CD.equals("")){
			sbSql.append("   AND (A.TM_CD = '" + TM_CD + "'  OR A.PT_CD = '" + TM_CD + "' )                                                       \n");
		}
		if(!UPJANG.equals("")){
			sbSql.append("   AND A.UPJANG = '" + UPJANG + "'                                                                                      \n");
		}
		if(!CUSTCD.equals("")){
			sbSql.append("   AND B.CUSTCD = '" + CUSTCD + "'                                                                                      \n");
		}
		sbSql.append(" ORDER BY A.MU_NM, A.TM_NM, A.UPJANGNM                                                                                      \n");

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_list = this.makeDataSet(rs, "ds_list");

		pstmt.close();
		rs.close();

		/**종료**/
		out_dl.add(ds_list);
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
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