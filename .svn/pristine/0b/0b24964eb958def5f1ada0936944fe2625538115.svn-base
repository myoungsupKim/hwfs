package com.hwfs.guide.sample.service;

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
import com.hwfs.guide.sample.dao.GuideJdbcDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 외부 DB에 접속하여 처리하는 ServiceImpl
 * - 데이터소스는 이용하지만 TxManager를 이용하지 못하고 직접 commit/rollback 처리해야 함
 * @ClassName GuideJdbcServiceImpl.java
 * @Description GuideJdbcServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.09.01.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 1. 22.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/guide/sample/guideJdbcService")
public class GuideJdbcServiceImpl extends DefaultServiceImpl implements GuideJdbcService {
	//외부 DB TxManager bean
    @Resource(name="transactionManagerYfnc")
    private PlatformTransactionManager txManager;
    
    /** Guide Jdbc DAO */
	@Resource(name="/guide/sample/guideJdbcDAO")
	private GuideJdbcDAO guideJdbcDAO;

	/**
	 * GUIDE_SAMPLE의 DATA를 조회한다.
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.template.service.GuideSampleService#selectList(java.util.Map)
	*/
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return guideJdbcDAO.selectList(parameter);
	}

	/**
	 * GUIDE_SAMPLE에 DATA를 추가/변경/삭제한다.
	 * <pre>
	 * - TxManager를 이용하지 못하고 직접 commit/rollback 처리해야 함
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.template.service.GuideSampleService#insertList(hone.online.xplatform.map.DataSetMap)
	*/
	@SuppressWarnings("unchecked")
	@Override
	@Transactional(propagation=Propagation.REQUIRED)  //트랜잭션 속성 설정
	public int saveList(DataSetMap list) throws Exception {
		int insertRowCnt = 0;
		int updateRowCnt = 0;
		int deleteRowCnt = 0;
		
		//Transaction 상태 얻기
    	TransactionStatus txStatus = txManager.getTransaction(new DefaultTransactionDefinition());
		try {
			for (int i = 0 ; i < list.size() ; i++) {
				Map<String, Object> rowData = list.get(i);
				int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

				//추가를 수행합니다.
				if (rowType == DataSet.ROW_TYPE_INSERTED) {
					insertRowCnt += guideJdbcDAO.insert(rowData);
				}
				//수정을 수행합니다.
				else if (rowType == DataSet.ROW_TYPE_UPDATED) {
					updateRowCnt += guideJdbcDAO.update(rowData);
				}
				//삭제를 수행합니다.
				else if (rowType == DataSet.ROW_TYPE_DELETED) {
					deleteRowCnt += guideJdbcDAO.delete(rowData);
				}
			}
			
			//commit 처리
	    	txManager.commit(txStatus);
		}catch (Exception ex) {
			//rollback 처리
			txManager.rollback(txStatus);
			throw ex;
		}
		return insertRowCnt + updateRowCnt + deleteRowCnt;
	}

}
