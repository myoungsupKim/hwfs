package com.hwfs.ls.lcm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 검체유형 시험항목 관리 Dao Class
 *
 * @ClassName SpecmTypeTestArticleMappMgmtDAO.java
 * @Description SpecmTypeTestArticleMappMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 16.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3. 16.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ls/lcm/specmTypeTestArticleMappMgmtDAO")
public class SpecmTypeTestArticleMappMgmtDAO extends DefaultDAO {

    /**
     * 검체유형 시험항목에 대하여 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.specmTypeTestArticleMappMgmtDAO.selectList", parameter);
    }

    /**
     * 검체유형 시험항목을 생성한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.specmTypeTestArticleMappMgmtDAO.insertList", parameter);
    }

    /**
     * 검체유형 시험항목을 삭제한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.specmTypeTestArticleMappMgmtDAO.deleteList", parameter);
    }

    /**
     * 전체를 삭제
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteAllList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.specmTypeTestArticleMappMgmtDAO.deleteAllList", parameter);
    }

    /**
     * 검체타입을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public String selectSpecmType(Map<String, Object> parameter) throws Exception {
        return (String) super.queryForObject("ls.lcm.specmTypeTestArticleMappMgmtDAO.selectSpecmType", parameter, null);
    }

    /**
     * 엑셀업로드 검체유형 시험항목을 생성한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertExlList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.specmTypeTestArticleMappMgmtDAO.insertExlList", parameter);
    }

    /**
     * 검체유형 시험항목에 대하여 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectMappingList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.specmTypeTestArticleMappMgmtDAO.selectMappingList", parameter);
    }
    
}
