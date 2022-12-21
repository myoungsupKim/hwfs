package com.hwfs.ls.lum.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 폐액/폐기물 관리 Dao Class
 *
 * @ClassName WswtMgmtDAO.java
 * @Description WswtMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 29.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 4. 29.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ls/lum/wswtMgmtDAO")
public class WswtMgmtDAO extends DefaultDAO {

    /**
     * 폐액/폐기물에 대하여 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lum.wswtMgmtDAO.selectList", parameter);
    }

    /**
     * 폐액/폐기물을 생성한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertWswtList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lum.wswtMgmtDAO.insertWswtList", parameter);
    }

    /**
     * 폐액/폐기물을 수정한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateWswtList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lum.wswtMgmtDAO.updateWswtList", parameter);
    }

    /**
     * 폐액/폐기물을 삭제한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteWswtList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lum.wswtMgmtDAO.deleteWswtList", parameter);
    }

}
