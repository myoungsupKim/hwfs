<%
	/*-----------------------------------------------------------------------------
	 ■ 시스템명	: 구매관리/구매신청/구매신청서작성/식자재구매신청(확정 시 배송중 체크)
	 ■ 프로그램ID	: FSP00032E_T013.jsp
	 ■ 프로그램명	: 구매신청(신청된건에 대한 자재수정및 추가일경우)
	 ■ 작성일자	: 2017-11-27
	 ■ 작성자	: 김호석
	 ■ 이력관리	: 2017-11-27	 
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

		DataSet ds_condi = in_dl.get("ds_condi2"); // 조회조건및 필수 파라미터	데이터셋
		DataSet ds_pr_item = in_dl.get("ds_pr_item2"); // 구매신청자제	데이터셋
		DataSet ds_del_item = in_dl.get("ds_del_item2"); // 식단에서	구매신청에서 제외된	자재

		String PR_NUM      = nullToBlank(ds_condi.getString(0, "PR_NUM")); // 구매번호(수정일경우에만 넘어옴)
		String LINE_STATUS = nullToBlank(ds_condi.getString(0, "LINE_STATUS")); // 진행상태코드	(임시저장되었던건인지 확정되었던 건인지	구분자)

		StringBuffer sbSelSql = new StringBuffer();
		StringBuffer sbInsSql = new StringBuffer();
		StringBuffer sbUpdSql = new StringBuffer();

		String strOrgPrNum = ""; // 원본	PR_NUM
		String strAddPrNum = ""; // 자재	추가시 신규	PR_NUM
		String strAprNum   = ""; // 구매승인번호
		String strValiPrId = ""; // 구매시스템 유효성체크할 PR_ID

		int iSaveCnt   = ds_pr_item.getRowCount(); // 변경 추가된 자재건수
		int iDeleteCnt = ds_pr_item.getRemovedRowCount(); // 삭제된 자재 건수
		int iUpdateCnt = 0;
		int iAddCnt    = 0;

		int iMenuAddCnt = 0; // 식단에 의한 발주일경우 식단에서 신청된 건수
		int iMenuModCnt = 0; // 식단에 의한 발주일경우 식단에서 변경된 건수
		int iMenuDelCnt = 0; // 식단에 의한 발주일경우 식단에서 삭제된 건수
		
        List<Map> beforelistMap = new ArrayList<Map>();  // PR_ID별 현재 상태값

		strOrgPrNum = PR_NUM; // 원본	PR_NUM (신청호가정 후 추가 자재가 있을 경우를 원본 PR_NUM 존재)
		
		
		//진행상태 체크(저장전 상태가 바뀐경우) 2017.11.27 김호석
		sbSelSql.delete(0, sbSelSql.length());
		sbSelSql.append("SELECT A.PR_ID, A.ITEM_NAME, CASE A.LINE_STATUS WHEN '002' 																																			\n"); 
        sbSelSql.append("        THEN CASE WHEN (SELECT /*+ LEADING(IA.PODT) USE_NL(IA.PODT IA.POHD) */ COUNT(1) FROM HLDC_PO_PO IA WHERE IA.PO_ID = A.PR_ID ) > 1												\n");
        sbSelSql.append("        THEN (SELECT /*+ LEADING(IA.PODT) USE_NL(IA.PODT IA.POHD) */ IA.LINE_STATUS FROM HLDC_PO_PO IA WHERE IA.LINE_STATUS <> 'PD' AND IA.PO_ID = A.PR_ID )							\n");
        sbSelSql.append("                 ELSE (SELECT /*+ LEADING(IA.PODT) USE_NL(IA.PODT IA.POHD) */ IA.LINE_STATUS FROM HLDC_PO_PO IA WHERE IA.PO_ID = A.PR_ID )												\n");
        sbSelSql.append("            END																	 																									\n");
        sbSelSql.append("           ELSE A.LINE_STATUS																																							\n");
        sbSelSql.append("           END LINE_STATUS									/* 구매진행상황코드 */  																									\n");
        //sbSelSql.append("SELECT A.PR_ID, A.ITEM_NAME, CASE WHEN A.PR_ID = '168866972' THEN 'DL' ELSE 'PC'END AS LINE_STATUS	--TEST																																	\n");
        sbSelSql.append("           		FROM SO_PR A WHERE A.ORG_PR_NUM = '" + strOrgPrNum + "' 																													\n");
        sbSelSql.append("           		ORDER BY A.PR_ID																													\n");

		stmt = conn.createStatement();
		rs = stmt.executeQuery(sbSelSql.toString());
		String s_prid = "";
		String s_status = "";
		String s_itemname = "";
		String itemlist = "";
		int s_cnt = 0; 	
		
		//PR_NUM의 PR_ID별 현재 진행상태값 저장 
		while (rs.next()) { 
			
			s_prid    = rs.getString("PR_ID");
			s_status  = rs.getString("LINE_STATUS");
			s_itemname  = rs.getString("ITEM_NAME");
	       	
	       	Map<String, Object> before_rowData = new HashMap<String,Object>();
	       	before_rowData.put("PR_ID", s_prid);
	       	before_rowData.put("LINE_STATUS", s_status);
	       	before_rowData.put("ITEM_NAME", s_itemname);
	    	
	    	beforelistMap.add(before_rowData);	        
			
		}
		
		//현재 진행상태와 그리드에서 넘어온 상태값 체크
		for (int k = 0 ; k < beforelistMap.size() ; k++) {
			Map<String, Object> bMap = beforelistMap.get(k);
			
			//수정건에 대해서만 진행중으로 변경된 품목 체크(추가는 체크할 필요 없음)
			for (int i = 0; i < iSaveCnt; i++) {				
				//추가, 삭제 제외
				if (ds_pr_item.getRowType(i) == DataSet.ROW_TYPE_UPDATED || ds_pr_item.getRowType(i) == DataSet.ROW_TYPE_NORMAL) {
					s_prid = bMap.get("PR_ID").toString();
					s_status = bMap.get("LINE_STATUS").toString();
					s_itemname = bMap.get("ITEM_NAME").toString();
					if ((ds_pr_item.getString(i, "PR_ID").equals(s_prid)) && (!ds_pr_item.getString(i, "LINE_STATUS").equals(s_status)))  {
						if (s_status.equals("DL")) {					
							s_cnt += 1;	
							itemlist = itemlist + " \n - " + s_itemname;
						}
					}
				}
			}	
			
			//삭제된 건 중 배송중으로 변경 된 품목 체크
			for (int j = 0; j < iDeleteCnt; j++) {
				s_prid = bMap.get("PR_ID").toString();
				s_status = bMap.get("LINE_STATUS").toString();
				s_itemname = bMap.get("ITEM_NAME").toString();
				if ((ds_pr_item.getRemovedStringData(j, "PR_ID").equals(s_prid)) && (!ds_pr_item.getRemovedStringData(j, "LINE_STATUS").equals(s_status)))  {
					if (s_status.equals("DL")) {
						s_cnt += 1;				
						itemlist = itemlist + " \n - " + s_itemname;
					}
				}
			}
		}
		out_vl.add("v_ItemName", itemlist);
		
		rs.close();
		stmt.close();		
		
		//배송중으로 변경된 품목 리스트 리턴
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