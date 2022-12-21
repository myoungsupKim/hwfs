package com.hwfs.sm.srm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.srm.dao.DiplomatExemptionDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 외교관 면세정보를 관리하는 DiplomatExemption Service Implementation
 * 
 * @ClassName DiplomatExemptionServiceImpl.java
 * @Description DiplomatExemptionServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.08    Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.05.08
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/srm/diplomatExemptionService")
public class DiplomatExemptionServiceImpl extends DefaultServiceImpl implements DiplomatExemptionService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** DiplomatExemptionDAO Bean 생성 */
	@Resource(name = "/sm/srm/diplomatExemptionDAO")
	private DiplomatExemptionDAO diplomatExemptionDAO;
	

	/**
	 * 외교관 면세정보 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return diplomatExemptionDAO.selectList(mapParam);
	}

	/**
	 * 외교관 면세정보 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
				insRowCnt += diplomatExemptionDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += diplomatExemptionDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += diplomatExemptionDAO.delete(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
