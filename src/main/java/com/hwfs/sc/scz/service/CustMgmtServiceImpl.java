package com.hwfs.sc.scz.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

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
import com.hwfs.sc.scz.dao.CustMgmtDAO;
import com.hwfs.sc.scz.dao.CustRequestDAO;

 /**
 * 거래처 정보를 관리하는 CustMgmt Service Implementation
 *
 * @ClassName CustMgmtServiceImpl.java
 * @Description CustMgmtServiceImpl Class
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
@Service("/sc/scz/custMgmtService")
public class CustMgmtServiceImpl extends DefaultServiceImpl implements CustMgmtService {

	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** CustMgmtDAO Bean 생성 */
	@Resource(name = "/sc/scz/custMgmtDAO")
	private CustMgmtDAO custMgmtDAO;

	@Resource(name = "scCustRequestSeqGenSequence")
	private SequenceIdGenService scCustRequestSeqGenSequence;

	@Resource(name = "/sc/scz/custRequestDAO")
	private CustRequestDAO custRequestDAO;

	@Resource(name="EAIService")
	EAIService eaiService;

	@Resource(name="/sc/cmn/custInchargeService")
	private CustInchargeService custInchargeService;

	//주소를 처리하기 위한 공통 Service
	@Resource(name = "/sc/cmn/addrSearchService")
	private AddrSearchService addressService;

	/**
	 * 거래처 정보 목록을 조회한다.
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
		return custMgmtDAO.selectList(mapParam);
	}

	/**
	 * 선택된 거래처에 대한 정보를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.scz.service.CustMgmtService#selectCustInfo(java.util.Map)
	*/
	public Map<String, RecordSet> selectCustInfo(Map<String, Object> mapParam) throws Exception {
		Map<String, RecordSet> rtn = new HashMap<String, RecordSet>();

		rtn.put("inchargeList", custMgmtDAO.selectCustInchargeList(mapParam));

		return rtn;
	}

	/**
	 * Full 사업자번호에 대하여 거래처 정보를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.scz.service.CustMgmtService#selectCustInfo(java.util.Map)
	*/
	public Map<String, RecordSet> selectCheckCust(Map<String, Object> mapParam) throws Exception {
		Map<String, RecordSet> rtn = new HashMap<String, RecordSet>();

		RecordSet rs = custMgmtDAO.selectStCust(mapParam);

		if (rs.size() < 1)
			rs = custMgmtDAO.selectSapCust(mapParam);

		RecordSet rsHlevelCust = custMgmtDAO.selectHlevelCust(mapParam);

		rtn.put("custInfo", rs);
		rtn.put("hlevelCust", rsHlevelCust);

		return rtn;
	}

	/**
	 * 거래처 정보 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public Map<String, Object> saveList(DataSetMap list, DataSetMap inchargeList, String sabun, String muCd) throws Exception {
		Map<String, Object> rtn = new HashMap<String, Object>();
		Map<String, Object> requestData = new HashMap<String, Object>();

		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String requestNum = "";

		if (list.size() > 0) {
			int i = 0;
			Map<String, Object> rowData = list.get(i);

			//강제로 없는 경우는 국내거래처로 간주한다.
			if ("".equals(rowData.get("custGrpCd").toString())) {
				rowData.put("custGrpCd", "1000");
			}

			//국내 거래처
			if ("1000".equals(rowData.get("custGrpCd").toString())) {
				//전화번호 가공
				if (rowData.containsKey("telNo1") && rowData.containsKey("telNo2") && rowData.containsKey("telNo3")) rowData.put("telNoEnc", rowData.get("telNo1").toString()+rowData.get("telNo2").toString()+rowData.get("telNo3").toString());
				//팩스번호 가공
				if (rowData.containsKey("faxNo1") && rowData.containsKey("faxNo2") && rowData.containsKey("faxNo3")) rowData.put("faxNoEnc", rowData.get("faxNo1").toString()+rowData.get("faxNo2").toString()+rowData.get("faxNo3").toString());
				//Full사업자번호 가공
				if (rowData.containsKey("saupno")) {
					requestData.put("bsnNo", rowData.get("saupno"));
					if (rowData.containsKey("subUpjangNum")) {
						requestData.put("subUpjangNum", rowData.get("subUpjangNum"));
						rowData.put("fullBsnNo", rowData.get("saupno").toString()+rowData.get("subUpjangNum").toString());
						requestData.put("fullBsnNo", rowData.get("saupno").toString()+rowData.get("subUpjangNum").toString());
					}
					else {
						requestData.put("subUpjangNum", "0000");
						rowData.put("fullBsnNo", rowData.get("saupno").toString()+"0000");
						requestData.put("fullBsnNo", rowData.get("saupno").toString()+"0000");
					}
				}

				addressService.setAddress(rowData, "addr", sabun);
			}
			//해외거래처
			else if ("5000".equals(rowData.get("custGrpCd").toString())) {
				//전화번호 가공
				if (rowData.containsKey("telNo")) rowData.put("telNoEnc", rowData.get("telNo").toString());
				//팩스번호 가공
				if (rowData.containsKey("faxNo")) rowData.put("faxNoEnc", rowData.get("faxNo").toString());
			}
			//개인
			else if ("6000".equals(rowData.get("custGrpCd").toString())) {
				//전화번호 가공
				if (rowData.containsKey("telNo1") && rowData.containsKey("telNo2") && rowData.containsKey("telNo3")) rowData.put("telNoEnc", rowData.get("telNo1").toString()+rowData.get("telNo2").toString()+rowData.get("telNo3").toString());
				//핸드폰번호 가공
				if (rowData.containsKey("hpNo1") && rowData.containsKey("hpNo2") && rowData.containsKey("hpNo3")) rowData.put("handPhoneEnc", rowData.get("hpNo1").toString()+rowData.get("hpNo2").toString()+rowData.get("hpNo3").toString());

				addressService.setAddress(rowData, "addr", sabun);
			}

			//해외거래처 및 개인인 경우에는 사업자번호 및 종사업장 번호, Full사업자번호를 Clear한다.
			if (!"1000".equals(rowData.get("custGrpCd").toString())) {
				rowData.put("fullBsnNo", "");
				rowData.put("saupno", "");
				rowData.put("subUpjangNum", "");
			}

			if ("Y".equals(rowData.get("requestSapYn").toString())) {
				rowData.put("procType", "2");
				rowData.put("procResult", "R");
				requestNum = scCustRequestSeqGenSequence.getNextStringId().trim();
				rowData.put("custRequestNum", requestNum);
			}

			updRowCnt += custMgmtDAO.update(rowData);

			//SAP에 요청을 한다.
//			if ("Y".equals(rowData.get("requestSapYn").toString())) {
//				requestData.put("requestNum", requestNum);
//				requestData.put("procResult", "R");
//				requestData.put("muCd", muCd);
//
//				if (rowData.containsKey("custGrpCd")) requestData.put("custGrp", rowData.get("custGrpCd"));
//				if (rowData.containsKey("custtype")) requestData.put("custType", rowData.get("custtype"));
//				if (rowData.containsKey("custgubun")) requestData.put("custClass", rowData.get("custgubun"));
//				if (rowData.containsKey("custnm")) requestData.put("custNm", rowData.get("custnm"));
//				if (rowData.containsKey("custCorpNm")) requestData.put("custCorpNm", rowData.get("custCorpNm"));
//				if (rowData.containsKey("bubinno")) requestData.put("corpNum", rowData.get("bubinno"));
//				if (rowData.containsKey("idNoEnc")) requestData.put("idNoEnc", rowData.get("idNoEnc"));
//				if (rowData.containsKey("frgnCustCd")) requestData.put("frgnCustNum", rowData.get("frgnCustCd"));
//				if (rowData.containsKey("postNo")) requestData.put("zipCode", rowData.get("postNo"));
//				if (rowData.containsKey("baseAddr")) requestData.put("addr", rowData.get("baseAddr"));
//				if (rowData.containsKey("detailAddr")) requestData.put("detailAddrEnc", rowData.get("detailAddr"));
//				if (rowData.containsKey("telNoEnc")) requestData.put("telNumEnc", rowData.get("telNoEnc"));
//				if (rowData.containsKey("faxNoEnc")) requestData.put("faxNumEnc", rowData.get("faxNoEnc"));
//				if (rowData.containsKey("handPhoneEnc")) requestData.put("handPhoneEnc", rowData.get("handPhoneEnc"));
//				if (rowData.containsKey("emailAddr")) requestData.put("emailAddrEnc", rowData.get("emailAddr"));
//				if (rowData.containsKey("drname1")) requestData.put("ceoHangulName", rowData.get("drname1"));
//				if (rowData.containsKey("drname2")) requestData.put("ceoEnglishName", rowData.get("drname2"));
//				if (rowData.containsKey("ceoIdNoEnc")) requestData.put("ceoIdNoEnc", rowData.get("ceoIdNoEnc"));
//				if (rowData.containsKey("upJong")) requestData.put("bizCat", rowData.get("upJong"));
//				if (rowData.containsKey("upTae")) requestData.put("bizType", rowData.get("upTae"));
//				if (rowData.containsKey("nationCd")) requestData.put("nationCd", rowData.get("nationCd"));
//				if (rowData.containsKey("currencyCd")) requestData.put("currencyCd", rowData.get("currencyCd"));
//				if (rowData.containsKey("elctnTaxBillYn")) requestData.put("elctnTaxBillYn", rowData.get("elctnTaxBillYn"));
//				if (rowData.containsKey("vatCustgubun")) requestData.put("vatType", rowData.get("vatCustgubun"));
//				if (rowData.containsKey("chgReason")) requestData.put("requestReason", rowData.get("chgReason"));
//				if (rowData.containsKey("inspectType")) requestData.put("inspectType", rowData.get("inspectType"));
//				if (rowData.containsKey("procType")) requestData.put("procType", rowData.get("procType"));
//				if (rowData.containsKey("custcd")) requestData.put("custCd", rowData.get("custcd"));
//				if (rowData.containsKey("hlevelCustCd")) requestData.put("hlevelCustCd", rowData.get("hlevelCustCd"));
//				if (rowData.containsKey("sapCustCd")) requestData.put("sapCustCd", rowData.get("sapCustCd"));
//				if (rowData.containsKey("arPayPossYn")) requestData.put("arPayPossYn", rowData.get("arPayPossYn"));
//				if (rowData.containsKey("custAcctCd")) requestData.put("acctCd", rowData.get("custAcctCd"));
//				if (rowData.containsKey("custPayCond")) requestData.put("payCond", rowData.get("custPayCond"));
//				if (rowData.containsKey("vendorAcctCd")) requestData.put("vendorAcctCd", rowData.get("vendorAcctCd"));
//				if (rowData.containsKey("vendorPayCond")) requestData.put("vendorPayCond", rowData.get("vendorPayCond"));
//				if (rowData.containsKey("addrKey")) requestData.put("addrKey", rowData.get("addrKey"));
//
//				insRowCnt += custRequestDAO.insertSccCustRequest(requestData);
//
//				Record rc = custRequestDAO.selectSapRequest(requestData);
//
//				CustomerRequestTable ct = new CustomerRequestTable();
//				ct.setParameter(rc);
//
//				CustomerRequestBuInfoTable cbt = new CustomerRequestBuInfoTable();
//
//				cbt.addParameter("sysCd", "IFC");
//				cbt.addParameter("requestNum", requestNum);
//				cbt.addParameter("buCd", "2000");
//
//				//매입처
//				if ("001".equals(requestData.get("custClass").toString())) {
//					cbt.addParameter("vendorCreationYn", "Y");
//					cbt.addParameter("vendorAcctCd", requestData.get("vendorAcctCd"));
//					cbt.addParameter("vendorPayCond", requestData.get("vendorPayCond"));
//					cbt.addParameter("custCreationYn", "N");
//					cbt.addParameter("custAcctCd", "");
//					cbt.addParameter("custPayCond", "");
//				}
//				//매출처
//				else if ("002".equals(requestData.get("custClass").toString())) {
//					cbt.addParameter("custCreationYn", "Y");
//					cbt.addParameter("custAcctCd", requestData.get("acctCd"));
//					cbt.addParameter("custPayCond", requestData.get("payCond"));
//					cbt.addParameter("vendorCreationYn", "N");
//					cbt.addParameter("vendorAcctCd", "");
//					cbt.addParameter("vendorPayCond", "");
//				}
//				//매입/매출처
//				else if ("003".equals(requestData.get("custClass").toString())) {
//					cbt.addParameter("custCreationYn", "Y");
//					cbt.addParameter("custAcctCd", requestData.get("acctCd"));
//					cbt.addParameter("custPayCond", requestData.get("payCond"));
//					cbt.addParameter("vendorCreationYn", "Y");
//					cbt.addParameter("vendorAcctCd", requestData.get("vendorAcctCd"));
//					cbt.addParameter("vendorPayCond", requestData.get("vendorPayCond"));
//				}
//
//				cbt.addParameter("picode", "FI-002-02");
//				cbt.addParameter("pistat", "R");
//
//				EAIResponse res = eaiService.call(ct);
//
//				if (res.isSuccess()) {
//					Map<String, Object> requestStatus = new HashMap<String, Object>();
//					requestStatus.put("requestNum", requestNum);
//
//					eaiService.call(cbt);
//					//custRequestDAO.updateSapRequestStatus(requestStatus);
//				}
//				else {
//					throw new BizException("SAP에 거래처 요청시 오류가 발생하였습니다.");
//				}
//			}
		}

		custInchargeService.saveList(inchargeList);

		rtn.put("procCnt", insRowCnt + updRowCnt + delRowCnt);

		return rtn;
	}
	
	/**
	 * Full 사업자번호에 대하여 거래처 정보를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.scz.service.CustMgmtService#selectCustInfo(java.util.Map)
	*/
	public Map<String, RecordSet> searchAddrCnt(Map<String, Object> mapParam) throws Exception {
		Map<String, RecordSet> rtn = new HashMap<String, RecordSet>();

		RecordSet rs = custMgmtDAO.searchAddrCnt(mapParam);

		rtn.put("addrKey", rs);

		return rtn;
	}
}
