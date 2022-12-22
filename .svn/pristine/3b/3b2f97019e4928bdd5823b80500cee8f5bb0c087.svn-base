package com.hwfs.fs.fsb.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsb.dao.UpjangPackModifyDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 사업장을 일괄수정하는 UpjangPackModify Service Implementation
 * 
 * @ClassName UpjangPackModifyServiceImpl.java
 * @Description UpjangPackModifyServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.21    김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.05.21
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsb/upjangPackModifyService")
public class UpjangPackModifyServiceImpl extends DefaultServiceImpl implements UpjangPackModifyService {
	
	/** UpjangPackModifyDAO Bean 생성 */
	@Resource(name = "/fs/fsb/upjangPackModifyDAO")
	private UpjangPackModifyDAO upjangPackModifyDAO;
	

	/**
	 * 사업장 목록을 조회한다.
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
		return upjangPackModifyDAO.selectList(mapParam);
	}

	/**
	 * 사업장 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap deptList) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < deptList.size() ; i++) {
			Map<String, Object> rowData = deptList.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			String gubun;
			//Update 처리
			if (rowType == DataSet.ROW_TYPE_UPDATED) {

				updRowCnt += upjangPackModifyDAO.update(rowData);
				
				upjangPackModifyDAO.insert(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += upjangPackModifyDAO.delete(rowData);
			}
		}
				
		return updRowCnt + delRowCnt;
	}
}
