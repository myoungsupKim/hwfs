package com.hwfs.sc.scu.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.scu.dao.TempUserMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 가사번 사용자를 관리하는 TempUserMgmt Service Implementation
 * 
 * @ClassName TempUserMgmtServiceImpl.java
 * @Description TempUserMgmtServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.10.02    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.10.02
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scu/tempUserMgmtService")
public class TempUserMgmtServiceImpl extends DefaultServiceImpl implements TempUserMgmtService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** TempUserMgmtDAO Bean 생성 */
	@Resource(name = "/sc/scu/tempUserMgmtDAO")
	private TempUserMgmtDAO tempUserMgmtDAO;
	

	/**
	 * 가사번 사용자 목록을 조회한다.
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
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return tempUserMgmtDAO.selectList(mapParam);
	}

	public RecordSet selectOrgInfo(Map<String, Object> mapParam) throws Exception {
		return tempUserMgmtDAO.selectOrgInfo(mapParam);
	}
	
	public RecordSet selectCreateTempSabun(Map<String, Object> mapParam) throws Exception {
		return tempUserMgmtDAO.selectCreateTempSabun(mapParam);
	}
	
	/**
	 * 가사번 사용자 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += tempUserMgmtDAO.insertSccUserInfo(rowData);
				tempUserMgmtDAO.insertHrPersonal(rowData);
				tempUserMgmtDAO.deleteSccUserAuthlevel(rowData);
				tempUserMgmtDAO.insertSccUserAuthlevel(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += tempUserMgmtDAO.updateSccUserInfo(rowData);
				tempUserMgmtDAO.updateHrPersonal(rowData);
				tempUserMgmtDAO.deleteSccUserAuthlevel(rowData);
				tempUserMgmtDAO.insertSccUserAuthlevel(rowData);
			}
		}
				
		return insRowCnt + updRowCnt;
	}
	
	public int clearPassword(Map<String, Object> mapParam) throws Exception {
		return tempUserMgmtDAO.updateSccUserInfo(mapParam);
	}
}
