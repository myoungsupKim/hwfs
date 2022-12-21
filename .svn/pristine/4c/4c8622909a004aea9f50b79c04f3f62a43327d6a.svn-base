<%-----------------------------------------------------------
 - Project     : 한화 FS System
 - MenuID      : 메뉴관리 > 구매관리 > 입고관리 > 입고예정현황조회
 - ViewPage    : FSP00110V_S002.JSP 
 - Description : 발주번호, 검수창고 조회
 - Author      : 손 창 덕
 - History     : 1) 2008. 03. 18 - 최초작성.
 -               2) 
 ------------------------------------------------------------%>
<%@page import="com.sz.util.AppDataUtility"%>

<%@page contentType="text/html; charset=EUC-KR"%>
<%@ include file="../../sc/main/common.jsp"%>
<%
	try {
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		// IN DataSet
		DataSet ds_condi = in_dl.get("ds_condi");

		// 변수 설정
		String GB = ds_condi.getString(0, "GB"); // 조회구분
		String TYPE = ds_condi.getString(0, "TYPE"); // 검수구분
		String TYPE_CODE = ds_condi.getString(0, "TYPE_CODE"); // 검수구분별 창고코드
		String FROM_DATE = ds_condi.getString(0, "FROM_DATE"); // 시작일자
		String TO_DATE = ds_condi.getString(0, "TO_DATE"); // 종료일자
		String UPJANG = ds_condi.getString(0, "UPJANG");

		StringBuffer sbQuery = new StringBuffer();

		// 발주번호 조회
		if (GB.equals("ORDER_NUM")) {
			sbQuery.setLength(0);
			sbQuery.append("\nSELECT '000' AS CODE, '- 전체 -' AS CODE_NAME													");
			sbQuery.append("\n  FROM DUAL																					");
			sbQuery.append("\n UNION ALL																					");
			sbQuery.append("\nSELECT A.CUSTCD || '-' ||A.NEED_DATE AS CODE                                   									");
			sbQuery.append("\n     , A.CUSTCD || '-' ||A.NEED_DATE AS CODE_NAME                                                  ");
			sbQuery.append("\n  FROM HLDC_PO_PO A																			");
			sbQuery.append("\n WHERE A.NEED_DATE BETWEEN '" + FROM_DATE + "' AND '" + TO_DATE + "'							");
			//sbQuery.append("\n   AND ABS(A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) > 0	");
			//sbQuery.append("\n   AND A.LINE_STATUS IN ('DL', 'GC')                                          				");
			sbQuery.append("\n   AND A.LINE_STATUS IN ('DL','GC','IV')                                          			");
			//sbQuery.append("\n   AND A.PO_NUM IS NOT NULL                                                    				");
			if (TYPE.equals("S")) {
				sbQuery.append("\n   AND A.SUBINV_CODE = '" + TYPE_CODE + "'												");
			} else if (TYPE.equals("D")) {
				sbQuery.append("\n   AND A.RC_DEPT_ID = '" + TYPE_CODE + "'													");
				sbQuery.append("\n   AND A.SUBINV_CODE IS NULL																");
			}
			sbQuery.append("\n GROUP BY A.CUSTCD || '-' ||A.NEED_DATE										            ");
			sbQuery.append("\n ORDER BY CODE_NAME										            ");

		}
		// 창고코드 조회
		else if (GB.equals("SUBINV")) {
			// 창고입고 조회
			if (TYPE.equals("S")) {
				sbQuery.append("SELECT A.SUBINV_CODE																						\n");
				sbQuery.append("	 , DECODE(A.USE_YN,'N','폐장')||' '||A.SUBINV_NAME AS SUBINV_NAME	  \n");
				sbQuery.append("	 , SUBSTR(D.CENTER_TYPE,1,2) AS	CENTER_TYPE																\n");
				sbQuery.append("	 , E.MU_CD AS MU_CD																						\n");
				sbQuery.append("  FROM HLDC_PO_SUBINVENTORY	A, HLDC_ST_UPJANG B																\n");
				sbQuery.append("	 , HLDC_PO_UPJANG_CENTER C,	HLDC_PO_CENTER D, HLDC_SC_DEPT_V E											\n");
				sbQuery.append(" WHERE A.UPJANG	             = B.UPJANG																		\n");
				sbQuery.append("   AND B.AP_UNITPRICE_UPJANG = C.UPJANG																		\n");
				sbQuery.append("   AND C.CENTER_CODE         = D.CENTER_CODE																\n");
				sbQuery.append("   AND B.DEPT_ID             = E.DEPT_ID																	\n");
				sbQuery.append("   AND A.UPJANG	             = '" + UPJANG
						+ "'															\n");
				sbQuery.append("   AND A.USE_YN	             = 'Y'																			\n");
				sbQuery.append(" ORDER BY CASE WHEN 'C' = SUBSTR(SUBINV_CODE, 1, 1) THEN 1													\n");
				sbQuery.append("               WHEN 'A' = SUBSTR(SUBINV_CODE, 1, 1) THEN 2													\n");
				sbQuery.append("               WHEN 'W' = SUBSTR(SUBINV_CODE, 1, 1) THEN 3													\n");
				sbQuery.append("               ELSE 4 END													                                \n");
				sbQuery.append("        , A.SUBINV_CODE  													                                \n");

			}
			//부서입고조회(소속부서	및 자신이 관리자로 등록되어	있는 창고의	부서)
			else {
				sbQuery.append("SELECT A.DEPT_ID AS	SUBINV_CODE																				\n");
				sbQuery.append("	 , A.DEPT_NAME AS SUBINV_NAME																			\n");
				sbQuery.append("	 , 'N' AS TR_DATE_FIX_FLAG																				\n");
				sbQuery.append("	 , A.MU_CD AS MU_CD																						\n");
				sbQuery.append("	 , DECODE(A.MU_CD, 'YA', 'Y', 'N') AS TR_CHK															\n");
				sbQuery.append("  FROM (SELECT B.DEPT_ID																					\n");
				sbQuery.append("			 , DECODE(B.DEPT_USE,'N','(구)')||'('||B.CC_CD||')'||B.MU_NM||' '||B.CC_NM||'('||TO_CHAR(B.DEPT_ID)||')' AS	DEPT_NAME \n");
				sbQuery.append("			 , B.MU_CD AS MU_CD																				\n");
				sbQuery.append("			 , B.DEPT_USE AS USE_YN																			\n");
				sbQuery.append("		  FROM HLDC_SC_DEPT_V B, HLDC_ST_UPJANG	C															\n");
				sbQuery.append("		 WHERE C.DEPT_ID = B.DEPT_ID																		\n");
				sbQuery.append("		   AND C.UPJANG	 = " + UPJANG + ") A																\n");
				sbQuery.append(" ORDER BY A.DEPT_ID																							\n");
			}
		}

		pstmt = conn.prepareStatement(sbQuery.toString());
		rs = pstmt.executeQuery();

		DataSet ds_out = this.makeDataSet(rs, "ds_out");
		out_dl.add(ds_out);

		this.setResultMessage(0, "OK", out_vl);
	} catch (Exception ex) {
		ex.printStackTrace();
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
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
			}
		}
		proc_output(response, out, out_vl, out_dl);
	}
%>