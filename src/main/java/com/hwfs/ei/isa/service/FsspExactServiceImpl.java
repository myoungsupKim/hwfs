package com.hwfs.ei.isa.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.hanwha.CustomAnnotaion.CustomAnnotationDefinition;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.output.Format;
import org.jdom2.output.XMLOutputter;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.cmn.idgen.UUIdGenUtil;
import com.hwfs.cmn.util.DateUtil;
import com.hwfs.ei.cmn.RequestUtils;
import com.hwfs.ei.cmn.ResponseData;
import com.hwfs.ei.isa.dao.FsspExactDAO;
import com.hwfs.ei.isa.dao.FsspIrisDAO;
import com.hwfs.ei.isa.dao.FsspOrderDAO;

 /**
 * 특판상품을 정산하는 FsspExact Service Implementation
 * 
 * @ClassName FsspExactServiceImpl.java
 * @Description FsspExactServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.12.07    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : 특판담당 김재섭
 * @since 2015.12.07
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ei/isa/fsspExactService")
public class FsspExactServiceImpl extends DefaultServiceImpl implements FsspExactService {
    @Resource(name="transactionManagerResortfo")
    private PlatformTransactionManager txManager;

	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** FsspExactDAO Bean 생성 */
	@Resource(name = "/ei/isa/fsspExactDAO")
	private FsspExactDAO fsspExactDAO;
	
	/** FsspOrderDAO Bean 생성 */
	@Resource(name = "/ei/isa/fsspOrderDAO")
	private FsspOrderDAO fsspOrderDAO;
	
	@Resource(name = "/ei/isa/fsspIrisDAO")
	private FsspIrisDAO fsspIrisDAO;

	/**
	 * 정산 목록을 조회한다.
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
	@CustomAnnotationDefinition(txId="ISA0201",Description="특판상품 정산내역를 조회한다.")
	public JSONObject selectExact(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.debug("******************************************************************************************************");
		logger.debug("  [[ 특판상품정산내역 조회 - ISA0201 ]]  ");
		logger.debug("* ISA 호출아이디 : " + header.getString("logId"));
		logger.debug("* ISA 호출Parameter : " + data.toString());
		logger.debug("******************************************************************************************************");
		Map<String, Object> parameter = RequestUtils.JSONObject2Map(data.getJSONObject("datas"));
		
		ResponseData res = new ResponseData();
		res.addData("res", fsspExactDAO.selectExact(parameter));

		return res.send();
	}

	/**
	 * 주문내역을 조회한다.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 * @see com.hwfs.ei.isa.service.FsspExactService#selectOrder(org.json.JSONObject, org.json.JSONObject, org.json.JSONObject)
	*/
	@CustomAnnotationDefinition(txId="ISA0202",Description="특판상품 주문내역를 조회한다.")
	public JSONObject selectOrder(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.debug("******************************************************************************************************");
		logger.debug("  [[ 특판상품정산내역 조회 - ISA0202 ]]  ");
		logger.debug("* ISA 호출아이디 : " + header.getString("logId"));
		logger.debug("* ISA 호출Parameter : " + data.toString());
		logger.debug("******************************************************************************************************");
		Map<String, Object> parameter = RequestUtils.JSONObject2Map(data.getJSONObject("datas"));
		
		ResponseData res = new ResponseData();
		
		if (parameter.containsKey("spIds") && !"".equals(parameter.get("spIds").toString())) {
			List<String> spIds = new ArrayList<String>();
			String[] spId = parameter.get("spIds").toString().split(",");
			for (int i = 0 ; i < spId.length ; i++) {
				spIds.add(spId[i]);
			}
			
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("spIds", spIds);
			param.put("brchCd", parameter.get("brchCd"));
			
			res.addData("res", fsspExactDAO.selectOrder(param));
		}
		else {		
			res.addData("res", fsspExactDAO.selectOrder(parameter));
		}

		return res.send();
	}
	
	/**
	 * 주문건을 취소한다.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 * @see com.hwfs.ei.isa.service.FsspExactService#saveOrderCancel(org.json.JSONObject, org.json.JSONObject, org.json.JSONObject)
	*/
	@CustomAnnotationDefinition(txId="ISA0203",Description="특판상품 주문내역을 취소한다.")
	public JSONObject saveOrderCancel(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.debug("******************************************************************************************************");
		logger.debug("  [[ 특판상품주문내역 취소 - ISA0203 ]]  ");
		logger.debug("* ISA 호출아이디 : " + header.getString("logId"));
		logger.debug("* ISA 호출Parameter : " + data.toString());
		logger.debug("******************************************************************************************************");
		
		Map<String, Object> sendData = new HashMap<String, Object>();
		JSONArray datas = data.getJSONArray("datas");
		
		for (int i = 0; i < datas.length() ; i++) {
			Map<String, Object> parameter = RequestUtils.JSONObject2Map(datas.getJSONObject(i));
			
			//필요에 따라서 Validation을 처리한다.
			try {
				fsspExactDAO.updateOrderCancel(parameter);
				sendData.put("statusCd", "S");
				sendData.put("message", "OK");
			}
			catch (Exception ept) {
				sendData.put("statusCd", "F");
				sendData.put("message", ept.getMessage());
				
				throw new BizException(ept.getMessage());
			}
		}
		
		
		ResponseData res = new ResponseData();
		res.addData("res", sendData);

		return res.send();
	}
	
	/**
	 * 주문내역을 변경한다.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 * @see com.hwfs.ei.isa.service.FsspExactService#saveOrderChange(org.json.JSONObject, org.json.JSONObject, org.json.JSONObject)
	*/
	@CustomAnnotationDefinition(txId="ISA0204",Description="특판상품 주문내역을 변경한다.")
	public JSONObject saveOrderChange(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.debug("******************************************************************************************************");
		logger.debug("  [[ 특판상품주문내역 변경 - ISA0204 ]]  ");
		logger.debug("* ISA 호출아이디 : " + header.getString("logId"));
		logger.debug("* ISA 호출Parameter : " + data.toString());
		logger.debug("******************************************************************************************************");
		
		List<Map<String, Object>> sendDatas = new ArrayList<Map<String,Object>>();
		JSONArray datas = data.getJSONArray("datas");
		
		for (int i = 0; i < datas.length() ; i++) {
			Map<String, Object> parameter = RequestUtils.JSONObject2Map(datas.getJSONObject(i));
			Map<String, Object> sendStatus = new HashMap<String, Object>();
			
			//ordQty라는 Key가 없는 경우에는 prQty를 ordQty로 설정한다.
			if (!parameter.containsKey("ordQty")) parameter.put("ordQty", parameter.get("prQty"));
			
			Record r = fsspOrderDAO.selectValidation(parameter);
			
			if ("Y".equals(r.getString("stockYn"))) {
				throw new BizException("주문 가능한 재고가 부족합니다.");
			}
			
			if ("Y".equals(r.getString("lastTimeYn"))) {
				throw new BizException("금일 주문시간이 종료되었습니다.");
			}

			if ("Y".equals(r.getString("lastYn"))) {
				throw new BizException("주문 가능일이 종료되었습니다.");
			}
			
			try {
				fsspExactDAO.updateOrderChange(parameter);
				sendStatus.put("status", "S");
				sendStatus.put("message", "OK");
				
				sendDatas.add(sendStatus);
			}
			catch (Exception ept) {
				sendStatus.put("status", "F");
				sendStatus.put("message", ept.getMessage());
				
				sendDatas.add(sendStatus);
				throw new BizException("주문 변경시 오류가 발생하였습니다.");
			}
		}
		
		ResponseData res = new ResponseData();
		res.addData("res", sendDatas);

		return res.send();
	}
	
	/**
	 * VAN Data를 처리한다.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 * @see com.hwfs.ei.isa.service.FsspExactService#saveVanData(org.json.JSONObject, org.json.JSONObject, org.json.JSONObject)
	*/
	@CustomAnnotationDefinition(txId="ISA0205",Description="특판상품 VAN Data를 처리한다.")
	public JSONObject saveVanData(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.debug("******************************************************************************************************");
		logger.debug("  [[ 특판상품주문내역 결제 - ISA0205 ]]  ");
		logger.debug("* ISA 호출아이디 : " + header.getString("logId"));
		logger.debug("* ISA 호출Parameter : " + data.toString());
		logger.debug("******************************************************************************************************");
		
		Map<String, Object> sendData = new HashMap<String, Object>(); 
		
		JSONObject datas = data.getJSONObject("datas");
		
		//KEY정보
		String vanKey = datas.getString("vanKey");
		String vanRefKey = "";
		boolean isCreate = false;
		//승인내역데이터
		JSONArray vanDatas = datas.getJSONArray("van");		
		//주문내역데이터
		JSONArray orderDatas = datas.getJSONArray("order");
		
		//신규인경우
		if ("NONE".equals(vanKey)) {
			vanKey = UUIdGenUtil.getUUID();
			isCreate = true;
		}
		
		//[[VAN Data는 항상 1건씩만 전송된다.
		Map<String, Object> parameter = RequestUtils.JSONObject2Map(vanDatas.getJSONObject(0));
		parameter.put("vanKey", vanKey);
		
		//취소거래시 기존의 승인거래의 마크를 "C"로 변경한다.
		if (!"승인거래".equals(parameter.get("assignType").toString())) {
			Map<String, Object> markParam = new HashMap<String, Object>();
			markParam.put("vanKey", vanKey);
			markParam.put("vanRefKey", datas.getString("vanRefKey"));
			markParam.put("sabun", parameter.get("sabun"));
			markParam.put("actionMark", "C");
			
			try {
				fsspExactDAO.updateActionMark(markParam);
			}
			catch (Exception ept) {
				logger.debug(ept.toString());
				throw new BizException("승인내역 취소마크시 오류가 발생하였습니다.");
			}
		}
		else {
			Map<String, Object> markParam = new HashMap<String, Object>();
			markParam.put("vanKey", vanKey);
			markParam.put("sabun", parameter.get("sabun"));
			markParam.put("actionMark", "C");
			
			try {
				fsspExactDAO.updateActionMark(markParam);
			}
			catch (Exception ept) {
				logger.debug(ept.toString());
				throw new BizException("승인내역 취소마크시 오류가 발생하였습니다.");
			}
		}
		
		//신규거래 발생
		if ("NONE".equals(parameter.get("vanRefKey"))) {
			vanRefKey = UUIdGenUtil.getUUID();
			parameter.put("vanRefKey", vanRefKey);
			
			try {
				fsspExactDAO.insertVanDetail(parameter);
			}
			catch (Exception ept) {
				logger.debug(ept.toString());
				throw new BizException("[신규] 상세내역 처리시 오류가 발생하였습니다.");
			}
		}
		//기존거래 발생
		else {
			vanRefKey = parameter.get("vanRefKey").toString();
			
			try {
				fsspExactDAO.updateVanDetail(parameter);
			}
			catch (Exception ept) {
				logger.debug(ept.toString());
				throw new BizException("[수정] 상세내역 처리시 오류가 발생하였습니다.");
			}
			
		}
		//VAN Data는 항상 1건씩만 전송된다.]]

		//결제금액과 부가세를 가져온다.
		BigDecimal approvalAmount = BigDecimal.valueOf(Long.valueOf(parameter.get("reqAmt").toString()));
		BigDecimal approvalVat = BigDecimal.valueOf(Long.valueOf(parameter.get("reqVat").toString()));
		BigDecimal approvalSum = approvalAmount.add(approvalVat);
		BigDecimal totalTargetAmount = BigDecimal.ZERO;
		
		//[[주문 상품에 대한 처리
		for (int i = 0 ; i < orderDatas.length() ; i++) {
			Map<String, Object> param = RequestUtils.JSONObject2Map(orderDatas.getJSONObject(i));
			Map<String, Object> newParam = new HashMap<String, Object>();
			
			BigDecimal targetAmount = BigDecimal.valueOf(Long.valueOf(param.get("targetAmount").toString()));
			BigDecimal aprAmt = BigDecimal.ZERO;
			int compareTo = targetAmount.compareTo(approvalSum);
			totalTargetAmount = totalTargetAmount.add(targetAmount);
			
			//[[남아있는 결제금액이 0보다 클때까지....
			if (approvalSum.compareTo(new BigDecimal("0")) == 1) {
				//대상금액이 결제금액보다가 작다.
				if (compareTo == -1) {
					aprAmt = targetAmount;
				}
				//대상금액과 결제금액이 같다.
				else if (compareTo == 0) {
					aprAmt = approvalSum;
				}
				//대상금액이 결제금액보다 크다.
				else if (compareTo == 1) {
					aprAmt = approvalSum;
				}

				approvalSum = approvalSum.subtract(aprAmt);
			
				if (aprAmt.compareTo(new BigDecimal("0")) == 1) {
					newParam.put("sabun", parameter.get("sabun"));
					newParam.put("spId", param.get("spId"));
					newParam.put("aprAmt", ("승인거래".equals(parameter.get("assignType").toString()))?aprAmt:aprAmt.multiply(new BigDecimal("-1")));
					newParam.put("vanKey", vanKey);
					newParam.put("vanRefKey", vanRefKey);
					
					try {
						fsspExactDAO.insertSaleVan(newParam);
					}
					catch (Exception ept) {
						logger.debug(ept.toString());
						throw new BizException("주문내역 처리시 오류가 발생하였습니다.");
					}
				}				
			}
			//남아있는 결제금액이 0보다 클때까지....]]
			
			//주문건에 VAN KEY를 설정한다.(같은 VAN KEY로 묶는다.)
			try {
				Map<String, Object> orderParam = new HashMap<String, Object>();
				orderParam.put("sabun", parameter.get("sabun"));
				orderParam.put("spId", param.get("spId"));
				orderParam.put("vanKey", vanKey);
				
				fsspExactDAO.updateOrderVanKey(orderParam);
			}
			catch (Exception ept) {
				logger.debug(ept.toString());
				throw new BizException("주문내역 수정시 오류가 발생하였습니다.");
			}
		}
		//주문 상품에 대한 처리]]
		
		//[[VAN Master 생성
		String procStatus = ("승인거래".equals(parameter.get("assignType").toString()))?"결제완료":"취소완료";
		if (totalTargetAmount.compareTo(approvalAmount.add(approvalVat)) != 0) {
			procStatus = "처리중";
		}
		
		Map<String, Object> masterParam = new HashMap<String, Object>();
		masterParam.put("vanKey", vanKey);
		masterParam.put("procStatus", procStatus);
		masterParam.put("sabun", parameter.get("sabun"));
		
		//Master가 신규인 경우
		if (isCreate) {
			try {
				fsspExactDAO.insertVanMaster(masterParam);
			}
			catch (Exception ept) {
				logger.debug(ept.toString());
				throw new BizException("[신규] 결제내역 처리시 오류가 발생하였습니다.");
			}
		}
		//Master가 수정인 경우
		else {
			try {
				fsspExactDAO.updateVanMaster(masterParam);
			}
			catch (Exception ept) {
				logger.debug(ept.toString());
				throw new BizException("[수정] 결제내역 처리시 오류가 발생하였습니다.");
			}
		}
		//VAN Master 생성]]
		
		sendData.put("status", "S");
		sendData.put("message", "정상적으로 수행되었습니다.");
		sendData.put("vanKey", vanKey);
		sendData.put("procStatus", procStatus);
		
		ResponseData res = new ResponseData();
		res.addData("res", sendData);

		return res.send();
	}
	
	/**
	 * 승인 상세내역을 조회한다.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 * @see com.hwfs.ei.isa.service.FsspExactService#selectVanDtl(org.json.JSONObject, org.json.JSONObject, org.json.JSONObject)
	*/
	@CustomAnnotationDefinition(txId="ISA0206",Description="특판상품 승인 상세내역을 조회한다.")
	public JSONObject selectVanDtl(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.debug("******************************************************************************************************");
		logger.debug("  [[ 특판상품승인 상세내역 - ISA0206 ]]  ");
		logger.debug("* ISA 호출아이디 : " + header.getString("logId"));
		logger.debug("* ISA 호출Parameter : " + data.toString());
		logger.debug("******************************************************************************************************");
		Map<String, Object> parameter = RequestUtils.JSONObject2Map(data.getJSONObject("datas"));
		
		ResponseData res = new ResponseData();
		res.addData("res", fsspExactDAO.selectVanDtl(parameter));

		return res.send();
	}
	
	/** 
	 * 특판상품 승인별 주문내역을 조회한다.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 * @see com.hwfs.ei.isa.service.FsspExactService#selectSaleVan(org.json.JSONObject, org.json.JSONObject, org.json.JSONObject)
	*/
	@CustomAnnotationDefinition(txId="ISA0207",Description="특판상품 승인별 주문내역을 조회한다.")
	public JSONObject selectSaleVan(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.debug("******************************************************************************************************");
		logger.debug("  [[ 특판상품 결제내역별 주문내역 - ISA0207 ]]  ");
		logger.debug("* ISA 호출아이디 : " + header.getString("logId"));
		logger.debug("* ISA 호출Parameter : " + data.toString());
		logger.debug("******************************************************************************************************");
		Map<String, Object> parameter = RequestUtils.JSONObject2Map(data.getJSONObject("datas"));
		
		ResponseData res = new ResponseData();
		res.addData("res", fsspExactDAO.selectSaleVan(parameter));

		return res.send();
	}
	
	/**
	 * 결제대상 목록에서 제외하기.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 * @see com.hwfs.ei.isa.service.FsspExactService#saveClearOrder(org.json.JSONObject, org.json.JSONObject, org.json.JSONObject)
	*/
	@CustomAnnotationDefinition(txId="ISA0208",Description="특판상품 VAN KEY를 CLEAR한다.")
	public JSONObject saveClearOrder(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.debug("******************************************************************************************************");
		logger.debug("  [[ 특판상품 VAN KEY Clear - ISA0208 ]]  ");
		logger.debug("* ISA 호출아이디 : " + header.getString("logId"));
		logger.debug("* ISA 호출Parameter : " + data.toString());
		logger.debug("******************************************************************************************************");
		Map<String, Object> parameter = RequestUtils.JSONObject2Map(data.getJSONObject("datas"));
		
		try {
			fsspExactDAO.updateOrderVanKey(parameter);
		}
		catch (Exception ept) {
			throw new BizException("결제대상 제외시 오류가 발생하였습니다.");
		}
		
		parameter.put("message", "결제대상 목록에서 제외하였습니다.");
		
		ResponseData res = new ResponseData();
		res.addData("res", parameter);

		return res.send();
	}
	
	@CustomAnnotationDefinition(txId="ISA0209",Description="특판상품 정산을 처리한다.")
	@Transactional(propagation=Propagation.REQUIRED)
	public JSONObject saveExact(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.debug("******************************************************************************************************");
		logger.debug("  [[ 특판상품 정산을 처리 - ISA0209 ]]  ");
		logger.debug("* ISA 호출아이디 : " + header.getString("logId"));
		logger.debug("* ISA 호출Parameter : " + data.toString());
		logger.debug("******************************************************************************************************");
		Map<String, Object> sendData = new HashMap<String, Object>();
		JSONObject datas = data.getJSONObject("datas");
		JSONArray extraData = datas.getJSONArray("extra");
		TransactionStatus txStatus = txManager.getTransaction(new DefaultTransactionDefinition());
		
		BigDecimal totAmount = BigDecimal.ZERO;
		BigDecimal saleAmount = BigDecimal.ZERO;
		BigDecimal dcAmount = BigDecimal.ZERO;
		BigDecimal netAmount = BigDecimal.ZERO;
		BigDecimal vatAmount = BigDecimal.ZERO;
		
		BigDecimal vatTotalAmount = BigDecimal.ZERO;

		int intReceiptNo = 0; //영수증번호(마지막번호+1의 값)
		int totalAmount_Count = 0; //총매출액_건수
		int pureAmount_Count = 0;  //순매출액_건수
		int cashSale_Count = 0;    //현금매출_건수
	    int credit_Count = 0;      //카드_건수
	    int empafter_Count = 0;    //직원후불_건수
	    int vat_Count = 0;         //부가세_건수
		
	    List<Integer> receiptNos = new ArrayList<Integer>();
	    
		BigDecimal totalAmount_Amount = BigDecimal.ZERO; //총매출액_금액
		BigDecimal pureAmount_Amount = BigDecimal.ZERO;  //순매출액_금액
		BigDecimal cashSale_Amount = BigDecimal.ZERO;    //현금매출_금액
		BigDecimal credit_Amount = BigDecimal.ZERO;      //카드_금액
		BigDecimal empafter_Amount = BigDecimal.ZERO;    //직원후불_금액
		BigDecimal vat_Amount = BigDecimal.ZERO;         //부가세_금액
	    
		String rqSabun = "";
		String rqName = "";
		//String tranFlag = "";
		//int lastReceiptNo = 0;
		
		//[[영수증번호 가져오기
		Map<String, Object> mainParameter = new HashMap<String, Object>();
		mainParameter.put("saleDate", datas.get("saleDate"));
		mainParameter.put("brchCd", datas.get("brchCd"));
		mainParameter.put("locCd", datas.get("locCd"));
		mainParameter.put("posNo", datas.get("posNo"));
		mainParameter.put("brchNm", datas.get("brchNm"));
		mainParameter.put("locNm", datas.get("locNm"));
		mainParameter.put("posNm", datas.get("posName"));
		mainParameter.put("sabun", datas.get("sabun"));
		mainParameter.put("userName", datas.get("userName"));

		Record rReceiptNo = fsspExactDAO.selectReceiptNo(mainParameter);
		
		intReceiptNo = rReceiptNo.getInt("intReceiptNo");
		//영수증번호 가져오기]]
		List<String> vanKeys = new ArrayList<String>();
		
		Map<String, Object> tranInfoParameter = new HashMap<String, Object>();
		Map<String, Object> tranItemsParameter;
		Map<String, Object> tranNodeParameter;
		Map<String, Object> tranEmpParameter;
		Map<String, Object> tranTeamParameter;
		Map<String, Object> tranCardParameter;
		Map<String, Object> tranCashParameter;
		
		try {
			for (int i = 0 ; i < extraData.length() ; i++) {
				Map<String, Object> p = RequestUtils.JSONObject2Map(extraData.getJSONObject(i));
				
				if ("1".equals(p.get("chkBox").toString())) {
					totalAmount_Count++; //총매출액_건수
					pureAmount_Count++;  //순매출액_건수
					
					totAmount = BigDecimal.ZERO;
					saleAmount = BigDecimal.ZERO;
					dcAmount = BigDecimal.ZERO;
					netAmount = BigDecimal.ZERO;
					vatAmount = BigDecimal.ZERO;
					
					if (!"2".equals(p.get("payMethod").toString())) {
						intReceiptNo++; //영수증번호 증가 시키기
						receiptNos.add(intReceiptNo);
						//[[Tran Info 처리
						tranInfoParameter = new HashMap<String, Object>();
						tranInfoParameter.putAll(mainParameter);
						tranInfoParameter.put("receiptNo", intReceiptNo);
						tranInfoParameter.put("posOpenSeq", "0");
						tranInfoParameter.put("logFlag", "TranNode");
						tranInfoParameter.put("logFlagNm", "판매");
						
						try {
							fsspExactDAO.insertTranInfo(tranInfoParameter);
						}
						catch (Exception ept) {
							throw new BizException("Tran Info 생성시 오류가 발생하였습니다.("+ept.toString()+")");
						}
						//Tran Info 처리]]
	
						RecordSet rs = fsspExactDAO.selectExactTarget(p);
						
						for (int j = 0 ; j < rs.size() ; j++) {
							Record r = rs.get(j);
							
							if ("1".equals(r.getString("taxFlag"))) {
								vat_Count++; //부가세_건수
								vat_Amount = vat_Amount.add(r.getBigDecimal("taxAmount")); //부가세_금액
							}
							
							//[[Tran Item 처리
							tranItemsParameter = new HashMap<String, Object>();
							tranItemsParameter.putAll(tranInfoParameter);
							
							if ("EXACT_PROCESS".equals(datas.getString("procFlag")) && "Z".equals(p.get("payMethod").toString())) {
								tranItemsParameter.put("tranFlag", "I");
							}
							else if (!"EXACT_PROCESS".equals(datas.getString("procFlag")) && "Z".equals(p.get("payMethod").toString())) {
								tranItemsParameter.put("tranFlag", "V");
							}
							else if ("EXACT_PROCESS".equals(datas.getString("procFlag")) && !"Z".equals(p.get("payMethod").toString())) {
								tranItemsParameter.put("tranFlag", "N");
							}
							else if (!"EXACT_PROCESS".equals(datas.getString("procFlag")) && !"Z".equals(p.get("payMethod").toString())) {
								tranItemsParameter.put("tranFlag", "R");
							}
							
							tranItemsParameter.put("itemFlag", "정정");
							tranItemsParameter.put("itemCode", r.getString("itemCode"));
							tranItemsParameter.put("classCode", r.getString("classCode"));
							tranItemsParameter.put("instoreCode", r.getString("instoreCode"));
							tranItemsParameter.put("itemName", r.getString("itemName"));
							tranItemsParameter.put("price", r.getBigDecimal("price"));
							tranItemsParameter.put("taxFlag", r.getString("taxFlag"));
							
							if ("EXACT_PROCESS".equals(datas.getString("procFlag"))) {
								tranItemsParameter.put("quantity", r.getBigDecimal("quantity"));
								tranItemsParameter.put("cancelQty", new BigDecimal("0"));
							}
							else {
								tranItemsParameter.put("quantity", new BigDecimal("0"));
								tranItemsParameter.put("cancelQty", r.getBigDecimal("cancelQty"));
							}
							
							tranItemsParameter.put("discountFlag", r.getString("discountFlag"));
							tranItemsParameter.put("discountRate", r.getBigDecimal("discountRate"));
							tranItemsParameter.put("discountPrice", r.getBigDecimal("discountPrice"));
							tranItemsParameter.put("discountAmount", r.getBigDecimal("discountAmount"));
							tranItemsParameter.put("originPrice", r.getBigDecimal("originPrice"));
							tranItemsParameter.put("subtotal", r.getBigDecimal("subTotal"));
							tranItemsParameter.put("total", r.getBigDecimal("total"));
							tranItemsParameter.put("taxAmount", r.getBigDecimal("taxAmount"));
							tranItemsParameter.put("freeAmount", r.getBigDecimal("freeAmount"));
							tranItemsParameter.put("currencySign", "1");
							
							try {
								fsspExactDAO.insertTranItems(tranItemsParameter);
							}
							catch (Exception ept) {
								throw new BizException("Tran Items Data를 생성시에 오류가 발생하였습니다.("+ept.toString()+")");
							}
							//Tran Item 처리]]
	
							rqSabun = r.getString("empNumber");
							rqName = r.getString("empName");
							totAmount = totAmount.add(r.getBigDecimal("total"));
							
							saleAmount = saleAmount.add(r.getBigDecimal("saleAmount"));
							dcAmount = dcAmount.add(r.getBigDecimal("discountAmount"));
							netAmount = netAmount.add(r.getBigDecimal("freeAmount"));
							vatAmount = vatAmount.add(r.getBigDecimal("taxAmount"));
	
							totalAmount_Amount = totalAmount_Amount.add(r.getBigDecimal("saleAmount")); //총매출액_금액
							pureAmount_Amount = pureAmount_Amount.add(r.getBigDecimal("freeAmount"));   //순매출액_금액
							
							if ("8".equals(p.get("payMethod").toString()) || "E".equals(p.get("payMethod").toString())) {
								empafter_Count++; //직원후불_건수
								empafter_Amount = empafter_Amount.add(r.getBigDecimal("total")); //직원후불_금액
							}
							
							vatTotalAmount = vatTotalAmount.add(r.getBigDecimal("taxAmount"));
							
							//정산 마크
							Map<String, Object> exactParam = new HashMap<String, Object>();
							exactParam.put("spId", r.getString("spId"));
							
							if ("EXACT_PROCESS".equals(datas.getString("procFlag"))) {
								exactParam.put("lineStatus", "정산");
							}
							else {
								exactParam.put("lineStatus", "주문");
							}
							exactParam.put("posNo", datas.getString("posNo"));
							exactParam.put("receiptNo", String.valueOf(intReceiptNo));
							fsspExactDAO.updateLineStatus(exactParam);
						}
					}
	
					//카드결제인경우
					if ("2".equals(p.get("payMethod").toString())) {
						RecordSet van = fsspExactDAO.selectExactVan(p);
	
						for (int k = 0 ; k < van.size() ; k++) {
							intReceiptNo++; //영수증번호 증가 시키기
							receiptNos.add(intReceiptNo);
							//[[Tran Info 처리
							tranInfoParameter = new HashMap<String, Object>();
							tranInfoParameter.putAll(mainParameter);
							tranInfoParameter.put("receiptNo", intReceiptNo);
							tranInfoParameter.put("posOpenSeq", "0");
							tranInfoParameter.put("logFlag", "TranNode");
							tranInfoParameter.put("logFlagNm", "판매");
							
							try {
								fsspExactDAO.insertTranInfo(tranInfoParameter);
							}
							catch (Exception ept) {
								throw new BizException("Tran Info 생성시 오류가 발생하였습니다.("+ept.toString()+")");
							}
							//Tran Info 처리]]
	
							//[[Tran Node 생성
							tranNodeParameter = new HashMap<String, Object>();
							tranNodeParameter.putAll(tranInfoParameter);
							
							if ("EXACT_PROCESS".equals(datas.getString("procFlag")) && "Z".equals(p.get("payMethod").toString())) {
								tranNodeParameter.put("tranFlag", "I");
							}
							else if (!"EXACT_PROCESS".equals(datas.getString("procFlag")) && "Z".equals(p.get("payMethod").toString())) {
								tranNodeParameter.put("tranFlag", "V");
							}
							else if ("EXACT_PROCESS".equals(datas.getString("procFlag")) && !"Z".equals(p.get("payMethod").toString())) {
								tranNodeParameter.put("tranFlag", "N");
							}
							else if (!"EXACT_PROCESS".equals(datas.getString("procFlag")) && !"Z".equals(p.get("payMethod").toString())) {
								tranNodeParameter.put("tranFlag", "R");
							}
							
							tranNodeParameter.put("tenderCd", "CardCashTenderNode");
							
							try {
								fsspExactDAO.insertTranNode(tranNodeParameter);
							}
							catch (Exception ept) {
								throw new BizException("Tran Node(CASH) Data를 생성시에 오류가 발생하였습니다.("+ept.toString()+")");
							}
							//Tran Node 생성]]
							
							Record v = van.get(k);
							Map<String, Object> pp = new HashMap<String, Object>();
							pp.put("vanKey", v.getString("vanKey"));
							pp.put("assignType", "승인거래");
							pp.put("brchCd", p.get("brchCd").toString());
							RecordSet rs = fsspExactDAO.selectExactTarget(pp);
							
							vanKeys.add(v.getString("vanKey"));
							
							for (int j = 0 ; j < rs.size() ; j++) {
								Record r = rs.get(j);
			
								if ("1".equals(r.getString("taxFlag"))) {
									vat_Count++; //부가세_건수
									vat_Amount = vat_Amount.add(r.getBigDecimal("taxAmount")); //부가세_금액
								}
								
								//[[Tran Item 처리
								tranItemsParameter = new HashMap<String, Object>();
								tranItemsParameter.putAll(tranInfoParameter);
								
								if ("EXACT_PROCESS".equals(datas.getString("procFlag")) && "Z".equals(p.get("payMethod").toString())) {
									tranItemsParameter.put("tranFlag", "I");
								}
								else if (!"EXACT_PROCESS".equals(datas.getString("procFlag")) && "Z".equals(p.get("payMethod").toString())) {
									tranItemsParameter.put("tranFlag", "V");
								}
								else if ("EXACT_PROCESS".equals(datas.getString("procFlag")) && !"Z".equals(p.get("payMethod").toString())) {
									tranItemsParameter.put("tranFlag", "N");
								}
								else if (!"EXACT_PROCESS".equals(datas.getString("procFlag")) && !"Z".equals(p.get("payMethod").toString())) {
									tranItemsParameter.put("tranFlag", "R");
								}
								
								tranItemsParameter.put("itemFlag", "정정");
								tranItemsParameter.put("itemCode", r.getString("itemCode"));
								tranItemsParameter.put("classCode", r.getString("classCode"));
								tranItemsParameter.put("instoreCode", r.getString("instoreCode"));
								tranItemsParameter.put("itemName", r.getString("itemName"));
								tranItemsParameter.put("price", r.getBigDecimal("price"));
								tranItemsParameter.put("taxFlag", r.getString("taxFlag"));
								
								if ("EXACT_PROCESS".equals(datas.getString("procFlag"))) {
									tranItemsParameter.put("quantity", r.getBigDecimal("quantity"));
									tranItemsParameter.put("cancelQty", new BigDecimal("0"));
								}
								else {
									tranItemsParameter.put("quantity", new BigDecimal("0"));
									tranItemsParameter.put("cancelQty", r.getBigDecimal("cancelQty"));
								}
								
								tranItemsParameter.put("discountFlag", r.getString("discountFlag"));
								tranItemsParameter.put("discountRate", r.getBigDecimal("discountRate"));
								tranItemsParameter.put("discountPrice", r.getBigDecimal("discountPrice"));
								tranItemsParameter.put("discountAmount", r.getBigDecimal("discountAmount"));
								tranItemsParameter.put("originPrice", r.getBigDecimal("originPrice"));
								tranItemsParameter.put("subtotal", r.getBigDecimal("subTotal"));
								tranItemsParameter.put("total", r.getBigDecimal("total"));
								tranItemsParameter.put("taxAmount", r.getBigDecimal("taxAmount"));
								tranItemsParameter.put("freeAmount", r.getBigDecimal("freeAmount"));
								tranItemsParameter.put("currencySign", "1");
								
								try {
									fsspExactDAO.insertTranItems(tranItemsParameter);
								}
								catch (Exception ept) {
									throw new BizException("Tran Items Data를 생성시에 오류가 발생하였습니다.("+ept.toString()+")");
								}
								//Tran Item 처리]]
	
								rqSabun = r.getString("empNumber");
								rqName = r.getString("empName");
								totAmount = totAmount.add(r.getBigDecimal("total"));
	
								saleAmount = saleAmount.add(r.getBigDecimal("saleAmount"));
								dcAmount = dcAmount.add(r.getBigDecimal("discountAmount"));
								netAmount = netAmount.add(r.getBigDecimal("freeAmount"));
								vatAmount = vatAmount.add(r.getBigDecimal("taxAmount"));
	
								totalAmount_Amount = totalAmount_Amount.add(r.getBigDecimal("saleAmount")); //총매출액_금액
								pureAmount_Amount = pureAmount_Amount.add(r.getBigDecimal("freeAmount"));   //순매출액_금액
								vatTotalAmount = vatTotalAmount.add(r.getBigDecimal("taxAmount"));
							
								//정산 마크
								Map<String, Object> exactParam = new HashMap<String, Object>();
								exactParam.put("spId", r.getString("spId"));
								if ("EXACT_PROCESS".equals(datas.getString("procFlag"))) {
									exactParam.put("lineStatus", "정산");
								}
								else {
									exactParam.put("lineStatus", "주문");
								}
								exactParam.put("posNo", datas.getString("posNo"));
								exactParam.put("receiptNo", String.valueOf(intReceiptNo));
								fsspExactDAO.updateLineStatus(exactParam);
							}
	
							Map<String, Object> tmp = new HashMap<String, Object>();
							tmp.put("vanKey", pp.get("vanKey"));
							
							if ("EXACT_PROCESS".equals(datas.getString("procFlag"))) {
								tmp.put("assignType", "승인거래");
							}
							else {
								tmp.put("assignType", "취소거래");
							}
							
							RecordSet rsVanDtl = fsspExactDAO.selectExactVanDtl(tmp);
	
							for (int l = 0 ; l < rsVanDtl.size() ; l++) {
								Record rVanDtl = rsVanDtl.get(l);
	
								//현금
								if ("1".equals(rVanDtl.getString("tenderFlag"))) {
									
									//[[Tran CASH 생성
									tranCashParameter = new HashMap<String, Object>();
									tranCashParameter.putAll(tranInfoParameter);
									tranCashParameter.put("seq", l);
	
									if ("EXACT_PROCESS".equals(datas.getString("procFlag"))) {
										tranCashParameter.put("tranFlag", "N");
										tranCashParameter.put("tenderSign", "1");
									}
									else {
										tranCashParameter.put("tranFlag", "R");
										tranCashParameter.put("tenderSign", "-1");
									}
	
									tranCashParameter.put("tenderFlag", "1");
									tranCashParameter.put("tenderName", "현금");
									tranCashParameter.put("receiveAmount", rVanDtl.getBigDecimal("receiveAmount"));
									tranCashParameter.put("realAmount", rVanDtl.getBigDecimal("realAmount"));
									
									try {
										fsspExactDAO.insertTranCash(tranCashParameter);
									}
									catch (Exception ept) {
										throw new BizException("Tran CASH Data를 생성시에 오류가 발생하였습니다.("+ept.toString()+")");
									}
									//Tran CASH 생성]]
									
									cashSale_Count++; //현금매출_건수
									cashSale_Amount = cashSale_Amount.add(rVanDtl.getBigDecimal("realAmount")); //현금매출_금액
								}
								//카드
								else {
									credit_Count++; //카드_건수
									credit_Amount = credit_Amount.add(rVanDtl.getBigDecimal("realAmount")); //카드_금액
									
									//[[Regi Unit Card 처리
									Map<String, Object> regiUnitCardParameter = new HashMap<String, Object>();
									regiUnitCardParameter.put("unitType", rVanDtl.getString("cardBuyCd"));
									regiUnitCardParameter.put("unitText", rVanDtl.getString("cardBuyName"));
									regiUnitCardParameter.put("unitCount", 1);
									regiUnitCardParameter.put("unitAmt", rVanDtl.getBigDecimal("realAmount"));
									regiUnitCardParameter.put("unitEnuriAmt", 0);
									regiUnitCardParameter.put("unitRealAmt", rVanDtl.getBigDecimal("realAmount"));
									regiUnitCardParameter.putAll(mainParameter);
									
									try {
										if (fsspExactDAO.selectExistsRegiUnitCard(regiUnitCardParameter).getInt("cnt") == 0) {
											fsspExactDAO.insertRegiUnitCard(regiUnitCardParameter);
										}
										else {
											fsspExactDAO.updateRegiUnitCard(regiUnitCardParameter);
										}
									}
									catch (Exception ept) {
										throw new BizException("Regi Unit Card Data를 처리시 오류가 발생하였습니다.("+ept.toString()+")");
									}
									//Regi Unit Card 처리]]
																	
									//[[Tran Card 생성
									tranCardParameter = new HashMap<String, Object>();
									tranCardParameter.putAll(tranInfoParameter);
									tranCardParameter.put("seq", l);
									
									if ("EXACT_PROCESS".equals(datas.getString("procFlag"))) {
										tranCardParameter.put("tranFlag", "N");
										tranCardParameter.put("tenderSign", "1");
									}
									else {
										tranCardParameter.put("tranFlag", "R");
										tranCardParameter.put("tenderSign", "-1");
									}
									
									tranCardParameter.put("tenderFlag", "2");
									tranCardParameter.put("tenderName", "타사카드");
									tranCardParameter.put("receiveAmount", rVanDtl.getBigDecimal("receiveAmount"));
									tranCardParameter.put("realAmount", rVanDtl.getBigDecimal("realAmount"));
									tranCardParameter.put("vanId", rVanDtl.getString("vanId"));
									tranCardParameter.put("slipNumber", rVanDtl.getString("slipNumber"));
									tranCardParameter.put("cardNumber", rVanDtl.getString("cardNumber"));
									tranCardParameter.put("activeDate", rVanDtl.getString("activeDate"));
									tranCardParameter.put("halbuMonth", rVanDtl.getString("halbuMonth"));
									tranCardParameter.put("pwd", rVanDtl.getString("password"));
									tranCardParameter.put("approvalFlag", rVanDtl.getString("approvalFlag"));
									tranCardParameter.put("approvalCode", rVanDtl.getString("approvalCode"));
									tranCardParameter.put("vanSeq", rVanDtl.getString("vanSeq"));
									tranCardParameter.put("aprDate", rVanDtl.getString("saleDate"));
									tranCardParameter.put("saleTime", rVanDtl.getString("saleTime"));
									tranCardParameter.put("preApprovalCode", rVanDtl.getString("preApprovalCode"));
									tranCardParameter.put("preSaleDate", rVanDtl.getString("preSaleDate"));
									tranCardParameter.put("preVanSeq", rVanDtl.getString("preVanSeq"));
									tranCardParameter.put("inputFlag", rVanDtl.getString("inputFlag"));
									tranCardParameter.put("inputData", rVanDtl.getString("inputData"));
									tranCardParameter.put("cardName", rVanDtl.getString("cardName"));
									tranCardParameter.put("cardSaCd", rVanDtl.getString("cardSaCd"));
									tranCardParameter.put("machNum", rVanDtl.getString("machNum"));
									tranCardParameter.put("cardMakeCd", rVanDtl.getString("cardMakeCd"));
									tranCardParameter.put("cardMakeName", rVanDtl.getString("cardMakeName"));
									tranCardParameter.put("cardBuyCd", rVanDtl.getString("cardBuyCd"));
									tranCardParameter.put("cardBuyName", rVanDtl.getString("cardBuyName"));
									tranCardParameter.put("affiliate", rVanDtl.getString("affiliate"));
									tranCardParameter.put("returnCd", rVanDtl.getString("returnCd"));
									tranCardParameter.put("message1", rVanDtl.getString("message1"));
									tranCardParameter.put("message2", rVanDtl.getString("message2"));
									tranCardParameter.put("esign", rVanDtl.getString("esign"));
									tranCardParameter.put("encryptYn", rVanDtl.getString("encryptYn"));
	
									try {
										fsspExactDAO.insertTranCard(tranCardParameter);
									}
									catch (Exception ept) {
										throw new BizException("Tran Card Data를 생성시에 오류가 발생하였습니다.("+ept.toString()+")");
									}
									//Tran Card 생성]]
								}
							}
						}
					}
					//직원외상/외상(세금계산서)인 경우
					else if ("8".equals(p.get("payMethod").toString()) || "E".equals(p.get("payMethod").toString())) {
						
						//[[Tran Node 생성
						tranNodeParameter = new HashMap<String, Object>();
						tranNodeParameter.putAll(tranInfoParameter);
						
						if ("EXACT_PROCESS".equals(datas.getString("procFlag")) && "Z".equals(p.get("payMethod").toString())) {
							tranNodeParameter.put("tranFlag", "I");
						}
						else if (!"EXACT_PROCESS".equals(datas.getString("procFlag")) && "Z".equals(p.get("payMethod").toString())) {
							tranNodeParameter.put("tranFlag", "V");
						}
						else if ("EXACT_PROCESS".equals(datas.getString("procFlag")) && !"Z".equals(p.get("payMethod").toString())) {
							tranNodeParameter.put("tranFlag", "N");
						}
						else if (!"EXACT_PROCESS".equals(datas.getString("procFlag")) && !"Z".equals(p.get("payMethod").toString())) {
							tranNodeParameter.put("tranFlag", "R");
						}
						
						tranNodeParameter.put("tenderCd", "EmpafterTenderNode");
						
						try {
							fsspExactDAO.insertTranNode(tranNodeParameter);
						}
						catch (Exception ept) {
							throw new BizException("Tran Node(EMP) Data를 생성시에 오류가 발생하였습니다.("+ept.toString()+")");
						}
						//Tran Node 생성]]
						
						//[[Tran EMP 생성
						tranEmpParameter = new HashMap<String, Object>();
						tranEmpParameter.putAll(tranInfoParameter);
						tranEmpParameter.put("seq", 0);
						
						if ("EXACT_PROCESS".equals(datas.getString("procFlag"))) {
							tranEmpParameter.put("tranFlag", "N");
							tranEmpParameter.put("tenderSign", "1");
						}
						else {
							tranEmpParameter.put("tranFlag", "R");
							tranEmpParameter.put("tenderSign", "-1");
						}
						
						tranEmpParameter.put("tenderFlag", "6");
						tranEmpParameter.put("tenderName", "직원외상");
						tranEmpParameter.put("receiveAmount", totAmount);
						tranEmpParameter.put("realAmount", totAmount);
						tranEmpParameter.put("empNumber", rqSabun);
						tranEmpParameter.put("empName", rqName);
						tranEmpParameter.put("approvalFlag", "A");
						tranEmpParameter.put("approvalCode", rqSabun);
						tranEmpParameter.put("arSaveDiv", "3");
						
						try {
							fsspExactDAO.insertTranEmp(tranEmpParameter);
						}
						catch (Exception ept) {
							throw new BizException("Tran EMP Data를 생성시에 오류가 발생하였습니다.("+ept.toString()+")");
						}
						//Tran EMP 생성]]
					}
					//내부거래인 경우
					else if ("Z".equals(p.get("payMethod").toString())) {
						//[[Tran Node 생성
						tranNodeParameter = new HashMap<String, Object>();
						tranNodeParameter.putAll(tranInfoParameter);
						
						if ("EXACT_PROCESS".equals(datas.getString("procFlag")) && "Z".equals(p.get("payMethod").toString())) {
							tranNodeParameter.put("tranFlag", "I");
						}
						else if (!"EXACT_PROCESS".equals(datas.getString("procFlag")) && "Z".equals(p.get("payMethod").toString())) {
							tranNodeParameter.put("tranFlag", "V");
						}
						else if ("EXACT_PROCESS".equals(datas.getString("procFlag")) && !"Z".equals(p.get("payMethod").toString())) {
							tranNodeParameter.put("tranFlag", "N");
						}
						else if (!"EXACT_PROCESS".equals(datas.getString("procFlag")) && !"Z".equals(p.get("payMethod").toString())) {
							tranNodeParameter.put("tranFlag", "R");
						}
						
						tranNodeParameter.put("tenderCd", "TeamafterTenderNode");
						
						try {
							fsspExactDAO.insertTranNode(tranNodeParameter);
						}
						catch (Exception ept) {
							throw new BizException("Tran Node(TEAM) Data를 생성시에 오류가 발생하였습니다.("+ept.toString()+")");
						}
						//Tran Node 생성]]
						
						//[[Tran TEAM 생성
						tranTeamParameter = new HashMap<String, Object>();
						tranTeamParameter.putAll(tranInfoParameter);
						tranTeamParameter.put("seq", 0);
						
						if ("EXACT_PROCESS".equals(datas.getString("procFlag"))) {
							tranTeamParameter.put("tranFlag", "I");
							tranTeamParameter.put("tenderSign", "1");
						}
						else {
							tranTeamParameter.put("tranFlag", "V");
							tranTeamParameter.put("tenderSign", "-1");
						}
						
						tranTeamParameter.put("tenderFlag", "15");
						tranTeamParameter.put("tenderName", "내부이용");
						tranTeamParameter.put("receiveAmount", totAmount);
						tranTeamParameter.put("realAmount", totAmount);
						tranTeamParameter.put("teamNumber", rqSabun);
						tranTeamParameter.put("teamName", rqName);
						tranTeamParameter.put("approvalFlag", "A");
						tranTeamParameter.put("originalPrice", totAmount);
						tranTeamParameter.put("inFlag", "Y");
						
						try {
							fsspExactDAO.insertTranTeam(tranTeamParameter);
						}
						catch (Exception ept) {
							throw new BizException("Tran TEAM Data를 생성시에 오류가 발생하였습니다.("+ept.toString()+")");
						}
						//Tran TEAM 생성]]
					}
				}
			}
			
			//[[Regi Hdr 처리
			Map<String, Object> regiHdr = new HashMap<String, Object>();
			regiHdr.put("openFlag", "1");
			regiHdr.put("openDate", datas.get("saleDate"));
			regiHdr.put("openTime", DateUtil.getYyyymmddhhmmss().substring(8));
			regiHdr.put("openSeq", 1);
			regiHdr.put("closeFlag", "1");
			regiHdr.put("closeDate", datas.get("saleDate"));
			regiHdr.put("closeTime", DateUtil.getYyyymmddhhmmss().substring(8));
			regiHdr.put("closeSeq", 1);
			regiHdr.put("userId", datas.get("sabun"));
			regiHdr.put("updateDate", DateUtil.getYyyymmdd());
			regiHdr.put("updateTime", DateUtil.getYyyymmddhhmmss().substring(8));
			regiHdr.put("receiptNo", intReceiptNo);
			regiHdr.put("sendReceiptNo", intReceiptNo);
			regiHdr.put("creditSlipNo", "");
			regiHdr.putAll(mainParameter);
					
			try {
				if (fsspExactDAO.selectExistsRegiHdr(regiHdr).getInt("cnt") == 0) {
					fsspExactDAO.insertRegiHdr(regiHdr);
				}
				else {
					fsspExactDAO.updateRegiHdr(regiHdr);
				}
			}
			catch (Exception ept) {
				throw new BizException("Regi Header을 처리시 오류가 발생하였습니다.");
			}
			//Regi Hdr 처리]]		
	
			//[[Regi Unit 처리
			List<Map<String, Object>> regiUnits = new ArrayList<Map<String,Object>>();
			regiUnits.add(this.setRegiUnit(regiHdr, "TotalAmount"   , "총매출액"      , totalAmount_Count, totalAmount_Amount , new BigDecimal("0"), 1));
			regiUnits.add(this.setRegiUnit(regiHdr, "EnuriAmount"   , "총에누리"      , 0                , new BigDecimal("0"), new BigDecimal("0"), 2));
			regiUnits.add(this.setRegiUnit(regiHdr, "PureAmount"    , "순매출액"      , pureAmount_Count , pureAmount_Amount  , new BigDecimal("0"), 3));
	
			//정산수행
			if ("EXACT_PROCESS".equals(datas.getString("procFlag"))) {
				regiUnits.add(this.setRegiUnit(regiHdr, "CashSale"      , "현금매출"      , cashSale_Count   , cashSale_Amount    , cashSale_Amount    , 4));
				regiUnits.add(this.setRegiUnit(regiHdr, "CashReturn"    , "현금반품매출"  , 0                , new BigDecimal("0"), new BigDecimal("0"), 5));
			}
			//정산취소
			else {
				regiUnits.add(this.setRegiUnit(regiHdr, "CashSale"      , "현금매출"      , 0                , new BigDecimal("0"), new BigDecimal("0"), 4));
				regiUnits.add(this.setRegiUnit(regiHdr, "CashReturn"    , "현금반품매출"  , cashSale_Count   , cashSale_Amount    , cashSale_Amount    , 5));
			}
	
			regiUnits.add(this.setRegiUnit(regiHdr, "Credit"        , "카드"          , credit_Count     , credit_Amount      , new BigDecimal("0"), 6));
			regiUnits.add(this.setRegiUnit(regiHdr, "UseSale"       , "사용매출"      , 0                , new BigDecimal("0"), new BigDecimal("0"), 7));
			regiUnits.add(this.setRegiUnit(regiHdr, "Gift"          , "상품권"        , 0                , new BigDecimal("0"), new BigDecimal("0"), 8));
			regiUnits.add(this.setRegiUnit(regiHdr, "PreCash"       , "선수금"        , 0                , new BigDecimal("0"), new BigDecimal("0"), 9));
			regiUnits.add(this.setRegiUnit(regiHdr, "Pretend"       , "선납쿠폰"      , 0                , new BigDecimal("0"), new BigDecimal("0"), 10));
			regiUnits.add(this.setRegiUnit(regiHdr, "Return"        , "환불"          , 0                , new BigDecimal("0"), new BigDecimal("0"), 11));
			regiUnits.add(this.setRegiUnit(regiHdr, "MemDiscount"   , "회원할인"      , 0                , new BigDecimal("0"), new BigDecimal("0"), 12));
			regiUnits.add(this.setRegiUnit(regiHdr, "EmpDiscount"   , "직원할인"      , 0                , new BigDecimal("0"), new BigDecimal("0"), 13));
			regiUnits.add(this.setRegiUnit(regiHdr, "RoomDiscount"  , "고객할인"      , 0                , new BigDecimal("0"), new BigDecimal("0"), 14));
			regiUnits.add(this.setRegiUnit(regiHdr, "Cupon"         , "쿠폰할인"      , 0                , new BigDecimal("0"), new BigDecimal("0"), 15));
			regiUnits.add(this.setRegiUnit(regiHdr, "MobileDiscount", "모바일할인"    , 0                , new BigDecimal("0"), new BigDecimal("0"), 16));
			regiUnits.add(this.setRegiUnit(regiHdr, "Roomafter"     , "객실후불"      , 0                , new BigDecimal("0"), new BigDecimal("0"), 17));
			regiUnits.add(this.setRegiUnit(regiHdr, "Groupafter"    , "단체후불"      , 0                , new BigDecimal("0"), new BigDecimal("0"), 18));
			regiUnits.add(this.setRegiUnit(regiHdr, "Custafter"     , "내장객후불"    , 0                , new BigDecimal("0"), new BigDecimal("0"), 19));
			regiUnits.add(this.setRegiUnit(regiHdr, "Empafter"      , "직원후불"      , empafter_Count   , empafter_Amount    , new BigDecimal("0"), 20));
			regiUnits.add(this.setRegiUnit(regiHdr, "Teamafter"     , "부서후불"      , 0                , new BigDecimal("0"), new BigDecimal("0"), 21));
			regiUnits.add(this.setRegiUnit(regiHdr, "Normalafter"   , "일반후불"      , 0                , new BigDecimal("0"), new BigDecimal("0"), 22));
			regiUnits.add(this.setRegiUnit(regiHdr, "ReservedFund"  , "준비금"        , 0                , new BigDecimal("0"), new BigDecimal("0"), 23));
			regiUnits.add(this.setRegiUnit(regiHdr, "MidStockCash1" , "중간입금현금1" , 0                , new BigDecimal("0"), new BigDecimal("0"), 24));
			regiUnits.add(this.setRegiUnit(regiHdr, "MidStockCash2" , "중간입금현금2" , 0                , new BigDecimal("0"), new BigDecimal("0"), 25));
			regiUnits.add(this.setRegiUnit(regiHdr, "MidStockCash3" , "중간입금현금3" , 0                , new BigDecimal("0"), new BigDecimal("0"), 26));
			regiUnits.add(this.setRegiUnit(regiHdr, "MidStockGift"  , "중간입금상품권", 0                , new BigDecimal("0"), new BigDecimal("0"), 27));
			regiUnits.add(this.setRegiUnit(regiHdr, "GiftReturnCash", "상품권환불"    , 0                , new BigDecimal("0"), new BigDecimal("0"), 28));
			regiUnits.add(this.setRegiUnit(regiHdr, "CashStock"     , "현금시재등록"  , 0                , new BigDecimal("0"), new BigDecimal("0"), 29));
			
			//정산수행
			if ("EXACT_PROCESS".equals(datas.getString("procFlag"))) {
				regiUnits.add(this.setRegiUnit(regiHdr, "NormalSale"    , "정상매출"      , totalAmount_Count, totalAmount_Amount , new BigDecimal("0"), 30));
				regiUnits.add(this.setRegiUnit(regiHdr, "ReturnSale"    , "반품매출"      , 0                , new BigDecimal("0"), new BigDecimal("0"), 31));
			}
			//정산취소
			else {
				regiUnits.add(this.setRegiUnit(regiHdr, "NormalSale"    , "정상매출"      , 0                , new BigDecimal("0"), new BigDecimal("0"), 30));
				regiUnits.add(this.setRegiUnit(regiHdr, "ReturnSale"    , "반품매출"      , totalAmount_Count, totalAmount_Amount , new BigDecimal("0"), 31));
			}
			
			regiUnits.add(this.setRegiUnit(regiHdr, "BagSale"       , "쇼핑백판매"    , 0                , new BigDecimal("0"), new BigDecimal("0"), 32));
			regiUnits.add(this.setRegiUnit(regiHdr, "BagReturn"     , "쇼핑백회수"    , 0                , new BigDecimal("0"), new BigDecimal("0"), 33));
			regiUnits.add(this.setRegiUnit(regiHdr, "BottleSale"    , "공병판매"      , 0                , new BigDecimal("0"), new BigDecimal("0"), 34));
			regiUnits.add(this.setRegiUnit(regiHdr, "BottleReturn"  , "공병회수"      , 0                , new BigDecimal("0"), new BigDecimal("0"), 35));
			regiUnits.add(this.setRegiUnit(regiHdr, "Vat"           , "부가세"        , vat_Count        , vat_Amount         , new BigDecimal("0"), 36));
			regiUnits.add(this.setRegiUnit(regiHdr, "CustomerNumber", "고객수"        , 0                , new BigDecimal("0"), new BigDecimal("0"), 37));
	
			this.saveRegiUnit(regiUnits);
			//Regi Unit 처리]]
			
			//영수증 및 Regi Log를 생성하여 IRIS에 저장한다.
				this.createRegiXML(mainParameter, receiptNos);
				txManager.commit(txStatus);
		}
		catch (Exception e) {
			txManager.rollback(txStatus);
			throw e;
		}
		
		sendData.put("status", "OK");
		sendData.put("message", "정상적으로 처리하였습니다.");
		
		ResponseData res = new ResponseData();
		res.addData("res", sendData);

		return res.send();
	}

	private String createRegiXML(Map<String, Object> parameter, List<Integer> receiptNos) throws Exception {
		//[[Regi XML 생성
		RecordSet rsRegi = fsspExactDAO.selectRegiXML(parameter);
		Element regiDoc = new Element("document");
		Element regiHdr = new Element("RegiHeader");
		Element regiDtl = new Element("RegiDetail");
		
		Map<String, Object> regiLog = new HashMap<String, Object>();

		for (int i = 0 ; i < rsRegi.size() ; i++) {
			Record rRegi = rsRegi.get(i);
			
			//[[Regi Hdr은 맨 첫 행으로만 작성한다.
			if (i == 0) {
				regiHdr.addContent(this.createNewElement("StoreCode", rRegi.getString("brchCd")));
				regiHdr.addContent(this.createNewElement("StoreName", rRegi.getString("brchNm")));
				regiHdr.addContent(this.createNewElement("LocCode", rRegi.getString("locCd")));
				regiHdr.addContent(this.createNewElement("LocName", rRegi.getString("locNm")));
				regiHdr.addContent(this.createNewElement("RegiNo", rRegi.getString("posNo")));
				regiHdr.addContent(this.createNewElement("RegiName", rRegi.getString("posNm")));
				regiHdr.addContent(this.createNewElement("OpenFlag", rRegi.getString("openFlag")));
				regiHdr.addContent(this.createNewElement("OpenDate", rRegi.getString("openDate")));
				regiHdr.addContent(this.createNewElement("OpenTime", rRegi.getString("openTime")));
				regiHdr.addContent(this.createNewElement("OpenDay365", "000"));
				regiHdr.addContent(this.createNewElement("OpenSequence", rRegi.getString("openSeq")));
				regiHdr.addContent(this.createNewElement("CloseFlag", rRegi.getString("closeFlag")));
				regiHdr.addContent(this.createNewElement("CloseDate", rRegi.getString("closeDate")));
				regiHdr.addContent(this.createNewElement("CloseTime", rRegi.getString("closeTime")));
				regiHdr.addContent(this.createNewElement("CloseSequence", rRegi.getString("closeSeq")));
				regiHdr.addContent(this.createNewElement("UserID", rRegi.getString("userId")));
				regiHdr.addContent(this.createNewElement("UserName", rRegi.getString("userName")));
				regiHdr.addContent(this.createNewElement("ServerState", "false"));
				regiHdr.addContent(this.createNewElement("UpdateDate", rRegi.getString("updateDate")));
				regiHdr.addContent(this.createNewElement("UpdateTime", rRegi.getString("updateTime")));
				regiHdr.addContent(this.createNewElement("ReceiptNo", rRegi.getString("receiptNo")));
				regiHdr.addContent(this.createNewElement("SendReceiptNo", rRegi.getString("sendReceiptNo")));
				regiHdr.addContent(this.createNewElement("CreditSlipNo", rRegi.getString("creditSlipNo")));
				
				regiLog.put("saleDate", rRegi.getString("saleDate"));
				regiLog.put("brchCd", rRegi.getString("brchCd"));
				regiLog.put("posNo", rRegi.getString("posNo"));
				regiLog.put("sabun", rRegi.getString("userId"));
			}
			//Regi Hdr은 맨 첫 행으로만 작성한다.]]

			//[[카드인 경우는 별도 처리
			if ("Credit".equals(rRegi.getString("unitType"))) {
				regiDtl.addContent(this.createRegiCardUnit(rRegi));
			}
			//카드인 경우는 별도 처리]]
			else {
				regiDtl.addContent(this.createRegiUnit(rRegi));
			}			
		}
		
		regiDoc.addContent(regiHdr);
		regiDoc.addContent(regiDtl);
		
		Document regiDocument = new Document();
		regiDocument.setRootElement(regiDoc);
		
		XMLOutputter regiOut = new XMLOutputter(Format.getPrettyFormat().setEncoding("EUC-KR"));
		
		String xmlRegi = regiOut.outputString(regiDocument);
		
		logger.debug(xmlRegi);
		//Regi XML 생성]]
		regiLog.put("trlog", xmlRegi);
		
		try {
			if (fsspIrisDAO.selectExistsRegiLog(regiLog).getInt("cnt") > 0) {
				fsspIrisDAO.updateRegiLog(regiLog);
			}
			else {
				fsspIrisDAO.insertRegiLog(regiLog);
			}
		}
		catch (Exception e) {
			throw new BizException("RegiLog Data 생성시 오류가 발생하였습니다."+e.getMessage());
		}
		
		//[[Receipt XML 생성
		parameter.put("receiptNos", receiptNos);
		
		RecordSet tranHdr = fsspExactDAO.selectTranHdr(parameter);
		Element tranDoc;
		Element tran;
		Element tranInfo;
		Element tranNode;
		
		for (int i = 0 ; i < tranHdr.size() ; i++) {
			Record r = tranHdr.get(i);
			tranDoc = new Element("document");
			tran = new Element("Transaction");
			tranInfo = new Element("TranInformation");
			tranNode = new Element("TranNode");
			
			tranInfo.addContent(this.createNewElement("STORE_CODE", r.getString("brchCd")));
			tranInfo.addContent(this.createNewElement("SALE_DATE", r.getString("saleDate")));
			tranInfo.addContent(this.createNewElement("POS_NUMBER", r.getString("posNo")));
			tranInfo.addContent(this.createNewElement("POS_OPEN_SEQUENCE", r.getString("posOpenSeq")));
			tranInfo.addContent(this.createNewElement("RECEIPT_NUMBER", r.getString("receiptNo")));
			tranInfo.addContent(this.createNewElement("USER_CODE", r.getString("userId")));
			tranInfo.addContent(this.createNewElement("DATE_TIME", r.getString("dateTime")));
			tranInfo.addContent(this.createNewElement("LOG_FLAG", r.getString("logFlag")));

			tranNode.addContent(this.createNewElement("TranFlag", r.getString("tranFlag")));
			
			//[[Item List 생성
			Map<String, Object> p = new HashMap<String, Object>();
			p.put("saleDate", r.getString("saleDate"));
			p.put("brchCd", r.getString("brchCd"));
			p.put("locCd", r.getString("locCd"));
			p.put("posNo", r.getString("posNo"));
			p.put("receiptNo", r.getString("receiptNo"));
			
			RecordSet tranItem = fsspExactDAO.selectTranItems(p);
			Element tranItemList = new Element("ItemList");
			Element tranItemNode;
			
			for (int j = 0 ; j < tranItem.size() ; j++) {
				Record rItem = tranItem.get(j);
				tranItemNode = new Element("ItemNode");
				
				tranItemNode.addContent(this.createNewElement("TranFlag", rItem.getString("tranFlag")));
				tranItemNode.addContent(this.createNewElement("ItemFlag", rItem.getString("itemFlag")));
				tranItemNode.addContent(this.createNewElement("LocCd", rItem.getString("locCd")));
				tranItemNode.addContent(this.createNewElement("ItemCode", rItem.getString("itemCode")));
				tranItemNode.addContent(this.createNewElement("ClassCode", rItem.getString("classCode")));
				tranItemNode.addContent(this.createNewElement("InstoreCode", rItem.getString("instoreCode")));
				tranItemNode.addContent(this.createNewElement("ItemName", rItem.getString("itemName")));
				tranItemNode.addContent(this.createNewElement("Price", rItem.getString("price")));
				tranItemNode.addContent(this.createNewElement("CadyYn", rItem.getString("cadyYn")));
				tranItemNode.addContent(this.createNewElement("BottleCode", rItem.getString("bottleCode")));
				tranItemNode.addContent(this.createNewElement("BOTL_MNGM_YN", rItem.getString("botlMngmYn")));
				tranItemNode.addContent(this.createNewElement("BOTL_YN", rItem.getString("botlYn")));
				tranItemNode.addContent(this.createNewElement("TaxFlag", rItem.getString("taxFlag")));
				tranItemNode.addContent(this.createNewElement("Quantity", rItem.getString("quantity")));
				tranItemNode.addContent(this.createNewElement("CancelQty", rItem.getString("cancelQty")));
				tranItemNode.addContent(this.createNewElement("DiscountFlag", rItem.getString("discountFlag")));
				tranItemNode.addContent(this.createNewElement("DiscountRate", rItem.getString("discountRate")));
				tranItemNode.addContent(this.createNewElement("DiscountPrice", rItem.getString("discountPrice")));
				tranItemNode.addContent(this.createNewElement("DiscountAmount", rItem.getString("discountAmount")));
				tranItemNode.addContent(this.createNewElement("SubDiscountAmount", rItem.getString("subDiscountAmount")));
				tranItemNode.addContent(this.createNewElement("SubDiscountQty", rItem.getString("subDiscountQty")));
				tranItemNode.addContent(this.createNewElement("OriginPrice", rItem.getString("originPrice")));
				tranItemNode.addContent(this.createNewElement("PretendQty", rItem.getString("pretendQty")));
				tranItemNode.addContent(this.createNewElement("EventFlag", "false"));
				tranItemNode.addContent(this.createNewElement("Subtotal", rItem.getString("subtotal")));
				tranItemNode.addContent(this.createNewElement("Total", rItem.getString("total")));
				tranItemNode.addContent(this.createNewElement("TaxAmount", rItem.getString("taxAmount")));
				tranItemNode.addContent(this.createNewElement("ServiceAmt", rItem.getString("serviceAmt")));
				tranItemNode.addContent(this.createNewElement("ServiceRate", rItem.getString("serviceRate")));
				tranItemNode.addContent(this.createNewElement("FreeAmount", rItem.getString("freeAmount")));
				tranItemNode.addContent(this.createNewElement("Sign", rItem.getString("currencySign")));
				tranItemNode.addContent(this.createNewElement("WEIG_YN", rItem.getString("weigYn")));
				tranItemNode.addContent(this.createNewElement("PointType", rItem.getString("pointType")));
				tranItemNode.addContent(this.createNewElement("PointQty", rItem.getString("pointQty")));
				tranItemNode.addContent(this.createNewElement("PointDcAmt", rItem.getString("pointDcAmt")));
				tranItemNode.addContent(this.createNewElement("PointArAmt", rItem.getString("pointArAmt")));
				tranItemNode.addContent(this.createNewElement("PointTrack2", rItem.getString("pointTrack2")));
				tranItemNode.addContent(this.createNewElement("PointApprDate", rItem.getString("pointApprDate")));
				tranItemNode.addContent(this.createNewElement("PointApprNo", rItem.getString("pointApprNo")));
				
				tranItemList.addContent(tranItemNode);
			}
			
			//Item List 생성]]
			tranNode.addContent(tranItemList);
			
			//[[TenderList 생성
			RecordSet tranCard = fsspExactDAO.selectTranCard(p);
			RecordSet tranCash = fsspExactDAO.selectTranCash(p);
			RecordSet tranEmp = fsspExactDAO.selectTranEmp(p);
			RecordSet tranTeam = fsspExactDAO.selectTranTeam(p);
			
			Element tenderList = new Element("TenderList");
			
			//카드
			for (int j = 0 ; j < tranCard.size() ; j++) {
				Record rCard = tranCard.get(j);
				Element cardNode = new Element("CreditTenderNode");
				Element tenderNode = new Element("TenderNode");
				
				tenderNode.addContent(this.createNewElement("TranFlag", rCard.getString("tranFlag")));
				tenderNode.addContent(this.createNewElement("TenderFlag", rCard.getString("tenderFlag")));
				tenderNode.addContent(this.createNewElement("TenderName", rCard.getString("tenderName")));
				tenderNode.addContent(this.createNewElement("ReceiveAmount", rCard.getString("receiveAmount")));
				tenderNode.addContent(this.createNewElement("RealAmount", rCard.getString("realAmount")));
				tenderNode.addContent(this.createNewElement("Sign", rCard.getString("tenderSign")));

				cardNode.addContent(tenderNode);
				cardNode.addContent(this.createNewElement("VanID", rCard.getString("vanId")));
				cardNode.addContent(this.createNewElement("SlipNumber", rCard.getString("slipNumber")));
				cardNode.addContent(this.createNewElement("CardNumber", rCard.getString("cardNumber")));
				cardNode.addContent(this.createNewElement("ActiveDate", rCard.getString("activeDate")));
				cardNode.addContent(this.createNewElement("HalbuMonth", rCard.getString("halbuMonth")));
				cardNode.addContent(this.createNewElement("Password", rCard.getString("pwd")));
				cardNode.addContent(this.createNewElement("ApprovalFlag", rCard.getString("approvalFlag")));
				cardNode.addContent(this.createNewElement("ApprovalCode", rCard.getString("approvalCode")));
				cardNode.addContent(this.createNewElement("VANSeq", rCard.getString("vanSeq")));
				cardNode.addContent(this.createNewElement("SaleDate", rCard.getString("aprDate")));
				cardNode.addContent(this.createNewElement("SaleTime", rCard.getString("saleTime")));
				cardNode.addContent(this.createNewElement("PreApprovalCode", rCard.getString("preApprovalCode")));
				cardNode.addContent(this.createNewElement("PreSaleDate", rCard.getString("preSaleDate")));
				cardNode.addContent(this.createNewElement("PreVANSeq", rCard.getString("preVanSeq")));
				cardNode.addContent(this.createNewElement("InputFlag", rCard.getString("inputFlag")));
				cardNode.addContent(this.createNewElement("InputData", rCard.getString("inputData")));
				cardNode.addContent(this.createNewElement("CardName", rCard.getString("cardName")));
				cardNode.addContent(this.createNewElement("CardsaCD", rCard.getString("cardSaCd")));
				cardNode.addContent(this.createNewElement("MachNum", rCard.getString("machNum")));
				cardNode.addContent(this.createNewElement("CardMakeCD", rCard.getString("cardMakeCd")));
				cardNode.addContent(this.createNewElement("CardMakeName", rCard.getString("cardMakeName")));
				cardNode.addContent(this.createNewElement("CardBuyCD", rCard.getString("cardBuyCd")));
				cardNode.addContent(this.createNewElement("CardBuyName", rCard.getString("cardBuyName")));
				cardNode.addContent(this.createNewElement("Affiliate", rCard.getString("affiliate")));
				cardNode.addContent(this.createNewElement("ReturnCD", rCard.getString("returnCd")));
				cardNode.addContent(this.createNewElement("Message1", rCard.getString("message1")));
				cardNode.addContent(this.createNewElement("Message2", rCard.getString("message2")));
				cardNode.addContent(this.createNewElement("ESign", rCard.getString("esign")));
				cardNode.addContent(this.createNewElement("EncryptYn", rCard.getString("encryptYn")));
				
				tenderList.addContent(cardNode);
			}
			
			//현금
			for (int j = 0 ; j < tranCash.size() ; j++) {
				Record rCash = tranCash.get(j);
				Element cashNode = new Element("CashTenderNode");
				Element tenderNode = new Element("TenderNode");
				
				tenderNode.addContent(this.createNewElement("TranFlag", rCash.getString("tranFlag")));
				tenderNode.addContent(this.createNewElement("TenderFlag", rCash.getString("tenderFlag")));
				tenderNode.addContent(this.createNewElement("TenderName", rCash.getString("tenderName")));
				tenderNode.addContent(this.createNewElement("ReceiveAmount", rCash.getString("receiveAmount")));
				tenderNode.addContent(this.createNewElement("RealAmount", rCash.getString("realAmount")));
				tenderNode.addContent(this.createNewElement("Sign", rCash.getString("tenderSign")));

				cashNode.addContent(tenderNode);
				
				tenderList.addContent(cashNode);
			}
			
			//직원외상
			for (int j = 0 ; j < tranEmp.size() ; j++) {
				Record rEmp = tranEmp.get(j);
				Element empNode = new Element("EmpafterTenderNode");
				Element tenderNode = new Element("TenderNode");
				
				tenderNode.addContent(this.createNewElement("TranFlag", rEmp.getString("tranFlag")));
				tenderNode.addContent(this.createNewElement("TenderFlag", rEmp.getString("tenderFlag")));
				tenderNode.addContent(this.createNewElement("TenderName", rEmp.getString("tenderName")));
				tenderNode.addContent(this.createNewElement("ReceiveAmount", rEmp.getString("receiveAmount")));
				tenderNode.addContent(this.createNewElement("RealAmount", rEmp.getString("realAmount")));
				tenderNode.addContent(this.createNewElement("Sign", rEmp.getString("tenderSign")));

				empNode.addContent(tenderNode);
				empNode.addContent(this.createNewElement("EmpNumber", rEmp.getString("empNumber")));
				empNode.addContent(this.createNewElement("EmpName", rEmp.getString("empName")));
				empNode.addContent(this.createNewElement("ApprovalFlag", rEmp.getString("approvalFlag")));
				empNode.addContent(this.createNewElement("ApprovalCode", rEmp.getString("approvalCode")));
				empNode.addContent(this.createNewElement("ArSaveDiv", rEmp.getString("arSaveDiv")));
				empNode.addContent(this.createNewElement("SttlNumber", rEmp.getString("sttlNumber")));
				
				tenderList.addContent(empNode);
			}
			
			//내부거래
			for (int j = 0 ; j < tranTeam.size() ; j++) {
				Record rTeam = tranTeam.get(j);
				Element teamNode = new Element("TeamafterTenderNode");
				Element tenderNode = new Element("TenderNode");
				
				tenderNode.addContent(this.createNewElement("TranFlag", rTeam.getString("tranFlag")));
				tenderNode.addContent(this.createNewElement("TenderFlag", rTeam.getString("tenderFlag")));
				tenderNode.addContent(this.createNewElement("TenderName", rTeam.getString("tenderName")));
				tenderNode.addContent(this.createNewElement("ReceiveAmount", rTeam.getString("receiveAmount")));
				tenderNode.addContent(this.createNewElement("RealAmount", rTeam.getString("realAmount")));
				tenderNode.addContent(this.createNewElement("Sign", rTeam.getString("tenderSign")));

				teamNode.addContent(tenderNode);
				teamNode.addContent(this.createNewElement("TeamNumber", rTeam.getString("teamNumber")));
				teamNode.addContent(this.createNewElement("TeamName", rTeam.getString("teamName")));
				teamNode.addContent(this.createNewElement("ApprovalFlag", rTeam.getString("approvalFlag")));
				teamNode.addContent(this.createNewElement("ApprovalCode", rTeam.getString("teamNumber")));
				teamNode.addContent(this.createNewElement("PreApprovalCode", rTeam.getString("preApprovalCode")));
				teamNode.addContent(this.createNewElement("ErrorMessage", rTeam.getString("errorMessage")));
				teamNode.addContent(this.createNewElement("OriginalPrice", rTeam.getString("originalPrice")));
				teamNode.addContent(this.createNewElement("InFlag", rTeam.getString("inFlag")));
				
				tenderList.addContent(teamNode);
			}

			//TenderList 생성]]
			tranNode.addContent(tenderList);
			
			tranNode.addContent(this.createNewElement("OtherList", ""));
			tranNode.addContent(this.createNewElement("CUST_DIV", ""));
			tranNode.addContent(this.createNewElement("CUST_CODE", ""));
			tranNode.addContent(this.createNewElement("CC_ID_NO", ""));
			tranNode.addContent(this.createNewElement("GROUP_EVNT_CODE", ""));
			tranNode.addContent(this.createNewElement("AUTO_SALE_EQMT_CODE", ""));
			tranNode.addContent(this.createNewElement("CUST_ZONE", ""));
			tranNode.addContent(this.createNewElement("BUNDLE_CUST_CONT", ""));
			tranNode.addContent(this.createNewElement("HALL_TABLE_NO", ""));
			tranNode.addContent(this.createNewElement("REASON_CODE", ""));
			tranNode.addContent(this.createNewElement("PRE_RECEIPT_NO", ""));
			tranNode.addContent(this.createNewElement("TRAN_MEMO", ""));
			
			tran.addContent(tranInfo);
			tran.addContent(tranNode);
			
			tranDoc.addContent(tran);
			
			Document tranDocument = new Document();
			tranDocument.setRootElement(tranDoc);
			
			XMLOutputter tranOut = new XMLOutputter(Format.getPrettyFormat().setEncoding("EUC-KR"));
			
			String xmlTran = tranOut.outputString(tranDocument);
			
			logger.debug(xmlTran);

			//Tran Log 생성
			Map<String, Object> tranLog = new HashMap<String, Object>();
			tranLog.put("saleDate", r.getString("saleDate"));
			tranLog.put("rcptNo", r.getString("receiptNo"));
			tranLog.put("brchCd", r.getString("brchCd"));
			tranLog.put("posNo", r.getString("posNo"));
			tranLog.put("trlog", xmlTran);
			tranLog.put("sabun", r.getString("userId"));
			
			try {
				fsspIrisDAO.insertTranLog(tranLog);
			}
			catch (Exception e) {
				throw new BizException("TranLog Data생성시 오류가 발생하였습니다."+e.getMessage());
			}
		}
		//Receipt XML 생성]]
		
		return xmlRegi;
	}
	
	/**
	 * Regi Unit Card 정보를 생성한다.
	 *
	 * @param r
	 * @return
	 * @throws Exception
	 */
	private Element createRegiCardUnit(Record r) throws Exception {
		Element unit = new Element("unit");
		
		unit.addContent(this.createNewElement("type", r.getString("unitType")));
		unit.addContent(this.createNewElement("text", r.getString("unitText")));
		unit.addContent(this.createNewElement("count", r.getString("unitCount")));
		unit.addContent(this.createNewElement("amount", r.getString("unitAmt")));
		unit.addContent(this.createNewElement("enuriamount", r.getString("unitEnuriAmt")));
		unit.addContent(this.createNewElement("realamount", r.getString("unitRealAmt")));
		
		if (r.getInt("unitCount") > 0) {
			Element unitlist = new Element("unitlist");
			Element subUnit = new Element("unit");
			subUnit.addContent(this.createNewElement("type", "OtherCredit"));
			subUnit.addContent(this.createNewElement("text", ""));
			subUnit.addContent(this.createNewElement("count", r.getString("unitCount")));
			subUnit.addContent(this.createNewElement("amount", r.getString("unitAmt")));
			subUnit.addContent(this.createNewElement("enuriamount", r.getString("unitEnuriAmt")));
			subUnit.addContent(this.createNewElement("realamount", r.getString("unitRealAmt")));

			Element subUnitList = new Element("unitlist");
			Element e;
			
			Map<String, Object> p = new HashMap<String, Object>();
			p.put("saleDate", r.getString("saleDate"));
			p.put("brchCd", r.getString("brchCd"));
			p.put("locCd", r.getString("locCd"));
			p.put("posNo", r.getString("posNo"));
			
			RecordSet rs = fsspExactDAO.selectRegiCardXML(p);
			
			for (int i = 0 ; i < rs.size() ; i++) {
				Record rCard = rs.get(i);
				e = new Element("unit");
				e.addContent(this.createNewElement("type", rCard.getString("unitType")));
				e.addContent(this.createNewElement("text", rCard.getString("unitText")));
				e.addContent(this.createNewElement("count", rCard.getString("unitCount")));
				e.addContent(this.createNewElement("amount", rCard.getString("unitAmt")));
				e.addContent(this.createNewElement("enuriamount", rCard.getString("unitEnuriAmt")));
				e.addContent(this.createNewElement("realamount", rCard.getString("unitRealAmt")));
				
				subUnitList.addContent(e);
			}
			subUnit.addContent(subUnitList);
			unitlist.addContent(subUnit);
			unit.addContent(unitlist);
		}
		
		return unit;
	}
	
	/**
	 * Regi Unit을 생성한다.
	 *
	 * @param r
	 * @return
	 */
	private Element createRegiUnit(Record r) {
		Element unit = new Element("unit");
		
		unit.addContent(this.createNewElement("type", r.getString("unitType")));
		unit.addContent(this.createNewElement("text", r.getString("unitText")));
		unit.addContent(this.createNewElement("count", r.getString("unitCount")));
		unit.addContent(this.createNewElement("amount", r.getString("unitAmt")));
		unit.addContent(this.createNewElement("enuriamount", r.getString("unitEnuriAmt")));
		unit.addContent(this.createNewElement("realamount", r.getString("unitRealAmt")));

		if (r.getInt("unitCount") > 0) {
			Element unitlist = new Element("unitlist");
			Element subUnit = new Element("unit");
			subUnit.addContent(this.createNewElement("type", r.getString("unitType")));
			subUnit.addContent(this.createNewElement("text", r.getString("unitText")));
			subUnit.addContent(this.createNewElement("count", r.getString("unitCount")));
			subUnit.addContent(this.createNewElement("amount", r.getString("unitAmt")));
			subUnit.addContent(this.createNewElement("enuriamount", r.getString("unitEnuriAmt")));
			subUnit.addContent(this.createNewElement("realamount", r.getString("unitRealAmt")));
			
			unitlist.addContent(subUnit);
			
			unit.addContent(unitlist);
		}
		
		return unit;
	}
	
	private Element createNewElement(String elementName, String text) {
		Element e = new Element(elementName);
		e.setText(text);
		return e;
	}
	
	/**
	 * Regi Unit Data 처리
	 *
	 * @param unit
	 * @return
	 * @throws Exception
	 */
	private int saveRegiUnit(List<Map<String, Object>> unit) throws Exception {
		int insRow = 0, updRow = 0;
		
		for (int i = 0 ; i < unit.size() ; i++) {
			Map<String, Object> regiUnit = unit.get(i);
			try {
				if (fsspExactDAO.selectExistsRegiUnit(regiUnit).getInt("cnt") == 0) {
					insRow += fsspExactDAO.insertRegiUnit(regiUnit);
				}
				else {
					updRow += fsspExactDAO.updateRegiUnit(regiUnit);
				}
			}
			catch (Exception e) {
				throw new BizException("Regi Unit 데이터를 처리시 오류가 발생하였습니다.["+e.getMessage()+"]");
			}
		}
		
		return insRow + updRow;
	}
	
	/**
	 * Regi Unit 데이터를 생성한다.
	 *
	 * @param regiHdr
	 * @param type
	 * @param text
	 * @param count
	 * @param amt
	 * @param real
	 * @return
	 */
	private Map<String, Object> setRegiUnit(Map<String, Object> regiHdr, String type, String text, int count, BigDecimal amt, BigDecimal real, int seq) {
		return this.setRegiUnit(regiHdr, type, text, count, amt, new BigDecimal("0"), real, seq);
	}

	/**
	 * Regi Unit 데이터를 생성한다.
	 *
	 * @param regiHdr
	 * @param type
	 * @param text
	 * @param count
	 * @param amt
	 * @param enuri
	 * @param real
	 * @return
	 */
	private Map<String, Object> setRegiUnit(Map<String, Object> regiHdr, String type, String text, int count, BigDecimal amt, BigDecimal enuri, BigDecimal real, int seq) {
		Map<String, Object> unit = new HashMap<String, Object>();
		unit.put("unitType", type);
		unit.put("unitText", text);
		unit.put("unitCount", count);
		unit.put("unitAmt", amt);
		unit.put("unitEnuriAmt", enuri);
		unit.put("unitRealAmt", real);
		unit.put("unitSeq", seq);
		unit.putAll(regiHdr);
		
		return unit;
	}
}
 