package com.hwfs.ls.lcm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 검체유형 위험도매핑 관리 Dao Class
 *
 * @ClassName SpecmTypeDangerMappMgmtDAO.java
 * @Description SpecmTypeDangerMappMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3.12.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3.12.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ls/lcm/specmTypeDangerMappMgmtDAO")
public class SpecmTypeDangerMappMgmtDAO extends DefaultDAO {

    /**
     * 검체유형 위험도매핑에 대하여 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectSpecmDangerMappList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.specmTypeDangerMappMgmtDAO.selectSpecmDangerMappList", parameter);
    }

    /**
     * 검체유형 위험도매핑을 생성/수정한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateSpecmDangerMappList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.specmTypeDangerMappMgmtDAO.updateSpecmDangerMappList", parameter);
    }

    /**
     * 검체유형 위험도매핑을 삭제한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteSpecmDangerMappList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.specmTypeDangerMappMgmtDAO.deleteSpecmDangerMappList", parameter);
    }

    /**
     * 전체를 삭제
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteAllList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.specmTypeDangerMappMgmtDAO.deleteAllList", parameter);
    }

}
