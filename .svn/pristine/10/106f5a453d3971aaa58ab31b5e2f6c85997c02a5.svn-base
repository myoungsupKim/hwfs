package com.hwfs.fs.fse.service;

import hone.core.util.record.RecordSet;

import java.util.Map;
import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fse.dao.EventPopDAO;

/**
 * 이벤트 조회 팝업하는 EventPop Service Implementation
 *
 * @ClassName EventPopServiceImpl.java
 * @Description EventPopServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.11    남기빈        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 남기빈
 * @since 2015.03.11
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fse/eventPopService")
public class EventPopServiceImpl extends DefaultServiceImpl implements EventPopService {

    /** EventPopDAO Bean 생성 */
    @Resource(name = "/fs/fse/eventPopDAO")
    private EventPopDAO eventPopDAO;

    /**
     * 이벤트 Master 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @see com.hwfs.fs.fse.service.EventPopService#selectEventPopList(java.util.Map)
    */
    @Override
    public RecordSet selectEventPopList(Map<String, Object> mapParam) throws Exception {
        return eventPopDAO.selectEventPopList(mapParam);
    }

    /**
     * 이벤트 Master 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @see com.hwfs.fs.fse.service.EventPopService#selectEventPopList(java.util.Map)
     */
    @Override
    public RecordSet selectEventProcessInfoList(Map<String, Object> mapParam) throws Exception {
    	return eventPopDAO.selectEventProcessInfoList(mapParam);
    }

	/**
	 * 콤보용 코드 목록을 조회한다. (분류, 테마)
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public Map<String, RecordSet> selectCodeList() throws Exception {
		
		RecordSet rs1 = eventPopDAO.selectCodeMclass();
		RecordSet rs2 = eventPopDAO.selectCodeSclass();
		
		Map<String, RecordSet> rsMap = new HashMap<String, RecordSet>();
		rsMap.put("codeMclass", rs1);
		rsMap.put("codeSclass", rs2);
		return rsMap;
	}
}
