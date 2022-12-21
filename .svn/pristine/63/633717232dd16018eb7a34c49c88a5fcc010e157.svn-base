package com.ifis.fm.fmo;

import com.sz.service.sqlmap.SqlExecutor;
import com.sz.service.sqlmap.SqlMapFactoryHelper;
import com.sz.service.sqlmap.SqlRequest;
import com.sz.ui.AbstractAction;
import com.sz.ui.BusinessContext;
import com.sz.ui.xplatform.DataSetUtility;
import com.sz.util.AppDataUtility;
import com.tobesoft.xplatform.data.DataSet;
import com.tobesoft.xplatform.data.DataTypes;
/**
 * 사업장 수입금내역 조회 
 * 입금유형별, 고객사별, 일자별, 월별  조회 
 */
public class FMO00200V_ACT extends AbstractAction {
	
	private static final String USER_BUNBU = "본부";
	private static final String USER_BUNSA = "본사";
	private static final String USER_UPJANG = "사업장";
	/**
	 * 입금 유형별 조회 
	 * @param ctx
	 * @throws Exception
	 */
	public void searchByType(BusinessContext ctx) throws Exception {
		// 사용자 종류
		String userKind = ctx.getInputString("g_UserKind");
		// 조회 조건 DataSet
		DataSet dsCond = (DataSet) ctx.getInputObject("ds_cond");
		
		StringBuffer codeSql = new StringBuffer( "SELECT " )
			   .append( "        CODE, CODE_NAME AS TITLE, 'AMT_' || CODE AS DS_COL_NM " )
			   .append( "   FROM SCC_COMMON_CODE " )
			   .append( "  WHERE GROUP_CODE = '입금유형'")
			   .append( "  UNION ALL")
			   .append( " SELECT '003' CODE, '적요' TITLE,  'CONTENTS' DS_COL_NM")
			   .append( "   FROM DUAL");
		
		SqlRequest codeReq 
				= SqlMapFactoryHelper.makeSqlRequestBySelectSql(codeSql.toString());
		
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		DataSet codeDs = (DataSet) executor.query(codeReq).getResultObject();
		
		StringBuffer mainSql = new StringBuffer("SELECT ")
				.append("TO_CHAR(TO_DATE(RCV_DATE, 'YYYYMMDD'), 'YYYY-MM-DD') RCV_DATE ");
				
		// 컬럼 생성 
		for ( int i = 0; i < codeDs.getRowCount(); i++ ) {
			mainSql.append(", SUM(DECODE(RCV_TYPE, '" )
				.append( codeDs.getString(i, "CODE"))
				.append("' , RCV_AMT, 0 )) AMT_")
				.append( codeDs.getString(i, "CODE"));
		}
		mainSql.append(", SUM(RCV_AMT) AMT_SUM")
				.append(", CONTENTS ")
	   			.append(" FROM FMO_RCV ")
	   			.append(" WHERE RCV_DATE BETWEEN #FROM_DT# AND #TO_DT# ");	// 조회 일자 From ~ TO 
		
		if ( AppDataUtility.isNotNull(dsCond.getString(0, "UPJANG"))) {
			mainSql.append(" 	AND UPJANG = #UPJANG#");// 사업장 
		} else {
			if ( userKind.equals(USER_UPJANG)) {
				// 업장일 경우 
				mainSql.append("	AND UPJANG IN ( SELECT UPJANG FROM FMS_USER_UPJANG WHERE SABUN = #SABUN# )");
			} else if ( userKind.equals(USER_BUNSA)) {
				// 본사일 경우 
				mainSql.append("	AND UPJANG IN ( SELECT UPJANG FROM FMS_UPJANG WHERE USE_YN = 'Y' AND MAIN_UPJANG = #UPJANG#)" );
			}
		}
		
		mainSql.append(" AND USE_YN = 'Y'");
		mainSql.append(" GROUP BY RCV_DATE, CONTENTS");
		
		SqlRequest mainReq
			= SqlMapFactoryHelper.makeSqlRequestBySelectSql(mainSql.toString());
		
		mainReq.addParamObject("FROM_DT", dsCond.getString(0, "FROM_DT"));
		mainReq.addParamObject("TO_DT", dsCond.getString(0, "TO_DT"));
		
		if ( AppDataUtility.isNotNull(dsCond.getString(0, "UPJANG"))) {
			mainReq.addParamObject("UPJANG", DataSetUtility.getString(dsCond, 0, "UPJANG", ""));
		} else {
			if ( userKind.equals(USER_UPJANG)) {
				// 업장일 경우 
				mainReq.addParamObject("SABUN", ctx.getInputString("g_EmpNo"));
			} else if ( userKind.equals(USER_BUNSA)) {
				// 본사일 경우 
				mainReq.addParamObject("UPJANG", ctx.getInputString("g_Upjang"));
			}
		}
		
		DataSet mainDs = (DataSet) executor.query(mainReq).getResultObject();
		
		// Title 추가
		codeDs.newRow(0);
		codeDs.set(0,"TITLE", "총 입금액");
		codeDs.set(0,"DS_COL_NM", "AMT_SUM");
		
		codeDs.newRow(0);	// newRow(0);
		codeDs.set(0,"TITLE", "입금일");              
		codeDs.set(0,"DS_COL_NM", "RCV_DATE");
		
		// 출력 결과로 설정 
		ctx.addOutput("ds_title", codeDs);	// title 정보 가지고 있는 DataSet
		ctx.addOutput("ds_data", mainDs);	// 조회 결과 
	}
	
	/**
	 * 일자별 수입금 현황 조회 
	 * @param ctx
	 * @throws Exception
	 */
	public void searchByDaily(BusinessContext ctx) throws Exception {
		// 사용자 종류
		String userKind = ctx.getInputString("g_UserKind");
		
		DataSet dsCond = (DataSet) ctx.getInputObject("ds_cond");
		String month = dsCond.getString(0, "FROM_DT").substring(0,6);
		
		DataSet titleDs = new DataSet("ds_title");
		titleDs.addColumn("TITLE", DataTypes.STRING, 255);
		titleDs.addColumn("DS_COL_NM", DataTypes.STRING, 255);
		
		String currDate = AppDataUtility.getDateTimeString("yyyyMMdd");
		String lastDate = AppDataUtility.getLastDay(month);
		if ( Integer.parseInt(lastDate) > Integer.parseInt(currDate)) {
			// 현재 일자까지만 조회 
			lastDate = currDate;
		}
		
		StringBuffer query = new StringBuffer("SELECT ")
				.append(" SUM(RCV_AMT) AMT_SUM, ");
		
		int lastCnt = Integer.parseInt(lastDate.substring(6,8));
		int tRow = 0;
		// 컬럼 생성 
		for ( int i = 1; i <= lastCnt ; i++ ) {
			query.append(" SUM(DECODE(RCV_DAY, '").append(( i < 10 ? "0" : "") + i )
				.append("', RCV_AMT, 0 )) AMT_").append(i + ",");
			
			// 컬럼 타이틀 생성 
			tRow = titleDs.newRow();
			titleDs.set(tRow, "TITLE", i + "일");
			titleDs.set(tRow, "DS_COL_NM", "AMT_" + i );
		}
		query.append(" UPJANG, ")
			.append(" MAX(UPJANGNM_DISP) UPJANG_NM ")
			.append(" FROM ( ") 
			.append(" 	SELECT")
			.append(" 		M.RCV_AMT, ")
			.append(" 		M.RCV_DATE, M.CONTENTS, ")
			.append(" 		SUBSTR(M.RCV_DATE, 7,2) RCV_DAY, ")
			.append(" 		M.UPJANG, ")
			.append(" 		U.UPJANGNM_DISP ")
			.append(" 	FROM FMO_RCV M, FMS_UPJANG U ")
			.append(" 	WHERE M.RCV_DATE BETWEEN #FROM_DT# AND #TO_DT# ")
			.append(" 	AND M.UPJANG = U.UPJANG ");
		
		if ( AppDataUtility.isNotNull(dsCond.getString(0, "UPJANG"))) {
			query.append(" 	AND M.UPJANG = #UPJANG#");
		} else {
			if ( userKind.equals(USER_UPJANG)) {
				// 업장일 경우 
				query.append("	AND M.UPJANG IN ( SELECT UPJANG FROM FMS_USER_UPJANG WHERE SABUN = #SABUN# )");
			} else if ( userKind.equals(USER_BUNSA)) {
				// 본사일 경우 
				query.append("	AND M.UPJANG IN ( SELECT UPJANG FROM FMS_UPJANG WHERE USE_YN = 'Y' AND MAIN_UPJANG = #UPJANG#)" );
			}
		}
		
		query.append(" AND M.USE_YN = 'Y' )  GROUP BY UPJANG");
		
		SqlRequest mainReq
			= SqlMapFactoryHelper.makeSqlRequestBySelectSql(query.toString());
	
		mainReq.addParamObject("FROM_DT", month + "01");
		mainReq.addParamObject("TO_DT", lastDate);
		
		if ( AppDataUtility.isNotNull(dsCond.getString(0, "UPJANG"))) {
			mainReq.addParamObject("UPJANG", DataSetUtility.getString(dsCond, 0, "UPJANG", ""));
		} else {
			if ( userKind.equals(USER_UPJANG)) {
				// 업장일 경우 
				mainReq.addParamObject("SABUN", ctx.getInputString("g_EmpNo"));
			} else if ( userKind.equals(USER_BUNSA)) {
				// 본사일 경우 
				mainReq.addParamObject("UPJANG", ctx.getInputString("g_Upjang"));
			}
		}
		
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		DataSet mainDs = (DataSet) executor.query(mainReq).getResultObject();
		
		// Title 추가 
		titleDs.newRow(0);
		titleDs.set(0,"TITLE", "총 입금액");
		titleDs.set(0,"DS_COL_NM", "AMT_SUM");
		
		titleDs.newRow(0);
		titleDs.set(0,"TITLE", "사업장");
		titleDs.set(0,"DS_COL_NM", "UPJANG_NM");
		
		// 출력 결과로 설정 
		ctx.addOutput("ds_title", titleDs);	// title 정보 가지고 있는 DataSet
		ctx.addOutput("ds_data", mainDs);	// 조회 결과 
	}
	/**
	 * 월별  수입금 현황 조회 
	 * @param ctx
	 * @throws Exception
	 */
	public void searchByMonthly(BusinessContext ctx) throws Exception {
		// 사용자 종류
		String userKind = ctx.getInputString("g_UserKind");
		
		DataSet dsCond = (DataSet) ctx.getInputObject("ds_cond");
		String fromMonth = dsCond.getString(0, "FROM_DT").substring(0,6);
		String toMonth = dsCond.getString(0, "TO_DT").substring(0,6);
		
		DataSet titleDs = new DataSet("ds_title");
		titleDs.addColumn("TITLE", DataTypes.STRING, 255);
		titleDs.addColumn("DS_COL_NM", DataTypes.STRING, 255);
				
		StringBuffer query = new StringBuffer("SELECT ")
				.append(" SUM(RCV_AMT) AMT_SUM, ");
		
		int monthCnt = AppDataUtility.getAfterMonthCount(fromMonth, toMonth, "yyyyMM");
		String[] months = AppDataUtility.getAfterMonths(fromMonth, monthCnt, "yyyyMM", "yyyyMM");
		
		int tRow = 0;
		// 컬럼 생성 
		for ( int i = 0; i < monthCnt; i++ ) {
			query.append(" SUM(DECODE(RCV_DAY, '").append(months[i])
				.append("', RCV_AMT, 0 )) AMT_").append(i + ",");
			
			// 컬럼 타이틀 생성 
			tRow = titleDs.newRow();
			titleDs.set(tRow, "TITLE", months[i].substring(0, 4) + "-" + months[i].substring(4,6));
			titleDs.set(tRow, "DS_COL_NM", "AMT_" + i );
		}
		query.append(" UPJANG, ")
			.append(" MAX(UPJANGNM_DISP) UPJANG_NM ")
			.append(" FROM ( ") 
			.append(" 	SELECT")
			.append(" 		M.RCV_AMT, ")
			.append(" 		M.RCV_DATE, CONTENTS, ")
			.append(" 		SUBSTR(M.RCV_DATE, 1,6) RCV_DAY, ")	// 월로 
			.append(" 		M.UPJANG, ")
			.append(" 		U.UPJANGNM_DISP ")
			.append(" 	FROM FMO_RCV M, FMS_UPJANG U ")
			.append(" 	WHERE M.RCV_DATE BETWEEN #FROM_DT# AND #TO_DT# ")
			.append(" 	AND M.UPJANG = U.UPJANG ");
		
		if ( AppDataUtility.isNotNull(dsCond.getString(0, "UPJANG"))) {
			query.append(" 	AND M.UPJANG = #UPJANG#");
		} else {
			if ( userKind.equals(USER_UPJANG)) {
				// 업장일 경우 
				query.append("	AND M.UPJANG IN ( SELECT UPJANG FROM FMS_USER_UPJANG WHERE SABUN = #SABUN# )");
			} else if ( userKind.equals(USER_BUNSA)) {
				// 본사일 경우 
				query.append("	AND M.UPJANG IN ( SELECT UPJANG FROM FMS_UPJANG WHERE USE_YN = 'Y' AND MAIN_UPJANG = #UPJANG#)" );
			}
		}
		query.append(" AND M.USE_YN = 'Y' )  GROUP BY UPJANG");
		
		SqlRequest mainReq
			= SqlMapFactoryHelper.makeSqlRequestBySelectSql(query.toString());
	
		mainReq.addParamObject("FROM_DT", fromMonth + "01");
		//mainReq.addParamObject("TO_DT", toMonth + AppDataUtility.getLastDay(toMonth));
		mainReq.addParamObject("TO_DT", AppDataUtility.getLastDay(toMonth));
		
		if ( AppDataUtility.isNotNull(dsCond.getString(0, "UPJANG"))) {
			mainReq.addParamObject("UPJANG", DataSetUtility.getString(dsCond, 0, "UPJANG", ""));
		} else {
			if ( userKind.equals(USER_UPJANG)) {
				// 업장일 경우 
				mainReq.addParamObject("SABUN", ctx.getInputString("g_EmpNo"));
			} else if ( userKind.equals(USER_BUNSA)) {
				// 본사일 경우 
				mainReq.addParamObject("UPJANG", ctx.getInputString("g_Upjang"));
			}
		}
		
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		DataSet mainDs = (DataSet) executor.query(mainReq).getResultObject();
		
		// Title 추가 
		titleDs.newRow(0);
		titleDs.set(0,"TITLE", "총 입금액");
		titleDs.set(0,"DS_COL_NM", "AMT_SUM");
		
		titleDs.newRow(0);
		titleDs.set(0,"TITLE", "사업장");
		titleDs.set(0,"DS_COL_NM", "UPJANG_NM");
		
		// 출력 결과로 설정 
		ctx.addOutput("ds_title", titleDs);	// title 정보 가지고 있는 DataSet
		ctx.addOutput("ds_data", mainDs);	// 조회 결과 
	}	
	/**
	 * 고객사별 수입금 현황 조회 
	 * @param ctx
	 * @throws Exception
	 */
	public void searchByCust(BusinessContext ctx) throws Exception {
		// 사용자 종류
		String userKind = ctx.getInputString("g_UserKind");
		
		DataSet dsCond = (DataSet) ctx.getInputObject("ds_cond");
		String fromDate = dsCond.getString(0, "FROM_DT");
		String toDate = dsCond.getString(0, "TO_DT");
		
		int dayCnt = AppDataUtility.getAfterDayCount(fromDate, toDate, "yyyyMMdd");
		String[] days = AppDataUtility.getAfterDays(fromDate, dayCnt, "yyyyMMdd");
		
		DataSet titleDs = new DataSet("ds_title");
		titleDs.addColumn("TITLE", DataTypes.STRING, 255);
		titleDs.addColumn("DS_COL_NM", DataTypes.STRING, 255);
		
		
		StringBuffer query = new StringBuffer("SELECT ")
				.append(" SUM(RCV_AMT) AMT_SUM, ");
		
		int tRow = 0;
		// 컬럼 생성 
		for ( int i = 1; i <= days.length ; i++ ) {
			query.append(" SUM(DECODE(M.RCV_DATE, '")
				.append( days[i-1])
				.append("', RCV_AMT, 0)) AS AMT_").append( days[i-1] ).append(",");
			
			// 컬럼 타이틀 생성 
			tRow = titleDs.newRow();
			titleDs.set(tRow, "TITLE", days[i-1].substring(0,4) + "-" 
					+ days[i-1].substring(4,6) + "-" + days[i-1].substring(6,8));
			titleDs.set(tRow, "DS_COL_NM", "AMT_" + days[i-1] );
		}
		query.append(" MAX(C.CUSTNM) CUSTNM ")
			.append(" FROM FMO_RCV M, FMS_CUSTOM C ")
			.append(" WHERE M.RCV_DATE BETWEEN #FROM_DT# AND #TO_DT# ")
			.append(" AND M.CUST_ID = C.CUST_ID ");
		
		if ( AppDataUtility.isNotNull(dsCond.getString(0, "UPJANG"))) {
			query.append(" 	AND M.UPJANG = #UPJANG#");
		} else {
			if ( userKind.equals(USER_UPJANG)) {
				// 업장일 경우 
				query.append("	AND M.UPJANG IN ( SELECT UPJANG FROM FMS_USER_UPJANG WHERE SABUN = #SABUN# )");
			} else if ( userKind.equals(USER_BUNSA)) {
				// 본사일 경우 
				query.append("	AND M.UPJANG IN ( SELECT UPJANG FROM FMS_UPJANG WHERE USE_YN = 'Y' AND MAIN_UPJANG = #UPJANG#)" );
			}
		}
		query.append(" AND M.USE_YN = 'Y'");
		query.append("GROUP BY M.CUST_ID");
		
		SqlRequest mainReq
			= SqlMapFactoryHelper.makeSqlRequestBySelectSql(query.toString());
	
		mainReq.addParamObject("FROM_DT", fromDate);
		mainReq.addParamObject("TO_DT", toDate);
		
		if ( AppDataUtility.isNotNull(dsCond.getString(0, "UPJANG"))) {
			mainReq.addParamObject("UPJANG", DataSetUtility.getString(dsCond, 0, "UPJANG", ""));
		} else {
			if ( userKind.equals(USER_UPJANG)) {
				// 업장일 경우 
				mainReq.addParamObject("SABUN", ctx.getInputString("g_EmpNo"));
			} else if ( userKind.equals(USER_BUNSA)) {
				// 본사일 경우 
				mainReq.addParamObject("UPJANG", ctx.getInputString("g_Upjang"));
			}
		}
		
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		DataSet mainDs = (DataSet) executor.query(mainReq).getResultObject();
		
		// Title 추가 
		titleDs.newRow(0);	// insertRow(0);
		titleDs.set(0,"TITLE", "총 입금액");
		titleDs.set(0,"DS_COL_NM", "AMT_SUM");
		
		titleDs.newRow(0); // insertRow(0);
		titleDs.set(0,"TITLE", "고객");
		titleDs.set(0,"DS_COL_NM", "CUSTNM");
		
		// 출력 결과로 설정 
		ctx.addOutput("ds_title", titleDs);	// title 정보 가지고 있는 DataSet
		ctx.addOutput("ds_data", mainDs);	// 조회 결과 
	}
}
