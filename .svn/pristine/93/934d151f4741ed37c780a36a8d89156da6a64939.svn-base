package com.hwfs.fs.fso.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fso.dao.MarketerDivPopupDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 마케터배부등록팝업하는 MarketerDivPopup Service Implementation
 * 
 * @ClassName MarketerDivPopupServiceImpl.java
 * @Description MarketerDivPopupServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.02    박준석        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 박준석
 * @since 2015.07.02
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fso/marketerDivPopupService")
public class MarketerDivPopupServiceImpl extends DefaultServiceImpl implements MarketerDivPopupService {
	

	/** MarketerDivPopupDAO Bean 생성 */
	@Resource(name = "/fs/fso/marketerDivPopupDAO")
	private MarketerDivPopupDAO marketerDivPopupDAO;
	

	/**
	 * 마케터배부등록팝업 목록을 조회한다.
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
		return marketerDivPopupDAO.selectList(mapParam);
	}
	
	/**
	 * 마케터배부등록 총합을 조회한다.
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
	public RecordSet selectTotalSumChk(Map<String, Object> mapParam) throws Exception {
		return marketerDivPopupDAO.selectTotalSumChk(mapParam);
	}

	/**
	 * 마케터배부등록팝업 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public String saveList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String dupChk = "";
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				dupChk = marketerDivPopupDAO.selectMarketerDupChk(rowData).get(0).get("dupChk").toString();
				if("N".equals(dupChk)) {
					insRowCnt += marketerDivPopupDAO.insert(rowData);
				}
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += marketerDivPopupDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += marketerDivPopupDAO.delete(rowData);
			}
		}
				
		return dupChk;
	}
}
