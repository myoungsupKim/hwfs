package com.ifis.fs.fsa;

import com.sz.business.BusinessRuntimeException;
import com.sz.service.sqlmap.SqlExecutor;
import com.sz.service.sqlmap.SqlMapFactoryHelper;
import com.sz.service.sqlmap.SqlRequest;
import com.sz.ui.AbstractAction;
import com.sz.ui.BusinessContext;
import com.sz.util.AppDataUtility;
import com.tobesoft.xplatform.data.DataSet;
/**
 * 월말목표재고비율 설정
 */
public class FSA00040E_ACT extends AbstractAction {
	
// [속도개선 Project 시작] 2017. 6. 29. 최범주 ChangeAddParamObject
	private static final long serialVersionUID = 3655365465574242881L;
// [속도개선 Project   끝] 2017. 6. 29. 최범주	

	/**
	 * 목표재고비율 검색
	 * @param ctx
	 * @throws Exception
	 */
	public void searchGoalRate(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		DataSet dsInput = (DataSet) ctx.getInputObject("ds_Input");
		
		// 검색조건 DataSet 검증
		if( dsInput.getRowCount() != 1 ) {
			throw new BusinessRuntimeException("올바르지 않은 검색 정보입니다.\n관리자에게 문의하여 주십시요.");
		}
		
		// 변수 선언
		String sJobCd    = dsInput.getString(0,  "JOB_CD"    );
		String sSubJobCd = dsInput.getString(0,  "SUB_JOB_CD");
		String sTmCd     = dsInput.getString(0,  "TM_CD"     );
		String sUpjang   = dsInput.getString(0,  "UPJANG"    );
		String sYear     = dsInput.getString(0,  "YEAR"      );
		String sOnly     = dsInput.getString(0,  "ONLY"      );
		String sMuCd     = dsInput.getString(0,  "MU_CD"     );
		
		// Query Setting
// [속도개선 Project 시작] 2017. 6. 29. 최범주 ChangeAddParamObject
		StringBuffer sbQuery = new StringBuffer();
		sbQuery.append("\nSELECT TM_NM, JOB_NAME, SUB_JOB_NAME, SEL, UPJANG, UPJANGNM, GOAL_YEAR,						");
		sbQuery.append("\n       SUM(GOAL1) AS GOAL1, SUM(GOAL2) AS GOAL2, SUM(GOAL3) AS GOAL3,							");
		sbQuery.append("\n       SUM(GOAL4) AS GOAL4, SUM(GOAL5) AS GOAL5, SUM(GOAL6) AS GOAL6,							");
		sbQuery.append("\n       SUM(GOAL7) AS GOAL7, SUM(GOAL8) AS GOAL8, SUM(GOAL9) AS GOAL9,							");
		sbQuery.append("\n       SUM(GOAL10) AS GOAL10, SUM(GOAL11) AS GOAL11, SUM(GOAL12) AS GOAL12					");
		sbQuery.append("\n  FROM (																						");
		sbQuery.append("\n        SELECT T1.TM_NM, T1.JOB_NAME, T1.SUB_JOB_NAME, T1.SEL, T1.UPJANG, T1.UPJANGNM,		");
		sbQuery.append("\n               SUBSTR(T2.GOAL_MM,0,4) AS GOAL_YEAR,											");
		sbQuery.append("\n               DECODE(SUBSTR(T2.GOAL_MM, 5, 2), '01', T2.GOAL_RATE, 0.0) AS GOAL1,			");
		sbQuery.append("\n               DECODE(SUBSTR(T2.GOAL_MM, 5, 2), '02', T2.GOAL_RATE, 0.0) AS GOAL2,			");
		sbQuery.append("\n               DECODE(SUBSTR(T2.GOAL_MM, 5, 2), '03', T2.GOAL_RATE, 0.0) AS GOAL3,			");
		sbQuery.append("\n               DECODE(SUBSTR(T2.GOAL_MM, 5, 2), '04', T2.GOAL_RATE, 0.0) AS GOAL4,			");
		sbQuery.append("\n               DECODE(SUBSTR(T2.GOAL_MM, 5, 2), '05', T2.GOAL_RATE, 0.0) AS GOAL5,			");
		sbQuery.append("\n               DECODE(SUBSTR(T2.GOAL_MM, 5, 2), '06', T2.GOAL_RATE, 0.0) AS GOAL6,			");
		sbQuery.append("\n               DECODE(SUBSTR(T2.GOAL_MM, 5, 2), '07', T2.GOAL_RATE, 0.0) AS GOAL7,			");
		sbQuery.append("\n               DECODE(SUBSTR(T2.GOAL_MM, 5, 2), '08', T2.GOAL_RATE, 0.0) AS GOAL8,			");
		sbQuery.append("\n               DECODE(SUBSTR(T2.GOAL_MM, 5, 2), '09', T2.GOAL_RATE, 0.0) AS GOAL9,			");
		sbQuery.append("\n               DECODE(SUBSTR(T2.GOAL_MM, 5, 2), '10', T2.GOAL_RATE, 0.0) AS GOAL10,			");
		sbQuery.append("\n               DECODE(SUBSTR(T2.GOAL_MM, 5, 2), '11', T2.GOAL_RATE, 0.0) AS GOAL11,			");
		sbQuery.append("\n               DECODE(SUBSTR(T2.GOAL_MM, 5, 2), '12', T2.GOAL_RATE, 0.0) AS GOAL12			");
		sbQuery.append("\n          FROM (SELECT A.TM_NM, B.JOB_NAME, C.SUB_JOB_NAME, '0' AS SEL, A.UPJANG, A.UPJANGNM	");
		sbQuery.append("\n                  FROM SCO_UPJANG_MST_V A,													");
		sbQuery.append("\n                       (SELECT JOB_CD, JOB_NAME FROM MAS_JOB) B,								");
		sbQuery.append("\n                       (SELECT JOB_CD, SUB_JOB_CD, SUB_JOB_NAME FROM MAS_JOB_SUB) C			");
		sbQuery.append("\n                 WHERE 1 = 1																	");
		if( AppDataUtility.isNotNull(sMuCd) ) {
			sbQuery.append("\n                   AND A.MU_CD = #MU_CD_1# --검색조건(사업부)					         	");
		}
		if( AppDataUtility.isNotNull(sTmCd) ) {
			sbQuery.append("\n                   AND A.TM_CD = #TM_CD_1# --검색조건(운영부서(팀))						");
		}
		if( !sJobCd.equals("000") ) {
			sbQuery.append("\n                   AND A.JOB_CD = #JOB_CD_1# --검색조건(직군)							    ");
		}
		if( !sSubJobCd.equals("000000") ) {
			sbQuery.append("\n                   AND A.SUB_JOB_CD = #SUB_JOB_CD_1# --검색조건(상세직군)		     		");
		}
		if( AppDataUtility.isNotNull(sUpjang) ) {
			sbQuery.append("\n                   AND A.UPJANG = #UPJANG_1# --검색조건(업장)			                    ");
		}
		if(sOnly.equals("Y")) {
			sbQuery.append("\n                   AND NVL(A.CLOSE_DATE,'99999999') >= #YEAR_1# --폐점업장 제외		    ");
		}
		sbQuery.append("\n                   AND A.JOB_CD = B.JOB_CD													");
		sbQuery.append("\n                   AND A.JOB_CD = C.JOB_CD													");
		sbQuery.append("\n                   AND A.SUB_JOB_CD = C.SUB_JOB_CD) T1, FSA_STOCK_GOAL_SET T2					");
		sbQuery.append("\n         WHERE T1.UPJANG = T2.UPJANG(+)														");
		sbQuery.append("\n           AND T2.GOAL_MM LIKE #GOAL_MM# --필수검색조건(연도)						            ");
		sbQuery.append("\n         UNION																				");
		sbQuery.append("\n        SELECT T1.TM_NM, T1.JOB_NAME, T1.SUB_JOB_NAME, T1.SEL, T1.UPJANG, T1.UPJANGNM,		");
		sbQuery.append("\n               #YEAR_2# AS GOAL_YEAR,												   	        ");
		sbQuery.append("\n               0.0 AS GOAL1, 0.0 AS GOAL2, 0.0 AS GOAL3, 0.0 AS GOAL4,						");
		sbQuery.append("\n               0.0 AS GOAL5, 0.0 AS GOAL6, 0.0 AS GOAL7, 0.0 AS GOAL8,						");
		sbQuery.append("\n               0.0 AS GOAL9, 0.0 AS GOAL10, 0.0 AS GOAL11, 0.0 AS GOAL12						");
		sbQuery.append("\n          FROM (SELECT A.TM_NM, B.JOB_NAME, C.SUB_JOB_NAME, '0' AS SEL, A.UPJANG, A.UPJANGNM	");
		sbQuery.append("\n                  FROM SCO_UPJANG_MST_V A,													");
		sbQuery.append("\n                       (SELECT JOB_CD, JOB_NAME FROM MAS_JOB) B,								");
		sbQuery.append("\n                       (SELECT JOB_CD, SUB_JOB_CD, SUB_JOB_NAME FROM MAS_JOB_SUB) C			");
		sbQuery.append("\n                 WHERE 1 = 1																	");
		if( AppDataUtility.isNotNull(sMuCd) ) {
			sbQuery.append("\n                   AND A.MU_CD = #MU_CD_2# --검색조건(사업부)						        ");
		}
		if( AppDataUtility.isNotNull(sTmCd) ) {
			sbQuery.append("\n                   AND A.TM_CD = #TM_CD_2# --검색조건(운영부서(팀))						");
		}
		if( !sJobCd.equals("000") ) {
			sbQuery.append("\n                   AND A.JOB_CD = #JOB_CD_2# --검색조건(직군)							    ");
		}
		if( !sSubJobCd.equals("000000") ) {
			sbQuery.append("\n                   AND A.SUB_JOB_CD = #SUB_JOB_CD_2# --검색조건(상세직군)				    ");
		}
		if( AppDataUtility.isNotNull(sUpjang) ) {
			sbQuery.append("\n                   AND A.UPJANG = #UPJANG_2# --검색조건(업장)			                    ");
		}
		if(sOnly.equals("Y")) {
			sbQuery.append("\n                   AND NVL(A.CLOSE_DATE,'99999999') >= #YEAR_3# --폐점업장 제외		    ");
		}
		sbQuery.append("\n                   AND A.JOB_CD = B.JOB_CD													");
		sbQuery.append("\n                   AND A.JOB_CD = C.JOB_CD													");
		sbQuery.append("\n                   AND A.SUB_JOB_CD = C.SUB_JOB_CD) T1, FSA_STOCK_GOAL_SET T2					");
		sbQuery.append("\n         WHERE T1.UPJANG = T2.UPJANG(+))														");
		sbQuery.append("\n GROUP BY TM_NM, JOB_NAME, SUB_JOB_NAME, SEL, UPJANG, UPJANGNM, GOAL_YEAR						");
		sbQuery.append("\n ORDER BY TM_NM, JOB_NAME, SUB_JOB_NAME, UPJANGNM												");
		
		// SQL 요청자 정보 생성 
		SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		if( AppDataUtility.isNotNull(sMuCd) ) {
			sqlRequest.addParamObject("MU_CD_1", sMuCd);                       // 검색조건(사업부)
		}                                                                      
		if( AppDataUtility.isNotNull(sTmCd) ) {                                
			sqlRequest.addParamObject("TM_CD_1", sTmCd);                       // 검색조건(운영부서(팀))
		}                                                                      
		if( !sJobCd.equals("000") ) {                                          
			sqlRequest.addParamObject("JOB_CD_1", sJobCd);                     // 검색조건(직군)
		}                                                                      
		if( !sSubJobCd.equals("000000") ) {                                    
			sqlRequest.addParamObject("SUB_JOB_CD_1", sSubJobCd);              // 검색조건(상세직군)
		}
		if( AppDataUtility.isNotNull(sUpjang) ) {
			sqlRequest.addParamObject("UPJANG_1", Integer.parseInt(sUpjang));  // 검색조건(업장)
		}
		if(sOnly.equals("Y")) {
			sqlRequest.addParamObject("YEAR_1", sYear);
		}
		sqlRequest.addParamObject("GOAL_MM", sYear + "%");                     // 필수검색조건(연도)
		sqlRequest.addParamObject("YEAR_2", sYear);                            
		if( AppDataUtility.isNotNull(sMuCd) ) {                                
			sqlRequest.addParamObject("MU_CD_2", sMuCd);                       // 검색조건(사업부)
		}                                                                      
		if( AppDataUtility.isNotNull(sTmCd) ) {                                
			sqlRequest.addParamObject("TM_CD_2", sTmCd);                       // 검색조건(운영부서(팀))
		}                                                                      
		if( !sJobCd.equals("000") ) {                                          
			sqlRequest.addParamObject("JOB_CD_2", sJobCd);                     // 검색조건(직군)
		}                                                                      
		if( !sSubJobCd.equals("000000") ) {                                    
			sqlRequest.addParamObject("SUB_JOB_CD_2", sSubJobCd);              // 검색조건(상세직군)
		}
		if( AppDataUtility.isNotNull(sUpjang) ) {
			sqlRequest.addParamObject("UPJANG_2", Integer.parseInt(sUpjang));  // 검색조건(업장)
		}
		if(sOnly.equals("Y")) {
			sqlRequest.addParamObject("YEAR_3", sYear);
		}
// [속도개선 Project   끝] 2017. 6. 29. 최범주		

		// DB 처리 객체 생성하기
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		
	    // Execute Result DataSet
	    DataSet dsResult = (DataSet)executor.query(sqlRequest).getResultObject();
	    
	    // Result DataSet Return
		ctx.addOutput("ds_List", dsResult);
	}
	
	/**
	 * 월말목표재고비율 선택일괄적용
	 * @param ctx
	 * @throws Exception
	 */
	public void updateGoalRate(BusinessContext ctx) throws Exception {
		
		// InputDataSet 가져오기
		DataSet dsInput = (DataSet) ctx.getInputObject ("ds_Input");
		DataSet dsList  = (DataSet) ctx.getInputObject ("ds_List" );
		String  sEmpNo  = ctx.getInputString("g_EmpNo");
		
		// 검색조건 DataSet 검증
		if( dsInput.getRowCount() != 1 ) {
			throw new BusinessRuntimeException("올바르지 않은 검색 정보입니다.\n관리자에게 문의하여 주십시요.");
		}
		if( dsList.getRowCount() == 0 ) {
			throw new BusinessRuntimeException("올바르지 않은 검색 정보입니다.\n관리자에게 문의하여 주십시요.");
		}
		
		// 변수 설정
		double dGoalRate   = dsInput.getDouble(0, "GOAL_RATE"   );
		int    iStartMonth = dsInput.getInt(0, "START_MONTH");
		int    iUpjang     = 0;
		String sGoalMm     = "";
		String sYear       = "";
		
		// DB 처리 객체 생성하기  
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
	    
	    // SQL 요청자 정보 생성 
	    SqlRequest sqlRequest = null;
	    
	    // Query StringBuffer
	    StringBuffer sbQuery = new StringBuffer();
	    
	    // Temp Result DataSet
	    DataSet dsTemp = null;
	    
	    // Query Setting
	    for( int i = 0; i < dsList.getRowCount(); i++ ) {
	    	sYear   = dsList.getString (i, "GOAL_YEAR");
	    	iUpjang = dsList.getInt(i, "UPJANG"   );
	    	for( int j = iStartMonth; j <= 12; j++ ) {
	    		sbQuery.setLength(0);
	    		sbQuery.append("\nSELECT UPJANG							");
	    		sbQuery.append("\n  FROM FSA_STOCK_GOAL_SET				");
	    		sbQuery.append("\n WHERE UPJANG = " + iUpjang			 );
	    		if( Integer.toString(j).length() == 1 ) {
	    			sGoalMm = sYear + "0" + Integer.toString(j);
	    		} else {
	    			sGoalMm = sYear + Integer.toString(j);
	    		}
	    		sbQuery.append("\n   AND GOAL_MM = '" + sGoalMm + "'	");
	    		
	    		// SQL 요청자 정보 생성 
	    	    sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
	    	    
	    	    // Execute Result DataSet
	    	    dsTemp = (DataSet)executor.query(sqlRequest).getResultObject();
	    	    
	    	    if( dsTemp.getRowCount() == 0 ) {
	    	    	// Insert
	    	    	sbQuery.setLength(0);
	    	    	sbQuery.append("\nINSERT INTO FSA_STOCK_GOAL_SET															");
	    	    	sbQuery.append("\n       (UPJANG, GOAL_MM, GOAL_RATE, CUSER, CDATE)											");
	    	    	sbQuery.append("\n VALUES(" + iUpjang + ", '" + sGoalMm + "', " + dGoalRate + ", '" + sEmpNo + "', SYSDATE)	");
	    	    } else {
	    	    	sbQuery.setLength(0);
	    	    	sbQuery.append("\nUPDATE FSA_STOCK_GOAL_SET			");
	    	    	sbQuery.append("\n   SET GOAL_RATE = " + dGoalRate	 );
	    	    	sbQuery.append("\n     , UUSER = '" + sEmpNo + "'	");
	    	    	sbQuery.append("\n     , UDATE = SYSDATE			");
	    	    	sbQuery.append("\n WHERE UPJANG = " + iUpjang		 );
	    	    	sbQuery.append("\n   AND GOAL_MM = '" + sGoalMm + "'");
	    	    }
	    	    sqlRequest = SqlMapFactoryHelper.makeSqlRequestByInsertSql(sbQuery.toString());
	    	    
				// Transaction 처리
				if( executor.execute(sqlRequest) != 1 ) {
					throw new BusinessRuntimeException("목표재고비율 일괄적용 중 오류가 발생하였습니다.\n관리자에게 문의하여 주십시요.");
				}
	    	} // End for
	    } // End for
	}
	
	/**
	 * 월말목표재고비율 자동생성 전 존재여부 체크 
	 * @param ctx
	 * @throws Exception
	 */
	public void checkAutoSetting(BusinessContext ctx) throws Exception {
		
		// InputDataSet 가져오기
		DataSet dsInput = (DataSet) ctx.getInputObject ("ds_Input");
		
		// 검색조건 DataSet 검증
		if( dsInput.getRowCount() != 1 ) {
			throw new BusinessRuntimeException("올바르지 않은 검색 정보입니다.\n관리자에게 문의하여 주십시요.");
		}
		
		// 변수 설정
		String sYear = dsInput.getString(0, "YEAR");
		
		// DB 처리 객체 생성하기  
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
	    
	    // SQL 요청자 정보 생성 
	    SqlRequest sqlRequest = null;
	    
	    // Query StringBuffer
	    StringBuffer sbQuery = new StringBuffer();
	    
	    // Temp Result DataSet
	    DataSet dsResult = null;
	    
	    /********** 자료 검색 Start *****************************************************************/
	    // Query Setting
// [속도개선 Project 시작] 2017. 6. 29. 최범주 ChangeAddParamObject
	    sbQuery.setLength(0);
	    sbQuery.append("\nSELECT * 										");
	    sbQuery.append("\n  FROM FSA_STOCK_GOAL_SET						");
	    sbQuery.append("\n WHERE GOAL_MM LIKE #YEAR#	                ");
	    
	    sqlRequest    = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
	    sqlRequest.addParamObject("YEAR", sYear + "%");
// [속도개선 Project   끝] 2017. 6. 29. 최범주
	    
	    dsResult = (DataSet)executor.query(sqlRequest).getResultObject();
	    /********** 자료 검색 End *******************************************************************/
	    
	    // Result DataSet Return
		ctx.addOutput("ds_AutoCheck", dsResult);
	    
	} // End Method
	
	/**
	 * 월말목표재고비율 자동생성
	 * @param ctx
	 * @throws Exception
	 */
	public void updateAutoGoalRate(BusinessContext ctx) throws Exception {
		
		// InputDataSet 가져오기
		DataSet dsInput = (DataSet) ctx.getInputObject ("ds_Input");
		String  sEmpNo  = ctx.getInputString("g_EmpNo");
		
		// 검색조건 DataSet 검증
		if( dsInput.getRowCount() != 1 ) {
			throw new BusinessRuntimeException("올바르지 않은 검색 정보입니다.\n관리자에게 문의하여 주십시요.");
		}
		
		// 변수 설정
		double dGoalRate   = 0.0;
		int    iStartMonth = 1;
		int    iUpjang     = 0;
		String sGoalMm     = "";
		String sGoalYear   = dsInput.getString(0, "YEAR");
		int    iPreYear    = Integer.parseInt(sGoalYear) - 1;
		
		// DB 처리 객체 생성하기  
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
	    
	    // SQL 요청자 정보 생성 
	    SqlRequest sqlRequest = null;
	    
	    // Query StringBuffer
	    StringBuffer sbQuery = new StringBuffer();
	    
	    // Temp Result DataSet
	    DataSet dsPreGoalRate = null;
	    DataSet dsTemp        = null;
	    
	    /********** 과년도 12월 자료 검색 Start *******************************************************/
	    // Query Setting
// [속도개선 Project 시작] 2017. 6. 29. 최범주 ChangeAddParamObject
	    sbQuery.setLength(0);
	    sbQuery.append("\nSELECT * 									");
	    sbQuery.append("\n  FROM FSA_STOCK_GOAL_SET					");
	    sbQuery.append("\n WHERE GOAL_MM = #GOAL_MM#                ");
	    
	    sqlRequest    = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
	    sqlRequest.addParamObject("GOAL_MM", String.valueOf(iPreYear) + "12");
	    dsPreGoalRate = (DataSet)executor.query(sqlRequest).getResultObject();
	    /********** 과년도 12월 자료 검색 End *********************************************************/
	    
	    if( dsPreGoalRate.getRowCount() > 0 ) {
	    	for( int i=0; i<dsPreGoalRate.getRowCount(); i++ ) {
	    		iUpjang   = dsPreGoalRate.getInt(i, "UPJANG"   );
	    		dGoalRate = dsPreGoalRate.getDouble(i, "GOAL_RATE");
	    		
	    		for( int j = iStartMonth; j <= 12; j++ ) {
		    		sbQuery.setLength(0);
		    		sbQuery.append("\nSELECT UPJANG				     ");
		    		sbQuery.append("\n  FROM FSA_STOCK_GOAL_SET	     ");
		    		sbQuery.append("\n WHERE UPJANG = #UPJANG_1#     ");
		    		if( Integer.toString(j).length() == 1 ) {
		    			sGoalMm = sGoalYear + "0" + Integer.toString(j);
		    		} else {
		    			sGoalMm = sGoalYear + Integer.toString(j);
		    		}
		    		sbQuery.append("\n   AND GOAL_MM = #GOAL_MM_1#   ");
		    		
		    		// SQL 요청자 정보 생성 
		    	    sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		    	    sqlRequest.addParamObject("UPJANG_1", iUpjang);
		    	    sqlRequest.addParamObject("GOAL_MM_1", sGoalMm);
		    	    
		    	    // Execute Result DataSet
		    	    dsTemp = (DataSet)executor.query(sqlRequest).getResultObject();
		    	    
		    	    if( dsTemp.getRowCount() == 0 ) {
		    	    	// Insert
		    	    	sbQuery.setLength(0);
		    	    	sbQuery.append("\nINSERT INTO FSA_STOCK_GOAL_SET										");
		    	    	sbQuery.append("\n       (UPJANG, GOAL_MM, GOAL_RATE, CUSER, CDATE)						");
		    	    	sbQuery.append("\n VALUES(#UPJANG_2#, #GOAL_MM_2#, #GOAL_RATE_2#, #CUSER_2#, SYSDATE)	");
		    	    } else {
		    	    	sbQuery.setLength(0);
		    	    	sbQuery.append("\nUPDATE FSA_STOCK_GOAL_SET			");
		    	    	sbQuery.append("\n   SET GOAL_RATE = #GOAL_RATE_3#  ");
		    	    	sbQuery.append("\n     , UUSER     = #UUSER_3#	    ");
		    	    	sbQuery.append("\n     , UDATE     = SYSDATE		");
		    	    	sbQuery.append("\n WHERE UPJANG    = #UPJANG_3#     ");
		    	    	sbQuery.append("\n   AND GOAL_MM   = #GOAL_MM#      ");
		    	    }
		    	    sqlRequest = SqlMapFactoryHelper.makeSqlRequestByInsertSql(sbQuery.toString());
		    	    if( dsTemp.getRowCount() == 0 ) {
		    	    	sqlRequest.addParamObject("UPJANG_2", iUpjang);
		    	    	sqlRequest.addParamObject("GOAL_MM_2", sGoalMm);
		    	    	sqlRequest.addParamObject("GOAL_RATE_2", dGoalRate);
		    	    	sqlRequest.addParamObject("CUSER_2", sEmpNo);
		    	    } else {
		    	    	sqlRequest.addParamObject("GOAL_RATE_3", dGoalRate);
		    	    	sqlRequest.addParamObject("UUSER_3", sEmpNo);
		    	    	sqlRequest.addParamObject("UPJANG_3", iUpjang);
		    	    	sqlRequest.addParamObject("GOAL_MM", sGoalMm);
		    	    }
// [속도개선 Project   끝] 2017. 6. 29. 최범주
		    	    
					// Transaction 처리
					if( executor.execute(sqlRequest) != 1 ) {
						throw new BusinessRuntimeException("목표재고비율 자동생성 중 오류가 발생하였습니다.\n관리자에게 문의하여 주십시요.");
					}
		    	} // End for
	    	} // End for
	    } // End if
	} // End Method
}
