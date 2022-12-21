package com.hwfs.guide.sample.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.guide.sample.dao.GuideSampleMysqlDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.tobesoft.xplatform.data.DataSet;


@Service("/guide/sample/guideSampleMysqlService")
public class GuideSampleMysqlServiceImpl extends DefaultServiceImpl implements GuideSampleMysqlService {

	@Resource(name="/guide/sample/guideSampleMysqlDAO")
	private GuideSampleMysqlDAO guideSampleMysqlDAO;

	@Resource(name ="transactionManagerLocalFood")
	private PlatformTransactionManager txManger;
	
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return guideSampleMysqlDAO.selectList(parameter);
	}

	
	@SuppressWarnings("unchecked")
	@Override
	public int saveList(DataSetMap list) throws Exception {
		
		TransactionStatus txStatus = txManger.getTransaction(new DefaultTransactionDefinition());
		
		int insertRowCnt = 0;
		int updateRowCnt = 0;
		int deleteRowCnt = 0;

		try {
			for (int i = 0 ; i < list.size() ; i++) {
				Map<String, Object> rowData = list.get(i);
				int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
	
				if (rowType == DataSet.ROW_TYPE_INSERTED) {
					insertRowCnt += guideSampleMysqlDAO.insert(rowData);
				} else if (rowType == DataSet.ROW_TYPE_UPDATED) {
					updateRowCnt += guideSampleMysqlDAO.update(rowData);
				} else if (rowType == DataSet.ROW_TYPE_DELETED) {
					deleteRowCnt += guideSampleMysqlDAO.delete(rowData);
				}
			}
			txManger.commit(txStatus);
		} catch (Exception e) {
			txManger.rollback(txStatus);
			throw e;
		}
		
		return insertRowCnt + updateRowCnt + deleteRowCnt;
	}
}
