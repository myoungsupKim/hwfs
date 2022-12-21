package com.hwfs.ls.lcm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 양식서 관리 Dao Class
 *
 * @ClassName FormMgmtDAO.java
 * @Description FormMgmtDAO Class
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
@Repository("/ls/lcm/formMgmtDAO")
public class FormMgmtDAO extends DefaultDAO {

    /**
     * 양식서에 대하여 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectFormList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.formMgmtDAO.selectFormList", parameter);
    }

    /**
     * 양식서에 대하여 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectForm(Map<String, Object> parameter) throws Exception {
        return (Map<String, Object>) super.queryForRecord("ls.lcm.formMgmtDAO.selectForm", parameter);
    }

    /**
     * 양식서번호를 채번 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public String selectFormId(Map<String, Object> parameter) throws Exception {
        return (String) super.queryForObject("ls.lcm.formMgmtDAO.selectFormId", parameter, null);
    }

    /**
     * 양식서을 생성한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertFormList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.formMgmtDAO.insertFormList", parameter);
    }

    /**
     * 양식서을 수정한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateFormList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.formMgmtDAO.updateFormList", parameter);
    }

    /**
     * 양식서을 삭제한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteFormList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.formMgmtDAO.deleteFormList", parameter);
    }

    /**
     * 첨부파일 삭제
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int saveFormAttachFileDelete(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.formMgmtDAO.saveFormAttachFileDelete", parameter);
    }

}
