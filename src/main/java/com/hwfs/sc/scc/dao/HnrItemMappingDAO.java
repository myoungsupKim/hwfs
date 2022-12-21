package com.hwfs.sc.scc.dao;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 조직에 대한 환경을 설정하는 HnrItemMapping DAO
 * 
 * @ClassName HnrItemMappingDAO.java
 * @Description HnrItemMappingDAO Class
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
@Repository("/sc/scc/hnrItemMappingDAO")
public class HnrItemMappingDAO extends DefaultDAO {
	
	public RecordSet selectHnrItemMapping(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scc.hnrItemMappingDAO.selectHnrItemMapping", mapParam);
	}
	
	public List<Map> selectItemCodeList(String itemCode, String itemType) throws Exception {
    	Map<String, Object> map = new HashMap<String, Object>();
        map.put("itemCode", itemCode);
        map.put("itemType", itemType);
    	return super.queryForList("sc.scc.hnrItemMappingDAO.selectItemCodeList", map);
    }
	
	public int insertHnrItemMapping(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scc.hnrItemMappingDAO.insertHnrItemMapping", mapParam);
	}

	public int updateOrgConfig01(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scc.hnrItemMappingDAO.updateOrgConfig01", mapParam);
	}

	public int deleteOrgConfig01(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scc.hnrItemMappingDAO.deleteOrgConfig01", mapParam);
	}
	
}
