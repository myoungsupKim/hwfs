package com.hwfs.guide.sample.service;

import hone.core.util.record.RecordSet;
import hone.hanwha.CustomAnnotaion.CustomAnnotationDefinition;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.guide.sample.dao.GuideSampleDAO;

/**
 * GuideJsonServiceImpl
 * @ClassName GuideJsonServiceImpl.java
 * @Description GuideJsonServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.19.   lsjmanse      최초생성
 *  2015.03.25.   kksoo         프로젝트에 맞게 조정
 * </pre>
 * @author FC종합전산구축 : HONE lsjmanse
 * @since 2015. 3. 25.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service
public class GuideJsonServiceImpl extends DefaultServiceImpl implements GuideJsonService{

	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** Guide Sample DAO */
	@Resource(name="/guide/sample/guideSampleDAO")
	private GuideSampleDAO guideSampleDAO;
	
	/**
	 * Json 처리 서비스 샘플 IF_SALE_INQ
	 *
	 * @param txHeader
	 * @param txData
	 * @param txResult
	 * @return JSONObject
	 * @throws Exception
	 * @see com.hwfs.guide.sample.service.GuideJsonService#IF_SALE_INQ(org.json.JSONObject, org.json.JSONObject, org.json.JSONObject)
	 */
	@CustomAnnotationDefinition(txId="IF_SALE_INQ",Description="pos 티켓발행 리소스.")
	public JSONObject IF_SALE_INQ(JSONObject txHeader, JSONObject txData, JSONObject txResult) throws Exception
	{
		//시스템 오류 테스트
		//String a = null;
		//logger.debug("에러유발" + a.indexOf("11"));
		
    	//Biz Exception 테스트용
    	//if (true)
    	//	throw super.processException("message.test03", new Object[]{"123","456"});

		Map<String, Object> parameter = new HashMap<String, Object>();
		RecordSet rs = guideSampleDAO.selectList(parameter);
		
		//반환할 결과 데이터를 설정 : key 값은 업무에 맞게 설정
		JSONObject result = new JSONObject();
		//result.put("if_id1", "추가데이터");
		result.put("resultList", rs);
		
		return result;
	}
	
	/**
	 * Json 처리 서비스 샘플 IF_TEST
	 * 
	 * @param txHeader
	 * @param txData
	 * @param txResult
	 * @return
	 * @throws Exception
	 * @see com.hwfs.guide.sample.service.GuideJsonService#IF_TEST(org.json.JSONObject, org.json.JSONObject, org.json.JSONObject)
	 */
	@CustomAnnotationDefinition(txId="IF_SALE_INQ2",Description="테스트 메소드 입니다.")
	public JSONObject IF_TEST(JSONObject txHeader, JSONObject txData, JSONObject txResult) throws Exception
	{
		logger.debug("메소드 2번입니다.");
		
		String posVer = (String) txData.get("posVer");
		
		logger.debug("posVer :." + posVer);
		
		
		
		JSONObject result = new JSONObject();		
		result.put("if_id2", "IF_SALE_INQ2");
		
		return result;
	}
	
}
