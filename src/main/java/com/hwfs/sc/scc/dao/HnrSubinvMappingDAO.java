package com.hwfs.sc.scc.dao;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * HnrSubinvMapping DAO
 * 
 * @ClassName HnrSubinvMappingDAO.java
 * @Description HnrSubinvMappingDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  
 * </pre>
 * @author 
 * @since 
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scc/hnrSubinvMappingDAO")
public class HnrSubinvMappingDAO extends DefaultDAO {
	
	public RecordSet selectHnrSubinvMapping(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scc.hnrSubinvMappingDAO.selectHnrSubinvMapping", mapParam);
	}
	
	public List<Map> selectSubinvCodeList(String subinvCode, String subinvType) throws Exception {
    	Map<String, Object> map = new HashMap<String, Object>();
        map.put("subinvCode", subinvCode);
        map.put("subinvType", subinvType);
    	return super.queryForList("sc.scc.hnrSubinvMappingDAO.selectSubinvCodeList", map);
    }
	
	
	
	
	
	
	

	/**
	 * 조직 환경 설정(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertHnrSubinvMapping(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scc.hnrSubinvMappingDAO.insertHnrSubinvMapping", mapParam);
	}
	
	/**
	 * 조직 환경 설정(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateOrgConfig01(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scc.hnrSubinvMappingDAO.updateOrgConfig01", mapParam);
	}
	
	/**
	 * 조직 환경 설정(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteOrgConfig01(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scc.hnrSubinvMappingDAO.deleteOrgConfig01", mapParam);
	}
	
}
