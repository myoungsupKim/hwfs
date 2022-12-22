package com.hwfs.sc.scu.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

/**
* 사용자의 권한을 변경하는 UserRoleChng DAO
*
* @ClassName UserRoleChngDAO.java
* @Description UserRoleChngDAO Class
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2015.05.18   	김재섭        최초생성
* </pre>
* @author FC종합전산구축 : COM 김재섭
* @since 2015.05.18
* @version 1.0
* @see
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
@Repository("/sc/scu/userRoleChngDAO")
public class UserRoleChngDAO extends DefaultDAO {

    /**
     * 사용자 권한 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("sc.scu.userRoleChngDAO.selectList", mapParam);
    }

    /**
     * 사용자 권한(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insert(Map<String, Object> mapParam) throws Exception {
        return super.update("sc.scu.userRoleChngDAO.insert", mapParam);
    }

    /**
     * 사용자 권한(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int update(Map<String, Object> mapParam) throws Exception {
        return super.update("sc.scu.userRoleChngDAO.update", mapParam);
    }

    /**
     * 사용자 권한(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int delete(Map<String, Object> mapParam) throws Exception {
        return super.update("sc.scu.userRoleChngDAO.delete", mapParam);
    }

    /**
     * 시스템 권한변경 요청 그룹웨어 상신
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Record selectGwDraftMst(Map<String, Object> parameter) throws Exception {
        return super.queryForRecord("sc.scu.userRoleChngDAO.selectGwDraftMst", parameter);
    }

    /**
     * 상신 후 instanceId를 저장 한다.
     *
     * @param mapParam
     * @return
     */
    public int saveGwInstanceId(Map<String, Object> parameter) throws Exception {
        return super.update("sc.scu.userRoleChngDAO.saveGwInstanceId", parameter);
    }

}
