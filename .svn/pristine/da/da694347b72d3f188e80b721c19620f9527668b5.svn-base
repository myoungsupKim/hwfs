package com.hwfs.fs.fsa.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsa.dao.AdoptionDelListDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 개인정보를 파기하는 AdoptionDelList Service Implementation
 * 
 * @ClassName AdoptionDelListServiceImpl.java
 * @Description AdoptionDelListServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.27    김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.04.27
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsa/adoptionDelListService")
public class AdoptionDelListServiceImpl extends DefaultServiceImpl implements AdoptionDelListService {

	/** AdoptionDelListDAO Bean 생성 */
	@Resource(name = "/fs/fsa/adoptionDelListDAO")
	private AdoptionDelListDAO adoptionDelListDAO;
	

	/**
	 * 개인정보 목록을 조회한다.
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
	public RecordSet selectDelList(Map<String, Object> mapParam) throws Exception {
		return adoptionDelListDAO.selectDelList(mapParam);
	}
	public RecordSet selectBrkdList(Map<String, Object> mapParam) throws Exception {
		return adoptionDelListDAO.selectBrkdList(mapParam);
	}

	/**
	 * 개인정보 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap parameterDel) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < parameterDel.size() ; i++) {
			Map<String, Object> rowData = parameterDel.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
 
			//Delete 처리.
			if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += adoptionDelListDAO.delete(rowData);
			}
		}
				
		return delRowCnt;
	}
}
