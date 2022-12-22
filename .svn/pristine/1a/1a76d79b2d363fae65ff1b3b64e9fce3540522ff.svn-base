package com.hwfs.ei.isa.service;

import hone.hanwha.CustomAnnotaion.CustomAnnotationDefinition;

import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ei.cmn.RequestUtils;
import com.hwfs.ei.cmn.ResponseData;
import com.hwfs.ei.isa.dao.FsspIrisDAO;

 /**
 * IRIS하는 FsspIris Service Implementation
 * 
 * @ClassName FsspIrisServiceImpl.java
 * @Description FsspIrisServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.12.16    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : IRIS 김재섭
 * @since 2015.12.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ei/isa/fsspIrisService")
public class FsspIrisServiceImpl extends DefaultServiceImpl implements FsspIrisService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** FsspIrisDAO Bean 생성 */
	@Resource(name = "/ei/isa/fsspIrisDAO")
	private FsspIrisDAO fsspIrisDAO;
	
	@CustomAnnotationDefinition(txId="ISA0301",Description="사업장 조회")
	public JSONObject selectBrch(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.debug("******************************************************************************************************");
		logger.debug("  [[ 사업장 조회 - ISA0301 ]]  ");
		logger.debug("* ISA 호출아이디 : " + header.getString("logId"));
		logger.debug("* ISA 호출Parameter : " + data.toString());
		logger.debug("******************************************************************************************************");
		Map<String, Object> parameter = RequestUtils.JSONObject2Map(data.getJSONObject("datas"));
		
		ResponseData res = new ResponseData();
		res.addData("res", fsspIrisDAO.selectBrch(parameter));

		return res.send();
	}
	
	@CustomAnnotationDefinition(txId="ISA0302",Description="영업장 조회")
	public JSONObject selectLoc(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.debug("******************************************************************************************************");
		logger.debug("  [[ 영업장 조회 - ISA0302 ]]  ");
		logger.debug("* ISA 호출아이디 : " + header.getString("logId"));
		logger.debug("* ISA 호출Parameter : " + data.toString());
		logger.debug("******************************************************************************************************");
		Map<String, Object> parameter = RequestUtils.JSONObject2Map(data.getJSONObject("datas"));
		
		ResponseData res = new ResponseData();
		res.addData("res", fsspIrisDAO.selectLoc(parameter));

		return res.send();
	}
	
	@CustomAnnotationDefinition(txId="ISA0305",Description="거래처 확인 조회")
	public JSONObject selectCustomer(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.debug("******************************************************************************************************");
		logger.debug("  [[ 거래처 확인 조회 - ISA0305 ]]  ");
		logger.debug("* ISA 호출아이디 : " + header.getString("logId"));
		logger.debug("* ISA 호출Parameter : " + data.toString());
		logger.debug("******************************************************************************************************");
		Map<String, Object> parameter = RequestUtils.JSONObject2Map(data.getJSONObject("datas"));
		
		ResponseData res = new ResponseData();
		res.addData("res", fsspIrisDAO.selectCustomer(parameter));

		return res.send();
	}
	
	@CustomAnnotationDefinition(txId="ISA0306",Description="POS번호 조회")
	public JSONObject selectPos(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.debug("******************************************************************************************************");
		logger.debug("  [[ POS번호 조회 - ISA0306 ]]  ");
		logger.debug("* ISA 호출아이디 : " + header.getString("logId"));
		logger.debug("* ISA 호출Parameter : " + data.toString());
		logger.debug("******************************************************************************************************");
		Map<String, Object> parameter = RequestUtils.JSONObject2Map(data.getJSONObject("datas"));
		
		ResponseData res = new ResponseData();
		res.addData("res", fsspIrisDAO.selectPos(parameter));

		return res.send();
	}
	
	@CustomAnnotationDefinition(txId="ISA0307",Description="VAN정보 조회")
	public JSONObject selectVanInfo(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.debug("******************************************************************************************************");
		logger.debug("  [[ VAN정보 조회 - ISA0307 ]]  ");
		logger.debug("* ISA 호출아이디 : " + header.getString("logId"));
		logger.debug("* ISA 호출Parameter : " + data.toString());
		logger.debug("******************************************************************************************************");
		Map<String, Object> parameter = RequestUtils.JSONObject2Map(data.getJSONObject("datas"));
		
		ResponseData res = new ResponseData();
		res.addData("res", fsspIrisDAO.selectVanInfo(parameter));

		return res.send();
	}
	
	@CustomAnnotationDefinition(txId="ISA0308",Description="영수증 타이틀 정보 조회")
	public JSONObject selectReceiptTitle(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.debug("******************************************************************************************************");
		logger.debug("  [[ 영수증 타이틀 정보 - ISA0308 ]]  ");
		logger.debug("* ISA 호출아이디 : " + header.getString("logId"));
		logger.debug("* ISA 호출Parameter : " + data.toString());
		logger.debug("******************************************************************************************************");
		Map<String, Object> parameter = RequestUtils.JSONObject2Map(data.getJSONObject("datas"));
		
		ResponseData res = new ResponseData();
		res.addData("res", fsspIrisDAO.selectReceiptTitle(parameter));

		return res.send();
	}
}
