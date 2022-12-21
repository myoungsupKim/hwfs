package com.hwfs.ls.lcm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 검체유형항목 관리 Dao Class
 *
 * @ClassName SpecmTypeArticleMgmtDAO.java
 * @Description SpecmTypeArticleMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 3.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3. 3.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ls/lcm/specmTypeArticleMgmtDAO")
public class SpecmTypeArticleMgmtDAO extends DefaultDAO {

    /**
     * 검체유형항목을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.specmTypeArticleMgmtDAO.selectList", parameter);
    }

    /**
     * 검체유형항목 대분류를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectMgrpList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.specmTypeArticleMgmtDAO.selectMgrpList", parameter);
    }

    /**
     * 검체유형항목 중분류를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectMcalssList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.specmTypeArticleMgmtDAO.selectMcalssList", parameter);
    }

    /**
     * 검체유형항목 소분류를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectSclassList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.specmTypeArticleMgmtDAO.selectSclassList", parameter);
    }

    /**
     * 검체유형항목 대분류코드를 채번 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public String selectMgrpCd(Map<String, Object> parameter) throws Exception {
        return (String) super.queryForObject("ls.lcm.specmTypeArticleMgmtDAO.selectMgrpCd", parameter, null);
    }

    /**
     * 검체유형항목 중분류코드를 채번 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public String selectMcalssCd(Map<String, Object> parameter) throws Exception {
        return (String) super.queryForObject("ls.lcm.specmTypeArticleMgmtDAO.selectMcalssCd", parameter, null);
    }

    /**
     * 검체유형항목 소분류코드를 채번 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public String selectSclassCd(Map<String, Object> parameter) throws Exception {
        return (String) super.queryForObject("ls.lcm.specmTypeArticleMgmtDAO.selectSclassCd", parameter, null);
    }

    /**
     * 검체유형항목 대분류를 생성한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertMgrpList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.specmTypeArticleMgmtDAO.insertMgrpList", parameter);
    }

    /**
     * 검체유형항목 대분류를 생성한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertMcalssList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.specmTypeArticleMgmtDAO.insertMcalssList", parameter);
    }

    /**
     * 검체유형항목 소분류를 생성한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertSclassList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.specmTypeArticleMgmtDAO.insertSclassList", parameter);
    }

    /**
     * 검체유형항목 대분류를 수정한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateMgrpList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.specmTypeArticleMgmtDAO.updateMgrpList", parameter);
    }

    /**
     * 검체유형항목 중분류를 수정한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateMcalssList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.specmTypeArticleMgmtDAO.updateMcalssList", parameter);
    }

    /**
     * 검체유형항목 소분류를 수정한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateSclassList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.specmTypeArticleMgmtDAO.updateSclassList", parameter);
    }

    /**
     * 검체유형항목을 대분류를 삭제한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteMgrpList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.specmTypeArticleMgmtDAO.deleteMgrpList", parameter);
    }

    /**
     * 검체유형항목을 중분류를 삭제한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteMcalssList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.specmTypeArticleMgmtDAO.deleteMcalssList", parameter);
    }

    /**
     * 검체유형항목을 소분류를 삭제한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteSclassList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.specmTypeArticleMgmtDAO.deleteSclassList", parameter);
    }

    /**
     * 검체유형항목 대분류 전체를 삭제한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteMgrpAllList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.specmTypeArticleMgmtDAO.deleteMgrpAllList", parameter);
    }

    /**
     * 검체유형항목 중분류 전체를 삭제한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteMcalssAllList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.specmTypeArticleMgmtDAO.deleteMcalssAllList", parameter);
    }

    /**
     * 검체유형항목 소분류 전체를 삭제한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteSclassAllList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.specmTypeArticleMgmtDAO.deleteSclassAllList", parameter);
    }
}
