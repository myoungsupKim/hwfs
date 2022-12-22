package com.hwfs.ls.lcm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 담당자 관리 Dao Class
 *
 * @ClassName UserMgmtDAO.java
 * @Description UserMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 9.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3. 9.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ls/lcm/userMgmtDAO")
public class UserMgmtDAO extends DefaultDAO {

    /**
     * 담당자 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectUserMgmtList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.userMgmtDAO.selectUserMgmtList", parameter);
    }

    /**
     * 담당자 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectUserList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.userMgmtDAO.selectUserList", parameter);
    }

    /**
     * 담당자를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int selectUser(Map<String, Object> parameter) throws Exception {
        return super.queryForInt("ls.lcm.userMgmtDAO.selectUser", parameter);
    }

    /**
     * 담당자를 생성한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertUserList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.userMgmtDAO.insertUserList", parameter);
    }

    /**
     * 담당자를 수정한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateUserList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.userMgmtDAO.updateUserList", parameter);
    }

    /**
     * 담당자를 삭제한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteUserList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.userMgmtDAO.deleteUserList", parameter);
    }

    /**
     * 식품연구소 사원을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectHrUserList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.userMgmtDAO.selectHrUserList", parameter);
    }

}
