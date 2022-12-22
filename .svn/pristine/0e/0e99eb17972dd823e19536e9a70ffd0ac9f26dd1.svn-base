package com.ifis.sc.scc;


import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.hwfs.sc.cmn.util.namo.NamoMimeToHtml;
import com.sun.org.apache.xml.internal.security.utils.Base64;
import com.sz.business.BusinessRuntimeException;
import com.sz.core.ServiceManagerFactory;
import com.sz.service.sqlmap.DataSetSqlRequest;
import com.sz.service.sqlmap.SqlExecutor;
import com.sz.service.sqlmap.SqlMapFactoryHelper;
import com.sz.service.sqlmap.SqlRequest;
import com.sz.service.sqlmap.SqlResult;
import com.sz.service.ui.HttpFileManager;
import com.sz.ui.AbstractAction;
import com.sz.ui.BusinessContext;
import com.sz.ui.xplatform.DataSetUtility;
import com.tobesoft.xplatform.data.DataSet;
import com.tobesoft.xplatform.data.DataTypes;

/**
 * 게시판 관리 Action 클래스
 */
public class SCC80050E_ACT extends AbstractAction {
	private String C_FILE_SVC = "HttpFileManagerService";
	
	/**
	 * 상세 내용 조회
	 * @param ctx
	 * @throws Exception
	 */
	public void select(BusinessContext ctx) throws Exception {
		// 게시물 번호
		String conId = ctx.getInputString("CON_ID");
		String updateYn = ctx.getInputString("UPDATE_YN");	// 조회건수 증가 여부
		String empNo = ctx.getInputString("g_EmpNo");

		// DB에서 정보 조회
		SqlRequest sqlRequest
			= SqlMapFactoryHelper.makeXDataSetSqlRequest("sc/scc:SCC80050E_S001");
		sqlRequest.addParamObject("CON_ID", conId);
		SqlExecutor executor =
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		SqlResult result = executor.query(sqlRequest);
		DataSet ds_master = (DataSet)result.getResultObject();

		
		// Namo Web File 처리
		if ( ds_master.getRowCount() > 0 ) {
			String contents = NamoWebUtility.getContents(
					ds_master.getInt(0, "BBS_ID")+ ""
					, conId);

			// '<', '>' 역변환
			contents = contents.replaceAll("&amp;lt;", "<");
			contents = contents.replaceAll("&amp;gt;", ">");
			
			String uFlag = ds_master.getString(0, "U_FLAG");
			DateFormat sdFormat = new SimpleDateFormat("yyyyMMdd");
			Date nowDate = new Date();
			
			String uKey = ds_master.getString(0, "BBS_ID") 
						+ ds_master.getString(0, "CON_ID")
						+ ds_master.getString(0, "WRITE_SABUN")
						+ sdFormat.format(nowDate);
			
			String enKey = Base64.encode(uKey.getBytes());
			
			ds_master.set(0, "U_FLAG", enKey);
			ds_master.set(0, "N_CONT", contents);

			// UPDATE_YN 이 Y일 경우 상세 조회이다
			if ( updateYn != null && updateYn.equals("Y")) {
				SqlRequest updateSqlRequest
					= SqlMapFactoryHelper.makeXDataSetSqlRequest("sc/scc:SCC80050E_U003");
				updateSqlRequest.addParamObject("CON_ID", conId);
				executor.execute(updateSqlRequest);

				ds_master.set(0, "READ_CNT"
						, ds_master.getObject(0, "READ_CNT") != null ?
								ds_master.getInt(0, "READ_CNT") + 1 : 1);

				//조회 사용자 정보 처리
				SqlRequest updateReadUserSqlRequest = SqlMapFactoryHelper.makeXDataSetSqlRequest("sc/scc:SCC80050E_U006");
				updateReadUserSqlRequest.addParamObject("CON_ID", conId);
				updateReadUserSqlRequest.addParamObject("g_EmpNo", empNo);
				executor.execute(updateReadUserSqlRequest);

				// 의견 조회
				SqlRequest repSqlRequest
					= SqlMapFactoryHelper.makeXDataSetSqlRequest("sc/scc:SCC80061V_S001");
				repSqlRequest.addParamObject("CON_ID", conId);
				SqlResult result2 = executor.query(repSqlRequest);
				DataSet ds_repList = (DataSet)result2.getResultObject();
				ctx.addOutput("ds_repList", ds_repList);
			} else {
				// 게시대상 정보 조회
				if ( ds_master.getString(0, "READ_ALL_YN").equals("N")) {
					SqlRequest targetSqlRequest
						= SqlMapFactoryHelper.makeXDataSetSqlRequest("sc/scc:SCC80050E_S004");
					targetSqlRequest.addParamObject("CON_ID", conId);
					DataSet ds_target = (DataSet) executor.query(targetSqlRequest).getResultObject();
					ctx.addOutput("ds_target", ds_target);
				} else {
					DataSet ds_target = new DataSet("ds_target");
					ds_target.addColumn("TARGET_CODE", DataTypes.STRING, 255);
					ds_target.addColumn("TARGET_CLASS", DataTypes.STRING, 255);
					ds_target.addColumn("CODE_NAME", DataTypes.STRING, 255);
					ctx.addOutput("ds_target", ds_target);
				}
			}
		}

		ctx.addOutput("ds_master", ds_master);
	}

	
	/**
	 * 게시순서 가용 번호 조회
	 * @param ctx
	 * @throws Exception
	 */
	public void selectOrder(BusinessContext ctx) throws Exception {
		
		DataSet dsMast = (DataSet)ctx.getInputObject("ds_master");
		String strAttr06 = null;
			   strAttr06 = dsMast.getString(0, "ATTR06");
		SqlRequest orderSqlRequest = SqlMapFactoryHelper.makeXDataSetSqlRequest("sc/scc:SCC80050E_S005");
				   orderSqlRequest.addParamObject("ds_master", dsMast);
				   orderSqlRequest.addParamObject("ATTR06", strAttr06);
		SqlExecutor executor = SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);		   
		SqlResult result2 = executor.query(orderSqlRequest);
		DataSet ds_order = (DataSet)result2.getResultObject();
	
		ctx.addOutput("ds_order", ds_order);
	}
	
	/**
	 * 내용 저장
	 * @param ctx
	 * @throws Exception
	 */
	public void insert(BusinessContext ctx) throws Exception {
		DataSet ds_master = (DataSet)ctx.getInputObject("ds_master");
		DataSet ds_file = (DataSet)ctx.getInputObject("ds_file");	// 첨부 파일
		DataSet dsTarget = (DataSet)ctx.getInputObject("ds_target");	// 게시 대상

		SqlExecutor executor =
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);

		// 게시물 번호 조회
		SqlRequest sqlRequest
			= SqlMapFactoryHelper.makeXDataSetSqlRequest("sc/scc:SCC80050E_S002");
		SqlResult result = executor.query(sqlRequest);
		DataSet ds_key = (DataSet)result.getResultObject();

		// Namo 저장
		String conts = ds_master.getString(0, "N_CONT");
		NamoMimeToHtml mineToHtml = new NamoMimeToHtml();
		mineToHtml.decode(conts);
		String html = mineToHtml.getBodyContent();
		Boolean ckeckResult = NamoWebUtility.checkContents(html);
		
		if ( !ckeckResult ) {
			throw new BusinessRuntimeException("저장할 수 없는 내용을 포함하고 있습니다.");
		}
		
		String ismobile = ds_master.getString(0, "IS_MOBILE");
		boolean isMobile = false;

		if ("Y".equals(ismobile)) isMobile = true;
		else isMobile = false;

		String htmlUrl = NamoWebUtility.writeContents(
				ds_master.getInt(0, "BBS_ID") + ""
				, ds_key.getString(0, "MAX_SEQ")
				, conts, isMobile);

		// key 넘겨주기
		ds_master.set(0, "CON_ID", ds_key.getString(0, "MAX_SEQ"));
		ds_master.set(0, "HTML_URL", htmlUrl);

		if ( ds_master.getObject(0, "PARENT_CON_ID") == null
				|| ds_master.getInt(0, "PARENT_CON_ID") == 0) {
			ds_master.set(0, "PARENT_CON_ID", ds_key.getString(0, "MAX_SEQ"));
		} else {
			// 답변 모드 -> 이전 step update 처리
			SqlRequest updateSqlRequest
				= SqlMapFactoryHelper.makeXDataSetSqlRequest("sc/scc:SCC80050E_U002");
			updateSqlRequest.addParamObject("ds_master", ds_master);
			executor.execute(updateSqlRequest);
		}

		// 첨부파일 명 처리
		int cnt = 1;
		for ( int i = 0; i < ds_file.getRowCount(); i++) {
			if ( !DataSetUtility.getString(ds_file, i, "FLAG").equals("D") ) {
				ds_master.set(0, "APPEND" + cnt
							, DataSetUtility.getString(ds_file,i, "FILE_NM"));
				ds_master.set(0, "SAPPEND" + cnt
						, DataSetUtility.getString(ds_file,i, "S_FILE_NM"));
				// 사이즈 저장
				ds_master.set(0, "ATTR0" + cnt
						, DataSetUtility.getString(ds_file,i, "FILE_SIZE"));
				cnt++;
			}	// end if
		}
		// 자료지우기
		for ( int i = cnt; i <= 5; i++ ){
			ds_master.set(0, "APPEND" + i, "");
			ds_master.set(0, "SAPPEND" + i, "");
			ds_master.set(0, "ATTR0" + i, "");
		}
		// 전체 읽기 여부
		ds_master.set(0, "READ_ALL_YN", dsTarget.getRowCount() == 0 ? "Y" : "N");

		// master 등록 처리
		SqlRequest insertSql
			= SqlMapFactoryHelper.makeXDataSetSqlRequest("sc/scc:SCC80050E_I001");

		insertSql.addParamObject("ds_master", ds_master);
		insertSql.addParamObject("g_EmpNo", ctx.getInputString("g_EmpNo"));

		//executor.execute(insertSql);
		// INSERT COUNT CHECK
		if( executor.execute(insertSql) != 1 ) {
			throw new BusinessRuntimeException("정보 등록 중 오류가 발생하였습니다.");
		}
		
		// 게시물 Popup 처리
		if ( DataSetUtility.getString(ds_master, "POPUP_YN","N").equals("Y")) {
			SqlRequest popupInsertSql
				= SqlMapFactoryHelper.makeXDataSetSqlRequest("sc/scc:SCC80050E_I002");
			popupInsertSql.addParamObject("ds_master", ds_master);
			popupInsertSql.addParamObject("g_EmpNo", ctx.getInputString("g_EmpNo"));
			executor.execute(popupInsertSql);
			// 화면에 넘겨 줌.
			ds_master.set(0, "OLD_POPUP_YN", "Y");
		}

		// 게시 대상 등록
		DataSetSqlRequest targetSql
			= SqlMapFactoryHelper.makeXDataSetSqlRequest("sc/scc:SCC80050E_I003");
		targetSql.addParamObject("ds_master", ds_master);
		targetSql.addParamObject("ds_target", dsTarget);
		for ( int i = 0; i < dsTarget.getRowCount(); i++) {
			targetSql.setRowIndex(i);
			if ( i == 0 ) {
				executor.startBatch(targetSql);
			} else {
				executor.addBatch(targetSql);
			}
		}

		if ( dsTarget.getRowCount() > 0 ) {
			executor.executeBatch();
		}

		ctx.addOutput("ds_master", ds_master);
		ctx.addOutput("ds_target", dsTarget);
	}

	/**
	 * 내용 수정
	 * @param ctx
	 * @throws Exception
	 */
	public void update(BusinessContext ctx) throws Exception {
		DataSet ds_master = (DataSet)ctx.getInputObject("ds_master");
		DataSet ds_file = (DataSet)ctx.getInputObject("ds_file");	// 첨부 파일
		DataSet dsTarget = (DataSet)ctx.getInputObject("ds_target");	// 게시 대상
		/*
		String uFlag = ds_master.getString(0, "U_FLAG");
		DateFormat sdFormat = new SimpleDateFormat("yyyyMMdd");
		Date nowDate = new Date();
		
		String uKey = ds_master.getString(0, "BBS_ID") 
					+ ds_master.getString(0, "CON_ID")
					+ ds_master.getString(0, "WRITE_SABUN")
					+ sdFormat.format(nowDate);

		String enKey = Base64.encode(uKey.getBytes());
		System.out.println(uFlag+"||"+enKey);		
		if ( !uFlag.equals(enKey) ) {
			throw new BusinessRuntimeException("저장중에 오류가 발생하였습니다.\n관리자에게 문의하여 주십시요.");
		}
		*/
		SqlExecutor executor =
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);

		// Namo 저장
		String conts = ds_master.getString(0, "N_CONT");
		// '<', '>' 변환
		//conts.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
		//conts = conts.replaceAll("<", "&lt;");
		//conts = conts.replaceAll(">", "&gt;");
		conts = conts.replaceAll("<", "&amp;lt;");
		conts = conts.replaceAll(">", "&amp;gt;");
//System.out.println(conts);
		//
		String ismobile = ds_master.getString(0, "IS_MOBILE");
		boolean isMobile = false;

		if ("Y".equals(ismobile)) isMobile = true;
		else isMobile = false;

		String htmlUrl = NamoWebUtility.writeContents(
				ds_master.getInt(0, "BBS_ID") + ""
				, ds_master.getString(0, "CON_ID")
				, conts, isMobile);

		ds_master.set(0, "HTML_URL", htmlUrl);

		// 첨부파일 명 처리
		int cnt = 1;
		for ( int i = 0; i < ds_file.getRowCount(); i++) {
			if ( !DataSetUtility.getString(ds_file, i, "FLAG").equals("D") ) {
				ds_master.set(0, "APPEND" + cnt
							, DataSetUtility.getString(ds_file,i, "FILE_NM"));
				ds_master.set(0, "SAPPEND" + cnt
						, DataSetUtility.getString(ds_file,i, "S_FILE_NM"));
				// 사이즈 저장
				ds_master.set(0, "ATTR0" + cnt
						, DataSetUtility.getString(ds_file,i, "FILE_SIZE"));
				cnt++;
			}	// end if
		}
		// 자료지우기
		for ( int i = cnt; i <= 5; i++ ){
			ds_master.set(0, "APPEND" + i, "");
			ds_master.set(0, "SAPPEND" + i, "");
			ds_master.set(0, "ATTR0" + i, "");
		}

		// 전체 읽기 여부
		ds_master.set(0, "READ_ALL_YN", dsTarget.getRowCount() == 0 ? "Y" : "N");

		// master 수정 처리
		SqlRequest updateSql
			= SqlMapFactoryHelper.makeXDataSetSqlRequest("sc/scc:SCC80050E_U001");
		updateSql.addParamObject("ds_master", ds_master);
		updateSql.addParamObject("g_EmpNo", ctx.getInputString("g_EmpNo"));
		executor.execute(updateSql);

		// 게시물 Popup 처리
		String currPopupYn = DataSetUtility.getString(ds_master, "POPUP_YN","N");
		String oldPopupYn = DataSetUtility.getString(ds_master, "OLD_POPUP_YN","N");

		if ( currPopupYn.equals("Y")) {
			if ( oldPopupYn.equals("N")) {
				// 신규 등록
				SqlRequest popupInsertSql
					= SqlMapFactoryHelper.makeXDataSetSqlRequest("sc/scc:SCC80050E_I002");
				popupInsertSql.addParamObject("ds_master", ds_master);
				popupInsertSql.addParamObject("g_EmpNo", ctx.getInputString("g_EmpNo"));
				executor.execute(popupInsertSql);
			} else {
				SqlRequest popupUpdateSql
					= SqlMapFactoryHelper.makeXDataSetSqlRequest("sc/scc:SCC80050E_U005");
				popupUpdateSql.addParamObject("ds_master", ds_master);
				popupUpdateSql.addParamObject("g_EmpNo", ctx.getInputString("g_EmpNo"));
				executor.execute(popupUpdateSql);
			}
		} else if ( oldPopupYn.equals("Y")){
			// 삭제해야 함.
			// 삭제 - SCC_BBS_POPUP
			DataSetSqlRequest deleteSql2
				= SqlMapFactoryHelper.makeXDataSetSqlRequest("sc/scc:SCC80050E_D002");
			deleteSql2.addParamObject("ds_master", ds_master);
			executor.execute(deleteSql2);
			// 삭제 - SCC_BBS_POPUP_CONF
			DataSetSqlRequest deleteSql3
				= SqlMapFactoryHelper.makeXDataSetSqlRequest("sc/scc:SCC80050E_D003");
			deleteSql3.addParamObject("ds_master", ds_master);
			executor.execute(deleteSql3);
		}
		// 화면에 전송
		ds_master.set(0, "OLD_POPUP_YN", currPopupYn);

		// 게시 대상 삭제
		DataSetSqlRequest targetDeleteSql
			= SqlMapFactoryHelper.makeXDataSetSqlRequest("sc/scc:SCC80050E_D006");
		targetDeleteSql.addParamObject("ds_target", dsTarget);
		targetDeleteSql.addParamObject("CON_ID", ds_master.getString(0, "CON_ID"));
		for ( int i = 0; i < dsTarget.getRemovedRowCount(); i++) {
			targetDeleteSql.setDeleteRow(true);
			targetDeleteSql.setRowIndex(i);

			if ( i == 0 ) {
				executor.startBatch(targetDeleteSql);
			} else {
				executor.addBatch(targetDeleteSql);
			}
		}

		if ( dsTarget.getRemovedRowCount() > 0 ) {
			executor.executeBatch();
		}

		// 게시 대상 등록
		DataSetSqlRequest targetSql
			= SqlMapFactoryHelper.makeXDataSetSqlRequest("sc/scc:SCC80050E_I003");
		targetSql.addParamObject("ds_master", ds_master);
		targetSql.addParamObject("ds_target", dsTarget);
		targetSql.addParamObject("g_EmpNo", ctx.getInputString("g_EmpNo"));
		int count = 0;
		for ( int i = 0; i < dsTarget.getRowCount(); i++) {
		//	if ( dsTarget.getRowStatus(i).toUpperCase().equals("INSERT")) {
			if( dsTarget.getRowType(i) == DataSet.ROW_TYPE_INSERTED) {
				targetSql.setRowIndex(i);
				if ( count == 0 ) {
					executor.startBatch(targetSql);
				} else {
					executor.addBatch(targetSql);
				}
				count++;
			}
		}
		if ( count > 0 ) {
			executor.executeBatch();
		}

		ctx.addOutput("ds_master", ds_master);
		ctx.addOutput("ds_target", dsTarget);
	}

	/**
	 * 삭제 처리
	 * @param ctx
	 * @throws Exception
	 */
	public void delete(BusinessContext ctx) throws Exception {
		// 입력 데이터
		DataSet dsMaster = (DataSet)ctx.getInputObject("ds_master");

		// db
		SqlExecutor db =
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);

		// 조회
		DataSetSqlRequest selectReq
			= SqlMapFactoryHelper.makeXDataSetSqlRequest("sc/scc:SCC80050E_S003");
		selectReq.addParamObject("ds_master", dsMaster);

		// update 처리
		DataSetSqlRequest updateReq
			= SqlMapFactoryHelper.makeXDataSetSqlRequest("sc/scc:SCC80050E_U004");
		updateReq.addParamObject("ds_master", dsMaster);

		// namo 삭제
		NamoWebUtility.deleteContents(dsMaster.getString(0, "BBS_ID")
				, dsMaster.getString(0, "CON_ID"));
		// 첨부 파일 정보 삭제
		HttpFileManager file
			= (HttpFileManager) ServiceManagerFactory.getServiceObject(C_FILE_SVC);
		for ( int i = 1; i<=5; i++ ) {
			if ( !DataSetUtility.getString(dsMaster, "SAPPEND" + i, "" ).equals("")) {
				// 파일 삭제
				file.delete("SCC_BBS", dsMaster.getString(0, "SAPPEND" + i ));
			}
		}

		// 삭제 처리 - SCC_BBS_CON
		DataSetSqlRequest deleteSql
			= SqlMapFactoryHelper.makeXDataSetSqlRequest("sc/scc:SCC80050E_D001");
		deleteSql.addParamObject("ds_master", dsMaster);

		// 삭제 - SCC_BBS_POPUP
		DataSetSqlRequest deleteSql2
			= SqlMapFactoryHelper.makeXDataSetSqlRequest("sc/scc:SCC80050E_D002");
		deleteSql2.addParamObject("ds_master", dsMaster);

		// 삭제 - SCC_BBS_POPUP)CONF
		DataSetSqlRequest deleteSql3
			= SqlMapFactoryHelper.makeXDataSetSqlRequest("sc/scc:SCC80050E_D003");
		deleteSql3.addParamObject("ds_master", dsMaster);

		// 삭제 - SCC_BBS_CON_REP -> 댓글 정보
		DataSetSqlRequest deleteSql4
			= SqlMapFactoryHelper.makeXDataSetSqlRequest("sc/scc:SCC80050E_D004");
		deleteSql4.addParamObject("ds_master", dsMaster);

		// 삭제 - SCC_BBS_PRIV_LIST -> 게시 대상  정보
		DataSetSqlRequest deleteSql5
			= SqlMapFactoryHelper.makeXDataSetSqlRequest("sc/scc:SCC80050E_D005");
		deleteSql5.addParamObject("ds_master", dsMaster);

		for ( int i = 0; i < dsMaster.getRowCount(); i++) {
			// row 옮김.
			selectReq.setRowIndex(i);

			DataSet ds = (DataSet) db.query(selectReq).getResultObject();
			if ( ds.getRowCount() > 0 ) {
				// 이미 존재한다.
				throw new BusinessRuntimeException("하위 게시물이 있는 게시물은 삭제되지 않습니다.");
			}

			// 삭제 처리
			deleteSql.setRowIndex(i);
			db.execute(deleteSql);

			// POPUP 정보 삭제
			deleteSql2.setRowIndex(i);
			db.execute(deleteSql2);

			// POPUP 정보 삭제 - CONF
			deleteSql3.setRowIndex(i);
			db.execute(deleteSql3);

			//댓글 정보 삭제
			deleteSql4.setRowIndex(i);
			db.execute(deleteSql4);

			//게시 대상  정보 삭제
			deleteSql5.setRowIndex(i);
			db.execute(deleteSql5);

			// step update 처리
			if( dsMaster.getObject(i, "STEP") != null && dsMaster.getInt(i, "STEP") > 1 ) {
				updateReq.setRowIndex(i);
				// step 감소 시킴.
				db.execute(updateReq);
			}
		}
	}

	/**
	 * 게시물을 타 게시판으로 복사
	 * @param ctx
	 * @throws Exception
	 */
	public void copy(BusinessContext ctx) throws Exception {
		String conId = ctx.getInputString("CON_ID");
		String bbsId = ctx.getInputString("BBS_ID");
		SqlExecutor executor =
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);

		// DB에서 게시물 정보 조회
		SqlRequest sqlRequest
			= SqlMapFactoryHelper.makeDataSetSqlRequest("sc/scc:SCC80050E_S001");
		sqlRequest.addParamObject("CON_ID", conId);
		DataSet dsMaster = (DataSet) executor.query(sqlRequest).getResultObject();

		// 값 초기화
		dsMaster.set(0, "LEVELS", new Integer( 1 ));
		dsMaster.set(0, "STEP", new Integer( 1 ));
		dsMaster.set(0, "POPUP_YN", "N");
		dsMaster.set(0, "READ_ALL_YN", "Y");
		// dsMaster.set(0, "PASSWORD", "");

		// master 등록 처리
		SqlRequest insertSql
			= SqlMapFactoryHelper.makeXDataSetSqlRequest("sc/scc:SCC80050E_I001");
		insertSql.addParamObject("ds_master", dsMaster);
		insertSql.addParamObject("g_EmpNo", ctx.getInputString("g_EmpNo"));

		// 게시물 번호 조회
		SqlRequest keySql
			= SqlMapFactoryHelper.makeXDataSetSqlRequest("sc/scc:SCC80050E_S002");
		// key DataSet
		DataSet dsKey = null;

		HttpFileManager file
			= (HttpFileManager) ServiceManagerFactory.getServiceObject(C_FILE_SVC);
		DataSet dsList = (DataSet)ctx.getInputObject("ds_list");	// 복사할 게시판 목록
		for ( int i = 0; i < dsList.getRowCount(); i++) {
			// 첨부 파일 처리
			for ( int c = 1; c <= 5; c++) {
				if ( !DataSetUtility.getString(dsMaster, "SAPPEND" + c, "").equals("")) {
					// 파일 복사 시킴.
					file.copy("SCC_BBS", "SCC_BBS"
							, DataSetUtility.getString(dsMaster, "SAPPEND" + c)
							, "C_" + DataSetUtility.getString(dsMaster, "SAPPEND" + c)
							, false);

					// 파일명 변경 시킴.
					dsMaster.set(0, "SAPPEND" + c
							, "C_" + DataSetUtility.getString(dsMaster, "SAPPEND" + c));
				}
			}
			// key 조회
			dsKey = (DataSet) executor.query(keySql).getResultObject();

			String contents = NamoWebUtility.getContents(bbsId, conId);

			// namo 파일에 다시 씀.
			/*NamoWebUtility.writeContents( dsList.getString(i,"BBS_ID")
					, dsKey.getString(0, "MAX_SEQ"), contents);*/

			String ismobile = dsMaster.getString(0, "IS_MOBILE");
			boolean isMobile = false;

			if ("Y".equals(ismobile)) isMobile = true;
			else isMobile = false;

			String htmlUrl = NamoWebUtility.writeContents(
					dsList.getString(i,"BBS_ID") + ""
					, dsKey.getString(0, "MAX_SEQ")
					, contents, isMobile);

			// key 넘겨주기
			dsMaster.set(0, "CON_ID", dsKey.getString(0, "MAX_SEQ"));
			dsMaster.set(0, "HTML_URL", htmlUrl);
			dsMaster.set(0, "PARENT_CON_ID", dsKey.getString(0, "MAX_SEQ"));
			dsMaster.set(0, "BBS_ID", dsList.getInt(i,"BBS_ID"));	// 저장하는 BBS 수정

			// 등록 처리
			executor.execute(insertSql);
		}
	}

	/**
	 * 팝업 목록 조회
	 * @param ctx
	 * @throws Exception
	 */
	public void selectPopup(BusinessContext ctx) throws Exception {
		// DB에서 정보 조회
		SqlRequest sqlRequest
			= SqlMapFactoryHelper.makeXSqlRequest("sc/scc:SCC80080V_S001");
		sqlRequest.addParamObject("g_EmpNo", ctx.getInputString("g_EmpNo"));
		sqlRequest.addParamObject("TARGET_CODE", ctx.getInputString("TARGET_CODE"));

		SqlExecutor executor =
				SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		SqlResult result = executor.query(sqlRequest);
		DataSet ds_popupList = (DataSet)result.getResultObject();
		for( int i = 0; i < ds_popupList.getRowCount(); i++) {
			String contents = NamoWebUtility.getContents(
					ds_popupList.getString(i, "BBS_ID")
					, ds_popupList.getString(i, "CON_ID"));

			ds_popupList.set(i, "N_CONT", contents);
		}

		ctx.addOutput("ds_popupList", ds_popupList);
	}
}