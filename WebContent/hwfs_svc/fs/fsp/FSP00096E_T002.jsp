<%
	/*-----------------------------------------------------------------------------
	 ■ 시스템명	: 메뉴관리/자재관리/효율화식재 설정
	 ■ 프로그램ID	: FSP00096E_T002.jsp
	 ■ 프로그램명	: 효율화식재 센터내 동일자재 체크
	 ■ 작성일자	: 2018-01-19
	 ■ 작성자	: 김호석
	 ■ 이력관리	: 2018-01-19	 
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

		DataSet ds_list2 = in_dl.get("ds_list2"); // 효율화식재 리스트
		
		String CENTER_CODE = ""; // 센터코드
		String ITEM_CODE   = ""; // 아이템코드
		String START_DATE   = ""; // 시작일자

		StringBuffer sbSelSql = new StringBuffer();
		StringBuffer sbInsSql = new StringBuffer();
		StringBuffer sbUpdSql = new StringBuffer();

		int iAddCnt    = 0;
		
		int iSaveCnt   = ds_list2.getRowCount(); // 변경 추가된 자재건수
		
		String s_itemCode = "";
		String s_centerName = "";
		String itemlist = "";
		int s_cnt = 0; 	

		for (int i = 0; i < iSaveCnt; i++) {
					
			if (ds_list2.getRowType(i) == DataSet.ROW_TYPE_INSERTED) {
				
				CENTER_CODE = nullToBlank(ds_list2.getString(i, "CENTER_CODE")); // 센터코드
				ITEM_CODE   = nullToBlank(ds_list2.getString(i, "ITEM_CODE")); // 아이템코드
				START_DATE   = nullToBlank(ds_list2.getString(i, "START_DATE")); // 시작일자
		
				//같은 센터 내 동일자재, 같은 시작일이 있는 경우 체크
				sbSelSql.delete(0, sbSelSql.length());
				sbSelSql.append("SELECT B.CENTER_NAME, MAX(A.ITEM_CODE) AS ITEM_CODE																													\n"); 
		        sbSelSql.append("           		FROM FSI_EFF_MST A, HLDC_PO_CENTER B 																																\n");
	       		sbSelSql.append("           				WHERE A.CENTER_CODE = B.CENTER_CODE AND A.CENTER_CODE = '" + CENTER_CODE + "' 																		\n");
		        sbSelSql.append("           								AND A.ITEM_CODE = '" + ITEM_CODE + "'																										\n");
		        sbSelSql.append("           								AND A.START_DATE = '" + START_DATE + "'																										\n");
		        sbSelSql.append("           							      GROUP BY B.CENTER_NAME, A.ITEM_CODE   																									\n");
		
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sbSelSql.toString());
				s_itemCode = "";
				s_centerName = "";
				
				//PR_NUM의 PR_ID별 현재 진행상태값 저장 
				while (rs.next()) { 
					
					s_itemCode    = rs.getString("ITEM_CODE");
					s_centerName  = rs.getString("CENTER_NAME");
		
					itemlist = itemlist + " \n - " + "(" + s_centerName + ")" + s_itemCode;
					
				}
			}
		}
		System.out.println("itemlist : " + itemlist);
		
		out_vl.add("v_ItemName", itemlist);
		
		rs.close();
		stmt.close();		
		
		//이미 등록된 품목 리스트 리턴
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