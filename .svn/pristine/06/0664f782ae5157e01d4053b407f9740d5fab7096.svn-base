package com.hwfs.ei.isa.service;

import hone.core.util.record.Record;
import hone.hanwha.CustomAnnotaion.CustomAnnotationDefinition;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.idgen.SequenceIdGenService;
import com.hwfs.ei.cmn.RequestUtils;
import com.hwfs.ei.cmn.ResponseData;
import com.hwfs.ei.isa.dao.FsspOrderDAO;

 /**
 * 통합회계에서 특판상품을 주문 처리하는 FsspOrder Service Implementation
 * 
 * @ClassName FsspOrderServiceImpl.java
 * @Description FsspOrderServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.11.23    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : 정보기획팀 김재섭
 * @since 2015.11.23
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service
public class FsspOrderServiceImpl extends DefaultServiceImpl implements FsspOrderService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** FsspOrderDAO Bean 생성 */
	@Resource(name = "/ei/isa/fsspOrderDAO")
	private FsspOrderDAO fsspOrderDAO;
	
	@Resource(name="fspPoSpecialSaleSeqGenSequence")
	private SequenceIdGenService fspPoSpecialSaleSeqGenSequence;

	/**
	 * 특판상품 주문 목록을 조회한다.
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
	@CustomAnnotationDefinition(txId="ISA0101",Description="특판상품정보를 조회한다.")
	public JSONObject selectGoodsList(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.debug("******************************************************************************************************");
		logger.debug("  [[ 특판상품정보 조회 - ISA0101 ]]  ");
		logger.debug("* ISA 호출아이디 : " + header.getString("logId"));
		logger.debug("* ISA 호출Parameter : " + data.toString());
		logger.debug("******************************************************************************************************");
		Map<String, Object> parameter = RequestUtils.JSONObject2Map(data.getJSONObject("datas"));
		
		ResponseData res = new ResponseData();
		res.addData("res", fsspOrderDAO.selectGoodsList(parameter));

		return res.send();
	}

	/**
	 * 상품주문 내역을 조회한다.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 * @see com.hwfs.ei.isa.service.FsspOrderService#selectGoodsOrderList(org.json.JSONObject, org.json.JSONObject, org.json.JSONObject)
	*/
	@CustomAnnotationDefinition(txId="ISA0104",Description="상품주문 내역을 조회한다.")
	public JSONObject selectGoodsOrderList(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.debug("******************************************************************************************************");
		logger.debug("  [[ 장바구니 조회 - ISA0104 ]]  ");
		logger.debug("* ISA 호출아이디 : " + header.getString("logId"));
		logger.debug("* ISA 호출Parameter : " + data.toString());
		logger.debug("******************************************************************************************************");
		Map<String, Object> parameter = RequestUtils.JSONObject2Map(data.getJSONObject("datas"));
		
		ResponseData res = new ResponseData();
		res.addData("res", fsspOrderDAO.selectGoodsOrderList(parameter));

		return res.send();
	}
	
	/**
	 * 상품 주문을 처리한다.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 * @see com.hwfs.ei.isa.service.FsspOrderService#saveOrder(org.json.JSONObject, org.json.JSONObject, org.json.JSONObject)
	*/
	@CustomAnnotationDefinition(txId="ISA0105",Description="상품주문을 처리한다.")
	public JSONObject saveOrder(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.debug("******************************************************************************************************");
		logger.debug("  [[ 상품주문처리 - ISA0105 ]]  ");
		logger.debug("* ISA 호출아이디 : " + header.getString("logId"));
		logger.debug("* ISA 호출Parameter : " + data.toString());
		logger.debug("******************************************************************************************************");
		int insRows = 0;
		int updRows = 0;
		int delRows = 0;
		List<Map<String, Object>> sendDatas = new ArrayList<Map<String,Object>>();
		JSONArray datas = data.getJSONArray("datas");
		boolean isOrder = true;
		
		for (int i = 0 ; i < datas.length() ; i++) {
			Map<String, Object> parameter = RequestUtils.JSONObject2Map(datas.getJSONObject(i));
			Map<String, Object> sendStatus = new HashMap<String, Object>();
			
			//ordQty라는 Key가 없는 경우에는 prQty를 ordQty로 설정한다.
			if (!parameter.containsKey("ordQty")) parameter.put("ordQty", parameter.get("prQty"));
			
			Record r = fsspOrderDAO.selectValidation(parameter);
			
			if (!"D".equals(parameter.get("action").toString()) && "Y".equals(r.getString("stockYn"))) {
				sendStatus.put("status", "F");
				sendStatus.put("message", "주문 가능한 재고가 부족합니다.");
				
				sendDatas.add(sendStatus);
				isOrder = false;
			}
			
			if (!"D".equals(parameter.get("action").toString()) && "Y".equals(r.getString("lastTimeYn"))) {
				sendStatus.put("status", "F");
				sendStatus.put("message", "금일 주문시간이 종료되었습니다.");
				
				sendDatas.add(sendStatus);
				isOrder = false;
			}

			if (!"D".equals(parameter.get("action").toString()) && "Y".equals(r.getString("lastYn"))) {
				sendStatus.put("status", "F");
				sendStatus.put("message", "주문 가능일이 종료되었습니다.");
				
				sendDatas.add(sendStatus);
				isOrder = false;
			}

			if (isOrder) {				
				//추가
				if ("I".equals(parameter.get("action").toString())) {
					parameter.put("spId", BigDecimal.valueOf(Long.parseLong(fspPoSpecialSaleSeqGenSequence.getNextStringId().trim())));
					logger.debug("주문추가 : " + parameter.toString());
					insRows += fsspOrderDAO.insertOrder(parameter);
					fsspOrderDAO.insertOrderInfo(parameter);
				}
				//수정
				else if ("U".equals(parameter.get("action").toString())) {
					logger.debug("주문수정 : " + parameter.toString());
					updRows += fsspOrderDAO.updateOrder(parameter);
					fsspOrderDAO.updateOrderInfo(parameter);
				}
				//삭제
				else if ("D".equals(parameter.get("action").toString())) {
					logger.debug("주문취소 : " + parameter.toString());
					parameter.put("lineStatus", "취소");
					delRows += fsspOrderDAO.updateOrder(parameter);
				}
				sendStatus.put("status", "S");
				sendStatus.put("message", "정상적으로 처리하였습니다.");
				
				sendDatas.add(sendStatus);
			}
			
			sendStatus.put("seasonNum", parameter.get("seasonNum"));
			sendStatus.put("itemCode", parameter.get("itemCode"));
			sendStatus.put("itemName", parameter.get("itemName"));
			
		}
		logger.debug("총 처리건수 : " + String.valueOf(insRows+updRows+delRows));
		logger.debug("----------------------------------------------------------");
		
		ResponseData res = new ResponseData();
		res.addData("res", sendDatas);

		return res.send();
	}
	
	/**
	 * 특정상품, 시즌에 대하여 주문가능을 체크한다.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 * @see com.hwfs.ei.isa.service.FsspOrderService#selectValidation(org.json.JSONObject, org.json.JSONObject, org.json.JSONObject)
	*/
	@CustomAnnotationDefinition(txId="ISA0106",Description="특정상품 시즌에 대하여 주문가능 시간을 체크한다.")
	public JSONObject selectValidation(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.debug("******************************************************************************************************");
		logger.debug("  [[ 주문가능체크 - ISA0106 ]]  ");
		logger.debug("* ISA 호출아이디 : " + header.getString("logId"));
		logger.debug("* ISA 호출Parameter : " + data.toString());
		logger.debug("******************************************************************************************************");
		Map<String, Object> parameter = RequestUtils.JSONObject2Map(data.getJSONObject("datas"));
		
		ResponseData res = new ResponseData();
		res.addData("res", fsspOrderDAO.selectValidation(parameter));

		return res.send();
	}
}
