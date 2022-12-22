package com.ifis.fm.fmo;
import com.sz.business.BusinessRuntimeException;
import com.sz.service.sqlmap.SqlExecutor;
import com.sz.service.sqlmap.SqlMapFactoryHelper;
import com.sz.service.sqlmap.SqlRequest;
import com.sz.ui.AbstractAction;
import com.sz.ui.BusinessContext;
import com.tobesoft.xplatform.data.DataSet;
/**
 * 월 경영계획 등록
 */
public class FMO00210E_ACT extends AbstractAction {
	
	/**
	 * 월 경영계획(예산액) 조회
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
	    
	    // Query 생성
	    StringBuffer sbQuery = new StringBuffer();
	    sbQuery.setLength(0);
	    sbQuery.append("\nSELECT UPJANG, LINE_ID, SORT_SEQ, LINE_NAME, NUMERATOR, DENOMINATOR, EXP_AMT,																													");
	    sbQuery.append("\n       DECODE(DENOMINATOR_AMT, 0, 0, ROUND((NUMERATOR_AMT / DENOMINATOR_AMT) * 100,1) ) AS PER																								");
	    sbQuery.append("\n  FROM (SELECT A.UPJANG, A.LINE_ID, A.SORT_SEQ, A.LINE_NAME, A.NUMERATOR, A.DENOMINATOR,																										");
	    sbQuery.append("\n               FMO_PL_LINE_FUN(" + iMainUpjang + ", " + iUpjang + ", A.LINE_ID, '" + sSearchDate + "', '" + sSearchDate + "', '0') AS EXP_AMT,												");
	    sbQuery.append("\n               DECODE( A.NUMERATOR, NULL, 0, FMO_PL_LINE_FUN(" + iMainUpjang + ", " + iUpjang + ", A.NUMERATOR, '" + sSearchDate + "', '" + sSearchDate + "', '0')) AS NUMERATOR_AMT,			");
	    sbQuery.append("\n               DECODE( A.DENOMINATOR, NULL, 0, FMO_PL_LINE_FUN(" + iMainUpjang + ", " + iUpjang + ", A.DENOMINATOR, '" + sSearchDate + "', '" + sSearchDate + "', '0')) AS DENOMINATOR_AMT,	");
	    sbQuery.append("\n               DECODE(COUNT(B.ACCTCD), 1, 'Y', 'N') AS INPUT_YN																																");
	    sbQuery.append("\n          FROM FMO_PL_LINE A, FMO_PL_DTL B																																					");
	    sbQuery.append("\n         WHERE A.UPJANG = " + iMainUpjang + " -- 본사코드																																		");
	    sbQuery.append("\n           AND A.UPJANG = B.UPJANG(+)																																							");
	    sbQuery.append("\n           AND A.LINE_ID = B.LINE_ID(+)																																						");
	    sbQuery.append("\n         GROUP BY A.UPJANG, A.LINE_ID, A.SORT_SEQ, A.LINE_NAME, A.NUMERATOR, A.DENOMINATOR																									");
	    sbQuery.append("\n         ORDER BY A.SORT_SEQ)																																									");
	    
	    // SQL 요청자 정보 생성
	    SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		
		// Execute Result DataSet
	    DataSet dsResult = (DataSet)executor.query(sqlRequest).getResultObject();
	    
	    // Result DataSet Return
		ctx.addOutput("ds_List", dsResult);
	}
	
	/**
	 * 라인별 계정과목 경영계획(예산액) 조회
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
	    sbQuery.append("\nSELECT " + iUpjang + " AS UPJANG, '" + sSearchDate +"' AS YYMM, A.ACCTCD, B.ACCTNM,													");
	    sbQuery.append("\n       (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FM0001' AND CODE = B.ACCT_TYPE) AS ACCT_TYPE,						");
	    sbQuery.append("\n       NVL((SELECT EXP_AMT																											");
	    sbQuery.append("\n              FROM FMO_MGMT_EXPECT																									");
	    sbQuery.append("\n             WHERE UPJANG = " + iUpjang + " AND YYMM = '" + sSearchDate + "' AND ACCTCD = A.ACCTCD AND USE_YN = 'Y'),0) AS EXP_AMT,	");
	    sbQuery.append("\n       ACT_CONTROL_YN																													");
	    sbQuery.append("\n  FROM FMO_PL_DTL A,																													");
	    sbQuery.append("\n       (SELECT ACCTCD, ACCTNM, ACCT_TYPE, ACT_CONTROL_YN FROM FMO_ACCOUNT WHERE UPJANG = " + iMainUpjang + ") B						");
	    sbQuery.append("\n WHERE A.UPJANG = " + iMainUpjang + " -- 본사코드																						");
	    sbQuery.append("\n   AND A.LINE_ID = " + iLineId + " -- 라인ID																							");
	    sbQuery.append("\n   AND A.ACCTCD = B.ACCTCD(+)																											");
	    sbQuery.append("\n ORDER BY CAL_SORT																													");
	    
	    // SQL 요청자 정보 생성
	    SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		
		// Execute Result DataSet
	    DataSet dsResult = (DataSet)executor.query(sqlRequest).getResultObject();
	    
	    // Result DataSet Return
		ctx.addOutput("ds_Mgmt", dsResult);
	}
	
	/**
	 * 계정과목별 경영계획(예상액) 저장
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
		int    iExpAmt      = 0;
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
				iExpAmt = dsMgmt.getInt(i, "EXP_AMT");
				
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
		    		sbQuery.append("\n                            EXP_AMT, USE_YN, CUSER, CDATE)	");
		    		sbQuery.append("\n VALUES(" + iUpjang + ", '" + sYyMm + "', '" + sAcctCd + "',	");
		    		sbQuery.append("\n        " + iExpAmt + ", 'Y', '" + sEmpNo + "', SYSDATE)		");
		    		
		    		sqlRequest = SqlMapFactoryHelper.makeSqlRequestByInsertSql(sbQuery.toString());
					iSucCount += executor.execute(sqlRequest);
	    		} else {
	    			// UPDATE
	    			sbQuery.setLength(0);
		    		sbQuery.append("\nUPDATE FMO_MGMT_EXPECT				");
		    		sbQuery.append("\n   SET EXP_AMT = " + iExpAmt			 );
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
		    	throw new BusinessRuntimeException("경영계획 저장 중 오류가 발생하였습니다.\n관리자에게 문의하여 주십시요.");
		    }
	    }
	}
}
