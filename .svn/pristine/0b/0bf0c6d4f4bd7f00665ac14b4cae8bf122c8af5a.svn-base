package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fms.dao.SalePriceExceptionDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 업장품목 예외사항 관리하는 SalePriceException Service Implementation
 * 
 * @ClassName SalePriceExceptionServiceImpl.java
 * @Description SalePriceExceptionServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.15    최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.07.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fms/salePriceExceptionService")
public class SalePriceExceptionServiceImpl extends DefaultServiceImpl implements SalePriceExceptionService {
	
	/** SalePriceExceptionDAO Bean 생성 */
	@Resource(name = "/fm/fms/salePriceExceptionDAO")
	private SalePriceExceptionDAO salePriceExceptionDAO;
	

	/**
	 * 단가계약업장 목록 조회를 수행합니다
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectStd(Map<String, Object> mapParam) throws Exception {
		return salePriceExceptionDAO.selectStd(mapParam);
	}
	
	
	/**
	 * 업장품목 예외사항 관리 목록을 조회한다.(+, -)
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectListAdd(Map<String, Object> mapParam) throws Exception {
		return salePriceExceptionDAO.selectList(mapParam);
	}
	public RecordSet selectListDel(Map<String, Object> mapParam) throws Exception {
		return salePriceExceptionDAO.selectList(mapParam);
	}

	/**
	 * 업장품목 예외사항 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += salePriceExceptionDAO.insert(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += salePriceExceptionDAO.delete(rowData);
			}
		}
				
		return insRowCnt +  delRowCnt;
	}



	/**
	 * 엑셀업로드용 업장품목 예외사항 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveExcel(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			// 일괄 삭제 후에 INSERT 하는 방식으로 처리해야 한다.(한번만 실행)
			if (i==0) {
				delRowCnt = salePriceExceptionDAO.deleteAll(rowData);
			}

			// Merge 형태로 INSERT	
			insRowCnt += salePriceExceptionDAO.insert2(rowData);
		}
				
		return insRowCnt +  delRowCnt;
	}




}
