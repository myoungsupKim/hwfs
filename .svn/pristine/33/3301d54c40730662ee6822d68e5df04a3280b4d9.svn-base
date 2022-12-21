package com.hwfs.sc.scz.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.cmn.idgen.SequenceIdGenService;
import com.hwfs.sc.cmn.sap.EAIResponse;
import com.hwfs.sc.cmn.sap.service.EAIService;
import com.hwfs.sc.cmn.sap.table.CustomerRequestBuInfoTable;
import com.hwfs.sc.cmn.sap.table.CustomerRequestTable;
import com.hwfs.sc.cmn.service.AddrSearchService;
import com.hwfs.sc.scz.dao.CustRequestDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 거래처를 신청하는 CustRequest Service Implementation
 *
 * @ClassName CustRequestServiceImpl.java
 * @Description CustRequestServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.29    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.04.29
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scz/custRequestService")
public class CustRequestServiceImpl extends DefaultServiceImpl implements CustRequestService {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** CustRequestDAO Bean 생성 */
	@Resource(name = "/sc/scz/custRequestDAO")
	private CustRequestDAO custRequestDAO;

	@Resource(name="EAIService")
	EAIService eaiService;

	@Resource(name = "scCustRequestSeqGenSequence")
	private SequenceIdGenService scCustRequestSeqGenSequence;

	@Resource(name="stCustSeqGenSequence")
	private SequenceIdGenService stCustSeqGenSequence;

	//주소를 처리하기 위한 공통 Service
	@Resource(name = "/sc/cmn/addrSearchService")
	private AddrSearchService addressService;

	/**
	 * 거래처 신청정보 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return custRequestDAO.selectList(mapParam);
	}

	/**
	 * 등록된 거래처인지를 판별한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.scz.service.CustRequestService#selectExists(java.util.Map)
	*/
	public Map<String, Object> selectExists(Map<String, Object> parameter) throws Exception {
		Map<String, Object> rtn = new HashMap<String, Object>();
		String status = "";
		RecordSet rsStCust = null, rsSccCustRequest = null, rsSccSapCust = null;

		//1. ST_CUST를 검색한다.
		RecordSet rs = rsStCust = custRequestDAO.selectExistsStCust(parameter);

		if (rs.size() < 1) {

			//2. SCC_SAP_CUST를 검색한다.
			rs = rsSccSapCust = custRequestDAO.selectExistsSccSapCust(parameter);

			if (rs.size() < 1) {
				//3. SCC_CUST_REQUEST를 검색한다.
				rs = rsSccCustRequest = custRequestDAO.selectExistsSccCustRequest(parameter);

				if (rs.size() < 1) {
					status = "NEW";
				}
				else {
					status = "SCC_CUST_REQUEST";
					rsStCust = custRequestDAO.selectExistsStCust(parameter);
					rsSccSapCust = custRequestDAO.selectExistsSccSapCust(parameter);
				}
			}
			else {
				status = "SCC_SAP_CUST";

				rsStCust = custRequestDAO.selectExistsStCust(parameter);
				rsSccCustRequest = custRequestDAO.selectExistsSccCustRequest(parameter);
			}
		}
		else {
			status = "ST_CUST";

			rsSccCustRequest = custRequestDAO.selectExistsSccCustRequest(parameter);
			rsSccSapCust = custRequestDAO.selectExistsSccSapCust(parameter);
		}



//		logger.debug("[SCC_CUST_REQUEST]에서 검색을 수행합니다.");
//		RecordSet rs = rsSccCustRequest = custRequestDAO.selectExistsSccCustRequest(parameter);
//
//		if (rs.size() < 1) {
//			//SAP에 등록된 정보를 조회
//			logger.debug("[SCC_SAP_CUST]에서 검색을 수행합니다.");
//			rs = rsSccSapCust = custRequestDAO.selectExistsSccSapCust(parameter);
//
//			if (rs.size() < 1) {
//				//SCC_CUST_REQUEST에 등록된 정보를 조회한다.
//				//logger.debug("[SCC_CUST_REQUEST]에서 검색을 수행합니다.");
//				//rs = custRequestDAO.selectExistsSccCustRequest(parameter);
//				//ST_CUST에 등록된 정보를 조회
//				logger.debug("[ST_CUST]에서 검색을 수행합니다.");
//				rs = rsStCust = custRequestDAO.selectExistsStCust(parameter);
//
//				if (rs.size() < 1) {
//					logger.debug("신규 거래처입니다.");
//					status = "NEW";
//				}
//				else {
//					//logger.debug("[SCC_CUST_REQUEST]에 등록된 거래처입니다.");
//					//status = "SCC_CUST_REQUEST";
//					logger.debug("[ST_CUST]에 등록된 거래처입니다.");
//					status = "ST_CUST";
//
//					rsSccCustRequest = custRequestDAO.selectExistsSccCustRequest(parameter);
//					rsSccSapCust = custRequestDAO.selectExistsSccSapCust(parameter);
//				}
//			}
//			else {
//				logger.debug("[SCC_SAP_CUST]에 등록된 거래처입니다.");
//				status = "SCC_SAP_CUST";
//
//				rsStCust = custRequestDAO.selectExistsStCust(parameter);
//				rsSccCustRequest = custRequestDAO.selectExistsSccCustRequest(parameter);
//			}
//
//		}
//		else {
//			//logger.debug("[ST_CUST]에 등록된 거래처입니다.");
//			//status = "ST_CUST";
//			logger.debug("[SCC_CUST_REQUEST]에 등록된 거래처입니다.");
//			status = "SCC_CUST_REQUEST";
//
//			rsStCust = custRequestDAO.selectExistsStCust(parameter);
//			rsSccSapCust = custRequestDAO.selectExistsSccSapCust(parameter);
//		}


		rtn.put("status", status);
		rtn.put("data", rs);
		rtn.put("dataStCust", rsStCust);
		rtn.put("dataSccCustRequest", rsSccCustRequest);
		rtn.put("dataSccSapCust", rsSccSapCust);

		return rtn;
	}

	/**
	 * 거래처 신청정보 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public String saveList(DataSetMap list, String sabun) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String requestNum = "";

		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			//국내 및 개인인 경우
			if (!"5000".equals(rowData.get("custGrp").toString())) {
				//전화번호 가공
				if (rowData.containsKey("telNo1") && rowData.containsKey("telNo2") && rowData.containsKey("telNo3")) {
					rowData.put("telNumEnc", rowData.get("telNo1").toString()+rowData.get("telNo2").toString()+rowData.get("telNo3").toString());
				}
				//팩스번호 가공
				if (rowData.containsKey("faxNo1") && rowData.containsKey("faxNo2") && rowData.containsKey("faxNo3")) {
					rowData.put("faxNumEnc", rowData.get("faxNo1").toString()+rowData.get("faxNo2").toString()+rowData.get("faxNo3").toString());
				}
				//휴대폰번호 가공
				if (rowData.containsKey("hpNo1") && rowData.containsKey("hpNo2") && rowData.containsKey("hpNo3")) {
					rowData.put("handPhoneEnc", rowData.get("hpNo1").toString()+rowData.get("hpNo2").toString()+rowData.get("hpNo3").toString());
				}

				addressService.setAddress(rowData, "addr", sabun);
			}
			//해외거래처인 경우
			else
			{
				//전화번호 가공
				if (rowData.containsKey("telNo")) {
					rowData.put("telNumEnc", rowData.get("telNo").toString());
				}
				//팩스번호 가공
				if (rowData.containsKey("faxNo")) {
					rowData.put("faxNumEnc", rowData.get("faxNo").toString());
				}
			}

			if ("1000".equals(rowData.get("custGrp").toString())) {
				//FULL사업자번호(사업자번호 + 종사업장번호)
				rowData.put("fullBsnNo", rowData.get("bsnNo").toString()+rowData.get("subUpjangNum").toString());
			}

			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				//요청번호를 생성한다.
				requestNum = scCustRequestSeqGenSequence.getNextStringId().trim();
				rowData.put("requestNum", requestNum);

				//거래처 번호를 생성한다.
				if (!"Y".equals(rowData.get("sapRequestYn").toString())) {
					rowData.put("custCd", BigDecimal.valueOf(Long.parseLong(stCustSeqGenSequence.getNextStringId().trim())));
				}

				insRowCnt += custRequestDAO.insertSccCustRequest(rowData);

				if ("Y".equals(rowData.get("sapRequestYn").toString())) {
					logger.debug("######### SAP Request Start... #########");
					Record rc = custRequestDAO.selectSapRequest(rowData);

					CustomerRequestTable ct = new CustomerRequestTable();
					ct.setParameter(rc);

					CustomerRequestBuInfoTable cbt = new CustomerRequestBuInfoTable();

					cbt.addParameter("sysCd", "IFC");
					cbt.addParameter("requestNum", requestNum);
					cbt.addParameter("buCd", "2000");

					//매입처
					if ("001".equals(rowData.get("custClass").toString())) {
						cbt.addParameter("vendorCreationYn", "Y");
						cbt.addParameter("vendorAcctCd", rowData.get("vendorAcctCd"));
						cbt.addParameter("vendorPayCond", rowData.get("vendorPayCond"));
						cbt.addParameter("custCreationYn", "N");
						cbt.addParameter("custAcctCd", "");
						cbt.addParameter("custPayCond", "");
					}
					//매출처
					else if ("002".equals(rowData.get("custClass").toString())) {
						cbt.addParameter("custCreationYn", "Y");
						cbt.addParameter("custAcctCd", rowData.get("acctCd"));
						cbt.addParameter("custPayCond", rowData.get("payCond"));
						cbt.addParameter("vendorCreationYn", "N");
						cbt.addParameter("vendorAcctCd", "");
						cbt.addParameter("vendorPayCond", "");
					}
					//매입/매출처
					else if ("003".equals(rowData.get("custClass").toString())) {
						cbt.addParameter("custCreationYn", "Y");
						cbt.addParameter("custAcctCd", rowData.get("acctCd"));
						cbt.addParameter("custPayCond", rowData.get("payCond"));
						cbt.addParameter("vendorCreationYn", "Y");
						cbt.addParameter("vendorAcctCd", rowData.get("vendorAcctCd"));
						cbt.addParameter("vendorPayCond", rowData.get("vendorPayCond"));
					}

					cbt.addParameter("picode", "FI-002-02");
					cbt.addParameter("pistat", "R");

					EAIResponse res = eaiService.call(ct);

					if (res.isSuccess()) {
						Map<String, Object> requestStatus = new HashMap<String, Object>();
						requestStatus.put("requestNum", requestNum);

						eaiService.call(cbt);

						custRequestDAO.updateSapRequestStatus(requestStatus);
					}
					else {
						throw new BizException("SAP에 거래처 요청시 오류가 발생하였습니다.");
					}


					logger.debug("######### SAP Request End... #########");
				}
				//거래처(ST_CUST)를 생성한다.
				else {
					logger.debug("######### 거래처 생성 Start... #########");
					//매입처
					if ("001".equals(rowData.get("custClass").toString())) {
						rowData.put("vendorCreationYn", "Y");
						rowData.put("custCreationYn", "N");
						rowData.put("acctCd", "");
						rowData.put("payCond", "");
					}
					//매출처
					else if ("002".equals(rowData.get("custClass").toString())) {
						rowData.put("custCreationYn", "Y");
						rowData.put("vendorCreationYn", "N");
						rowData.put("vendorAcctCd", "");
						rowData.put("vendorPayCond", "");
					}
					//매입/매출처
					else if ("003".equals(rowData.get("custClass").toString())) {
						rowData.put("vendorCreationYn", "Y");
						rowData.put("custCreationYn", "Y");
					}

					custRequestDAO.insertStCust(rowData);
					logger.debug("######### 거래처 생성 End... #########");
				}
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += custRequestDAO.update(rowData);
			}
			////Delete 처리.
			//else if (rowType == DataSet.ROW_TYPE_DELETED) {
			//	delRowCnt += custRequestDAO.delete(rowData);
			//}
		}

		return requestNum; //insRowCnt + updRowCnt + delRowCnt;
	}
}
