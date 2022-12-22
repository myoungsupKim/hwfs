<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/주문관리
■ 프로그램ID   : FMP00160E_T001.jsp
■ 프로그램명   : 주문 저장
■ 작성일자     : 2008.01.21
■ 작성자       : 박은규
■ 이력관리     : 2008.01.21
               2009-03-13 박은규 CSR#(25270) 요청자:김진희(식재사업팀)
               주문수량이 0인 것은 식단정보에 발주로 처리
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt              =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();	
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));	
		//In 데이타
		DataSet ds_Cond  	    = in_dl.get("ds_Cond");
		
		String v_Upjang         = nullToBlank(ds_Cond.getString(0, "UPJANG"));
		String v_TransDate      = nullToBlank(ds_Cond.getString(0, "TRANS_DATE"));
		String v_SubinvCode     = nullToBlank(ds_Cond.getString(0, "SUBINV_CODE"));	  
		String sOnhandMonth     = "000101";
	    //out 데이타
		DataSet ds_List;
		
		StringBuffer sbSql = new StringBuffer();
			
		sbSql.delete(0, sbSql.length());
		sbSql.append( "SELECT A.CLS_YM \n");
		sbSql.append( "  FROM FMW_CLOSING A \n");
		sbSql.append( " WHERE A.CLS_YM      < SUBSTR('" + v_TransDate + "',1,6) \n");
		sbSql.append( "   AND A.SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSql.append( "   AND A.CLS_FLAG    = 'Y' \n");
		sbSql.append( "   AND ROWNUM        <= 1 \n");
out_vl.add("fa_Sql", sbSql.toString());					
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		
		if(rs.next())
		{
			sOnhandMonth = rs.getString("CLS_YM");
		}
		else
		{
			sOnhandMonth = "000101";
		}
		
		rs.close();
		pstmt.close();
//System.out.println("sOnhandMonth:" + sOnhandMonth);
		sbSql.delete(0, sbSql.length());
		sbSql.append( "SELECT (SELECT Z.OTCUSTNM FROM FMW_OTCUST Z WHERE Z.OTCUSTCD = A.OTCUSTCD) AS OTCUSTNM \n");
		sbSql.append( "     , A.ITEM_CODE \n");
		sbSql.append( "     , A.ITEM_NAME \n");			
		sbSql.append( "     , A.ITEM_SIZE_BONG \n");
		sbSql.append( "     , SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,SUM(B.TRANS_QTY)), 1, INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,SUM(B.TRANS_QTY)), ',') - 1) AS BOX_QTY  --박스수량                                                           \n");
		sbSql.append( "     , SUBSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,SUM(B.TRANS_QTY)), INSTR(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,SUM(B.TRANS_QTY)), ',') + 1, LENGTH(FMW_UNIT_CHG_FUN(A.ITEM_CODE,1,0,SUM(B.TRANS_QTY)))) AS BONG_QTY  --봉수량   \n");
		sbSql.append( "     , ROUND(DECODE(SUM(B.UNIT_QTY),0,0,SUM(UNIT_AMOUNT) / SUM(B.UNIT_QTY)) * SUM(B.TRANS_QTY)) AS UNIT_AMOUNT \n");
		sbSql.append( "  FROM FMW_ITEM_V A, FMS_SUBINVENTORY F \n");
		sbSql.append( "     ,( \n");
		//sbSql.append( "       SELECT C.SUBINV_CODE \n");
		//sbSql.append( "            , C.ITEM_CODE \n");
		//sbSql.append( "            , C.ONHAND_QTY AS TRANS_QTY \n");
		//sbSql.append( "            , ABS(C.UNIT_AMOUNT) AS UNIT_AMOUNT  \n");
		//sbSql.append( "            , ABS(C.ONHAND_QTY) AS UNIT_QTY  \n");
		//sbSql.append( "         FROM FMW_ONHAND_MONTH C \n");
		//sbSql.append( "        WHERE C.ONHAND_YM   = '" + sOnhandMonth + "' \n");
		//sbSql.append( "          AND C.SUBINV_CODE = '" + v_SubinvCode + "' \n");
		//sbSql.append( "      UNION ALL \n");
		sbSql.append( "       SELECT D.SUBINV_CODE \n");
		sbSql.append( "            , D.ITEM_CODE \n");
		sbSql.append( "            , 0 AS TRANS_QTY \n");
		sbSql.append( "            , SUM(ABS(D.TRANS_AMOUNT))AS UNIT_AMOUNT \n");
		sbSql.append( "            , SUM(ABS(D.TRANS_QTY)) AS UNIT_QTY \n");
		sbSql.append( "         FROM FMW_PO_TRANSACTION D \n");
		sbSql.append( "        WHERE D.TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + sOnhandMonth + "'||'01','YYYYMMDD'),1),'YYYYMMDD') AND '" + v_TransDate + "' \n");
		sbSql.append( "          AND D.SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSql.append( "          AND D.TRANS_TYPE LIKE 'I%' \n");
		sbSql.append( "        GROUP BY D.SUBINV_CODE, D.ITEM_CODE \n");
		sbSql.append( "      UNION ALL \n");
		sbSql.append( "       SELECT E.SUBINV_CODE \n");
		sbSql.append( "            , E.ITEM_CODE \n");
		sbSql.append( "            , SUM(E.TRANS_QTY * E.PHYSIC_GUBUN) AS TRANS_QTY \n");
		sbSql.append( "            , 0 AS UNIT_AMOUNT \n");
		sbSql.append( "            , 0 AS UNIT_QTY \n");
		sbSql.append( "         FROM FMW_PO_TRANSACTION E \n");
		sbSql.append( "        WHERE E.TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + sOnhandMonth + "'||'01','YYYYMMDD'),1),'YYYYMMDD') AND '" + v_TransDate + "' \n");
		sbSql.append( "          AND E.SUBINV_CODE = '" + v_SubinvCode + "' \n");
		sbSql.append( "        GROUP BY E.SUBINV_CODE, E.ITEM_CODE \n");
		sbSql.append( "      ) B \n");
		sbSql.append( " WHERE B.SUBINV_CODE = F.SUBINV_CODE \n");
		sbSql.append( "   AND A.ITEM_CODE = B.ITEM_CODE                                             \n");
		sbSql.append( "   AND (A.ITEM_CODE LIKE '%" + nullToBlank(ds_Cond.getString(0, "ITEM_CODE")) + "%'               \n");
	    sbSql.append( "     OR A.ITEM_NAME LIKE '%" + nullToBlank(ds_Cond.getString(0, "ITEM_CODE")) + "%')              \n");
		sbSql.append( " GROUP BY A.OTCUSTCD, A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE_BONG                         \n");
		sbSql.append( "HAVING SUM(B.TRANS_QTY) <> 0                                                 \n");	
		sbSql.append( " ORDER BY A.OTCUSTCD, A.ITEM_CODE                                                 \n");
out_vl.add("fa_Sql", sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery();
		ds_List = this.makeDataSet(rs,"ds_List");
		out_dl.add(ds_List);
		//FileLog.println("c:\\ds_stock.txt",ds_stock);			
	   	this.setResultMessage(0, "OK",out_vl);
	   	
	} catch(Exception ex) {
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);	
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
//			if(stmt != null) {
//				try {
//					stmt.close();
//				}catch(Exception e) {}
//			}
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
