<%
	/*-----------------------------------------------------------------------------
	 ■ 시스템명	: 구매관리/구매신청/구매신청서작성/식자재구매신청
	 ■ 프로그램ID	: FSP00032E_T002.jsp
	 ■ 프로그램명	: 구매신청(신청된건에 대한 자재수정및 추가일경우)
	 ■ 작성일자	: 2015-07-11
	 ■ 작성자	: 정영철
	 ■ 이력관리	: 2015-07-11
	 - 신청서 수정일경우	자재 추가 삭제 수량변경등 로직
	 -----------------------------------------------------------------------------*/
%>
<%@	page contentType="text/html; charset=EUC-KR"%>
<%@	include file="../../sc/main/common.jsp"%>
<%@page import="org.aspectj.asm.IModelFilter"%>

<%
	Statement stmt = null;
	CallableStatement cstmt1 = null; // 추가건이	존재하거나 신청서상태가	임시저장이였을경우
	CallableStatement cstmt2 = null; // 변경건이	존재할경우
	PreparedStatement pstmt1 = null; // SO_PR UPDATE
	PreparedStatement pstmt2 = null;
	PreparedStatement pstmt3 = null;
	PreparedStatement pstmt4 = null;
	PreparedStatement pstmt5 = null; // 자재가 삭제되었을경우
	PreparedStatement pstmt6 = null;

	try {
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		// log 서비스 시작
		logger.startIndividualLog(in_vl.getString("titLogId"));

		DataSet ds_condi = in_dl.get("ds_condi"); // 조회조건및 필수 파라미터	데이터셋
		DataSet ds_pr_item = in_dl.get("ds_pr_item"); // 구매신청자제	데이터셋
		DataSet ds_del_item = in_dl.get("ds_del_item"); // 식단에서	구매신청에서 제외된	자재

		String TYPE        = nullToBlank(ds_condi.getString(0, "TYPE")); // 신규	& 수정 확정구분자
		String PR_SABUN    = nullToBlank(ds_condi.getString(0, "PR_SABUN")); // 구매신청자 사번
		String PR_DEPT_ID  = nullToBlank(ds_condi.getString(0, "PR_DEPT_ID")); // 구매신청자 소속 부서
		String PR_UPJANG   = nullToBlank(ds_condi.getString(0, "PR_UPJANG")); // 구매신청자 소속 업장
		String PO_TYPE     = nullToBlank(ds_condi.getString(0, "PO_TYPE")); // 구매유형
		String RC_UPJANG   = nullToBlank(ds_condi.getString(0, "RC_UPJANG")); // 구매신청	업장
		String PR_NUM      = nullToBlank(ds_condi.getString(0, "PR_NUM")); // 구매번호(수정일경우에만 넘어옴)
		String APPROVE_NUM = nullToBlank(ds_condi.getString(0, "APPROVE_NUM")); // 구매승인번호(수정일경우에만 넘어옴)
		String PR_DATE     = nullToBlank(ds_condi.getString(0, "PR_DATE")); // 신청일자
		String NEED_DATE   = nullToBlank(ds_condi.getString(0, "NEED_DATE")); // 입고예정일자
		String SUBINV_CODE = nullToBlank(ds_condi.getString(0, "SUBINV_CODE")); // 창고코드
		String STATUS      = nullToBlank(ds_condi.getString(0, "STATUS")); // 확정인지	임시저장인지 구분자
		String REASON_CD   = nullToBlank(ds_condi.getString(0, "REASON_CD")); // 사유코드
		String PR_REASON   = nullToBlank(ds_condi.getString(0, "PR_REASON")); // 사유코드
		String LINE_STATUS = nullToBlank(ds_condi.getString(0, "LINE_STATUS")); // 진행상태코드	(임시저장되었던건인지 확정되었던 건인지	구분자)

		String MOBILE_GUBUN = in_vl.getString("p_mobile_gubun"); // 모바일구분값

		// 모바일구분값이 공백일 경우 P로 하드코딩
		if (MOBILE_GUBUN.equals("")) {
			MOBILE_GUBUN = "P";
		}

		StringBuffer sbSelSql = new StringBuffer();
		StringBuffer sbInsSql = new StringBuffer();
		StringBuffer sbUpdSql = new StringBuffer();

		String strOrgPrNum = ""; // 원본	PR_NUM
		String strAddPrNum = ""; // 자재	추가시 신규	PR_NUM
		String strAprNum   = ""; // 구매승인번호
		String strValiPrId = ""; // 구매시스템 유효성체크할 PR_ID
		String PR_YN       = ""; // 유효성 체크 YN 2018.03.22 김호석 추가

		int iSaveCnt   = ds_pr_item.getRowCount(); // 변경 추가된 자재건수
		int iDeleteCnt = ds_pr_item.getRemovedRowCount(); // 삭제된 자재 건수
		int iUpdateCnt = 0;
		int iAddCnt    = 0;

		int iMenuAddCnt = 0; // 식단에 의한 발주일경우 식단에서 신청된 건수
		int iMenuModCnt = 0; // 식단에 의한 발주일경우 식단에서 변경된 건수
		int iMenuDelCnt = 0; // 식단에 의한 발주일경우 식단에서 삭제된 건수

		strOrgPrNum = PR_NUM; // 원본	PR_NUM (신청호가정 후 추가 자재가 있을 경우를 원본 PR_NUM 존재)
		strAprNum = APPROVE_NUM;

		//	구매유형(구매 프로시져에 넘길 파라미터)
		String strItemtype = "";
		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("SELECT ITEM_TYPE	FROM HLDC_PO_TYPE_FS WHERE	PO_TYPE	= '" + PO_TYPE + "'	\n");

		stmt = conn.createStatement();
		rs = stmt.executeQuery(sbSelSql.toString());

		rs.next();

		strItemtype = rs.getString("ITEM_TYPE");

		for (int i = 0; i < iSaveCnt; i++) {
			//System.out.println(i +"번째 변경추가된 자재 로우타입 >>>>>>>>>> "	+ ds_pr_item.getRowType(i) + " - 명	>> "+ ds_pr_item.getRowTypeName(i));
			// 추가된 자재건수
			if (ds_pr_item.getRowType(i) == DataSet.ROW_TYPE_INSERTED) {
				iAddCnt++;
			}

			// 수정된 자재건수
			if (ds_pr_item.getRowType(i) == DataSet.ROW_TYPE_UPDATED) {
				iUpdateCnt++;
			}
		}

		//System.out.println(ds_condi.saveXml());
		System.out.println("변경된 자재건수	 >>>>>>>>>>	" +	iUpdateCnt);
		 /*
		 System.out.println("구매신청	자재건수 >>>>>>>>>>	" +	iSaveCnt);
		 System.out.println("추가된 자재건수	 >>>>>>>>>>	" +	iAddCnt);
		 System.out.println("변경된 자재건수	 >>>>>>>>>>	" +	iUpdateCnt);
		 System.out.println("삭제된 자재건수	 >>>>>>>>>>	" +	iDeleteCnt);
		*/

		/************************************************************************************************
			  확정건에 대해서 자재추가 건수가 있을경우 신규	PR_NUM 생성
		 ************************************************************************************************/
		 System.out.println("LINE_STATUS	 >>>>>>>>>>	" +	LINE_STATUS);
		 
		if (iAddCnt > 0 && (LINE_STATUS.equals("PC") || LINE_STATUS.equals("DL"))) {
			// 구매신청번호	생성
			sbSelSql.delete(0, sbSelSql.length());
			sbSelSql.append("SELECT	TO_CHAR(SYSDATE,'YYYYMMDD')||'-'||LPAD(SO_PR_NUM_S.NEXTVAL,5,'0') PR_NUM FROM DUAL \n");

			stmt = conn.createStatement();
			rs = stmt.executeQuery(sbSelSql.toString());
			rs.next();

			strAddPrNum = rs.getString("PR_NUM");

			rs.close();
			stmt.close();
			//System.out.println("자재추가 건수가 있을경우 신규	PR_NUM를 생성 >>>>>>>>>> " + strAddPrNum);

		}

		/************************************************************************************************
			SQL	생성
		 ************************************************************************************************/
		// 자재	수량 및	비고 수정건	및 임시저장건
		sbInsSql.delete(0, sbInsSql.length());
		sbInsSql.append("UPDATE	SO_PR							\n");
		sbInsSql.append("SET									\n");
		sbInsSql.append("  PR_QTY			 = ?				\n");
		sbInsSql.append(", PR_REMARK		 = ?				\n");
		sbInsSql.append(", REMARK		     = ''				\n");
		sbInsSql.append(", UPDATE_BY		 = ?				\n");
		sbInsSql.append(", UPDATE_DATE		 = SYSDATE			\n");
		sbInsSql.append(", MOBILE_GUBUN		 = ?				\n");
		sbInsSql.append(", LINE_STATUS		 = ?				\n");
		sbInsSql.append("WHERE ORG_PR_NUM	 = ?				\n");
		sbInsSql.append("  AND PR_ID		 = ?				\n");
		//한번 취소된 PR_ID는 다시 못살아나도록 처리 2018.01.30 김호석
		sbInsSql.append("  AND LINE_STATUS  NOT IN ('003','999','PD')  	\n");

		String strPrUpdate = sbInsSql.toString();
		pstmt1 = conn.prepareStatement(strPrUpdate);

		// 자재가 삭제되었을경우
		sbInsSql.delete(0, sbInsSql.length());
		sbInsSql.append("UPDATE	SO_PR							\n");
		sbInsSql.append("SET									\n");
		sbInsSql.append("  PR_QTY			 = 0				\n");
		sbInsSql.append(", PR_REMARK		 = ?				\n");
		sbInsSql.append(", REMARK		     = ?				\n");
		sbInsSql.append(", UPDATE_BY		 = ?				\n");
		sbInsSql.append(", UPDATE_DATE		 = SYSDATE			\n");
		sbInsSql.append(", MOBILE_GUBUN		 = ?				\n");
		sbInsSql.append(", LINE_STATUS		 = '999'			\n");
		sbInsSql.append("WHERE ORG_PR_NUM	 = ?				\n");
		sbInsSql.append("  AND PR_ID		 = ?				\n");
		String strPrDelete = sbInsSql.toString();
		pstmt5 = conn.prepareStatement(strPrDelete);

		// 자재추가	건에 대한 신규 PR_NUM 으로 입력
		sbInsSql.delete(0, sbInsSql.length());
		sbInsSql.append("INSERT	INTO SO_PR						\n");
		sbInsSql.append("( PR_ID								\n");
		sbInsSql.append(", PR_NUM								\n");
		sbInsSql.append(", PR_DATE								\n");
		sbInsSql.append(", PR_DEPT_ID							\n");
		sbInsSql.append(", PR_UPJANG							\n");
		sbInsSql.append(", PR_SABUN								\n");
		sbInsSql.append(", APPROVER								\n");
		sbInsSql.append(", APPROVE_TIME							\n");
		sbInsSql.append(", APPROVE_NUM							\n");
		sbInsSql.append(", PO_TYPE								\n");
		sbInsSql.append(", DOCU_SOURCE							\n");
		sbInsSql.append(", CUSTCD								\n");
		sbInsSql.append(", SUBINV_CODE							\n");
		sbInsSql.append(", RC_MU_CD								\n");
		sbInsSql.append(", RC_DEPT_ID							\n");
		sbInsSql.append(", RC_UPJANG							\n");
		sbInsSql.append(", CENTER_CODE							\n");
		sbInsSql.append(", ITEM_CODE							\n");
		sbInsSql.append(", ITEM_NAME							\n");
		sbInsSql.append(", ITEM_SIZE							\n");
		sbInsSql.append(", PO_UOM								\n");
		sbInsSql.append(", TAX_CODE								\n");
		sbInsSql.append(", BUDDEPT_ID							\n");
		sbInsSql.append(", ACCTCD								\n");
		sbInsSql.append(", BUD_CLS								\n");
		sbInsSql.append(", CENTER_FLAG							\n");
		sbInsSql.append(", UNIT_PRICE							\n");
		sbInsSql.append(", MARGIN_PRICE							\n");
		sbInsSql.append(", SALE_PRICE							\n");
		sbInsSql.append(", PR_QTY								\n");
		sbInsSql.append(", PO_QTY								\n");
		sbInsSql.append(", NEED_DATE							\n");
		sbInsSql.append(", INVAT_FLAG							\n");
		sbInsSql.append(", OUTVAT_FLAG							\n");
		sbInsSql.append(", MENU_QTY								\n");
		sbInsSql.append(", PR_REMARK							\n");
		sbInsSql.append(", LINE_STATUS							\n");
		sbInsSql.append(", CREATE_BY							\n");
		sbInsSql.append(", UPDATE_BY							\n");
		sbInsSql.append(", VD_SN								\n");
		sbInsSql.append(", APPLY_SD								\n");
		sbInsSql.append(", MOBILE_GUBUN							\n");
		sbInsSql.append(", ORG_PR_NUM							\n");
		sbInsSql.append(", UPJANG_GRP							\n");
		sbInsSql.append(", IS_ENF								\n");
		sbInsSql.append("  ) VALUES	(							\n");
		sbInsSql.append("  ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS')	\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", 0									\n");
		sbInsSql.append(", ROUND(?,1)							\n");
		sbInsSql.append(", ROUND(?,1)							\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(")										\n");

		String strPrAdd = sbInsSql.toString();
		pstmt2 = conn.prepareStatement(strPrAdd);

		// 자재	추가시 식단정보	업데이트
		sbInsSql.delete(0, sbInsSql.length());
		sbInsSql.append("UPDATE	FSM_REAL_RECIPE_ITEM A			\n");
		sbInsSql.append("	SET	A.ORDER_YN	   = 'Y'			\n");
		sbInsSql.append("	  ,	A.PR_NUM	   = ?				\n");
		sbInsSql.append("	  ,	A.PR_ID		   = ?				\n");
		sbInsSql.append("	  ,	A.PR_QTY	   = ROUND(?,1)		\n");
		sbInsSql.append("	  ,	A.UNIT_PRICE   = ?				\n");
		sbInsSql.append("	  ,	A.MARGIN_PRICE = ?				\n");
		sbInsSql.append("	  ,	A.MARGIN_RATE  = ?				\n");
		sbInsSql.append("	  ,	A.UDATE		   = SYSDATE		\n");
		sbInsSql.append("	  ,	A.UUSER		   = ?				\n");
		sbInsSql.append(" WHERE	A.ORDER_YN	   = 'N'			\n");
		sbInsSql.append("	AND	A.NEED_DATE	   = ?				\n");
		sbInsSql.append("	AND	A.ITEM_CODE	   = ?				\n");
		sbInsSql.append("	AND	EXISTS							\n");
		sbInsSql.append("	 (									\n");
		sbInsSql.append("	 SELECT	1					\n");
		sbInsSql.append("	   FROM	FSM_REAL_MENU_MST B			\n");
		sbInsSql.append("		   ,FSM_REAL_RECIPE_ITEM C		\n");
		sbInsSql.append("		   ,FSA_HALL_MST D				\n");
		sbInsSql.append("	  WHERE	B.UPJANG	  =	C.UPJANG	\n");
		sbInsSql.append("		AND	B.MENU_CD	  =	C.MENU_CD	\n");
		sbInsSql.append("		AND	B.UPJANG	  =	D.UPJANG	\n");
		sbInsSql.append("		AND	B.HALL_CD	  =	D.HALL_CD	\n");
		sbInsSql.append("		AND	A.UPJANG	  =	B.UPJANG	\n");
		sbInsSql.append("		AND	A.MENU_CD	  =	B.MENU_CD	\n");
		sbInsSql.append("		AND	D.SUBINV_CODE =	?			\n");
		sbInsSql.append("		AND	C.ITEM_CODE	  =	?			\n");
		sbInsSql.append("		AND	C.NEED_DATE	  =	?			\n");
		sbInsSql.append("	 )									\n");

		String strMenuAdd = sbInsSql.toString();
		pstmt3 = conn.prepareStatement(strMenuAdd);

		//	자재 수정시	삭제시 식단정보	업데이트
/* 		sbInsSql.delete(0, sbInsSql.length());
		sbInsSql.append("UPDATE	FSM_REAL_RECIPE_ITEM A			\n");
		sbInsSql.append("	SET	A.ORDER_YN	= ?					\n"); //1	신청YN
		sbInsSql.append("	  ,	A.PR_NUM	= ?					\n"); //2	신청번호
		sbInsSql.append("	  ,	A.PR_QTY	= ?					\n"); //3	자재신청건수
		sbInsSql.append("	  ,	A.PR_ID		= ?					\n"); //4	구매신청번호
		sbInsSql.append("	  ,	A.UDATE		= SYSDATE			\n");
		sbInsSql.append("	  ,	A.UUSER		= ?					\n"); //5	수정자사원번호
		sbInsSql.append(" WHERE	A.ORDER_YN	= 'Y'				\n");
		sbInsSql.append("	AND	A.NEED_DATE	= ?					\n"); //6	입고일자
		sbInsSql.append("	AND	EXISTS							\n");
		sbInsSql.append("	(									\n");
		sbInsSql.append("	 SELECT	1							\n");
		sbInsSql.append("	   FROM	SO_PR C						\n");
		sbInsSql.append("	  WHERE	C.PR_ID	 = A.PR_ID			\n");
		sbInsSql.append("		AND	C.PR_ID	 = ?				\n"); //7	구매신청번호
		//sbInsSql.append("		  AND C.PR_NUM = ?				\n"); //8	신청번호
		sbInsSql.append("	)									\n"); */

		sbInsSql.delete(0, sbInsSql.length());
		sbInsSql.append("UPDATE	FSM_REAL_RECIPE_ITEM A			\n");
		sbInsSql.append("	SET	A.ORDER_YN	= ?					\n"); //1	신청YN
		sbInsSql.append("	  ,	A.PR_NUM	= ?					\n"); //2	신청번호
		sbInsSql.append("	  ,	A.PR_QTY	= ?					\n"); //3	자재신청건수
		sbInsSql.append("	  ,	A.PR_ID		= ?					\n"); //4	구매신청번호
		sbInsSql.append("	  ,	A.UDATE		= SYSDATE			\n");
		sbInsSql.append("	  ,	A.UUSER		= ?					\n"); //5	수정자사원번호
		sbInsSql.append(" WHERE	A.ORDER_YN	= 'Y'				\n");
		sbInsSql.append("	AND	A.PR_ID  	= ?					\n"); //6 PR_ID
		//한번 취소된 PR_ID는 다시 못살아나도록 처리 2018.01.30 김호석
		//삭제되는 경우 식단업데이트 안됨 20181129 김호석
		//sbInsSql.append("	AND	A.PR_ID IN (SELECT B.PR_ID FROM SO_PR B WHERE PR_ID = ? AND B.LINE_STATUS NOT IN ('003','999','PD') ) \n"); //7 PR_ID

		String strMenuMod = sbInsSql.toString();
		pstmt4 = conn.prepareStatement(strMenuMod);

		//	자재 추가시	로그테이블에 Insert
		sbInsSql.delete(0, sbInsSql.length());
		sbInsSql.append("INSERT	INTO SO_PR_MENU_LOG				\n");
		sbInsSql.append("( PR_ID								\n");
		sbInsSql.append(", PR_NUM								\n");
		sbInsSql.append(", PR_DATE								\n");
		sbInsSql.append(", PR_DEPT_ID							\n");
		sbInsSql.append(", PR_UPJANG							\n");
		sbInsSql.append(", PR_SABUN								\n");
		sbInsSql.append(", APPROVER								\n");
		sbInsSql.append(", APPROVE_TIME							\n");
		sbInsSql.append(", APPROVE_NUM							\n");
		sbInsSql.append(", PO_TYPE								\n");
		sbInsSql.append(", DOCU_SOURCE							\n");
		sbInsSql.append(", CUSTCD								\n");
		sbInsSql.append(", SUBINV_CODE							\n");
		sbInsSql.append(", RC_MU_CD								\n");
		sbInsSql.append(", RC_DEPT_ID							\n");
		sbInsSql.append(", RC_UPJANG							\n");
		sbInsSql.append(", CENTER_CODE							\n");
		sbInsSql.append(", ITEM_CODE							\n");
		sbInsSql.append(", ITEM_NAME							\n");
		sbInsSql.append(", ITEM_SIZE							\n");
		sbInsSql.append(", PO_UOM								\n");
		sbInsSql.append(", TAX_CODE								\n");
		sbInsSql.append(", BUDDEPT_ID							\n");
		sbInsSql.append(", ACCTCD								\n");
		sbInsSql.append(", BUD_CLS								\n");
		sbInsSql.append(", CENTER_FLAG							\n");
		sbInsSql.append(", UNIT_PRICE							\n");
		sbInsSql.append(", MARGIN_PRICE							\n");
		sbInsSql.append(", SALE_PRICE							\n");
		sbInsSql.append(", PR_QTY								\n");
		sbInsSql.append(", PO_QTY								\n");
		sbInsSql.append(", NEED_DATE							\n");
		sbInsSql.append(", INVAT_FLAG							\n");
		sbInsSql.append(", OUTVAT_FLAG							\n");
		sbInsSql.append(", MENU_QTY								\n");
		sbInsSql.append(", PR_REMARK							\n");
		sbInsSql.append(", LINE_STATUS							\n");
		sbInsSql.append(", CREATE_BY							\n");
		sbInsSql.append(", UPDATE_BY							\n");
		sbInsSql.append(", VD_SN								\n");
		sbInsSql.append(", APPLY_SD								\n");
		sbInsSql.append(", ORG_PR_NUM							\n");
		sbInsSql.append(", UPJANG_GRP							\n");
		sbInsSql.append(", REMARK							\n");
		sbInsSql.append("  ) VALUES	(  \n");
		sbInsSql.append(" SO_PR_MENU_LOG_S.NEXTVAL				\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS')	\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", 0									\n");
		sbInsSql.append(", ROUND(?,1)							\n");
		sbInsSql.append(", ROUND(?,1)							\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(", ?									\n");
		sbInsSql.append(")										\n");

		String strLogInsert = sbInsSql.toString();
		pstmt6 = conn.prepareStatement(strLogInsert);

		/************************************************************************************************
			SQL	생성 끝
		 ************************************************************************************************/

		/************************************************************************************************
			추가된 자재는 신규 PR_NUM으로 SO_PR에 INSERT
			변경된 자재는 UPDATE
		 ************************************************************************************************/
		iUpdateCnt = 0; // 구매신청	수정건수
		iAddCnt = 0; // 구매신청	추가건수
		iMenuAddCnt = 0; // 식단에 의한 구매신청	추가 건수
		iMenuModCnt = 0; // 식단에 의한 구매신청	변경삭제 건수
		
		//System.out.println(" DataSet.ROW_TYPE_NORMAL	>> "+ DataSet.ROW_TYPE_NORMAL);
		//System.out.println(" DataSet.ROW_TYPE_UPDATED	>> "+ DataSet.ROW_TYPE_UPDATED);
		//System.out.println(" DataSet.ROW_TYPE_INSERTED	>> "+ DataSet.ROW_TYPE_INSERTED);
		//System.out.println(" DataSet.ROW_TYPE_DELETED	>> "+ DataSet.ROW_TYPE_DELETED);
		
		System.out.println(" DataSet.ROW_TYPE_NAME_NORMAL	>> "+ DataSet.ROW_TYPE_NAME_NORMAL);
		System.out.println(" DataSet.ROW_TYPE_NAME_UPDATED	>> "+ DataSet.ROW_TYPE_NAME_UPDATED);
		System.out.println(" DataSet.ROW_TYPE_NAME_INSERTED	>> "+ DataSet.ROW_TYPE_NAME_INSERTED);
		System.out.println(" DataSet.ROW_TYPE_NAME_DELETED	>> "+ DataSet.ROW_TYPE_NAME_DELETED);
		
		String lineStatus = "";		
		for (int i = 0; i < ds_pr_item.getRowCount(); i++) {
			lineStatus = "";
			// 수정건에	대한 로직
			if (ds_pr_item.getRowType(i) == DataSet.ROW_TYPE_UPDATED || ds_pr_item.getRowType(i) == DataSet.ROW_TYPE_NORMAL) {
				
				//식단정보부터 업데이트하도록 변경 20181115 김호석
				//(취소후 살아나는 PR_ID 방지 체크 전에 식단정보부터 업데이트 필요, SO_PR부터 업데이트 하면 상태가 바뀐 뒤에 식단정보 입력 시에는 업데이트 전 상태를 확인 불가)
				if (PO_TYPE.equals("04")) {
					// 식단정보	업데이트
					pstmt4.setString(1, "Y"); // 신청YN
					pstmt4.setString(2, ds_pr_item.getString(i, "ORG_PR_NUM")); // 구매신청번호
					pstmt4.setDouble(3, Double.parseDouble(ds_pr_item.getString(i, "PR_QTY"))); // 자재신청건수
					pstmt4.setLong  (4, Long.parseLong(ds_pr_item.getString(i, "PR_ID"))); // 구매신청번호
					pstmt4.setString(5, PR_SABUN); // 변경자 아이디
					pstmt4.setLong  (6, Long.parseLong(ds_pr_item.getString(i, "PR_ID"))); // 구매신청라인ID
					//pstmt4.setLong  (7, Long.parseLong(ds_pr_item.getString(i, "PR_ID"))); // 구매신청라인ID

					pstmt4.addBatch();
					iMenuModCnt++;
				}
				
				pstmt1.setDouble(1, Double.parseDouble(ds_pr_item.getString(i, "PR_QTY"))); // 구매갯수
				pstmt1.setString(2, nullToBlank(ds_pr_item.getString(i, "PR_REMARK"))); // 비고
				pstmt1.setString(3, PR_SABUN); // 변경자 아이디
				pstmt1.setString(4, MOBILE_GUBUN); // 신청구분
				pstmt1.setString(5, STATUS); // 신청저장 & 확정
				pstmt1.setString(6, nullToBlank(ds_pr_item.getString(i, "ORG_PR_NUM"))); // 구매신청번호
				
				//System.out.println(" DataSet.getRowType	>> "+ ds_pr_item.getRowType(i));
				//System.out.println(" DataSet.PR_ID	>> "+ ds_pr_item.getString(i, "PR_ID"));			
				
				pstmt1.setLong  (7, Long.parseLong(ds_pr_item.getString(i, "PR_ID"))); // 구매신청라인ID
				pstmt1.addBatch();
				iUpdateCnt++;

				// 2017.10.17 김호석 수정 배송중인건은 제외하고 유효성체크 추가
				lineStatus = nullToBlank(ds_pr_item.getString(i, "LINE_STATUS")); //진행상황

				// 수정된 자재일 경우 유효성체크에 포함
				if(ds_pr_item.getRowType(i) == DataSet.ROW_TYPE_UPDATED) {
					// 2017.10.17 김호석 수정 배송중인건은 제외하고 유효성체크 추가
					if (!lineStatus.equals("DL")) { //배송중인 건은 제외
						strValiPrId = strValiPrId + ds_pr_item.getString(i, "PR_ID") + ",";
					}
				}
			}

			// 추가건에	대한 로직
			else if (ds_pr_item.getRowType(i) == DataSet.ROW_TYPE_INSERTED) {
				//System.out.println(" 추가건에	대한 로직 start	>> "+ i);
				String strPrID = "";

				//====================>	신규 PR_ID 생성	시작
				sbSelSql.delete(0, sbSelSql.length());
				sbSelSql.append("SELECT	TO_CHAR(SO_PR_S.NEXTVAL) PR_ID FROM	DUAL \n");

				stmt = conn.createStatement();
				rs = stmt.executeQuery(sbSelSql.toString());

				rs.next();

				strPrID = rs.getString("PR_ID");

				// 신규 자재일 경우 유효성체크에 포함
				//System.out.println(" 추가추가추가	>> "+ ds_pr_item.getRowType(i));
				strValiPrId = strValiPrId + strPrID + ",";

				rs.close();
				stmt.close();
				//====================>	신규 PR_ID 생성	끝

				pstmt2.setLong(1, Long.parseLong(strPrID));
				// 확정된 신청에 대해서	추가된 자재는 새로운 PR_NUM으로	INSERT하고 임시저장건은	기존 신청서의 PR_NUM를 INSERT
				if (LINE_STATUS.equals("001")) {
					pstmt2.setString(2, strOrgPrNum);
				} else {
					pstmt2.setString(2, strAddPrNum);
				}
				pstmt2.setString(3, PR_DATE);
				pstmt2.setString(4, PR_DEPT_ID);
				pstmt2.setDouble(5, Double.parseDouble(PR_UPJANG));
				pstmt2.setString(6, PR_SABUN);
				pstmt2.setString(7, PR_SABUN);
				pstmt2.setString(8, strAprNum);
				pstmt2.setString(9, PO_TYPE);
				pstmt2.setString(10, "07 FS");
				pstmt2.setDouble(11, Double.parseDouble(ds_pr_item.getString(i, "CUSTCD")));
				pstmt2.setString(12, ds_pr_item.getString(i, "SUBINV_CODE"));
				pstmt2.setString(13, ds_pr_item.getString(i, "MU_CD"));
				pstmt2.setString(14, ds_pr_item.getString(i, "DEPT_ID"));
				pstmt2.setDouble(15, Double.parseDouble(ds_pr_item.getString(i, "UPJANG")));
				pstmt2.setDouble(16, Double.parseDouble(ds_pr_item.getString(i, "CENTER_CODE")));
				pstmt2.setString(17, ds_pr_item.getString(i, "ITEM_CODE"));
				pstmt2.setString(18, ds_pr_item.getString(i, "ITEM_NAME"));
				pstmt2.setString(19, nullToBlank(ds_pr_item.getString(i, "ITEM_SIZE")));
				pstmt2.setString(20, nullToBlank(ds_pr_item.getString(i, "PO_UOM")));
				pstmt2.setString(21, nullToBlank(ds_pr_item.getString(i, "TAX_CODE")));
				pstmt2.setString(22, nullToBlank(ds_pr_item.getString(i, "BUDDEPT_ID")));
				pstmt2.setString(23, nullToBlank(ds_pr_item.getString(i, "ACCTCD")));
				pstmt2.setString(24, nullToBlank(ds_pr_item.getString(i, "BUD_CLS")));
				pstmt2.setString(25, ds_pr_item.getString(i, "CENTER_FLAG"));
				pstmt2.setDouble(26, Double.parseDouble(ds_pr_item.getString(i, "UNIT_PRICE")));
				pstmt2.setDouble(27, Double.parseDouble(ds_pr_item.getString(i, "MARGIN_PRICE")));
				pstmt2.setDouble(28, Double.parseDouble(ds_pr_item.getString(i, "PR_QTY")));
				pstmt2.setDouble(29, Double.parseDouble(ds_pr_item.getString(i, "PR_QTY")));
				pstmt2.setString(30, nullToBlank(ds_pr_item.getString(i, "NEED_DATE")));
				pstmt2.setString(31, nullToBlank(ds_pr_item.getString(i, "INVAT_FLAG")));
				pstmt2.setString(32, nullToBlank(ds_pr_item.getString(i, "OUTVAT_FLAG")));
				pstmt2.setDouble(33, Double.parseDouble(nullToZero(ds_pr_item.getString(i, "KG_QTY"))));
				pstmt2.setString(34, nullToBlank(ds_pr_item.getString(i, "PR_REMARK")));
				pstmt2.setString(35, STATUS);
				pstmt2.setString(36, PR_SABUN);
				pstmt2.setString(37, PR_SABUN);
				pstmt2.setString(38, nullToBlank(ds_pr_item.getString(i, "VD_SN")));
				pstmt2.setString(39, nullToBlank(ds_pr_item.getString(i, "APPLY_SD")));
				pstmt2.setString(40, MOBILE_GUBUN);
				pstmt2.setString(41, strOrgPrNum);
				pstmt2.setString(42, nullToBlank(ds_pr_item.getString(i, "UPJANG_GRP")));
				pstmt2.setInt(43, Integer.parseInt(nullToZero(ds_pr_item.getString(i, "IS_ENF"))));
				pstmt2.addBatch();
				iAddCnt++;

				if (PO_TYPE.equals("04")) {
					// 식단정보	업데이트
					System.out.println(" 추가건에 대한 식단정보	업데이트 start >> " + i);
					pstmt3.setString(1, strOrgPrNum);
					pstmt3.setLong(2, Long.parseLong(strPrID));
					pstmt3.setDouble(3, Double.parseDouble(nullToZero(ds_pr_item.getString(i, "PR_QTY"))));
					pstmt3.setDouble(4, Double.parseDouble(nullToZero(ds_pr_item.getString(i, "UNIT_PRICE"))));
					pstmt3.setDouble(5, Double.parseDouble(nullToZero(ds_pr_item.getString(i, "MARGIN_PRICE"))));
					pstmt3.setDouble(6, Double.parseDouble(nullToZero(ds_pr_item.getString(i, "MARGIN_RATE"))));
					pstmt3.setString(7, PR_SABUN);
					pstmt3.setString(8, NEED_DATE);
					pstmt3.setString(9, ds_pr_item.getString(i, "ITEM_CODE"));
					pstmt3.setString(10, SUBINV_CODE);
					pstmt3.setString(11, ds_pr_item.getString(i, "ITEM_CODE"));
					pstmt3.setString(12, NEED_DATE);

					pstmt3.addBatch();
					iMenuAddCnt++;
				}
			}
		}

		// 삭제건에	대해서 진행상태값을	999으로	Update
		iDeleteCnt = 0; // 구매신청	삭제건수

		for (int i = 0; i < ds_pr_item.getRemovedRowCount(); i++) {
			lineStatus = "";
			
			//식단정보부터 업데이트하도록 변경 20181115 김호석
			//(취소후 살아나는 PR_ID 방지 체크 전에 식단정보부터 업데이트 필요, SO_PR부터 업데이트 하면 상태가 바뀐 뒤에 식단정보 입력 시에는 업데이트 전 상태를 확인 불가)
			if (PO_TYPE.equals("04")) {
				// 식단정보	업데이트
				System.out.println("식단정보 업데이트 >> ");
				pstmt4.setString(1, "N"); // 신청YN
				pstmt4.setString(2, ""); // 구매신청번호
				pstmt4.setDouble(3, 0); // 자재신청건수
				pstmt4.setString(4, ""); // 구매신청번호
				pstmt4.setString(5, PR_SABUN); // 변경자 아이디
				//pstmt4.setString(6, NEED_DATE); // 입고일자
				pstmt4.setString(6, ds_pr_item.getRemovedStringData(i, "PR_ID")); // 구매신청라인ID
				//pstmt4.setString(8, ds_pr_item.getString(i,"ORG_PR_NUM"));	// 구매신청번호
				pstmt4.addBatch();
				iMenuModCnt++;
			}
			
			//System.out.println(" 신청서에서 자재가 삭제되는건은 999로	저장 >>	"+ i);
			//	신청서에서 자재가 삭제되는건은 999로 저장
			pstmt5.setString(1, nullToBlank(ds_pr_item.getRemovedStringData(i, "PR_REMARK"))); // 비고
			pstmt5.setString(2, nullToBlank(ds_pr_item.getRemovedStringData(i, "REMARK"))); // 비고
			pstmt5.setString(3, PR_SABUN); // 변경자 아이디
			pstmt5.setString(4, MOBILE_GUBUN); // 신청구분
			pstmt5.setString(5, nullToBlank(ds_pr_item.getRemovedStringData(i, "ORG_PR_NUM"))); // 구매신청번호
			pstmt5.setString(6, nullToBlank(ds_pr_item.getRemovedStringData(i, "PR_ID"))); // 구매신청라인ID
			pstmt5.addBatch();
			iDeleteCnt++;
			
			// 2017.10.17 김호석 수정 배송중인건은 제외하고 유효성체크 추가
			lineStatus = nullToBlank(ds_pr_item.getString(i, "LINE_STATUS")); //진행상황
			PR_YN = nullToBlank(ds_pr_item.getRemovedStringData(i, "PR_YN")); //유효성 체크 YN
			//System.out.println("1. PR_YN : " + PR_YN);

			// 삭제건에 대한 로직
			//strValiPrId = strValiPrId + ds_pr_item.getString(i, "PR_ID") + ",";
			//2016.02.29 최학진 삭제 할때 기존의 PR_ID를 넣으니까 전부다 유효성 체크를 한다.
			//2017.10.17 김호석 수정 배송중인건, 신청저장인 경우 제외하고 유효성체크 추가(발주완료인 경우는 체크해야함)
			if (!lineStatus.equals("DL") && !lineStatus.equals("001") ) { //배송중,신청저장인 건은 제외
				//유효성 체크 중 수발주 제한을 제외한 나머지는 삭제 시 유효성 체크하지 않도록 수정 2018.03.22 김호석(이혜은 과장 요청)
			    //2018.04.02 모든 유효성 체크된 자재는 삭제 못하도록(수정/삭제 모두 불가) 다시 변경(이혜은, 윤지혜, 염병문 확인)
				//if (PR_YN.equals("Y")) {
					strValiPrId = strValiPrId + nullToBlank(ds_pr_item.getRemovedStringData(i, "PR_ID"))  + ",";
				//}
			}
			//System.out.println("lineStatus >>	"+ lineStatus);
			//System.out.println("strValiPrId >>	"+ strValiPrId);			
			
		}

		//식단자동일 경우	삭제된 자재정보를 저장한다.
		int iLogCnt = 0;
		if (PO_TYPE.equals("04")) {
			// 로그테이블에서 기존 내역	삭제
			sbInsSql.delete(0, sbInsSql.length());
			
			sbInsSql.append("DELETE	SO_PR_MENU_LOG						\n");
			sbInsSql.append("WHERE ORG_PR_NUM =	'" + strOrgPrNum + "'	\n");

			stmt = conn.createStatement();
			stmt.execute(sbInsSql.toString());

			stmt.close();

			for (int i = 0; i < ds_del_item.getRowCount(); i++) {
				pstmt6.setString(1, strOrgPrNum);
				pstmt6.setString(2, PR_DATE);
				pstmt6.setDouble(3, Double.parseDouble(PR_DEPT_ID));
				pstmt6.setDouble(4, Double.parseDouble(PR_UPJANG));
				pstmt6.setString(5, PR_SABUN);
				if (STATUS.equals("002")) {
					pstmt6.setString(6, PR_SABUN);
					pstmt6.setString(7, strAprNum);
				} else {
					pstmt6.setString(6, "");
					pstmt6.setString(7, "");
				}
				pstmt6.setString(8, PO_TYPE);
				pstmt6.setString(9, "01	BO");
				pstmt6.setDouble(10, Double.parseDouble(nullToZero(ds_del_item.getString(i, "CUSTCD"))));
				pstmt6.setString(11, ds_del_item.getString(i, "SUBINV_CODE"));
				pstmt6.setString(12, ds_del_item.getString(i, "MU_CD"));
				pstmt6.setDouble(13, Double.parseDouble(ds_del_item.getString(i, "DEPT_ID")));
				pstmt6.setDouble(14, Double.parseDouble(ds_del_item.getString(i, "UPJANG")));
				pstmt6.setDouble(15, Double.parseDouble(nullToZero(ds_del_item.getString(i, "CENTER_CODE"))));
				pstmt6.setString(16, ds_del_item.getString(i, "ITEM_CODE"));
				pstmt6.setString(17, ds_del_item.getString(i, "ITEM_NAME"));
				pstmt6.setString(18, nullToBlank(ds_del_item.getString(i, "ITEM_SIZE")));
				pstmt6.setString(19, nullToBlank(ds_del_item.getString(i, "PO_UOM")));
				pstmt6.setString(20, nullToBlank(ds_del_item.getString(i, "TAX_CODE")));
				pstmt6.setDouble(21, Double.parseDouble(nullToZero(ds_del_item.getString(i, "BUDDEPT_ID"))));
				pstmt6.setString(22, nullToBlank(ds_del_item.getString(i, "ACCTCD")));
				pstmt6.setString(23, nullToBlank(ds_del_item.getString(i, "BUD_CLS")));
				pstmt6.setString(24, nullToBlank(ds_del_item.getString(i, "CENTER_FLAG")));
				pstmt6.setDouble(25, Double.parseDouble(nullToZero(ds_del_item.getString(i, "UNIT_PRICE"))));
				pstmt6.setDouble(26, Double.parseDouble(nullToZero(ds_del_item.getString(i, "MARGIN_PRICE"))));
				pstmt6.setDouble(27, Double.parseDouble(nullToZero(ds_del_item.getString(i, "PR_QTY"))));
				pstmt6.setDouble(28, Double.parseDouble(nullToZero(ds_del_item.getString(i, "PR_QTY"))));
				pstmt6.setString(29, nullToBlank(ds_del_item.getString(i, "NEED_DATE")));
				pstmt6.setString(30, nullToBlank(ds_del_item.getString(i, "INVAT_FLAG")));
				pstmt6.setString(31, nullToBlank(ds_del_item.getString(i, "OUTVAT_FLAG")));
				pstmt6.setDouble(32, Double.parseDouble(nullToZero(ds_del_item.getString(i, "KG_QTY"))));
				pstmt6.setString(33, nullToBlank(ds_del_item.getString(i, "PR_REMARK")));
				pstmt6.setString(34, STATUS);
				pstmt6.setString(35, PR_SABUN);
				pstmt6.setString(36, PR_SABUN);
				pstmt6.setString(37, nullToBlank(ds_del_item.getString(i, "VD_SN")));
				pstmt6.setString(38, nullToBlank(ds_del_item.getString(i, "APPLY_SD")));
				pstmt6.setString(39, strOrgPrNum);
				pstmt6.setString(40, nullToBlank(ds_del_item.getString(i, "UPJANG_GRP")));
				pstmt6.setString(41, nullToBlank(ds_del_item.getString(i, "REMARK")));
				pstmt6.addBatch();
				iLogCnt++;
			}
		}
		/*	System.out.println("결과	수정건수 >>	"+ iUpdateCnt);
		 System.out.println("결과 추가건수 >> "+	iAddCnt);
		 System.out.println("결과 메뉴추가건수 >> "+	iMenuAddCnt);
		 System.out.println("결과 메뉴수정건수 >> "+	iMenuModCnt);
		 System.out.println("결과 삭제건수건수 >> "+	iDeleteCnt);
		 System.out.println("결과 로그자재건수 >> "+	iLogCnt); */

		if (iUpdateCnt > 0)
			pstmt1.executeBatch();
		if (iMenuModCnt > 0)
			pstmt4.executeBatch();
		if (iAddCnt > 0)
			pstmt2.executeBatch();
		if (iMenuAddCnt > 0)
			pstmt3.executeBatch();
		if (iDeleteCnt > 0)
			pstmt5.executeBatch();
		if (iLogCnt > 0)
			pstmt6.executeBatch();

		//	삭제전 신청서 수정중  결의 작업이 있었는지 점검
		sbSelSql.delete(0, sbSelSql.length());

		sbSelSql.append("SELECT	/*+	PUSH_PRED(A) */	B.ITEM_CODE	|| ' ' || B.ITEM_NAME AS ITEM_NAME	\n");
		sbSelSql.append("  FROM	HLDC_PO_PO A														\n");
		sbSelSql.append("	  ,	SO_PR B																\n");
		sbSelSql.append(" WHERE	A.PO_ID	 = B.PR_ID													\n");
		sbSelSql.append("	AND	A.PO_NUM = B.PR_NUM													\n");
		//sbSelSql.append("	AND	A.LINE_STATUS IN ('DL','GC','IV')									\n"); //FM0037 - 진행상태코드		
		// 김호석 수정 2017.10.17 배송중인건은 제외하는 구매프로시저 수정(배송중인 건이 포함되어도 수정가능)
		sbSelSql.append("	AND	A.LINE_STATUS IN ('GC','IV')									\n"); //FM0037 - 진행상태코드
		sbSelSql.append("	AND	B.ORG_PR_NUM  =	'" + strOrgPrNum + "'								\n");
		sbSelSql.append("	AND	ROWNUM = 1															\n");

		stmt = conn.createStatement();
		rs = stmt.executeQuery(sbSelSql.toString());

		if (rs.next()) {
			out_vl.add("fv_PoItemName", rs.getString("ITEM_NAME"));
			this.setResultMessage(0, "OK", out_vl);
			conn.rollback();
			proc_output(response, out, out_vl, out_dl);
			rs.close();
			return;
		}

		// 유형별 D_DAY, D_TIME 가능한지 체크
		sbSelSql.delete(0, sbSelSql.length());

		sbSelSql.append("SELECT A.D_DAYS                                                                                                                                \n");
		sbSelSql.append("     , A.D_TIMES                                                                                                                               \n");
		sbSelSql.append("     , A.TYPE_NAME                                                                                                                             \n");
		sbSelSql.append("     , CASE WHEN TO_CHAR(TO_DATE('"+NEED_DATE+"') - A.D_DAYS + (A.D_TIMES/24), 'YYYYMMDDHH24') <= TO_CHAR(SYSDATE, 'YYYYMMDDHH24') THEN 'Y'    \n");
		sbSelSql.append("\n          ELSE 'N'                                                                                                                           \n");
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
		
		//최학진 신청서 수정을 통해서 들어 갈경우에는 5분 종복 체크 로직 빠져있어서 추가
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
		

		String strItemList = ""; // 유효성체크 자재
		// 수정된자재나 추가된 자재가 있을경우에만 구매신청 유효성체크 진행(삭제된 자재(신청저장 시 제외)도 체크 추가 2018.01.31 김호석, 이혜은과장 요청)
		if (STATUS.equals("002")) {
			sbSelSql.delete(0, sbSelSql.length());

			sbSelSql.append("	 SELECT	t.*																																			\n");
			sbSelSql.append("	   FROM	(																																			\n");
			sbSelSql.append("	   SELECT A.ITEM_CODE																																\n");
			sbSelSql.append("		, A.ITEM_NAME																																	\n");
			sbSelSql.append("		, A.CENTER_CODE																																	\n");
			sbSelSql.append("		, A.RC_UPJANG																																	\n");
			sbSelSql.append("		, A.CENTER_FLAG																																	\n");
			sbSelSql.append("		, (SELECT CASE WHEN	VAL_SHP_CNT	IN ('CE', 'NN')	THEN '자재 업장군 맵핑 유효성 체크 오류'														\n");
			sbSelSql.append("				       WHEN	VAL_UNS_CNT	IN ('UK', 'NN')	THEN '자재 불용체크	오류'																		\n");
			sbSelSql.append("				       WHEN	VAL_STP_CNT	IN ('TK', 'NN')	THEN '자재 중지체크	오류'																		\n");
			sbSelSql.append("				       WHEN	VAL_EVT_CNT	IN ('VE', 'NN')	THEN '기획자재 한정수량체크	오류'																\n");
			sbSelSql.append("				       WHEN	VAL_CTR_CNT	IN ('SE', 'NN')	THEN 'SPOT계약 발주횟수체크	오류'																\n");
			sbSelSql.append("				       WHEN	VAL_REQ_CNT	IN ('XE', 'NN')	THEN '요일별 신청불가 체크 오류'																\n");
			sbSelSql.append("				       WHEN	VAL_SCH_CNT	IN ('HE', 'NN')	THEN '수발주 스케쥴에 따른 유효성 체크 오류'													\n");
			sbSelSql.append("				       WHEN	A.CENTER_FLAG =	'DC'																										\n");
			sbSelSql.append("				  AND EPROCUSR.FC_GET_CENTER_IVT_YN('100',	'HFC', A.CENTER_CODE, A.ITEM_CODE, A.PR_QTY) = 'N' THEN	'DC자재	수량체크 오류'				\n");
			sbSelSql.append("			      ELSE 'OK'	END																															\n");
			sbSelSql.append("			 FROM TABLE(EPROCUSR.FN_ITEM_PROCURE_VALIDATE('100', 'HFC',	(SELECT	OPER_ORG_SN_PURC FROM HLDC_PO_CENTER WHERE CENTER_CODE = A.CENTER_CODE)	\n");
			sbSelSql.append("								  ,	A.ITEM_CODE, A.VD_SN, A.APPLY_SD, A.PR_QTY,	A.UPJANG_GRP, '01'														\n");
			sbSelSql.append("								  ,	FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_DAYS')																\n");
			sbSelSql.append("								  ,	FMS_PREORDER_FUN(A.CENTER_CODE,A.ITEM_CODE,'D_TIMES'), TO_CHAR(SYSDATE, 'YYYYMMDD'), '" + NEED_DATE + "'))						\n");
			sbSelSql.append("		  )	AS ITEM_VAL																																	\n");
			sbSelSql.append("		 FROM SO_PR	A																																	\n");
			sbSelSql.append("		WHERE A.ORG_PR_NUM	= '" + strOrgPrNum + "'																										\n");			
			if(strValiPrId.length() > 0) {
				sbSelSql.append("		  AND A.PR_ID IN (" + strValiPrId.substring(0, strValiPrId.length() - 1) + ")														        \n");
		    }
			//유효성체크할 자재가 없는 경우 체크 SKIP 2018.02.08 김호석(신청저장에서 삭제만 할 경우 유효성 체크 없어야함, 발주완료에서 삭제할 경우는 유효성 체크함) 
			if(strValiPrId.length() == 0) {
				sbSelSql.append("		  AND A.PR_ID = 0														        \n");
			}
			//삭제된 자재도 유효성 체크필요 2018.01.31 김호석 
			sbSelSql.append("		  AND A.LINE_STATUS	IN ('002','999') 																													\n");
			sbSelSql.append("		  ) t																													\n");
			sbSelSql.append("	WHERE t.ITEM_VAL <>	'OK'																															\n");

			System.out.println("유효성체크대상 : " + strValiPrId);

			stmt = conn.createStatement();
			rs = stmt.executeQuery(sbSelSql.toString());

			DataSet ds_save_out = this.makeDataSet(rs, "ds_save_out");
			
			
			
			out_dl.add(ds_save_out);

			// 모바일에서는 정상코드를 보내야 데이터셋을 리턴 받을수 있다고 해서 모바일일 경우 정상코드로 에러메시지 분기
			if (ds_save_out.getRowCount() > 0) {
				if (MOBILE_GUBUN.equals("M")) {
					this.setResultMessage(1,  "구매신청 불가 자재가 존재합니다.", out_vl);
				} else {
					this.setResultMessage(-1, "구매신청 불가 자재가 존재합니다.", out_vl);
				}

				conn.rollback();
				
				//유효성체크 자재리스트
				if (rs.next()) {
					
					if (strItemList == "") {
						strItemList = strItemList + rs.getString("ITEM_CODE") + "(" + rs.getString("ITEM_NAME") +")";
					} else {
						strItemList = strItemList + ", " + rs.getString("ITEM_CODE") + "(" + rs.getString("ITEM_NAME") +")";
					}
					
				}				
				out_vl.add("fv_closeRamak", strItemList);
				
				proc_output(response, out, out_vl, out_dl);
				rs.close();
				return;
			}
			rs.close();
			stmt.close();
		}

		rs.close();
		stmt.close();

		// 확정시 구매 프로시져	호출
		if (STATUS.equals("002")) {

			//추가건이 존재하거나 신청서상태가 임시저장이였을경우
			if (iAddCnt > 0 || LINE_STATUS.equals("001")) {

				// 해당 prnum에 대해 PO에 존재하는지 체크 (중복 체크)
				sbSelSql.delete(0, sbSelSql.length());
	            sbSelSql.append("SELECT COUNT(*) AS PO_CNT             \n");
	            sbSelSql.append("  FROM HLDC_PO_PO                     \n");
	            if (LINE_STATUS.equals("001")) {
	            	sbSelSql.append(" WHERE PO_NUM = '" + strOrgPrNum + "'	   \n");
	            } else {
	            	sbSelSql.append(" WHERE PO_NUM = '" + strAddPrNum + "'	   \n");
	            }
	            sbSelSql.append("   AND PO_TYPE = '" + PO_TYPE + "'	   \n");

				stmt = conn.createStatement();
				rs = stmt.executeQuery(sbSelSql.toString());
				rs.next();

				if(!rs.getString("PO_CNT").equals("0")) {
					if (LINE_STATUS.equals("001")) {
						this.setResultMessage(-1, "해당 구매신청건에 대해 중복신청 되었습니다. - 신청번호 : " + strOrgPrNum, out_vl);
					} else {
						this.setResultMessage(-1, "해당 구매신청건에 대해 중복신청 되었습니다. - 신청번호 : " + strAddPrNum, out_vl);
					}
					conn.rollback();
					proc_output(response,out,out_vl,out_dl);
					return;
				}
				rs.close();
				stmt.close();

				cstmt1 = conn.prepareCall("{call EPROCUSR.SP_IF_SALES_ORDER(?, ?, ?, ?,	?, ?, ?, ?,	?, ?, ?)}");
				// 김호석 수정 2017.10.17 배송중인건은 제외하는 구매프로시저 수정 
				//cstmt1 = conn.prepareCall("{call EPROCUSR.SP_IF_SALES_ORDER_NON_DL(?, ?, ?, ?,	?, ?, ?, ?,	?, ?, ?)}");
				cstmt1.setString(1, "100");
				cstmt1.setString(2, "HFC");
				cstmt1.setString(3, "FR");
				cstmt1.setString(4, strItemtype);
				cstmt1.setString(5, RC_UPJANG);
				cstmt1.setString(6, PR_SABUN);
				cstmt1.setString(7, PO_TYPE);
				if (LINE_STATUS.equals("001")) {
					cstmt1.setString(8, strOrgPrNum);
				} else {
					cstmt1.setString(8, strAddPrNum);
				}
				cstmt1.setString(9, "C");
				cstmt1.registerOutParameter(10, Types.VARCHAR);
				cstmt1.registerOutParameter(11, Types.VARCHAR);
				cstmt1.execute();

				if (!cstmt1.getString(10).equals("S000")) {
					conn.rollback();
					this.setResultMessage(-1, cstmt1.getString(11), out_vl);
					proc_output(response, out, out_vl, out_dl);
					cstmt1.close();
					return;
				}
				cstmt1.close();
			} //추가건이 존재할경우 END

			// 변경건이	존재할경우
			String strPrNum = "";
			//System.out.println("수정 구매프로시져 호출 111!"); 
			if (iUpdateCnt > 0 && !LINE_STATUS.equals("001")) {
				//System.out.println("수정 구매프로시져 호출 START!");
				for (int i = 0; i < ds_pr_item.getRowCount(); i++) {
					//System.out.println("수정 구매프로시져 호출 222!");
					if (ds_pr_item.getRowType(i) == DataSet.ROW_TYPE_UPDATED && !strPrNum.equals(ds_pr_item.getString(i, "PR_NUM"))) {
						//System.out.println("수정 구매프로시져 호출 333!");

						strPrNum = ds_pr_item.getString(i, "PR_NUM");
						System.out.println("수정 구매프로시져 호출 >>>>" + strPrNum);

						cstmt2 = conn.prepareCall("{call EPROCUSR.SP_IF_SALES_ORDER(?, ?, ?, ?,	?, ?, ?, ?,	?, ?, ?)}");
						// 김호석 수정 2017.10.17 배송중인건은 제외하는 구매프로시저 수정 
						//cstmt2 = conn.prepareCall("{call EPROCUSR.SP_IF_SALES_ORDER_NON_DL(?, ?, ?, ?,	?, ?, ?, ?,	?, ?, ?)}");
						cstmt2.setString(1, "100");
						cstmt2.setString(2, "HFC");
						cstmt2.setString(3, "FR");
						cstmt2.setString(4, strItemtype);
						cstmt2.setString(5, RC_UPJANG);
						cstmt2.setString(6, PR_SABUN);
						cstmt2.setString(7, PO_TYPE);

						cstmt2.setString(8, strPrNum);
						cstmt2.setString(9, "U");
						cstmt2.registerOutParameter(10, Types.VARCHAR);
						cstmt2.registerOutParameter(11, Types.VARCHAR);
						cstmt2.execute();

						if (!cstmt2.getString(10).equals("S000")) {
							conn.rollback();
							this.setResultMessage(-1, cstmt2.getString(11), out_vl);
							proc_output(response, out, out_vl, out_dl);
							cstmt2.close();
							return;
						}
						cstmt2.close();
					}
				}
			} // 변경건이	존재할경우 END

			strPrNum = "";
			if (iDeleteCnt > 0 && !LINE_STATUS.equals("001")) {
				for (int i = 0; i < ds_pr_item.getRemovedRowCount(); i++) {
					if (!strPrNum.equals(ds_pr_item.getRemovedStringData(i, "PR_NUM"))) {

						strPrNum = ds_pr_item.getRemovedStringData(i, "PR_NUM");
						System.out.println("삭제 구매프로시져 호출 >>>>" + strPrNum);

						cstmt2 = conn.prepareCall("{call EPROCUSR.SP_IF_SALES_ORDER(?, ?, ?, ?,	?, ?, ?, ?,	?, ?, ?)}");
						// 김호석 수정 2017.10.17 배송중인건은 제외하는 구매프로시저 수정 
						//cstmt2 = conn.prepareCall("{call EPROCUSR.SP_IF_SALES_ORDER_NON_DL(?, ?, ?, ?,	?, ?, ?, ?,	?, ?, ?)}");
						cstmt2.setString(1, "100");
						cstmt2.setString(2, "HFC");
						cstmt2.setString(3, "FR");
						cstmt2.setString(4, strItemtype);
						cstmt2.setString(5, RC_UPJANG);
						cstmt2.setString(6, PR_SABUN);
						cstmt2.setString(7, PO_TYPE);
						cstmt2.setString(8, strPrNum);
						cstmt2.setString(9, "U");
						cstmt2.registerOutParameter(10, Types.VARCHAR);
						cstmt2.registerOutParameter(11, Types.VARCHAR);
						cstmt2.execute();

						if (!cstmt2.getString(10).equals("S000")) {
							conn.rollback();
							cstmt2.close();
							this.setResultMessage(-1, cstmt2.getString(11), out_vl);
							proc_output(response, out, out_vl, out_dl);

							return;
						}
						cstmt2.close();
					}
				}
			} // 변경건이	존재할경우 END
		} // 구매	프로시져 호출 END

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

		if (cstmt1 != null) {
			try {
				cstmt1.close();
			} catch (Exception e) {
			}
		}

		if (cstmt2 != null) {
			try {
				cstmt2.close();
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