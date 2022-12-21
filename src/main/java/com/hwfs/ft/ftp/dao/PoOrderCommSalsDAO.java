package com.hwfs.ft.ftp.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 수수료 매출 관리하는 PoOrderCommSals DAO
 *
 * @ClassName PoOrderCommSalsDAO.java
 * @Description PoOrderCommSalsDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.10   	kjj        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 kjj
 * @since 2015.06.10
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ft/ftp/poOrderCommSalsDAO")
public class PoOrderCommSalsDAO extends DefaultDAO {

    /**
     * 수수료 매출 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.ftp.poOrderCommSalsDAO.selectList", mapParam);
    }

    /**
     * 수수료 매출 관리(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insert(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.poOrderCommSalsDAO.insert", mapParam);
    }

    /**
     * 수수료 매출 관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int update(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.poOrderCommSalsDAO.update", mapParam);
    }

    /**
     * 수수료 매출 관리 상태(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateStatus(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.poOrderCommSalsDAO.updateStatus", mapParam);
    }

    /**
     * 수수료 매출 관리(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int delete(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.poOrderCommSalsDAO.delete", mapParam);
    }

}
