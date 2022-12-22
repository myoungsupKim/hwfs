package com.hwfs.fm.fmf.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fmf.dao.CloseMgntStatusDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 마감관리현황(브랜드) 조회하는 CloseMgntStatus Service Implementation
 * 
 * @ClassName CloseMgntStatusServiceImpl.java
 * @Description CloseMgntStatusServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.03.10   ksm        최초생성
 * 
 * </pre>
 * @author ksm
 * @since 2022.03.10
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmf/closeMgntStatusService")
public class CloseMgntStatusServiceImpl extends DefaultServiceImpl implements CloseMgntStatusService {
	
	/** CloseMgntStatusDAO Bean 생성 */
	@Resource(name = "/fm/fmf/closeMgntStatusDAO")
	private CloseMgntStatusDAO closeMgntStatusDAO;
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/**
	 * 마감관리현황(브랜드) 목록을 조회한다.
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
		return closeMgntStatusDAO.selectList(mapParam);
	}
	
	/**
	 * 마감관리현황(브랜드) 브랜드유통 관리부서 목록을 조회한다.
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
	public RecordSet selectBrandTm(Map<String, Object> mapParam) throws Exception {
		return closeMgntStatusDAO.selectBrandTm(mapParam);
	}
	
	/**
	 * 마감관리현황(브랜드) DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
//			if (rowType == DataSet.ROW_TYPE_INSERTED) {
//				insRowCnt += buySaleSumDAO.insert(rowData);
//			}
			//Update 처리
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += closeMgntStatusDAO.update(rowData);
			}
			//Delete 처리.
//			else if (rowType == DataSet.ROW_TYPE_DELETED) {
//				delRowCnt += buySaleSumDAO.delete(rowData);
//			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
