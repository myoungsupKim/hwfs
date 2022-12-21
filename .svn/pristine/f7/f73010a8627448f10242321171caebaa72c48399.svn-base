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
import com.hwfs.fm.fms.dao.CustSysInterfaceDAO;
import com.hwfs.fm.fms.dao.CustSysInterfaceMssqlDAO;

/**
 * FMS JOB Schedule Dao Class
 *
 * @ClassName FmsCustSysInterfaceSubinvDAO.java
 * @Description FmsCustSysInterfaceSubinvDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016. 4. 15.   박용대        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015. 7. 11.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/fm/fms/fmsCustSysInterfaceSubinvDAO")
public class FmsCustSysInterfaceSubinvDAO extends DefaultBatchDAO {

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
	/** CustSysInterfaceDAO Bean 생성 */
	@Resource(name = "/fm/fms/custSysInterfaceDAO")
	private CustSysInterfaceDAO custSysInterfaceDAO;
	
	/** CustSysInterfaceMssqlDAO Bean 생성 */
	@Resource(name = "/fm/fms/custSysInterfaceMssqlDAO")
	private CustSysInterfaceMssqlDAO custSysInterfaceMssqlDAO;

	@Resource(name ="transactionManagerYfnc")
	private PlatformTransactionManager txManger;
	
	public int batchJob(Map<String, Object> mapParam) throws Exception {
		
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delFlag = 0;
		String sTodate = (String) mapParam.get("schDate1");
		String sDay = sTodate.substring(6);
		RecordSet searchSubinvResult;
		RecordSet searchItemResult;
		RecordSet searchOrder2Result;
		RecordSet searchTrade2Result;
		
		//Transaction
		TransactionStatus txStatus = txManger.getTransaction(new DefaultTransactionDefinition());
		
		try{
			System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
			
			//적용여부는 조금더 지켜보고 넣자.
			if(sDay.equals("01") || sDay.equals("16"))	//판가작업일이면 거래처 정보랑 상품정보를 보낸다
			{
				System.out.println("판가작업일");
			}
			else
			{
				System.out.println("판가작업 아닌일");
			}
			
			
			//logger.debug("창고정보 조회");
			searchSubinvResult = super.queryForRecordSet("fm.fms.custSysInterfaceDAO.selectSubinvBatch", mapParam);
			System.out.println("searchSubinvResult : " + searchSubinvResult.getRowCount());
			
			for(int i=0; i<searchSubinvResult.getRowCount(); i++)
			{
				Map<String, Object> rowData = searchSubinvResult.get(i);
				System.out.println("ifJobid : " + "subinv"+DateUtil.getYyyymmddhhmmss());
				System.out.println("rowid : " + i);
				rowData.put("ifJobid", "subinv"+DateUtil.getYyyymmddhhmmss());
				//rowData.put("mod", "D"); 	//개발DB : D
				rowData.put("mod", "P");	//운영DB : P
				rowData.put("loginSabun", "999999990");
				rowData.put("loginUserid", "999999990");
				rowData.put("loginPersMask", "");
				
				String key = custSysInterfaceMssqlDAO.subinvSelect(rowData);
				System.out.println("key : " + key);
				if(!"".equals(key) && key != null){
					updRowCnt += custSysInterfaceMssqlDAO.subinvUpdate(rowData);
				}else{
					insRowCnt += custSysInterfaceMssqlDAO.subinvInsert(rowData);
				}
			}
			
			//logger.debug("아이템정보 조회");
			searchItemResult = super.queryForRecordSet("fm.fms.custSysInterfaceDAO.selectItemBatch", mapParam);
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
				
				/*
				String key = custSysInterfaceMssqlDAO.itemSelect(rowData);
				System.out.println("key : " + key);
				if(!"".equals(key) && key != null){
					updRowCnt += custSysInterfaceMssqlDAO.itemUpdate(rowData);
				}else{
					insRowCnt += custSysInterfaceMssqlDAO.itemInsert(rowData);
				}
				*/
				updRowCnt += custSysInterfaceMssqlDAO.itemUpdate2(rowData);
			}
			
			//logger.debug("주문정보2 조회");
			/*
			searchOrder2Result = super.queryForRecordSet("fm.fms.custSysInterfaceDAO.selectOrder2Batch", mapParam);
			System.out.println("searchOrder2Result : " + searchOrder2Result.getRowCount());
			
			for(int i=0; i<searchOrder2Result.getRowCount(); i++)
			{
				Map<String, Object> rowData = searchOrder2Result.get(i);
				System.out.println("ifJobid : " + "order2"+DateUtil.getYyyymmddhhmmss());
				System.out.println("rowid : " + i);
				rowData.put("ifJobid", "order2"+DateUtil.getYyyymmddhhmmss());
				//rowData.put("mod", "D"); 	//개발DB : D
				rowData.put("mod", "P");	//운영DB : P
				rowData.put("loginSabun", "999999990");
				rowData.put("loginUserid", "999999990");
				rowData.put("loginPersMask", "");
				
				if(delFlag == 0 && i ==0){
					logger.debug("delFlag : " + delFlag + "  ,                " + i);
					delFlag += custSysInterfaceMssqlDAO.orderDelete(rowData);
				}
				insRowCnt += custSysInterfaceMssqlDAO.orderInsert(rowData);
			}
			*/
			
			//logger.debug("거래내역2 조회");
			/*
			searchTrade2Result = super.queryForRecordSet("fm.fms.custSysInterfaceDAO.selectTrans2Batch", mapParam);
			System.out.println("searchTrade2Result : " + searchTrade2Result.getRowCount());
			
			for(int i=0; i<searchTrade2Result.getRowCount(); i++)
			{
				Map<String, Object> rowData = searchTrade2Result.get(i);
				System.out.println("ifJobid : " + "trans2"+DateUtil.getYyyymmddhhmmss());
				System.out.println("rowid : " + i);
				rowData.put("ifJobid", "trans2"+DateUtil.getYyyymmddhhmmss());
				//rowData.put("mod", "D"); 	//개발DB : D
				rowData.put("mod", "P");	//운영DB : P
				rowData.put("loginSabun", "999999990");
				rowData.put("loginUserid", "999999990");
				rowData.put("loginPersMask", "");
				
				if(delFlag == 0 && i ==0){
					delFlag += custSysInterfaceMssqlDAO.tradeInfoDDDelete(rowData);
				}
				insRowCnt += custSysInterfaceMssqlDAO.tradeInfoDDInsert(rowData);
			}
			*/
			
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
