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
import com.hwfs.cmn.exception.BizException;
import com.hwfs.cmn.idgen.SequenceIdGenService;
import com.hwfs.sc.cmn.sap.EAIResponse;
import com.hwfs.sc.cmn.sap.dto.BankAcctNoRequestDTO;
import com.hwfs.sc.cmn.sap.list.BankAcctNoRequestList;
import com.hwfs.sc.cmn.sap.service.EAIService;
import com.hwfs.sc.cmn.service.AddrSearchService;
import com.hwfs.sc.scz.dao.UpjangMgmtDAO;
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
@Service("/sc/scz/upjangMgmtService")
public class UpjangMgmtServiceImpl extends DefaultServiceImpl implements UpjangMgmtService {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** UpjangMgmtDAO Bean 생성 */
	@Resource(name = "/sc/scz/upjangMgmtDAO")
	private UpjangMgmtDAO upjangMgmtDAO;

	@Resource(name="stUpjangSeqGenSequence")
	private SequenceIdGenService stUpjangSeqGenSequence;

	//주소를 처리하기 위한 공통 Service
	@Resource(name = "/sc/cmn/addrSearchService")
	private AddrSearchService addressService;

	@Resource(name="EAIService")
	EAIService eaiService;

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
		return upjangMgmtDAO.selectList(mapParam);
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
		
		return upjangMgmtDAO.selectSaveUpjangList(param);
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
	public List<Map<String, Object>> saveList(DataSetMap list, String sabun) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		boolean isRequest = false;
		List<BankAcctNoRequestDTO> bankList = new ArrayList<BankAcctNoRequestDTO>();
		List<Map<String, Object>> upjangCodeList = new ArrayList<Map<String, Object>>();

		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			Map<String, Object> upjangCode = new HashMap<String, Object>();
			
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			addressService.setAddress(rowData, "addr", sabun);

			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				// 신규 메뉴아이디 생성/적용
				rowData.put("upjang", BigDecimal.valueOf(Long.parseLong(stUpjangSeqGenSequence.getNextStringId().trim())));
				logger.debug(" ★ UPJANG => " + rowData.get("upjang"));

				insRowCnt += upjangMgmtDAO.insert(rowData);

				//upjangMgmtDAO.insertScoUpjangMst(rowData);

				//if (rowData.containsKey("shopTypCd") && "02".equals(rowData.get("shopTypCd"))) {
				//	upjangMgmtDAO.insertFmsUpjang(rowData);
				//}
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
				
				updRowCnt += upjangMgmtDAO.update(rowData);
			}

			//[[ 가상계좌를 신청한다.
			if (rowData.containsKey("bankAcctNoRequestYn") && "Y".equals(rowData.get("bankAcctNoRequestYn")) && "02".equals(rowData.get("shopTypCd"))) {
				Record r = upjangMgmtDAO.selectExistsVirtureBankAcctNo(rowData);
				
				if (r != null && r.size() > 0 && r.getInt("cnt") == 0) {
					BankAcctNoRequestDTO bankDto = new BankAcctNoRequestDTO();
					bankDto.setCcCd(rowData.get("ccCd").toString());
					bankDto.setCustCd(rowData.get("sapCustCd").toString());
					bankDto.setUpjangCd(BigDecimal.valueOf(Long.valueOf(rowData.get("upjang").toString())));
					bankDto.setUpjangNm(rowData.get("upjangnm").toString());
					bankList.add(bankDto);
					isRequest = true;
				}
			}
			//가상계좌를 신청한다. ]]
			upjangCode.put("upjang", rowData.get("upjang"));
			upjangCodeList.add(upjangCode);
		}

		if (isRequest) {
			BankAcctNoRequestList requestList = new BankAcctNoRequestList();
			requestList.setDataList(bankList);
			EAIResponse res = eaiService.call(requestList);

			if (!res.isSuccess()) {
				BizException be = new BizException("가상계좌 신청시 오류가 발생했습니다.");
				throw be;
			}
		}

		return upjangCodeList;
	}
	
	public RecordSet selectIncludeCS(Map<String, Object> mapParam) throws Exception {
		return upjangMgmtDAO.selectIncludeCS(mapParam);
	}
	
}
