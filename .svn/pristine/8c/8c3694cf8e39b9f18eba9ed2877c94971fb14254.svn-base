package com.hwfs.ls.lcm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * ScArticleMgmtDAO에 대한 설명 작성
 *
 * @ClassName ScArticleMgmtDAO.java
 * @Description ScArticleMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 1. 28.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 1. 28.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ls/lcm/scArticleMgmtDAO")
public class ScArticleMgmtDAO extends DefaultDAO {

    /**
     * 공통그룹코드에 대하여 조회한다.
     *
     * @return
     * @throws Exception
     */
    public RecordSet selectGroupList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.scArticleMgmtDAO.selectGroupList", parameter);
    }

    /**
     * 특정 그룹코드에 맞는 공통코드를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectCodeList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.scArticleMgmtDAO.selectCodeList", parameter);
    }

    /**
     * 상세 코드 일괄 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectCodeDtlBatchList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.scArticleMgmtDAO.selectCodeDtlBatchList", parameter);
    }

    /**
     * 공통그룹코드를 생성한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertGroupList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.scArticleMgmtDAO.insertGroupList", parameter);
    }

    /**
     * 공통그룹코드를 수정한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateGroupList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.scArticleMgmtDAO.updateGroupList", parameter);
    }

    /**
     * 공통코드를 생성한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertCodeList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.scArticleMgmtDAO.insertCodeList", parameter);
    }

    /**
     * 공통코드를 수정한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateCodeList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.scArticleMgmtDAO.updateCodeList", parameter);
    }

    /**
     * 그룹코드의 사용상태가 [사용안함] 상태인 경우에는 전체 공통코드를 [사용안함] 상태로 변경한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateUseAllCode(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.scArticleMgmtDAO.updateUseAllCode", parameter);
    }
}
