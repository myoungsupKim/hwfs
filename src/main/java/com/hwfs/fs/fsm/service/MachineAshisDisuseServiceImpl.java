package com.hwfs.fs.fsm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsm.dao.MachineAshisDisuseDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 기기/기물 as/폐기 관리하는 MachineAshisDisuse Service Implementation
 * 
 * @ClassName MachineAshisDisuseServiceImpl.java
 * @Description MachineAshisDisuseServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.13    김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.03.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsm/machineAshisDisuseService")
public class MachineAshisDisuseServiceImpl extends DefaultServiceImpl implements MachineAshisDisuseService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** MachineAshisDisuseDAO Bean 생성 */
	@Resource(name = "/fs/fsm/machineAshisDisuseDAO")
	private MachineAshisDisuseDAO machineAshisDisuseDAO;
	

	/**
	 * 기기/기물 as/폐기 관리 목록을 조회한다.
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
	public RecordSet selectAsList(Map<String, Object> mapParam) throws Exception {
		return machineAshisDisuseDAO.selectAsList(mapParam);
	}
	public RecordSet selectDisuseList(Map<String, Object> mapParam) throws Exception {
		return machineAshisDisuseDAO.selectDisuseList(mapParam);
	}

	/**
	 * 기기/기물 as/폐기 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap parameterAs, DataSetMap parameterDisuse) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < parameterAs.size() ; i++) {
			Map<String, Object> rowData = parameterAs.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += machineAshisDisuseDAO.insertAs(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += machineAshisDisuseDAO.updateAs(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += machineAshisDisuseDAO.deleteAs(rowData);
			}
		}
		
		for (int i = 0 ; i < parameterDisuse.size() ; i++) {
			Map<String, Object> rowData = parameterDisuse.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += machineAshisDisuseDAO.insertDisuse(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += machineAshisDisuseDAO.updateDisuse(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += machineAshisDisuseDAO.deleteDisuse(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
