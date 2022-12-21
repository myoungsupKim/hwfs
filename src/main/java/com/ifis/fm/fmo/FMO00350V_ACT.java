package com.ifis.fm.fmo;
import com.sz.business.BusinessRuntimeException;
import com.sz.service.sqlmap.SqlExecutor;
import com.sz.service.sqlmap.SqlMapFactoryHelper;
import com.sz.service.sqlmap.SqlRequest;
import com.sz.ui.AbstractAction;
import com.sz.ui.BusinessContext;
import com.sz.util.AppDataUtility;
import com.tobesoft.xplatform.data.DataSet;
/**
 * 사업장별 손익분석
 */
public class FMO00350V_ACT extends AbstractAction {
	
	/**
	 * 손익분석 조회
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
		String sUpjang     = dsInput.getString (0, "UPJANG"     );
		int    iUpjang     = 0;
		if( AppDataUtility.isNotNull(sUpjang) ) {
			iUpjang = Integer.parseInt(sUpjang);
		}
		String sFromDate   = dsInput.getString (0, "FROM_DATE"  );
		String sToDate     = dsInput.getString (0, "TO_DATE"    );
		int    iUpjangCnt  = 0;
		
		// DB 처리 객체 생성하기
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
	    
	    /****************** 사업장 리스트 조회  Start *******************************************************************/
	    StringBuffer sbQuery = new StringBuffer();
	    sbQuery.setLength(0);
	    sbQuery.append("\nSELECT MAIN_UPJANG, UPJANG, UPJANGNM_DISP AS UPJANGNM				");
	    sbQuery.append("\n  FROM FMS_UPJANG													");
	    sbQuery.append("\n WHERE MAIN_UPJANG = " + iMainUpjang + " -- 본사코드(필수 검색조건)	");
	    if( iUpjang != 0 ) {
	    	sbQuery.append("\n   AND UPJANG = " + iUpjang + " -- 업장코드(선택 검색조건)			");
	    }
	    sbQuery.append("\n   AND USE_YN = 'Y'												");
	    sbQuery.append("\n ORDER BY UPJANG													");
	    
	    // SQL 요청자 정보 생성
	    SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		
		// Execute Result DataSet
	    DataSet dsUpjangList = (DataSet)executor.query(sqlRequest).getResultObject();
	    /****************** 사업장 리스트 조회  End *********************************************************************/
	    
	    iUpjangCnt = dsUpjangList.getRowCount();
	    
	    /****************** 사업장별 손익분석 조회 Start ****************************************************************/
	    if( iUpjangCnt >= 1 )
	    {
	    	// 손익보고서 Query Setting
    		sbQuery.setLength(0);
    	    sbQuery.append("\nSELECT LINE_NAME,																																			");
    	    
    	    // 누계 합산을 위한 Query 생성
    	    String sSumExpAmtQuery = "(";
    	    String sSumActAmtQuery = "(";
    	    String sSumPerQuery    = "";
    	    for( int i=0; i<iUpjangCnt; i++ ) {
    	    	if( i == 0 ) {
    	    		sSumExpAmtQuery += "SUM(EXP_AMT" + (i+1) + ")";
    	    		sSumActAmtQuery += "SUM(ACT_AMT" + (i+1) + ")";
    	    	} else {
    	    		sSumExpAmtQuery += " + SUM(EXP_AMT" + (i+1) + ")";
    	    		sSumActAmtQuery += " + SUM(ACT_AMT" + (i+1) + ")";
    	    	}
    	    }
    	    sSumExpAmtQuery += ")";
    		sSumActAmtQuery += ")";
    		sSumPerQuery    += "ROUND(DECODE("+sSumExpAmtQuery+", 0, 0, ("+sSumActAmtQuery+" / "+sSumExpAmtQuery+") * 100 ), 1)";
    		
    	    sbQuery.append("\n       "+sSumExpAmtQuery+" AS SUM_EXP_AMT,																												");
    	    sbQuery.append("\n       "+sSumActAmtQuery+" AS SUM_ACT_AMT,																												");
    	    sbQuery.append("\n       "+sSumPerQuery+" AS SUM_PER,																														");
    	    for( int i=0; i<iUpjangCnt; i++ ) {
    	    	sbQuery.append("\n       SUM(EXP_AMT"+(i+1)+") AS EXP_AMT"+(i+1)+",																										");
    	    	sbQuery.append("\n       SUM(ACT_AMT"+(i+1)+") AS ACT_AMT"+(i+1)+",																										");
    	    	sbQuery.append("\n       SUM(PER"+(i+1)+") AS PER"+(i+1)+",																												");
    	    }
    	    sbQuery.append("\n       LINE_ID																																			");
    	    sbQuery.append("\n  FROM (																																					");
    	    sbQuery.append("\n        SELECT LINE_NAME,																																	");
    	    for( int i=0; i<iUpjangCnt; i++ ) {
    	    	if( i == iUpjangCnt - 1 ) {
	    	    	sbQuery.append("\n               DECODE( MOD(SEQ, "+iUpjangCnt+"), 0,  EXP_AMT, 0 ) AS EXP_AMT"+(i+1)+",															");
	    	    	sbQuery.append("\n               DECODE( MOD(SEQ, "+iUpjangCnt+"), 0,  ACT_AMT, 0 ) AS ACT_AMT"+(i+1)+",															");
	    	    	sbQuery.append("\n               DECODE( MOD(SEQ, "+iUpjangCnt+"), 0,  PER,     0 ) AS PER"+(i+1)+",																");
    	    	} else {
    	    		sbQuery.append("\n               DECODE( MOD(SEQ, "+iUpjangCnt+"), "+(i+1)+",  EXP_AMT, 0 ) AS EXP_AMT"+(i+1)+",													");
	    	    	sbQuery.append("\n               DECODE( MOD(SEQ, "+iUpjangCnt+"), "+(i+1)+",  ACT_AMT, 0 ) AS ACT_AMT"+(i+1)+",													");
	    	    	sbQuery.append("\n               DECODE( MOD(SEQ, "+iUpjangCnt+"), "+(i+1)+",  PER,     0 ) AS PER"+(i+1)+",														");
    	    	}
    	    }
    	    sbQuery.append("\n               LINE_ID, SORT_SEQ																															");
    	    sbQuery.append("\n          FROM (																																			");
    	    sbQuery.append("\n                SELECT MAIN_UPJANG, UPJANG, UPJANGNM, SEQ, SORT_SEQ, LINE_ID, LINE_NAME, EXP_AMT, ACT_AMT,												");
    	    sbQuery.append("\n                       ROUND(DECODE(EXP_AMT, 0, 0, (ACT_AMT / EXP_AMT) * 100 ), 1) AS PER																	");
    	    sbQuery.append("\n                  FROM (																																	");
    	    sbQuery.append("\n                        SELECT T2.MAIN_UPJANG, T2.UPJANG, T2.UPJANGNM_DISP AS UPJANGNM, T2.SEQ, T1.LINE_ID, T1.SORT_SEQ,									");
    	    sbQuery.append("\n                               T1.LINE_NAME, T1.NUMERATOR, T1.DENOMINATOR,																				");
    	    sbQuery.append("\n                               FMO_PL_LINE_FUN(T2.MAIN_UPJANG, T2.UPJANG, T1.LINE_ID, '"+sFromDate+"', '"+sToDate+"', '0') AS EXP_AMT,					");
    	    sbQuery.append("\n                               FMO_PL_LINE_FUN(T2.MAIN_UPJANG, T2.UPJANG, T1.LINE_ID, '"+sFromDate+"', '"+sToDate+"', '1') AS ACT_AMT						");
    	    sbQuery.append("\n                          FROM FMO_PL_LINE T1,																											");
    	    sbQuery.append("\n                               (SELECT MAIN_UPJANG, ROW_NUMBER() OVER(PARTITION BY MAIN_UPJANG ORDER BY UPJANG ASC) AS SEQ, UPJANG, UPJANGNM_DISP			");
    	    sbQuery.append("\n                                  FROM FMS_UPJANG																											");
    	    sbQuery.append("\n                                 WHERE MAIN_UPJANG = "+iMainUpjang+" -- 본사코드(필수 검색조건)																");
    	    if( iUpjang != 0 ) {
    	    	sbQuery.append("\n                                   AND UPJANG = "+iUpjang+" -- 업장코드(선택 검색조건)																		");
    	    }
    	    sbQuery.append("\n                                   AND USE_YN = 'Y'																										");
    	    sbQuery.append("\n                                 ORDER BY UPJANG) T2																										");
    	    sbQuery.append("\n                         WHERE T1.UPJANG = "+iMainUpjang																									 );
    	    sbQuery.append("\n                           AND T1.UPJANG = T2.MAIN_UPJANG																									");
    	    sbQuery.append("\n                         ORDER BY T2.MAIN_UPJANG, T2.UPJANG, T1.SORT_SEQ ) ) )																			");
    	    sbQuery.append("\n GROUP BY SORT_SEQ, LINE_ID, LINE_NAME																													");
    	    sbQuery.append("\n ORDER BY SORT_SEQ																																		");
	    }
	    else
	    {
	    	sbQuery.setLength(0);
	    	sbQuery.append("\nSELECT LINE_ID, LINE_NAME,								");
	    	sbQuery.append("\n       0 AS SUM_EXP_AMT, 0 AS SUM_ACT_AMT, 0 AS SUM_PER	");
	    	sbQuery.append("\n	FROM FMO_PL_LINE										");
	    	sbQuery.append("\n WHERE UPJANG = "+iMainUpjang								 );
	    	sbQuery.append("\n ORDER BY SORT_SEQ										");
	    }
	    /****************** 사업장별 손익분석 조회 End ******************************************************************/
	    
	    // SQL 요청자 정보 생성
	    sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		
		// Execute Result DataSet
	    DataSet dsList = (DataSet)executor.query(sqlRequest).getResultObject();
	    
	    // Result DataSet Return
		ctx.addOutput("ds_UpjangList", dsUpjangList);
		ctx.addOutput("ds_List",       dsList      );
	}
}
