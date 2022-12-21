package com.hwfs.sm.srm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.srm.dao.MonthCloseChkDAO;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 월마감 현황을 관리하는 MonthCloseChk Service Implementation
 * 
 * @ClassName MonthCloseChkServiceImpl.java
 * @Description MonthCloseChkServiceImpl Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.12.21    백승현      최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 백승현
 * @since 2015.12.21
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/srm/monthCloseChkService")
public class MonthCloseChkServiceImpl extends DefaultServiceImpl implements MonthCloseChkService {

	/** LogService */
	// private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SapSlipNonUpoadListDAO Bean 생성 */
	@Resource(name = "/sm/srm/monthCloseChkDAO")
	private MonthCloseChkDAO monthCloseChkDAO;

	/**
	 * 월마감관리 현황 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return monthCloseChkDAO.selectList(mapParam);
	}

	/**
	 * 월마감 현황을 조회 DataSetMap의 데이터를 Merge 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	public int saveList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += monthCloseChkDAO.insert(rowData);
			}
		}
		return insRowCnt;
	}
	

	/**
	 * 회계 월마감 현황을 조회 DataSetMap의 데이터를 Merge 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	public int saveList2(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += monthCloseChkDAO.insert2(rowData);
			}
		}
		return insRowCnt;
	}

	/**
	 * 회계 월마감관리 현황 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectList2(Map<String, Object> mapParam) throws Exception {
		return monthCloseChkDAO.selectList2(mapParam);
	}

}
