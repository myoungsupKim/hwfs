package com.hwfs.fm.fmc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fmc.dao.DistributionRequestRptRegDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 물류요청서등록하는 DistributionRequestRptReg Service Implementation
 * 
 * @ClassName DistributionRequestRptRegServiceImpl.java
 * @Description DistributionRequestRptRegServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.12    최영준        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.03.12
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmc/distributionRequestRptRegService")
public class DistributionRequestRptRegServiceImpl extends DefaultServiceImpl implements DistributionRequestRptRegService {

	/** DistributionRequestRptRegDAO Bean 생성 */
	@Resource(name = "/fm/fmc/distributionRequestRptRegDAO")
	private DistributionRequestRptRegDAO distributionRequestRptRegDAO;
	

	/**
	 * 물류요청서 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param parameter
	 *            조회조건 MAP
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return distributionRequestRptRegDAO.selectList(parameter);
	}

	/**
	 * 물류요청서 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	@Override
	public int saveList(DataSetMap list) throws Exception {
		int masterCnt = 0;
		int insertRowCnt = 0;
		int updateRowCnt = 0;
		int deleteRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			//  MASTER정보 생성 : 1건만 생성
			if (i==0) {
				masterCnt = distributionRequestRptRegDAO.insertMast(rowData);				
			}
			
			//추가를 수행합니다.
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insertRowCnt += distributionRequestRptRegDAO.insert(rowData);
			}
			//수정을 수행합니다.
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updateRowCnt += distributionRequestRptRegDAO.update(rowData);
			}
			//삭제를 수행합니다.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				deleteRowCnt += distributionRequestRptRegDAO.delete(rowData);
			}
		}
				
		return insertRowCnt + updateRowCnt + deleteRowCnt;
	}

	public RecordSet selectMast(Map<String, Object> parameter) throws Exception {
		return distributionRequestRptRegDAO.selectMast(parameter);
	}
	
	
	
	/**
	 * 물류요청서 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	@Override
	public int saveMast(Map<String, Object> parameter2) throws Exception {
		int insertRowCnt = 0;
		int updateRowCnt = 0;
		int deleteRowCnt = 0;
		
			insertRowCnt += distributionRequestRptRegDAO.insertMast(parameter2);
			
		
		return insertRowCnt + updateRowCnt + deleteRowCnt;
	}
}
