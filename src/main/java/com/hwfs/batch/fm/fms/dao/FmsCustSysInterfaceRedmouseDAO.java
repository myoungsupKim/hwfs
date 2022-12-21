package com.hwfs.batch.fm.fms.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.sql.Types;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.hwfs.batch.defaults.DefaultBatchDAO;
import com.hwfs.cmn.util.DateUtil;
import com.hwfs.fm.fms.dao.CustSysInterfaceRedmouseDAO;
import com.hwfs.fm.fms.dao.CustSysInterfaceRedmouseMssqlDAO;

/**
 * FMS JOB Schedule Dao Class
 *
 * @ClassName FmsCustSysInterfaceRedmouseDAO.java
 * @Description FmsCustSysInterfaceRedmouseDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.12.23.   JHKim        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015. 7. 11.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/fm/fms/fmsCustSysInterfaceRedmouseDAO")
public class FmsCustSysInterfaceRedmouseDAO extends DefaultBatchDAO {

    /**
     * 식재영업 고객인터페이스 창고자료 전송 배치
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
	/** CustSysInterfaceRedmouseDAO Bean 생성 */
	@Resource(name = "/fm/fms/custSysInterfaceRedmouseDAO")
	private CustSysInterfaceRedmouseDAO custSysInterfaceRedmouseDAO;
	
	/** CustSysInterfaceRedmouseMssqlDAO Bean 생성 */
	@Resource(name = "/fm/fms/custSysInterfaceRedmouseMssqlDAO")
	private CustSysInterfaceRedmouseMssqlDAO custSysInterfaceRedmouseMssqlDAO;

	@Resource(name ="transactionManagerLocalFood")
	private PlatformTransactionManager txManger;
	
	public int batchJob(Map<String, Object> mapParam) throws Exception {
		
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delFlag = 0;
		String sTodate = (String) mapParam.get("schDate1");
		RecordSet searchItemResult;
		
		//Transaction
		TransactionStatus txStatus = txManger.getTransaction(new DefaultTransactionDefinition());
		
		try{
			System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
			 
			//logger.debug("아이템정보 조회");
			searchItemResult = super.queryForRecordSet("fm.fms.custSysInterfaceRedmouseDAO.selectItemBatch", mapParam);
			System.out.println("searchItemResult : " + searchItemResult.getRowCount());
			
			for(int i=0; i<searchItemResult.getRowCount(); i++)
			{				
				Map<String, Object> rowData = searchItemResult.get(i);
				System.out.println("ifJobid : " + "item"+DateUtil.getYyyymmddhhmmss());
				System.out.println("rowid : " + i);
				rowData.put("ifJobid", "ITEM"+DateUtil.getYyyymmddhhmmss());
				//rowData.put("mod", "D"); 	//개발DB : D
				rowData.put("mod", "P");	//운영DB : P
				rowData.put("loginSabun", "999999990");
				rowData.put("loginUserid", "999999990");
				rowData.put("loginPersMask", "");
				
				if(delFlag == 0 && i ==0){
					delFlag += custSysInterfaceRedmouseMssqlDAO.itemDelete(rowData);
				}
				
				updRowCnt += custSysInterfaceRedmouseMssqlDAO.itemInsert(rowData);
			}
			
			System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
			
			txManger.commit(txStatus);
		}catch( Exception e){
			//rollback
			txManger.rollback(txStatus);
			throw e;
		}
    	
		return insRowCnt+updRowCnt;
    }

}
