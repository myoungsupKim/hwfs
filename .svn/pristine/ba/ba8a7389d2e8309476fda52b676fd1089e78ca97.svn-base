package com.hwfs.ft.fsi.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

import hone.core.util.record.RecordSet;

/**
* 
*
* @ClassName 
* @Description 
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*               최초생성
* </pre>
* @author 
* @since 
* @version 1.0
* @see
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
@Repository("/ft/fsi/pbItemMgmtDAO")
public class PbItemMgmtDAO extends DefaultDAO {

    /**
     * 조회
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fsi.pbItemMgmtDAO.selectList", mapParam);
    }
    
    public List<Map> selectItemCodeList(String itemCode) throws Exception {
    	Map<String, Object> map = new HashMap<String, Object>();
        map.put("itemCode", itemCode);
    	return super.queryForList("ft.fsi.pbItemMgmtDAO.selectItemCodeList", map);
    }
    
    /**
     * 저장
     *
     * @param mapParam
     * @return
     */
    public int saveList(Map<String, Object> mapParam) throws Exception {
    	return super.update("ft.fsi.pbItemMgmtDAO.saveList", mapParam);
    
    }
    
    /**
     * 일괄 업데이트
     *
     * @param mapParam
     * @return
     */
    public int updateList(Map<String, Object> mapParam) throws Exception {
    	return super.update("ft.fsi.pbItemMgmtDAO.updateList", mapParam);
    
    }
}
