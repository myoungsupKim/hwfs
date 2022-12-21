package com.hwfs.guide.sample.service;

import hone.hanwha.CustomAnnotaion.CustomAnnotationDefinition;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.guide.sample.dao.ExtIfTableDAO;

 /**
 * ExtIfTableServiceImpl에 대한 설명 작성
 * @ClassName ExtIfTableServiceImpl.java
 * @Description ExtIfTableServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 7. 30.   taiho        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 taiho
 * @since 2015. 7. 30.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service
public class ExtIfTableServiceImpl extends DefaultServiceImpl implements ExtIfTableService {
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	@Resource(name="/guide/sample/extIfTableDAO")
	private ExtIfTableDAO extIfTableDAO;
	
	/**
	 * saveData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param txHeader
	 * @param txData
	 * @param txResult
	 * @return
	 * @throws Exception
	 * @see com.hwfs.guide.sample.service.ExtIfTableService#saveData(org.json.JSONObject, org.json.JSONObject, org.json.JSONObject)
	*/
	@SuppressWarnings("unchecked")
	@CustomAnnotationDefinition(txId="ExtIfTable",Description="식권자판기 인터페이스용 샘플 Service")
	public JSONObject saveData(JSONObject txHeader, JSONObject txData,
			JSONObject txResult) throws Exception {
		
		JSONObject processResult = new JSONObject();
		JSONObject result = new JSONObject();
		int insRow = 0;
		
		logger.debug("★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★");
		logger.debug(" HEADER INFO : " + txHeader.toString());
		logger.debug(" DATA   INFO : " + txData.toString());
		logger.debug(" RESULT INFO : " + txResult.toString());
		logger.debug("★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★");
		
		JSONArray datas = txData.getJSONArray("datas"); //KEY로 사용한 datas는 약속된 KEY로써 변경하지 마세요.
		
		for (int i=0 ; i < datas.length() ; i++) {
			Map<String, Object> rowData = new HashMap<String, Object>();
			
			rowData.put("empNo", datas.getJSONObject(i).getString("empNo"));
			rowData.put("empNm", datas.getJSONObject(i).getString("empNm"));
			rowData.put("deptNm", datas.getJSONObject(i).getString("deptNm"));
			
			insRow += extIfTableDAO.insert(rowData);
		}
		
		//식권발급기 쪽으로 전달하고자하는 메시지등을 기술한다.
		processResult.put("procCount", insRow);
		
		result.put("data", processResult);
		
		return result;
	}

}
