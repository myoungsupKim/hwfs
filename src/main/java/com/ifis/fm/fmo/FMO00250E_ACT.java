package com.ifis.fm.fmo;
import com.sz.business.BusinessRuntimeException;
import com.sz.service.sqlmap.SqlExecutor;
import com.sz.service.sqlmap.SqlMapFactoryHelper;
import com.sz.service.sqlmap.SqlRequest;
import com.sz.ui.AbstractAction;
import com.sz.ui.BusinessContext;
import com.tobesoft.xplatform.data.DataSet;
/**
 * 월 경영실적 등록
 */
public class FMO00250E_ACT extends AbstractAction {
	
	/**
	 * 월 경영실적 조회
	 * @param ctx
	 * @throws Exception
	 */
	public void searchList(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		DataSet dsInput = (DataSet) ctx.getInputObject("ds_Input");
		
		// 검색조건 DataSet 검증
		if( dsInput.getRowCount() != 1 ) {
			throw new BusinessRuntimeException("올바르지 않은 검색 정보입니다.\n관리자에게 문의하여 주십시요.");
		}
		
		// 변수 설정
		int    iMainUpjang = dsInput.getInt(0, "MAIN_UPJANG");
		int    iUpjang     = dsInput.getInt(0, "UPJANG"     );
		String sSearchDate = dsInput.getString (0, "SEARCH_DATE");
		
		// DB 처리 객체 생성하기
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);

	    StringBuffer sbQuery = new StringBuffer();

	    /****************** 경영실적 조회  Start ***********************************************************************/
	    sbQuery.setLength(0);
	    sbQuery.append("\nSELECT UPJANG, LINE_ID, SORT_SEQ, LINE_NAME, NUMERATOR, DENOMINATOR, EXP_AMT, EXP_PER, ACT_AMT, ACT_PER,																					");
	    sbQuery.append("\n       ROUND(DECODE(EXP_AMT, 0, 0, (ACT_AMT / EXP_AMT) * 100 ), 1) AS PER																													");
	    sbQuery.append("\n  FROM (SELECT UPJANG, LINE_ID, SORT_SEQ, LINE_NAME, NUMERATOR, DENOMINATOR,																												");
	    sbQuery.append("\n               EXP_AMT, ROUND(DECODE(EXP_DENOMINATOR_AMT, 0, 0, (EXP_NUMERATOR_AMT / EXP_DENOMINATOR_AMT) * 100 ) , 1) AS EXP_PER,														");
	    sbQuery.append("\n               ACT_AMT, ROUND(DECODE(ACT_DENOMINATOR_AMT, 0, 0, (ACT_NUMERATOR_AMT / ACT_DENOMINATOR_AMT) * 100 ) , 1) AS ACT_PER															");
	    sbQuery.append("\n          FROM (SELECT A.UPJANG, A.LINE_ID, A.SORT_SEQ, A.LINE_NAME, A.NUMERATOR, A.DENOMINATOR,																							");
	    sbQuery.append("\n                       FMO_PL_LINE_FUN("+iMainUpjang+", "+iUpjang+", A.LINE_ID, '"+sSearchDate+"', '"+sSearchDate+"', '0') AS EXP_AMT,													");
	    sbQuery.append("\n                       DECODE( A.NUMERATOR, NULL, 0, FMO_PL_LINE_FUN("+iMainUpjang+", "+iUpjang+", A.NUMERATOR, '"+sSearchDate+"', '"+sSearchDate+"', '0')) AS EXP_NUMERATOR_AMT,			");
	    sbQuery.append("\n                       DECODE( A.DENOMINATOR, NULL, 0, FMO_PL_LINE_FUN("+iMainUpjang+", "+iUpjang+", A.DENOMINATOR, '"+sSearchDate+"', '"+sSearchDate+"', '0')) AS EXP_DENOMINATOR_AMT,	");
	    sbQuery.append("\n                       FMO_PL_LINE_FUN("+iMainUpjang+", "+iUpjang+", A.LINE_ID, '"+sSearchDate+"', '"+sSearchDate+"', '1') AS ACT_AMT,													");
	    sbQuery.append("\n                       DECODE( A.NUMERATOR, NULL, 0, FMO_PL_LINE_FUN("+iMainUpjang+", "+iUpjang+", A.NUMERATOR, '"+sSearchDate+"', '"+sSearchDate+"', '1')) AS ACT_NUMERATOR_AMT,			");
	    sbQuery.append("\n                       DECODE( A.DENOMINATOR, NULL, 0, FMO_PL_LINE_FUN("+iMainUpjang+", "+iUpjang+", A.DENOMINATOR, '"+sSearchDate+"', '"+sSearchDate+"', '1')) AS ACT_DENOMINATOR_AMT,	");
	    sbQuery.append("\n                       DECODE(COUNT(B.ACCTCD), 1, 'Y', 'N') AS INPUT_YN																													");
	    sbQuery.append("\n                  FROM FMO_PL_LINE A, FMO_PL_DTL B																																		");
	    sbQuery.append("\n                 WHERE A.UPJANG = "+iMainUpjang+" -- 본사코드																																");
	    sbQuery.append("\n                   AND A.UPJANG = B.UPJANG(+)																																				");
	    sbQuery.append("\n                   AND A.LINE_ID = B.LINE_ID(+)																																			");
	    sbQuery.append("\n                 GROUP BY A.UPJANG, A.LINE_ID, A.SORT_SEQ, A.LINE_NAME, A.NUMERATOR, A.DENOMINATOR																						");
	    sbQuery.append("\n                 ORDER BY A.SORT_SEQ))																																					");
	    
	    // SQL 요청자 정보 생성
	    SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		
		// Execute Result DataSet
	    DataSet dsResult = (DataSet)executor.query(sqlRequest).getResultObject();
	    /****************** 경영실적 조회  End *************************************************************************/
	    
	    /****************** 실적 집계여부 조회  Start *******************************************************************/
	    sbQuery.setLength(0);
	    sbQuery.append("\nSELECT *							");
	    sbQuery.append("\n  FROM FMO_MGMT_EXPECT			");
	    sbQuery.append("\n WHERE UPJANG = "+iUpjang			 );
	    sbQuery.append("\n   AND YYMM = '"+sSearchDate+"'	");
	    sbQuery.append("\n   AND NVL(ACT_AMT,0) <> 0		");
	    
	    // SQL 요청자 정보 생성
	    sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		
		// Execute Result DataSet
	    DataSet dsChkActTotal = (DataSet)executor.query(sqlRequest).getResultObject();
	    /****************** 실적 집계여부 조회 End **********************************************************************/
	    
	    // Result DataSet Return
		ctx.addOutput("ds_List",        dsResult     );
		ctx.addOutput("ds_ChkActTotal", dsChkActTotal);
	}
	
	public void searchFoodCost(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		DataSet dsInput = (DataSet) ctx.getInputObject("ds_Input");
		
		// 검색조건 DataSet 검증
		if( dsInput.getRowCount() != 1 ) {
			throw new BusinessRuntimeException("올바르지 않은 검색 정보입니다.\n관리자에게 문의하여 주십시요.");
		}
		
		// 변수 설정
		int    iMainUpjang = dsInput.getInt(0, "MAIN_UPJANG");
		int    iUpjang     = dsInput.getInt(0, "UPJANG"     );
		String sSearchDate = dsInput.getString (0, "SEARCH_DATE");
		
		// DB 처리 객체 생성하기
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);

	    StringBuffer sbQuery = new StringBuffer();

	    /************* 운영율 설정조회 ***************************************************************/
	    /*
	    sbQuery.setLength(0);
	    sbQuery.append("\nSELECT FMS_OPRATEINFO_FUN(" + iUpjang + ") AS OP_LEN");
	    sbQuery.append("\n  FROM FMS_UPJANG");
	    sbQuery.append("\n WHERE UPJANG = " + iUpjang);
	    */
	    // SQL 요청자 정보 생성
	    SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		
		// Execute Result DataSet
		//DataSet dsTemp = (DataSet)executor.query(sqlRequest).getResultObject();
	    /*
		String strOpLen;
		if( dsTemp.getRowCount() == 1 ) {
			strOpLen = dsTemp.getString(0, "OP_LEN");
		} else {
			throw new Exception("업장정보(운영율)가 올바르지 않습니다.");
		}
		*/
	    /****************** 식재료비현황 조회  Start ********************************************************************/
	    sbQuery.setLength(0);
	    sbQuery.append("\nSELECT A.UPJANG, B.UPJANGNM_DISP, A.SUBINV_CODE, A.SUBINV_NAME_DISP,																	");
	    sbQuery.append("\n       SUM(A.TOT_SALE_AMT) AS TOT_SALE, -- 매출액																						");
	    sbQuery.append("\n       SUM(A.TOT_HANWHA + A.TOT_SUPPLY + A.TOT_LOCALPO ) AS TOT_SUM, -- 합계															");
	    sbQuery.append("\n       SUM(A.TOT_HANWHA) AS HANWHA, -- 한화 식재료비																						");
	    sbQuery.append("\n       SUM(A.TOT_SUPPLY) AS SUPPLY, -- 공급업체 식재료비																					");
	    sbQuery.append("\n       SUM(A.TOT_LOCALPO) AS LOCALPO -- 현재구매 식재료비																					");
	    sbQuery.append("\n  FROM (SELECT TO_CHAR(A.UPJANG) AS UPJANG, A.SUBINV_CODE,");
	    sbQuery.append("\n               (SELECT Z.SUBINV_NAME_DISP FROM FMS_SUBINVENTORY Z WHERE Z.SUBINV_CODE = A.SUBINV_CODE) AS SUBINV_NAME_DISP,");
	    sbQuery.append("\n               SUM(NVL(A.OCCUR_AMT,0)) AS TOT_SALE_AMT,																				");
	    sbQuery.append("\n               0 AS TOT_HANWHA,																										");
	    sbQuery.append("\n               0 AS TOT_SUPPLY,																										");
	    sbQuery.append("\n               0 AS TOT_LOCALPO																										");
	    sbQuery.append("\n         FROM FMO_ACCT_OCCUR A, FMS_UPJANG B, FMO_ACCOUNT C");
	    sbQuery.append("\n        WHERE A.UPJANG = B.UPJANG																										");
	    sbQuery.append("\n          AND B.MAIN_UPJANG = C.UPJANG																										");
	    sbQuery.append("\n          AND A.ACCTCD = C.ACCTCD																										");
	    sbQuery.append("\n          AND A.UPJANG = " + iUpjang);
	    //sbQuery.append("\n          AND SUBSTR(A.OCCUR_DATE,0,6) = '" + sSearchDate + "'");
	    sbQuery.append("\n          AND A.OCCUR_DATE BETWEEN '" + sSearchDate + "'||'01' AND '" + sSearchDate + "'||'31'");
	    sbQuery.append("\n          AND C.ACCT_TYPE = '001'");
	    sbQuery.append("\n        GROUP BY A.UPJANG, A.SUBINV_CODE");
	    sbQuery.append("\n        UNION ALL																														");
	    
	    sbQuery.append("\n       SELECT TO_CHAR(A.UPJANG) AS UPJANG, A.SUBINV_CODE, E.SUBINV_NAME_DISP,																			");
	    sbQuery.append("\n              0 AS TOT_SALE_AMT,																										");
	    sbQuery.append("\n              SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL ");
	    sbQuery.append("\n                        THEN DECODE(A.OTCUSTCD,'0000',ROUND(A.OUT_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)),0)");
	    sbQuery.append("\n                        WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL");
	    sbQuery.append("\n                        THEN DECODE(A.OTCUSTCD,'0000',ROUND(A.OUT_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)),0)");
	    sbQuery.append("\n                   ELSE DECODE(A.OTCUSTCD,'0000',ROUND(A.OUT_QTY * A.PRICE),0) END");
	    sbQuery.append("\n              ) AS TOT_HANWHA,");
	    sbQuery.append("\n              SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL ");
	    sbQuery.append("\n                        THEN DECODE(A.OTCUSTCD,'0000',0,ROUND(A.OUT_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))");
	    sbQuery.append("\n                        WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL");
	    sbQuery.append("\n                        THEN DECODE(A.OTCUSTCD,'0000',0,ROUND(A.OUT_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)))");
	    sbQuery.append("\n                   ELSE DECODE(A.OTCUSTCD,'0000',0,ROUND(A.OUT_QTY * A.PRICE)) END");
	    sbQuery.append("\n              ) AS TOT_SUPPLY,");
	    sbQuery.append("\n              0 AS TOT_LOCALPO																							");
	    //sbQuery.append("\n         FROM FMP_SUBUL A																									");
	    //sbQuery.append("\n             ,FMS_ITEM_V B																								");
	    sbQuery.append("\n         FROM (SELECT A.* , B.ITEM_CLASS4, B.CONSUM_YN, B.OTCUSTCD FROM FMP_SUBUL A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A ");
	    sbQuery.append("\n             ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												");
	    sbQuery.append("\n                  FROM FMU_OP_RATE 																						");
	    sbQuery.append("\n         		   WHERE UPJANG = " + iUpjang 																				 );
	    sbQuery.append("\n                   AND USE_YN = 'Y'																						");
	    sbQuery.append("\n         			 AND ITEM_TYPE = 'M'																					");
	    sbQuery.append("\n         		) C																											");
	    sbQuery.append("\n             ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												");
	    sbQuery.append("\n                  FROM FMU_OP_RATE 																						");
	    sbQuery.append("\n         		   WHERE UPJANG = " + iUpjang 																				 );
	    sbQuery.append("\n                   AND USE_YN = 'Y'																						");
	    sbQuery.append("\n         			 AND ITEM_TYPE = 'C'																					");
	    sbQuery.append("\n         		) D																											");
	    sbQuery.append("\n         	   ,FMS_SUBINVENTORY E																							");
	    sbQuery.append("\n        WHERE 1=1																					");
	    //sbQuery.append("\n          AND A.UPJANG = C.UPJANG(+)																									");
	    sbQuery.append("\n          AND A.SDATE BETWEEN C.SDATE(+) AND C.EDATE(+)																	");
	    sbQuery.append("\n          AND A.SDATE BETWEEN D.SDATE(+) AND D.EDATE(+)																	");
	    //sbQuery.append("\n          AND SUBSTR(A.ITEM_CODE, 1, " + strOpLen + ") = C.ITEM_CODE(+)");
	    //sbQuery.append("\n          AND C.USE_YN(+) = 'Y'");
	    sbQuery.append("\n          AND A.SUBINV_CODE = E.SUBINV_CODE																				");
	    sbQuery.append("\n          AND A.UPJANG = " + iUpjang);
	    //sbQuery.append("\n          AND SUBSTR(A.SDATE,0,6) = '" + sSearchDate + "'");
	    sbQuery.append("\n          AND A.SDATE BETWEEN '" + sSearchDate + "'||'01' AND '" + sSearchDate + "'||'31'");
	    sbQuery.append("\n          AND A.CONSUM_YN = 'N'");
	    sbQuery.append("\n          AND E.STOCK_YN = 'Y'");
	    sbQuery.append("\n          AND A.ITEM_CODE = C.ITEM_CODE(+)");
	    sbQuery.append("\n          AND A.ITEM_CLASS4 = D.ITEM_CODE(+)");
	    
	    sbQuery.append("\n        GROUP BY A.UPJANG, A.SUBINV_CODE, E.SUBINV_NAME_DISP");

	    sbQuery.append("\n        UNION ALL																														");
	    sbQuery.append("\n       SELECT TO_CHAR(A.TRANS_UPJANG) AS UPJANG, A.SUBINV_CODE, E.SUBINV_NAME_DISP,																			");
	    sbQuery.append("\n              0 AS TOT_SALE_AMT,																										");
//	    sbQuery.append("\n              SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL ");
//	    sbQuery.append("\n                        THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))");
//	    sbQuery.append("\n                        WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL");
//	    sbQuery.append("\n                        THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE))");
//	    sbQuery.append("\n                   ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * A.SALE_PRICE) END");
//	    sbQuery.append("\n              ) AS TOT_HANWHA,");
	    sbQuery.append("\n     			DECODE(A.SAL_OPER_PRICE, 0, A.SALE_PRICE, A.SAL_OPER_PRICE) AS TOT_HANWHA, --운영단가 \n");
	    sbQuery.append("\n              0 AS TOT_SUPPLY,");
	    sbQuery.append("\n              0 AS TOT_LOCALPO																							");
	    //sbQuery.append("\n         FROM HLDC_PO_TRANSACTION A																									");
	    //sbQuery.append("\n             ,FMS_ITEM_V B																								");
	    sbQuery.append("\n         FROM (SELECT A.* , B.ITEM_CLASS4, B.CONSUM_YN FROM FMS_TRANSACTION_V A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A ");
//	    sbQuery.append("\n             ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												");
//	    sbQuery.append("\n                  FROM FMU_OP_RATE 																						");
//	    sbQuery.append("\n         		   WHERE UPJANG = " + iUpjang 																				 );
//	    sbQuery.append("\n                   AND USE_YN = 'Y'																						");
//	    sbQuery.append("\n         			 AND ITEM_TYPE = 'M'																					");
//	    sbQuery.append("\n         		) C																											");
//	    sbQuery.append("\n             ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												");
//	    sbQuery.append("\n                  FROM FMU_OP_RATE 																						");
//	    sbQuery.append("\n         		   WHERE UPJANG = " + iUpjang 																				 );
//	    sbQuery.append("\n                   AND USE_YN = 'Y'																						");
//	    sbQuery.append("\n         			 AND ITEM_TYPE = 'C'																					");
//	    sbQuery.append("\n         		) D																											");
	    sbQuery.append("\n         	   ,FMS_SUBINVENTORY E																							");
	    sbQuery.append("\n        WHERE 1=1																					");
	    //sbQuery.append("\n          AND A.TRANS_UPJANG = C.UPJANG(+)																									");
//	    sbQuery.append("\n          AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+)																");
//	    sbQuery.append("\n          AND A.TRANS_DATE BETWEEN D.SDATE(+) AND D.EDATE(+)																");
	    //sbQuery.append("\n          AND SUBSTR(A.ITEM_CODE, 1, " + strOpLen + ") = C.ITEM_CODE(+)");
	    //sbQuery.append("\n          AND C.USE_YN(+) = 'Y'");
	    sbQuery.append("\n          AND A.SUBINV_CODE = E.SUBINV_CODE																				");
	    sbQuery.append("\n          AND A.TRANS_UPJANG = " + iUpjang);
	    sbQuery.append("\n          AND A.TRANS_DATE BETWEEN '" + sSearchDate + "'||'01' AND '" + sSearchDate + "'||'31'");
	    sbQuery.append("\n          AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO'))");
	    sbQuery.append("\n          AND A.CONSUM_YN = 'N'");
	    sbQuery.append("\n          AND E.STOCK_YN = 'N'");
//	    sbQuery.append("\n          AND A.ITEM_CODE = C.ITEM_CODE(+)");
//	    sbQuery.append("\n          AND A.ITEM_CLASS4 = D.ITEM_CODE(+)");
	    sbQuery.append("\n        GROUP BY A.TRANS_UPJANG, A.SUBINV_CODE, E.SUBINV_NAME_DISP, A.SAL_OPER_PRICE, A.SALE_PRICE");
	    
	    sbQuery.append("\n        UNION ALL																														");
	    sbQuery.append("\n       SELECT TO_CHAR(A.UPJANG) AS UPJANG, A.SUBINV_CODE, E.SUBINV_NAME_DISP,																			");
	    sbQuery.append("\n              0 AS TOT_SALE_AMT,																										");
	    sbQuery.append("\n              0 AS TOT_HANWHA,");
	    sbQuery.append("\n     			DECODE(A.OP_PRICE, 0, A.SALE_PRICE, A.OP_PRICE) AS TOT_SUPPLY, \n");
//	    sbQuery.append("\n              SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL ");
//	    sbQuery.append("\n                        THEN ROUND(A.PO_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))");
//	    sbQuery.append("\n                        WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL");
//	    sbQuery.append("\n                        THEN ROUND(A.PO_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE))");
//	    sbQuery.append("\n                   ELSE ROUND(A.PO_QTY * A.SALE_PRICE) END");
//	    sbQuery.append("\n              ) AS TOT_SUPPLY,");
	    sbQuery.append("\n              0 AS TOT_LOCALPO																										");
	    //sbQuery.append("\n         FROM FMP_OTCUST_PR A																									");
	    //sbQuery.append("\n             ,FMS_ITEM_V B																								");
	    sbQuery.append("\n         FROM (SELECT A.* , B.ITEM_CLASS4, B.CONSUM_YN FROM FMP_OTCUST_PR A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A ");
//	    sbQuery.append("\n             ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												");
//	    sbQuery.append("\n                  FROM FMU_OP_RATE 																						");
//	    sbQuery.append("\n         		   WHERE UPJANG = " + iUpjang 																				 );
//	    sbQuery.append("\n                   AND USE_YN = 'Y'																						");
//	    sbQuery.append("\n         			 AND ITEM_TYPE = 'M'																					");
//	    sbQuery.append("\n         		) C																											");
//	    sbQuery.append("\n             ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												");
//	    sbQuery.append("\n                  FROM FMU_OP_RATE 																						");
//	    sbQuery.append("\n         		   WHERE UPJANG = " + iUpjang 																				 );
//	    sbQuery.append("\n                   AND USE_YN = 'Y'																						");
//	    sbQuery.append("\n         			 AND ITEM_TYPE = 'C'																					");
//	    sbQuery.append("\n         		) D																											");
	    sbQuery.append("\n         	   ,FMS_SUBINVENTORY E																							");
	    sbQuery.append("\n        WHERE 1=1																								");
	    //sbQuery.append("\n          AND A.UPJANG = C.UPJANG(+)																									");
//	    sbQuery.append("\n          AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+)																				");
//	    sbQuery.append("\n          AND A.NEED_DATE BETWEEN D.SDATE(+) AND D.EDATE(+)																				");
	    //sbQuery.append("\n          AND SUBSTR(A.ITEM_CODE, 1, " + strOpLen + ") = C.ITEM_CODE(+)");
	    //sbQuery.append("\n          AND C.USE_YN(+) = 'Y'");
	    sbQuery.append("\n          AND A.SUBINV_CODE = E.SUBINV_CODE																							");
	    sbQuery.append("\n          AND A.UPJANG = " + iUpjang);
	    sbQuery.append("\n          AND A.NEED_DATE BETWEEN '" + sSearchDate + "'||'01' AND '" + sSearchDate + "'||'31'");
	    sbQuery.append("\n          AND A.LINE_STATUS <> '003'");        
	    sbQuery.append("\n          AND A.CONSUM_YN = 'N'");
	    sbQuery.append("\n          AND E.STOCK_YN = 'N'");
//	    sbQuery.append("\n          AND A.ITEM_CODE = C.ITEM_CODE(+)");
//	    sbQuery.append("\n          AND A.ITEM_CLASS4 = D.ITEM_CODE(+)");
	    sbQuery.append("\n        GROUP BY A.UPJANG, A.SUBINV_CODE, E.SUBINV_NAME_DISP, A.OP_PRICE, A.SALE_PRICE ");
	    
	    sbQuery.append("\n        UNION ALL																														");
	    sbQuery.append("\n       SELECT TO_CHAR(A.UPJANG) AS UPJANG, A.SUBINV_CODE,E.SUBINV_NAME_DISP,																				");
	    sbQuery.append("\n              0 AS TOT_SALE_AMT,																										");
	    sbQuery.append("\n              0 AS TOT_HANWHA,																										");
	    sbQuery.append("\n              0 AS TOT_SUPPLY,																										");
	    sbQuery.append("\n              SUM(NVL(A.AMOUNT,0)) AS TOT_LOCALPO																						");
	    sbQuery.append("\n         FROM FMP_LOCALPO A, FMS_ITEM_V B, FMS_UPJANG D, FMS_SUBINVENTORY E															");
	    sbQuery.append("\n        WHERE A.ITEM_CODE = B.ITEM_CODE																								");
	    sbQuery.append("\n          AND A.UPJANG = D.UPJANG																										");
	    sbQuery.append("\n          AND A.SUBINV_CODE = E.SUBINV_CODE																							");
	    sbQuery.append("\n          AND B.CONSUM_YN = 'N'																										");
	    sbQuery.append("\n          AND A.UPJANG = " + iUpjang);
	    //sbQuery.append("\n          AND SUBSTR(A.PO_DATE,0,6) = '" + sSearchDate + "'");
	    sbQuery.append("\n          AND A.NEED_DATE BETWEEN '" + sSearchDate + "'||'01' AND '" + sSearchDate + "'||'31'");
	    sbQuery.append("\n        GROUP BY A.UPJANG, A.SUBINV_CODE, E.SUBINV_NAME_DISP ) A, FMS_UPJANG B														");
	    sbQuery.append("\n WHERE A.UPJANG = B.UPJANG																											");
	    sbQuery.append("\n GROUP BY A.UPJANG, B.UPJANGNM_DISP, A.SUBINV_CODE, A.SUBINV_NAME_DISP																");
	    
	    // SQL 요청자 정보 생성
	    sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		
		// Execute Result DataSet
	    DataSet dsFoodCost = (DataSet)executor.query(sqlRequest).getResultObject();
	    /****************** 식재료비현황 조회 End ***********************************************************************/
	    
	    /****************** 직원식대 조회  Start ************************************************************************/
	    sbQuery.setLength(0);
	    sbQuery.append("\nSELECT UPJANG, SUM(NVL(EMP_QTY,0) * NVL(EMP_UPRICE,0)) AS TOT_EMP		");
	    sbQuery.append("\n  FROM FMO_MONTH_PLAN_DTL												");
	    sbQuery.append("\n WHERE UPJANG = " + iUpjang											 );
	    sbQuery.append("\n   AND YYMM = '" + sSearchDate + "'									");
	    sbQuery.append("\n GROUP BY UPJANG														");
	    
	    // SQL 요청자 정보 생성
	    sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		
		// Execute Result DataSet
	    DataSet dsEmpUprice = (DataSet)executor.query(sqlRequest).getResultObject();
	    /****************** 직원식대 조회 End ***************************************************************************/
	    
	    // Result DataSet Return
		ctx.addOutput("ds_FoodCost",    dsFoodCost   );
		ctx.addOutput("ds_EmpUprice",   dsEmpUprice  );
	}

	/**
	 * 라인별 계정과목 경영실적 조회
	 * @param ctx
	 * @throws Exception
	 */
	public void searchMgmt(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		DataSet dsInput = (DataSet) ctx.getInputObject("ds_Input");
		
		// 검색조건 DataSet 검증
		if( dsInput.getRowCount() != 1 ) {
			throw new BusinessRuntimeException("올바르지 않은 검색 정보입니다.\n관리자에게 문의하여 주십시요.");
		}
		
		// 변수 설정
		int    iMainUpjang = dsInput.getInt(0, "MAIN_UPJANG");
		int    iUpjang     = dsInput.getInt(0, "UPJANG"     );
		String sSearchDate = dsInput.getString (0, "SEARCH_DATE");
		int    iLineId     = dsInput.getInt(0, "LINE_ID"    );
		
		// DB 처리 객체 생성하기
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		
		// Query 생성
		StringBuffer sbQuery = new StringBuffer();
		sbQuery.setLength(0);
		sbQuery.append("\nSELECT " + iUpjang + " AS UPJANG, '" + sSearchDate +"' AS YYMM, A.ACCTCD, B.ACCTNM");
		sbQuery.append("\n     , (SELECT Z.CODE_NAME FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FM0001' AND Z.CODE = B.ACCT_TYPE) AS ACCT_TYPE");
		sbQuery.append("\n     , NVL((SELECT Z.ACT_AMT");
		sbQuery.append("\n              FROM FMO_MGMT_EXPECT Z");
		sbQuery.append("\n             WHERE Z.UPJANG = " + iUpjang + " AND Z.YYMM = '" + sSearchDate + "' AND Z.ACCTCD = A.ACCTCD AND Z.USE_YN = 'Y'),0) AS ACT_AMT");
		sbQuery.append("\n     , B.ACT_CONTROL_YN");
		sbQuery.append("\n  FROM FMO_PL_DTL A");
		sbQuery.append("\n     , (SELECT ACCTCD, ACCTNM, ACCT_TYPE, ACT_CONTROL_YN FROM FMO_ACCOUNT WHERE UPJANG = " + iMainUpjang + " AND USE_YN = 'Y') B");
		sbQuery.append("\n WHERE A.UPJANG = " + iMainUpjang + " -- 본사코드");
		sbQuery.append("\n   AND A.LINE_ID = " + iLineId + " -- 라인ID");
		sbQuery.append("\n   AND A.ACCTCD = B.ACCTCD(+)");
		//sbQuery.append("\n ORDER BY A.CAL_SORT, B.ACCT_TYPE, A.ACCTCD");
		sbQuery.append("\n ORDER BY B.ACCT_TYPE, A.ACCTCD");
		
		// SQL 요청자 정보 생성
		SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		
		// Execute Result DataSet
		DataSet dsResult = (DataSet)executor.query(sqlRequest).getResultObject();
		
		// Result DataSet Return
		ctx.addOutput("ds_Mgmt", dsResult);
	}
	
	/**
	 * 계정과목별 경영실적 저장
	 * @param ctx
	 * @throws Exception
	 */
	public void saveMgmt(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		DataSet dsMgmt = (DataSet) ctx.getInputObject("ds_Mgmt");
		
		// 변수 설정
		int    iUpjang      = 0;
		String sYyMm        = "";
		String sAcctCd      = "";
		int    iActAmt      = 0;
		String sEmpNo       = ctx.getInputString("EMP_NO");
		int    iTotCount    = 0;
		int    iSucCount    = 0;
		
		// DB 처리 객체 생성하기
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
	    
	    // SQL 요청자 정보 생성
	    SqlRequest sqlRequest = null;
	    
	    // Query 생성
	    StringBuffer sbQuery = new StringBuffer();
	    
	    iTotCount = dsMgmt.getRowCount();
	    
	    if( iTotCount > 0 ) {
	    	
		    for( int i=0; i<iTotCount; i++ ) {
		    	
		    	iUpjang = dsMgmt.getInt(i, "UPJANG" );
				sYyMm   = dsMgmt.getString (i, "YYMM"   );
				sAcctCd = dsMgmt.getString (i, "ACCTCD" );
				iActAmt = dsMgmt.getInt(i, "ACT_AMT");
				
				System.out.println("iUpjang="+iUpjang);
				System.out.println("sYyMm="+sYyMm);
				System.out.println("sAcctCd="+sAcctCd);
				System.out.println("iActAmt="+iActAmt);
				
		    	sbQuery.setLength(0);
	    		sbQuery.append("\nSELECT *								");
	    		sbQuery.append("\n  FROM FMO_MGMT_EXPECT				");
	    		sbQuery.append("\n WHERE UPJANG = " + iUpjang			 );
	    		sbQuery.append("\n   AND YYMM = '" + sYyMm + "'			");
	    		sbQuery.append("\n   AND ACCTCD = '" + sAcctCd + "'		");
		    		
	    		sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
	    		DataSet dsResult = (DataSet)executor.query(sqlRequest).getResultObject();
	    		
	    		if( dsResult.getRowCount() == 0 ) {
	    			// INSERT
	    			sbQuery.setLength(0);
		    		sbQuery.append("\nINSERT INTO FMO_MGMT_EXPECT(UPJANG, YYMM, ACCTCD,				");
		    		sbQuery.append("\n                            ACT_AMT, USE_YN, CUSER, CDATE)	");
		    		sbQuery.append("\n VALUES(" + iUpjang + ", '" + sYyMm + "', '" + sAcctCd + "',	");
		    		sbQuery.append("\n        " + iActAmt + ", 'Y', '" + sEmpNo + "', SYSDATE)		");
		    		
		    		sqlRequest = SqlMapFactoryHelper.makeSqlRequestByInsertSql(sbQuery.toString());
					iSucCount += executor.execute(sqlRequest);
	    		} else {
	    			// UPDATE
	    			sbQuery.setLength(0);
		    		sbQuery.append("\nUPDATE FMO_MGMT_EXPECT				");
		    		sbQuery.append("\n   SET ACT_AMT = " + iActAmt			 );
		    		sbQuery.append("\n     , UUSER = '" + sEmpNo + "'		");
	    			sbQuery.append("\n     , UDATE = SYSDATE				");
		    		sbQuery.append("\n WHERE UPJANG = " + iUpjang			 );
		    		sbQuery.append("\n   AND YYMM = '" + sYyMm + "'			");
		    		sbQuery.append("\n   AND ACCTCD = '" + sAcctCd + "'		");
		    		
		    		sqlRequest = SqlMapFactoryHelper.makeSqlRequestByUpdateSql(sbQuery.toString());
					iSucCount += executor.execute(sqlRequest);
	    		}
		    }
		    
		    // Transaction 처리
		    if( iTotCount != iSucCount ) {
		    	throw new BusinessRuntimeException("경영실적 저장 중 오류가 발생하였습니다.\n관리자에게 문의하여 주십시요.");
		    }
	    }
	}
	
	/**
	 * 실적 집계 처리
	 * @param ctx
	 * @throws Exception
	 */
	public void saveActTotal(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		DataSet dsInput = (DataSet) ctx.getInputObject("ds_Input");
		
		// 검색조건 DataSet 검증
		if( dsInput.getRowCount() != 1 ) {
			throw new BusinessRuntimeException("올바르지 않은 검색 정보입니다.\n관리자에게 문의하여 주십시요.");
		}
		
		// 변수 설정
		int    iMainUpjang = dsInput.getInt(0, "MAIN_UPJANG");
		int    iUpjang     = dsInput.getInt(0, "UPJANG"     );
		String sSearchDate = dsInput.getString (0, "SEARCH_DATE");
		String sEmpNo      = ctx.getInputString("EMP_NO");
		int    iTotCount   = 0;
		int    iSucCount   = 0;
		
		// DB 처리 객체 생성하기
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
	    
	    // SQL 요청자 정보 생성
	    SqlRequest sqlRequest = null;
	    
	    // Query 생성
	    StringBuffer sbQuery = new StringBuffer();
	    
	    /************* 운영율 설정조회 ***************************************************************/
	    /*
	    sbQuery.setLength(0);
	    sbQuery.append("\nSELECT FMS_OPRATEINFO_FUN(" + iUpjang + ") AS OP_LEN");
	    sbQuery.append("\n  FROM FMS_UPJANG");
	    sbQuery.append("\n WHERE UPJANG = " + iUpjang);
	    */
	    // SQL 요청자 정보 생성
	    sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		
		// Execute Result DataSet
		//DataSet dsTemp = (DataSet)executor.query(sqlRequest).getResultObject();
	    /*
		String strOpLen;
		if( dsTemp.getRowCount() == 1 ) {
			strOpLen = dsTemp.getString(0, "OP_LEN");
		} else {
			throw new Exception("업장정보(운영율)가 올바르지 않습니다.");
		}
		*/
		sbQuery.setLength(0);
		//sbQuery.append("\n--매출/비용 등록내용");
		sbQuery.append("\nSELECT A.UPJANG");
		sbQuery.append("\n     , '" + sSearchDate + "' AS YYMM");
		sbQuery.append("\n     , A.ACCTCD");
		sbQuery.append("\n     , SUM(NVL(A.OCCUR_AMT,0)) AS OCCUR_AMT");
		sbQuery.append("\n  FROM FMO_ACCT_OCCUR A");
		sbQuery.append("\n WHERE A.UPJANG = " + iUpjang + "");
	    sbQuery.append("\n   AND A.OCCUR_DATE BETWEEN '" + sSearchDate + "'||'01' AND '" + sSearchDate + "'||'31'");
		sbQuery.append("\n   AND A.USE_YN = 'Y'");
		sbQuery.append("\n GROUP BY A.UPJANG, A.ACCTCD");
		sbQuery.append("\n ---------이상 매출/비용 등록내용");
		sbQuery.append("\n UNION ALL");
		sbQuery.append("\n ---------이하 노무관리 등록내용");
		//sbQuery.append("\n--노무관리 등록내용");
		sbQuery.append("\nSELECT " + iUpjang + " AS UPJANG");
		sbQuery.append("\n     , '" + sSearchDate + "' AS YYMM");
		sbQuery.append("\n     , A.ACCTCD");
		sbQuery.append("\n     , NVL(FMO_HUMANCOST_FUN(" + iUpjang + ", '" + sSearchDate + "', A.HUMAN_REL), 0) AS OCCUR_AMT");
		sbQuery.append("\n  FROM FMO_ACCOUNT A");
		sbQuery.append("\n WHERE A.UPJANG = " + iMainUpjang + "");
	    sbQuery.append("\n   AND TRIM(A.HUMAN_REL) > ' '");
		sbQuery.append("\n   AND A.USE_YN = 'Y'");
		sbQuery.append("\n ---------");
		sbQuery.append("\n UNION ALL");
		sbQuery.append("\n ---------이하 식재료비 등록내용");
		//sbQuery.append("\n--식재료비 등록내용");
		sbQuery.append("\nSELECT " + iUpjang + " AS UPJANG");
		sbQuery.append("\n     , '" + sSearchDate + "' AS YYMM");
		sbQuery.append("\n     , A.ACCTCD");
		sbQuery.append("\n     , SUM(A.AMT) AS OCCUR_AMT");
	    sbQuery.append("\n  FROM");
	    sbQuery.append("\n(");
	    sbQuery.append("\n--한화 식재료비(재고관리창고)");

	    
	    sbQuery.append("\nSELECT F.ACCTCD");
	    //sbQuery.append("\n     , SUM(ROUND(A.OUT_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS AMT");
	    sbQuery.append("\n             ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL ");
	    sbQuery.append("\n                        THEN ROUND(A.OUT_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))");
	    sbQuery.append("\n                        WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL");
	    sbQuery.append("\n                        THEN ROUND(A.OUT_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE))");
	    sbQuery.append("\n                   ELSE ROUND(A.OUT_QTY * A.PRICE) END");
	    sbQuery.append("\n              ) AS AMT");
	    //sbQuery.append("\n  FROM FMP_SUBUL A, FMS_ITEM_V B, FMU_OP_RATE C, FMS_SUBINVENTORY E");
	    //sbQuery.append("\n         FROM FMP_SUBUL A																									");
	    //sbQuery.append("\n             ,FMS_ITEM_V B																								");
	    sbQuery.append("\n         FROM (SELECT A.* , B.ITEM_CLASS4, B.CONSUM_YN, B.OTCUSTCD FROM FMP_SUBUL A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A ");
	    sbQuery.append("\n             ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												");
	    sbQuery.append("\n                  FROM FMU_OP_RATE 																						");
	    sbQuery.append("\n         		   WHERE UPJANG = " + iUpjang 																				 );
	    sbQuery.append("\n                   AND USE_YN = 'Y'																						");
	    sbQuery.append("\n         			 AND ITEM_TYPE = 'M'																					");
	    sbQuery.append("\n         		) C																											");
	    sbQuery.append("\n             ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												");
	    sbQuery.append("\n                  FROM FMU_OP_RATE 																						");
	    sbQuery.append("\n         		   WHERE UPJANG = " + iUpjang 																				 );
	    sbQuery.append("\n                   AND USE_YN = 'Y'																						");
	    sbQuery.append("\n         			 AND ITEM_TYPE = 'C'																					");
	    sbQuery.append("\n         		) D																											");
	    sbQuery.append("\n         	   ,FMS_SUBINVENTORY E																							");
	    
	    sbQuery.append("\n     , (SELECT Z.SET1 AS ACCTCD FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FM0018' AND Z.CODE = " + iMainUpjang + " AND Z.USE_YN = 'Y') F");
	    sbQuery.append("\n WHERE 1=1 ");
	    //sbQuery.append("\n   AND A.UPJANG = C.UPJANG(+)");
	    sbQuery.append("\n   AND A.SDATE BETWEEN C.SDATE(+) AND C.EDATE(+)");
	    sbQuery.append("\n   AND A.SDATE BETWEEN D.SDATE(+) AND D.EDATE(+)");
	    //sbQuery.append("\n   AND SUBSTR(A.ITEM_CODE, 1, " + strOpLen + ") = C.ITEM_CODE(+)");
	    //sbQuery.append("\n   AND C.USE_YN(+) = 'Y'");
	    sbQuery.append("\n   AND A.SUBINV_CODE = E.SUBINV_CODE");
	    sbQuery.append("\n   AND A.UPJANG = " + iUpjang);
	    sbQuery.append("\n   AND A.SDATE BETWEEN '" + sSearchDate + "'||'01' AND '" + sSearchDate + "'||'31'");
	    sbQuery.append("\n   AND A.CONSUM_YN = 'N'");
	    sbQuery.append("\n   AND E.STOCK_YN = 'Y'");
	    sbQuery.append("\n   AND A.OTCUSTCD = '0000'");
	    sbQuery.append("\n   AND A.ITEM_CODE = C.ITEM_CODE(+)");
	    sbQuery.append("\n   AND A.ITEM_CLASS4 = D.ITEM_CODE(+)");
	    sbQuery.append("\n GROUP BY F.ACCTCD");
	    
	    sbQuery.append("\n UNION ALL");
	    sbQuery.append("\n--공급업체 식재료비(재고관리창고)");
	    sbQuery.append("\nSELECT F.ACCTCD");
	    //sbQuery.append("\n     , SUM(ROUND(A.OUT_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS AMT");
	    sbQuery.append("\n             ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL ");
	    sbQuery.append("\n                        THEN ROUND(A.OUT_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))");
	    sbQuery.append("\n                        WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL");
	    sbQuery.append("\n                        THEN ROUND(A.OUT_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE))");
	    sbQuery.append("\n                   ELSE ROUND(A.OUT_QTY * A.PRICE) END");
	    sbQuery.append("\n              ) AS AMT");
	    //sbQuery.append("\n  FROM FMP_SUBUL A, FMS_ITEM_V B, FMU_OP_RATE C, FMS_SUBINVENTORY E");
	    //sbQuery.append("\n         FROM FMP_SUBUL A																									");
	    //sbQuery.append("\n             ,FMS_ITEM_V B																								");
	    sbQuery.append("\n         FROM (SELECT A.* , B.ITEM_CLASS4, B.CONSUM_YN, B.OTCUSTCD FROM FMP_SUBUL A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A ");
	    sbQuery.append("\n             ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												");
	    sbQuery.append("\n                  FROM FMU_OP_RATE 																						");
	    sbQuery.append("\n         		   WHERE UPJANG = " + iUpjang 																				 );
	    sbQuery.append("\n                   AND USE_YN = 'Y'																						");
	    sbQuery.append("\n         			 AND ITEM_TYPE = 'M'																					");
	    sbQuery.append("\n         		) C																											");
	    sbQuery.append("\n             ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												");
	    sbQuery.append("\n                  FROM FMU_OP_RATE 																						");
	    sbQuery.append("\n         		   WHERE UPJANG = " + iUpjang 																				 );
	    sbQuery.append("\n                   AND USE_YN = 'Y'																						");
	    sbQuery.append("\n         			 AND ITEM_TYPE = 'C'																					");
	    sbQuery.append("\n         		) D																											");
	    sbQuery.append("\n         	   ,FMS_SUBINVENTORY E																							");
	    
	    sbQuery.append("\n     , (SELECT Z.SET2 AS ACCTCD FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FM0018' AND Z.CODE = " + iMainUpjang + " AND Z.USE_YN = 'Y') F");
	    sbQuery.append("\n WHERE 1 = 1 ");
	    //sbQuery.append("\n   AND A.UPJANG = C.UPJANG(+)");
	    sbQuery.append("\n   AND A.SDATE BETWEEN C.SDATE(+) AND C.EDATE(+)");
	    sbQuery.append("\n   AND A.SDATE BETWEEN D.SDATE(+) AND D.EDATE(+)");
	    //sbQuery.append("\n   AND SUBSTR(A.ITEM_CODE, 1, " + strOpLen + ") = C.ITEM_CODE(+)");
	    //sbQuery.append("\n   AND C.USE_YN(+) = 'Y'");
	    sbQuery.append("\n   AND A.SUBINV_CODE = E.SUBINV_CODE");
	    sbQuery.append("\n   AND A.UPJANG = " + iUpjang);
	    sbQuery.append("\n   AND A.SDATE BETWEEN '" + sSearchDate + "'||'01' AND '" + sSearchDate + "'||'31'");
	    sbQuery.append("\n   AND A.CONSUM_YN = 'N'");
	    sbQuery.append("\n   AND E.STOCK_YN = 'Y'");
	    sbQuery.append("\n   AND A.OTCUSTCD <> '0000'");
	    sbQuery.append("\n   AND A.ITEM_CODE = C.ITEM_CODE(+)");
	    sbQuery.append("\n   AND A.ITEM_CLASS4 = D.ITEM_CODE(+)");
	    sbQuery.append("\n GROUP BY F.ACCTCD");
	    sbQuery.append("\n UNION ALL");
	    sbQuery.append("\n--한화 식재료비(재고미관리창고)");
	    
	    sbQuery.append("\nSELECT F.ACCTCD");
	    //sbQuery.append("\n     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS AMT");
	    sbQuery.append("     	 , DECODE(A.SAL_OPER_PRICE, 0, A.SALE_PRICE, A.SAL_OPER_PRICE) AS AMT \n");
//	    sbQuery.append("\n             ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL ");
//	    sbQuery.append("\n                        THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))");
//	    sbQuery.append("\n                        WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL");
//	    sbQuery.append("\n                        THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE))");
//	    sbQuery.append("\n                   ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * A.SALE_PRICE) END");
//	    sbQuery.append("\n              ) AS AMT");
	    //sbQuery.append("\n  FROM HLDC_PO_TRANSACTION A, FMS_ITEM_V B, FMU_OP_RATE C, FMS_SUBINVENTORY E");
	    //sbQuery.append("\n         FROM HLDC_PO_TRANSACTION A																									");
	    //sbQuery.append("\n             ,FMS_ITEM_V B																								");
	    sbQuery.append("\n         FROM (SELECT A.* , B.ITEM_CLASS4, B.CONSUM_YN, B.OTCUSTCD FROM FMS_TRANSACTION_V A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A ");
//	    sbQuery.append("\n             ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												");
//	    sbQuery.append("\n                  FROM FMU_OP_RATE 																						");
//	    sbQuery.append("\n         		   WHERE UPJANG = " + iUpjang 																				 );
//	    sbQuery.append("\n                   AND USE_YN = 'Y'																						");
//	    sbQuery.append("\n         			 AND ITEM_TYPE = 'M'																					");
//	    sbQuery.append("\n         		) C																											");
//	    sbQuery.append("\n             ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												");
//	    sbQuery.append("\n                  FROM FMU_OP_RATE 																						");
//	    sbQuery.append("\n         		   WHERE UPJANG = " + iUpjang 																				 );
//	    sbQuery.append("\n                   AND USE_YN = 'Y'																						");
//	    sbQuery.append("\n         			 AND ITEM_TYPE = 'C'																					");
//	    sbQuery.append("\n         		) D																											");
	    sbQuery.append("\n         	   ,FMS_SUBINVENTORY E																							");
	    sbQuery.append("\n     , (SELECT Z.SET1 AS ACCTCD FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FM0018' AND Z.CODE = " + iMainUpjang + " AND Z.USE_YN = 'Y') F");
	    sbQuery.append("\n WHERE 1 = 1 ");
	    //sbQuery.append("\n   AND A.TRANS_UPJANG = C.UPJANG(+)");
//	    sbQuery.append("\n   AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+)");
//	    sbQuery.append("\n   AND A.TRANS_DATE BETWEEN D.SDATE(+) AND D.EDATE(+)");
	    //sbQuery.append("\n   AND SUBSTR(A.ITEM_CODE, 1, " + strOpLen + ") = C.ITEM_CODE(+)");
	    //sbQuery.append("\n   AND C.USE_YN(+) = 'Y'");
	    sbQuery.append("\n   AND A.SUBINV_CODE = E.SUBINV_CODE");
	    sbQuery.append("\n   AND A.TRANS_UPJANG = " + iUpjang);
	    sbQuery.append("\n   AND A.TRANS_DATE BETWEEN '" + sSearchDate + "'||'01' AND '" + sSearchDate + "'||'31'");
	    sbQuery.append("\n   AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO'))");
	    sbQuery.append("\n   AND A.CONSUM_YN = 'N'");
	    sbQuery.append("\n   AND E.STOCK_YN = 'N'");
//	    sbQuery.append("\n   AND A.ITEM_CODE = C.ITEM_CODE(+)");
//	    sbQuery.append("\n   AND A.ITEM_CLASS4 = D.ITEM_CODE(+)");
	    sbQuery.append("\n GROUP BY F.ACCTCD, A.SAL_OPER_PRICE, A.SALE_PRICE");
	    sbQuery.append("\n UNION ALL");
	    sbQuery.append("\n--공급업체 식재료비(재고미관리창고)");
	    
	    sbQuery.append("\nSELECT F.ACCTCD");
	    //sbQuery.append("\n     , SUM(ROUND(A.PO_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS AMT");
	    sbQuery.append("     	 , DECODE(A.OP_PRICE, 0, A.SALE_PRICE, A.OP_PRICE) AS AMT \n");
//	    sbQuery.append("\n             ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL ");
//	    sbQuery.append("\n                        THEN ROUND(A.PO_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))");
//	    sbQuery.append("\n                        WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL");
//	    sbQuery.append("\n                        THEN ROUND(A.PO_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE))");
//	    sbQuery.append("\n                   ELSE ROUND(A.PO_QTY * A.SALE_PRICE) END");
//	    sbQuery.append("\n              ) AS AMT");
	    //sbQuery.append("\n  FROM FMP_OTCUST_PR A, FMS_ITEM_V B, FMU_OP_RATE C, FMS_SUBINVENTORY E");
	    //sbQuery.append("\n         FROM FMP_OTCUST_PR A																									");
	    //sbQuery.append("\n             ,FMS_ITEM_V B																								");
	    sbQuery.append("\n         FROM (SELECT A.* , B.ITEM_CLASS4, B.CONSUM_YN, B.OTCUSTCD FROM FMP_OTCUST_PR A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A ");
//	    sbQuery.append("\n             ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												");
//	    sbQuery.append("\n                  FROM FMU_OP_RATE 																						");
//	    sbQuery.append("\n         		   WHERE UPJANG = " + iUpjang 																				 );
//	    sbQuery.append("\n                   AND USE_YN = 'Y'																						");
//	    sbQuery.append("\n         			 AND ITEM_TYPE = 'M'																					");
//	    sbQuery.append("\n         		) C																											");
//	    sbQuery.append("\n             ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE												");
//	    sbQuery.append("\n                  FROM FMU_OP_RATE 																						");
//	    sbQuery.append("\n         		   WHERE UPJANG = " + iUpjang 																				 );
//	    sbQuery.append("\n                   AND USE_YN = 'Y'																						");
//	    sbQuery.append("\n         			 AND ITEM_TYPE = 'C'																					");
//	    sbQuery.append("\n         		) D																											");
	    sbQuery.append("\n         	   ,FMS_SUBINVENTORY E																							");
	    sbQuery.append("\n     , (SELECT Z.SET2 AS ACCTCD FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FM0018' AND Z.CODE = " + iMainUpjang + " AND Z.USE_YN = 'Y') F");
	    sbQuery.append("\n WHERE 1 = 1");
	    //sbQuery.append("\n   AND A.UPJANG = C.UPJANG(+)");
//	    sbQuery.append("\n   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+)");
//	    sbQuery.append("\n   AND A.NEED_DATE BETWEEN D.SDATE(+) AND D.EDATE(+)");
	    //sbQuery.append("\n   AND SUBSTR(A.ITEM_CODE, 1, " + strOpLen + ") = C.ITEM_CODE(+)");
	    //sbQuery.append("\n   AND C.USE_YN(+) = 'Y'");
	    sbQuery.append("\n   AND A.SUBINV_CODE = E.SUBINV_CODE");
	    sbQuery.append("\n   AND A.UPJANG = " + iUpjang);
	    sbQuery.append("\n   AND A.NEED_DATE BETWEEN '" + sSearchDate + "'||'01' AND '" + sSearchDate + "'||'31'");
	    sbQuery.append("\n   AND A.LINE_STATUS <> '003'");        
	    sbQuery.append("\n   AND A.CONSUM_YN = 'N'");
	    sbQuery.append("\n   AND E.STOCK_YN = 'N'");
//	    sbQuery.append("\n   AND A.ITEM_CODE = C.ITEM_CODE(+)");
//	    sbQuery.append("\n   AND A.ITEM_CLASS4 = D.ITEM_CODE(+)");
	    sbQuery.append("\n GROUP BY F.ACCTCD, A.OP_PRICE, A.SALE_PRICE");
	    sbQuery.append("\n UNION ALL");
	    sbQuery.append("\n--현지구매 식재료비");
	    sbQuery.append("\nSELECT F.ACCTCD");
	    sbQuery.append("\n     , SUM(NVL(A.AMOUNT,0)) AS AMT");
	    sbQuery.append("\n  FROM FMP_LOCALPO A, FMS_ITEM_V B, FMS_UPJANG D, FMS_SUBINVENTORY E");
	    sbQuery.append("\n     , (SELECT Z.SET3 AS ACCTCD FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FM0018' AND Z.CODE = " + iMainUpjang + " AND Z.USE_YN = 'Y') F");
	    sbQuery.append("\n WHERE A.ITEM_CODE = B.ITEM_CODE");
	    sbQuery.append("\n   AND A.UPJANG = D.UPJANG");
	    sbQuery.append("\n   AND A.SUBINV_CODE = E.SUBINV_CODE");
	    sbQuery.append("\n   AND B.CONSUM_YN = 'N'");
	    sbQuery.append("\n   AND A.UPJANG = " + iUpjang);
	    sbQuery.append("\n   AND A.NEED_DATE BETWEEN '" + sSearchDate + "'||'01' AND '" + sSearchDate + "'||'31'");
	    sbQuery.append("\n GROUP BY F.ACCTCD");
	    sbQuery.append("\n UNION ALL");
	    sbQuery.append("\n--직원식대(경우에 따라 +/- 처리(SET5))");
	    sbQuery.append("\nSELECT F.ACCTCD");
	    sbQuery.append("\n     , SUM(F.DIG * NVL(A.EMP_QTY,0) * NVL(A.EMP_UPRICE,0)) AS AMT");
	    sbQuery.append("\n  FROM FMO_MONTH_PLAN_DTL	A");
	    sbQuery.append("\n     , (SELECT Z.SET4 AS ACCTCD, SIGN(TO_NUMBER(NVL(Z.SET5,'1'))) AS DIG FROM SCC_COMMON_CODE Z WHERE Z.GROUP_CODE = 'FM0018' AND Z.CODE = " + iMainUpjang + " AND Z.USE_YN = 'Y') F");
	    sbQuery.append("\n WHERE UPJANG = " + iUpjang);
	    sbQuery.append("\n   AND YYMM = '" + sSearchDate + "'");
	    sbQuery.append("\n GROUP BY F.ACCTCD");
	    sbQuery.append("\n) A");
		sbQuery.append("\n GROUP BY A.ACCTCD");
    		
		sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		DataSet dsResult = (DataSet)executor.query(sqlRequest).getResultObject();
		
		iTotCount = dsResult.getRowCount();
		
		if( iTotCount > 0 ) {
			String sYyMm   = "";
			String sAcctCd = "";
			int    iActAmt = 0;
			
			for( int i=0; i<dsResult.getRowCount(); i++ ) {
				
				sYyMm   = dsResult.getString (i, "YYMM"     );
				sAcctCd = dsResult.getString (i, "ACCTCD"   );
				iActAmt = dsResult.getInt(i, "OCCUR_AMT");
				
				sbQuery.setLength(0);
	    		sbQuery.append("\nSELECT *								");
	    		sbQuery.append("\n  FROM FMO_MGMT_EXPECT				");
	    		sbQuery.append("\n WHERE UPJANG = " + iUpjang			 );
	    		sbQuery.append("\n   AND YYMM = '" + sYyMm + "'			");
	    		sbQuery.append("\n   AND ACCTCD = '" + sAcctCd + "'		");
		    		
	    		sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
	    		DataSet dsMgmt = (DataSet)executor.query(sqlRequest).getResultObject();
	    		
	    		if( dsMgmt.getRowCount() == 0 ) {
	    			// INSERT
	    			sbQuery.setLength(0);
		    		sbQuery.append("\nINSERT INTO FMO_MGMT_EXPECT(UPJANG, YYMM, ACCTCD,				");
		    		sbQuery.append("\n                            ACT_AMT, USE_YN, CUSER, CDATE)	");
		    		sbQuery.append("\n VALUES(" + iUpjang + ", '" + sYyMm + "', '" + sAcctCd + "',	");
		    		sbQuery.append("\n        " + iActAmt + ", 'Y', '" + sEmpNo + "', SYSDATE)		");
		    		
		    		sqlRequest = SqlMapFactoryHelper.makeSqlRequestByInsertSql(sbQuery.toString());
					iSucCount += executor.execute(sqlRequest);
	    		} else {
	    			// UPDATE
	    			sbQuery.setLength(0);
		    		sbQuery.append("\nUPDATE FMO_MGMT_EXPECT				");
		    		sbQuery.append("\n   SET ACT_AMT = " + iActAmt			 );
		    		sbQuery.append("\n     , UUSER = '" + sEmpNo + "'		");
	    			sbQuery.append("\n     , UDATE = SYSDATE				");
		    		sbQuery.append("\n WHERE UPJANG = " + iUpjang			 );
		    		sbQuery.append("\n   AND YYMM = '" + sYyMm + "'			");
		    		sbQuery.append("\n   AND ACCTCD = '" + sAcctCd + "'		");
		    		
		    		sqlRequest = SqlMapFactoryHelper.makeSqlRequestByUpdateSql(sbQuery.toString());
					iSucCount += executor.execute(sqlRequest);
	    		}
			}
		}
		
	    // Transaction 처리
	    if( iTotCount != iSucCount ) {
	    	throw new BusinessRuntimeException("경영실적 저장 중 오류가 발생하였습니다.\n관리자에게 문의하여 주십시요.");
	    }
	    
	    // Result DataSet Return
		ctx.addOutput("ds_ActTotal", dsResult);
	}
}
