package com.hwfs.ls.lcm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 장기보존여부 시험항목 관리 Dao Class
 *
 * @ClassName LongStorageTestArticleMappMgmtDAO.java
 * @Description LongStorageTestArticleMappMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 12.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3. 12.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ls/lcm/longStorageTestArticleMappMgmtDAO")
public class LongStorageTestArticleMappMgmtDAO extends DefaultDAO {

    /**
     * 장기보존여부 시험항목에 대하여 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.longStorageTestArticleMappMgmtDAO.selectList", parameter);
    }

    /**
     * 장기보존여부 시험항목을 생성한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.longStorageTestArticleMappMgmtDAO.insertList", parameter);
    }

    /**
     * 장기보존여부 시험항목을 삭제한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.longStorageTestArticleMappMgmtDAO.deleteList", parameter);
    }

    /**
     * 전체를 삭제
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteAllList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.longStorageTestArticleMappMgmtDAO.deleteAllList", parameter);
    }

}
