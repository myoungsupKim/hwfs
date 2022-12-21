package com.hwfs.rc.roa.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;




//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.roa.dao.PartTimeDutyDetailDAO;
import com.hwfs.rc.roa.dao.PartTimeSalaryDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 용역 근무 내용을 관리하는 PartTimeDutyDetail Service Implementation
 * 
 * @ClassName PartTimeDutyDetailServiceImpl.java
 * @Description PartTimeDutyDetailServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.11.22    김지영        최초생성
 * </pre>
 * @author 서비스ITO2 : 김지영
 * @since 2018.11.22
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/roa/partTimeDutyDetailService")
public class PartTimeDutyDetailServiceImpl extends DefaultServiceImpl implements PartTimeDutyDetailService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** PartTimeDutyDetailDAO Bean 생성 */
	@Resource(name = "/rc/roa/partTimeDutyDetailDAO")
	private PartTimeDutyDetailDAO partTimeDutyDetailDAO;
	

	/**
	 * 용역 근무 내용 관리 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return partTimeDutyDetailDAO.selectList(mapParam);
	}

	/**
	 * 용역 근무 내용 관리 중복체크
	*/
	@Override
	public int selectExists(Map<String, Object> parameter) {
		return partTimeDutyDetailDAO.selectExists(parameter);
	}
	
	/**
	 * 용역 근무 내용 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
				insRowCnt += partTimeDutyDetailDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += partTimeDutyDetailDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += partTimeDutyDetailDAO.delete(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 용역 근무내용정보(Combo)를 조회한다.
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectDutyDetail(Map<String, Object> mapParam) throws Exception {
		return partTimeDutyDetailDAO.selectDutyDetail(mapParam);
	}
}
