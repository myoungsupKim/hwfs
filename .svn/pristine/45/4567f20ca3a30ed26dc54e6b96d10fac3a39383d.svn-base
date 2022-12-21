package com.hwfs.ei.cmn.service;

import hone.hanwha.CustomAnnotaion.CustomAnnotationDefinition;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ei.cmn.RequestUtils;
import com.hwfs.ei.cmn.ResponseData;
import com.hwfs.ei.cmn.dao.FsspCommonDAO;
import com.hwfs.ei.isa.dao.FsspIrisDAO;

 /**
 * 통합회계에서 공통으로 호출하는 FsspCommon Service Implementation
 * 
 * @ClassName FsspCommonServiceImpl.java
 * @Description FsspCommonServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.11.23    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김재섭
 * @since 2015.11.23
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service
public class FsspCommonServiceImpl extends DefaultServiceImpl implements FsspCommonService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** FsspCommonDAO Bean 생성 */
	@Resource(name = "/ei/cmn/fsspCommonDAO")
	private FsspCommonDAO fsspCommonDAO;
	
	/** FsspIrisDAO Bean 생성 */
	@Resource(name = "/ei/isa/fsspIrisDAO")
	private FsspIrisDAO fsspIrisDAO;
	
	/**
	 * 특판 시즌정보 목록을 조회한다.
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
	@CustomAnnotationDefinition(txId="ISA0001",Description="특판 시즌정보를 조회한다.")
	public JSONObject selectSeason(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		
		logger.info("******************************************************************************************************");
		logger.info("  [[ 특판시즌정보 조회 ]]  ");
		logger.info("* ISA 호출아이디 : " + header.getString("logId"));
		logger.info("******************************************************************************************************");
		
		ResponseData res = new ResponseData();
		res.addData("res", fsspCommonDAO.selectSeason(new HashMap<String, Object>()));

		return res.send();
	}

	/**
	 * 공통코드를 조회한다.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 * @see com.hwfs.ei.cmn.service.FsspCommonService#selectCommonCode(org.json.JSONObject, org.json.JSONObject, org.json.JSONObject)
	*/
	@CustomAnnotationDefinition(txId="ISA0002",Description="공통코드를 조회한다.")
	public JSONObject selectCommonCode(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.info("******************************************************************************************************");
		logger.info("  [[ 공통코드정보 조회 ]]  ");
		logger.info("* ISA 호출아이디 : " + header.getString("logId"));
		
		Map<String, Object> parameter = RequestUtils.JSONObject2Map(data.getJSONObject("datas"));
		
		logger.info("* 추출Parameter : " + parameter.toString());
		logger.info("******************************************************************************************************");
		
		ResponseData res = new ResponseData();
		res.addData("res", fsspCommonDAO.selectCommonCode(parameter));

		return res.send();
	}

	/**
	 * 상품분류3에 해당하는 자료를 조회한다.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 */
	@CustomAnnotationDefinition(txId="ISA0003",Description="상품분류3에 해당하는 코드/명을 조회한다.")
	public JSONObject selectItemClass3(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.info("******************************************************************************************************");
		logger.info("  [[ 공통코드정보 조회 ]]  ");
		logger.info("* ISA 호출아이디 : " + header.getString("logId"));
		
		Map<String, Object> parameter = RequestUtils.JSONObject2Map(data.getJSONObject("datas"));
		
		logger.info("* 추출Parameter : " + parameter.toString());
		logger.info("******************************************************************************************************");
		
		ResponseData res = new ResponseData();
		res.addData("res", fsspCommonDAO.selectItemClass3(parameter));

		return res.send();
	}
	
	/**
	 * 상품분류4에 해당하는 자료를 조회한다.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 */
	@CustomAnnotationDefinition(txId="ISA0004",Description="상품분류4에 해당하는 코드/명을 조회한다.")
	public JSONObject selectItemClass4(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.info("******************************************************************************************************");
		logger.info("  [[ 공통코드정보 조회 ]]  ");
		logger.info("* ISA 호출아이디 : " + header.getString("logId"));
		
		Map<String, Object> parameter = RequestUtils.JSONObject2Map(data.getJSONObject("datas"));
		
		logger.info("* 추출Parameter : " + parameter.toString());
		logger.info("******************************************************************************************************");
		
		ResponseData res = new ResponseData();
		res.addData("res", fsspCommonDAO.selectItemClass4(parameter));

		return res.send();
	}
	
	/**
	 * PO Code를 조회한다.
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 * @see com.hwfs.ei.cmn.service.FsspCommonService#selectPoCode(org.json.JSONObject, org.json.JSONObject, org.json.JSONObject)
	*/
	@CustomAnnotationDefinition(txId="ISA0005",Description="PO Code를 조회한다.")
	public JSONObject selectPoCode(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.info("******************************************************************************************************");
		logger.info("  [[ 공통코드정보 조회 ]]  ");
		logger.info("* ISA 호출아이디 : " + header.getString("logId"));
		
		Map<String, Object> parameter = RequestUtils.JSONObject2Map(data.getJSONObject("datas"));
		
		logger.info("* 추출Parameter : " + parameter.toString());
		logger.info("******************************************************************************************************");
		
		ResponseData res = new ResponseData();
		res.addData("res", fsspCommonDAO.selectPoCode(parameter));

		return res.send();
	}
	
	/**
	 * selectBu 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param header
	 * @param data
	 * @param result
	 * @return
	 * @throws Exception
	 * @see com.hwfs.ei.cmn.service.FsspCommonService#selectBu(org.json.JSONObject, org.json.JSONObject, org.json.JSONObject)
	*/
	@CustomAnnotationDefinition(txId="ISA0006",Description="부문(BU)를 조회한다.")
	public JSONObject selectBu(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.info("******************************************************************************************************");
		logger.info("  [[ 부문(BU)를 조회 - ISA0006]]  ");
		logger.info("* ISA 호출아이디 : " + header.getString("logId"));
		
		Map<String, Object> parameter = RequestUtils.JSONObject2Map(data.getJSONObject("datas"));
		
		logger.info("* 추출Parameter : " + parameter.toString());
		logger.info("******************************************************************************************************");
		
		ResponseData res = new ResponseData();
		res.addData("res", fsspCommonDAO.selectBu(parameter));

		return res.send();
	}
	
	@CustomAnnotationDefinition(txId="ISA0007",Description="매출계정을(를) 조회한다.")
	public JSONObject selectSellType(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.info("******************************************************************************************************");
		logger.info("  [[ 매출계정조회 - ISA0007]]  ");
		logger.info("* ISA 호출아이디 : " + header.getString("logId"));
		
		Map<String, Object> parameter = RequestUtils.JSONObject2Map(data.getJSONObject("datas"));
		
		logger.info("* 추출Parameter : " + parameter.toString());
		logger.info("******************************************************************************************************");
		
		ResponseData res = new ResponseData();
		res.addData("res", fsspIrisDAO.selectSellType(parameter));

		return res.send();
	}
	
	@CustomAnnotationDefinition(txId="ISA0008",Description="매출형태을(를) 조회한다.")
	public JSONObject selectCmisYn(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.info("******************************************************************************************************");
		logger.info("  [[ 매출형태조회 - ISA0008]]  ");
		logger.info("* ISA 호출아이디 : " + header.getString("logId"));
		
		Map<String, Object> parameter = RequestUtils.JSONObject2Map(data.getJSONObject("datas"));
		
		logger.info("* 추출Parameter : " + parameter.toString());
		logger.info("******************************************************************************************************");
		
		ResponseData res = new ResponseData();
		res.addData("res", fsspIrisDAO.selectCmisYn(parameter));

		return res.send();
	}
	
	@CustomAnnotationDefinition(txId="ISA0009",Description="FO 매출유형을(를) 조회한다.")
	public JSONObject selectDrctCmisCd(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.info("******************************************************************************************************");
		logger.info("  [[ FO 매출유형조회 - ISA0009]]  ");
		logger.info("* ISA 호출아이디 : " + header.getString("logId"));
		
		Map<String, Object> parameter = RequestUtils.JSONObject2Map(data.getJSONObject("datas"));
		
		logger.info("* 추출Parameter : " + parameter.toString());
		logger.info("******************************************************************************************************");
		
		ResponseData res = new ResponseData();
		res.addData("res", fsspIrisDAO.selectDrctCmisCd(parameter));

		return res.send();
	}
	
	@CustomAnnotationDefinition(txId="ISA0010",Description="사업장 상품 생성여부.")
	public JSONObject selectCreateBrchItem(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.info("******************************************************************************************************");
		logger.info("  [[ 사업장 상품 생성여부 - ISA0010]]  ");
		logger.info("* ISA 호출아이디 : " + header.getString("logId"));
		
		Map<String, Object> parameter = RequestUtils.JSONObject2Map(data.getJSONObject("datas"));
		
		logger.info("* 추출Parameter : " + parameter.toString());
		logger.info("******************************************************************************************************");
		
		ResponseData res = new ResponseData();
		res.addData("res", fsspCommonDAO.selectCreateBrchItem(parameter));

		return res.send();
	}
	
	@CustomAnnotationDefinition(txId="ISA0011",Description="영업장 상품 생성여부.")
	public JSONObject selectCreateLocItem(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.info("******************************************************************************************************");
		logger.info("  [[ 영업장 상품 생성여부 - ISA0011]]  ");
		logger.info("* ISA 호출아이디 : " + header.getString("logId"));
		
		Map<String, Object> parameter = RequestUtils.JSONObject2Map(data.getJSONObject("datas"));
		
		logger.info("* 추출Parameter : " + parameter.toString());
		logger.info("******************************************************************************************************");
		
		ResponseData res = new ResponseData();
		res.addData("res", fsspCommonDAO.selectCreateLocItem(parameter));

		return res.send();
	}
}
