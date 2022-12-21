package com.hwfs.rc.sle.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.sle.dao.BnbSaleDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * B&B 매출조회하는 BnbSale Service Implementation
 * 
 * @ClassName BnbSaleServiceImpl.java
 * @Description BnbSaleServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.09.15    ydpark        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 ydpark
 * @since 2015.09.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/sle/bnbSaleService")
public class BnbSaleServiceImpl extends DefaultServiceImpl implements BnbSaleService {
	
	/** BnbSaleDAO Bean 생성 */
	@Resource(name = "/rc/sle/bnbSaleDAO")
	private BnbSaleDAO bnbSaleDAO;
	

	/**
	 * 조회 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	@Resource(name="transactionManagerResortfo")
	private PlatformTransactionManager txManager;
	
	@Transactional(propagation=Propagation.NOT_SUPPORTED)
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		
		//Transaction
		//TransactionStatus txStatus = txManager.getTransaction(new DefaultTransactionDefinition());
		
		return bnbSaleDAO.selectList(mapParam);
	}

	/**
	 * 조회 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += bnbSaleDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += bnbSaleDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += bnbSaleDAO.delete(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
