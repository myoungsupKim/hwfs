package com.hwfs.ls.lcm.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

import hone.core.util.record.RecordSet;

/**
 * 기타검체유형 관리 Dao Class
 *
 * @ClassName EtcSpecmArticleMgmtDAO.java
 * @Description EtcSpecmArticleMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 17.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3. 17.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ls/lcm/etcSpecmArticleMgmtDAO")
public class EtcSpecmArticleMgmtDAO extends DefaultDAO {

    /**
     * 기타검체유형에 대하여 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.etcSpecmArticleMgmtDAO.selectList", parameter);
    }

    /**
     * 구매/자재에 대하여 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectItemList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.etcSpecmArticleMgmtDAO.selectItemList", parameter);
    }

    /**
     * 구매이력정보를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectTransItemList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.etcSpecmArticleMgmtDAO.selectTransItemList", parameter);
    }

    /**
     * 기타검체유형번호를 채번 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public String selectCreateCd(Map<String, Object> parameter) throws Exception {
        return (String) super.queryForObject("ls.lcm.etcSpecmArticleMgmtDAO.selectCreateCd", parameter, null);
    }

    /**
     * 기타검체유형에 대하여 건수를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int selectSpecmCnt(Map<String, Object> parameter) throws Exception {
        return super.queryForInt("ls.lcm.etcSpecmArticleMgmtDAO.selectSpecmCnt", parameter);
    }

    /**
     * 기타검체유형을 생성한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.etcSpecmArticleMgmtDAO.insertList", parameter);
    }

    /**
     * 기타검체유형을 수정한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.etcSpecmArticleMgmtDAO.updateList", parameter);
    }

    /**
     * 기타검체유형을 삭제한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.etcSpecmArticleMgmtDAO.deleteList", parameter);
    }

}
