<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 구매신청/재고등록/재고취소 잠금해제
■ 프로그램ID   : FSP00900E_S001.jsp
■ 프로그램명   : 재고등록 잠금해제
■ 작성일자     : 2015-10-29
■ 작성자       : 정영철
■ 이력관리     : 2015-10-29
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

		DataSet ds_cond = in_dl.get("ds_cond");
		
		String strUpjang     = nullToBlank(ds_cond.getString(0, "UPJANG"     ));	// 업장코드
        String strSubinvCode = nullToBlank(ds_cond.getString(0, "SUBINV_CODE"));	// 창고코드
        String strUpdateBy   = nullToBlank(ds_cond.getString(0, "UPDATE_BY"	 ));	// 창고코드
        String strStatus     = nullToBlank(ds_cond.getString(0, "STATUS"     ));	// 잠금상태코드

		DataSet ds_list;
		StringBuffer sbSelSql = new StringBuffer();

		sbSelSql.delete(0, sbSelSql.length());
        sbSelSql.append("SELECT A.UPJANG \n");
        sbSelSql.append("     , C.UPJANGNM \n");
        sbSelSql.append("     , A.SUBINV_CODE \n");
        sbSelSql.append("     , D.SUBINV_NAME \n");
        sbSelSql.append("     , NVL(A.UPDATE_BY, A.CREATE_BY) AS UPDATE_BY \n");
        sbSelSql.append("     , B.NM_KOR \n");
        sbSelSql.append("     , TO_CHAR(NVL(A.UPDATE_DATE, A.CREATE_DATE), 'YYYY-MM-DD DAY HH24:MI:SS') AS UPDATE_DATE \n");
        sbSelSql.append("     , A.STATUS \n");
        sbSelSql.append("  FROM FSP_PHYSICAL_INVENTORY_LOG A \n");
        sbSelSql.append("     , HR_PERSONAL B \n");
        sbSelSql.append("     , ST_UPJANG C \n");
        sbSelSql.append("     , HLDC_PO_SUBINVENTORY D \n");
        sbSelSql.append(" WHERE NVL(A.UPDATE_BY, A.CREATE_BY)   = B.SABUN \n");
        sbSelSql.append("   AND A.UPJANG                        = C.UPJANG \n");
        sbSelSql.append("   AND A.SUBINV_CODE                   = D.SUBINV_CODE \n");

        if(!strUpjang.equals(""))
        	sbSelSql.append("   AND A.UPJANG      = " + strUpjang + "   	\n");
        if(!strUpdateBy.equals(""))
        	sbSelSql.append("   AND B.NM_KOR    = '" + strUpdateBy + "'  	\n");
        if(!strStatus.equals("%"))
        	sbSelSql.append("   AND A.STATUS      = " + strStatus + "   	\n");
        if(!strSubinvCode.equals("%"))
        	sbSelSql.append("   AND A.SUBINV_CODE = '" + strSubinvCode + "' \n");
        
        sbSelSql.append("  ORDER BY D.SUBINV_NAME                   	\n");

		stmt = conn.createStatement();
		rs = stmt.executeQuery(sbSelSql.toString());

		ds_list = this.makeDataSet(rs, "ds_list");
		out_dl.add(ds_list);

		rs.close();
		stmt.close();
		
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
