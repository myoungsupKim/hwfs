package com.hwfs.fs.fse.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 이벤트 등록 관리자 승인하는 EventProcessApprvMgnt DAO
 *
 * @ClassName EventProcessApprvMgntDAO.java
 * @Description EventProcessApprvMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.14      최종덕        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최종덕
 * @since 2015.04.14
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fse/eventProcessApprvMgntDAO")
public class EventProcessApprvMgntDAO extends DefaultDAO {

    /**
     * 이벤트 분류 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectCboList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("fs.fse.eventProcessApprvMgntDAO.selectCboList", mapParam);
    }

    /**
     * 이벤트 테마 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectThemeList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("fs.fse.eventProcessApprvMgntDAO.selectThemeList", mapParam);
    }

    /**
     * 이벤트 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("fs.fse.eventProcessApprvMgntDAO.selectList", parameter);
    }

    /**
     * 이벤트 Master 정보를 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectEventMst(Map<String, Object> parameter) {
        return queryForRecordSet("fs.fse.eventProcessApprvMgntDAO.selectEventMst", parameter);
    }

    /**
     * 이벤트 Master 진행정보를 조회한다.(Master 진행절차)
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectMstProgress(Map<String, Object> parameter) {
        return queryForRecordSet("fs.fse.eventProcessApprvMgntDAO.selectMstProgress", parameter);
    }
    
    /**
     * 기기/포장제 정보을 조회한다.(Master 기기/포장제)
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectMstUtensil(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("fs.fse.eventProcessApprvMgntDAO.selectMstUtensil", parameter);
    }
    
    /**
     * 서버 사진을 조회한다. (Master 첨부파일)
     *
     * @param parameter
     * @return
     */
    public RecordSet selectImgList(Map<String, Object> parameter) {
        return super.queryForRecordSet("fs.fse.eventProcessApprvMgntDAO.selectImgList", parameter);
    }    
    
    
    /**
     * 이벤트 신청 정보를 조회한다.
     *
     * @param parameter
     * @return
     */
    public RecordSet selectEventReq(Map<String, Object> parameter) {
        return super.queryForRecordSet("fs.fse.eventProcessApprvMgntDAO.selectEventReq", parameter);
    }

    /**
     * 진행절차 정보를 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectProgress(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("fs.fse.eventProcessApprvMgntDAO.selectProgress", parameter);
    }

    /**
     * 기기정보를 조회한다.
     *
     * @param parameter
     * @return
     */
    public RecordSet selectInforeg(Map<String, Object> parameter) {
        return super.queryForRecordSet("fs.fse.eventProcessApprvMgntDAO.selectInforeg", parameter);
    }

    /**
     * 사업장 기기 정보를 조회한다.
     *
     * @param parameter
     * @return
     */
    public RecordSet selectUpjangutensil(Map<String, Object> parameter) {
        return super.queryForRecordSet("fs.fse.eventProcessApprvMgntDAO.selectUpjangutensil", parameter);
    }

    
    /**
     * 이벤트 master 정보(을)를 승인한다.
     *
     * @param mapParam
     * @return
     */
    public int updateMst(Map<String, Object> mapParam) throws Exception {
        return super.update("fs.fse.eventProcessApprvMgntDAO.updateMst", mapParam);
    }

    /**
     * 이벤트 신청정보(을)를 승인한다.
     *
     * @param mapParam
     * @return
     */
    public int updateReq(Map<String, Object> mapParam) throws Exception {
        return super.update("fs.fse.eventProcessApprvMgntDAO.updateReq", mapParam);
    }
}
