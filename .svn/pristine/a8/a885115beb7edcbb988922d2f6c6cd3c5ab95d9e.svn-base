package com.hwfs.fs.fse.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 이벤트 진행정보 관리하는 EventProcessInfoMgnt DAO
 *
 * @ClassName EventProcessInfoMgntDAO.java
 * @Description EventProcessInfoMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.18      남기빈        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 남기빈
 * @since 2015.03.18
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fse/eventProcessInfoMgntDAO")
public class EventProcessInfoMgntDAO extends DefaultDAO {

    /**
     * 이벤트 분류 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectCboList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("fs.fse.eventProcessInfoMgntDAO.selectCboList", mapParam);
    }

    /**
     * 이벤트 테마 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectThemeList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("fs.fse.eventProcessInfoMgntDAO.selectThemeList", mapParam);
    }

    /**
     * 이벤트 진행정보 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectGrdList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("fs.fse.eventProcessInfoMgntDAO.selectGrdList", parameter);
    }

    /**
     * 이벤트 대분류 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectLclass(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("fs.fse.eventProcessInfoMgntDAO.selectLclass", parameter);
    }

    /**
     * 이벤트 중분류 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectMclass(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("fs.fse.eventProcessInfoMgntDAO.selectMclass", parameter);
    }

    /**
     * 이벤트 소분류 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectSclass(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("fs.fse.eventProcessInfoMgntDAO.selectSclass", parameter);
    }

    /**
     * 이벤트 Master 정보를 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectEventMst(Map<String, Object> parameter) {
        return queryForRecordSet("fs.fse.eventProcessInfoMgntDAO.selectEventMst", parameter);
    }

    /**
     * 이벤트 Master 진행정보를 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectMstProgress(Map<String, Object> parameter) {
        return queryForRecordSet("fs.fse.eventProcessInfoMgntDAO.selectMstProgress", parameter);
    }

    /**
     * 이벤트 신청 정보를 조회한다.
     *
     * @param parameter
     * @return
     */
    public RecordSet selectEventReq(Map<String, Object> parameter) {
        return super.queryForRecordSet("fs.fse.eventProcessInfoMgntDAO.selectEventReq", parameter);
    }

    /**
     * 사업장 기기 정보를 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectProgress(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("fs.fse.eventProcessInfoMgntDAO.selectProgress", parameter);
    }

    /**
     * 기기정보를 조회한다.
     *
     * @param parameter
     * @return
     */
    public RecordSet selectInforeg(Map<String, Object> parameter) {
        return super.queryForRecordSet("fs.fse.eventProcessInfoMgntDAO.selectInforeg", parameter);
    }

    /**
     * 사업장 기기 정보를 조회한다.
     *
     * @param parameter
     * @return
     */
    public RecordSet selectUpjangutensil(Map<String, Object> parameter) {
        return super.queryForRecordSet("fs.fse.eventProcessInfoMgntDAO.selectUpjangutensil", parameter);
    }

    /**
     * 기기/물류 재고수량을 조회한다.
     *
     * @param parameter
     * @return
     */
    public RecordSet selectInventoryQty(Map<String, Object> parameter) {
        return super.queryForRecordSet("fs.fse.eventProcessInfoMgntDAO.selectInventoryQty", parameter);
    }

    /**
     * 코드 정보를 조회한다.
     *
     * @param parameter
     * @return
     */
    public RecordSet selectInforegCode(Map<String, Object> parameter) {
        return super.queryForRecordSet("fs.fse.eventProcessInfoMgntDAO.selectInforegCode", parameter);
    }

    /**
     * 서버 사진을 조회한다.
     *
     * @param parameter
     * @return
     */
    public RecordSet selectImgList(Map<String, Object> parameter) {
        return super.queryForRecordSet("fs.fse.eventProcessInfoMgntDAO.selectImgList", parameter);
    }

    /**
     * 이벤트ID를 생성한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectEvntId(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("fs.fse.eventProcessInfoMgntDAO.selectEvntId", parameter);
    }

    /**
     * 이벤트 신청 등록관리(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insertForm(Map<String, Object> mapParam) throws Exception {
        return super.update("fs.fse.eventProcessInfoMgntDAO.insertForm", mapParam);
    }

    /**
     * 이벤트 진행관리(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insertPrcdr(Map<String, Object> mapParam) throws Exception {
        return super.update("fs.fse.eventProcessInfoMgntDAO.insertPrcdr", mapParam);
    }

    /**
     * 이벤트 기기정보(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insertInforeg(Map<String, Object> mapParam) throws Exception {
        return super.update("fs.fse.eventProcessInfoMgntDAO.insertInforeg", mapParam);
    }

    /**
     * 이벤트 사업장 기기정보(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insertUpjangutensil(Map<String, Object> mapParam) throws Exception {
        return super.update("fs.fse.eventProcessInfoMgntDAO.insertUpjangutensil", mapParam);
    }

    /**
     * 이벤트 신청 등록관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateForm(Map<String, Object> mapParam) throws Exception {
        return super.update("fs.fse.eventProcessInfoMgntDAO.updateForm", mapParam);
    }

    /**
     * 이벤트 진행정보(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updatePrcdr(Map<String, Object> mapParam) throws Exception {
        return super.update("fs.fse.eventProcessInfoMgntDAO.updatePrcdr", mapParam);
    }

    /**
     * 이벤트 기기정보(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateInforeg(Map<String, Object> mapParam) throws Exception {
        return super.update("fs.fse.eventProcessInfoMgntDAO.updateInforeg", mapParam);
    }

    /**
     * 이벤트 사업장 기기정보(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateUpjangutensil(Map<String, Object> mapParam) throws Exception {
        return super.update("fs.fse.eventProcessInfoMgntDAO.updateUpjangutensil", mapParam);
    }

    /**
     * 이벤트 신청정보(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int deleteForm(Map<String, Object> mapParam) throws Exception {
        return super.update("fs.fse.eventProcessInfoMgntDAO.deleteForm", mapParam);
    }

    /**
     * 이벤트 진행정보(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int deletePrcdr(Map<String, Object> mapParam) throws Exception {
        return super.update("fs.fse.eventProcessInfoMgntDAO.deletePrcdr", mapParam);
    }

    /**
     * 이벤트 기기정보(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int deleteInforeg(Map<String, Object> mapParam) throws Exception {
        return super.update("fs.fse.eventProcessInfoMgntDAO.deleteInforeg", mapParam);
    }

    /**
     * 이벤트 업장 기기정보(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int deleteUpjangutensil(Map<String, Object> mapParam) throws Exception {
        return super.update("fs.fse.eventProcessInfoMgntDAO.deleteUpjangutensil", mapParam);
    }
}
