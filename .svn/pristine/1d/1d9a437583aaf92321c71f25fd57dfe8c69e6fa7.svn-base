
<%
	/*-----------------------------------------------------------------------------
	 ■ 시스템명     : 구매관리/구매신청/구매신청서작성/
	 ■ 프로그램ID   : FSP00032E_T007.jsp
	 ■ 프로그램명   : 구매신청(신규)
	 ■ 작성일자     : 2015-07-11
	 ■ 작성자       : 정영철
	 ■ 이력관리     : 2015-07-11
	 - 신청서 신규작성시 로직
	 -----------------------------------------------------------------------------*/
%>
<%@page import="oracle.jdbc.oracore.OracleType"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="../../sc/main/common.jsp"%>

<%
	Statement stmt = null;
	CallableStatement cstmt = null;
	PreparedStatement pstmt1 = null;
	PreparedStatement pstmt2 = null;
	PreparedStatement pstmt3 = null;
	PreparedStatement pstmt4 = null;
	PreparedStatement pstmt5 = null;
	PreparedStatement pstmt6 = null;
	PreparedStatement pstmt7 = null;
	PreparedStatement pstmt8 = null;
	PreparedStatement pstmt9 = null;
	PreparedStatement pstmt10 = null;
	PreparedStatement pstmt11 = null;
	PreparedStatement pstmt12 = null;

	try {
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		// log 서비스 시작
		logger.startIndividualLog(in_vl.getString("titLogId"));

		DataSet ds_pr_item = in_dl.get("ds_pr_item"); // 구매신청자제 데이터셋
		DataSet ds_condi = in_dl.get("ds_condi"); // 조회조건및 필수 파라미터 데이터셋
		DataSet ds_del_item = in_dl.get("ds_del_item");

		String TYPE = nullToBlank(ds_condi.getString(0, "TYPE")); // 신규 & 수정 확정구분자
		String PR_SABUN = nullToBlank(ds_condi.getString(0, "PR_SABUN")); // 구매신청자 사번
		String PR_DEPT_ID = nullToBlank(ds_condi.getString(0, "PR_DEPT_ID")); // 구매신청자 소속 부서
		String PR_UPJANG = nullToBlank(ds_condi.getString(0, "PR_UPJANG")); // 구매신청자 소속 업장
		String PO_TYPE = nullToBlank(ds_condi.getString(0, "PO_TYPE")); // 구매유형
		String RC_UPJANG = nullToBlank(ds_condi.getString(0, "RC_UPJANG")); // 구매신청 업장
		String PR_NUM = nullToBlank(ds_condi.getString(0, "PR_NUM")); // 구매번호(수정일경우에만 넘어옴)
		String PR_DATE = nullToBlank(ds_condi.getString(0, "PR_DATE")); // 신청일자
		String NEED_DATE = nullToBlank(ds_condi.getString(0, "NEED_DATE")); // 입고예정일자
		String SUBINV_CODE = nullToBlank(ds_condi.getString(0, "SUBINV_CODE")); // 창고코드
		String STATUS = nullToBlank(ds_condi.getString(0, "STATUS")); // 확정인지 임시저장인지 구분자
		String REASON_CD = nullToBlank(ds_condi.getString(0, "REASON_CD")); // 사유코드
		String PR_REASON = nullToBlank(ds_condi.getString(0, "PR_REASON")); // 사유상세코드
		String LINE_STATUS = nullToBlank(ds_condi.getString(0, "LINE_STATUS")); // 진행상태

		String MOBILE_GUBUN = nullToBlank(in_vl.getString("p_mobile_gubun")); // 모바일구분값
		
		System.out.println(ds_condi.saveXml());
		System.out.println(ds_pr_item.saveXml());
		System.out.println(ds_del_item.saveXml());

		// 모바일구분값이 공백일 경우 P로 하드코딩
		if (MOBILE_GUBUN.equals("")) {
			MOBILE_GUBUN = "P";
		}

		StringBuffer sbSelSql = new StringBuffer();
		StringBuffer sbInsSql = new StringBuffer();

		String strPrNum;
		// 1 신청번호 생성
		sbSelSql.delete(0, sbSelSql.length());

		sbSelSql.append("SELECT TO_CHAR(SYSDATE,'YYYYMMDD')||'-'||LPAD(SO_PR_NUM_S.NEXTVAL,5,'0') PR_NUM FROM DUAL \n");

		stmt = conn.createStatement();
		rs = stmt.executeQuery(sbSelSql.toString());

		rs.next();

		strPrNum = rs.getString("PR_NUM");

		rs.close();
		stmt.close();

		// 2 구매승인번호 생성
		String strAprNum = "";

		sbSelSql.delete(0, sbSelSql.length());

		sbSelSql.append("SELECT TO_CHAR(SYSDATE,'YYYYMMDD')||'-'||LPAD(SO_PR_APV_NUM_S.NEXTVAL,4,'0') APPROVE_NUM FROM DUAL \n");

		stmt = conn.createStatement();
		rs = stmt.executeQuery(sbSelSql.toString());

		rs.next();

		strAprNum = rs.getString("APPROVE_NUM");

		rs.close();
		stmt.close();

		// 구매유형(구매 프로시져에 넘길 파라미터)
		String strItemtype = "";
		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("SELECT ITEM_TYPE FROM HLDC_PO_TYPE_FS WHERE PO_TYPE = '" + PO_TYPE + "' \n");

		stmt = conn.createStatement();
		rs = stmt.executeQuery(sbSelSql.toString());

		rs.next();

		strItemtype = rs.getString("ITEM_TYPE");

		// 취소 재작성일 경우 기존 신청내역의 진행 상태값을 999로 업데이트
		if (TYPE.equals("CANCEL_UPDATE")) {
			sbInsSql.delete(0, sbInsSql.length());
			sbInsSql.append("UPDATE SO_PR                                   \n");
			sbInsSql.append("   SET LINE_STATUS = '999'                     \n");
			sbInsSql.append("     , UPDATE_DATE = SYSDATE                   \n");
			sbInsSql.append("     , UPDATE_BY   = '" + PR_SABUN + "'        \n");
			sbInsSql.append(" WHERE ORG_PR_NUM  = '" + PR_NUM + "'        \n");
			stmt = conn.createStatement();
			stmt.execute(sbInsSql.toString());

			stmt.close();
			// 식단에 의한 자동발주일경우 삭제자재리스트 상태값을 999로 업데이트
			if (PO_TYPE.equals("04")) {
				sbInsSql.delete(0, sbInsSql.length());
				sbInsSql.append("UPDATE SO_PR_MENU_LOG                      \n");
				sbInsSql.append("   SET LINE_STATUS = '999'                     \n");
				sbInsSql.append("     , UPDATE_DATE = SYSDATE                   \n");
				sbInsSql.append("     , UPDATE_BY   = '" + PR_SABUN + "'        \n");
				sbInsSql.append(" WHERE ORG_PR_NUM  = '" + PR_NUM + "'        \n");
				stmt = conn.createStatement();
				stmt.execute(sbInsSql.toString());

				stmt.close();
			}
			
			//2016.02.18 최학진 취소 재작성일 때 구매 취소 데이터 인터페이스 추가
			cstmt = conn.prepareCall("{call EPROCUSR.SP_IF_SALES_ORDER(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");

			//실행
			cstmt.setString(1, "100");
			cstmt.setString(2, "HFC");
			cstmt.setString(3, "FR");
			cstmt.setString(4, strItemtype);
			cstmt.setString(5, RC_UPJANG);
			cstmt.setString(6, PR_SABUN);
			cstmt.setString(7, PO_TYPE);
			cstmt.setString(8, PR_NUM);
			cstmt.setString(9, "D");
			cstmt.registerOutParameter(10, Types.VARCHAR);
			cstmt.registerOutParameter(11, Types.VARCHAR);

			cstmt.execute();

			if (!cstmt.getString(10).equals("S000")) {
				conn.rollback();
				this.setResultMessage(-1, cstmt.getString(11), out_vl);
				proc_output(response, out, out_vl, out_dl);
				return;
			}

			cstmt.close();
		}

		// 신청정보 저장
		sbInsSql.delete(0, sbInsSql.length());
		sbInsSql.append("INSERT INTO SO_PR     \n");
		sbInsSql.append("( PR_ID               \n");
		sbInsSql.append(", PR_NUM              \n");
		sbInsSql.append(", PR_DATE             \n");
		sbInsSql.append(", PR_DEPT_ID          \n");
		sbInsSql.append(", PR_UPJANG           \n");
		sbInsSql.append(", PR_SABUN            \n");
		sbInsSql.append(", APPROVER            \n");
		sbInsSql.append(", APPROVE_TIME        \n");
		sbInsSql.append(", APPROVE_NUM         \n");
		sbInsSql.append(", PO_TYPE             \n");
		sbInsSql.append(", DOCU_SOURCE         \n");
		sbInsSql.append(", CUSTCD              \n");
		sbInsSql.append(", SUBINV_CODE         \n");
		sbInsSql.append(", RC_MU_CD            \n");
		sbInsSql.append(", RC_DEPT_ID          \n");
		sbInsSql.append(", RC_UPJANG           \n");
		sbInsSql.append(", CENTER_CODE         \n");
		sbInsSql.append(", ITEM_CODE           \n");
		sbInsSql.append(", ITEM_NAME           \n");
		sbInsSql.append(", ITEM_SIZE           \n");
		sbInsSql.append(", PO_UOM              \n");
		sbInsSql.append(", TAX_CODE            \n");
		sbInsSql.append(", BUDDEPT_ID          \n");
		sbInsSql.append(", ACCTCD              \n");
		sbInsSql.append(", BUD_CLS             \n");
		sbInsSql.append(", CENTER_FLAG         \n");
		sbInsSql.append(", UNIT_PRICE          \n");
		sbInsSql.append(", MARGIN_PRICE        \n");
		sbInsSql.append(", SALE_PRICE          \n");
		sbInsSql.append(", PR_QTY              \n");
		sbInsSql.append(", PO_QTY              \n");
		sbInsSql.append(", NEED_DATE           \n");
		sbInsSql.append(", INVAT_FLAG          \n");
		sbInsSql.append(", OUTVAT_FLAG         \n");
		sbInsSql.append(", MENU_QTY            \n");
		sbInsSql.append(", PR_REMARK           \n");
		sbInsSql.append(", LINE_STATUS         \n");
		sbInsSql.append(", CREATE_BY           \n");
		sbInsSql.append(", UPDATE_BY           \n");
		sbInsSql.append(", VD_SN               \n");
		sbInsSql.append(", APPLY_SD            \n");
		sbInsSql.append(", MOBILE_GUBUN        \n");
		sbInsSql.append(", ORG_PR_NUM          \n");
		sbInsSql.append(", UPJANG_GRP          \n");
		sbInsSql.append(", IS_ENF              \n");
		sbInsSql.append("  ) VALUES (  \n");
		sbInsSql.append("  ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", 0 \n");
		sbInsSql.append(", ROUND(?,1) \n");
		sbInsSql.append(", ROUND(?,1) \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(", ? \n");
		sbInsSql.append(")   \n");

		String strPrInsert = sbInsSql.toString();
		pstmt8 = conn.prepareStatement(strPrInsert);

		// 식단정보 업데이트
		sbInsSql.delete(0, sbInsSql.length());
		sbInsSql.append("UPDATE /*+ NO_QUERY_TRANSFORMATION */ FSM_REAL_RECIPE_ITEM A                                  \n");
		sbInsSql.append("   SET A.ORDER_YN = 'Y'                                        \n");
		sbInsSql.append("     , A.PR_NUM = ?                                            \n");
		sbInsSql.append("     , A.PR_ID = ?                                             \n");
		sbInsSql.append("     , A.PR_QTY = ROUND(?,1)                                   \n");
		sbInsSql.append("     , A.UNIT_PRICE = ?                                        \n");
		sbInsSql.append("     , A.MARGIN_PRICE = ?                                      \n");
		sbInsSql.append("     , A.MARGIN_RATE = ?                                       \n");
		sbInsSql.append("     , A.UDATE = SYSDATE                                       \n");
		sbInsSql.append("     , A.UUSER = ?                                             \n");
		sbInsSql.append(" WHERE A.ORDER_YN = 'N'                                        \n");
		sbInsSql.append("   AND A.NEED_DATE = ?                                         \n");
		sbInsSql.append("   AND A.ITEM_CODE = ?                                         \n");
		sbInsSql.append("   AND EXISTS                                                  \n");
		sbInsSql.append("        (                                                      \n");
		sbInsSql.append("        SELECT 1                                               \n");
		sbInsSql.append("          FROM FSM_REAL_MENU_MST B                     \n");
		sbInsSql.append("              ,FSM_REAL_RECIPE_ITEM C                  \n");
		sbInsSql.append("              ,FSA_HALL_MST D                          \n");
		sbInsSql.append("         WHERE B.UPJANG = C.UPJANG                     \n");
		sbInsSql.append("           AND B.MENU_CD = C.MENU_CD                   \n");
		sbInsSql.append("           AND B.UPJANG = D.UPJANG                     \n");
		sbInsSql.append("           AND B.HALL_CD = D.HALL_CD                   \n");
		sbInsSql.append("           AND A.UPJANG = B.UPJANG                     \n");
		sbInsSql.append("           AND A.MENU_CD = B.MENU_CD                   \n");
		sbInsSql.append("           AND D.SUBINV_CODE = ?                       \n");
		sbInsSql.append("           AND C.ITEM_CODE = ?                         \n");
		sbInsSql.append("           AND C.NEED_DATE = ?                         \n");
		sbInsSql.append("        )                                              \n");

		String strMenuUpdate = sbInsSql.toString();
		pstmt10 = conn.prepareStatement(strMenuUpdate);

		int iPrCnt = 0;
		int iDutyCnt = 0;
		int iMenuCnt = 0;

		for (int i = 0; i < ds_pr_item.getRowCount(); i++) {
			// PR_ID 생성 (식단에 PR_ID 저장을 위해 분리..속도가 느리거나 불필요하면 INSERT문에 포함 가능)
			sbSelSql.delete(0, sbSelSql.length());

			sbSelSql.append("SELECT TO_CHAR(SO_PR_S.NEXTVAL) PR_ID FROM DUAL \n");

			stmt = conn.createStatement();
			rs = stmt.executeQuery(sbSelSql.toString());

			rs.next();

			String strPrID = rs.getString("PR_ID");

			rs.close();
			stmt.close();

			pstmt8.setLong(1, Long.parseLong(strPrID));
			pstmt8.setString(2, strPrNum);
			pstmt8.setString(3, PR_DATE);
			pstmt8.setString(4, PR_DEPT_ID);
			pstmt8.setDouble(5, Double.parseDouble(PR_UPJANG));
			pstmt8.setString(6, PR_SABUN);
			pstmt8.setString(7, PR_SABUN);
			pstmt8.setString(8, strAprNum);
			pstmt8.setString(9, PO_TYPE);
			pstmt8.setString(10, "07 FS");
			pstmt8.setDouble(11, Double.parseDouble(ds_pr_item.getString(i, "CUSTCD")));
			pstmt8.setString(12, SUBINV_CODE);
			pstmt8.setString(13, ds_pr_item.getString(i, "MU_CD"));
			pstmt8.setString(14, ds_pr_item.getString(i, "DEPT_ID"));
			pstmt8.setDouble(15, Double.parseDouble(ds_pr_item.getString(i, "UPJANG")));
			pstmt8.setDouble(16, Double.parseDouble(ds_pr_item.getString(i, "CENTER_CODE")));
			pstmt8.setString(17, ds_pr_item.getString(i, "ITEM_CODE"));
			pstmt8.setString(18, ds_pr_item.getString(i, "ITEM_NAME"));
			pstmt8.setString(19, nullToBlank(ds_pr_item.getString(i, "ITEM_SIZE")));
			pstmt8.setString(20, nullToBlank(ds_pr_item.getString(i, "PO_UOM")));
			pstmt8.setString(21, nullToBlank(ds_pr_item.getString(i, "TAX_CODE")));
			pstmt8.setString(22, nullToBlank(ds_pr_item.getString(i, "BUDDEPT_ID")));
			pstmt8.setString(23, nullToBlank(ds_pr_item.getString(i, "ACCTCD")));
			pstmt8.setString(24, nullToBlank(ds_pr_item.getString(i, "BUD_CLS")));
			pstmt8.setString(25, ds_pr_item.getString(i, "CENTER_FLAG"));
			pstmt8.setDouble(26, Double.parseDouble(ds_pr_item.getString(i, "UNIT_PRICE")));
			pstmt8.setDouble(27, Double.parseDouble(ds_pr_item.getString(i, "MARGIN_PRICE")));
			pstmt8.setDouble(28, Double.parseDouble(ds_pr_item.getString(i, "PR_QTY")));
			pstmt8.setDouble(29, Double.parseDouble(ds_pr_item.getString(i, "PR_QTY")));
			pstmt8.setString(30, nullToBlank(ds_pr_item.getString(i, "NEED_DATE")));
			pstmt8.setString(31, nullToBlank(ds_pr_item.getString(i, "INVAT_FLAG")));
			pstmt8.setString(32, nullToBlank(ds_pr_item.getString(i, "OUTVAT_FLAG")));
			pstmt8.setDouble(33, Double.parseDouble(nullToZero(ds_pr_item.getString(i, "KG_QTY"))));
			pstmt8.setString(34, nullToBlank(ds_pr_item.getString(i, "PR_REMARK")));
			pstmt8.setString(35, STATUS);
			pstmt8.setString(36, PR_SABUN);
			pstmt8.setString(37, PR_SABUN);
			pstmt8.setString(38, nullToBlank(ds_pr_item.getString(i, "VD_SN")));
			pstmt8.setString(39, nullToBlank(ds_pr_item.getString(i, "APPLY_SD")));
			pstmt8.setString(40, MOBILE_GUBUN);
			pstmt8.setString(41, strPrNum);
			pstmt8.setString(42, nullToBlank(ds_pr_item.getString(i, "UPJANG_GRP")));
			pstmt8.setInt(43, Integer.parseInt(nullToZero(ds_pr_item.getString(i, "IS_ENF"))));
			pstmt8.addBatch();
			iPrCnt++;

			if (PO_TYPE.equals("04")) {
				// 식단정보 업데이트
				pstmt10.setString(1, strPrNum);
				pstmt10.setLong(2, Long.parseLong(strPrID));
				pstmt10.setDouble(3, Double.parseDouble(nullToZero(ds_pr_item.getString(i, "PR_QTY"))));
				pstmt10.setDouble(4, Double.parseDouble(nullToZero(ds_pr_item.getString(i, "UNIT_PRICE"))));
				pstmt10.setDouble(5, Double.parseDouble(nullToZero(ds_pr_item.getString(i, "MARGIN_PRICE"))));
				pstmt10.setDouble(6, Double.parseDouble(nullToZero(ds_pr_item.getString(i, "MARGIN_RATE"))));
				pstmt10.setString(7, PR_SABUN);
				pstmt10.setString(8, NEED_DATE);
				pstmt10.setString(9, ds_pr_item.getString(i, "ITEM_CODE"));
				pstmt10.setString(10, SUBINV_CODE);
				pstmt10.setString(11, ds_pr_item.getString(i, "ITEM_CODE"));
				pstmt10.setString(12, NEED_DATE);

				pstmt10.addBatch();
				iMenuCnt++;
			}
		}
		

		if (iPrCnt > 0)
			pstmt8.executeBatch();
		if (iMenuCnt > 0)
			pstmt10.executeBatch();


		//식단자동일 경우 삭제된 자재정보를 저장한다.
		if (PO_TYPE.equals("04")) {
			// 신청정보 로그 생성
			sbInsSql.delete(0, sbInsSql.length());
			

			sbInsSql.append("INSERT INTO SO_PR_MENU_LOG \n");
			sbInsSql.append("( PR_ID               \n");
			sbInsSql.append(", PR_NUM              \n");
			sbInsSql.append(", PR_DATE             \n");
			sbInsSql.append(", PR_DEPT_ID          \n");
			sbInsSql.append(", PR_UPJANG           \n");
			sbInsSql.append(", PR_SABUN            \n");
			sbInsSql.append(", APPROVER            \n");
			sbInsSql.append(", APPROVE_TIME        \n");
			sbInsSql.append(", APPROVE_NUM         \n");
			sbInsSql.append(", PO_TYPE             \n");
			sbInsSql.append(", DOCU_SOURCE         \n");
			sbInsSql.append(", CUSTCD              \n");
			sbInsSql.append(", SUBINV_CODE         \n");
			sbInsSql.append(", RC_MU_CD            \n");
			sbInsSql.append(", RC_DEPT_ID          \n");
			sbInsSql.append(", RC_UPJANG           \n");
			sbInsSql.append(", CENTER_CODE         \n");
			sbInsSql.append(", ITEM_CODE           \n");
			sbInsSql.append(", ITEM_NAME           \n");
			sbInsSql.append(", ITEM_SIZE           \n");
			sbInsSql.append(", PO_UOM              \n");
			sbInsSql.append(", TAX_CODE            \n");
			sbInsSql.append(", BUDDEPT_ID          \n");
			sbInsSql.append(", ACCTCD              \n");
			sbInsSql.append(", BUD_CLS             \n");
			sbInsSql.append(", CENTER_FLAG         \n");
			sbInsSql.append(", UNIT_PRICE          \n");
			sbInsSql.append(", MARGIN_PRICE        \n");
			sbInsSql.append(", SALE_PRICE          \n");
			sbInsSql.append(", PR_QTY              \n");
			sbInsSql.append(", PO_QTY              \n");
			sbInsSql.append(", NEED_DATE           \n");
			sbInsSql.append(", INVAT_FLAG          \n");
			sbInsSql.append(", OUTVAT_FLAG         \n");
			sbInsSql.append(", MENU_QTY            \n");
			sbInsSql.append(", PR_REMARK           \n");
			sbInsSql.append(", LINE_STATUS         \n");
			sbInsSql.append(", CREATE_BY           \n");
			sbInsSql.append(", UPDATE_BY           \n");
			sbInsSql.append(", VD_SN               \n");
			sbInsSql.append(", APPLY_SD            \n");
			sbInsSql.append(", ORG_PR_NUM          \n");
			sbInsSql.append(", UPJANG_GRP          \n");
			sbInsSql.append(", REMARK              \n");
			sbInsSql.append("  ) VALUES (  \n");
			sbInsSql.append(" SO_PR_MENU_LOG_S.NEXTVAL \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", 0 \n");
			sbInsSql.append(", ROUND(?,1) \n");
			sbInsSql.append(", ROUND(?,1) \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(", ? \n");
			sbInsSql.append(")   \n");

			String strLogInsert = sbInsSql.toString();
			pstmt11 = conn.prepareStatement(strLogInsert);

			int iLogCnt = 0;
			for (int i = 0; i < ds_del_item.getRowCount(); i++) {
				pstmt11.setString(1, strPrNum);
				pstmt11.setString(2, PR_DATE);
				pstmt11.setDouble(3, Double.parseDouble(PR_DEPT_ID));
				pstmt11.setDouble(4, Double.parseDouble(PR_UPJANG));
				pstmt11.setString(5, PR_SABUN);

				if (STATUS.equals("002")) {
					pstmt11.setString(6, PR_SABUN);
					pstmt11.setString(7, strAprNum);
				} else {
					pstmt11.setString(6, "");
					pstmt11.setString(7, "");
				}
				pstmt11.setString(8, PO_TYPE);
				pstmt11.setString(9, "01 BO");
				pstmt11.setDouble(10, Double.parseDouble(nullToZero(ds_del_item.getString(i, "CUSTCD"))));
				pstmt11.setString(11, ds_del_item.getString(i, "SUBINV_CODE"));
				pstmt11.setString(12, ds_del_item.getString(i, "MU_CD"));
				pstmt11.setDouble(13, Double.parseDouble(ds_del_item.getString(i, "DEPT_ID")));
				pstmt11.setDouble(14, Double.parseDouble(ds_del_item.getString(i, "UPJANG")));
				pstmt11.setDouble(15, Double.parseDouble(nullToZero(ds_del_item.getString(i, "CENTER_CODE"))));
				pstmt11.setString(16, ds_del_item.getString(i, "ITEM_CODE"));
				pstmt11.setString(17, ds_del_item.getString(i, "ITEM_NAME"));
				pstmt11.setString(18, nullToBlank(ds_del_item.getString(i, "ITEM_SIZE")));
				pstmt11.setString(19, nullToBlank(ds_del_item.getString(i, "PO_UOM")));
				pstmt11.setString(20, nullToBlank(ds_del_item.getString(i, "TAX_CODE")));
				pstmt11.setDouble(21, Double.parseDouble(nullToZero(ds_del_item.getString(i, "BUDDEPT_ID"))));
				pstmt11.setString(22, ds_del_item.getString(i, "ACCTCD"));
				pstmt11.setString(23, nullToBlank(ds_del_item.getString(i, "BUD_CLS")));
				pstmt11.setString(24, nullToBlank(ds_del_item.getString(i, "CENTER_FLAG")));
				pstmt11.setDouble(25, Double.parseDouble(nullToZero(ds_del_item.getString(i, "UNIT_PRICE"))));
				pstmt11.setDouble(26, Double.parseDouble(nullToZero(ds_del_item.getString(i, "MARGIN_PRICE"))));
				pstmt11.setDouble(27, Double.parseDouble(nullToZero(ds_del_item.getString(i, "PR_QTY"))));
				pstmt11.setDouble(28, Double.parseDouble(nullToZero(ds_del_item.getString(i, "PR_QTY"))));
				pstmt11.setString(29, nullToBlank(ds_del_item.getString(i, "NEED_DATE")));
				pstmt11.setString(30, nullToBlank(ds_del_item.getString(i, "INVAT_FLAG")));
				pstmt11.setString(31, nullToBlank(ds_del_item.getString(i, "OUTVAT_FLAG")));
				pstmt11.setDouble(32, Double.parseDouble(nullToZero(ds_del_item.getString(i, "KG_QTY"))));
				pstmt11.setString(33, nullToBlank(ds_del_item.getString(i, "PR_REMARK")));
				pstmt11.setString(34, STATUS);
				pstmt11.setString(35, PR_SABUN);
				pstmt11.setString(36, PR_SABUN);
				pstmt11.setString(37, nullToBlank(ds_del_item.getString(i, "VD_SN")));
				pstmt11.setString(38, nullToBlank(ds_del_item.getString(i, "APPLY_SD")));
				pstmt11.setString(39, strPrNum);
				pstmt11.setString(40, nullToBlank(ds_del_item.getString(i, "UPJANG_GRP")));
				pstmt11.setString(41, nullToBlank(ds_del_item.getString(i, "REMARK")));
				pstmt11.addBatch();
				iLogCnt++;
			}

			if (iLogCnt > 0)
				pstmt11.executeBatch();
		}

		//식자재 단가계약이면서 식단구매신청이 아닐 경우 사유 저장
		if (!PO_TYPE.equals("04")) {
		
			sbInsSql.delete(0, sbInsSql.length());

			sbInsSql.append("INSERT INTO SO_PR_REASON(");
			sbInsSql.append("            PR_NUM                                     \n");
			sbInsSql.append("          , PR_DATE                            \n");
			sbInsSql.append("          , PR_UPJANG                          \n");
			sbInsSql.append("          , PR_SABUN                           \n");
			sbInsSql.append("          , REASON_CD                          \n");
			sbInsSql.append("          , PR_REASON                          \n");
			sbInsSql.append("          , CREATE_DATE                        \n");
			sbInsSql.append("          , CREATE_BY                          \n");
			sbInsSql.append("          , UPDATE_DATE                        \n");
			sbInsSql.append("          , UPDATE_BY                          \n");
			sbInsSql.append("          ) VALUES (                           \n");
			sbInsSql.append("            '" + strPrNum + "'        \n");
			sbInsSql.append("          , '" + PR_DATE + "'        \n");
			sbInsSql.append("          , " + PR_UPJANG + "         \n");
			sbInsSql.append("          , '" + PR_SABUN + "'        \n");
			sbInsSql.append("          , '" + REASON_CD + "' \n");
			sbInsSql.append("          , '" + PR_REASON + "' \n");
			sbInsSql.append("          , SYSDATE \n");
			sbInsSql.append("          , '" + PR_SABUN + "'        \n");
			sbInsSql.append("          , SYSDATE \n");
			sbInsSql.append("          , '" + PR_SABUN + "'        \n");
			sbInsSql.append("          ) \n");

			stmt = conn.createStatement();
			stmt.execute(sbInsSql.toString());

			stmt.close();
		}
		
		// 유형별 D_DAY, D_TIME 가능한지 체크
		sbSelSql.delete(0, sbSelSql.length());

		sbSelSql.append("SELECT A.D_DAYS                                                                                                                                \n");
		sbSelSql.append("     , A.D_TIMES                                                                                                                               \n");
		sbSelSql.append("     , A.TYPE_NAME                                                                                                                             \n");
		sbSelSql.append("     , CASE WHEN A.D_DAYS = 0 AND A.D_TIMES = 0 THEN CASE WHEN TO_CHAR(TO_DATE('"+NEED_DATE+"') - A.D_DAYS + (A.D_TIMES/24), 'YYYYMMDD') = TO_CHAR(SYSDATE, 'YYYYMMDD') THEN 'N'   \n");
		sbSelSql.append("     													   WHEN TO_CHAR(TO_DATE('"+NEED_DATE+"') - A.D_DAYS + (A.D_TIMES/24), 'YYYYMMDD') > TO_CHAR(SYSDATE, 'YYYYMMDD') THEN 'N' ELSE 'Y'	END  \n");
        sbSelSql.append("        ELSE 																																	\n");
        sbSelSql.append("            CASE WHEN TO_CHAR(TO_DATE('"+NEED_DATE+"') - A.D_DAYS + (A.D_TIMES/24), 'YYYYMMDDHH24') <= TO_CHAR(SYSDATE, 'YYYYMMDDHH24') THEN 'Y'    \n");
		sbSelSql.append("\n          ELSE 'N'                                                                                                                           \n");
		sbSelSql.append("\n      END                                                                                                                           			\n");
		sbSelSql.append("\n     END CLOSE_YN                                                                                                                            \n");
		sbSelSql.append("  FROM HLDC_PO_TYPE_FS A                                                                                                                       \n");
		sbSelSql.append(" WHERE A.PO_TYPE = '"+PO_TYPE+"'                                                                                                               \n");
		sbSelSql.append("   AND ROWNUM = 1                                                                                                                              \n");

		stmt = conn.createStatement();
		rs = stmt.executeQuery(sbSelSql.toString());
		rs.next();
		
		System.out.print("마감여부 >> " + rs.getString("CLOSE_YN"));
		if (rs.getString("CLOSE_YN").equals("Y")) {
			out_vl.add("fv_closeRamak", "입고예정일 기준 "+ rs.getString("D_DAYS") + "일 " +rs.getString("D_TIMES") +"시");
			this.setResultMessage(0, "OK", out_vl);
			conn.rollback();
			proc_output(response, out, out_vl, out_dl);
			rs.close();
			return;
		}

		//중복신청여부 최종 점검(동일한 품목/수량이 5분 안에 중복저장)
         if(!SUBINV_CODE.equals(""))
		 {
			 sbSelSql.delete(0, sbSelSql.length());
	
			 sbSelSql.append("SELECT A.ITEM_CODE||' '||A.ITEM_NAME AS ITEM_NAME              \n");
			 sbSelSql.append("  FROM SO_PR A                                                 \n");
			 sbSelSql.append(" WHERE A.NEED_DATE = '" + NEED_DATE + "'                       \n");
			 sbSelSql.append("   AND A.SUBINV_CODE = '" + SUBINV_CODE + "'                   \n");
			 sbSelSql.append("   AND A.LINE_STATUS = '002'                                   \n");
			 sbSelSql.append("   AND EXISTS                                                  \n");
			 sbSelSql.append("      (SELECT 1 FROM SO_PR Z                                   \n");
			 sbSelSql.append("        WHERE Z.NEED_DATE   = A.NEED_DATE                       \n");
			 sbSelSql.append("          AND Z.SUBINV_CODE = A.SUBINV_CODE                    \n");
			 sbSelSql.append("          AND Z.ITEM_CODE   = A.ITEM_CODE                      \n");
			 sbSelSql.append("          AND Z.LINE_STATUS = A.LINE_STATUS                    \n");
			 sbSelSql.append("          AND Z.PR_QTY = A.PR_QTY                              \n");
			 sbSelSql.append("          AND Z.ROWID <> A.ROWID                               \n");
			 sbSelSql.append("          AND ABS(Z.CREATE_DATE - A.CREATE_DATE) < 0.003)      \n"); //5분 이내
			 sbSelSql.append("   AND ROWNUM <= 1 \n");
	
			 stmt = conn.createStatement();
			 rs = stmt.executeQuery(sbSelSql.toString());
	
			 if(rs.next())
			 {
				 this.setResultMessage(-1, "5분이내 동일품목 동일수량 중복신청(" + rs.getString("ITEM_NAME") + " 외) 불가", out_vl);
				 conn.rollback();
				 proc_output(response,out,out_vl,out_dl);
				 return;
			 }
	
			 rs.close();
			 stmt.close();
		 } 
		 

		if (STATUS.equals("002")) {
			// 구매 자재신청 유효성 체크
			sbSelSql.delete(0, sbSelSql.length());

			sbSelSql.append("  SELECT t.*                                                                                                                                                                                                                                                                                                           \n");
			sbSelSql.append("    FROM (                                                                                                                                                                                                                                                                                                                     \n");
			sbSelSql.append("    SELECT A.ITEM_CODE                                                                                                                                                                                                                                                                                         \n");
			sbSelSql.append("         , A.ITEM_NAME                                                                                                                                                                                                                                                                                         \n");
			sbSelSql.append("         , A.CENTER_CODE                                                                                                                                                                                                                                                                                       \n");
			sbSelSql.append("         , A.RC_UPJANG                                                                                                                                                                                                                                                                                         \n");
			sbSelSql.append("         , A.CENTER_FLAG                                                                                                                                                                                                                                                                                       \n");
			sbSelSql.append("         , (SELECT CASE WHEN VAL_SHP_CNT IN ('CE', 'NN') THEN '자재 업장군 맵핑 유효성 체크 오류'                                                                                                                                              \n");
			sbSelSql.append("                        WHEN VAL_UNS_CNT IN ('UK', 'NN') THEN '자재 불용체크 오류'                                                                                                                                                                     \n");
			sbSelSql.append("                        WHEN VAL_STP_CNT IN ('TK', 'NN') THEN '자재 중지체크 오류'                                                                                                                                                                     \n");
			sbSelSql.append("                        WHEN VAL_EVT_CNT IN ('VE', 'NN') THEN '기획자재 한정수량체크 오류'                                                                                                                                                             \n");
			sbSelSql.append("                        WHEN VAL_CTR_CNT IN ('SE', 'NN') THEN 'SPOT계약 발주횟수체크 오류'                                                                                                                                                             \n");
			sbSelSql.append("                        WHEN VAL_REQ_CNT IN ('XE', 'NN') THEN '요일별 신청불가 체크 오류'                                                                                                                                                              \n");
			sbSelSql.append("                        WHEN VAL_SCH_CNT IN ('HE', 'NN') THEN '수발주 스케쥴에 따른 유효성 체크 오류'                                                                                                                                  \n");
			sbSelSql.append("                        WHEN A.CENTER_FLAG = 'DC'                                                                                                                                                                                                                                      \n");
			sbSelSql.append("                            AND EPROCUSR.FC_GET_CENTER_IVT_YN('100', 'HFC', A.CENTER_CODE, A.ITEM_CODE, A.PR_QTY) = 'N' THEN 'DC자재 수량체크 오류'                                    \n");
			sbSelSql.append("                   ELSE 'OK' END                                                                                                                                                                                                                                                                       \n");
			sbSelSql.append("              FROM TABLE(EPROCUSR.FN_ITEM_PROCURE_VALIDATE('100', 'HFC', (SELECT OPER_ORG_SN_PURC FROM HLDC_PO_CENTER WHERE CENTER_CODE = A.CENTER_CODE)                       \n");
			sbSelSql.append("                                                           , A.ITEM_CODE, A.VD_SN, A.APPLY_SD, A.PR_QTY, A.UPJANG_GRP, '01'                                                                            \n");
			sbSelSql.append("                                                           , FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_DAYS')                                                                                                      \n");
			sbSelSql.append("                                                           , FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_TIMES'), '" + PR_DATE + "', '" + NEED_DATE + "'))           \n");
			sbSelSql.append("           ) AS ITEM_VAL                                                                                                                                                                                                                                                                                       \n");
			sbSelSql.append("      FROM SO_PR A                                                                                                                                                                                                                                                                                                     \n");
			sbSelSql.append("     WHERE A.ORG_PR_NUM  = '" + strPrNum + "'                                                                                                                                                                                                                                          \n");
			sbSelSql.append("       AND A.LINE_STATUS = '002') t                                                                                                                                                                                                                                                            \n");
			sbSelSql.append(" WHERE t.ITEM_VAL <> 'OK'                                                                                                                                                                                                                                                                                      \n");

			stmt = conn.createStatement();
			rs = stmt.executeQuery(sbSelSql.toString());

			DataSet ds_save_out = this.makeDataSet(rs, "ds_save_out");
			out_dl.add(ds_save_out);

			if (ds_save_out.getRowCount() > 0) {
				if (MOBILE_GUBUN.equals("M")) {
					this.setResultMessage(1, "구매신청 불가 자재가 존재합니다.", out_vl);
				} else {
					this.setResultMessage(-1, "구매신청 불가 자재가 존재합니다.", out_vl);
				}
				conn.rollback();
				proc_output(response, out, out_vl, out_dl);
				return;
			}
			rs.close();
			stmt.close();
		}

		// 구매 프로시져 호출
		if (STATUS.equals("002")) {
			
			// 해당 prnum에 대해 PO에 존재하는지 체크 (중복 체크)
			sbSelSql.delete(0, sbSelSql.length());
            sbSelSql.append("SELECT COUNT(*) AS PO_CNT             \n");
            sbSelSql.append("  FROM HLDC_PO_PO                     \n");
            sbSelSql.append(" WHERE PO_NUM = '" + strPrNum + "'	   \n");
            sbSelSql.append("   AND PO_TYPE = '" + PO_TYPE + "'	   \n");
			
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sbSelSql.toString());
			rs.next();
            
			if(!rs.getString("PO_CNT").equals("0")) {
				this.setResultMessage(-1, "해당 구매신청건에 대해 중복신청 되었습니다. - 신청번호 : " + strPrNum, out_vl);
				conn.rollback();
				proc_output(response,out,out_vl,out_dl);
				return;
			}
			rs.close();
			stmt.close();
			
			cstmt = conn.prepareCall("{call EPROCUSR.SP_IF_SALES_ORDER(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");

			//실행
			cstmt.setString(1, "100");
			cstmt.setString(2, "HFC");
			cstmt.setString(3, "FR");
			cstmt.setString(4, strItemtype);
			cstmt.setString(5, RC_UPJANG);
			cstmt.setString(6, PR_SABUN);
			cstmt.setString(7, PO_TYPE);
			cstmt.setString(8, strPrNum);
			cstmt.setString(9, "C");
			cstmt.registerOutParameter(10, Types.VARCHAR);
			cstmt.registerOutParameter(11, Types.VARCHAR);

			cstmt.execute();

			if (!cstmt.getString(10).equals("S000")) {
				conn.rollback();
				this.setResultMessage(-1, cstmt.getString(11), out_vl);
				proc_output(response, out, out_vl, out_dl);
				return;
			}

			cstmt.close();
		}

		conn.commit();
		this.setResultMessage(0, "OK", out_vl);

	} catch (Exception ex) {

		conn.rollback();
		ex.printStackTrace();
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

		if (stmt != null) {
			try {
				stmt.close();
			} catch (Exception e) {
			}
		}

		if (cstmt != null) {
			try {
				cstmt.close();
			} catch (Exception e) {
			}
		}

		if (pstmt1 != null) {
			try {
				pstmt1.close();
			} catch (Exception e) {
			}
		}
		if (pstmt2 != null) {
			try {
				pstmt2.close();
			} catch (Exception e) {
			}
		}
		if (pstmt3 != null) {
			try {
				pstmt3.close();
			} catch (Exception e) {
			}
		}
		if (pstmt4 != null) {
			try {
				pstmt4.close();
			} catch (Exception e) {
			}
		}
		if (pstmt5 != null) {
			try {
				pstmt5.close();
			} catch (Exception e) {
			}
		}
		if (pstmt6 != null) {
			try {
				pstmt6.close();
			} catch (Exception e) {
			}
		}
		if (pstmt7 != null) {
			try {
				pstmt7.close();
			} catch (Exception e) {
			}
		}
		if (pstmt8 != null) {
			try {
				pstmt8.close();
			} catch (Exception e) {
			}
		}
		if (pstmt9 != null) {
			try {
				pstmt9.close();
			} catch (Exception e) {
			}
		}
		if (pstmt10 != null) {
			try {
				pstmt10.close();
			} catch (Exception e) {
			}
		}
		if (pstmt11 != null) {
			try {
				pstmt11.close();
			} catch (Exception e) {
			}
		}
		if (pstmt12 != null) {
			try {
				pstmt12.close();
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