package com.hwfs.ls.lum.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 폐수배출 관리 Dao Class
 *
 * @ClassName DrngMgmtDAO.java
 * @Description DrngMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 29.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 4. 29.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ls/lum/drngMgmtDAO")
public class DrngMgmtDAO extends DefaultDAO {

    /**
     * 폐수배출에 대하여 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lum.drngMgmtDAO.selectList", parameter);
    }

    /**
     * 폐수배출을 생성한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertDrngList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lum.drngMgmtDAO.insertDrngList", parameter);
    }

    /**
     * 폐수배출을 수정한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateDrngList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lum.drngMgmtDAO.updateDrngList", parameter);
    }

    /**
     * 폐수배출을 삭제한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteDrngList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lum.drngMgmtDAO.deleteDrngList", parameter);
    }

}
