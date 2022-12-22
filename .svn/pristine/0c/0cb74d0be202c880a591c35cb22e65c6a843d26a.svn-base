package com.hwfs.fs.fsa.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsa.dao.AdoptionAssignDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 채용인력배정하는 AdoptionAssign Service Implementation
 * 
 * @ClassName AdoptionAssignServiceImpl.java
 * @Description AdoptionAssignServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.09    김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.04.09
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsa/adoptionAssignService")
public class AdoptionAssignServiceImpl extends DefaultServiceImpl implements AdoptionAssignService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** AdoptionAssignDAO Bean 생성 */
	@Resource(name = "/fs/fsa/adoptionAssignDAO")
	private AdoptionAssignDAO adoptionAssignDAO;
	

	/**
	 * 채용인력 목록을 조회한다.
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
	public RecordSet selectChasu(Map<String, Object> mapParam) throws Exception {
		return adoptionAssignDAO.selectChasu(mapParam);
	}
	public RecordSet selectVstList(Map<String, Object> mapParam) throws Exception {
		return adoptionAssignDAO.selectVstList(mapParam);
	}

	/**
	 * 채용인력 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap parameterReq, DataSetMap parameterVisit, DataSetMap parameterAssign) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < parameterReq.size() ; i++) {
			Map<String, Object> rowData = parameterReq.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Update 처리
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += adoptionAssignDAO.updateReq(rowData);
				for (int n = 0 ; n < parameterAssign.size() ; n++) {
					Map<String, Object> poolData = parameterAssign.get(n);
					adoptionAssignDAO.updatePoolMst(poolData);
				}
			}
		}
		
		for (int i = 0 ; i < parameterVisit.size() ; i++) {
			Map<String, Object> rowData = parameterVisit.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += adoptionAssignDAO.insertVisit(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += adoptionAssignDAO.updateVisit(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += adoptionAssignDAO.deleteVisit(rowData);
			}
		}
		
		for (int i = 0 ; i < parameterAssign.size() ; i++) {
			Map<String, Object> rowData = parameterAssign.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += adoptionAssignDAO.insertAssign(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				rowData.put("adoptionStatus", "R");
				updRowCnt += adoptionAssignDAO.updatePoolMst(rowData);
				delRowCnt += adoptionAssignDAO.deleteAssign(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
