package com.hwfs.sm.ssi.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.ssi.dao.SalesTypeMgntDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 영업유형을 관리하는 SalesTypeMgnt Service Implementation
 * 
 * @ClassName SalesTypeMgntServiceImpl.java
 * @Description SalesTypeMgntServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.10    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.03.10
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/ssi/salesTypeMgntService")
public class SalesTypeMgntServiceImpl extends DefaultServiceImpl implements SalesTypeMgntService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SalesTypeMgntDAO Bean 생성 */
	@Resource(name = "/sm/ssi/salesTypeMgntDAO")
	private SalesTypeMgntDAO salesTypeMgntDAO;
	

	/**
	 * 영업유형 그룹을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return salesTypeMgntDAO.selectList(mapParam);
	}

	/**
	 * 영업유형 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectDtlList(Map<String, Object> mapParam) throws Exception {
		return salesTypeMgntDAO.selectDtlList(mapParam);
	}

	/**
	 * 영업유형 중복체크
	*/
	@Override
	public int selectExists(Map<String, Object> parameter) {
		return salesTypeMgntDAO.selectExists(parameter);
	}
	
	/**
	 * 영업유형 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
				insRowCnt += salesTypeMgntDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += salesTypeMgntDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += salesTypeMgntDAO.delete(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
