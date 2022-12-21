package com.hwfs.rc.rcm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rcm.dao.CloseMgnt01DAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 업장 마감을하는 CloseMgnt01 Service Implementation
 * 
 * @ClassName CloseMgnt01ServiceImpl.java
 * @Description CloseMgnt01ServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.26    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.05.26
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rcm/closeMgnt01Service")
public class CloseMgnt01ServiceImpl extends DefaultServiceImpl implements CloseMgnt01Service {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** CloseMgnt01DAO Bean 생성 */
	@Resource(name = "/rc/rcm/closeMgnt01DAO")
	private CloseMgnt01DAO closeMgnt01DAO;
	

	/**
	 * 업장 마감 (매출목록)을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet salsList(Map<String, Object> mapParam) throws Exception {
//		System.out.println("#################################");
//		System.out.println("#################################"+super.propertiesService.getString("eai.system.code"));
//		System.out.println("#################################");
		return closeMgnt01DAO.salsList(mapParam);
	}

	/**
	 * 업장 마감 (지불목록)을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet paymentList(Map<String, Object> mapParam) throws Exception {
		return closeMgnt01DAO.paymentList(mapParam);
	}
	
	/**
	 * 업장 마감 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
				insRowCnt += closeMgnt01DAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += closeMgnt01DAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += closeMgnt01DAO.delete(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 업장 마감 (선수금발생 목록)을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectAdvanceOccurList(Map<String, Object> mapParam) throws Exception {
		return closeMgnt01DAO.selectAdvanceOccurList(mapParam);
	}
}
