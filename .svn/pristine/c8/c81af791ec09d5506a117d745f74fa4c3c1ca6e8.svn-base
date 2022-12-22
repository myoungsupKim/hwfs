<%
/*-----------------------------------------------------------------------------
■ 시스템명     : FS식단/구매관리 / 즐겨찾기
■ 프로그램ID   : FSP90020E_S003.jsp
■ 프로그램명   : 즐겨찾기 목록조회
■ 작성일자     : 2015-07-08
■ 작성자       : 정영철
■ 이력관리     : 2015-07-08 정영철 최초작성
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
		DataSet ds_input     	= in_dl.get("ds_cond");
	
		String UPJANG 		= nullToBlank(ds_input.getString(0, "UPJANG"));
		String FAVOR_GROUP	= nullToBlank(ds_input.getString(0, "FAVOR_GROUP"));
		
		//out 데이타
		DataSet ds_out;

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length()); //내역조회		
		
        sbSql.append("\n                                                                                                         \n");
        sbSql.append("SELECT A.UPJANG                            /* 사업장코드   */                                                \n");
        sbSql.append("    , A.FAVOR_GROUP                        /* 즐겨찾기그룹 */                                                \n");
        sbSql.append("    , B.ITEM_CODE                          /* 자재코드     */                                                \n");
        sbSql.append("    , B.ITEM_NAME                          /* 자재명       */                                                \n");
        sbSql.append("    , B.ITEM_SIZE                          /* 규격         */                                                \n");
        sbSql.append("    , B.ORIGIN_TYPE                        /* 원산지구분   */                                                \n");
        sbSql.append("    , B.ORIGIN_NAT                         /* 원산지국가   */                                                \n");
        sbSql.append("    , B.PO_UOM                             /* 단위         */                                                \n");
        sbSql.append("    , C.CONTRACT_PRICE_M   AS UNIT_PRICE   /* 관리단가     */                                                \n");
        sbSql.append("    , ''                   AS ITEM_DESC    /* 자재정렬     */                                                \n");
        sbSql.append("    , A.REMARK                             /* 비고         */                                                \n");
        sbSql.append("    , A.USE_YN                             /* 사용유무     */                                                \n");
        sbSql.append("    , A.CUSER                              /* 최초입력자   */                                                \n");
        sbSql.append("    , A.UUSER                              /* 변경자       */                                                \n");
        sbSql.append("    , '1'                  AS CHK          /* 체크         */                                                \n");
        sbSql.append("  FROM FSP_FAVORITE      A                                                                                 \n");
        sbSql.append("    , HLDC_PO_ITEM_MST   B                                                                                 \n");
        sbSql.append("    , HLDC_PO_CONTRACT_F C                                                                                 \n");
        sbSql.append(" WHERE A.ITEM_CODE         =   B.ITEM_CODE                                                                 \n");
        sbSql.append("   AND A.UPJANG            =   "  + UPJANG      + "                                                        \n");
        sbSql.append("   AND A.FAVOR_GROUP       =   '" + FAVOR_GROUP + "'                                                       \n");
        sbSql.append("   AND A.USE_YN            =   'Y'                                                                         \n");
        sbSql.append("   AND B.ITEM_CODE         =   C.ITEM_CODE                                                                 \n");
        sbSql.append("   AND A.UPJANG            =   C.UPJANG                                                                    \n");
        // 즐겨찾기상품등록 화면 조회 시 식재만 조회(2018-11-28,이필승)
        // sbSql.append("   AND B.ITEM_CLASS1       =   'F'                                                                         \n");
        sbSql.append("   AND B.USE_YN            =   'Y'                                                                         \n");
        sbSql.append("   AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN C.CONTRACT_START    AND NVL(C.CONTRACT_END, '99991231')         \n");
        sbSql.append("   AND C.USE_YN            =   'Y'                                                                         \n");
        sbSql.append("   AND C.CONTRACT_PRICE_M  > 0                                                                             \n");
        sbSql.append(" ORDER BY B.ITEM_CODE, B.ITEM_NAME                                                                         \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_out = this.makeDataSet(rs, "ds_out"); //ds_list

		rs.close();
		pstmt.close();		
		
		/**종료**/
		out_dl.add(ds_out);
		//this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		//ex.printStackTrace();
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