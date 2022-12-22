package com.hwfs.guide.sample.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.guide.sample.dao.SapIfMultiDataProcessDAO;
import com.hwfs.sc.cmn.sap.EAIResponse;
import com.hwfs.sc.cmn.sap.dto.AcctMmSumDTO;
import com.hwfs.sc.cmn.sap.list.AcctMmSumList;
import com.hwfs.sc.cmn.sap.service.EAIService;

 /**
 * SAP IF로 멀티자료 이관하는하는 SapIfMultiDataProcess Service Implementation
 *
 * @ClassName SapIfMultiDataProcessServiceImpl.java
 * @Description SapIfMultiDataProcessServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.22    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.05.22
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/guide/sample/sapIfMultiDataProcessService")
public class SapIfMultiDataProcessServiceImpl extends DefaultServiceImpl implements SapIfMultiDataProcessService {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SapIfMultiDataProcessDAO Bean 생성 */
	@Resource(name = "/guide/sample/sapIfMultiDataProcessDAO")
	private SapIfMultiDataProcessDAO sapIfMultiDataProcessDAO;

	@Resource(name="EAIService")
	EAIService eaiService;

	/**
	 * SAP IF로 멀티자료 목록을 조회한다.
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
		return sapIfMultiDataProcessDAO.selectList(mapParam);
	}

	/**
	 * SAP IF로 멀티자료 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	public int saveList(DataSetMap parameter) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
/////////////////////////////////////////////////////////////////////////////////////////////////

		return insRowCnt + updRowCnt + delRowCnt;
	}


	/**
	 * 계정별 월합계 집계내역 샘플
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.guide.sample.service.SapIfMultiDataProcessService#saveAcctMmSum(hone.online.xplatform.map.DataSetMap)
	*/
	public void saveAcctMmSum(Map<String, Object> condition, DataSetMap datas) throws Exception {

		/**
		 * 아래의 예제 중에서 하나를 선택하여 사용하세요.
		 */

		//*********************************************************************************************
		//[[Sample Case 1 - 처리하고자 하는 자료를 DB에서 SELECT하는 경우
		//*********************************************************************************************
		RecordSet rs1 = sapIfMultiDataProcessDAO.selectAcctMmSum(condition);
		AcctMmSumList list1 = new AcctMmSumList();
		list1.setDataList(rs1);
		EAIResponse res1 = eaiService.call(list1);

		if (res1.isSuccess()) {
			logger.debug("※※※※※※※※※※ 성공에 대한 처리 ※※※※※※※※※※");
		}
		else {
			logger.debug("※※※※※※※※※※ 실패에 대한 처리 ※※※※※※※※※※");
		}
		//*********************************************************************************************
		//[[Sample Case 1 - 처리하고자 하는 자료를 DB에서 SELECT하는 경우
		//*********************************************************************************************

		//*********************************************************************************************
		//[[Sample Case 2 - 처리하고자 하는 자료가 UI부터 DataSetMap으로 전달되는 경우
		//*********************************************************************************************
		AcctMmSumList list2 = new AcctMmSumList();

		//[[아래의 유형에서 적절히 선택하여 사용한다.

		list2.setDataList(datas); //-전체의 자료를 대상으로 처리한다.
		//list2.setDataList(datas, DataSet.ROW_TYPE_INSERTED); //-신규 자료를 대상으로 처리한다.
		//list2.setDataList(datas, DataSet.ROW_TYPE_UPDATED); //-변경 자료를 대상으로 처리한다.
		//list2.setDataList(datas, DataSet.ROW_TYPE_DELETED); //-삭제 자료를 대상으로 처리한다.

		//아래의 유형에서 적절히 선택하여 사용한다.]]

		EAIResponse res2 = eaiService.call(list2);

		if (res2.isSuccess()) {
			logger.debug("※※※※※※※※※※ 성공에 대한 처리 ※※※※※※※※※※");
		}
		else {
			logger.debug("※※※※※※※※※※ 실패에 대한 처리 ※※※※※※※※※※");
		}
		//*********************************************************************************************
		//Sample Case 2 - 처리하고자 하는 자료가 UI부터 DataSetMap으로 전달되는 경우]]
		//*********************************************************************************************

		//*********************************************************************************************
		//[[Sample Case 3 - 처리하고자 하는 자료를 DTO에 직접 할당하여 처리하는 경우
		//*********************************************************************************************
		List<AcctMmSumDTO> list = new ArrayList<AcctMmSumDTO>();
		AcctMmSumDTO dto1 = new AcctMmSumDTO();
		dto1.setBuCd("2000");
		dto1.setFiscalYear("2015");
		dto1.setFiscalMm("06");
		dto1.setMuCd("2001");
		dto1.setTmCd("110000");
		dto1.setCcCd("110011");
		dto1.setAcctCd("1234567");
		dto1.setDrAmt(BigDecimal.valueOf(1100));
		dto1.setCrAmt(BigDecimal.valueOf(1100));

		list.add(dto1);

		AcctMmSumDTO dto2 = new AcctMmSumDTO();
		dto2.setBuCd("2000");
		dto2.setFiscalYear("2015");
		dto2.setFiscalMm("06");
		dto2.setMuCd("2001");
		dto2.setTmCd("110000");
		dto2.setCcCd("110011");
		dto2.setAcctCd("1236547");
		dto2.setDrAmt(BigDecimal.valueOf(1100));
		dto2.setCrAmt(BigDecimal.valueOf(1100));

		list.add(dto2);

		AcctMmSumList list3 = new AcctMmSumList();
		list3.setDataList(list);

		EAIResponse res3 = eaiService.call(list3);

		if (res3.isSuccess()) {
			logger.debug("※※※※※※※※※※ 성공에 대한 처리 ※※※※※※※※※※");
		}
		else {
			logger.debug("※※※※※※※※※※ 실패에 대한 처리 ※※※※※※※※※※");
		}
		//*********************************************************************************************
		//Sample Case 3 - 처리하고자 하는 자료를 DTO에 직접 할당하여 처리하는 경우]]
		//*********************************************************************************************

	}

}
