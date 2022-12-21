package com.hwfs.ls.lum.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 장비이력과 수리이력 관리 Dao Class
 *
 * @ClassName EquipMgmtDAO.java
 * @Description EquipMgmtDAO Class
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
@Repository("/ls/lum/equipMgmtDAO")
public class EquipMgmtDAO extends DefaultDAO {

    /**
     * 장비이력에 대하여 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectEquipLogList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lum.equipMgmtDAO.selectEquipLogList", parameter);
    }

    /**
     * 특정 장비이력에 맞는 수리이력을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectRparLogList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lum.equipMgmtDAO.selectRparLogList", parameter);
    }

    /**
     * 장비번호를 채번 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public String selectEquipNum(Map<String, Object> parameter) throws Exception {
        return (String) super.queryForObject("ls.lum.equipMgmtDAO.selectEquipNum", parameter, null);
    }

    /**
     * 장비이력을 생성한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertEquipLogList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lum.equipMgmtDAO.insertEquipLogList", parameter);
    }

    /**
     * 장비이력을 수정한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateEquipLogList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lum.equipMgmtDAO.updateEquipLogList", parameter);
    }

    /**
     * 수리이력을 생성한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertRparLogList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lum.equipMgmtDAO.insertRparLogList", parameter);
    }

    /**
     * 수리이력을 수정한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateRparLogList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lum.equipMgmtDAO.updateRparLogList", parameter);
    }

    /**
     * 장비이력을 삭제한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteEquipLogList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lum.equipMgmtDAO.deleteEquipLogList", parameter);
    }

    /**
     * 수리이력을 삭제한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteRparLogList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lum.equipMgmtDAO.deleteRparLogList", parameter);
    }

    /**
     * 수리이력을 전체를 삭제한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteRparLogListAll(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lum.equipMgmtDAO.deleteRparLogListAll", parameter);
    }

    /**
     * 장비이력 첨부파일 존재여부 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int selectEquipLogFileAppend(Map<String, Object> parameter) throws Exception {
        return super.queryForInt("ls.lum.equipMgmtDAO.selectEquipLogFileAppend", parameter);
    }

    /**
     * 장비이력 첨부파일을 생성 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertEquipLogFileAppend(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lum.equipMgmtDAO.insertEquipLogFileAppend", parameter);
    }

    /**
     * 장비이력 첨부파일을 수정 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateEquipLogFileAppend(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lum.equipMgmtDAO.updateEquipLogFileAppend", parameter);
    }

    /**
     * 장비이력 첨부파일을 삭제 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteEquipLogFileAppend(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lum.equipMgmtDAO.deleteEquipLogFileAppend", parameter);
    }

    /**
     * 첨부파일 참조 순번을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectEquipLogRefSeq(Map<String, Object> parameter) throws Exception {
        return super.queryForRecord("ls.lum.equipMgmtDAO.selectEquipLogRefSeq", parameter);
    }

}
