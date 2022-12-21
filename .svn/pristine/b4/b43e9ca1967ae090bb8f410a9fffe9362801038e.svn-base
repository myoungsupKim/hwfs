package com.ifis.sc.scc;

import com.sz.service.sqlmap.SqlExecutor;
import com.sz.service.sqlmap.SqlMapFactoryHelper;
import com.sz.service.sqlmap.SqlMapInOutParam;
import com.sz.service.sqlmap.SqlMapRecord;
import com.sz.service.sqlmap.SqlRequest;
import com.sz.service.sqlmap.SqlResult;
import com.sz.ui.AbstractAction;
import com.sz.ui.BusinessContext;
import com.sz.ui.xplatform.DataSetUtility;
import com.sz.util.AppDataUtility;
import com.tobesoft.xplatform.data.DataSet;
/**
 * 팝업 코드 관리 Action 클래스 
 */
public class SCC00070E_ACT extends AbstractAction {

	/**
	 * 팝업 코드에 해당하는 상세 항목 조회 
	 * @param ctx
	 * @throws Exception
	 */
	public void search(BusinessContext ctx) throws Exception {
		DataSet dsCond = (DataSet)ctx.getInputObject("ds_cond");
		String sqlId = DataSetUtility.getString(dsCond, "SQL_ID");
		
		// DB에서 정보 조회 
		SqlRequest sqlRequest 
			= SqlMapFactoryHelper.makeXSqlRequest("sc/scc:SCC00070E_S002");
		sqlRequest.addParamObject("ds_cond", dsCond);
		
		SqlExecutor executor = 
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		SqlResult result = executor.query(sqlRequest);
		DataSet dsRtn = (DataSet)result.getResultObject();
		
		SqlMapRecord rec = SqlMapFactoryHelper.getSqlRecord(sqlId);
		if ( rec == null ) {
			// DB 정보만 그대로 전송 
			ctx.addOutput("ds_code", dsRtn);
			return;
		}
		
		SqlMapInOutParam[] inCols = rec.getInputColumns();
		SqlMapInOutParam[] outCols = rec.getOutputColumns();
		/*
		 * 	 POPUP_CODE AS POPUP_CODE
	, FIELD AS FIELD
	, HEADER_NAME AS HEADER_NAME
	, DECODE(USE_YN, 'Y', '1', '0') AS USE_YN
	, DECODE(DISPLAY_YN, 'Y', '1', '0') AS DISPLAY_YN
	, DISPLAY_SIZE AS DISPLAY_SIZE
	, DISPLAY_ALIGN AS DISPLAY_ALIGN
	, DISPLAY_ORDER AS DISPLAY_ORDER
	, COND_ORDER AS COND_ORDER
	, COND_TYPE AS COND_TYPE
	, DECODE(WHERE_YN, 'Y', '1', '0')  AS WHERE_YN
	, DECODE(COMBO_YN, 'Y', '1', '0') AS COMBO_YN
	, COMBO_ORDER AS COMBO_ORDER
	, CUSER AS CUSER
	, TO_CHAR(CDATE, 'YYYY-MM-DD HH24:MI') AS CDATE
	, UUSER AS UUSER
	, TO_CHAR(UDATE, 'YYYY-MM-DD HH24:MI') AS UDATE
                , 'Y' AS DB_YN
		 */
		
		// 입력 컬럼 부터 처리
		boolean isFound = false;
		for ( int i = 0; i < inCols.length; i++ ) {
			isFound = false;
			for( int r = 0; r < dsRtn.getRowCount(); r++ ) {
				if ( inCols[i].getName().equals(dsRtn.getString(r, "FIELD"))) {
					isFound = true;
					break;
				}
			}
			
			// 못 찾았다. 추가해야 함.  
			if ( !isFound ) {
				int row = dsRtn.newRow();
				dsRtn.set(row, "FIELD", inCols[i].getName());
				dsRtn.set(row, "HEADER_NAME"
									, AppDataUtility.isNull(inCols[i].getDescription())
									? inCols[i].getName() : inCols[i].getDescription());
				dsRtn.set(row, "USE_YN", "0");
				dsRtn.set(row, "DISPLAY_YN", "0");
				dsRtn.set(row, "WHERE_YN", "1");
				dsRtn.set(row, "DB_YN", "N");
			}
		}
		
		// 출력 컬럼 처리 
		for ( int i = 0; i < outCols.length; i++ ) {
			isFound = false;
			for( int r = 0; r < dsRtn.getRowCount(); r++ ) {
				if ( outCols[i].getName().equals(dsRtn.getString(r, "FIELD"))) {
					isFound = true;
					break;
				}
			}
			// 못 찾았다. 추가해야 함.  
			if ( !isFound ) {
				int row = dsRtn.newRow();
				dsRtn.set(row, "FIELD", outCols[i].getName());
				dsRtn.set(row, "HEADER_NAME"
						, AppDataUtility.isNull(outCols[i].getDescription())
						? outCols[i].getName() : outCols[i].getDescription());
				dsRtn.set(row, "USE_YN", "1");
				dsRtn.set(row, "DISPLAY_YN", "1");
				dsRtn.set(row, "DISPLAY_SIZE", outCols[i].getSize());
				dsRtn.set(row, "DISPLAY_ALIGN", "left");
				
				dsRtn.set(row, "WHERE_YN", "0");
				dsRtn.set(row, "DB_YN", "N");
			}
		}
		
		ctx.addOutput("ds_code", dsRtn);
	}
}