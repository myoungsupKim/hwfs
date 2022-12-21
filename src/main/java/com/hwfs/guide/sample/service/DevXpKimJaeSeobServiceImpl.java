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
import com.hwfs.guide.sample.dao.DevXpKimJaeSeobDAO;
import com.hwfs.sc.cmn.sap.EAIListMap;
import com.hwfs.sc.cmn.sap.EAIResponse;
import com.hwfs.sc.cmn.sap.dto.ElctnTaxShetAppendDTO;
import com.hwfs.sc.cmn.sap.dto.ElctnTaxShetHdrDTO;
import com.hwfs.sc.cmn.sap.dto.ElctnTaxShetItemDTO;
import com.hwfs.sc.cmn.sap.dto.ElctnTaxShetPublishDTO;
import com.hwfs.sc.cmn.sap.list.ElctnTaxShetAppendList;
import com.hwfs.sc.cmn.sap.list.ElctnTaxShetHdrList;
import com.hwfs.sc.cmn.sap.list.ElctnTaxShetItemList;
import com.hwfs.sc.cmn.sap.list.ElctnTaxShetPublishList;
import com.hwfs.sc.cmn.sap.service.EAIService;

 /**
 * 김재섭이가 테스트를 위해서 개발하는 DevXpKimJaeSeob Service Implementation
 *
 * @ClassName DevXpKimJaeSeobServiceImpl.java
 * @Description DevXpKimJaeSeobServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.19    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.06.19
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/guide/sample/devXpKimJaeSeobService")
public class DevXpKimJaeSeobServiceImpl extends DefaultServiceImpl implements DevXpKimJaeSeobService {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** DevXpKimJaeSeobDAO Bean 생성 */
	@Resource(name = "/guide/sample/devXpKimJaeSeobDAO")
	private DevXpKimJaeSeobDAO devXpKimJaeSeobDAO;

	@Resource(name="EAIService")
	EAIService eaiService;

	/**
	 * 김재섭이 테스트 목록을 조회한다.
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
		return devXpKimJaeSeobDAO.selectList(mapParam);
	}

	/**
	 * 김재섭이 테스트 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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

		ElctnTaxShetHdrDTO headerDto = new ElctnTaxShetHdrDTO();
		List<ElctnTaxShetHdrDTO> headerList = new ArrayList<ElctnTaxShetHdrDTO>();
		ElctnTaxShetHdrList header = new ElctnTaxShetHdrList();

		headerDto.setTaxShetNum("A");
		headerDto.setOrgnlTaxShetNum("A");
		headerDto.setTaxShetApprvnum("A");
		headerDto.setDocCd("A");
		headerDto.setTaxShetWriteDate("A");
		headerDto.setTaxShetKind("A");
		headerDto.setTaxShetClsfi("A");
		headerDto.setTaxShetType("A");
		headerDto.setModifyCd("A");
		headerDto.setTaxShetClass("A");
		headerDto.setPublishClass("A");
		headerDto.setRcptBillingClass("A");
		headerDto.setSendcpnyCd("A");
		headerDto.setSendcpnyBizCd("A");
		headerDto.setCreationMnbdCd("A");
		headerDto.setApprvProcClass("A");
		headerDto.setSendMtod("A");
		headerDto.setSendReqDate("A");
		headerDto.setIncomeNewhghtNum("A");
		headerDto.setIncomePackissueSdate("A");
		headerDto.setIncomePackissueEdate("A");
		headerDto.setIncomeTotQuantity("A");
		headerDto.setSupplierSubUpjangNum("A");
		headerDto.setRcvrSubUpjangNum("A");
		headerDto.setTrustSubUpjangNum("A");
		headerDto.setCloseSdate("A");
		headerDto.setCloseEdate("A");
		headerDto.setSupplierBizNo("A");
		headerDto.setSupplierBizNm("A");
		headerDto.setSupplierCeonm("A");
		headerDto.setSupplierAddr("A");
		headerDto.setSupplierBizType("A");
		headerDto.setSupplierBizCat("A");
		headerDto.setRcvrBizNoClass("A");
		headerDto.setRcvrBizNo("A");
		headerDto.setRcvrBizNm("A");
		headerDto.setRcvrCeonm("A");
		headerDto.setRcvrAddr("A");
		headerDto.setRcvrBizType("A");
		headerDto.setRcvrBizCat("A");
		headerDto.setTrustBizNo("A");
		headerDto.setTrustBizNm("A");
		headerDto.setTrustCeonm("A");
		headerDto.setTrustAddr("A");
		headerDto.setTrustBizType("A");
		headerDto.setTrustBizCat("A");
		headerDto.setSupplierInchargeYn("A");
		headerDto.setSupplierInchargeId("A");
		headerDto.setSupplierInchargeNm("A");
		headerDto.setSupplierInchargeTel("A");
		headerDto.setSupplierInchargeHp("A");
		headerDto.setSupplierInchargeEmail("A");
		headerDto.setSupplierInchargeDept("A");
		headerDto.setRcvrInchargeYn("A");
		headerDto.setRcvrInchargeId("A");
		headerDto.setRcvrInchargeNm("A");
		headerDto.setRcvrInchargeTel("A");
		headerDto.setRcvrInchargeHp("A");
		headerDto.setRcvrInchargeEmail("A");
		headerDto.setRcvrInchargeDept("A");
		headerDto.setRcvrInchargeNm2("A");
		headerDto.setRcvrInchargeTel2("A");
		headerDto.setRcvrInchargeHp2("A");
		headerDto.setRcvrInchargeEmail2("A");
		headerDto.setRcvrInchargeDept2("A");
		headerDto.setTrustInchargeYn("A");
		headerDto.setTrustInchargeId("A");
		headerDto.setTrustInchargeNm("A");
		headerDto.setTrustInchargeTel("A");
		headerDto.setTrustInchargeHp("A");
		headerDto.setTrustInchargeEmail("A");
		headerDto.setTrustInchargeDept("A");
		headerDto.setSupplyAmt(BigDecimal.valueOf(0));
		headerDto.setVatAmt(BigDecimal.valueOf(0));
		headerDto.setTotAmt(BigDecimal.valueOf(0));
		headerDto.setTaxShetRemark("A");
		headerDto.setSignMtodcdCash("A");
		headerDto.setSignMtodcdMoneyCheck("A");
		headerDto.setSignMtodcdNotes("A");
		headerDto.setSignMtodcdCrdt("A");
		headerDto.setSignMtodamtCash(BigDecimal.valueOf(0));
		headerDto.setSignMtodamtMoneyCheck(BigDecimal.valueOf(0));
		headerDto.setSignMtodamtNotes(BigDecimal.valueOf(0));
		headerDto.setSignMtodamtCrdt(BigDecimal.valueOf(0));
		headerDto.setEmailDispatchYn("A");
		headerDto.setSmsDispatchYn("A");
		headerDto.setTaxShetXmlData("A");
		headerDto.setXslNumFilenm("A");
		headerDto.setVirtualBankAcctNo1("A");
		headerDto.setVirtualBankAcctNo2("A");
		headerDto.setVirtualBankAcctNo3("A");
		headerDto.setVirtualBankAcctNo4("A");
		headerDto.setVirtualBankAcctNo5("A");
		headerDto.setReservColumn1("A");
		headerDto.setReservColumn2("A");
		headerDto.setReservColumn3("A");
		headerDto.setAppendDocYn("A");
		headerDto.setAppendDocCnt(BigDecimal.valueOf(0));
		headerDto.setCurrentDdtt("A");
		headerDto.setBuCd("2000");


		headerList.add(headerDto);
		header.setDataList(headerList);

		ElctnTaxShetAppendDTO appendDto = new ElctnTaxShetAppendDTO();
		List<ElctnTaxShetAppendDTO> appendList = new ArrayList<ElctnTaxShetAppendDTO>();
		ElctnTaxShetAppendList append = new ElctnTaxShetAppendList();

		appendDto.setTaxShetNum("A");
		appendDto.setDocCd("A");
		appendDto.setXslNumFilenm("A");
		appendDto.setTaxShetXmlData("A");

		appendList.add(appendDto);
		append.setDataList(appendList);

		ElctnTaxShetItemDTO itemDto = new ElctnTaxShetItemDTO();
		List<ElctnTaxShetItemDTO> itemList = new ArrayList<ElctnTaxShetItemDTO>();
		ElctnTaxShetItemList item = new ElctnTaxShetItemList();

		itemDto.setTaxShetNum("A");
		itemDto.setItemSeq(BigDecimal.valueOf(0));
		itemDto.setItemSupplyDate("A");
		itemDto.setItemNm("A");
		itemDto.setItemStand("A");
		itemDto.setItemQuantity(BigDecimal.valueOf(0));
		itemDto.setItemUprice(BigDecimal.valueOf(0));
		itemDto.setItemSupplyAmt(BigDecimal.valueOf(0));
		itemDto.setItemVatAmt(BigDecimal.valueOf(0));
		itemDto.setItemRemark("A");

		itemList.add(itemDto);
		item.setDataList(itemList);

		ElctnTaxShetPublishDTO publishDto = new ElctnTaxShetPublishDTO();
		List<ElctnTaxShetPublishDTO> publishList = new ArrayList<ElctnTaxShetPublishDTO>();
		ElctnTaxShetPublishList publish = new ElctnTaxShetPublishList();

		publishDto.setTaxShetNum("A");
		publishDto.setPublishSabun1("A");
		publishDto.setPublishName1("A");
		publishDto.setPublishTel1("A");
		publishDto.setPublishHp1("A");
		publishDto.setPublishEmail1("A");
		publishDto.setPublishSabun2("A");
		publishDto.setPublishName2("A");
		publishDto.setPublishTel2("A");
		publishDto.setPublishHp2("A");
		publishDto.setPublishEmail2("A");
		publishDto.setProcUserSabun("A");

		publishList.add(publishDto);
		publish.setDataList(publishList);

		EAIListMap map = new EAIListMap();
		map.addEAIList("header", header);
		map.addEAIList("append", append);
		map.addEAIList("item", item);
		map.addEAIList("publish", publish);

		EAIResponse res = eaiService.call(map);

		if (res.isSuccess()) {
			logger.debug("※※※※※※※※※※ 성공에 대한 처리 ※※※※※※※※※※");
		}
		else {
			logger.debug("※※※※※※※※※※ 실패에 대한 처리 ※※※※※※※※※※");
		}






//		for (int i = 0 ; i < list.size() ; i++) {
//			Map<String, Object> rowData = list.get(i);
//			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
//
//			//Insert 처리
//			if (rowType == DataSet.ROW_TYPE_INSERTED) {
//				insRowCnt += devXpKimJaeSeobDAO.insert(rowData);
//			}
//			//Update 처리
//			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
//				updRowCnt += devXpKimJaeSeobDAO.update(rowData);
//			}
//			//Delete 처리.
//			else if (rowType == DataSet.ROW_TYPE_DELETED) {
//				delRowCnt += devXpKimJaeSeobDAO.delete(rowData);
//			}
//		}

		return insRowCnt + updRowCnt + delRowCnt;
	}
}
