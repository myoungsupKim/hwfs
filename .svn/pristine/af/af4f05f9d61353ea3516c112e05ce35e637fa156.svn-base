package com.hwfs.fs.fsa.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsa.dao.AdoptionReqListDAO;
import com.hwfs.sc.cmn.service.AddrSearchService;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 채용인력요청 관리하는 AdoptionReqList Service Implementation
 * 
 * @ClassName AdoptionReqListServiceImpl.java
 * @Description AdoptionReqListServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.02    김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.04.02
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsa/adoptionReqListService")
public class AdoptionReqListServiceImpl extends DefaultServiceImpl implements AdoptionReqListService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** AdoptionReqListDAO Bean 생성 */
	@Resource(name = "/fs/fsa/adoptionReqListDAO")
	private AdoptionReqListDAO adoptionReqListDAO;
	
	//주소를 처리하기 위한 공통 Service
	@Resource(name = "/sc/cmn/addrSearchService")
	private AddrSearchService addressService;
	

	/**
	 * 채용인력요청 목록을 조회한다.
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
	public RecordSet searchUpjangAddr(Map<String, Object> mapParam) throws Exception {
		return adoptionReqListDAO.searchUpjangAddr(mapParam);
	}
	public RecordSet selectReqList(Map<String, Object> mapParam) throws Exception {
		return adoptionReqListDAO.selectReqList(mapParam);
	}
	public RecordSet selectUpjangPoolList(Map<String, Object> mapParam) throws Exception {
		return adoptionReqListDAO.selectUpjangPoolList(mapParam);
	}

	/**
	 * 채용인력요청 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap parameterReq, DataSetMap parameterAssign, String sabun) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < parameterReq.size() ; i++) {
			Map<String, Object> rowData = parameterReq.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//주소 처리
			Map<String, Object> rtn = addressService.setAddress(rowData, "addrInfo", sabun);
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += adoptionReqListDAO.insertReq(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += adoptionReqListDAO.updateReq(rowData);
				for (int n = 0 ; n < parameterAssign.size() ; n++) {
					Map<String, Object> endData = parameterAssign.get(n);
					adoptionReqListDAO.updateEnd(endData);
				}
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += adoptionReqListDAO.deleteReq(rowData);
			}
		}
				
		for (int i = 0 ; i < parameterAssign.size() ; i++) {
			Map<String, Object> rowData = parameterAssign.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
//			if (rowType == DataSet.ROW_TYPE_INSERTED) {
//				insRowCnt += adoptionReqListDAO.insertReq(rowData);
//			}
			//Update 처리
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += adoptionReqListDAO.updateAssign(rowData);
				for (int n = 0 ; n < parameterAssign.size() ; n++) {
					Map<String, Object> endData = parameterAssign.get(n);
					adoptionReqListDAO.updateEnd(endData);
				}
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += adoptionReqListDAO.deleteReq(rowData);
			}
		}
		
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
