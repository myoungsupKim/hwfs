package com.hwfs.sm.stm.service;

import hone.core.util.record.RecordSet;
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
import org.springframework.util.StringUtils;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.util.DateUtil;
import com.hwfs.cmn.util.StringUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.sap.EAIListMap;
import com.hwfs.sc.cmn.sap.EAIResponse;
import com.hwfs.sc.cmn.sap.dto.ElctnTaxShetAppendDTO;
import com.hwfs.sc.cmn.sap.dto.ElctnTaxShetHdrDTO;
import com.hwfs.sc.cmn.sap.dto.ElctnTaxShetItemDTO;
import com.hwfs.sc.cmn.sap.dto.ElctnTaxShetPublishDTO;
import com.hwfs.sc.cmn.sap.dto.ElctnTaxShetStatusSendDTO;
import com.hwfs.sc.cmn.sap.list.ElctnTaxShetAppendList;
import com.hwfs.sc.cmn.sap.list.ElctnTaxShetHdrList;
import com.hwfs.sc.cmn.sap.list.ElctnTaxShetItemList;
import com.hwfs.sc.cmn.sap.list.ElctnTaxShetPublishList;
import com.hwfs.sc.cmn.sap.list.ElctnTaxShetStatusSendList;
import com.hwfs.sc.cmn.sap.service.EAIService;
import com.hwfs.sm.stm.dao.TaxInvoiceMgntHqDAO;

 /**
 * 세금계산서 발행을 관리하는 TaxInvoiceMgntHq Service Implementation
 * 
 * @ClassName TaxInvoiceMgntHqServiceImpl.java
 * @Description TaxInvoiceMgntHqServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.10    Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.06.10
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/stm/taxInvoiceMgntHqService")
public class TaxInvoiceMgntHqServiceImpl extends DefaultServiceImpl implements TaxInvoiceMgntHqService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** TaxInvoiceMgntHqDAO Bean 생성 */
	@Resource(name = "/sm/stm/taxInvoiceMgntHqDAO")
	private TaxInvoiceMgntHqDAO taxInvoiceMgntHqDAO;
	
	@Resource(name="EAIService")
	EAIService eaiService;

	/**
	 * 세금계산서 발행(본사용) 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return taxInvoiceMgntHqDAO.selectList(mapParam);
	}

	/**
	 * 세금계산서 발행(본사용) DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveTaxInvoice(DataSetMap taxShetMst, DataSetMap taxShetDtl, DataSetMap taxShetOccurObj) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		Map<String, Object> taxShetMstMap = taxShetMst.get(0);
		
		//세금계산서 일련번호 생성
		String taxShetNum = (String)taxInvoiceMgntHqDAO.selectTaxShetNum(taxShetMstMap);
		taxShetMstMap.put("taxShetNum", taxShetNum);
		
		//세금계산서 마스터 등록
		insRowCnt = taxInvoiceMgntHqDAO.insertTaxShetMst(taxShetMstMap);
		
		//세금계산서 상세 등록
		for(int i=0; i<taxShetDtl.size(); i++){
			Map<String, Object> rowData = taxShetDtl.get(i);
			rowData.put("taxShetNum", taxShetNum);
			String fiscalDate = (String)taxShetMstMap.get("fiscalDate");
			String itemSupplyDateMM = (String)rowData.get("itemSupplyDateMM");
			String itemSupplyDateDD = (String)rowData.get("itemSupplyDateDD");
			rowData.put("itemSupplyDate", fiscalDate.substring(0, 4)+itemSupplyDateMM+itemSupplyDateDD);
			
			insRowCnt = taxInvoiceMgntHqDAO.insertTaxShetDetail(rowData);
		}
		
		//세금계산서 발행대상 등록
		for(int j=0; j<taxShetOccurObj.size(); j++){
			Map<String, Object> rowData2 = taxShetOccurObj.get(j);
			rowData2.put("taxShetNum", taxShetNum);
			
			insRowCnt = taxInvoiceMgntHqDAO.insertTaxShetOccurObj(rowData2);
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 신고사업장 정보, 고객 정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUpjangInfo(Map<String, Object> mapParam) throws Exception {
		//신고사업장정보 검색
		if(mapParam.get("schGb").equals("upjang")){
			mapParam.put("fullSaupno", (String)mapParam.get("saupno")+mapParam.get("subUpjangNum"));
			return taxInvoiceMgntHqDAO.selectNewhghtUpjangInfo(mapParam);
		}
		
		//고객정보 검색
		return taxInvoiceMgntHqDAO.selectCustInfo(mapParam);
	}
	
	/**
	 * 
	 * 세금계산서 발행 상세 목록을 검색한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectTaxShetDetailList(Map<String, Object> mapParam) throws Exception {
		return taxInvoiceMgntHqDAO.selectTaxShetDetailList(mapParam);
	}
	
	/**
	 * 
	 * 최근 신고사업장 담당자 정보 또는 최근 고객 담당자 정보를 검색한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectInchargeInfo(Map<String, Object> mapParam) throws Exception {
		return taxInvoiceMgntHqDAO.selectInchargeInfo(mapParam);
	}
	
	/**
	 * 세금계산서 발행(본사용) 데이터를 삭제한다.
	 *
	 * @return 처리건수
	 * @throws Exception
	*/
	public int deleteTaxInvoice(DataSetMap list) throws Exception {
		
		int delRowCnt = 0; 
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			delRowCnt = taxInvoiceMgntHqDAO.deleteTaxShetMst(rowData);
			delRowCnt += taxInvoiceMgntHqDAO.deleteTaxShetDtl(rowData);
			delRowCnt += taxInvoiceMgntHqDAO.deleteTaxShetOccurObj(rowData);
		}
		
		return delRowCnt;
	}
	
	/**
	 * 세금계산서 발행(본사용) 데이터를 삭제한다.
	 *
	 * @return 처리건수
	 * @throws Exception
	*/
	public int deleteTaxInvoiceOrgnl(DataSetMap list) throws Exception {
		
		int delRowCnt = 0; 
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			delRowCnt += taxInvoiceMgntHqDAO.deleteTaxShetOccurObjOrgnl(rowData);
		}
		
		return delRowCnt;
	}
	
	/**
	 * 
	 * 세금계산서 요청 상태별 처리
	 *
	 * @param list
	 * @param reqStatus
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> taxInvoiceRequest(DataSetMap list, String reqStatus, LoginDTO loginDto) throws Exception{
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		//발행요청
		if(reqStatus.equals("001")){
			rtnMap = taxShetPublishRequest(list);
			
		//상태변경요청
		}else{
			rtnMap = taxShetStatusChangeRequest(list, reqStatus, loginDto);
		}
		
		return rtnMap;
	}
	
	/**
	 * 
	 * 세금계산서 발행요청
	 *
	 * @param list
	 * @return
	 */
	@SuppressWarnings({ "unchecked" })
	public Map<String, Object> taxShetPublishRequest(DataSetMap list) throws Exception{
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		//HEADER
		List<ElctnTaxShetHdrDTO> headerList = new ArrayList<ElctnTaxShetHdrDTO>();
		ElctnTaxShetHdrList header = new ElctnTaxShetHdrList();
		//APPEND
		List<ElctnTaxShetAppendDTO> appendList = new ArrayList<ElctnTaxShetAppendDTO>();
		ElctnTaxShetAppendList append = new ElctnTaxShetAppendList();
		//ITEM
		List<ElctnTaxShetItemDTO> itemList = new ArrayList<ElctnTaxShetItemDTO>();
		ElctnTaxShetItemList item = new ElctnTaxShetItemList();
		//PUBLISH
		List<ElctnTaxShetPublishDTO> publishList = new ArrayList<ElctnTaxShetPublishDTO>();
		ElctnTaxShetPublishList publish = new ElctnTaxShetPublishList();
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			//TaxShetMst 검색
			RecordSet rsMst = taxInvoiceMgntHqDAO.selectList(rowData);
			//TaxShetDtl 검색
			RecordSet rsDtl = taxInvoiceMgntHqDAO.selectTaxShetDetailList(rowData);
			
			/********************************************************************************************************************
			 ************************************************ 전송 데이터 생성 **************************************************
			 ********************************************************************************************************************/
			/*################################################### HEADER [S] ###################################################*/
			ElctnTaxShetHdrDTO headerDto = new ElctnTaxShetHdrDTO();
			
			headerDto.setTaxShetNum(rsMst.get(0).getString("taxShetNum"));						//세금계산서 번호
			headerDto.setOrgnlTaxShetNum(rsMst.get(0).getString("orgnlTaxShetNum"));			//원본 세금계산서 번호
			if (rsMst.get(0).getString("publishClass").equals("2")){
				headerDto.setTaxShetApprvnum(rsMst.get(0).getString("taxShetApprvNum"));		//세금계산서 승인번호				
				headerDto.setCreationMnbdCd("02");													//생성 주체 코드(01:자사 순발행 발송자료 그룹 ASP 전송 02:타사 역발행 발송자료 그룹 ASP 전송)
				headerDto.setApprvProcClass("03");													//승인 처리 구분(01:정상승인대상 02:강제승인대상 03:관리목적)
			}else{
				headerDto.setTaxShetApprvnum(rsMst.get(0).getString("orgnlTaxShetApprvNum"));		//세금계산서 승인번호				
				headerDto.setCreationMnbdCd("01");													//생성 주체 코드(01:자사 순발행 발송자료 그룹 ASP 전송 02:타사 역발행 발송자료 그룹 ASP 전송)
				headerDto.setApprvProcClass("01");													//승인 처리 구분(01:정상승인대상 02:강제승인대상 03:관리목적)
			}
			headerDto.setDocCd(rsMst.get(0).getString("docCd"));								//문서 코드(01:영수증 02:세금계산서(DEFAULT) 03:입금증 07:거래명세서 08:청구서 99:전자세금계산서 V3.0 데이터)
			headerDto.setTaxShetWriteDate(rsMst.get(0).getString("taxShetWriteDate"));			//세금계산서 작성일자
			headerDto.setTaxShetKind(rsMst.get(0).getString("taxShetKind"));														//세금계산서 종류(01:세금계산서 02:수정세금계산서 03:계산서 04:수정계산서)
			headerDto.setTaxShetClsfi(rsMst.get(0).getString("taxShetClsfi"));					//세금계산서 분류(01:일반 02:영세율 03:위수탁 04:수입 05:영세율 위수탁)
			headerDto.setTaxShetType(rsMst.get(0).getString("taxShetKind")+rsMst.get(0).getString("taxShetClsfi"));				//세금계산서 유형(세금계산서종류+세금계산서분류)
			headerDto.setModifyCd(rsMst.get(0).getString("modifyCd"));					   	    //수정코드
			headerDto.setTaxShetClass(rsMst.get(0).getString("taxShetClass"));					//세금계산서 구분(1:매출 2:매입)
			headerDto.setPublishClass(rsMst.get(0).getString("publishClass"));					//발행구분(1:순발행 2:역발행)
			headerDto.setRcptBillingClass(rsMst.get(0).getString("rcptBillingClass"));			//영수/청구구분(01:영수 02:청구)
			headerDto.setSendcpnyCd("2000");													//송신사 코드
			headerDto.setSendcpnyBizCd("01");													//송신사 사업코드
			headerDto.setSendMtod("01");														//송신 방법(01:실시간 전송(DEFAULT), 02:일괄전송(Client 프로그램 이용 수동 전송))
			headerDto.setSendReqDate(rsMst.get(0).getString("taxShetWriteDate"));				//송신 요청일(DEFAULT 세금계산서 작성일자 정보 입력)
//			headerDto.setIncomeNewhghtNum("A");
//			headerDto.setIncomePackissueSdate("A");
//			headerDto.setIncomePackissueEdate("A");
//			headerDto.setIncomeTotQuantity("A");
			headerDto.setSupplierSubUpjangNum(rsMst.get(0).getString("supplierSubUpjangNum"));	//공급자 종사업장 번호
			headerDto.setRcvrSubUpjangNum(rsMst.get(0).getString("rcvrSubUpjangNum"));			//공급받는자 종사업장 번호
//			headerDto.setTrustSubUpjangNum("A");
			headerDto.setCloseSdate(DateUtil.getYyyymmddhhmmss());								//세금계산서 마감시작일 --확인필요@@@@@
			headerDto.setCloseEdate(DateUtil.getYyyymmddhhmmss());								//세금계산서 마감종료일 --확인필요@@@@@
			headerDto.setSupplierBizNo(rsMst.get(0).getString("supplierBizNo"));				//공급자 사업자등록번호
			headerDto.setSupplierBizNm(rsMst.get(0).getString("supplierBizNm"));				//공급자 사업명
			headerDto.setSupplierCeonm(rsMst.get(0).getString("supplierCeonm"));				//공급자 대표자명
			headerDto.setSupplierAddr(rsMst.get(0).getString("supplierAddr"));					//공급자 주소
			headerDto.setSupplierBizType(rsMst.get(0).getString("supplierBizType"));			//공급자 업태
			headerDto.setSupplierBizCat(rsMst.get(0).getString("supplierBizCat"));				//공급자 업종
			headerDto.setRcvrBizNoClass(rsMst.get(0).getString("rcvrBizNoClass"));				//공급받는자 사업자등록번호 구분(01:사업자등록번호 02:주민등록번호 03:외국인)
			headerDto.setRcvrBizNo(rsMst.get(0).getString("rcvrBizNo"));						//공급받는자 사업자등록번호
			headerDto.setRcvrBizNm(rsMst.get(0).getString("rcvrBizNm"));						//공급받는자 사업명
			headerDto.setRcvrCeonm(rsMst.get(0).getString("rcvrCeonm"));						//공급받는자 대표자명
			headerDto.setRcvrAddr(rsMst.get(0).getString("rcvrAddr"));							//공급받는자 주소
			headerDto.setRcvrBizType(rsMst.get(0).getString("rcvrBizType"));					//공급받는자 업태
			headerDto.setRcvrBizCat(rsMst.get(0).getString("rcvrBizCat"));						//공급받는자 업종
//			headerDto.setTrustBizNo("A");
//			headerDto.setTrustBizNm("A");
//			headerDto.setTrustCeonm("A");
//			headerDto.setTrustAddr("A");
//			headerDto.setTrustBizType("A");
//			headerDto.setTrustBizCat("A");
			headerDto.setSupplierInchargeYn(rsMst.get(0).getString("supplierInchargeYn"));		//공급자 담당자 지정여부
			headerDto.setSupplierInchargeId(rsMst.get(0).getString("supplierInchargeId"));		//공급자 담당자ID
			headerDto.setSupplierInchargeNm(rsMst.get(0).getString("supplierInchargeNm"));		//공급자 담당자명
			headerDto.setSupplierInchargeTel(rsMst.get(0).getString("supplierInchargeTel"));	//공급자 담당자 전화
			headerDto.setSupplierInchargeHp(rsMst.get(0).getString("supplierInchargeHp"));		//공급자 담당자 HP
			headerDto.setSupplierInchargeEmail(rsMst.get(0).getString("supplierInchargeEmail"));//공급자 담당자 이메일
			headerDto.setSupplierInchargeDept(rsMst.get(0).getString("supplierInchargeDept"));	//공급자 담당자 부서
			headerDto.setRcvrInchargeYn(rsMst.get(0).getString("rcvrInchargeYn"));				//공급받는자 담당자 지정여부
			headerDto.setRcvrInchargeId(rsMst.get(0).getString("rcvrInchargeId"));				//공급받는자 담당자ID
			headerDto.setRcvrInchargeNm(rsMst.get(0).getString("rcvrInchargeNm"));				//공급받는자 담당자명
			headerDto.setRcvrInchargeTel(rsMst.get(0).getString("rcvrInchargeTel"));			//공급받는자 담당자 전화
			headerDto.setRcvrInchargeHp(rsMst.get(0).getString("rcvrInchargeHp"));				//공급받는자 담당자 HP
			headerDto.setRcvrInchargeEmail(rsMst.get(0).getString("rcvrInchargeEmail"));		//공급받는자 담당자 이메일
			headerDto.setRcvrInchargeDept(rsMst.get(0).getString("rcvrInchargeDept"));			//공급받는자 담당자 부서
//			headerDto.setRcvrInchargeNm2("A");
//			headerDto.setRcvrInchargeTel2("A");
//			headerDto.setRcvrInchargeHp2("A");
//			headerDto.setRcvrInchargeEmail2("A");
//			headerDto.setRcvrInchargeDept2("A");
//			headerDto.setTrustInchargeYn("A");
//			headerDto.setTrustInchargeId("A");
//			headerDto.setTrustInchargeNm("A");
//			headerDto.setTrustInchargeTel("A");
//			headerDto.setTrustInchargeHp("A");
//			headerDto.setTrustInchargeEmail("A");
//			headerDto.setTrustInchargeDept("A");
			headerDto.setSupplyAmt(rsMst.get(0).getBigDecimal("supplyAmt"));					//공급 금액
			headerDto.setVatAmt(rsMst.get(0).getBigDecimal("vatAmt"));							//부가세 금액
			headerDto.setTotAmt(rsMst.get(0).getBigDecimal("totAmt"));							//합계 금액
			headerDto.setTaxShetRemark(rsMst.get(0).getString("taxShetRemark"));
			if(!StringUtil.isNull(rsMst.get(0).getString("signMtodcdCash"))){
				headerDto.setSignMtodcdCash(rsMst.get(0).getString("signMtodcdCash"));						//결제방법코드 현금(10)
				headerDto.setSignMtodamtCash(rsMst.get(0).getBigDecimal("signMtodamtCash"));				//결제방법금액 현금
			}
			if(!StringUtil.isNull(rsMst.get(0).getString("signMtodcdMoneyCheck"))){
				headerDto.setSignMtodcdMoneyCheck(rsMst.get(0).getString("signMtodcdMoneyCheck"));			//결제방법코드 수표(20)
				headerDto.setSignMtodamtMoneyCheck(rsMst.get(0).getBigDecimal("signMtodamtMoneyCheck"));	//결제방법금액 수표
			}
			if(!StringUtil.isNull(rsMst.get(0).getString("signMtodcdNotes"))){
				headerDto.setSignMtodcdNotes(rsMst.get(0).getString("signMtodcdNotes"));					//결제방법코드 어음(30)
				headerDto.setSignMtodamtNotes(rsMst.get(0).getBigDecimal("signMtodamtNotes"));				//결제방법금액 어음
			}
			if(!StringUtil.isNull(rsMst.get(0).getString("signMtodcdCrdt"))){
				headerDto.setSignMtodcdCrdt(rsMst.get(0).getString("signMtodcdCrdt"));						//결제방법코드 외상(매출금/미수금)(40)
				headerDto.setSignMtodamtCrdt(rsMst.get(0).getBigDecimal("signMtodamtCrdt"));				//결제방법금액 외상(매출금/미수금)
			}
			headerDto.setEmailDispatchYn(rsMst.get(0).getString("emailDispatchYn"));			//EMAIL 발송여부
			headerDto.setSmsDispatchYn(rsMst.get(0).getString("smsDispatchYn"));				//SMS 발송여부
			if (rsMst.get(0).getString("publishClass").equals("2")){			
				headerDto.setTaxShetXmlData(rsMst.get(0).getString("taxShetXmlData"));				//세금계산서 XML데이터
			}
//			headerDto.setXslNumFilenm("A");
//			headerDto.setVirtualBankAcctNo1("A");
//			headerDto.setVirtualBankAcctNo2("A");
//			headerDto.setVirtualBankAcctNo3("A");
//			headerDto.setVirtualBankAcctNo4("A");
//			headerDto.setVirtualBankAcctNo5("A");
//			headerDto.setReservColumn1("A");
//			headerDto.setReservColumn2("A");
//			headerDto.setReservColumn3("A");
			headerDto.setAppendDocYn("N");														//첨부문서 존재여부
			headerDto.setAppendDocCnt(BigDecimal.valueOf(0));									//첨부문서 카운트
			headerDto.setCurrentDdtt(DateUtil.getYyyymmddhhmmss());								//현재 일시
			headerDto.setBuCd("2000");															//회사 코드
			
			headerList.add(headerDto);
			header.setDataList(headerList);
			/*################################################### HEADER [E] ###################################################*/
			
			
			/*################################################### APPEND [S] ###################################################*/
			ElctnTaxShetAppendDTO appendDto = new ElctnTaxShetAppendDTO();
			
			appendDto.setTaxShetNum(rsMst.get(0).getString("taxShetNum"));				//세금계산서 번호
			appendDto.setDocCd(rsMst.get(0).getString("docCd"));						//문서코드
//			appendDto.setXslNumFilenm("A");
			if (rsMst.get(0).getString("publishClass").equals("2")){			
				appendDto.setTaxShetXmlData(rsMst.get(0).getString("taxShetXmlData"));		//세금계산서 XML데이터
			}

			appendList.add(appendDto);
			append.setDataList(appendList);
			/*################################################### APPEND [E] ###################################################*/
			
			
			/*################################################### ITEM [S] ###################################################*/
			ElctnTaxShetItemDTO itemDto = new ElctnTaxShetItemDTO();
			
			for(int j=0; j<rsDtl.size(); j++){
				itemDto = new ElctnTaxShetItemDTO();
				itemDto.setTaxShetNum(rsDtl.get(j).getString("taxShetNum"));			//세금계산서 번호
				itemDto.setItemSeq(rsDtl.get(j).getBigDecimal("itemSeq"));				//아이템 시퀀스
				itemDto.setItemSupplyDate(rsDtl.get(j).getString("itemSupplyDate"));	//아이템 일자
				itemDto.setItemNm(rsDtl.get(j).getString("itemNm"));					//아이템 명
				itemDto.setItemStand(rsDtl.get(j).getString("itemStand"));				//아이템 규격
				itemDto.setItemQuantity(rsDtl.get(j).getBigDecimal("itemQuantity"));	//아이템 수량
				itemDto.setItemUprice(rsDtl.get(j).getBigDecimal("itemUprice"));		//아이템 단가
				itemDto.setItemSupplyAmt(rsDtl.get(j).getBigDecimal("itemSupplyAmt"));	//아이템 공급가액
				itemDto.setItemVatAmt(rsDtl.get(j).getBigDecimal("itemVatAmt"));		//아이템 세액
				itemDto.setItemRemark(rsDtl.get(j).getString("itemRemark"));			//아이템 비고
				
				itemList.add(itemDto);
			}
			item.setDataList(itemList);
			/*################################################### ITEM [E] ###################################################*/
			
			
			/*################################################### PUBLISH [S] ###################################################*/
			ElctnTaxShetPublishDTO publishDto = new ElctnTaxShetPublishDTO();
			
			publishDto.setTaxShetNum(rsMst.get(0).getString("taxShetNum"));					//세금계산서번호
			publishDto.setPublishSabun1(rsMst.get(0).getString("supplierInchargeId"));		//발행 사번1
			publishDto.setPublishName1(rsMst.get(0).getString("supplierInchargeNm"));		//발행 성명1
			publishDto.setPublishTel1(rsMst.get(0).getString("supplierInchargeTel"));		//발행 전화1
			publishDto.setPublishHp1(rsMst.get(0).getString("supplierInchargeHp"));			//발행 HP1
			publishDto.setPublishEmail1(rsMst.get(0).getString("supplierInchargeEmail"));	//발행 이메일1
			publishDto.setPublishSabun2(rsMst.get(0).getString("supplierInchargeId2"));		//발행 사번2
			publishDto.setPublishName2(rsMst.get(0).getString("supplierInchargeNm2"));		//발행 성명2
			publishDto.setPublishTel2(rsMst.get(0).getString("supplierInchargeTel2"));		//발행 전화2
			publishDto.setPublishHp2(rsMst.get(0).getString("supplierInchargeHp2"));		//발행 HP2
			publishDto.setPublishEmail2(rsMst.get(0).getString("supplierInchargeEmail2"));	//발행 이메일2
			publishDto.setProcUserSabun(rsMst.get(0).getString("regEmpNum"));				//처리자 사번
			
			publishList.add(publishDto);
			publish.setDataList(publishList);
			/*################################################### PUBLISH [E] ###################################################*/
			
		}
		
		EAIListMap map = new EAIListMap();
		map.addEAIList("header", header);		//HEADER
		map.addEAIList("append", append);		//APPEND
		map.addEAIList("item", item);			//ITEM
		map.addEAIList("publish", publish);		//PUBLISH

		EAIResponse res = eaiService.call(map);
		
		if (res.isSuccess()) {
			logger.debug("※※※※※※※※※※ [발행요청] 성공에 대한 처리 ※※※※※※※※※※");
			rtnMap.put("successYn", "Y");
			rtnMap.put("errCode", "");
			rtnMap.put("errMsg", "");
			
			//상태를 변경한다.
			for (int i = 0 ; i < list.size() ; i++) {
				Map<String, Object> rowData = list.get(i);
			
				rowData.put("progressStatus", "001");		//발행예정 전송대기
				taxInvoiceMgntHqDAO.updateTaxProgressStatus(rowData);
			}
		}
		else {
			logger.debug("※※※※※※※※※※ [발행요청] 실패에 대한 처리 ※※※※※※※※※※");
			rtnMap.put("successYn", "N");
			rtnMap.put("errCode", res.getErrorCode());
			rtnMap.put("errMsg", res.getErrorMsg());
		}
		
		return rtnMap;
	}
	
	/**
	 * 
	 * 세금계산서 상태변경 요청
	 *
	 * @param list
	 * @param reqStatus 변경요청할 상태
	 * @return
	 */
	@SuppressWarnings({ "unchecked" })
	public Map<String, Object> taxShetStatusChangeRequest(DataSetMap list, String reqStatus, LoginDTO loginDto) throws Exception{
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		List<ElctnTaxShetStatusSendDTO> sendList = new ArrayList<ElctnTaxShetStatusSendDTO>();
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			//TaxShetMst 검색
			RecordSet rsMst = taxInvoiceMgntHqDAO.selectList(rowData);
			
			/********************************************************************************************************************
			 ************************************************ 전송 데이터 생성 **************************************************
			 ********************************************************************************************************************/
			ElctnTaxShetStatusSendDTO sendDto = new ElctnTaxShetStatusSendDTO();
			
			sendDto.setTaxShetNum((String)rowData.get("taxShetNum"));			//세금계산서번호
			sendDto.setChgRequestDate(DateUtil.getYyyymmddhhmmss());			//상태변경처리요청일시
			sendDto.setWriteDate(rsMst.get(0).getString("taxShetWriteDate"));	//작성일자
			sendDto.setChgRequestCd(reqStatus);									//상태변경요청코드
			sendDto.setSendDdtt(DateUtil.getYyyymmddhhmmss());					//송신일시
			sendDto.setSendStatusCd("0");										//송신상태코드(최초 0으로 세팅하여 입력해야함.0:미전송(default), 1:전송성공, 2:전송실패)
			if(reqStatus.equals("930")){
				sendDto.setSendDetailInfo("INVOICEE," + rowData.get("rcvrInchargeEmail"));										//송신상세정보bind:rcvrInchargeEmail
			}else if(reqStatus.equals("940")){
				sendDto.setSendDetailInfo("INVOICEE," + rowData.get("rcvrInchargeHp"));										//송신상세정보rcvrInchargeHp
			}else{
				sendDto.setSendDetailInfo("");	
			}
//			sendDto.setStatusProcDdtt("");										//상태처리일시
			sendDto.setSendcpnyCd("0005");										//송신사 코드
			sendDto.setSendcpnyBizCd("01");										//송신사 사업코드
			sendDto.setRequesterId(loginDto.getSabun());						//신청자ID
//			sendDto.setCreationDate("");										//생성일자
//			sendDto.setCreationTime("");										//생성시간
//			sendDto.setCreationName("");										//생성성명
//			sendDto.setModifyDate("");											//수정일자
//			sendDto.setModifyTime("");											//수정시간
//			sendDto.setModifyName("");											//수정성명
			
			sendList.add(sendDto);
			
		}
		
		ElctnTaxShetStatusSendList elctnTaxShetStatusSendList = new ElctnTaxShetStatusSendList();
		elctnTaxShetStatusSendList.setDataList(sendList);

		EAIResponse res = eaiService.call(elctnTaxShetStatusSendList);
		
		if (res.isSuccess()) {
			logger.debug("※※※※※※※※※※ [상태변경 요청] 성공에 대한 처리 ※※※※※※※※※※");
			rtnMap.put("successYn", "Y");
			rtnMap.put("errCode", "");
			rtnMap.put("errMsg", "");
			
			//상태를 변경한다.
			for (int i = 0 ; i < list.size() ; i++) {
				Map<String, Object> rowData = list.get(i);
				if(reqStatus.equals("930") || reqStatus.equals("900") || reqStatus.equals("940") || reqStatus.equals("910")){	//상태값 변경은 다른곳에 넣는다.
					rowData.put("reqStatusChange", reqStatus);
				}else{
					rowData.put("reqStatusChange", reqStatus);
					rowData.put("progressStatus", reqStatus);
				}
				taxInvoiceMgntHqDAO.updateTaxProgressStatus(rowData);
			}
			
		}
		else {
			logger.debug("※※※※※※※※※※ [상태변경 요청] 실패에 대한 처리 ※※※※※※※※※※");
			rtnMap.put("successYn", "N");
			rtnMap.put("errCode", res.getErrorCode());
			rtnMap.put("errMsg", res.getErrorMsg());
		}
		
		return rtnMap;
	}
	
	/**
	 * 세금계산서 발행(본사용) DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public Map<String, String> saveConcellation(DataSetMap taxShetMst, DataSetMap taxShetDtl) throws Exception {
		int insRowCnt = 0;
		
		Map<String, String> returnValue = new HashMap<String, String>();
		Map<String, Object> taxShetMstMap = taxShetMst.get(0);
		
		//세금계산서 일련번호 생성
		String taxShetNum = (String)taxInvoiceMgntHqDAO.selectTaxShetNumConcellation(taxShetMstMap);
		taxShetMstMap.put("newtaxShetNum", taxShetNum);
		returnValue.put("concellationTaxNum", taxShetNum);
		
		//세금계산서 마스터 등록
		insRowCnt = taxInvoiceMgntHqDAO.insertConcellation(taxShetMstMap);
		insRowCnt += taxInvoiceMgntHqDAO.insertConcellationDetail(taxShetMstMap);
		
		//수정코드를 가지고 온다.
		String modifyCd = (String) taxShetMstMap.get("modifyCd");
		
		//수정코드 1 (기재사항의 착오 정정) 
		//기재사항 착오정정의 경우만 수장계산서가 두장 나오도록 수정  20161216 맹수영
		//if(!StringUtils.isEmpty(modifyCd) && (modifyCd.equals("01") || modifyCd.equals("02"))){
		if(!StringUtils.isEmpty(modifyCd) && (modifyCd.equals("01")  )){
			//세금계산서 일련번호 생성
			taxShetNum = (String)taxInvoiceMgntHqDAO.selectTaxShetNumConcellation(taxShetMstMap);
			taxShetMstMap.put("newtaxShetNum", taxShetNum);
			returnValue.put("correctionTaxNum", taxShetNum);
			
			int totSupplyAmt = 0;
			int totVatAmt = 0;
			 
			//세금계산서 상세 등록
			if(modifyCd.equals("01")){
				for(int idx=0; idx<taxShetDtl.size(); idx++){
					Map<String, Object> taxShetDtlMap = taxShetDtl.get(idx);
					taxShetDtlMap.put("newtaxShetNum", taxShetNum);
					
					totSupplyAmt += Integer.parseInt(taxShetDtlMap.get("itemSupplyAmt").toString());
					totVatAmt += Integer.parseInt(taxShetDtlMap.get("itemVatAmt").toString());
					
					
					insRowCnt += taxInvoiceMgntHqDAO.insertTaxShetCorrectionDtl(taxShetDtlMap);
				}
			}else if(modifyCd.equals("02")){
				for(int idx=0; idx<taxShetDtl.size(); idx++){
					Map<String, Object> taxShetDtlMap = taxShetDtl.get(idx);
					
					if(StringUtils.isEmpty(taxShetDtlMap.get("chk"))) continue;
					
					taxShetDtlMap.put("newtaxShetNum", taxShetNum);
					
					totSupplyAmt += Integer.parseInt(taxShetDtlMap.get("itemSupplyAmt").toString());
					totVatAmt += Integer.parseInt(taxShetDtlMap.get("itemVatAmt").toString());
					
					
					insRowCnt += taxInvoiceMgntHqDAO.insertTaxShetApplyAmtDtl(taxShetDtlMap);
				}
			}

			int totTotAmt = totSupplyAmt + totVatAmt;
			
			taxShetMstMap.put("supplyAmt", totSupplyAmt);
			taxShetMstMap.put("vatAmt", totVatAmt);
			taxShetMstMap.put("totAmt", totTotAmt);
			
			//세금계산서 마스터 등록
			insRowCnt += taxInvoiceMgntHqDAO.insertTaxShetCorrectionMst(taxShetMstMap);
			insRowCnt += taxInvoiceMgntHqDAO.updateCorrectionObj(taxShetMstMap);
			
		}
		
		returnValue.put("processCnt", Integer.toString(insRowCnt));
		
		
		return returnValue;
	}
	
	/**
	 * 세금계산서 공급 받는자 담당자를 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectInvoiceRcvr(Map<String, Object> mapParam) throws Exception {
		return taxInvoiceMgntHqDAO.selectInvoiceRcvr(mapParam);
	}

	
}
