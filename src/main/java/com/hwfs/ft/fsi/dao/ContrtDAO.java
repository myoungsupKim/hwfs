package com.hwfs.ft.fsi.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 창고 조회하는 Wh DAO
 *
 * @ClassName WhDAO.java
 * @Description WhDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.27   	kjj        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 kjj
 * @since 2015.03.27
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ft/fsi/contrtDAO")
public class ContrtDAO extends DefaultDAO {

    /**
     * 매출처 조회 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
    	if ( "70".equals(mapParam.get("cusVdCls")) ) {
    		return super.queryForRecordSet("ft.fsi.contrtDAO.selectList2", mapParam);
    	} else {
    		return super.queryForRecordSet("ft.fsi.contrtDAO.selectList", mapParam);
    	}
    }

}
