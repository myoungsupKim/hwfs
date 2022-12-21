<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/메뉴관리/레시피관리
■ 프로그램ID   : FMM00110E_T001.jsp
■ 프로그램명   : 레시피 대체상품 등록(조회)
■ 작성일자     : 2008-03-25
■ 작성자       : 박은규
■ 이력관리     : 2008-03-25 - 최초작성
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
		//DataSet ds_cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sMainUpjang  = nullToBlank(in_vl.getString("sMainUpjang"));
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
		String sType        = nullToBlank(in_vl.getString("sType"));
		//FileLog.println("d:\\aaa.txt", ds_cond);

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		//내역조회
		if (sType.equals("ItmLst"))
		{
			sbSql.delete(0, sbSql.length());
			//sbSql.append("/*===== 일괄대체 상품 조회 =====*/ \n");
			sbSql.append("SELECT A.UPJANG \n");
			sbSql.append("     , A.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE, B.PO_UOM \n");
			sbSql.append("     , A.ITEM_CODE_TO, C.ITEM_NAME AS ITEM_NAME_TO, C.ITEM_SIZE AS ITEM_SIZE_TO, C.PO_UOM AS PO_UOM_TO \n");
			sbSql.append("     , B.ORIGIN_TYPE, C.ORIGIN_TYPE AS ORIGIN_TYPE_TO \n");
			sbSql.append("  FROM FMM_CHG_ITEM_LIST A, FMS_ITEM_V B, FMS_ITEM_V C \n");
			sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("   AND A.ITEM_CODE_TO = C.ITEM_CODE \n");
			sbSql.append("   AND A.UPJANG = " + sUpjang + " \n");
		}	
		else if (sType.equals("UpjLst"))
		{
			sbSql.delete(0, sbSql.length());
			//sbSql.append("/*===== 일괄등록 대상 사업장 목록 조회 =====*/ \n");
			//본사일경우 하위업장까지 보여주고 사업장은 자기 업장만 보여주게
			if(sMainUpjang.equals(sUpjang))
			{
				sbSql.append("SELECT A.UPJANG, A.UPJANGNM_DISP, '0' AS CHK \n");
				sbSql.append("  FROM FMS_UPJANG A \n");
				sbSql.append(" WHERE A.MAIN_UPJANG = " + sMainUpjang + " \n");
				sbSql.append("   AND A.USE_YN = 'Y' \n");
				sbSql.append(" ORDER BY 1 \n");
			}
			else
			{
				sbSql.append("SELECT A.UPJANG, A.UPJANGNM_DISP, '0' AS CHK \n");
				sbSql.append("  FROM FMS_UPJANG A \n");
				sbSql.append(" WHERE A.UPJANG = " + sUpjang + " \n");
				sbSql.append("   AND A.USE_YN = 'Y' \n");
				sbSql.append(" ORDER BY 1 \n");		
			}
		}	
		else if (sType.equals("FAV_UpjLst"))
		{
			sbSql.delete(0, sbSql.length());
			//sbSql.append("/*===== 일괄등록 대상 사업장 목록 조회 =====*/ \n");
			sbSql.append("SELECT A.UPJANG, A.UPJANGNM_DISP, '0' AS CHK \n");
			sbSql.append("  FROM FMS_UPJANG A \n");
			sbSql.append(" WHERE A.MAIN_UPJANG = " + sMainUpjang + " \n");
			sbSql.append("   AND A.USE_YN = 'Y' \n");
			sbSql.append("   AND A.UPJANG <> " + sUpjang + "  \n");
			sbSql.append(" ORDER BY 1 \n");
		}			
		else if (sType.equals("ErrLst"))
		{
			sbSql.delete(0, sbSql.length());
			//sbSql.append("/*===== 레시피 사용불가 상품 조회 =====*/ \n");
			sbSql.append("SELECT /*+ ORDERED */ \n"); //USE_HASH(A W)
			sbSql.append("       (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS_HLDC_V WHERE CLASS_CODE = A.ITEM_CLASS2) AS CLASS_NAME2 \n");
			sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS_HLDC_V WHERE CLASS_CODE = A.ITEM_CLASS3) AS CLASS_NAME3 \n");
			sbSql.append("     , (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS_HLDC_V WHERE CLASS_CODE = A.ITEM_CLASS4) AS CLASS_NAME4 \n");
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM  \n");
			sbSql.append("  FROM HLDC_PO_ITEM_MST A \n");
			sbSql.append("     , FMS_SUBINVENTORY W, SCC_COMMON_CODE X, FSR_STD_RECIPE_MST Y, FSR_STD_RECIPE_ITEM Z \n");
			sbSql.append(" WHERE W.SUBINV_CLASS = X.SET1 \n");
			sbSql.append("   AND X.SET2 = Y.RECIPE_CLASS \n");
			sbSql.append("   AND Y.RECIPE_CD = Z.RECIPE_CD \n");
			sbSql.append("   AND Z.ITEM_CODE = A.ITEM_CODE \n");
			sbSql.append("   AND W.UPJANG = " + sUpjang + " \n");
			sbSql.append("   AND X.GROUP_CODE = 'FM0007' AND X.USE_YN = 'Y' \n");
			sbSql.append("   AND NOT EXISTS \n");
			sbSql.append("      (SELECT 1 FROM HLDC_PO_TREAT_UPJANG K1 \n");
			sbSql.append("        WHERE K1.UPJANG = (SELECT AP_UNITPRICE_UPJANG FROM HLDC_ST_UPJANG WHERE UPJANG = " + sUpjang + ") \n");
			sbSql.append("          AND K1.ITEM_CODE = Z.ITEM_CODE) \n");
			sbSql.append(" GROUP BY A.ITEM_CLASS2, A.ITEM_CLASS3, A.ITEM_CLASS4, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM \n");
		}	
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		rs.close();
		pstmt.close();
		//FileLog.println("d:\\aaa.txt", ds_List);

		/**종료**/
		out_dl.add(ds_List);
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