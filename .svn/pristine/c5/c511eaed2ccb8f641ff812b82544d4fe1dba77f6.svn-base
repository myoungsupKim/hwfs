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
import com.hwfs.ei.isa.dao.FsspRptDAO;

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
@Service
public class FsspRptServiceImpl extends DefaultServiceImpl implements FsspRptService {
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** FsspExactDAO Bean 생성 */
	@Resource(name = "/ei/isa/fsspRptDAO")
	private FsspRptDAO fsspRptDAO;
	
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
	@CustomAnnotationDefinition(txId="ISA9001",Description="팀별 실적을 조회한다.")
	public JSONObject selectTeam(JSONObject header, JSONObject data, JSONObject result) throws Exception {
		logger.debug("******************************************************************************************************");
		logger.debug("  [[ 팀별 실적조회 - ISA9001 ]]  ");
		logger.debug("* ISA 호출아이디 : " + header.getString("logId"));
		logger.debug("* ISA 호출Parameter : " + data.toString());
		logger.debug("******************************************************************************************************");
		Map<String, Object> parameter = RequestUtils.JSONObject2Map(data.getJSONObject("datas"));
		
		ResponseData res = new ResponseData();
		res.addData("res", fsspRptDAO.selectTeam(parameter));

		return res.send();
	}
}
 