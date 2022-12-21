<%
	/*-----------------------------------------------------------------------------
	 ■ 시스템명	: 구매관리/구매신청/신청서 전량 삭제
	 ■ 프로그램ID	: FSP00030E_T008.jsp
	 ■ 프로그램명	: 구매신청(신청서삭제)
	 ■ 작성일자	: 2015-07-11
	 ■ 작성자	    : 정영철
	 ■ 이력관리	: 2015-07-11
	 -----------------------------------------------------------------------------*/
%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="../../sc/main/common.jsp"%>
<%
	Statement stmt = null;
	CallableStatement cstmt = null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		String p_PrNum      = in_vl.getString("p_PrNum");		// 구매번호
		String p_PoType     = in_vl.getString("p_PoType");		// 구매유형(HLDC_PO_TYPE_FS - 04:식자재_자동(FS), 05:식자재_추가(FS), 11:매점상품, 99:식자재_추가(외식))
		String p_NeedDate   = in_vl.getString("p_NeedDate");	// 입고예정일자
		String p_SubinvCode = in_vl.getString("p_SubinvCode");	// 창고코드
		String g_EmpNo      = in_vl.getString("g_EmpNo");		// 사원번호
		String p_RcUpjang   = in_vl.getString("p_RcUpjang");	// 신청업장
		String p_LineStatus = in_vl.getString("p_LineStatus");	// 진행상황코드(공통코드:FM0037)
		
		conn.setAutoCommit(false);

		StringBuffer sbInsSql = new StringBuffer();
		
		//삭제 시 배송중/D-day 체크 추가 2018.01.30 김호석 이혜은과장 요청 시작
		StringBuffer sbSelSql = new StringBuffer();
		
		sbSelSql.delete(0, sbSelSql.length());

		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("SELECT D.*, TO_CHAR(sysdate+D.D_DAYS,'YYYYMMDD') AS ADATE, TO_NUMBER(TRUNC(TO_CHAR(sysdate+D.D_DAYS,'YYYYMMDD')) - TRUNC(NEED_DATE)) AS DIFF_DAY 		\n");
		sbSelSql.append("FROM (  																																			\n");		
		sbSelSql.append("SELECT A.PR_ID, A.ITEM_NAME, CASE A.LINE_STATUS WHEN '002' 																																			\n"); 
        sbSelSql.append("        THEN CASE WHEN (SELECT /*+ LEADING(IA.PODT) USE_NL(IA.PODT IA.POHD) */ COUNT(1) FROM HLDC_PO_PO IA WHERE IA.PO_ID = A.PR_ID ) > 1												\n");
        sbSelSql.append("        THEN (SELECT /*+ LEADING(IA.PODT) USE_NL(IA.PODT IA.POHD) */ IA.LINE_STATUS FROM HLDC_PO_PO IA WHERE IA.LINE_STATUS <> 'PD' AND IA.PO_ID = A.PR_ID )							\n");
        sbSelSql.append("                 ELSE (SELECT /*+ LEADING(IA.PODT) USE_NL(IA.PODT IA.POHD) */ IA.LINE_STATUS FROM HLDC_PO_PO IA WHERE IA.PO_ID = A.PR_ID )												\n");
        sbSelSql.append("            END																	 																									\n");
        sbSelSql.append("           ELSE A.LINE_STATUS																																							\n");
        sbSelSql.append("           END LINE_STATUS									/* 구매진행상황코드 */  																									\n");
        sbSelSql.append("           , B.D_DAYS AS D_DAY                                                                                                                                         \n");
        sbSelSql.append("           ,(SELECT TO_DATE('" + p_NeedDate + "','YYYYMMDD') -    TO_DATE(Z.NONHOLI_DATE,'YYYYMMDD')                                                                        \n");          
        sbSelSql.append("           FROM (SELECT ROW_NUMBER() OVER(ORDER BY Z.CD_SY||Z.CD_SM||Z.CD_SD DESC) AS    SEQ                                                                                     \n");
        sbSelSql.append("                          , Z.CD_SY||Z.CD_SM||Z.CD_SD    AS NONHOLI_DATE                                                                                                             \n");
        sbSelSql.append("                       FROM SCC_CALENDA_DATA Z                                                                                                                                       \n");
        sbSelSql.append("                      WHERE Z.CD_SY||Z.CD_SM||Z.CD_SD    < '" + p_NeedDate + "'                                                                                                       \n");
        sbSelSql.append("                        AND Z.CD_SY BETWEEN TO_NUMBER(SUBSTR('" + p_NeedDate +"', 1, 4)) - 1 AND TO_NUMBER(SUBSTR('" + p_NeedDate + "', 1, 4))                                     \n");
        sbSelSql.append("                AND Z.CD_WEEK    NOT IN ('일')) Z                                                                                                                            \n");
        sbSelSql.append("              WHERE Z.SEQ    = B.D_DAYS ) AS D_DAYS                                                                                                                               \n");   
        sbSelSql.append("           , B.D_TIMES    																																					\n");
        sbSelSql.append("			, TO_CHAR(sysdate,'YYYYMMDD') AS tday																															\n");
        sbSelSql.append("			, TO_CHAR(sysdate,'HH24') AS ttime																																\n");
        sbSelSql.append("			, A.NEED_DATE																																					\n");
        sbSelSql.append("           		FROM SO_PR A, HLDC_PO_PREORDER_LIST B  																														\n");
        sbSelSql.append("						WHERE A.ORG_PR_NUM = '" + p_PrNum + "' 																													\n");
        sbSelSql.append("           				AND A.ITEM_CODE = B.ITEM_CODE AND A.CENTER_CODE = B.CENTER_CODE  																													\n");
        sbSelSql.append(" ) D																																										\n");

		//System.out.println("체크대상 : " + p_PrNum);

		stmt = conn.createStatement();
		rs = stmt.executeQuery(sbSelSql.toString());
		
		String s_status = "";
		String s_aDate = "";
		String s_needDate = "";
		int s_tTime = 0;
		int s_d_times = 0;
		int s_diff_day = 0;
		String s_itemName = "";
		
		int dl_cnt = 0;
		int dday_cnt = 0;
		while (rs.next()) { 
			
			s_status  = rs.getString("LINE_STATUS");
			s_aDate  = rs.getString("ADATE");	
			s_needDate  = rs.getString("NEED_DATE");	
			s_tTime  = rs.getInt("TTIME");	
			s_d_times  = rs.getInt("D_TIMES");	
			s_diff_day  = rs.getInt("DIFF_DAY");
			s_itemName  = rs.getString("ITEM_NAME");
 
			//배송중인 건 있는지 체크 
			if (s_status.equals("DL")) {
				dl_cnt = dl_cnt +1;
				System.out.println("배송중 : " + s_itemName);
			}			
			//D-day 체크
			if( s_diff_day > 0) {			
				dday_cnt =dday_cnt +1;
				System.out.println("D-Day Day 제한 : " + s_itemName);				
			}

			//if( s_needDate == s_aDate) {
			if( s_diff_day == 0) {				
				if (s_d_times == 0) { 
					//패스
				} else {
					if( s_d_times <= s_tTime) {
						dday_cnt =dday_cnt +1;
						System.out.println("D-Day Time 제한 : " + s_itemName);	
					}
				}
			}
			
		}

		DataSet ds_save_out = this.makeDataSet(rs, "ds_save_out");
		out_dl.add(ds_save_out);
		
		//자재별 배송중 체크
		if (dl_cnt > 0) {
			
			this.setResultMessage(-1, "배송중인 자재가 존재합니다. ", out_vl);
			
			conn.rollback();
			proc_output(response, out, out_vl, out_dl);
			rs.close();
			return;
		}
		//자재별 D-Day 체크
		if (dday_cnt > 0) {
			
			this.setResultMessage(-1, "마감시간이 지난 자재가 존재합니다. ", out_vl);
			
			conn.rollback();
			proc_output(response, out, out_vl, out_dl);
			rs.close();
			return;
		}
		
		
		rs.close();
		stmt.close();
		//삭제 시 배송중/D-day 체크 추가 2018.01.30 김호석 이혜은과장 요청 끝		

		// 구매유형이 식자재_자동(FS)일 경우 식단정보 업데이트
		if (p_PoType.equals("04")) {
			sbInsSql.delete(0, sbInsSql.length());
			sbInsSql.append("UPDATE FSM_REAL_RECIPE_ITEM A \n");
			sbInsSql.append("   SET A.ORDER_YN = 'N' \n");
			sbInsSql.append("     , A.PR_NUM = NULL \n");
			sbInsSql.append("     , A.PR_QTY = 0 \n");
			sbInsSql.append("     , A.PR_ID  = NULL \n");
			sbInsSql.append("     , A.UDATE = SYSDATE \n");
			sbInsSql.append("     , A.UUSER = '" + g_EmpNo + "' \n");
			sbInsSql.append(" WHERE A.ORDER_YN = 'Y' \n");
			sbInsSql.append("   AND A.NEED_DATE = '" + p_NeedDate + "' \n");
			sbInsSql.append("   AND EXISTS \n");
			sbInsSql.append("       ( \n");
			sbInsSql.append("        SELECT 1 \n");
			sbInsSql.append("          FROM SO_PR C \n");
			sbInsSql.append("         WHERE C.PR_ID = A.PR_ID \n");
			sbInsSql.append("           AND C.ORG_PR_NUM = '" + p_PrNum + "' \n");
			sbInsSql.append("       ) \n");

			stmt = conn.createStatement();
			stmt.execute(sbInsSql.toString());

			stmt.close();
		}

		//신청서 취소 
		sbInsSql.delete(0, sbInsSql.length());
		sbInsSql.append("UPDATE SO_PR                           \n");
		sbInsSql.append("   SET LINE_STATUS = '003'             \n");
		sbInsSql.append("     , UPDATE_DATE = SYSDATE           \n");
		sbInsSql.append("     , UPDATE_BY   = '" + g_EmpNo + "' \n");
		sbInsSql.append(" WHERE ORG_PR_NUM  = '" + p_PrNum + "' \n");
		sbInsSql.append("   AND LINE_STATUS <> '999'            \n");

		stmt = conn.createStatement();
		stmt.execute(sbInsSql.toString());
		stmt.close();

		// ORG_PR_NUM에 여러개의 PR_NUM이 존재할수 있으므로 ORG_PR_NUM으로 PR_NUM을 조회
		sbInsSql.delete(0, sbInsSql.length());
		sbInsSql.append("SELECT PR_NUM             \n");
		sbInsSql.append("  FROM SO_PR                           \n");
		sbInsSql.append(" WHERE ORG_PR_NUM = '" + p_PrNum + "'  \n");
		sbInsSql.append(" GROUP BY PR_NUM          \n");

		stmt = conn.createStatement();
		rs = stmt.executeQuery(sbInsSql.toString());

		DataSet ds_pr_num = this.makeDataSet(rs, "ds_pr_num");

		rs.close();
		stmt.close();
		
		// 구매신청된 건에 대해서만 구매프로시져 호출 (LINE_STATUS이 002, PC 인 경우에만 호출)
		if (p_LineStatus.equals("002") || p_LineStatus.equals("PC")) {
			for (int i = 0; i < ds_pr_num.getRowCount(); i++) {
				
				System.out.println("삭제 구매프로시져 호출 >>>>" + ds_pr_num.getString(i, "PR_NUM"));
				
				cstmt = conn.prepareCall("{call EPROCUSR.SP_IF_SALES_ORDER(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");

				//실행
				cstmt.setString(1, "100");
				cstmt.setString(2, "HFC");
				cstmt.setString(3, "FR");
				cstmt.setString(4, "MT");
				cstmt.setString(5, p_RcUpjang);
				cstmt.setString(6, g_EmpNo);
				cstmt.setString(7, p_PoType);
				cstmt.setString(8, ds_pr_num.getString(i, "PR_NUM"));
				cstmt.setString(9, "D");
				cstmt.registerOutParameter(10, Types.VARCHAR);
				cstmt.registerOutParameter(11, Types.VARCHAR);

				cstmt.execute();

				// 프로시져에서 정상코드가 아닐경우 롤백
				if (!cstmt.getString(10).equals("S000")) {
					conn.rollback();
					cstmt.close();
					this.setResultMessage(-1, cstmt.getString(11), out_vl);
					proc_output(response, out, out_vl, out_dl);
					return;
				}
				cstmt.close();
			}
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
		if (cstmt != null) {
			try {
				cstmt.close();
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
