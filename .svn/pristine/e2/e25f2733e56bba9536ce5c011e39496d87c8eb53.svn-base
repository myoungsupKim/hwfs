package com.hwfs.sm.spm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.spm.dao.AdvanceAdjustDescInquiryDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 선수금정산(대체)내역 조회하는 AdvanceAdjustDescInquiry Service Implementation
 * 
 * @ClassName AdvanceAdjustDescInquiryServiceImpl.java
 * @Description AdvanceAdjustDescInquiryServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.14    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.05.14
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/spm/advanceAdjustDescInquiryService")
public class AdvanceAdjustDescInquiryServiceImpl extends DefaultServiceImpl implements AdvanceAdjustDescInquiryService {
	
	/** AdvanceAdjustDescInquiryDAO Bean 생성 */
	@Resource(name = "/sm/spm/advanceAdjustDescInquiryDAO")
	private AdvanceAdjustDescInquiryDAO advanceAdjustDescInquiryDAO;
	
	/**
	 * 선수금정산(대체)내역을 조회 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return advanceAdjustDescInquiryDAO.selectList(mapParam);
	}

	/**
	 * 선수금정산(대체)내역을 조회 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
				insRowCnt += advanceAdjustDescInquiryDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += advanceAdjustDescInquiryDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += advanceAdjustDescInquiryDAO.delete(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
