package com.hwfs.sc.scz.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.cmn.idgen.SequenceIdGenService;
import com.hwfs.sc.cmn.sap.EAIRequest;
import com.hwfs.sc.cmn.sap.EAIResponse;
import com.hwfs.sc.cmn.sap.request.FixedAssetsRequest;
import com.hwfs.sc.cmn.sap.service.EAIService;
import com.hwfs.sc.cmn.sap.table.CustomerRequestBuInfoTable;
import com.hwfs.sc.cmn.sap.table.CustomerRequestTable;
import com.hwfs.sc.cmn.service.AddrSearchService;
import com.hwfs.sc.cmn.service.CustInchargeService;
import com.hwfs.sc.scz.dao.ContractMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 계약 정보를 관리하는 contractMgmt Service Implementation
 *
 * @ClassName contractMgmtServiceImpl.java
 * @Description contractMgmtServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.17    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.04.17
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scz/contractMgmtService")
public class ContractMgmtServiceImpl extends DefaultServiceImpl implements ContractMgmtService {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** contractMgmtDAO Bean 생성 */
	@Resource(name = "/sc/scz/contractMgmtDAO")
	private ContractMgmtDAO contractMgmtDAO;

	@Resource(name="EAIService")
	EAIService eaiService;

	/**
	 * 계약 정보 목록을 조회한다.
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
		//logger.debug("★★★★★★★★★★ 조회 ★★★★★★★★★★");
		return contractMgmtDAO.selectList(mapParam);
	}
	
	/**
	 * 이자율 정보 조회한다.
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
	public RecordSet selectRateList(Map<String, Object> mapParam) throws Exception {
		return contractMgmtDAO.selectRateList(mapParam);
	}

	/**
	 * 계약 정보 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public Map<String, Object> saveList(DataSetMap list, String sabun, String muCd) throws Exception {
		Map<String, Object> rtn = new HashMap<String, Object>();
		Map<String, Object> requestData = new HashMap<String, Object>();

		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String requestNum = "";

		if (list.size() > 0) {
			int i = 0;
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += contractMgmtDAO.insert(rowData);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				updRowCnt += contractMgmtDAO.update(rowData);
			}
			else if (rowType == DataSet.ROW_TYPE_DELETED){
				delRowCnt += contractMgmtDAO.delete(rowData);
			}
		}


		rtn.put("procCnt", insRowCnt + updRowCnt + delRowCnt);

		return rtn;
	}
	
}

