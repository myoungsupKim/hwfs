package com.hwfs.ei.isa.service;

import hone.core.util.record.Record;
import hone.hanwha.CustomAnnotaion.CustomAnnotationDefinition;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

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
import com.hwfs.ei.cmn.RequestUtils;
import com.hwfs.ei.cmn.ResponseData;
import com.hwfs.ei.isa.dao.FsspGoodsDAO;
import com.hwfs.ei.isa.dao.FsspIrisDAO;

 /**
 * 특판상품관리하는 FsspGoods Service Implementation
 * 
 * @ClassName FsspGoodsServiceImpl.java
 * @Description FsspGoodsServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.12.17    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : 특판 김재섭
 * @since 2015.12.17
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ei/isa/fsspGoodsService")
public class FsspGoodsServiceImpl extends DefaultServiceImpl implements FsspGoodsService {
	@Resource(name="transactionManagerResortfo")
	private PlatformTransactionManager txManager;
	 
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** FsspGoodsDAO Bean 생성 */
	@Resource(name = "/ei/isa/fsspGoodsDAO")
	private FsspGoodsDAO fsspGoodsDAO;
	
	/** FsspIrisDAO Bean 생성 */
	@Resource(name = "/ei/isa/fsspIrisDAO")
	private FsspIrisDAO fsspIrisDAO;
	
	@CustomAnnotationDefinition(txId="ISA0303",Description="특판상품정보를 조회한다.")
	public JSONObject selectGoods(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.debug("******************************************************************************************************");
		logger.debug("  [[ 특판상품정보 조회 - ISA0303 ]]  ");
		logger.debug("* ISA 호출아이디 : " + header.getString("logId"));
		logger.debug("* ISA 호출Parameter : " + data.toString());
		logger.debug("******************************************************************************************************");
		Map<String, Object> parameter = RequestUtils.JSONObject2Map(data.getJSONObject("datas"));
		
		ResponseData res = new ResponseData();
		res.addData("res", fsspGoodsDAO.selectGoods(parameter));

		return res.send();
	}
	
	@CustomAnnotationDefinition(txId="ISA0304",Description="특판상품정보를 저장한다.")
	@Transactional(propagation=Propagation.REQUIRED)
	public JSONObject saveGoods(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.debug("******************************************************************************************************");
		logger.debug("  [[ 특판상품정보 저장 - ISA0304 ]]  ");
		logger.debug("* ISA 호출아이디 : " + header.getString("logId"));
		logger.debug("* ISA 호출Parameter : " + data.toString());
		logger.debug("******************************************************************************************************");
		Map<String, Object> sendData = new HashMap<String, Object>();
		JSONArray datas = data.getJSONArray("datas");
		TransactionStatus txStatus = txManager.getTransaction(new DefaultTransactionDefinition());

		try {
			for (int i = 0 ; i < datas.length() ; i++) {
				Map<String, Object> parameter = RequestUtils.JSONObject2Map(datas.getJSONObject(i));
				
				if ("I".equals(parameter.get("action").toString())) {
					try {
						fsspGoodsDAO.insertGoods(parameter);
					}
					catch (Exception ept) {
						throw new BizException("상품을 생성시에 오류가 발생하였습니다.");
					}
					
					try {
						fsspGoodsDAO.insertPrice(parameter);
					}
					catch (Exception ept) {
						throw new BizException("상품 가격정보를 생성시에 오류가 발생하였습니다.");
					}
	
					//IRIS 상품 생성/수정
					Record r1 = fsspIrisDAO.selectExistsGoods(parameter);
					
					if (r1.getInt("cnt") > 0) {
						try {
							fsspIrisDAO.updateGoods(parameter);
						}
						catch (Exception ept) {
							throw new BizException("상품을 수정시에 오류가 발생하였습니다.[IRIS시스템]");
						}
					}
					else {
						try {
							fsspIrisDAO.insertGoods(parameter);
						}
						catch (Exception ept) {
							throw new BizException("상품을 생성시에 오류가 발생하였습니다.[IRIS시스템]");
						}
					}
	
					//IRIS 상품가격 생성/수정
					Record r2 = fsspIrisDAO.selectExistsPrice(parameter);
					
					if (r2.getInt("cnt") > 0) {
						try {
							fsspIrisDAO.updatePrice(parameter);
						}
						catch (Exception ept) {
							throw new BizException("상품 가격정보를 수정시에 오류가 발생하였습니다.[IRIS시스템]");
						}
					}
					else {
						try {
							fsspIrisDAO.insertPrice(parameter);
						}
						catch (Exception ept) {
							throw new BizException("상품 가격정보를 생성시에 오류가 발생하였습니다.[IRIS시스템]");
						}
					}
				}
				else {
					try {
						fsspGoodsDAO.updateGoods(parameter);
					}
					catch (Exception ept) {
						throw new BizException("상품을 수정시에 오류가 발생하였습니다.");
					}
					
					try {
						fsspGoodsDAO.updatePrice(parameter);
					}
					catch (Exception ept) {
						throw new BizException("상품 가격정보를 수정시에 오류가 발생하였습니다.");
					}
	
					//IRIS 상품 생성/수정
					Record r1 = fsspIrisDAO.selectExistsGoods(parameter);
					
					if (r1.getInt("cnt") > 0) {
						try {
							fsspIrisDAO.updateGoods(parameter);
						}
						catch (Exception ept) {
							throw new BizException("상품을 수정시에 오류가 발생하였습니다.[IRIS시스템]");
						}
					}
					else {
						try {
							fsspIrisDAO.insertGoods(parameter);
						}
						catch (Exception ept) {
							throw new BizException("상품을 생성시에 오류가 발생하였습니다.[IRIS시스템]");
						}
					}
	
					//IRIS 상품가격 생성/수정
					Record r2 = fsspIrisDAO.selectExistsPrice(parameter);
					
					if (r2.getInt("cnt") > 0) {
						try {
							fsspIrisDAO.updatePrice(parameter);
						}
						catch (Exception ept) {
							throw new BizException("상품 가격정보를 수정시에 오류가 발생하였습니다.[IRIS시스템]");
						}
					}
					else {
						try {
							fsspIrisDAO.insertPrice(parameter);
						}
						catch (Exception ept) {
							throw new BizException("상품 가격정보를 생성시에 오류가 발생하였습니다.[IRIS시스템]");
						}
					}
				}
			}
			txManager.commit(txStatus);
		}
		catch (Exception e) {
			txManager.rollback(txStatus);
			throw e;
		}
		
		sendData.put("status", "S");
		sendData.put("message", "정상적으로 처리하였습니다.");
		
		ResponseData res = new ResponseData();
		res.addData("res", sendData);

		return res.send();
	}
}
