<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 협력업체 > 운영관리
■ 프로그램ID   : FSV00400E_T001.jsp
■ 프로그램명   : 자재이력관리(조회)
■ 작성일자     : 2008-07-01
■ 작성자       : 박은규
■ 이력관리     : 2008-07-01 - 최초작성 박은규 CSR#(28344)
                2009-07-24 박은규 CSR#(29350) 요청자:김경운(구매지원팀)
                축산법률 규정변경에 따른 관리항목 변경
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//입력 데이타                                                                                                                                                                                         
		DataSet ds_input     = in_dl.get("ds_input"); 
		
		String strCnterCode 		= nullToBlank(ds_input.getString(0, "CENTER_CODE"));                                                                                                                                                                                                        
		String strCustCD			= nullToBlank(ds_input.getString(0, "CUSTCD"));
		String strCustNm			= nullToBlank(ds_input.getString(0, "CUSTNM"));
		
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		stmt 		=  conn.createStatement();
	
	
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
        
		// 확정단가조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT B.HIST_ID \n");
		sbSql.append("     , A.ITEM_CODE \n");
		sbSql.append("     , C.ITEM_NAME \n");
		sbSql.append("     , C.PO_UOM \n");
		sbSql.append("     , C.ITEM_SIZE \n");
		sbSql.append("     , DECODE(C.TAX_CODE,'100','과세','210','면세','영세') AS TAX_CODE     --과면세 \n");
		sbSql.append("     , C.KEEPING_TYPE --보관방법 \n");
		sbSql.append("     , C.ORIGIN_TYPE  --원산지 \n");
		sbSql.append("     , DECODE(NVL(D.D_DAYS,0), 0, '없음', 'D-'||(D.D_DAYS+1)||' '||DECODE(NVL(D.D_TIMES,0),0,NULL,D.D_TIMES||'시')) D_DAY --발주제한 \n");
		sbSql.append("     , B.ITEM_FEATURE  --자재특성 \n");
		sbSql.append("     , NVL2(B.DOCU_FILE1,'Y','N') DOCU_YN -- 증빙자료 \n");
		sbSql.append("     , B.NUT_INFO --영양소정보 \n");
		sbSql.append("     , B.MARKET_TREND --시장동향 \n");
		sbSql.append("     , B.APRV_YN --승인여부 \n");
		sbSql.append("     , B.DOCU_FILE1 \n");
		sbSql.append("     , B.DOCU_FILE2 \n");
		sbSql.append("     , B.DOCU_FILE3 \n");
		sbSql.append("     , B.DOCU_FILE4 \n");
		sbSql.append("     , B.DOCU_FILE5 \n");
		sbSql.append("     , B.SDOCU_FILE1 \n");
		sbSql.append("     , B.SDOCU_FILE2 \n");
		sbSql.append("     , B.SDOCU_FILE3 \n");
		sbSql.append("     , B.SDOCU_FILE4 \n");
		sbSql.append("     , B.SDOCU_FILE5 \n");
		sbSql.append("     , B.SDOCU_FILE_SIZE1 \n");
		sbSql.append("     , B.SDOCU_FILE_SIZE2 \n");
		sbSql.append("     , B.SDOCU_FILE_SIZE3 \n");
		sbSql.append("     , B.SDOCU_FILE_SIZE4 \n");
		sbSql.append("     , B.SDOCU_FILE_SIZE5 \n");
		//2008.12.18 박은규 : 원재료등급/생산년도/전처리작업일/세부원산지/부위명/개체식별번호/포장단위 추가
//============================================================================================
//(2009-07-24 추가) 시작
// 2009-07-24 박은규 CSR#(29350) 요청자:김경운(구매지원팀)
// 축산법률 규정변경에 따른 관리항목 변경
//============================================================================================
		sbSql.append("     , B.ORIGIN_QUALITY, B.ORIGIN_INFO, B.PRODUCT_YEAR, NVL(B.BOXING_QTY,0) AS BOXING_QTY \n");
		sbSql.append("     , B.PREJOB_DATE, B.PART_NAME, B.BLNUMBER \n");
		sbSql.append("     , B.ITEM_GRADE, B.IDNUMBER, B.CONF_NUM, B.BUTCH_NAME \n");
		//
		sbSql.append("     , B.ITEM_PRT_NAME, B.MATERIAL_INFO, B.LIFEDAY_INFO \n");
		sbSql.append("     , B.KEEPING_METHOD, B.ATTENTION_INFO \n");
//============================================================================================
//(2009-07-24 추가) 끝
//============================================================================================
		sbSql.append("     , B.IMPORT_NUM \n");
	    sbSql.append("     , '" + strCustNm + "' CUSTNM \n");
	    sbSql.append("     , B.PRODUCT_NAME \n");
		sbSql.append("  FROM \n");
		sbSql.append("       ( \n");
		sbSql.append("        SELECT CENTER_UPJANG, ITEM_CODE \n");
		//sbSql.append("          FROM PO_CUSTOM_ITEM \n");
		sbSql.append("          FROM PO_CUSTOM_ITEM \n");
		sbSql.append("         WHERE CENTER_UPJANG = " + strCnterCode + " \n");
		sbSql.append("           AND CUSTCD = " + strCustCD + " \n");
		sbSql.append("           AND USE_TYPE = '01' --하드코딩 \n");
		sbSql.append("       ) A \n");
		sbSql.append("     , ( \n");
		sbSql.append("        SELECT * \n");
		sbSql.append("          FROM PO_ITEM_HIST \n");
		sbSql.append("         WHERE CENTER_CODE = " + strCnterCode + " \n");
		sbSql.append("           AND CUSTCD = " + strCustCD + " \n");
		sbSql.append("           AND USE_YN = 'Y' \n");
		sbSql.append("       ) B \n");
		sbSql.append("     , PO_ITEM_MST C \n");
		sbSql.append("     , PO_PREORDER_LIST D \n");
		sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
		sbSql.append("   AND A.CENTER_UPJANG = B.CENTER_CODE(+) \n");
		sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("   AND A.CENTER_UPJANG = D.CENTER_CODE(+) \n");
		sbSql.append("   AND A.ITEM_CODE = D.ITEM_CODE(+) \n");
		sbSql.append(" ORDER BY A.ITEM_CODE \n");
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());                                                                                                                                                             
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();                                                                                                                                                                          
		ds_list = this.makeDataSet(rs, "ds_list");                                                                                                                                                          
                                                                                                                                                                                                        
		/**종료**/                                                                                                                                                                                          
		out_dl.add(ds_list);                                                                                                                                                          
		this.setResultMessage(0, "OK", out_vl);  
		
	} catch(Exception ex) {
		   ex.printStackTrace();
	       this.setResultMessage(-1, ex.toString(),out_vl);
		} finally {
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
			if(stmt != null) {
				try {
					stmt.close();
				}catch(Exception e) {}
			}
			if(conn != null) {
				try {
					conn.close();
				}catch(Exception e) {}
			}
		}
		
	  proc_output(response,out,out_vl,out_dl);
	
%>	