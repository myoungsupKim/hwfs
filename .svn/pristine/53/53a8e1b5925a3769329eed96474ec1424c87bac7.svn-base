package com.ifis.fm.fmo;
import java.util.Calendar;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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
 * 사업장별 매출조회(일별,월별)
 * 
 * 변경이력
 * 2017.03.20	kihoon	[CH201703_00486] 매출조회쿼리수정(비용제외)
 */
public class FMO00100V_ACT extends AbstractAction {
	
// [속도개선 Project 시작] 2017. 6. 29. 최범주 ChangeAddParamObject
	private static final long serialVersionUID = 1420350912333907493L;
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
// [속도개선 Project   끝] 2017. 6. 29. 최범주
	
	private static final String USER_BUNBU = "본부";
	private static final String USER_BUNSA = "본사";
	private static final String USER_UPJANG = "사업장";
	
	/**
	 * 일자별 수입금 현황 조회 
	 * @param ctx
	 * @throws Exception
	 */
	public void searchByDaily(BusinessContext ctx) throws Exception {
		
		//달력 인스턴스 생성
		Calendar cal = Calendar.getInstance();
		
		// 사용자 종류
		String userKind = ctx.getInputString("g_UserKind");
		
		// input데이터 받기
		DataSet dsCond = (DataSet) ctx.getInputObject("ds_input");
		String month = dsCond.getString(0, "OCCUR_F_DATE").substring(0,6);
		
		int myYYYY = Integer.parseInt(dsCond.getString(0, "OCCUR_F_DATE").substring(0,4));
		int myMM = Integer.parseInt(dsCond.getString(0, "OCCUR_F_DATE").substring(4,6));
		int myDD = Integer.parseInt(dsCond.getString(0, "OCCUR_F_DATE").substring(6,8));
		
// [속도개선 Project 시작] 2017. 6. 29. 최범주 ChangeAddParamObject
		logger.debug("★★★★★★★★★★ " + myYYYY +"-"+ myMM +"-"+ myDD);
// [속도개선 Project   끝] 2017. 6. 29. 최범주		
		
		cal.set(myYYYY,myMM-1,myDD);
		
		// 타이틀 ds셋팅
		DataSet titleDs = new DataSet("ds_title");
		titleDs.addColumn("TITLE", DataTypes.STRING, 255 );
		titleDs.addColumn("DS_COL_NM", DataTypes.STRING, 255);
		
		String currDate = AppDataUtility.getDateTimeString("yyyyMMdd");
		//영업일의 마지막일로 가져오다보니 31일이 조회가 안됨
		//String lastDate = AppDataUtility.getLastDay(month);		
		String lastDate = month + cal.getActualMaximum(Calendar.DATE)+""; //문자로치환
		
		System.out.println(month);
		System.out.println(lastDate);
		
		if ( Integer.parseInt(lastDate) > Integer.parseInt(currDate)) {
			// 현재 일자까지만 조회 
			lastDate = currDate;
		}
		
		StringBuffer query = new StringBuffer("SELECT")
				.append("  SUM(OCCUR_AMT) AMT_SUM	 \n")
				.append("        , SUM(OCCUR_SUPAMT) SUPAMT_SUM	\n");
		
		int lastCnt = Integer.parseInt(lastDate.substring(6,8));
		int tRow = 0;
		// 컬럼 생성 
		for ( int i = 1; i <= lastCnt ; i++ ) {
			// 일에 따라 매출액과 순매출액 생성 (AMT_ : 매출액, SUPAMT_ : 순매출액)
			query.append("        , SUM(DECODE(RCV_DAY, '").append(( i < 10 ? "0" : "") + i )
				.append("', OCCUR_AMT, 0 )) AMT_").append(i + "	\n");
			query.append("        , SUM(DECODE(RCV_DAY, '").append(( i < 10 ? "0" : "") + i )
				.append("', OCCUR_SUPAMT, 0 )) SUPAMT_").append(i + "	\n");			
			// 컬럼 타이틀 생성 
			tRow = titleDs.newRow();
			titleDs.set(tRow, "TITLE", i + "일");
			titleDs.set(tRow, "DS_COL_NM", i );
		}
		query.append("        , UPJANG	\n")
			.append("        ,  MAX(UPJANGNM_DISP) UPJANG_NM	\n")
			.append("        FROM (	\n") 
			.append("                SELECT  ACC_OCC.OCCUR_AMT	\n")
			.append("                        , CASE WHEN ACC_OCC.TAX_CODE = '100' THEN ROUND(ACC_OCC.OCCUR_AMT/1.1) ELSE ACC_OCC.OCCUR_AMT END AS OCCUR_SUPAMT	\n")
			.append("                        , ACC_OCC.OCCUR_DATE	\n")
			.append("                        , SUBSTR(ACC_OCC.OCCUR_DATE, 7,2) RCV_DAY	\n")
			.append("                        , ACC_OCC.UPJANG	\n")
			.append("                        , UJ.UPJANGNM_DISP	\n")
			.append("                FROM    FMO_ACCT_OCCUR ACC_OCC	\n")
			.append("                        , FMS_UPJANG UJ	\n")
			.append("                WHERE   ACC_OCC.OCCUR_DATE BETWEEN #OCCUR_F_DATE# AND #OCCUR_T_DATE# \n")
			.append("                AND     ACC_OCC.UPJANG = UJ.UPJANG	\n")
			.append("                AND     UJ.USE_YN ='Y'	\n")
		    .append("                AND     UJ.MAIN_UPJANG = #MAIN_UPJANG#	 \n")
			.append("				 AND     ACC_OCC.SALE_TYPE IS NOT NULL  \n")
			.append("				 AND	 ACC_OCC.TAX_CODE IS NOT NULL \n");
			
		if ( userKind.equals(USER_UPJANG)) {
			// 업장일 경우 
			query.append("                AND     (ACC_OCC.UPJANG = #UPJANG# 	\n")
	                 .append("                          OR ACC_OCC.UPJANG IN ( SELECT UPJANG FROM FMS_USER_UPJANG WHERE USE_YN = 'Y' AND SABUN = #SABUN# ))");
		}
		
		query.append("            )	\n")
			.append("GROUP BY UPJANG	\n")
			.append("ORDER BY UPJANG	\n");
		
		SqlRequest mainReq
			= SqlMapFactoryHelper.makeSqlRequestBySelectSql(query.toString());
	
		mainReq.addParamObject("OCCUR_F_DATE", month + "01");
		mainReq.addParamObject("OCCUR_T_DATE", lastDate);
		
		mainReq.addParamObject("MAIN_UPJANG", DataSetUtility.getString(dsCond, 0, "MAIN_UPJANG", ""));

			
		if ( userKind.equals(USER_UPJANG)) {
				// 업장일 경우 
				mainReq.addParamObject("SABUN", ctx.getInputString("g_EmpNo"));
				mainReq.addParamObject("UPJANG", ctx.getInputString("g_Upjang"));
		}
		
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		DataSet mainDs = (DataSet) executor.query(mainReq).getResultObject();	
		
		// 출력 결과로 설정 
		ctx.addOutput("ds_title", titleDs);	// title 정보 가지고 있는 DataSet
		ctx.addOutput("ds_data", mainDs);	// 조회 결과 
	}
	
	/**
	 * 월별  수입금 현황 조회 
	 * @param ctx
	 * @throws Exception
	 */
	/**
	 * 월별  수입금 현황 조회 
	 * @param ctx
	 * @throws Exception
	 */
	public void searchByMonthly(BusinessContext ctx) throws Exception {
		
		// 사용자 종류
		String userKind = ctx.getInputString("g_UserKind");
		
		// input데이터 받기
		DataSet dsCond = (DataSet) ctx.getInputObject("ds_input");
		String fromMonth = dsCond.getString(0, "OCCUR_F_DATE").substring(0,6);
		String toMonth = dsCond.getString(0, "OCCUR_T_DATE").substring(0,6);
		
		DataSet titleDs = new DataSet("ds_title");
		titleDs.addColumn("TITLE", DataTypes.STRING, 255);
		titleDs.addColumn("DS_COL_NM", DataTypes.STRING, 255);
				
		StringBuffer query = new StringBuffer("SELECT")
		.append("  SUM(OCCUR_AMT) AMT_SUM	\n")
		.append("        , SUM(OCCUR_SUPAMT) SUPAMT_SUM	\n");
		
		int monthCnt = AppDataUtility.getAfterMonthCount(fromMonth, toMonth, "yyyyMM");
		String[] months = AppDataUtility.getAfterMonths(fromMonth, monthCnt, "yyyyMM", "yyyyMM");
		
		int tRow = 0;
		// 컬럼 생성 
		for ( int i = 0; i < monthCnt; i++ ) {
			// 일에 따라 매출액과 순매출액 생성 (AMT_ : 매출액, SUPAMT_ : 순매출액)
			query.append("        , SUM(DECODE(RCV_DAY, '").append(months[i])
				.append("', OCCUR_AMT, 0 )) AMT_").append(i + "	\n");
			query.append("        , SUM(DECODE(RCV_DAY, '").append(months[i] )
				.append("', OCCUR_SUPAMT, 0 )) SUPAMT_").append(i + "	\n");	
			
			// 컬럼 타이틀 생성 
			tRow = titleDs.newRow();
			titleDs.set(tRow, "TITLE", months[i].substring(4,6) + "월");
			titleDs.set(tRow, "DS_COL_NM", i );
		}
		query.append("        , UPJANG	\n")
		.append("        ,  MAX(UPJANGNM_DISP) UPJANG_NM	\n")
		.append("        FROM (	\n") 
		.append("                SELECT  ACC_OCC.OCCUR_AMT	\n")
		.append("                        , CASE WHEN ACC_OCC.TAX_CODE = '100' THEN ROUND(ACC_OCC.OCCUR_AMT/1.1) ELSE ACC_OCC.OCCUR_AMT END AS OCCUR_SUPAMT	\n")
		.append("                        , ACC_OCC.OCCUR_DATE	\n")
		.append("                        , SUBSTR(ACC_OCC.OCCUR_DATE, 1,6) RCV_DAY	\n")
		.append("                        , ACC_OCC.UPJANG	\n")
		.append("                        , UJ.UPJANGNM_DISP	\n")
		.append("                FROM    FMO_ACCT_OCCUR ACC_OCC	\n")
		.append("                        , FMS_UPJANG UJ	\n")
		.append("                WHERE   SUBSTR(ACC_OCC.OCCUR_DATE,0,6) BETWEEN SUBSTR(#OCCUR_F_DATE#,0,6) AND SUBSTR(#OCCUR_T_DATE#,0,6) \n")
		.append("                AND     ACC_OCC.UPJANG = UJ.UPJANG	\n")
		.append("                AND     UJ.USE_YN ='Y'	\n")
	    .append("                AND     UJ.MAIN_UPJANG = #MAIN_UPJANG# 	\n");
		
	if ( userKind.equals(USER_UPJANG)) {
		// 업장일 경우 
		query.append("                AND     (ACC_OCC.UPJANG = #UPJANG# 	\n")
		         .append("                          OR ACC_OCC.UPJANG IN ( SELECT UPJANG FROM FMS_USER_UPJANG WHERE USE_YN = 'Y' AND SABUN = #SABUN# ))");
	}
	
	query.append("            )	\n")
		.append("GROUP BY UPJANG	\n")
		.append("ORDER BY UPJANG	\n");

		
		SqlRequest mainReq
			= SqlMapFactoryHelper.makeSqlRequestBySelectSql(query.toString());
	
		mainReq.addParamObject("OCCUR_F_DATE", fromMonth);
		mainReq.addParamObject("OCCUR_T_DATE", toMonth);

		mainReq.addParamObject("MAIN_UPJANG", DataSetUtility.getString(dsCond, 0, "MAIN_UPJANG", ""));
			
		if ( userKind.equals(USER_UPJANG)) {
				// 업장일 경우 
				mainReq.addParamObject("SABUN", ctx.getInputString("g_EmpNo"));
				mainReq.addParamObject("UPJANG", ctx.getInputString("g_Upjang"));
		}
		
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		DataSet mainDs = (DataSet) executor.query(mainReq).getResultObject();
		
		// 출력 결과로 설정 
		ctx.addOutput("ds_title", titleDs);	// title 정보 가지고 있는 DataSet
		ctx.addOutput("ds_data", mainDs);	// 조회 결과 
	}
}
