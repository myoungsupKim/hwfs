package com.hwfs.sm.sar.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.sar.dao.ReceiveDetailInquiryDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 입금상세조회하는 ReceiveDetailInquiry Service Implementation
 * 
 * @ClassName ReceiveDetailInquiryServiceImpl.java
 * @Description ReceiveDetailInquiryServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.20    유성진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유성진
 * @since 2015.05.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/sar/receiveDetailInquiryService")
public class ReceiveDetailInquiryServiceImpl extends DefaultServiceImpl implements ReceiveDetailInquiryService {
	
	/** ReceiveDetailInquiryDAO Bean 생성 */
	@Resource(name = "/sm/sar/receiveDetailInquiryDAO")
	private ReceiveDetailInquiryDAO receiveDetailInquiryDAO;
	

	/**
	 * 입금상세조회 목록을 조회한다.
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
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return receiveDetailInquiryDAO.selectList(mapParam);
	}
	
	/**
	 * 입금내역상세 목록을 조회한다.
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
	public RecordSet selectDetail(Map<String, Object> mapParam) throws Exception {
		return receiveDetailInquiryDAO.selectDetail(mapParam);
	}

	/**
	 * 입금상세조회 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
				insRowCnt += receiveDetailInquiryDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += receiveDetailInquiryDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += receiveDetailInquiryDAO.delete(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
