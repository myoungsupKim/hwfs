package com.hwfs.fs.fse.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 이벤트 결과등록 관리하는 EventResultRegMgnt DAO
 *
 * @ClassName EventResultRegMgntDAO.java
 * @Description EventResultRegMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.17      최종덕        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최종덕
 * @since 2015.04.17
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fse/eventResultRegMgntDAO")
public class EventResultRegMgntDAO extends DefaultDAO {

    /**
     * 이벤트 분류 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectCboList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("fs.fse.eventResultRegMgntDAO.selectCboList", mapParam);
    }

    /**
     * 이벤트 테마 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectThemeList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("fs.fse.eventResultRegMgntDAO.selectThemeList", mapParam);
    }

    /**
     * 이벤트 결과등록 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("fs.fse.eventResultRegMgntDAO.selectList", parameter);
    }

    /**
     * 결과정보 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectResult(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("fs.fse.eventResultRegMgntDAO.selectResult", parameter);
    }

    /**
     * 이벤트 결과등록 관리(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insertForm(Map<String, Object> mapParam) throws Exception {
        return super.update("fs.fse.eventResultRegMgntDAO.insertForm", mapParam);
    }

    /**
     * 이벤트 결과등록 관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateForm(Map<String, Object> mapParam) throws Exception {
        return super.update("fs.fse.eventResultRegMgntDAO.updateForm", mapParam);
    }
}
