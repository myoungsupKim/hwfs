package com.hwfs.batch.sc.app.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
import com.hwfs.sc.app.dao.AppMasterInterfaceFcusdbDAO;
import com.hwfs.sc.app.dao.AppMasterInterfaceMariadbDAO;

/**
 * JOB Schedule Dao Class
 *
 * @ClassName AppMasterInterfaceDAO.java
 * @Description AppMasterInterfaceDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.07.14.   김명섭        최초생성
 * </pre>
 */
@Repository("/batch/sc/app/appMasterInterfaceDAO")
public class AppMasterInterfaceDAO extends DefaultBatchDAO {

    /**
     * 식재앱 판가,자재마스터 송신 배치
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
	/** AppMasterInterfaceFcusdbDAO Bean 생성 */
	@Resource(name = "/sc/app/appMasterInterfaceFcusdbDAO")
	private AppMasterInterfaceFcusdbDAO appMasterInterfaceFcusdbDAO;
	
	/** AppMasterInterfaceMariadbDAO Bean 생성 */
	@Resource(name = "/sc/app/appMasterInterfaceMariadbDAO")
	private AppMasterInterfaceMariadbDAO appMasterInterfaceMariadbDAO;

	@Resource(name ="transactionManagerfdapp")
	private PlatformTransactionManager txManger;
	
	public int batchJob(Map<String, Object> mapParam) throws Exception {

		int insRowCnt = 0;
		int updRowCnt = 0;
		int procCnt = 0;
		RecordSet searchItem;
		RecordSet searchFsale2;
		RecordSet searchItem2;

		//Transaction(자재마스터)
		TransactionStatus txStatus2 = txManger.getTransaction(new DefaultTransactionDefinition());
		
		try{
			
			searchItem = super.queryForRecordSet("sc.app.appMasterInterfaceFcusdbDAO.selectItem", mapParam);
			//System.out.println("searchItem : " + searchItem.getRowCount());
			
			for(int i=0; i<searchItem.getRowCount(); i++)
			{
				//System.out.println("searchItem i : " + i);
				Map<String, Object> rowData = searchItem.get(i);

				insRowCnt += appMasterInterfaceMariadbDAO.itemInsert(rowData);
				updRowCnt += super.update("sc.app.appMasterInterfaceFcusdbDAO.updateItem", rowData);
				
			}

			//System.out.println("itemInsert commit");
			txManger.commit(txStatus2);
		}catch( Exception e){
			//rollback
			//System.out.println("itemInsert rollback : " + e.toString());
			txManger.rollback(txStatus2);
			throw e;
		}

		//Transaction(공급업체판가)
		TransactionStatus txStatus3 = txManger.getTransaction(new DefaultTransactionDefinition());
		
		try{
			
			searchFsale2 = super.queryForRecordSet("sc.app.appMasterInterfaceFcusdbDAO.selectFsale2", mapParam);
			//System.out.println("searchFsale2 : " + searchFsale2.getRowCount());
			
			for(int i=0; i<searchFsale2.getRowCount(); i++)
			{
				Map<String, Object> rowData = searchFsale2.get(i);

				insRowCnt += appMasterInterfaceMariadbDAO.fsaleInsert2(rowData);
				updRowCnt += super.update("sc.app.appMasterInterfaceFcusdbDAO.updateFsale2", rowData);
				
			}
			
			//System.out.println("fsaleInsert2 commit");
			txManger.commit(txStatus3);
		}catch( Exception e){
			//rollback
			//System.out.println("fsaleInsert2 rollback : " + e.toString());
			txManger.rollback(txStatus3);
			throw e;
		}

		//Transaction(공급업체품목)
		TransactionStatus txStatus4 = txManger.getTransaction(new DefaultTransactionDefinition());
		
		try{
			
			searchItem2 = super.queryForRecordSet("sc.app.appMasterInterfaceFcusdbDAO.selectItem2", mapParam);
			//System.out.println("searchItem2 : " + searchItem2.getRowCount());
			
			for(int i=0; i<searchItem2.getRowCount(); i++)
			{
				Map<String, Object> rowData = searchItem2.get(i);

				insRowCnt += appMasterInterfaceMariadbDAO.itemInsert2(rowData);
				updRowCnt += super.update("sc.app.appMasterInterfaceFcusdbDAO.updateItem2", rowData);
				
			}
			
			//System.out.println("itemInsert2 commit");
			txManger.commit(txStatus4);
		}catch( Exception e){
			//rollback
			//System.out.println("itemInsert2 rollback : " + e.toString());
			txManger.rollback(txStatus4);
			throw e;
		}

		return insRowCnt;
    }
/*
	public int batchJob2(Map<String, Object> mapParam) throws Exception {

		int insRowCnt = 0;
		int updRowCnt = 0;
		int procCnt = 0;
		RecordSet searchFsale;
		List<Map> listMap = new ArrayList<Map>();
		int[] upCnts = null;

		try{
			
			searchFsale = super.queryForRecordSet("sc.app.appMasterInterfaceFcusdbDAO.selectFsale", mapParam);
			System.out.println("searchFsale : " + searchFsale.getRowCount());

			for(int i=0; i<searchFsale.getRowCount(); i++)
			{
				System.out.println("searchFsale i : " + i);
				Map<String, Object> rowData = searchFsale.get(i);
				listMap.add(rowData);

				insRowCnt += appMasterInterfaceMariadbDAO.fsaleInsert(rowData);				
			}
			
			System.out.println("insRowCnt : " + insRowCnt);
			System.out.println("listMap : " + listMap.size());
			upCnts = appMasterInterfaceFcusdbDAO.updateFsale(listMap);
			
			System.out.println("inCnts : " + upCnts[0]);
			
		}catch( Exception e){
			throw e;
		}

		//System.out.println("batchJob2 Return : " + insRowCnt);
		return insRowCnt;
    }
*/    
	
	public int batchJob2(Map<String, Object> mapParam) throws Exception {

		int insRowCnt = 0;
		int updRowCnt = 0;
		int procCnt = 0;
		RecordSet searchFsale;

		//Transaction(식재판가)
		TransactionStatus txStatus = txManger.getTransaction(new DefaultTransactionDefinition());

		try{
			
			searchFsale = super.queryForRecordSet("sc.app.appMasterInterfaceFcusdbDAO.selectFsale", mapParam);
			//System.out.println("searchFsale : " + searchFsale.getRowCount());

			for(int i=0; i<searchFsale.getRowCount(); i++)
			{
				//System.out.println("searchFsale i : " + i);
				Map<String, Object> rowData = searchFsale.get(i);

				insRowCnt += appMasterInterfaceMariadbDAO.fsaleInsert(rowData);
				updRowCnt += super.update("sc.app.appMasterInterfaceFcusdbDAO.updateFsale", rowData);
				
			}
			
			//System.out.println("fsaleInsert commit");
			txManger.commit(txStatus);

		}catch( Exception e){
			//rollback
			//System.out.println("fsaleInsert Exception : " + e.toString());
			txManger.rollback(txStatus);
			throw e;
		}

		//System.out.println("batchJob2 Return : " + insRowCnt);
		return insRowCnt;
    }
	
	public int batchJob3(Map<String, Object> mapParam) throws Exception {

		int insRowCnt = 0;
		int updRowCnt = 0;
		int procCnt = 0;
		RecordSet searchOprate;

		
		//Transaction(운영단가율)
		TransactionStatus txStatus = txManger.getTransaction(new DefaultTransactionDefinition());
		
		try{
			
			searchOprate = super.queryForRecordSet("sc.app.appMasterInterfaceFcusdbDAO.selectOprate", mapParam);
			//System.out.println("searchOprate : " + searchOprate.getRowCount());
			
			for(int i=0; i<searchOprate.getRowCount(); i++)
			{
				//System.out.println("searchOprate i : " + i);
				Map<String, Object> rowData = searchOprate.get(i);

				insRowCnt += appMasterInterfaceMariadbDAO.oprateInsert(rowData);
				updRowCnt += super.update("sc.app.appMasterInterfaceFcusdbDAO.updateOprate", rowData);
				
			}
						
			//System.out.println("oprateInsert commit");
			txManger.commit(txStatus);
		}catch( Exception e){
			//rollback
			//System.out.println("oprateInsert rollback : " + e.toString());
			txManger.rollback(txStatus);
			throw e;
		}

		return insRowCnt;
    }

	public int batchJob4(Map<String, Object> mapParam) throws Exception {

		int insRowCnt = 0;
		int updRowCnt = 0;
		int procCnt = 0;
		RecordSet searchPrecheck0;
		RecordSet searchPrecheck1;
		RecordSet searchPrecheck2;
		RecordSet searchPrecheck3;
		RecordSet searchPrecheck4;

		
		//Transaction(구매수발주제한)
		TransactionStatus txStatus = txManger.getTransaction(new DefaultTransactionDefinition());
		
		try{
			
			searchPrecheck0 = super.queryForRecordSet("sc.app.appMasterInterfaceFcusdbDAO.selectPrecheck0", mapParam);
			
			for(int i=0; i<searchPrecheck0.getRowCount(); i++)
			{
				Map<String, Object> rowData = searchPrecheck0.get(i);

				insRowCnt += appMasterInterfaceMariadbDAO.precheck0Insert(rowData);
				updRowCnt += super.update("sc.app.appMasterInterfaceFcusdbDAO.updatePrecheck0", rowData);
				
			}

			searchPrecheck1 = super.queryForRecordSet("sc.app.appMasterInterfaceFcusdbDAO.selectPrecheck1", mapParam);
			
			for(int i=0; i<searchPrecheck1.getRowCount(); i++)
			{
				Map<String, Object> rowData = searchPrecheck1.get(i);

				insRowCnt += appMasterInterfaceMariadbDAO.precheck1Insert(rowData);
				updRowCnt += super.update("sc.app.appMasterInterfaceFcusdbDAO.updatePrecheck1", rowData);
				
			}

			searchPrecheck2 = super.queryForRecordSet("sc.app.appMasterInterfaceFcusdbDAO.selectPrecheck2", mapParam);
			
			for(int i=0; i<searchPrecheck2.getRowCount(); i++)
			{
				Map<String, Object> rowData = searchPrecheck2.get(i);

				insRowCnt += appMasterInterfaceMariadbDAO.precheck2Insert(rowData);
				updRowCnt += super.update("sc.app.appMasterInterfaceFcusdbDAO.updatePrecheck2", rowData);
				
			}
			
			searchPrecheck3 = super.queryForRecordSet("sc.app.appMasterInterfaceFcusdbDAO.selectPrecheck3", mapParam);
			
			for(int i=0; i<searchPrecheck3.getRowCount(); i++)
			{
				Map<String, Object> rowData = searchPrecheck3.get(i);

				insRowCnt += appMasterInterfaceMariadbDAO.precheck3Insert(rowData);
				updRowCnt += super.update("sc.app.appMasterInterfaceFcusdbDAO.updatePrecheck3", rowData);
				
			}
			
			searchPrecheck4 = super.queryForRecordSet("sc.app.appMasterInterfaceFcusdbDAO.selectPrecheck4", mapParam);
			
			for(int i=0; i<searchPrecheck4.getRowCount(); i++)
			{
				Map<String, Object> rowData = searchPrecheck4.get(i);

				insRowCnt += appMasterInterfaceMariadbDAO.precheck4Insert(rowData);
				updRowCnt += super.update("sc.app.appMasterInterfaceFcusdbDAO.updatePrecheck4", rowData);
				
			}
			
			txManger.commit(txStatus);
		}catch( Exception e){
			//rollback
			//System.out.println("oprateInsert rollback : " + e.toString());
			txManger.rollback(txStatus);
			throw e;
		}

		return insRowCnt;
    }
	
	public int batchJob5(Map<String, Object> mapParam) throws Exception {

		int insRowCnt = 0;
		int updRowCnt = 0;
		int procCnt = 0;
		RecordSet searchSaleamt;

		
		//Transaction(운영단가율)
		TransactionStatus txStatus = txManger.getTransaction(new DefaultTransactionDefinition());
		
		try{
			
			searchSaleamt = super.queryForRecordSet("sc.app.appMasterInterfaceFcusdbDAO.selectSaleamt", mapParam);
			//System.out.println("searchOprate : " + searchOprate.getRowCount());
			
			for(int i=0; i<searchSaleamt.getRowCount(); i++)
			{
				//System.out.println("searchOprate i : " + i);
				Map<String, Object> rowData = searchSaleamt.get(i);

				insRowCnt += appMasterInterfaceMariadbDAO.saleamtInsert(rowData);
				updRowCnt += super.update("sc.app.appMasterInterfaceFcusdbDAO.updateSaleamt", rowData);
				
			}
						
			//System.out.println("oprateInsert commit");
			txManger.commit(txStatus);
		}catch( Exception e){
			//rollback
			//System.out.println("oprateInsert rollback : " + e.toString());
			txManger.rollback(txStatus);
			throw e;
		}

		return insRowCnt;
    }
	
	
}
