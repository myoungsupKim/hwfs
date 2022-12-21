package com.hwfs.sc.scz.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.idgen.SequenceIdGenService;
import com.hwfs.sc.cmn.dto.EmailDTO;
import com.hwfs.sc.cmn.sap.EAIResponse;
import com.hwfs.sc.cmn.sap.service.EAIService;
import com.hwfs.sc.cmn.sap.table.CustomerRequestBuInfoTable;
import com.hwfs.sc.cmn.sap.table.CustomerRequestTable;
import com.hwfs.sc.cmn.service.AddrSearchService;
import com.hwfs.sc.cmn.service.EmailSendService;
import com.hwfs.sc.scz.dao.CustRequestNewDAO;
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
@Service("/sc/scz/custRequestNewService")
public class CustRequestNewServiceImpl extends DefaultServiceImpl implements CustRequestNewService {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** CustRequestDAO Bean 생성 */
	@Resource(name = "/sc/scz/custRequestNewDAO")
	private CustRequestNewDAO custRequestNewDAO;

	@Resource(name="EAIService")
	EAIService eaiService;

	@Resource(name = "scCustRequestSeqGenSequence")
	private SequenceIdGenService scCustRequestSeqGenSequence;

	@Resource(name="stCustSeqGenSequence")
	private SequenceIdGenService stCustSeqGenSequence;

	//주소를 처리하기 위한 공통 Service
	@Resource(name = "/sc/cmn/addrSearchService")
	private AddrSearchService addressService;

	/** EmailSendService Bean 생성 */
	@Resource(name = "/sc/cmn/emailSendService")
	private EmailSendService emailSendService;

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
		logger.debug("★★★★★★★★★★ Service 호출 ★★★★★★★★★★");
		logger.debug("mapParam : " + mapParam.toString());
		logger.debug("★★★★★★★★★★ Service 호출 ★★★★★★★★★★");

		return custRequestNewDAO.selectList(mapParam);
	}
	
	/**
	 * 결재가 완료된 건을 sap에 요청한다. (스케줄러에 의해서 호출되어진다.)
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.scz.service.CustRequestService#procSapRequest()
	*/
	public int procSapRequest() throws Exception {
		//SAP에 요청한 내역을 처리한다.
		Map<String, Object> mapParam = new HashMap<String, Object>();
		RecordSet rs = custRequestNewDAO.selectSapRequest(mapParam);
		int procCnt = 0;
		
		if (rs != null && rs.size() > 0) {
			for (int i = 0 ; i < rs.size() ; i++) {
				Record r = rs.get(i);
				
				CustomerRequestBuInfoTable t = new CustomerRequestBuInfoTable();
				t.addParameter("sysCd", "IFC");
				t.addParameter("requestNum", r.getString("requestNum"));
				t.addParameter("buCd", "2000");
				t.addParameter("custCreationYn", "Y");
				t.addParameter("picode", "FI-002-02");
				t.addParameter("pistat", "R");
				
				eaiService.call(t);
				
				CustomerRequestTable ct = new CustomerRequestTable();
				ct.setParameter(r);
				EAIResponse res = eaiService.call(ct);

				if (res.isSuccess()) {
					logger.info("### SAP 거래처신청 Request 성공 : " + r.getString("requestNum"));
					custRequestNewDAO.updateProcResult(r);
					
					procCnt++;
				}
				else {
					logger.info("### SAP 거래처신청 Request 에러 : " + r.getString("requestNum"));
				}
				
			}
		}
		
		//SAP에서 전송한 자료를 담당자에게 E-MAIL을 보낸다.
		RecordSet rsMail = custRequestNewDAO.selectMailContent(mapParam);
		
		if (rsMail != null && rsMail.size() > 0) {
			List<EmailDTO> emailList = new ArrayList<EmailDTO>();

			for (int i = 0 ; i < rsMail.size() ; i++) {
				Record r = rsMail.get(i);
				
				if (!"NONE".equals(r.getString("emailAddr"))) {
					EmailDTO emailDTO = new EmailDTO();
					emailDTO.setToEmail(r.getString("emailAddr"));
					emailDTO.setToName(r.getString("nmKor"));
					emailDTO.setSubject(r.getString("mailSubject"));
					emailDTO.setMapContent(r.getString("mailContent"));
					emailDTO.setFromEmail(propertiesService.getString("ems.email.fromEmail", ""));
					emailDTO.setFromName(propertiesService.getString("ems.email.fromName", ""));
					emailDTO.setTrCcId(r.getString("ccCd"));
					emailDTO.setUserId(r.getString("sabun"));
					emailDTO.setDmNo("");
					emailList.add(emailDTO);
				}
				
				custRequestNewDAO.updataMailStatus(r);
			}
			
			emailSendService.saveEmail(emailList);
		}
		
		return procCnt;
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
		RecordSet rs = rsStCust = custRequestNewDAO.selectExistsStCust(parameter);

		if (rs.size() < 1) {

			//2. SCC_SAP_CUST를 검색한다.
			rs = rsSccSapCust = custRequestNewDAO.selectExistsSccSapCust(parameter);

			if (rs.size() < 1) {
				//3. SCC_CUST_REQUEST를 검색한다.
				rs = rsSccCustRequest = custRequestNewDAO.selectExistsSccCustRequest(parameter);

				if (rs.size() < 1) {
					status = "NEW";
				}
				else {
					status = "SCC_CUST_REQUEST";
					rsStCust = custRequestNewDAO.selectExistsStCust(parameter);
					rsSccSapCust = custRequestNewDAO.selectExistsSccSapCust(parameter);
				}
			}
			else {
				status = "SCC_SAP_CUST";

				rsStCust = custRequestNewDAO.selectExistsStCust(parameter);
				rsSccCustRequest = custRequestNewDAO.selectExistsSccCustRequest(parameter);
			}
		}
		else {
			status = "ST_CUST";

			rsSccCustRequest = custRequestNewDAO.selectExistsSccCustRequest(parameter);
			rsSccSapCust = custRequestNewDAO.selectExistsSccSapCust(parameter);
		}

		rtn.put("status", status);
		rtn.put("data", rs);
		rtn.put("dataStCust", rsStCust);
		rtn.put("dataSccCustRequest", rsSccCustRequest);
		rtn.put("dataSccSapCust", rsSccSapCust);

		return rtn;
	}

	/**
	 * 결재 본문정보를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.scz.service.CustRequestService#selectGwContent(java.util.Map)
	*/
	public Map<String, Object> selectGwContent(Map<String, Object> parameter) throws Exception {
		Map<String, Object> rtn = new HashMap<String, Object>();
		rtn.put("title", custRequestNewDAO.selectTitle(parameter));
		rtn.put("user", custRequestNewDAO.selectSendUser(parameter));
		rtn.put("requestNewCust", custRequestNewDAO.selectRequestNewCust(parameter));
		rtn.put("requestChangeCust", custRequestNewDAO.selectRequestChangeCust(parameter));

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
	public List<Map<String, Object>> saveList(DataSetMap list, String sabun) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String requestNumber = "";
		
		List<Map<String, Object>> requestNums = new ArrayList<Map<String,Object>>();

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
				Map<String, Object> reqeustNum = new HashMap<String, Object>();
				//요청번호를 생성한다.
				
				requestNumber = scCustRequestSeqGenSequence.getNextStringId().trim();
				rowData.put("requestNum", requestNumber);

				reqeustNum.put("requestNum", requestNumber);

				//거래처 번호를 생성한다.
				if (!"Y".equals(rowData.get("sapRequestYn").toString())) {
					rowData.put("custCd", BigDecimal.valueOf(Long.parseLong(stCustSeqGenSequence.getNextStringId().trim())));
					reqeustNum.put("procGw", "N");
				}
				else {
					//전자결재에 요청할 신청번호를 생성하여 UI까지 전달한다.
					reqeustNum.put("procGw", "Y");
				}
				
				requestNums.add(reqeustNum);

				insRowCnt += custRequestNewDAO.insertSccCustRequest(rowData);

				//기존에 이미 sap가 생성된 거래처는 즉시 거래처로 인지한다.
				if (!"Y".equals(rowData.get("sapRequestYn").toString())) {
					rowData.put("custCd", BigDecimal.valueOf(Long.parseLong(stCustSeqGenSequence.getNextStringId().trim())));
					
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

					custRequestNewDAO.insertStCust(rowData);
					logger.debug("######### 거래처 생성 End... #########");
				}
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += custRequestNewDAO.update(rowData);
			}
			
			if ("2".equals(rowData.get("procType").toString())) {
				custRequestNewDAO.updataStCust(rowData);
			}
		}
		
		logger.debug("총 거리건수 : " + String.valueOf(insRowCnt+updRowCnt+delRowCnt));

		return requestNums;
	}
	
	/**
	 * 결재ID를 갱신한다.
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.scz.service.CustRequestService#updateGwId(java.util.Map)
	*/
	public int updateGwId(Map<String, Object> parameter) throws Exception {
		return custRequestNewDAO.updateGwId(parameter);
	}
	
	/**
	 * 상신대기건을 취소한다.
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.scz.service.CustRequestNewService#updataUserCancel(java.util.Map)
	*/
	public int updataUserCancel(Map<String, Object> parameter) throws Exception {
		return custRequestNewDAO.updataUserCancel(parameter);
	}
}
