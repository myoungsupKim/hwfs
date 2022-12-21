package com.hwfs.rc.roa.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.roa.dao.HelperSupportDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * HELPER 지원 내역을 관리하는 HelperSupport Service Implementation
 * 
 * @ClassName HelperSupportServiceImpl.java
 * @Description HelperSupportServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.23    유인찬        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유인찬
 * @since 2015.03.23
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/roa/helperSupportService")
public class HelperSupportServiceImpl extends DefaultServiceImpl implements HelperSupportService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** HelperSupportDAO Bean 생성 */
	@Resource(name = "/rc/roa/helperSupportDAO")
	private HelperSupportDAO helperSupportDAO;
	

	/**
	 * HELPER 지원 내역 목록을 조회한다.
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return helperSupportDAO.selectList(mapParam);
	}
	
	/**
	 * HELPER 지원 내역 중복을 체크한다.
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int selectExists(Map<String, Object> mapParam) throws Exception{
		return helperSupportDAO.selectExists(mapParam);
	}

	/**
	 * HELPER 지원 내역 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
				insRowCnt += helperSupportDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += helperSupportDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += helperSupportDAO.delete(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
