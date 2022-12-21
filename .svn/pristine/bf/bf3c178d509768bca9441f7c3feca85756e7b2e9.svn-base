package com.ifis.fm.fmo;

import com.sz.service.sqlmap.SqlExecutor;
import com.sz.service.sqlmap.SqlMapFactoryHelper;
import com.sz.service.sqlmap.SqlRequest;
import com.sz.ui.AbstractAction;
import com.sz.ui.BusinessContext;
import com.sz.business.BusinessRuntimeException;
import com.tobesoft.xplatform.data.DataSet;

import com.ifis.sc.scc.CommonUtil;

/**
 * 손익계산표 양식 설정 Action
 */
public class FMO00110E_ACT extends AbstractAction {
	
	/**
	 * 본사 사용 계정코드 조회
	 * @param ctx
	 * @throws Exception
	 */
	public void searchAccount(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		DataSet dsInput = (DataSet) ctx.getInputObject("ds_Input");
		
		// 검색조건 DataSet 검증
		if( dsInput.getRowCount() != 1 ) {
			throw new BusinessRuntimeException("올바르지 않은 검색 정보입니다.\n관리자에게 문의하여 주십시요.");
		}
		
		// 변수 설정
		int iMainUpjang = dsInput.getInt(0, "MAIN_UPJANG");
		
		// DB 처리 객체 생성하기
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
	    
	    // Query 생성
	    StringBuffer sbQuery = new StringBuffer();
	    sbQuery.setLength(0);
	    sbQuery.append("\nSELECT 0 AS CHK, A.ACCTCD, A.ACCT_TYPE, B.CODE_NAME AS ACCT_TYPE_NM, A.ACCTNM			");
	    sbQuery.append("\n  FROM FMO_ACCOUNT A,																	");
	    sbQuery.append("\n       (SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FM0001') B	");
	    sbQuery.append("\n WHERE A.UPJANG = " + iMainUpjang														 );
	    sbQuery.append("\n   AND A.USE_YN = 'Y'																	");
	    sbQuery.append("\n   AND A.ACCT_TYPE = B.CODE(+)														");
	    sbQuery.append("\n ORDER BY A.ACCT_TYPE, A.ACCTCD														");
	    
	    // SQL 요청자 정보 생성
	    SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		
		// Execute Result DataSet
	    DataSet dsResult = (DataSet)executor.query(sqlRequest).getResultObject();
	    
	    // Result DataSet Return
		ctx.addOutput("ds_Account", dsResult);
	}
	
	/**
	 * 손익계산표 양식 조회
	 * @param ctx
	 * @throws Exception
	 */
	public void searchLine(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		DataSet dsInput = (DataSet) ctx.getInputObject("ds_Input");
		
		// 검색조건 DataSet 검증
		if( dsInput.getRowCount() != 1 ) {
			throw new BusinessRuntimeException("올바르지 않은 검색 정보입니다.\n관리자에게 문의하여 주십시요.");
		}
		
		// 변수 설정
		int iMainUpjang = dsInput.getInt(0, "MAIN_UPJANG");
		
		// DB 처리 객체 생성하기
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
	    
	    // Query 생성
	    StringBuffer sbQuery = new StringBuffer();
	    sbQuery.setLength(0);
	    sbQuery.append("\nSELECT UPJANG, LINE_ID, SORT_SEQ,			");
	    sbQuery.append("\n       LINE_NAME, NUMERATOR, DENOMINATOR	");
	    sbQuery.append("\n  FROM FMO_PL_LINE						");
	    sbQuery.append("\n WHERE UPJANG = " + iMainUpjang			 );
	    sbQuery.append("\n ORDER BY SORT_SEQ						");
	    
	    // SQL 요청자 정보 생성
	    SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		
		// Execute Result DataSet
	    DataSet dsResult = (DataSet)executor.query(sqlRequest).getResultObject();
	    
	    // Result DataSet Return
		ctx.addOutput("ds_Line", dsResult);
	}
	
	/**
	 * 손익계산표 라인별 수식 조회
	 * @param ctx
	 * @throws Exception
	 */
	public void searchCalc(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		DataSet dsInput = (DataSet) ctx.getInputObject("ds_Input");
		
		// 검색조건 DataSet 검증
		if( dsInput.getRowCount() != 1 ) {
			throw new BusinessRuntimeException("올바르지 않은 검색 정보입니다.\n관리자에게 문의하여 주십시요.");
		}
		
		// 변수 설정
		int iMainUpjang = dsInput.getInt(0, "MAIN_UPJANG");
		int iLineId     = dsInput.getInt(0, "LINE_ID"    );
		
		// DB 처리 객체 생성하기
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
	    
	    // Query 생성
	    StringBuffer sbQuery = new StringBuffer();
	    sbQuery.setLength(0);
	    sbQuery.append("\nSELECT A.UPJANG, A.LINE_ID, A.ACCTCD,	");
	    sbQuery.append("\n       A.CAL_SORT, A.ADD_YN, B.ACCTNM	");
	    sbQuery.append("\n  FROM FMO_PL_DTL A, FMO_ACCOUNT B	");
	    sbQuery.append("\n WHERE A.UPJANG = " + iMainUpjang		 );
	    sbQuery.append("\n   AND A.LINE_ID = " + iLineId		 );
	    sbQuery.append("\n   AND A.USE_YN = 'Y'					");
	    sbQuery.append("\n   AND A.UPJANG = B.UPJANG			");
	    sbQuery.append("\n   AND A.ACCTCD = B.ACCTCD			");
	    sbQuery.append("\n ORDER BY A.CAL_SORT					");
	    
	    // SQL 요청자 정보 생성
	    SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		
		// Execute Result DataSet
	    DataSet dsResult = (DataSet)executor.query(sqlRequest).getResultObject();
	    
	    // Result DataSet Return
		ctx.addOutput("ds_Calc", dsResult);
	}
	
	/**
	 * 손익계산서 양식 / 계산 수식 저장
	 * @param ctx
	 * @throws Exception
	 */
	public void saveLine(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		DataSet dsLine = (DataSet) ctx.getInputObject("ds_Line");
		DataSet dsCalc = (DataSet) ctx.getInputObject("ds_Calc");
		
		// 변수 설정
		int iTotUpdateCnt = 0;
		int iTotDeleteCnt = 0;
		int iSucCnt       = 0;
		
		// DB 처리 객체 생성하기
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
	    
	    // SQL 요청자 정보 생성
	    SqlRequest sqlRequest = null;
	    
	    // Query StringBuffer 생성
	    StringBuffer sbQuery = new StringBuffer();
	    		
		/*********** 1. 손익계산서 양식 INSERT / UPDATE / DELETE START *****************************************************************/
		// Transaction 검사를 위한 변수 설정
		iTotUpdateCnt = dsLine.getRowCount();
		iTotDeleteCnt = dsLine.getRemovedRowCount();
		iSucCnt = 0;
		
		// 변수 설정
		int    iMainUpjang  = 0;
		int    iLineId      = 0;
		int    iSortSeq     = 0;
		String sLineName    = "";
		String sNumerator   = "";
		String sDenominator = "";
		String sEmpNo       = ctx.getInputString("g_EmpNo");
		
		/* DELETE */
		for( int i=0; i<iTotDeleteCnt; i++ ) {
			iMainUpjang  = dsLine.getRemovedIntData(i, "UPJANG" );
			iLineId      = dsLine.getRemovedIntData(i, "LINE_ID");
			
    		sbQuery.setLength(0);
    		sbQuery.append("\nDELETE							");
    		sbQuery.append("\n  FROM FMO_PL_DTL					");
    		sbQuery.append("\n WHERE UPJANG = " + iMainUpjang	 );
    		sbQuery.append("\n   AND LINE_ID = " + iLineId		 );
    		
    		sqlRequest = SqlMapFactoryHelper.makeSqlRequestByDeleteSql(sbQuery.toString());
			executor.execute(sqlRequest);
			
    		sbQuery.setLength(0);
    		sbQuery.append("\nDELETE							");
    		sbQuery.append("\n  FROM FMO_PL_LINE				");
    		sbQuery.append("\n WHERE UPJANG = " + iMainUpjang	 );
    		sbQuery.append("\n   AND LINE_ID = " + iLineId		 );
    		
    		sqlRequest = SqlMapFactoryHelper.makeSqlRequestByDeleteSql(sbQuery.toString());
    		iSucCnt += executor.execute(sqlRequest);
		}
		/* DELETE COUNT 검증 */
		if( iSucCnt != iTotDeleteCnt ) {
			throw new BusinessRuntimeException("손익계산서 양식 저장 중 오류가 발생하였습니다.\n관리자에게 문의하여 주십시요.");
		}
		
		/* INSERT / UPDATE */
		iSucCnt = 0;
		for( int i=0; i<iTotUpdateCnt; i++ ) {
			
			iMainUpjang  = dsLine.getInt(i, "UPJANG"     );
			iSortSeq     = dsLine.getInt(i, "SORT_SEQ"   );
			sLineName    = dsLine.getString (i, "LINE_NAME"  );
			sNumerator   = dsLine.getString (i, "NUMERATOR"  );
			sDenominator = dsLine.getString (i, "DENOMINATOR");
			
			// dsLine.getRowStatus(i).equals("insert")
			if( dsLine.getRowType(i) == DataSet.ROW_TYPE_INSERTED ) {
				
	    		sbQuery.setLength(0);
	    		sbQuery.append("\nSELECT NVL(MAX(LINE_ID),0) + 1 AS MAX_LINE_ID	");
	    		sbQuery.append("\n  FROM FMO_PL_LINE							");
	    		sbQuery.append("\n WHERE UPJANG = " + iMainUpjang				 );
	    		
	    		sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
	    		DataSet dsResult = (DataSet)executor.query(sqlRequest).getResultObject();
	    		
	    		if( dsResult.getRowCount() == 0 ) {
	    			iLineId = 1;
	    		} else {
	    			iLineId = dsResult.getInt(0, "MAX_LINE_ID");
	    		}
	    		
	    		// 구성비의 기준값은 자동적으로 자기 자신으로 셋팅
	    		sNumerator = Integer.toString(iLineId);
	    		
	    		sbQuery.setLength(0);
	    		sbQuery.append("\nINSERT INTO FMO_PL_LINE (UPJANG, LINE_ID, SORT_SEQ, LINE_NAME,						");
	    		sbQuery.append("\n                         NUMERATOR, DENOMINATOR, CDATE, CUSER)						");
	    		sbQuery.append("\n VALUES(" + iMainUpjang + ", " + iLineId + ", " + iSortSeq + ", '" + sLineName + "',	");
	    		sbQuery.append("\n        " + sNumerator + ", " + sDenominator + ", SYSDATE, '" + sEmpNo + "')			");
	    		
	    		sqlRequest = SqlMapFactoryHelper.makeSqlRequestByInsertSql(sbQuery.toString());
				iSucCnt += executor.execute(sqlRequest);
				
			} else if( dsLine.getRowType(i) == DataSet.ROW_TYPE_UPDATED ) {
				
				iLineId      = dsLine.getInt(i, "LINE_ID"    );
				
				sbQuery.setLength(0);
	    		sbQuery.append("\nUPDATE FMO_PL_LINE						");
	    		sbQuery.append("\n   SET SORT_SEQ = " + iSortSeq			 );
	    		sbQuery.append("\n     , LINE_NAME = '" + sLineName +"'		");
    			sbQuery.append("\n     , NUMERATOR = " + sNumerator +"		");
    			sbQuery.append("\n     , DENOMINATOR = " + sDenominator +"	");
    			sbQuery.append("\n     , UDATE = SYSDATE					");
    			sbQuery.append("\n     , UUSER = '" + sEmpNo +"'			");
	    		sbQuery.append("\n WHERE UPJANG = " + iMainUpjang			 );
	    		sbQuery.append("\n   AND LINE_ID = " + iLineId				 );
	    		
	    		sqlRequest = SqlMapFactoryHelper.makeSqlRequestByUpdateSql(sbQuery.toString());
				iSucCnt += executor.execute(sqlRequest);
				
			}
		}
		/* INSERT / UPDATE COUNT 검증 */
		if( iSucCnt != iTotUpdateCnt ) {
			throw new BusinessRuntimeException("손익계산서 양식 저장 중 오류가 발생하였습니다.\n관리자에게 문의하여 주십시요.");
		}
		/*********** 1. 손익계산서 양식 INSERT / UPDATE / DELETE END *******************************************************************/
		
	    /*********** 2. 손익계산서 계산 수식 INSERT / UPDATE / DELETE START *************************************************************/
		// Transaction 검사를 위한 변수 설정
		iTotUpdateCnt = dsCalc.getRowCount();
	    iSucCnt       = 0;
	    
	    // 변수 설정
	    String sAcctCd  = "";
		int    iCalSort = 0;
		String sAddYn   = "";
		
	    if( iTotUpdateCnt > 0 ) {
	    	
	    	iMainUpjang = dsCalc.getInt(0, "UPJANG" );
    		iLineId     = dsCalc.getInt(0, "LINE_ID");
	    	
			sbQuery.setLength(0);
			sbQuery.append("\nDELETE							");
			sbQuery.append("\n  FROM FMO_PL_DTL					");
			sbQuery.append("\n WHERE UPJANG = " + iMainUpjang	 );
    		sbQuery.append("\n   AND LINE_ID = " + iLineId		 );
    		
    		sqlRequest = SqlMapFactoryHelper.makeSqlRequestByDeleteSql(sbQuery.toString());
			executor.execute(sqlRequest);
			
			for( int i=0; i<iTotUpdateCnt; i++ ) {
	    		iMainUpjang  = dsCalc.getInt(i, "UPJANG"  );
	    		iLineId      = dsCalc.getInt(i, "LINE_ID" );
				sAcctCd      = dsCalc.getString (i, "ACCTCD"  );
				iCalSort     = dsCalc.getInt(i, "CAL_SORT");
				sAddYn       = dsCalc.getString (i, "ADD_YN"  );
				
	    		sbQuery.setLength(0);
	    		sbQuery.append("\nINSERT INTO FMO_PL_DTL(UPJANG, LINE_ID, ACCTCD, CAL_SORT,							");
	    		sbQuery.append("\n                       ADD_YN, USE_YN)											");
	    		sbQuery.append("\n VALUES(" + iMainUpjang + ", " + iLineId + ", '" + sAcctCd + "', " + iCalSort + ",	");
	    		sbQuery.append("\n        '" + sAddYn + "', 'Y')													");
	    		
	    		sqlRequest = SqlMapFactoryHelper.makeSqlRequestByInsertSql(sbQuery.toString());
				iSucCnt += executor.execute(sqlRequest);
		    }
			
			/* INSERT COUNT 검증 */
		    if( iTotUpdateCnt != iSucCnt ) {
		    	throw new BusinessRuntimeException("손익계산서 계산 수식 저장 중 오류가 발생하였습니다.\n관리자에게 문의하여 주십시요.");
		    }
	    }
	    /*********** 2. 손익계산서 계산 수식 INSERT / UPDATE / DELETE END   *************************************************************/
	}
	
	/**
	 * 기본양식 가져오기 버튼 활성화/비활성화 체크
	 * @param ctx
	 * @throws Exception
	 */
	public void checkDefault(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		DataSet dsInput = (DataSet) ctx.getInputObject("ds_Input");
		
		// 검색조건 DataSet 검증
		if( dsInput.getRowCount() != 1 ) {
			throw new BusinessRuntimeException("올바르지 않은 검색 정보입니다.\n관리자에게 문의하여 주십시요.");
		}
		
		// 변수 설정
		int iMainUpjang = dsInput.getInt(0, "MAIN_UPJANG");
		
		// DB 처리 객체 생성하기
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
	    
	    // Query 생성
	    StringBuffer sbQuery = new StringBuffer();
	    sbQuery.setLength(0);
	    sbQuery.append("\nSELECT *									");
	    sbQuery.append("\n  FROM FMO_PL_LINE						");
	    sbQuery.append("\n WHERE UPJANG = " + iMainUpjang			 );
	    
	    // SQL 요청자 정보 생성
	    SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		
		// Execute Result DataSet
	    DataSet dsResult = (DataSet)executor.query(sqlRequest).getResultObject();
	    
	    // Result DataSet Return
		ctx.addOutput("ds_ChkDefault", dsResult);
	}
	
	/**
	 * 손익계산표 기본양식 조회
	 * @param ctx
	 * @throws Exception
	 */
	public void searchDefaultLine(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		DataSet dsInput = (DataSet) ctx.getInputObject("ds_Input");
		
		// 검색조건 DataSet 검증
		if( dsInput.getRowCount() != 1 ) {
			throw new BusinessRuntimeException("올바르지 않은 검색 정보입니다.\n관리자에게 문의하여 주십시요.");
		}
		
		// 변수 설정
		int iMainUpjang = dsInput.getInt(0, "MAIN_UPJANG");
		
		// DB 처리 객체 생성하기
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
	    
	    // Query 생성
	    StringBuffer sbQuery = new StringBuffer();
	    sbQuery.setLength(0);
	    sbQuery.append("\nSELECT " + iMainUpjang + " AS UPJANG , LINE_ID, SORT_SEQ,		");
	    sbQuery.append("\n       LINE_NAME, NUMERATOR, DENOMINATOR						");
	    sbQuery.append("\n  FROM FMO_PL_LINE											");
	    sbQuery.append("\n WHERE UPJANG = 000000										");
	    sbQuery.append("\n ORDER BY SORT_SEQ											");
	    
	    // SQL 요청자 정보 생성
	    SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		
		// Execute Result DataSet
	    DataSet dsResult = (DataSet)executor.query(sqlRequest).getResultObject();
	    
	    // Result DataSet Return
		ctx.addOutput("ds_TempLine", dsResult);
	}
	
	/**
	 * 손익계산서 구성비 수식 설정 저장(분자/분모)
	 * @param ctx
	 * @throws Exception
	 */
	public void saveCalcLine(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		DataSet dsLine  = (DataSet) ctx.getInputObject("ds_Line");
		
		// 변수 설정
		int    iTotCount    = 0;
		int    iSucCount    = 0;
		
		// DB 처리 객체 생성하기
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
	    // SQL 요청자 정보 생성
	    SqlRequest sqlRequest = null;
	    
	    // Query 생성
	    StringBuffer sbQuery = new StringBuffer();
	    
	    iTotCount = dsLine.getRowCount();
	    
	    if( iTotCount > 0 ) {
	    	
	    	int    iMainUpjang  = 0;
			int    iLineId      = 0;
			String sNumerator   = "";
			String sDenominator = "";
			
		    for( int i=0; i<iTotCount; i++ ) {
		    	// dsLine.getRowStatus(i).equals("update")
		    	if( dsLine.getRowType(i) == DataSet.ROW_TYPE_UPDATED) {
		    		iMainUpjang  = dsLine.getInt(i, "UPJANG"     );
					iLineId      = dsLine.getInt(i, "LINE_ID"    );
					sNumerator   = CommonUtil.nullToString(dsLine.getString(i, "NUMERATOR"), Integer.toString(iLineId));
					if( sNumerator.equals("0.0") ) {
						sNumerator = null;
					}
					sDenominator = dsLine.getString(i, "DENOMINATOR");
					if( sDenominator.equals("0.0") ) {
						sDenominator = null;
					}
					
		    		sbQuery.setLength(0);
		    		sbQuery.append("\nUPDATE FMO_PL_LINE						");
		    		sbQuery.append("\n   SET NUMERATOR = " + sNumerator + "		");
		    		sbQuery.append("\n     , DENOMINATOR = " + sDenominator + "	");
		    		sbQuery.append("\n WHERE UPJANG = " + iMainUpjang			 );
		    		sbQuery.append("\n   AND LINE_ID = " + iLineId				 );
		    		
		    		sqlRequest = SqlMapFactoryHelper.makeSqlRequestByUpdateSql(sbQuery.toString());
					iSucCount += executor.execute(sqlRequest);
		    	}
		    }
		    
		    // Transaction 처리
		    if( iTotCount != iSucCount ) {
		    	throw new BusinessRuntimeException("손익계산서 구성비 계산 수식 저장 중 오류가 발생하였습니다.\n관리자에게 문의하여 주십시요.");
		    }
	    }
	}
}
