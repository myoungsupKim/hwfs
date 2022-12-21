<%
/*-----------------------------------------------------------------------------
■ 시스템명	   : 구매관리/구매신청/구매신청상세조회
■ 프로그램ID   : FSP00032E_T009.jsp
■ 프로그램명   : 구매신청(구매신청상세조회)
■ 작성일자	   : 2015-06-01
■ 작성자	   : 정영철
■ 이력관리	   : 2015-06-01
-----------------------------------------------------------------------------*/
%>
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

		DataSet ds_condi_detail = in_dl.get("ds_condi_detail");

		String PR_NUM      = nullToBlank(ds_condi_detail.getString(0, "PR_NUM"));
		String DATE_TYPE   = nullToBlank(ds_condi_detail.getString(0, "DATE_TYPE"));
		String DT_FR       = nullToBlank(ds_condi_detail.getString(0, "DT_FR"));
		String DT_TO       = nullToBlank(ds_condi_detail.getString(0, "DT_TO"));
		String CUSTCD      = nullToBlank(ds_condi_detail.getString(0, "CUSTCD"));
		String SUBINV_CODE = nullToBlank(ds_condi_detail.getString(0, "SUBINV_CODE"));
		String RC_DEPT_ID  = nullToBlank(ds_condi_detail.getString(0, "RC_DEPT_ID"));
		String LINE_STATUS = nullToBlank(ds_condi_detail.getString(0, "LINE_STATUS"));
		String CHK_CUST    = nullToBlank(ds_condi_detail.getString(0, "CHK_CUST"));
		String CHK_DEPT    = nullToBlank(ds_condi_detail.getString(0, "CHK_DEPT"));
		String CHK_STATUS  = nullToBlank(ds_condi_detail.getString(0, "CHK_STATUS"));
		String NEED_DATE  = nullToBlank(ds_condi_detail.getString(0, "NEED_DATE"));

		DataSet ds_detail;
		StringBuffer sbSelSql = new StringBuffer();

		sbSelSql.delete(0, sbSelSql.length());

		sbSelSql.append("\n SELECT A.ITEM_CODE                       AS ITEM_CODE 		/* 자재코드 */");
		sbSelSql.append("\n      , A.ITEM_NAME                       AS ITEM_NAME 		/* 자재명   */");
		sbSelSql.append("\n      , A.ITEM_SIZE                       AS ITEM_SIZE		/*  규격    */");
		//PB_YN을 계약에서 가져옴 (2015.08.29) 
		sbSelSql.append("\n      , FN_ITEM_FEATURE_ICON(FSI_DUTY_ITEM_YN(A.CENTER_CODE, A.CUSTCD, A.ITEM_CODE, A.NEED_DATE), TRIM(G.PB_YN), TRIM(F.ECO_ITEM), TRIM(F.MANUF_CD)) AS FEATURE_NAME	/* 자재특성 */");
		sbSelSql.append("\n      , A.PR_SABUN                        AS PR_SABUN		/* 신청자사번 */");
		sbSelSql.append("\n      , A.PO_UOM                          AS PO_UOM			/*  */");
		sbSelSql.append("\n      , A.TAX_CODE                        AS TAX_CODE		/* 과세코드 */");
		sbSelSql.append("\n      , A.PR_REMARK                       AS PR_REMARK		/* 비고 */");
		sbSelSql.append("\n      , A.NEED_DATE                       AS NEED_DATE		/* 입고예정일 */");
		sbSelSql.append("\n      , A.MARGIN_PRICE                    AS MARGIN_PRICE	/* 관리단가 */");
		sbSelSql.append("\n      , A.PR_QTY                          AS PR_QTY			/* 구매신청개수 */");
		//sbSelSql.append("\n      , (SELECT PO_QTY FROM HLDC_PO_PO IA WHERE IA.LINE_STATUS <> 'PD' AND IA.PO_ID = A.PR_ID ) AS PO_QTY"			);
		//PR_ID, PR_NUM으로 JOIN이 가능한지 검토필요 
		sbSelSql.append("\n      , CASE WHEN (SELECT /*+ LEADING(IA.PODT) USE_NL(IA.PODT IA.POHD) */ COUNT(1) FROM HLDC_PO_PO IA WHERE IA.PO_ID = A.PR_ID ) > 1");
		sbSelSql.append("\n             THEN (SELECT /*+ LEADING(IA.PODT) USE_NL(IA.PODT IA.POHD) */ PO_QTY FROM HLDC_PO_PO IA WHERE IA.LINE_STATUS <> 'PD' AND IA.PO_ID = A.PR_ID )");
		sbSelSql.append("\n             ELSE (SELECT /*+ LEADING(IA.PODT) USE_NL(IA.PODT IA.POHD) */ PO_QTY FROM HLDC_PO_PO IA WHERE IA.PO_ID = A.PR_ID )");
		sbSelSql.append("\n        END  AS PO_QTY										/* 실구매신청개수 */");
		sbSelSql.append("\n      , (A.MARGIN_PRICE * A.PR_QTY)       AS PR_AMT			/* 구매신청가격 */");
		sbSelSql.append("\n      , A.SUBINV_CODE||' '||B.SUBINV_NAME AS SUBINV_NAME		/* 창고코드||창고명 */");
		sbSelSql.append("\n      , D.MU_NM||' '||D.CC_NM             AS CC_NM			/* 사업부코드||부서코드 */");
		sbSelSql.append("\n      , A.PR_ID                           AS PR_ID			/* 구매신청ID */");
		sbSelSql.append("\n      , A.APPROVE_NUM                     AS APPROVE_NUM 	/* 승인번호 */");
		sbSelSql.append("\n      , A.SUBINV_CODE                     AS SUBINV_CODE		/* 창고코드 */");
		sbSelSql.append("\n      , A.PR_DATE                         AS PR_DATE			/* 신청일자 */");
		sbSelSql.append("\n      , A.PO_TYPE                         AS PO_TYPE			/* 구매유형 */");
		sbSelSql.append("\n      , 'N'                               AS DML				/*  */");
		//sbSelSql.append("\n		, CASE A.LINE_STATUS WHEN '002' THEN (SELECT IA.LINE_STATUS FROM HLDC_PO_PO IA WHERE IA.LINE_STATUS <> 'PD' AND IA.PO_ID = A.PR_ID )");
		//sbSelSql.append("\n		                     ELSE A.LINE_STATUS "				);
		//sbSelSql.append("\n		                     END LINE_STATUS"					);
		//PR_ID, PR_NUM으로 JOIN이 가능한지 검토필요
		sbSelSql.append("\n	  	, CASE A.LINE_STATUS WHEN '002' ");
		sbSelSql.append("\n        THEN CASE WHEN (SELECT /*+ LEADING(IA.PODT) USE_NL(IA.PODT IA.POHD) */ COUNT(1) FROM HLDC_PO_PO IA WHERE IA.PO_ID = A.PR_ID ) > 1");
		sbSelSql.append("\n                  THEN (SELECT /*+ LEADING(IA.PODT) USE_NL(IA.PODT IA.POHD) */ IA.LINE_STATUS FROM HLDC_PO_PO IA WHERE IA.LINE_STATUS <> 'PD' AND IA.PO_ID = A.PR_ID )");
		sbSelSql.append("\n                  ELSE (SELECT /*+ LEADING(IA.PODT) USE_NL(IA.PODT IA.POHD) */ IA.LINE_STATUS FROM HLDC_PO_PO IA WHERE IA.PO_ID = A.PR_ID )");
		sbSelSql.append("\n             END");
		sbSelSql.append("\n            ELSE A.LINE_STATUS");
		sbSelSql.append("\n            END LINE_STATUS									/* 구매진행상황코드 */");
		sbSelSql.append("\n      , E.VD_NM                          AS CUSTNM			/* 거래처명 */");
		// [속도개선 Project 시작] 2017. 12. 06. 김호석 담당MD 추가		
		sbSelSql.append("\n     ,(SELECT MAX(DD.USR_NM)   ");
		sbSelSql.append("\n				FROM EPROCUSR.ESPINFO AA  ");
		sbSelSql.append("\n     			LEFT OUTER JOIN EPROCUSR.ESMVDOG BB ON AA.SYS_ID = BB.SYS_ID AND AA.COMP_CD = BB.COMP_CD AND AA.VD_SN = BB.VD_SN "); 
		sbSelSql.append("\n     											    AND BB.OPER_ORG_SN = '414' --FC부문만  ");
		sbSelSql.append("\n     			INNER JOIN EPROCUSR.ESPSWHC CC ON AA.SYS_ID = CC.SYS_ID AND AA.COMP_CD = CC.COMP_CD AND AA.PURC_OPER_ORG_SN = CC.OPER_ORG_SN_PURC "); 
		sbSelSql.append("\n     		  	INNER JOIN EPROCUSR.ESAUSER DD ON DD.SYS_ID = '100' AND DD.COMP_CD = 'HFC' AND BB.HFC_CHR_ID = DD.USR_ID  AND DD.STS <> 'D' ");
		sbSelSql.append("\n     					WHERE AA.SYS_ID = '100' AND AA.COMP_CD = 'HFC' AND :NEED_DATE BETWEEN AA.APPLY_SD AND AA.APPLY_ED  --계약 기간 "); 
		sbSelSql.append("\n     						   AND AA.STS <> 'D' --AND SUBSTR(AA.ITEM_CD, 0 , 1) = 'F' --식자재만 "); 
		sbSelSql.append("\n     					       AND BB.VD_SN = A.VD_SN --AND A.CUSTCD = BB.ERP_VD_CD  ");
		sbSelSql.append("\n     					       AND AA.ITEM_CD = A.ITEM_CODE ");
		sbSelSql.append("\n    							   AND CC.WH_CNTR_CD = G.CENTER_CODE ");
		sbSelSql.append("\n       ) AS MD_NAME	/*담당MD*/ ");
		// [속도개선 Project 끝] 2017. 12. 06. 김호석 담당MD 추가
		sbSelSql.append("\n      , NVL(");
		sbSelSql.append("\n            (");
		sbSelSql.append("\n             SELECT DISTINCT 'Y'");
		sbSelSql.append("\n               FROM HLDC_PO_SUBINVENTORY X ");
		sbSelSql.append("\n              WHERE X.UPJANG = A.RC_UPJANG ");
		sbSelSql.append("\n                AND OUTVAT_FLAG = 'Y' ");
		sbSelSql.append("\n             ),'N')                       AS SCHOOL_YN		/* 거래처가 학교인지 여부 */");
		sbSelSql.append("\n      , A.ORG_PR_NUM                      AS ORG_PR_NUM		/* 오리지날 PR_NUM */");
		sbSelSql.append("\n      , A.PR_NUM                          AS PR_NUM			/* PR_NUM */");
		sbSelSql.append("\n      , A.RC_UPJANG                       AS RC_UPJANG		/* 구매신청업장 */");
		sbSelSql.append("\n      , (SELECT IA.UPJANGNM  FROM ST_UPJANG IA WHERE IA.UPJANG  = A.RC_UPJANG) AS RC_UPJANG_NM	/* 구매신청업장명 */");
		sbSelSql.append("\n      , F.IMG_YN												/* 이미지여부 */");
		sbSelSql.append("\n      , NVL(H.D_DAYS,0) + 1 AS D_DAY           ");
		sbSelSql.append("\n   FROM SO_PR A");
		sbSelSql.append("\n      , HLDC_PO_SUBINVENTORY B");
		sbSelSql.append("\n      , HLDC_SC_DEPT_V D");
		sbSelSql.append("\n      , VO_FC_VENDOR E ");
		sbSelSql.append("\n      , HLDC_PO_ITEM_MST F ");
		sbSelSql.append("\n      , HLDC_PO_CONTRACT_F G ");
		sbSelSql.append("\n      , HLDC_PO_PREORDER_LIST H ");
		sbSelSql.append("\n  WHERE A.RC_DEPT_ID  = D.DEPT_ID ");
		sbSelSql.append("\n    AND TO_CHAR(A.CUSTCD)      = E.VD_CD     (+)");
		sbSelSql.append("\n    AND A.SUBINV_CODE = B.SUBINV_CODE");
		sbSelSql.append("\n    AND A.ITEM_CODE   = F.ITEM_CODE (+)");
		sbSelSql.append("\n    AND A.ITEM_CODE   = G.ITEM_CODE (+)");
		sbSelSql.append("\n    AND G.CENTER_CODE = H.CENTER_CODE(+)                                                                                        ");                                                        
		sbSelSql.append("\n    AND G.ITEM_CODE   = H.ITEM_CODE  (+)    																					 ");
		sbSelSql.append("\n    AND A.RC_UPJANG   = G.UPJANG    (+)");
		sbSelSql.append("\n    AND A.NEED_DATE   BETWEEN G.CONTRACT_START(+) AND G.CONTRACT_END(+)");
		//sbSelSql.append("\n    AND A.SUBINV_CODE = '" + SUBINV_CODE + "'");
		//sbSelSql.append("\n    AND A.ORG_PR_NUM  = '" + PR_NUM + "' ");
		
		sbSelSql.append("\n    AND A.SUBINV_CODE = :SUBINV_CODE ");
		sbSelSql.append("\n    AND A.ORG_PR_NUM  = :PR_NUM ");
		
		// 입고일 선택시
		if (DATE_TYPE.equals("1"))
			//sbSelSql.append("\n    AND A.NEED_DATE BETWEEN '" + DT_FR + "' AND '" + DT_TO + "' ");
			sbSelSql.append("\n    AND A.NEED_DATE BETWEEN :DT_FR AND :DT_TO ");
		
		// 거래처별조회 체크박스 체크시
		if (CHK_CUST.equals("Y")) {
			if (CUSTCD.equals(""))
				sbSelSql.append("\n    AND A.CUSTCD      IS NULL ");
			else
				//sbSelSql.append("\n    AND A.CUSTCD      = '" + CUSTCD + "' ");
				sbSelSql.append("\n    AND A.CUSTCD      = :CUSTCD ");
		}
		
		// 검수부서별조회 체크박스 체크시
		if (CHK_DEPT.equals("Y"))
			//sbSelSql.append("\n    AND A.RC_DEPT_ID  = " + RC_DEPT_ID + " ");
			sbSelSql.append("\n    AND A.RC_DEPT_ID  = :RC_DEPT_ID ");
		
		// 진행상황별조회 체크박스 체크시
		if (CHK_STATUS.equals("Y"))
			//sbSelSql.append("\n    AND A.LINE_STATUS = '" + LINE_STATUS + "' ");
			sbSelSql.append("\n    AND A.LINE_STATUS = :LINE_STATUS ");
		
		// 취소건이면 취소재작성된건만 필터
		if (LINE_STATUS.equals("003"))
		{
			sbSelSql.append("\n    AND A.LINE_STATUS     <>'999'        ");
		// 취소건이 아니면 취소된건 취소재작성건 둘다 필터
		}
		else
		{
			sbSelSql.append("\n    AND A.LINE_STATUS     NOT IN('999')        ");
		}

		sbSelSql.append(" ORDER BY A.ITEM_CODE                              \n");

		//////
		//stmt = conn.createStatement();		
		//rs = stmt.executeQuery(sbSelSql.toString());
		////
		// [속도개선 Project 시작] 2017. 12. 06. 김호석 쿼리 변수 바인딩기능 추가
				
        npstmt = new NamedParameterStatement(conn, sbSelSql.toString());

        npstmt.setString("NEED_DATE", NEED_DATE);
        npstmt.setString("SUBINV_CODE", SUBINV_CODE);
        npstmt.setString("PR_NUM", PR_NUM);
        if (DATE_TYPE.equals("1")) npstmt.setString("DT_FR", DT_FR);
        if (DATE_TYPE.equals("1")) npstmt.setString("DT_TO", DT_TO);
        if (CHK_CUST.equals("Y")) {
			if (!CUSTCD.equals("")) {
				npstmt.setString("CUSTCD", CUSTCD);
			}
        }
        if (CHK_DEPT.equals("Y")) npstmt.setString("RC_DEPT_ID", RC_DEPT_ID);
        if (CHK_STATUS.equals("Y")) npstmt.setString("LINE_STATUS", LINE_STATUS);
                
        rs = npstmt.executeQuery();
     	// [속도개선 Project 끝] 2017. 12. 06. 김호석 쿼리 변수 바인딩기능 추가

		ds_detail = this.makeDataSet(rs, "ds_detail");

		rs.close();
		npstmt.close();
		//stmt.close();

		out_dl.add(ds_detail);

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
		if (npstmt != null) {
			try {
				npstmt.close();
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
