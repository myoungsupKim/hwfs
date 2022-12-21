<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="../../sc/main/common.jsp"%>
<%
	Statement stmt = null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log 서비스 시작
		logger.startIndividualLog(in_vl.getString("titLogId"));

		DataSet in_ds = in_dl.get("ds_condi");

		String MU_CD = nullToBlank(in_ds.getString(0, "MU_CD"));
		String TM_CD = nullToBlank(in_ds.getString(0, "TM_CD"));
		String DATE_TYPE = nullToBlank(in_ds.getString(0, "DATE_TYPE"));
		String CHK_CUST = nullToBlank(in_ds.getString(0, "CHK_CUST"));
		String CHK_DEPT = nullToBlank(in_ds.getString(0, "CHK_DEPT"));
		String CHK_STATUS = nullToBlank(in_ds.getString(0, "CHK_STATUS"));
		String DT_FR = nullToBlank(in_ds.getString(0, "DT_FR"));
		String DT_TO = nullToBlank(in_ds.getString(0, "DT_TO"));
		String PO_TYPE = nullToBlank(in_ds.getString(0, "PO_TYPE"));
		String PR_UPJANG = nullToBlank(in_ds.getString(0, "PR_UPJANG"));
		String RC_UPJANG = nullToBlank(in_ds.getString(0, "RC_UPJANG"));
		String PR_SABUN = nullToBlank(in_ds.getString(0, "PR_SABUN"));
		String GROUP_CODE = nullToBlank(in_ds.getString(0, "GROUP_CODE"));

		String g_Mu_Cd = nullToBlank(in_vl.getString("g_Mu_Cd"));

		DataSet ds_master;
		StringBuffer sbSelSql = new StringBuffer();

		sbSelSql.delete(0, sbSelSql.length());

		if (CHK_CUST.equals("Y")) // 거래처별 조회
		{
			sbSelSql.append("\nSELECT A.MOBILE_GUBUN                                                                                                                                                                ");
			sbSelSql.append("\n     , A.ORG_PR_NUM AS PR_NUM                                                                                                                                                        ");
			sbSelSql.append("\n     , A.CUSTCD                                                                                                                                                                      ");
			sbSelSql.append("\n     , G.VD_CD||' '||G.VD_NM CUSTNM                                                                                                                                                  ");
			sbSelSql.append("\n     , A.PR_DATE                                                                                                                                                                     ");
			sbSelSql.append("\n     , B.TM_NM||' '||B.CC_NM CC_NM                                                                                                                                                   ");
			sbSelSql.append("\n     , A.SUBINV_CODE                                                                                                                                                                 ");
			sbSelSql.append("\n     , (SELECT SUBINV_NAME FROM HLDC_PO_SUBINVENTORY WHERE SUBINV_CODE = A.SUBINV_CODE) SUBINV_NAME                                                                                  ");
			sbSelSql.append("\n     , A.ITEM_NAME||DECODE(SIGN(E.CNT - 1),1,' 외 '||TO_CHAR(E.CNT - 1)||'건') AS ITEM_TITLE                                                                                         ");
			sbSelSql.append("\n     , C.TYPE_NAME                                                                                                                                                                   ");
			sbSelSql.append("\n     , E.AMT                                                                                                                                                                         ");
			sbSelSql.append("\n     , E.VAT                                                                                                                                                                         ");
			sbSelSql.append("\n     , (E.AMT + E.VAT) AS TOT                                                                                                                                                        ");
			sbSelSql.append("\n     , NVL((                                                                                                                                                                         ");
			sbSelSql.append("\n         SELECT /*+ LEADING(IA.PODT) USE_NL(IA.PODT IA.POHD) */ MAX(IA.LINE_STATUS) KEEP(DENSE_RANK FIRST ORDER BY DECODE(IA.LINE_STATUS, 'IV', 1, 'GC', 2, 'DL', 3, 'PC', 4, 'PW', 5, 'PD', 6, 'PR', 7, 8) ASC)                     ");
			//sbSelSql.append("\n         SELECT /*+ LEADING(IA.PODT) USE_NL(IA.PODT IA.POHD) */ MAX(IA.LINE_STATUS) KEEP(DENSE_RANK FIRST ORDER BY DECODE(IA.LINE_STATUS, 'IV', 1, 'GC', 2, 'PC', 3, 'DL', 4, 'PW', 5, 'PD', 6, 'PR', 7, 8) ASC)                     ");
			sbSelSql.append("\n           FROM HLDC_PO_PO IA                                                                                                                                                        ");
			sbSelSql.append("\n              , SO_PR      IB                                                                                                                                                        ");
			sbSelSql.append("\n              , SO_PR      IC                                                                                                                                                        ");
			sbSelSql.append("\n          WHERE IA.PO_ID = IB.PR_ID                                                                                                                                                  ");
			sbSelSql.append("\n					AND IA.PO_NUM = IB.PR_NUM                                                                                                                      						");
			sbSelSql.append("\n     			AND IB.PR_NUM = IC.PR_NUM      																																		");
			sbSelSql.append("\n        			AND IB.PR_ID = IC.PR_ID																																				");
			//처음 주문 자재를 모두 삭제 후 자제 추가하면 상태가 발주취소로 보이는 문제 수정(ORG_PR_NUM이 같은 PR_NUM을 모두 가져오도록 수정, 기존 : ORG_PR_NUM과 같은것만 가져와 PR_NUM이 새로 생성된 건이 누락됨)
			//sbSelSql.append("\n            AND IB.PR_NUM = IC.ORG_PR_NUM                                                                                                                                            ");
			sbSelSql.append("\n            AND IC.ORG_PR_NUM = A.ORG_PR_NUM                                                                                                                                         ");
			sbSelSql.append("\n       ), A.LINE_STATUS) AS LINE_STATUS                                                                                                                                              ");
			//sbSelSql.append("\n       ,'DL' AS LINE_STATUS                                                                                                                                              ");
			sbSelSql.append("\n     , A.PR_SABUN||'  '||F.NM_KOR PR_SABUN                                                                                                                                           ");
			sbSelSql.append("\n     , A.PO_TYPE                                                                                                                                                                     ");
			sbSelSql.append("\n     , E.NEED_DATE                                                                                                                                                                   ");
			if (CHK_DEPT.equals("Y"))
				sbSelSql.append("\n     , A.RC_DEPT_ID                                                                                                                                                              ");
			else
				sbSelSql.append("\n     , A.PR_DEPT_ID                                                                                                                                                              ");
			sbSelSql.append("\n     , A.RC_UPJANG                                                                                                                                                                   ");
			sbSelSql.append("\n     , CASE WHEN TO_CHAR(TO_DATE(A.NEED_DATE) - C.D_DAYS + (C.D_TIMES/24), 'YYYYMMDDHH24') <= TO_CHAR(SYSDATE, 'YYYYMMDDHH24') THEN 'Y'                                              ");
			sbSelSql.append("\n            ELSE 'N'                                                                                                                                                                 ");
			sbSelSql.append("\n       END CLOSE_YN                                                                                                                                                                  ");
			
			sbSelSql.append("\n  FROM SO_PR A                                                                                                                                                                       ");
			sbSelSql.append("\n     , HLDC_SC_DEPT_V B                                                                                                                                                              ");
			sbSelSql.append("\n     , HLDC_PO_TYPE_FS C                                                                                                                                                                ");
			sbSelSql.append("\n     , HR_PERSONAL F                                                                                                                                                                 ");
			sbSelSql.append("\n     , VO_FC_VENDOR G                                                                                                                                                                ");
			sbSelSql.append("\n     , (SELECT ORG_PR_NUM                                                                                                                                                            ");
			sbSelSql.append("\n             , CUSTCD                                                                                                                                                                ");
			sbSelSql.append("\n             , MIN(PR_ID) AS PR_ID                                                                                                                                                   ");
			sbSelSql.append("\n             , COUNT(*) AS CNT                                                                                                                                                       ");
			sbSelSql.append("\n             , SUM(MARGIN_PRICE * PR_QTY) AS AMT                                                                                                                                     ");
			sbSelSql.append("\n             , SUM(MARGIN_PRICE * PR_QTY * DECODE(TAX_CODE,100,0.1,0)) AS VAT                                                                                                        ");
			sbSelSql.append("\n             , MIN(NEED_DATE) NEED_DATE                                                                                                                                              ");
			if (CHK_STATUS.equals("Y"))
				sbSelSql.append("\n             , LINE_STATUS                                                                                                                                                       ");
			else
				sbSelSql.append("\n             , MAX(LINE_STATUS) AS LINE_STATUS                                                                                                                                   ");
			sbSelSql.append("\n          FROM SO_PR                                                                                                                                                                 ");
			if (DATE_TYPE.equals("0"))
				sbSelSql.append("\n         WHERE PR_DATE BETWEEN '" + DT_FR + "' AND '" + DT_TO + "'                                                                                                               ");
			else
				sbSelSql.append("\n         WHERE NEED_DATE BETWEEN '" + DT_FR + "' AND '" + DT_TO + "'                                                                                                             ");
			if (!RC_UPJANG.equals("")) {
				sbSelSql.append("\n           AND RC_UPJANG     = '" + RC_UPJANG + "'                                                                                                                               ");
			}
			sbSelSql.append("\n           AND LINE_STATUS <> '999'                                                                                                                                                  ");
			if (CHK_STATUS.equals("Y"))
				sbSelSql.append("\n         GROUP BY ORG_PR_NUM, CUSTCD, LINE_STATUS) E                                                                                                                             ");
			else
				sbSelSql.append("\n         GROUP BY ORG_PR_NUM, CUSTCD) E                                                                                                                                          ");
			if (CHK_DEPT.equals("Y"))
				sbSelSql.append("\n WHERE A.RC_DEPT_ID  = B.DEPT_ID                                                                                                                                                 ");
			else
				sbSelSql.append("\n WHERE A.PR_DEPT_ID  = B.DEPT_ID                                                                                                                                                 ");
			sbSelSql.append("\n   AND A.PO_TYPE     = C.PO_TYPE                                                                                                                                                     ");
			sbSelSql.append("\n   AND A.PR_ID       = E.PR_ID                                                                                                                                                       ");
			sbSelSql.append("\n   AND A.PR_SABUN    = F.SABUN                                                                                                                                                       ");
			sbSelSql.append("\n   AND A.LINE_STATUS <> '999'                                                                                                                                                        ");
			sbSelSql.append("\n   AND A.CUSTCD      = G.VD_CD(+)                                                                                                                                                    ");
			sbSelSql.append("\n   AND B.MU_CD       = '" + MU_CD + "'                                                                                                                                               ");
			if (!TM_CD.equals(""))
				sbSelSql.append("\n   AND B.TM_CD       = '" + TM_CD + "'                                                                                                                                           ");
			if (!PO_TYPE.equals("%"))
				sbSelSql.append("\n   AND A.PO_TYPE     = '" + PO_TYPE + "'                                                                                                                                         ");
			sbSelSql.append("\n ORDER BY A.PR_DATE DESC, A.PR_NUM DESC                                                                                                                                              ");
		} else {
			sbSelSql.append("\n");
			sbSelSql.append("\nSELECT A.MOBILE_GUBUN                                                                                                                                                                ");
			sbSelSql.append("\n     , A.ORG_PR_NUM AS PR_NUM                                                                                                                                                        ");
			sbSelSql.append("\n     , NULL CUSTCD                                                                                                                                                                   ");
			sbSelSql.append("\n     , NULL CUSTNM                                                                                                                                                                   ");
			sbSelSql.append("\n     , A.PR_DATE                                                                                                                                                                     ");
			sbSelSql.append("\n     , B.TM_NM||' '||B.CC_NM CC_NM                                                                                                                                                   ");
			sbSelSql.append("\n     , A.SUBINV_CODE                                                                                                                                                                 ");
			sbSelSql.append("\n     , (SELECT SUBINV_NAME FROM HLDC_PO_SUBINVENTORY WHERE SUBINV_CODE = A.SUBINV_CODE) SUBINV_NAME                                                                                  ");
			sbSelSql.append("\n     , A.ITEM_NAME||DECODE(SIGN(E.CNT - 1),1,' 외 '||TO_CHAR(E.CNT - 1)||'건') AS ITEM_TITLE                                                                                         ");
			sbSelSql.append("\n     , C.TYPE_NAME                                                                                                                                                                   ");
			sbSelSql.append("\n     , E.AMT                                                                                                                                                                         ");
			sbSelSql.append("\n     , E.VAT                                                                                                                                                                         ");
			sbSelSql.append("\n     , (E.AMT + E.VAT) AS TOT                                                                                                                                                        ");
			//최학진 2016.02.04 최학진 통합 영업에서 제일 첫번째 PR_ID를 취소했을 경우 전부다 취소 된거 처럼 보인다.. 그래서 수정
			sbSelSql.append("\n     , NVL((                                                                                                                                                                         ");
			sbSelSql.append("\n         SELECT /*+ LEADING(IA.PODT) USE_NL(IA.PODT IA.POHD) */ MAX(IA.LINE_STATUS) KEEP(DENSE_RANK FIRST ORDER BY DECODE(IA.LINE_STATUS, 'IV', 1, 'GC', 2, 'DL', 3, 'PC', 4, 'PW', 5, 'PD', 6, 'PR', 7, 8) ASC)                     ");
			//sbSelSql.append("\n         SELECT /*+ LEADING(IA.PODT) USE_NL(IA.PODT IA.POHD) */ MAX(IA.LINE_STATUS) KEEP(DENSE_RANK FIRST ORDER BY DECODE(IA.LINE_STATUS, 'IV', 1, 'GC', 2, 'PC', 3, 'DL', 4, 'PW', 5, 'PD', 6, 'PR', 7, 8) ASC)                     ");
			sbSelSql.append("\n           FROM HLDC_PO_PO IA                    ");
			sbSelSql.append("\n              , SO_PR      IB                                                                                                                                                        ");
			sbSelSql.append("\n              , SO_PR      IC                                                                                                                                                        ");
			sbSelSql.append("\n          WHERE IA.PO_ID = IB.PR_ID                                                                                                                                                  ");
			sbSelSql.append("\n					AND IA.PO_NUM = IB.PR_NUM                                                                                                                      						");
			sbSelSql.append("\n     			AND IB.PR_NUM = IC.PR_NUM      																																		");
			sbSelSql.append("\n        			AND IB.PR_ID = IC.PR_ID																																				");			
			//sbSelSql.append("\n            AND IB.PR_NUM = IC.ORG_PR_NUM                                                                                                                                            ");
			sbSelSql.append("\n            AND IC.ORG_PR_NUM = A.ORG_PR_NUM    ");

			//sbSelSql.append("\n          WHERE IA.PO_ID = A.PR_ID                                                                                                                                                   ");
			sbSelSql.append("\n       ), A.LINE_STATUS) AS LINE_STATUS                                                                                                                                              ");
			//sbSelSql.append("\n     , A.LINE_STATUS AS LINE_STATUS                                                                                                                                              ");
			//sbSelSql.append("\n     ,'DL' AS LINE_STATUS                                                                                                                                              ");
			sbSelSql.append("\n     , A.PR_SABUN||'  '||F.NM_KOR PR_SABUN                                                                                                                                           ");
			sbSelSql.append("\n     , A.PO_TYPE                                                                                                                                                                     ");
			sbSelSql.append("\n     , E.NEED_DATE                                                                                                                                                                   ");
			if (CHK_DEPT.equals("Y"))
				sbSelSql.append("\n     , A.RC_DEPT_ID                                                                                                                                                              ");
			else
				sbSelSql.append("\n     , A.PR_DEPT_ID                                                                                                                                                              ");
			sbSelSql.append("\n     , A.RC_UPJANG                                                                                                                                                                   ");
			sbSelSql.append("\n     , CASE WHEN A.PO_TYPE = '11' THEN 																																				");
			sbSelSql.append("\n										CASE WHEN C.D_DAYS = 0 AND C.D_TIMES = 0 THEN 																									");
			sbSelSql.append("\n                                                                                 	CASE WHEN TO_CHAR(TO_DATE(A.NEED_DATE) - C.D_DAYS + (C.D_TIMES/24), 'YYYYMMDD') = TO_CHAR(SYSDATE, 'YYYYMMDD') THEN 'N' END ");
			sbSelSql.append("\n                                                                              ELSE   CASE WHEN TO_CHAR(TO_DATE(A.NEED_DATE) - C.D_DAYS + (C.D_TIMES/24), 'YYYYMMDDHH24') <= TO_CHAR(SYSDATE, 'YYYYMMDDHH24') THEN 'Y' ");
			sbSelSql.append("\n    																																																							ELSE 'N' END ");
			sbSelSql.append("\n                                                                                          END																																			");
			sbSelSql.append("\n            ELSE																																																							");			
			sbSelSql.append("\n      CASE WHEN TO_CHAR(TO_DATE(A.NEED_DATE) - C.D_DAYS + (C.D_TIMES/24), 'YYYYMMDDHH24') <= TO_CHAR(SYSDATE, 'YYYYMMDDHH24') THEN 'Y'                                              ");
			sbSelSql.append("\n            ELSE 'N'  END                                                                                                                                                               ");
			sbSelSql.append("\n       END CLOSE_YN                                                                                                                                                                  ");
						
			sbSelSql.append("\n  FROM SO_PR A                                                                                                                                                                       ");
			sbSelSql.append("\n     , HLDC_SC_DEPT_V B                                                                                                                                                              ");
			sbSelSql.append("\n     , HLDC_PO_TYPE_FS C                                                                                                                                                                ");
			sbSelSql.append("\n     , HR_PERSONAL F                                                                                                                                                                 ");
			sbSelSql.append("\n     , (SELECT MIN(PR_ID) AS PR_ID                                                                                                                                                   ");
			sbSelSql.append("\n             , COUNT(*) AS CNT                                                                                                                                                       ");
			sbSelSql.append("\n             , SUM(MARGIN_PRICE * PR_QTY) AS AMT                                                                                                                                     ");
			sbSelSql.append("\n             , SUM(MARGIN_PRICE * PR_QTY * DECODE(TAX_CODE,100,0.1,0)) AS VAT                                                                                                        ");
			sbSelSql.append("\n             , MIN(NEED_DATE) NEED_DATE                                                                                                                                              ");
			if (CHK_STATUS.equals("Y"))
				sbSelSql.append("\n             , LINE_STATUS                                                                                                                                                       ");
			else	
				//최학진 2016.02.04 최학진 통합 영업에서 제일 첫번째 PR_ID를 취소했을 경우 전부다 취소 된거 처럼 보인다.. 그래서 수정
				sbSelSql.append("\n             , MAX(LINE_STATUS) AS LINE_STATUS                                                                                                                                   ");
				//sbSelSql.append("\n             , MIN(LINE_STATUS) AS LINE_STATUS                                                                                                                                   ");

			sbSelSql.append("\n          FROM SO_PR                                                                                                                                                                 ");

			if (DATE_TYPE.equals("0"))
				sbSelSql.append("\n         WHERE PR_DATE BETWEEN '" + DT_FR + "' AND '" + DT_TO + "'                                                                                                               ");
			else
				sbSelSql.append("\n         WHERE NEED_DATE BETWEEN '" + DT_FR + "' AND '" + DT_TO + "'                                                                                                             ");

			if (!RC_UPJANG.equals("")) {
				sbSelSql.append("\n           AND RC_UPJANG     = '" + RC_UPJANG + "'                                                                                                                               ");
			}
			sbSelSql.append("\n           AND LINE_STATUS <> '999'                                                                                                                                                  ");

			sbSelSql.append("\n         GROUP BY ORG_PR_NUM                                                                                                                                                         ");
			if (CHK_DEPT.equals("Y"))
				sbSelSql.append("\n             , RC_DEPT_ID                                                                                                                                                        ");

			if (CHK_STATUS.equals("Y"))
				sbSelSql.append("\n             , LINE_STATUS                                                                                                                                                       ");

			sbSelSql.append("\n         ) E                                                                                                                                                                         ");

			if (CHK_DEPT.equals("Y"))
				sbSelSql.append("\n WHERE A.RC_DEPT_ID  = B.DEPT_ID                                                                                                                                                 ");
			else
				sbSelSql.append("\n WHERE A.PR_DEPT_ID  = B.DEPT_ID                                                                                                                                                 ");
			sbSelSql.append("\n   AND A.PO_TYPE     = C.PO_TYPE                                                                                                                                                     ");
			sbSelSql.append("\n   AND A.PR_ID       = E.PR_ID                                                                                                                                                       ");
			sbSelSql.append("\n   AND A.PR_SABUN    = F.SABUN                                                                                                                                                       ");
			sbSelSql.append("\n   AND A.LINE_STATUS <> '999'                                                                                                                                                        ");
			sbSelSql.append("\n   AND A.RC_MU_CD    = '" + MU_CD + "'                                                                                                                                               ");
			if (!TM_CD.equals(""))
				sbSelSql.append("\n   AND B.TM_CD       = '" + TM_CD + "'                                                                                                                                           ");
			if (!PO_TYPE.equals("%"))
				sbSelSql.append("\n   AND A.PO_TYPE     = '" + PO_TYPE + "'                                                                                                                                         ");
			sbSelSql.append("\n ORDER BY A.PR_NUM DESC, A.PR_DATE DESC                                                                                                                                              ");
		} 

		stmt = conn.createStatement();
		rs = stmt.executeQuery(sbSelSql.toString());

		ds_master = this.makeDataSet(rs, "ds_master");

		out_dl.add(ds_master);
		this.setResultMessage(0, "OK", out_vl);

	} catch (Exception ex) {
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		this.setResultMessage(-1, ex.toString(), out_vl);
	} finally {
		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
			}
		}
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (Exception e) {
			}
		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (Exception e) {
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
			}
		}
		//jsp log 서비스 닫기
		try {
			logger.endIndividualLog();
		} catch (Exception logE) {
			logE.printStackTrace();
		}
	}

	proc_output(response, out, out_vl, out_dl);
%>