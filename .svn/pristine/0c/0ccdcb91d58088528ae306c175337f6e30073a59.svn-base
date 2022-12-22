package com.hwfs.ma.mas.service;

import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ma.mas.dao.SuspenseAltDAO;
import com.hwfs.sc.cmn.sap.EAIResponse;
import com.hwfs.sc.cmn.sap.request.YearBudgetInqueryRequest;
import com.hwfs.sc.cmn.sap.service.EAIService;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 전체 예산을 조회하는 SuspenseAlt Service Implementation
 * 
 * @ClassName SuspenseAltServiceImpl.java
 * @Description SuspenseAltServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.09.21    박준석        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 박준석
 * @since 2015.09.21
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ma/mas/suspenseAltService")
public class SuspenseAltServiceImpl extends DefaultServiceImpl implements SuspenseAltService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SuspenseAltDAO Bean 생성 */
	@Resource(name = "/ma/mas/suspenseAltDAO")
	private SuspenseAltDAO suspenseAltDAO;
	
	@Resource(name = "EAIService")
	EAIService eaiService;

	/**
	 * 전체 예산조회 목록을 조회한다.
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
	public List<Map<String, Object>> selectSuspenseAlt(Map<String, Object> mapParam) throws Exception {
		
 	 	/* ******************************************************************************* */
		/* 잔여예산조회                                                                    */
		/* ******************************************************************************* */
		//Map<String, Object> map = null;
		
		List<Map<String, Object>> list = null;
		
		YearBudgetInqueryRequest request = new YearBudgetInqueryRequest();
		
		//System.out.println("mapParam : " + mapParam);
		if (mapParam.containsKey("setInqYy"))
			request.setInqYy(mapParam.get("setInqYy").toString().trim());
		
		if (mapParam.containsKey("setCctrCd"))
			request.setCctrCd(mapParam.get("setCctrCd").toString().trim());
		
		if (mapParam.containsKey("setIoCd"))
			request.setIoCd(mapParam.get("setIoCd").toString().trim());
		
		if (mapParam.containsKey("setAcctCd"))
			request.setAcctCd(mapParam.get("setAcctCd").toString().trim());
		
//		request.setInqYy("");
//		request.setCctrCd("");
//		request.setIoCd("");
//		request.setAcctCd("");
		
		EAIResponse res = eaiService.call(request);
		//System.out.println("res : " + res);
		if (res.isSuccess()) {
			try {
				if(res.getListMap().size() > 0){
					list = res.getListMap();
				}
			} catch (Exception e) {
				logger.error(e.getMessage());
			}
		} else {
			logger.debug(res.getErrorCode() + " / " + res.getErrorMsg());
			if (res.getErrorCode() == -1) {
				logger.debug("조회된 결과가 없습니다.");
			} else {
				throw super.processException("eai.exception");	
			}
		}
		
		return list;
		
		//return suspenseAltDAO.selectSuspenseAlt(mapParam);
	}

	/**
	 * 전체 예산조회 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
				insRowCnt += suspenseAltDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += suspenseAltDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += suspenseAltDAO.delete(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
