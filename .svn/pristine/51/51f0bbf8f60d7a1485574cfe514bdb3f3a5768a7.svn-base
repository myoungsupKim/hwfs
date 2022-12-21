package com.ifis.fm.fmm;

import com.sz.service.sqlmap.SqlExecutor;
import com.sz.service.sqlmap.SqlMapFactoryHelper;
import com.sz.service.sqlmap.SqlRequest;
import com.sz.ui.AbstractAction;
import com.sz.ui.BusinessContext;
import com.sz.util.AppDataUtility;
import com.sz.business.BusinessRuntimeException;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 식재영업 공통 Action(손 창 덕)
 */
public class FMM_COMMON_ACT extends AbstractAction {
	
	/**
	 * 사업장 검색
	 * @param ctx
	 * @throws Exception
	 */
	public void searchUpjang(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		String sUserKind = ctx.getInputString("USER_KIND");
		int    iUpjang   = 0;
		String sEmpNo    = ctx.getInputString("EMP_NO"   );
		String sCode     = ctx.getInputString("CODE"     );
		String sCodeName = ctx.getInputString("CODE_NAME");
		String sOutputDS = ctx.getInputString("OUTPUT_DS");
		
		StringBuffer sbQuery = new StringBuffer();
		if( sUserKind.equals("본부") ) {
			sbQuery.append("\nSELECT UPJANG, UPJANGNM_DISP AS UPJANGNM				");
			sbQuery.append("\n  FROM FMS_UPJANG										");
			sbQuery.append("\n WHERE 1 = 1											");
			if( AppDataUtility.isNotNull(sCode) ) {
				sbQuery.append("\n   AND UPJANG LIKE '%" + sCode + "%'				");
			}
			if( AppDataUtility.isNotNull(sCodeName) ) {
				sbQuery.append("\n   AND UPJANGNM_DISP LIKE '%" + sCodeName + "%'	");
			}
			sbQuery.append("\n   AND USE_YN = 'Y'									");
			sbQuery.append("\n ORDER BY UPJANG										");
		} else if( sUserKind.equals("본사") ) {
			if( AppDataUtility.isNotNull(ctx.getInputString("UPJANG")) )
				iUpjang = Integer.parseInt(ctx.getInputString("UPJANG"));
			else
				throw new BusinessRuntimeException("g_Upjang 정보가 올바르지 않습니다.\n관리자에게 문의하여 주십시요.");
			
			sbQuery.append("\nSELECT UPJANG, UPJANGNM_DISP AS UPJANGNM				");
			sbQuery.append("\n  FROM FMS_UPJANG										");
			sbQuery.append("\n WHERE 1 = 1											");
			sbQuery.append("\n   AND MAIN_UPJANG = " + iUpjang                       ); 
			if( AppDataUtility.isNotNull(sCode) ) {
				sbQuery.append("\n   AND UPJANG LIKE '%" + sCode + "%'				");
			}
			if( AppDataUtility.isNotNull(sCodeName) ) {
				sbQuery.append("\n   AND UPJANGNM_DISP LIKE '%" + sCodeName + "%'	");
			}
			sbQuery.append("\n   AND USE_YN = 'Y'									");
			sbQuery.append("\n ORDER BY UPJANG										");
		} else if( sUserKind.equals("사업장") ) {
			sbQuery.append("\nSELECT A.UPJANG, B.UPJANGNM_DISP AS UPJANGNM		");
			sbQuery.append("\n  FROM FMS_USER_UPJANG A, FMS_UPJANG B			");
			sbQuery.append("\n WHERE A.SABUN = '" + sEmpNo + "'					");
			sbQuery.append("\n   AND A.USE_YN = 'Y'								");
			sbQuery.append("\n   AND A.UPJANG = B.UPJANG						");
			sbQuery.append("\n   AND B.UPJANG LIKE '%" + sCode + "%'			");
			sbQuery.append("\n   AND B.UPJANGNM_DISP LIKE '%" + sCodeName + "%'	");
			sbQuery.append("\n   AND B.USE_YN = 'Y'								");
			sbQuery.append("\n ORDER BY A.UPJANG								");
		} else {
			throw new BusinessRuntimeException("g_UserKind 정보가 올바르지 않습니다.\n관리자에게 문의하여 주십시요.");
		}
		
		// SQL 요청자 정보 생성 
		// SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());
		
		// DB 처리 객체 생성하기
		// DatasetSqlExecutor executor = new DatasetSqlExecutor(getConnection());
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
	    
	    // Execute Result DataSet
	    DataSet dsResult = (DataSet)executor.query(sqlRequest).getResultObject();
	    
	    // Result DataSet Return
		ctx.addOutput(sOutputDS, dsResult);
	}
	
	/**
	 * 사업장의 식당(창고)리스트 검색(콤보박스)
	 * @param ctx
	 * @throws Exception
	 */
	public void searchSubinv(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		String sUpjang   = ctx.getInputString("UPJANG"   );
		int    iUpjang   = 0;
		String sOutputDS = ctx.getInputString("OUTPUT_DS");
		
		if( AppDataUtility.isNull(sUpjang) ) {
			throw new BusinessRuntimeException("UPJANG 정보가 올바르지 않습니다.\n관리자에게 문의하여 주십시요.");
		} else {
			iUpjang = Integer.parseInt(sUpjang);
		}
		
		StringBuffer sbQuery = new StringBuffer();
		sbQuery.append("\nSELECT SUBINV_CODE, SUBINV_NAME_DISP AS SUBINV_NAME	");
		sbQuery.append("\n  FROM FMS_SUBINVENTORY								");
		sbQuery.append("\n WHERE UPJANG = " + iUpjang							 );
		sbQuery.append("\n ORDER BY SUBINV_CODE									");
		
		// SQL 요청자 정보 생성 
		SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());

		// DB 처리 객체 생성하기
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		
	    // Execute Result DataSet
	    DataSet dsResult = (DataSet)executor.query(sqlRequest).getResultObject();

	    // Result DataSet Return
		ctx.addOutput(sOutputDS, dsResult);
	}
	
	/**
	 * 업장, 식당(창고)코드를 이용한 끼니 검색(콤보박스)
	 * @param ctx
	 * @throws Exception
	 */
	public void searchSubinvMeal(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		String sUpjang     = ctx.getInputString("UPJANG"     );
		int    iUpjang     = 0;
		String sSubinvCode = ctx.getInputString("SUBINV_CODE");
		String sOutputDS   = ctx.getInputString("OUTPUT_DS"  );
		String sAllGubun   = ctx.getInputString("ALL_GUBUN"  );
		
		if( AppDataUtility.isNull(sUpjang) ) {
			throw new BusinessRuntimeException("사업장(UPJANG) 정보가 올바르지 않습니다.\n관리자에게 문의하여 주십시요.");
		} else {
			iUpjang = Integer.parseInt(sUpjang);
		}
		
		// Query Setting
		StringBuffer sbQuery = new StringBuffer();
		
		if( AppDataUtility.isNotNull(sAllGubun) ) {
			sbQuery.append("\nSELECT '000' AS MEAL_CODE, '" + sAllGubun + "' AS MEAL_NAME FROM DUAL				");
			sbQuery.append("\n UNION ALL																		");
		}
		sbQuery.append("\nSELECT DISTINCT A.MEAL AS MEAL_CODE, C.CODE_NAME AS MEAL_NAME							");
		sbQuery.append("\n  FROM FMM_MENU A,																	");
		sbQuery.append("\n       FMM_RECIPE B,																	");
		sbQuery.append("\n       (SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0023') C	");
		sbQuery.append("\n WHERE A.UPJANG = " + iUpjang															 );
		sbQuery.append("\n   AND A.SUBINV_CODE = '" + sSubinvCode + "'											");
		sbQuery.append("\n   AND A.UPJANG = B.UPJANG															");
		sbQuery.append("\n   AND A.MENU_CD = B.MENU_CD															");
		sbQuery.append("\n   AND A.MEAL = C.CODE(+)																");
		
		// SQL 요청자 정보 생성 
		SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());

		// DB 처리 객체 생성하기
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		
	    // Execute Result DataSet
	    DataSet dsResult = (DataSet)executor.query(sqlRequest).getResultObject();
	    
	    // Result DataSet Return
		ctx.addOutput(sOutputDS, dsResult);
	}
	
	/**
	 * 업장, 식당(창고)코드를 이용한 코너 검색(콤보박스)
	 * @param ctx
	 * @throws Exception
	 */
	public void searchSubinvCorner(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		String sUpjang     = ctx.getInputString("UPJANG"     );
		int    iUpjang     = 0;
		String sSubinvCode = ctx.getInputString("SUBINV_CODE");
		String sOutputDS   = ctx.getInputString("OUTPUT_DS"  );
		String sAllGubun   = ctx.getInputString("ALL_GUBUN"  );
		
		if( AppDataUtility.isNull(sUpjang) ) {
			throw new BusinessRuntimeException("사업장(UPJANG) 정보가 올바르지 않습니다.\n관리자에게 문의하여 주십시요.");
		} else {
			iUpjang = Integer.parseInt(sUpjang);
		}
		
		// Query Setting
		StringBuffer sbQuery = new StringBuffer();
		
		if( AppDataUtility.isNotNull(sAllGubun) ) {
			sbQuery.append("\nSELECT '000' AS CORNER_CODE, '" + sAllGubun + "' AS CORNER_NAME FROM DUAL			");
			sbQuery.append("\n UNION ALL																		");
		}
		
		sbQuery.append("\nSELECT DISTINCT A.CORNER AS CORNER_CODE, C.CODE_NAME AS CORNER_NAME					");
		sbQuery.append("\n  FROM FMM_MENU A,																	");
		sbQuery.append("\n       FMM_RECIPE B,																	");
		sbQuery.append("\n       (SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0022') C	");
		sbQuery.append("\n WHERE A.UPJANG = " + iUpjang															 );
		sbQuery.append("\n   AND A.SUBINV_CODE = '" + sSubinvCode + "'											");
		sbQuery.append("\n   AND A.UPJANG = B.UPJANG															");
		sbQuery.append("\n   AND A.MENU_CD = B.MENU_CD															");
		sbQuery.append("\n   AND A.CORNER = C.CODE(+)															");
		
		// SQL 요청자 정보 생성 
		SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());

		// DB 처리 객체 생성하기
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		
	    // Execute Result DataSet
	    DataSet dsResult = (DataSet)executor.query(sqlRequest).getResultObject();
	    
	    // Result DataSet Return
		ctx.addOutput(sOutputDS, dsResult);
	}
	
	/**
	 * 주의 월요일~일요일 검색
	 * @param ctx
	 * @throws Exception
	 */
	public void searchWeekStartEndDate(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		String sStanDate = ctx.getInputString("STAN_DATE");
		String sOutputDS = ctx.getInputString("OUTPUT_DS");
		
		// Query Setting
		StringBuffer sbQuery = new StringBuffer();
		
		// 기준 날짜가 없다면 현재의 주 월요일~일요일 검색
		if( AppDataUtility.isNull(sStanDate) || sStanDate.equals("") || sStanDate.length() == 0 ) {
			sbQuery.append("\nSELECT TO_CHAR(SYSDATE - TO_CHAR(SYSDATE - 1, 'd') + 1, 'YYYYMMDD') AS FROM_DATE,	");
			sbQuery.append("\n       TO_CHAR(SYSDATE - TO_CHAR(SYSDATE - 1, 'd') + 7, 'YYYYMMDD') AS TO_DATE	");
			sbQuery.append("\n  FROM DUAL																		");
		} else { // 기준 날짜가 포함되는 주 월요일~일요일 검색
			sbQuery.append("\nSELECT TO_CHAR(TO_DATE('" + sStanDate + "', 'YYYYMMDD') - TO_CHAR(TO_DATE('" + sStanDate + "', 'YYYYMMDD') - 1, 'd') + 1, 'YYYYMMDD') AS FROM_DATE,	");
			sbQuery.append("\n       TO_CHAR(TO_DATE('" + sStanDate + "', 'YYYYMMDD') - TO_CHAR(TO_DATE('" + sStanDate + "', 'YYYYMMDD') - 1, 'd') + 7, 'YYYYMMDD') AS TO_DATE		");
			sbQuery.append("\n  FROM DUAL																													");
		}
		
		// SQL 요청자 정보 생성 
		SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());

		// DB 처리 객체 생성하기
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		
	    // Execute Result DataSet
	    DataSet dsResult = (DataSet)executor.query(sqlRequest).getResultObject();
	    
	    // Result DataSet Return
		ctx.addOutput(sOutputDS, dsResult);
	}
	
	/**
	 * 공통코드 검색(콤보박스용)
	 * @param ctx
	 * @throws Exception
	 */
	public void searchCommonCode(BusinessContext ctx) throws Exception {
		
		// Arguments 가져오기
		String sGroupCode = ctx.getInputString("GROUP_CODE");
		String sOutputDS  = ctx.getInputString("OUTPUT_DS" );
		String sAllGubun  = ctx.getInputString("ALL_GUBUN" );
		
		// Query Setting
		StringBuffer sbQuery = new StringBuffer();
		
		if( sAllGubun.equals("Y") ) {
			sbQuery.append("\nSELECT '000' AS CODE, '- 전체 -' AS CODE_NAME	");
			sbQuery.append("\n  FROM DUAL									");
			sbQuery.append("\n UNION ALL									");
		}
		sbQuery.append("\nSELECT CODE, CODE_NAME 					");
		sbQuery.append("\n  FROM SCC_COMMON_CODE					");
		sbQuery.append("\n WHERE GROUP_CODE = '" + sGroupCode + "'	");
		
		// SQL 요청자 정보 생성 
		SqlRequest sqlRequest = SqlMapFactoryHelper.makeSqlRequestBySelectSql(sbQuery.toString());

		// DB 처리 객체 생성하기
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		
	    // Execute Result DataSet
	    DataSet dsResult = (DataSet)executor.query(sqlRequest).getResultObject();
	    
	    // Result DataSet Return
		ctx.addOutput(sOutputDS, dsResult);
	}
}
