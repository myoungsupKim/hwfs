package com.ifis.fs.fsm;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

import com.sz.core.ServiceManagerFactory;
import com.sz.service.sqlmap.SqlExecutor;
import com.sz.service.sqlmap.SqlMapFactoryHelper;
import com.sz.service.sqlmap.SqlRequest;
import com.sz.service.sqlmap.SqlResult;
import com.sz.ui.AbstractAction;
import com.sz.ui.BusinessContext;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 나모웹에디터 처리
 * 
 * @ClassName FSM00720E_ACT.java
 * @Description FSM00720E_ACT Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 24.   mskim        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 mskim
 * @since 2015. 3. 24.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class FSM00720E_ACT extends AbstractAction {
	
	private static final long serialVersionUID = -7600202090489361112L;

	/**
	 * 내용 조회
	 *
	 * @param ctx
	 * @throws Exception
	 */
	public void select(BusinessContext ctx) throws Exception {
		
		DataSet ds_cond = (DataSet)ctx.getInputObject("ds_cond");
		
		String bizType = ctx.getInputString("BIZ_TYPE");
		String key = ctx.getInputString("KEY");
		String dsName = ctx.getInputString("DS_NAME");
		String contentsField = ctx.getInputString("CONTENTS_FIELD");
		String sqlId = ctx.getInputString("SQL_ID");
		
		System.out.println("===================================================================");
		System.out.println("[ Select ]");
		System.out.println("bizType : " + bizType);
		System.out.println("key : " + key);
		System.out.println("dsName : " + dsName);
		System.out.println("contentsField : " + contentsField);
		System.out.println("sqlId : " + sqlId);
		System.out.println("===================================================================");
		
		// DB에서 정보 조회 
		SqlRequest sqlRequest = SqlMapFactoryHelper.makeXDataSetSqlRequest(sqlId);
		sqlRequest.addParamObject("ds_cond", ds_cond);
		SqlExecutor executor = SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);
		SqlResult result = executor.query(sqlRequest);
		DataSet ds_guid = (DataSet)result.getResultObject();
		
		// Namo Web File 처리
		if ( ds_guid.getRowCount() > 0 ) {
			String contents = getContents(bizType, key);

			// '<', '>' 역변환
			contents = contents.replaceAll("&amp;lt;", "<");
			contents = contents.replaceAll("&amp;gt;", ">");

			ds_guid.set(0, contentsField, contents);
		}	
		
		ctx.addOutput(dsName, ds_guid);
	}
	
	/**
	 * 내용 저장
	 *
	 * @param ctx
	 * @throws Exception
	 */
	public void insert(BusinessContext ctx) throws Exception {
		
		String bizType = ctx.getInputString("BIZ_TYPE");
		String key = ctx.getInputString("KEY");
		String dsName = ctx.getInputString("DS_NAME");
		String contentsField = ctx.getInputString("CONTENTS_FIELD");
		String sqlId = ctx.getInputString("SQL_ID");
		
		DataSet ds_guid = (DataSet)ctx.getInputObject(dsName);
		
		System.out.println("===================================================================");
		System.out.println("[ Insert ]");
		System.out.println("bizType : " + bizType);
		System.out.println("key : " + key);
		System.out.println("dsName : " + dsName);
		System.out.println("contentsField : " + contentsField);
		System.out.println("sqlId : " + sqlId);
		System.out.println("===================================================================");
		
		SqlExecutor executor = SqlMapFactoryHelper.makeSqlExecutor(getConnection(), SqlMapFactoryHelper.XDATASET);	
		
		// Namo 저장
		String conts = ds_guid.getString(0, contentsField);

		// '<', '>' 변환
		conts = conts.replaceAll("<", "&amp;lt;");
		conts = conts.replaceAll(">", "&amp;gt;");

		writeContents(bizType, key, conts);
		
		// master 등록 처리
		SqlRequest execSql = SqlMapFactoryHelper.makeXDataSetSqlRequest(sqlId);
		
		execSql.addParamObject("ds_guid", ds_guid);
		execSql.addParamObject("g_EmpNo", ctx.getInputString("g_EmpNo"));
		
		executor.execute(execSql);
		
		ctx.addOutput(dsName, ds_guid);
	}


	public String getContents(String bizType, String key) throws Exception {
		String str = "";
		File f = getFile(bizType, key);
		if ( f.exists() ) {
			FileReader fr = new FileReader(f);
			BufferedReader r = new BufferedReader(fr);
			
			StringBuffer buf = new StringBuffer();
			try {
				while( (str = r.readLine()) != null ) {
						buf.append(str);
						buf.append("\n");
					}
					r.close();
					fr.close();
					str = buf.toString();
			} catch( Exception e) {
				throw e;
			} finally {
				if ( r != null ) {
					r.close();
				}
				if ( fr != null ) {
					fr.close();
				}
			}
		}
		
		return str;
	}
	
	/**
	 * 내용 쓰기 
	 * @param bbsId
	 * @param conId
	 * @param conts
	 * @throws Exception
	 */
	public void writeContents(String bizType, String key, String conts) throws Exception {
		File f = getFile(bizType, key);
		
		FileWriter fw = null;
		try {
			fw = new FileWriter(f);
			fw.write(conts);
			fw.flush();
		} catch( IOException e) {
			throw e;
		} finally {
			if ( fw != null ) {
				fw.close();
			}
		}
	}
	
	private File getFile(String bizType, String key) throws Exception {
		String wk = ServiceManagerFactory.getProperty("WORK_DIR");
		File f = new File( wk + "/namo/" + bizType);
		if ( !f.exists() ) {
			f.mkdirs();
		}
		
		File conFile = new File(f, key + ".nmo");
		return conFile;
	}	
}