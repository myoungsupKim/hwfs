<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/상품정보
■ 프로그램ID   : FMP00010P_T001.jsp
■ 프로그램명   : 상품정보 팝업
■ 작성일자     : 2012-05-21
■ 작성자       : 박은규
■ 이력관리     : 박은규 최초 작성 2012-05-21 CSR#(25270) 
				  요청자:김경운(구매팀)
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();		
	
		// log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//입력 데이타
		//DataSet ds_Cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String strCenterCode  = nullToBlank(in_vl.getString("strCenterCode"));
		String strCustcd      = nullToBlank(in_vl.getString("strCustcd"));
		String strItemCode    = nullToBlank(in_vl.getString("strItemCode"));
		String strItemPrice    = nullToBlank(in_vl.getString("strItemPrice"));
		String g_Upjang       = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo        = nullToBlank(in_vl.getString("g_EmpNo"));
	
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//out 데이타
		DataSet ds_List, ds_ItemList, ds_OtCustImage;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
	
		sbSql.append("-- 자재정보                        \n");
		sbSql.append("SELECT ITEM_CODE                   \n");
		sbSql.append("     , ITEM_NAME                   \n");
		sbSql.append("     , ITEM_SIZE                   \n");
		sbSql.append("     , PO_UOM                      \n");
		sbSql.append("     , MAKER                       \n");
		sbSql.append("     , KEEPING_TYPE                \n");
		sbSql.append("     , ORIGIN_TYPE                 \n");
		sbSql.append("     , ORIGIN_NAT                  \n");
		sbSql.append("     , ORIGIN_DTL                  \n");
		sbSql.append("     , MIN_ORD_QTY                 \n");
		sbSql.append("     , POINT_FLAG                  \n");
		sbSql.append("     , REMARK                      \n");
		sbSql.append("     , '' as BOX_QTY               \n");
		sbSql.append("  FROM HLDC_PO_ITEM_MST            \n");
		sbSql.append(" WHERE ITEM_CODE = '" + strItemCode + "'       \n");
		sbSql.append(" UNION ALL                         \n");
		sbSql.append("SELECT ITEM_CODE                   \n");
		sbSql.append("     , ITEM_NAME                   \n");
		sbSql.append("     , ITEM_SIZE                   \n");
		sbSql.append("     , PO_UOM                      \n");
		sbSql.append("     , MAKER                       \n");
		sbSql.append("     , KEEPING_TYPE                \n");
		sbSql.append("     , ORIGIN_TYPE                 \n");
		sbSql.append("     , '' AS ORIGIN_NAT            \n");
		sbSql.append("     , '' AS ORIGIN_DTL            \n");
		sbSql.append("     , MIN_ORD_QTY                 \n");
		sbSql.append("     , POINT_FLAG                  \n");
		sbSql.append("     , REMARK                      \n");
		sbSql.append("     , '' as BOX_QTY               \n");
		sbSql.append("  FROM FMP_OTCUST_ITEM             \n");
		sbSql.append(" WHERE ITEM_CODE = '" + strItemCode + "'       \n");
		
		
		
		out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");

		pstmt.close();
		rs.close();
	    
// [속도개선 Project 시작] 2017. 8. 28. 최범주 쿼리 변수 바인딩기능 추가
		sbSql.setLength(0);
		sbSql.append("  /* fm/fmp/FMP00010P_T001.jsp */                         \n");
		sbSql.append("  -- 자재영양정보		                                    \n");
		sbSql.append("  SELECT :strItemCode AS ITEM_CODE                        \n");
		sbSql.append("      , A.CODE                                            \n");
		sbSql.append("      , A.CODE_NAME                                       \n");
		sbSql.append("      , A.CONTENTS                                        \n");
		sbSql.append("      , A.SET1                                            \n");
		sbSql.append("      , NVL(B.NUT_QTY, C.NUT_QTY) AS NUT_QTY              \n");
		sbSql.append("   FROM SCC_COMMON_CODE A                                 \n");
		sbSql.append("      , (SELECT CAL AS NUT_QTY, 'CAL' AS NUT_NAME         \n");
		sbSql.append("           FROM FSI_ITEM_NUT                              \n");
		sbSql.append("          WHERE ITEM_CODE = :strItemCode                  \n");
		sbSql.append("          UNION ALL                                       \n");
		sbSql.append("         SELECT PROT AS NUT_QTY, 'PROT' AS NUT_NAME       \n");
		sbSql.append("           FROM FSI_ITEM_NUT                              \n");
		sbSql.append("          WHERE ITEM_CODE = :strItemCode                  \n");
		sbSql.append("         UNION ALL                                        \n");
		sbSql.append("         SELECT CA AS NUT_QTY, 'CA' AS NUT_NAME           \n");
		sbSql.append("           FROM FSI_ITEM_NUT                              \n");
		sbSql.append("          WHERE ITEM_CODE = :strItemCode                  \n");
		sbSql.append("         UNION ALL                                        \n");
		sbSql.append("         SELECT NA AS NUT_QTY, 'NA' AS NUT_NAME           \n");
		sbSql.append("           FROM FSI_ITEM_NUT                              \n");
		sbSql.append("          WHERE ITEM_CODE = :strItemCode                  \n");
		sbSql.append("         ) B                                              \n");
		sbSql.append("      , (SELECT CAL AS NUT_QTY, 'CAL' AS NUT_NAME         \n");
		sbSql.append("           FROM HLDC_ITEM_NUTR_INFO                       \n");
		sbSql.append("          WHERE ITEM_CODE = :strItemCode                  \n");
		sbSql.append("         UNION ALL                                        \n");
		sbSql.append("         SELECT PROT AS NUT_QTY, 'PROT' AS NUT_NAME       \n");
		sbSql.append("           FROM HLDC_ITEM_NUTR_INFO                       \n");
		sbSql.append("          WHERE ITEM_CODE = :strItemCode                  \n");
		sbSql.append("         UNION ALL                                        \n");
		sbSql.append("         SELECT CA AS NUT_QTY, 'CA' AS NUT_NAME           \n");
		sbSql.append("           FROM HLDC_ITEM_NUTR_INFO                       \n");
		sbSql.append("          WHERE ITEM_CODE = :strItemCode                  \n");
		sbSql.append("         UNION ALL                                        \n");
		sbSql.append("         SELECT NA AS NUT_QTY, 'NA' AS NUT_NAME           \n");
		sbSql.append("           FROM HLDC_ITEM_NUTR_INFO                       \n");
		sbSql.append("          WHERE ITEM_CODE = :strItemCode                  \n");
		sbSql.append("         ) C                                              \n");
		sbSql.append("  WHERE A.SET2 = B.NUT_NAME(+)                            \n");
		sbSql.append("    AND A.SET2 = C.NUT_NAME(+)                            \n");
		sbSql.append("    AND A.GROUP_CODE = 'FS0027'                           \n");
		sbSql.append("    AND A.SET2 IN('CAL', 'PROT', 'CA', 'NA')              \n");
		sbSql.append("  ORDER BY A.SORT_SEQ                                     \n");
		
		out_vl.add("fa_Sql", sbSql.toString());
        npstmt = new NamedParameterStatement(conn, sbSql.toString());
        npstmt.setString("strItemCode", strItemCode);
        rs = npstmt.executeQuery();
		ds_ItemList = this.makeDataSet(rs, "ds_ItemList");

        npstmt.close();
        rs.close();
        sbSql.setLength(0);
// [속도개선 Project 시작] 2017. 8. 28. 최범주
		
// [속도개선 Project 시작] 2017. 8. 28. 최범주 쿼리 변수 바인딩기능 추가
		sbSql.setLength(0);
		sbSql.append("  /* fm/fmp/FMP00010P_T001.jsp */             \n");
 		sbSql.append("-- 자재이미지정보                        		\n");
 		sbSql.append("SELECT ITEM_CODE AS ITEM_CODE           		\n");
 		sbSql.append("		,IMG_PATH  AS SIMAGE_PATH               \n");
 		sbSql.append("		,''  AS IMAGE_PATH               		\n");
 		sbSql.append("  FROM EPROCUSR.MV_ITEM_IMG          			\n");
 		sbSql.append(" WHERE ITEM_CODE = :strItemCode               \n");
 		sbSql.append(" ---------------------------------------      \n");
 		sbSql.append(" UNION ALL      								\n");
 		sbSql.append(" ---------------------------------------      \n");
		sbSql.append("-- 공급업체이미지정보                   		\n");
		sbSql.append("SELECT ITEM_CODE                      		\n");
		sbSql.append("		,SIMAGE_PATH                      		\n");
		sbSql.append("		,''  AS IMAGE_PATH               		\n");
		sbSql.append("  FROM FMP_OTCUST_ITEM             			\n");
		sbSql.append(" WHERE ITEM_CODE = :strItemCode               \n");
		
		out_vl.add("fa_Sql", sbSql.toString());
        npstmt = new NamedParameterStatement(conn, sbSql.toString());
        npstmt.setString("strItemCode", strItemCode);
        rs = npstmt.executeQuery();
		ds_OtCustImage = this.makeDataSet(rs, "ds_OtCustImage");

        npstmt.close();
        rs.close();
        sbSql.setLength(0);
// [속도개선 Project 시작] 2017. 8. 28. 최범주

		/**종료**/
		out_dl.add(ds_List);
		out_dl.add(ds_ItemList);
		out_dl.add(ds_OtCustImage);
		
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
// [속도개선 Project 시작] 2017. 8. 28. 최범주 쿼리 변수 바인딩기능 추가
        if (npstmt != null) {
            try {
                npstmt.close();
            } catch (Exception e) {
            }
        }
// [속도개선 Project 시작] 2017. 8. 28. 최범주
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

<%--
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();		
	
		// log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//입력 데이타
		//DataSet ds_Cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String strCenterCode  = nullToBlank(in_vl.getString("strCenterCode"));
		String strCustcd      = nullToBlank(in_vl.getString("strCustcd"));
		String strItemCode    = nullToBlank(in_vl.getString("strItemCode"));
		String strItemPrice    = nullToBlank(in_vl.getString("strItemPrice"));
		String g_Upjang       = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo        = nullToBlank(in_vl.getString("g_EmpNo"));
	
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		sbSql.append("SELECT A.ITEM_NAME \n");
		sbSql.append("     , A.ITEM_SIZE \n");
//		sbSql.append("     , A.PO_UOM||'' / ''||TO_CHAR(B.BOXING_QTY) AS PO_UOM \n");
		sbSql.append("     , A.PO_UOM \n");
		//sbSql.append("     , " + strItemPrice + " AS ITEM_PRICE \n");
		//sbSql.append("     , B.ORIGIN_QUALITY \n");
		sbSql.append("     , NVL(B.ORIGIN_INFO, A.ORIGIN_TYPE) AS ORIGIN_INFO \n");
		//sbSql.append("     , B.MATERIAL_INFO \n");
		sbSql.append("     , B.LIFEDAY_INFO \n");
		sbSql.append("     , NVL(B.KEEPING_METHOD, A.KEEPING_TYPE) AS KEEPING_TYPE \n");
		sbSql.append("     , B.ATTENTION_INFO \n");
		sbSql.append("     , B.ITEM_FEATURE \n");
		sbSql.append("     , B.NUT_INFO \n");
		//sbSql.append("     , B.MARKET_TREND \n");
		sbSql.append("  FROM VO_ITEM_MST A \n");
		sbSql.append("     ,(SELECT * FROM HLDC_PO_ITEM_HIST \n");
		sbSql.append("        WHERE CENTER_CODE = '" + strCenterCode + "' \n");
		sbSql.append("          AND CUSTCD = '" + strCustcd + "' \n");
		sbSql.append("          AND ITEM_CODE = '" + strItemCode + "' \n");
		sbSql.append("          AND USE_YN = 'Y') B \n");
		sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
		sbSql.append("   AND A.ITEM_CODE = '" + strItemCode + "' \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		//로그남기기
		//logger.debug(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();

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

--%>
