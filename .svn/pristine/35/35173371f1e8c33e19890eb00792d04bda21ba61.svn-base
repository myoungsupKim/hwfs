package com.hwfs.sm.stm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.stm.dao.TaxInvoiceAutoDAO;
import com.hwfs.sm.stm.dao.TaxInvoiceMgntHqDAO;
import com.tobesoft.xplatform.data.DataSet;
import com.hwfs.sm.stm.dao.TaxInvoiceMgntHqDAO;

 /**
 * 구매 세금계산서 자동 발행하는 TaxInvoiceAuto Service Implementation
 * 
 * @ClassName TaxInvoiceAutoServiceImpl.java
 * @Description TaxInvoiceAutoServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.12.01    김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.12.01
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/stm/taxInvoiceAutoService")
public class TaxInvoiceAutoServiceImpl extends DefaultServiceImpl implements TaxInvoiceAutoService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** TaxInvoiceAutoDAO Bean 생성 */
	@Resource(name = "/sm/stm/taxInvoiceAutoDAO")
	private TaxInvoiceAutoDAO taxInvoiceAutoDAO;
	
	/** TaxInvoiceMgntHqDAO Bean 생성 */
	@Resource(name = "/sm/stm/taxInvoiceMgntHqDAO")
	private TaxInvoiceMgntHqDAO taxInvoiceMgntHqDAO;	
	

	/**
	 * 구매 세금계산서 자동 발행 목록을 조회한다.
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
		return taxInvoiceAutoDAO.selectList(mapParam);
	}

	/**
	 * 구매 세금계산서 자동 발행 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap taxShetMst, DataSetMap taxShetDtl) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		Map<String, Object> taxShetMstMap = taxShetMst.get(0);
		
		
		
		
		for(int i=0; i<taxShetDtl.size(); i++){
			//세금계산서 마스터 등록
			Map<String, Object> rowData = taxShetDtl.get(i);

			//세금계산서 일련번호 생성
			String taxShetNum = (String)taxInvoiceMgntHqDAO.selectTaxShetNum(taxShetMstMap);
			taxShetMstMap.put("taxShetNum", taxShetNum);

			taxShetMstMap.put("fiscalDate", taxShetMstMap.get("publishDate"));
			taxShetMstMap.put("taxShetWriteDate", taxShetMstMap.get("publishDate"));

			taxShetMstMap.put("docCd", "02");
			taxShetMstMap.put("smsDispatchYn", "Y");
			
			taxShetMstMap.put("muCd", rowData.get("muCd"));
			taxShetMstMap.put("ccCd", rowData.get("ccCd"));
			taxShetMstMap.put("upjangCd", rowData.get("upjangCd"));
			taxShetMstMap.put("tmCd", rowData.get("tmCd"));
			taxShetMstMap.put("custCd", rowData.get("custCd"));
			taxShetMstMap.put("sapCustCd", rowData.get("sapCustCd"));

			taxShetMstMap.put("totAmt", rowData.get("totAmt"));
			taxShetMstMap.put("supplyAmt", rowData.get("supplyAmt"));
			taxShetMstMap.put("vatAmt", rowData.get("vatAmt"));

			taxShetMstMap.put("supplierSubUpjangNum", rowData.get("supplierSubUpjangNum"));
			taxShetMstMap.put("rcvrAddr", rowData.get("rcvrAddr"));
			taxShetMstMap.put("rcvrBizNo", rowData.get("rcvrBizNo"));
			taxShetMstMap.put("rcvrSubUpjangNum", rowData.get("rcvrSubUpjangNum"));
			taxShetMstMap.put("rcvrBizNm", rowData.get("rcvrBizNm"));
			taxShetMstMap.put("rcvrCeonm", rowData.get("rcvrCeoNm"));
			taxShetMstMap.put("rcvrBizType", rowData.get("rcvrBizType"));
			taxShetMstMap.put("rcvrBizCat", rowData.get("rcvrBizCat"));
		//	taxShetMstMap.put("supplierInchargeYn", rowData.get("supplierInchargeYn"));
		//	taxShetMstMap.put("supplierInchargeId", rowData.get("supplierInchargeId"));
		//	taxShetMstMap.put("supplierInchargeNm", rowData.get("supplierInchargeNm"));
		//	taxShetMstMap.put("supplierInchargeTel", rowData.get("supplierInchargeTel"));
		//	taxShetMstMap.put("supplierInchargeHp", rowData.get("supplierInchargeHp"));
		//	taxShetMstMap.put("supplierInchargeEmail", rowData.get("supplierInchargeEmail"));
		//	taxShetMstMap.put("supplierInchargeDept", rowData.get("supplierInchargeDept"));
		//	taxShetMstMap.put("supplierInchargeId2", rowData.get("supplierInchargeId2"));
		//	taxShetMstMap.put("supplierInchargeNm2", rowData.get("supplierInchargeNm2"));
		//	taxShetMstMap.put("supplierInchargeTel2", rowData.get("supplierInchargeTel2"));
		//	taxShetMstMap.put("supplierInchargeHp2", rowData.get("supplierInchargeHp2"));
		//	taxShetMstMap.put("supplierInchargeEmail2", rowData.get("supplierInchargeEmail2"));
		//	taxShetMstMap.put("supplierInchargeDept2", rowData.get("supplierInchargeDept2"));
			taxShetMstMap.put("rcvrInchargeYn", rowData.get("rcvrInchargeYn"));
			taxShetMstMap.put("rcvrInchargeId", rowData.get("rcvrInchargeId"));
			taxShetMstMap.put("rcvrInchargeNm", rowData.get("rcvrInchargeNm"));
			taxShetMstMap.put("rcvrInchargeTel", rowData.get("rcvrInchargeTel"));
			taxShetMstMap.put("rcvrInchargeHp", rowData.get("rcvrInchargeHp"));
			taxShetMstMap.put("rcvrInchargeEmail", rowData.get("rcvrInchargeEmail"));
			taxShetMstMap.put("rcvrInchargeDept", rowData.get("rcvrInchargeDept"));
			taxShetMstMap.put("signMtodcdCrdt", rowData.get("signMtodcdCrdt"));
			taxShetMstMap.put("signMtodamtCrdt", rowData.get("signMtodamtCrdt"));

			insRowCnt = taxInvoiceMgntHqDAO.insertTaxShetMst(taxShetMstMap);
			
			
			//세금계산서 상세 등록
			rowData.put("taxShetNum", taxShetNum);
			rowData.put("itemSeq", "1");
			rowData.put("itemNm", "물류매출");
			rowData.put("itemSupplyAmt", taxShetMstMap.get("supplyAmt"));
			rowData.put("itemVatAmt", taxShetMstMap.get("vatAmt"));
			
			rowData.put("itemSupplyDate", taxShetMstMap.get("publishDate"));
			
			insRowCnt = taxInvoiceMgntHqDAO.insertTaxShetDetail(rowData);
			
			//세금계산서 발행대상 등록
			rowData.put("taxBillSeq", "1");
			rowData.put("occurClass", "6");
			rowData.put("occurDate", taxShetMstMap.get("publishDate"));
			rowData.put("amt", taxShetMstMap.get("totAmt"));
			
			insRowCnt = taxInvoiceMgntHqDAO.insertTaxShetOccurObj(rowData);
		}
		
	
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
