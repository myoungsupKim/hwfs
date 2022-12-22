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
import com.hwfs.cmn.idgen.UUIdGenUtil;
import com.hwfs.sc.cmn.dto.EmailDTO;
import com.hwfs.sc.cmn.sap.EAIResponse;
import com.hwfs.sc.cmn.sap.dto.BankAcctNoRequestDTO;
import com.hwfs.sc.cmn.sap.list.BankAcctNoRequestList;
import com.hwfs.sc.cmn.sap.service.EAIService;
import com.hwfs.sc.cmn.service.AddrSearchService;
import com.hwfs.sc.cmn.service.EmailSendService;
import com.hwfs.sc.scz.dao.UpjangMgmtNewDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 업장의 마스터 정보를 관리하는 UpjangMgmt Service Implementation
 *
 * @ClassName UpjangMgmtServiceImpl.java
 * @Description UpjangMgmtServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.07    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.04.07
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scz/upjangMgmtNewService")
public class UpjangMgmtNewServiceImpl extends DefaultServiceImpl implements UpjangMgmtNewService {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** UpjangMgmtDAO Bean 생성 */
	@Resource(name = "/sc/scz/upjangMgmtNewDAO")
	private UpjangMgmtNewDAO upjangMgmtNewDAO;

	@Resource(name="stUpjangSeqGenSequence")
	private SequenceIdGenService stUpjangSeqGenSequence;

	//주소를 처리하기 위한 공통 Service
	@Resource(name = "/sc/cmn/addrSearchService")
	private AddrSearchService addressService;

	@Resource(name="EAIService")
	EAIService eaiService;

	/** EmailSendService Bean 생성 */
	@Resource(name = "/sc/cmn/emailSendService")
	private EmailSendService emailSendService;

	/**
	 * 업장 마스터 정보 목록을 조회한다.
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
		return upjangMgmtNewDAO.selectList(mapParam);
	}

	@SuppressWarnings("unchecked")
	public RecordSet selectSaveUpjangList(DataSetMap list, Map<String, Object> mapParam) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("maskAuth", mapParam.get("maskAuth"));
		
		List<Object> l = new ArrayList<Object>();
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			l.add(rowData.get("upjang"));
		}
		
		param.put("upjangList", l);
		
		return upjangMgmtNewDAO.selectSaveUpjangList(param);
	}

	/**
	 * 입력한 업장명과 비슷한 업장을 검색한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.scz.service.UpjangMgmtNewService#selectLikeUpjangNm(java.util.Map)
	*/
	public RecordSet selectLikeUpjangNm(Map<String, Object> mapParam) throws Exception {
		return upjangMgmtNewDAO.selectLikeUpjangNm(mapParam);
	}
	
	/**
	 * 업장 마스터 정보 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public List<Map<String, Object>> saveList(DataSetMap list, String sabun, DataSetMap changeLog) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		boolean isRequest = false;
		List<BankAcctNoRequestDTO> bankList = new ArrayList<BankAcctNoRequestDTO>();
		List<Map<String, Object>> upjangCodeList = new ArrayList<Map<String, Object>>();
		String bankAcctRequestYn = "N";
		String oldBankAcctRequestYn = "N";

		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			Map<String, Object> upjangCode = new HashMap<String, Object>();
			
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			addressService.setAddress(rowData, "addr", sabun);

			//[[ 가상계좌를 신청한다.
			if (rowData.containsKey("bankAcctNoRequestYn") && "Y".equals(rowData.get("bankAcctNoRequestYn")) ) {
				bankAcctRequestYn = "Y";
			}
			else {
				bankAcctRequestYn = "N";
			}
			
			if (rowData.containsKey("oldBankAcctNoRequestYn") && "N".equals(rowData.get("oldBankAcctNoRequestYn"))) {
				oldBankAcctRequestYn = "Y";
			}
			else {
				oldBankAcctRequestYn = "N";
			}
			
			if ("Y".equals(bankAcctRequestYn) && "Y".equals(oldBankAcctRequestYn)) {
				upjangCode.put("bankAcctRequestYn", "Y");
				rowData.put("bankAcctProcResult", "1");
			}
			else {
				upjangCode.put("bankAcctRequestYn", "N");
				rowData.put("bankAcctProcResult", "");
			}
			//가상계좌를 신청한다. ]]

			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				if ("Y".equals(bankAcctRequestYn)) {
					upjangCode.put("bankAcctRequestYn", "Y");
					rowData.put("bankAcctProcResult", "1");
				}
				else {
					upjangCode.put("bankAcctRequestYn", "N");
					rowData.put("bankAcctProcResult", "");
				}

				// 신규 메뉴아이디 생성/적용
				rowData.put("upjang", BigDecimal.valueOf(Long.parseLong(stUpjangSeqGenSequence.getNextStringId().trim())));
				logger.debug(" ★ UPJANG => " + rowData.get("upjang"));

				insRowCnt += upjangMgmtNewDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				if (rowData.containsKey("approvalStatusCd") && !"APR".equals(rowData.get("approvalStatus"))) {
					rowData.put("approvalReqDate", "TODAY");
					rowData.put("approvalReqSabun", "LOGIN_SABUN");
					rowData.put("approvalStatusCd", "REQ");
				}
				else {
					rowData.put("approvalReqDate", "");
					rowData.put("approvalReqSabun", "");
					rowData.put("approvalStatusCd", "");
				}
				
				updRowCnt += upjangMgmtNewDAO.update(rowData);
			}
			
			upjangCode.put("upjang", rowData.get("upjang"));
			upjangCodeList.add(upjangCode);
		}
		
		logger.debug("#### 총 처리건수 : " + String.valueOf(insRowCnt+updRowCnt));
		
		//변경이력을 생성한다.
		String changeLogKey = UUIdGenUtil.getUUID().toUpperCase();

		for (int i = 0 ; i < changeLog.size() ; i++) {
			Map<String, Object> rowData1 = changeLog.get(i);
			rowData1.put("logKey", changeLogKey);
			upjangMgmtNewDAO.insertUpjangChngLog(rowData1);
		}
		

		return upjangCodeList;
	}
	
	public Map<String, Object> selectGwContent(Map<String, Object> mapParam) throws Exception {
		Map<String, Object> rtn = new HashMap<String, Object>();
		rtn.put("title", upjangMgmtNewDAO.selectTitle(mapParam));
		rtn.put("user", upjangMgmtNewDAO.selectSendUser(mapParam));
		rtn.put("requestBankAcctNo", upjangMgmtNewDAO.selectRequestBankAcctNo(mapParam));
		//rtn.put("requestChangeCust", custRequestDAO.selectRequestChangeCust(parameter));
		
		return rtn;
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
		return upjangMgmtNewDAO.updateGwId(parameter);
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
		Map<String, Object> mapParam = new HashMap<String, Object>();
		RecordSet rs = upjangMgmtNewDAO.selectSapRequestList(mapParam);
		List<BankAcctNoRequestDTO> bankList = new ArrayList<BankAcctNoRequestDTO>();
		int procCnt = 0;
		
		if (rs != null && rs.size() > 0) {
			for (int i = 0 ; i < rs.size() ; i++) {
				Record r = rs.get(i);

				BankAcctNoRequestDTO bankDto = new BankAcctNoRequestDTO();
				bankDto.setCcCd(r.get("ccCd").toString());
				bankDto.setCustCd(r.get("custCd").toString());
				bankDto.setUpjangCd(BigDecimal.valueOf(Long.valueOf(r.get("upjangCd").toString())));
				bankDto.setUpjangNm(r.get("upjangNm").toString());
				bankList.add(bankDto);
				
				BankAcctNoRequestList requestList = new BankAcctNoRequestList();
				requestList.setDataList(bankList);
				EAIResponse res = eaiService.call(requestList);

				if (res.isSuccess()) {
					logger.info("### SAP 가상계좌 신청 Request 에러 : " + r.getString("upjangCd"));
					upjangMgmtNewDAO.updateSapRequest(r);
				}
				else {
					logger.info("### SAP 가상계좌 신청 Request 에러 : " + r.getString("upjangCd"));
				}
				
				bankList.clear();
			}
		}
		
		//메일을 발송한다.
		RecordSet rsMail = upjangMgmtNewDAO.selectMailContent(mapParam);
		
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
				
				upjangMgmtNewDAO.updataMailStatus(r);
			}
			
			emailSendService.saveEmail(emailList);
		}
		
		
		return procCnt;
	}
	
	public RecordSet selectIncludeCS(Map<String, Object> mapParam) throws Exception {
		return upjangMgmtNewDAO.selectIncludeCS(mapParam);
	}
	
	public int updataUserCancel(Map<String, Object> parameter) throws Exception {
		return upjangMgmtNewDAO.updataUserCancel(parameter);
	}
	
}
