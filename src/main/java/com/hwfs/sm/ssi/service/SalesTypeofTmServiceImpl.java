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
import com.hwfs.sm.ssi.dao.SalesTypeofTmDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 팀별 영업유형을 관리하는 SalesTypeofTm Service Implementation
 * 
 * @ClassName SalesTypeofTmServiceImpl.java
 * @Description SalesTypeofTmServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.02    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.04.02
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/ssi/salesTypeofTmService")
public class SalesTypeofTmServiceImpl extends DefaultServiceImpl implements SalesTypeofTmService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SalesTypeofTmDAO Bean 생성 */
	@Resource(name = "/sm/ssi/salesTypeofTmDAO")
	private SalesTypeofTmDAO salesTypeofTmDAO;
	

	/**
	 * 팀별 영업유형 관리 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return salesTypeofTmDAO.selectList(mapParam);
	}

	/**
	 * 팀별 영업유형 중복체크
	*/
	@Override
	public int selectExists(Map<String, Object> parameter) {
		return salesTypeofTmDAO.selectExists(parameter);
	}
	
	/**
	 * 팀별 영업유형 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
			if (rowType == DataSet.ROW_TYPE_INSERTED || rowType == DataSet.ROW_TYPE_UPDATED) {
				insRowCnt += salesTypeofTmDAO.insert(rowData);
			}
			//Update 처리
//			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
//				updRowCnt += salesTypeofTmDAO.update(rowData);
//			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += salesTypeofTmDAO.delete(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
