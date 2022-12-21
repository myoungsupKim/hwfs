package com.hwfs.fs.fse.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fse.dao.EventUtensilPopDAO;
import com.hwfs.fs.fse.dao.UtensilPopDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 사업부 기기/기물 조회 팝업하는 EventUtensilPop Service Implementation
 * 
 * @ClassName EventUtensilPopServiceImpl.java
 * @Description EventUtensilPopServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.04    김미경        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김미경
 * @since 2015.06.04
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fse/eventUtensilPopService")
public class EventUtensilPopServiceImpl extends DefaultServiceImpl implements EventUtensilPopService {

	/** EventUtensilPopDAO Bean 생성 */
	@Resource(name = "/fs/fse/eventUtensilPopDAO")
	private EventUtensilPopDAO eventUtensilPopDAO;
	

	/**
	 * 사업부 기기/기물 조회 팝업 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return eventUtensilPopDAO.selectList(mapParam);
	}

	/**
	 * 콤보용 코드 목록을 조회한다. (대분류, 중분류)
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public Map<String, RecordSet> selectCodeList(Map<String, Object> mapParam) throws Exception {
		
		RecordSet rs1 = eventUtensilPopDAO.selectCodeLclass(mapParam);
		RecordSet rs2 = eventUtensilPopDAO.selectCodeMclass(mapParam);
		
		Map<String, RecordSet> rsMap = new HashMap<String, RecordSet>();
		rsMap.put("codeLclass", rs1);
		rsMap.put("codeMclass", rs2);
		return rsMap;
	}

}
